import encoding from 'k6/encoding';
import http from 'k6/http';
import { check } from 'k6';
import { sleep } from 'k6';

const username = 'admin';
const password = '';
const url = "https://xnat.pprod.md.campusbiotech.ch"
// const password = 'admin';
// const url = "https://localhost:8080"

export const options = {

  stages: [

    { duration: '1s', target: 1 },
    // { duration: '5m', target: 10 },
    // { duration: '2m', target: 25 },
    // { duration: '2', target: 50 },
    // { duration: '2m', target: 25 },
    // { duration: '5m', target: 10 },
    // { duration: '5m', target: 5 },
  ],
};

export default function () {

  const encodedCredentials = encoding.b64encode(`${username}:${password}`);
  const projects = `${url}/data/projects`;

  const params = {
    headers: {
      "Authorization": `Basic ${encodedCredentials}`,
      "Content-Type": "application/json"
    },
    redirect: 3
  }

  let resLogin = http.get(projects, params);
  // console.log(JSON.parse(resLogin.body))
  check(resLogin, {
    "Login: HTTP code was 200": (res) => res.status == 200,
  });

  const params2 = {
    headers: {
      "Authorization": `Basic ${encodedCredentials}`,
      "Content-Type": "application/json",
      "responseType": 'binary'
    },
    redirect: 3
  }

  const download = `${url}/data/projects/test/resources/2/files/s3curl.pl`
  let resDownload = http.get(download, params2)

  check(resDownload, {
    "Download: HTTP code was 200": (res) => res.status == 200,
  });
}
