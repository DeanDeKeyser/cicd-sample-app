node {
    stage('Preparation') {
        catchError(buildResult: 'SUCCESS') {
            sh 'docker stop samplerunning'
            sh 'docker rm samplerunning'
        }
        sh 'rm -rf tempdir'
    }
    stage('Build') {
        sh 'bash ./sample-app.sh'
    }
    stage('Test') {
        sh 'curl -s http://172.17.0.3:5050/ | grep "You are calling me from 172.17.0.2"'
    }
}
