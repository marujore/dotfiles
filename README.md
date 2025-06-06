# 🎨 Dotfiles & Configurações

Minhas configurações pessoais para sistemas Linux.  

---

## Keyboard
Settings -> Keyboard -> + Add Input Sources -> English (US, intl., with dead keys)


## 🎮 **Steam**  
*Instalar pelo App Center*  

### Configurações Recomendadas:
1. **Remover anúncios**:  
   `Steam -> Settings -> Interface`  
   ✅ Desmarque:  
   - _"Notify me about additions or changes to my games, new releases, and upcoming releases"_  

2. **Compatibilidade**:  
   `Steam -> Settings -> Compatibility`  
   ✅ Ative:  
   - _"Enable Steam Play for all other titles"_  

---

## 🎬 **DaVinci Resolve**  
1. Acesse o site oficial:  
   🔗 [https://www.blackmagicdesign.com/products/davinciresolve](https://www.blackmagicdesign.com/products/davinciresolve)  
2. Baixe a versão Linux  
3. Extraia o arquivo:  
   ```bash
   unzip DaVinci_Resolve*.zip

   chmod +x DaVinci_Resolve_20.0_Linux.run
   sudo ./DaVinci_Resolve_20.0_Linux.run -i
   sudo SKIP_PACKAGE_CHECK=1 ./DaVinci_Resolve_20.0_Linux.run -i
   sudo mkdir /opt/resolve/libs/unneeded
   sudo mv /opt/resolve/libs/libgio* /opt/resolve/libs/unneeded/
sudo mv /opt/resolve/libs/libglib* /opt/resolve/libs/unneeded/
sudo mv /opt/resolve/libs/libgmodule* /opt/resolve/libs/unneeded/