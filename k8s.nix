{config, lib, pkgs, ...}:
{
  boot.kernelModules = ["ip_vs" "ip_vs_rr" "ip_vs_wrr" "ip_vs_sh" "nf_conntrack_ipv4"];
  services.etcd = {
    name = "default";
    initialAdvertisePeerUrls = ["http://127.0.0.1:2380"];
    initialClusterToken = "etcd-cluster";
    listenClientUrls = ["http://127.0.0.1:2379"];
    listenPeerUrls = ["http://127.0.0.1:2380"];
    peerCertFile = "/etc/kubernetes/pki/etcd/etcd.pem";
    peerKeyFile = "/etc/kubernetes/pki/etcd/etcd-key.pem";
    peerTrustedCaFile = "/etc/kubernetes/pki/etcd/etcd-root-ca.pem";
    trustedCaFile = "/etc/kubernetes/pki/etcd/etcd-root-ca.pem";
    keyFile = "/etc/kubernetes/pki/etcd/etcd-key.pem";
    certFile = "/etc/kubernetes/pki/etcd/etcd.pem";
  };

  services.kubernetes = {
    roles = ["master" "node"];
    #addons.dashboard.enable = true;
    apiserver.port = 8080;
    apiserver.securePort = 8443;

    caFile = "/etc/kubernetes/pki/k8s/k8s-root-ca.pem";
    apiserver.extraOpts = "--anonymous-auth=false";
    apiserver.clientCaFile = "/etc/kubernetes/pki/k8s/k8s-root-ca.pem";
    apiserver.tlsCertFile = "/etc/kubernetes/pki/k8s/kubernetes.pem";
    apiserver.tlsKeyFile = "/etc/kubernetes/pki/k8s/kubernetes-key.pem";
    apiserver.serviceAccountKeyFile = "/etc/kubernetes/pki/k8s/k8s-root-ca-key.pem";
    apiserver.tokenAuthFile = "/etc/kubernetes/pki/k8s/token.csv";
    apiserver.kubeletClientCaFile = "/etc/kubernetes/pki/k8s/k8s-root-ca.pem";
    apiserver.kubeletClientCertFile = "/etc/kubernetes/pki/k8s/admin.pem";
    apiserver.kubeletClientKeyFile = "/etc/kubernetes/pki/k8s/admin-key.pem";
    apiserver.kubeletHttps = true;
    apiserver.authorizationMode = ["AlwaysAllow"];
    apiserver.serviceClusterIpRange = "198.14.0.0/24";
    clusterCidr = "192.168.0.0/16";
    #apiserver.disableAdmissionPlugins = ["NodeRestriction"];
    #apiserver.enableAdmissionPlugins = [ "NamespaceLifecycle" "LimitRanger" "ServiceAccount" "ResourceQuota" "DefaultStorageClass" "DefaultTolerationSeconds" ];

    kubeconfig.server = "https://127.0.0.1:8443";

    controllerManager.rootCaFile = "/etc/kubernetes/pki/k8s/k8s-root-ca.pem";
    controllerManager.serviceAccountKeyFile = "/etc/kubernetes/pki/k8s/k8s-root-ca-key.pem";
    controllerManager.kubeconfig.caFile = "/etc/kubernetes/pki/k8s/k8s-root-ca.pem";
    controllerManager.kubeconfig.certFile = "/etc/kubernetes/pki/k8s/kube-controller-manager.pem";
    controllerManager.kubeconfig.keyFile = "/etc/kubernetes/pki/k8s/kube-controller-manager-key.pem";
    controllerManager.kubeconfig.server = "https://127.0.0.1:8443";

    etcd.caFile = "/etc/kubernetes/pki/etcd/etcd-root-ca.pem";
    etcd.certFile = "/etc/kubernetes/pki/etcd/etcd.pem";
    etcd.keyFile = "/etc/kubernetes/pki/etcd/etcd-key.pem";
    etcd.servers = ["http://127.0.0.1:2379"];

    proxy.kubeconfig.caFile = "/etc/kubernetes/pki/k8s/k8s-root-ca.pem";
    proxy.kubeconfig.certFile = "/etc/kubernetes/pki/k8s/kube-proxy.pem";
    proxy.kubeconfig.keyFile = "/etc/kubernetes/pki/k8s/kube-proxy-key.pem";
    proxy.kubeconfig.server = "https://127.0.0.1:8443";
    #proxy.featureGates = [ "SupportIPVSProxyMode" ];
    #proxy.extraOpts = "--proxy-mode=ipvs --ipvs-min-sync-period=5s --ipvs-sync-period=5s --masquerade-all";    

    scheduler.kubeconfig.caFile = "/etc/kubernetes/pki/k8s/k8s-root-ca.pem";
    scheduler.kubeconfig.certFile = "/etc/kubernetes/pki/k8s/kube-scheduler.pem";
    scheduler.kubeconfig.keyFile = "/etc/kubernetes/pki/k8s/kube-scheduler-key.pem";
    scheduler.kubeconfig.server = "https://127.0.0.1:8443";

    kubelet.hostname = "apple";
    kubelet.enable = true;
    kubelet.nodeIp = "10.0.3.200";
    kubelet.applyManifests = true;
    kubelet.tlsCertFile = "/etc/kubernetes/pki/k8s/kubelet.pem";
    kubelet.tlsKeyFile = "/etc/kubernetes/pki/k8s/kubelet-key.pem";
    kubelet.kubeconfig.caFile = "/etc/kubernetes/pki/k8s/k8s-root-ca.pem";
    kubelet.kubeconfig.certFile = "/etc/kubernetes/pki/k8s/kubelet.pem";
    kubelet.kubeconfig.keyFile = "/etc/kubernetes/pki/k8s/kubelet-key.pem";
    kubelet.kubeconfig.server = "https://127.0.0.1:8443";

    };
}