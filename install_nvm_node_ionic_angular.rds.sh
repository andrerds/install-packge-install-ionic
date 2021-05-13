#!/bin/bash
set +e
echo " ---------------------------------------------  VERSAO 1.0.0   ---------------"
DEV=("André Rds")

NOMEDOSHELL=$0
#
BASH_DEFAULT

function checkNvmNode() {

  if [ "$NVM_STATUS" != "0" ]; then
    echo "NVM não encontrado instalar ( s | n )"
    installNvmFuncitons
    reloadBash
  fi
  if [ "$NODE_STATUS" != "0" ]; then
    echo "NODE não encontrado ....."
    selcionandoVersaoNodeInstall
    reloadBash
  fi
}

function selcionandoVersaoNodeInstall() {
  echo "Vamos listar a verãoes disponivéis.... Aguarde..."
  . $HOME/.nvm/nvm.sh && nvm list-remote
  echo "Instale uma versão do node | Exemplo: v12.18.3"
  read selecionarNovaVersaoparaInstalar

  if [ $selecionarNovaVersaoparaInstalar ]; then
    echo "Estamos instalando a versão $selecionarNovaVersaoparaInstalar"
    echo "$HOME/.nvm/nvm.sh && nvm install "$selecionarNovaVersaoparaInstalar" --verbose"
    . $HOME/.nvm/nvm.sh && nvm install $selecionarNovaVersaoparaInstalar
    echo "Recarregando terminal..."
    reloadBash
    echo "Setando node padrão ::: " | . $HOME/.nvm/nvm.sh && nvm use default
    nodeVersion=$(node --version)
    echo "$nodeVersion -----//------"
  fi
}

function installNvmFuncitons() {
  resultNvmCheck=$(. $HOME/.nvm/nvm.sh && nvm -v)
  statusCheckNvm=$?
  if [ "$statusCheckNvm" != "0" ]; then
    echo "Verificando nvm e instalando..."
    echo "sim" | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh)"
    setNvmBash # Setando nvm bash
    reloadBash # Reload depois do set.
  else
    echo "Erro ao installar NVM"
    exit -1
  fi
}
# Set variable Nvm
function setNvmBash() {  
if -f "$HOME/.bashrc" 
then
    echo 'export NVM_DIR="$HOME/.nvm"' >> $HOME/.bashrc
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm' >> $HOME/.bashrc
    echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion' >> $HOME/.bashrc
  fi
if -f "$HOME/.zshrc" 
then
     echo 'export NVM_DIR="$HOME/.nvm"' >> $HOME/.zshrc
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm' >> $HOME/.zshrc
    echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion' >> $HOME/.zshrc
fi
if -f "$HOME/.bash_profile"  
then
    echo 'export NVM_DIR="$HOME/.nvm"' >> $HOME/.bash_profile
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm' >> $HOME/.bash_profile
    echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion' >> $HOME/.bash_profile

fi
}

function reloadBash() {
  if [ -f "$HOME/.zshrc" ]
  then
     source ~/.zshrc &&  source ~/.bashrc &&  source ~/.bashrc
     echo "OK... Encontrado... .zshrc"
   echo  $BASH_DEFAULT".zshrc"
  fi

 if [ -f "$HOME/.bash_profile" ] 
 then
    source ~/.bash_profile
    echo "OK... Encontrado... bash_profile"
    echo $BASH_DEFAULT".bash_profile"

  fi
  
  if  [ -f "$HOME/.bashrc" ] 
  then
      source ~/.bashrc
     echo "OK... Encontrado... bashrc"
     echo $BASH_DEFAULT".bashrc"
  fi
  return $BASH_DEFAULT
}

echo "------------- Verificando NVM & NODE ---------------"
installNode=0
installNvm=0
#
resultNvm=$(. $HOME/.nvm/nvm.sh && nvm -v)
NVM_STATUS=$? # Retorma valor se for 0 e oqui comando deu certo. Diferente disso taca o pau.
#
resultNode=$(node --version)
NODE_STATUS=$? # Retorma valor se for 0 e oqui comando deu certo. Diferente disso taca o pau.
# 
resultNpm=$(npm --version)
NPM_STATUS=$?
#
resulIonic=$(ionic --version)
IONIC_STATUS=$?
#
resulCordova=$(cordova --version)
CORDOVA_STATUS=$?
#
resulCordovaRes=$(cordova-res --version)
CORDOVA_RES_STATUS=$?
#
resultNativeRun=$(native-run --version)
NATIVE_RUN_STATUS=$?
#
resulAngular=$(ng --version)
ANGULAR_STATUS=$?
#
reloadBash
echo "NVM  :::==> : $NVM_STATUS"  # NVM
echo "NODE :::==> : $NODE_STATUS" # NODE
echo "NPM :::==> : $NPM_STATUS" # NPM
echo "IONIC :::==> : $IONIC_STATUS" # IONIC
echo "CORDOVA :::==> : $CORDOVA_STATUS" # IONIC
echo "CORDOVA-RES :::==> : $CORDOVA_RES_STATUS" # IONIC
echo "NATIVE-RUN :::==> : $NATIVE_RUN_STATUS" # IONIC
echo "ANGULAR :::==> : $ANGULAR_STATUS" # IONIC
#
reloadBash
#
function instalarIonic() {
  installIonic=0
  # echo "entrou na funcao$"
  if [[ "$NPM_STATUS" == "0" && "$IONIC_STATUS" != "0" ]]; then 
     echo "------------- Verificando IONIC ---------------"
    echo "Instlando ionic....."
    npm install @ionic/cli -g
    reloadBash
    installIonic=1
    echo $(ionic -v)
  fi
  if  [[ "$installIonic" == "0" &&  "$IONIC_STATUS" != "0" ]]; then 
    echo "Probemas ao instalação"
    else {
      echo "-------------------------- IONIC V($resulIonic) SUCCESS ----------------------"
    }
  fi
}

function instalarCordova() {
  
  installCordova=0
  # echo "entrou na funcao$"
  if [[ "$NPM_STATUS" == "0" && "$CORDOVA_STATUS" != "0" ]]; then 
     echo "------------- Verificando CORDOVA ---------------"
    echo "Instlando cordova....."
    npm install cordova -g
    reloadBash
    installCordova=1
    echo $(cordova -v)
  fi
  if  [[ "$installCordova" == "0" &&  "$CORDOVA_STATUS" != "0" ]]; then 
    echo "Probemas ao instalação"
    else {
      echo "-------------------------- CORDOVA V($resulCordova) SUCCESS ----------------------"
    }
  fi
}

function instalarCordovaRes() {
  installCordovaRes=0
  # echo "entrou na funcao$"
  if [[ "$NPM_STATUS" == "0" && "$CORDOVA_RES_STATUS" != "0" ]]; then 
     echo "------------- Verificando CORDOVA RES ---------------"
    echo "Instlando cordova-res....."
    npm install cordova-res -g
    reloadBash
    installCordovaRes=1
    echo $(cordova-res -v)
  fi
  if  [[ "$installCordovaRes" == "0" &&  "$CORDOVA_RES_STATUS" != "0" ]]; then 
    echo "Probemas ao instalação"
    else {
      echo "-------------------------- CORDOVA-RES V($resulCordovaRes) SUCCESS ----------------------"
    }
  fi
}

function instalarNativeRun() {
  installNativeRun=0
  # echo "entrou na funcao$"
  if [[ "$NPM_STATUS" == "0" && "$NATIVE_RUN_STATUS" != "0" ]]; then 
     echo "------------- Verificando NATIVE RUN ---------------"
    echo "Instlando native-run....."
    npm install native-run -g
    reloadBash
    installNativeRun=1
    echo $(ionic -v)
  fi
  if  [[ "$installNativeRun" == "0" &&  "$NATIVE_RUN_STATUS" != "0" ]]; then 
    echo "Probemas ao instalação"
    else {
      echo "-------------------------- NATIVE RUN V($resultNativeRun) SUCCESS ----------------------"
    }
  fi
}

function instalarAngular() {
  installAngular=0
  # echo "entrou na funcao$"
  if [[ "$NPM_STATUS" == "0" && "$ANGULAR_STATUS" != "0" ]]; then 
     echo "------------- Verificando Angular ---------------"
    echo "Instlando angular....."
    npm install @angular/cli -g --verbose
    reloadBash
    installAngular=1
    echo $( ng --version)
  fi
  if  [[ "$installAngular" == "0" &&  "$ANGULAR_STATUS" != "0" ]]; then 
    echo "Probemas ao instalação"
    else {
      echo "-------------------------- ANGULAR - SUCCESS ----------------------"
    }
  fi
}


if [[ "$NVM_STATUS" != "0" && "$NODE_STATUS" != "0" ]]; then
      echo "NVM:::: $NVM_STATUS ::: $NODE_STATUS"
        installNode=0
        installNvm=0     
      echo "Verificando NVM & NODE novamente..."
      checkNvmNode #funcao
      if [[ "$checkNode" == "0" ]]; then
        installNode=1
        installNvm=1
      fi

else
  installNode=1
  installNvm=1
fi
if [[ "$installNode" == "0" && "$installNvm" == "0" ]]; then
  echo "Ops! Não foi possível continuar instalando..."
  echo "-------------------------- NVM/NODE ERROR!  --------------------------"
  exit -1
else
  echo "Versão do NVM é $resultNvm  || Node *$resultNode* "
  echo "-------------------------- NVM/NODE SUCCESS ----------------------" ${!NOMEDOSHELL}
  echo $(instalarIonic)
  echo $(instalarCordova)
  echo $(instalarCordovaRes)
  echo $(instalarNativeRun)
  echo $(instalarAngular)
  echo "--------------------------  FECHE O TERMINAL E RODE source ~/."$BASH_DEFAULT"  ----------------------"
  echo "###### \ \~ END ~// ######"
  echo " Obrigado! Att: >> $DEV << "
fi