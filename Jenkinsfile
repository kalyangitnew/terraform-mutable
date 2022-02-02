pipeline {
  agent { label 'WORKSTATION'}
  environment {
    ENV = "dev"
    ACTION = "apply"
    SSH = credentials('CENTOS_SSH')
  }
  parameters {
      choice(name: 'ENV', choices: ['dev', 'prod'], description: 'Choose Environment')
      string(name: 'ACTION', defaultValue: 'apply', description: 'Give an action to do on terraform')
  }
  options {
      ansiColor('xterm')
      disableConcurrentBuilds()
  }
  stages {
    stage ('vpc') {
        steps {
            sh 'echo ${SSH} >/tmp/out'
            sh '''
                cd vpc
                make ${ENV}-${ACTION}
            '''
        }
    }
    stage ('db') {
        steps {
            sh '''
                cd db
                make ${ENV}-${ACTION}
            '''
        }
    }
    stage ('alb') {
        steps {
            sh '''
                cd alb
                make ${ENV}-${ACTION}
            '''
        }
    }
  }
}
