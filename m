Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D959FC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 16:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE433206C0
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 16:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjHiSMSv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbgHPQSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 12:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgHPQSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 12:18:35 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181B9C061786
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 09:18:35 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k8so12016515wma.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 09:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dj0CMpb/VuCpo0vqdwQc0WQ/EtmdfBax0LIT37nNFTk=;
        b=MjHiSMSv0drb6w5wzL3wucqetoEgFG9na1/yLOEe/0U+43qww55Y/kGnmiDJFjl6L3
         rJzRC2jASGASZqvktFvcbsDo960vcrX9xPosBEeDsbB36KGArtxgSMPVdlYrwBmqPHXv
         foA9C7DURVfj05zVHfY6PGDgWfBgjDIw3zu5b4YybJoHFSUcG3JpU6sSIH+a+TTd4IVc
         d9u39vy4DB4GsR2qJ3+fck312hd2j2B92SNmbbcAbl06q5vS7jeVM/hUxeiVFB+0HGmR
         FdFW06QPcXjIt5HXELIrEBG6UeBxrI3L9dUfEIfJG5AQ8pssQhS0nONpmkXQyjnRtqVJ
         Rpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dj0CMpb/VuCpo0vqdwQc0WQ/EtmdfBax0LIT37nNFTk=;
        b=fX2OkSx8vzxxgig5aUkQHIU2ry1FG+0w3IbnKV8T17v2L8ejSCEmYypEdWmvN9hDw1
         5kOgjvH2sYF4+GUAYDZf+Lw8bcWsidP8H0NzYCkoqaemsgtU1rQTxoxqbq3CmDLVfEfl
         YZ5UFhn5eD3OgjFKlWxCwX+Prd9l5Ak+A/DPVmdqjYozbqr2W6FfS2NFRq7ZudG0wmPN
         RZ0fyZojzhCFNrEOfOG90/MEveHZE0aR8vEJhV7E0hwdJ1C1YBvgmnsUmWabtVm1srAM
         vidQbef4NYQsetgd9sC/7CMIRPPhAXN3PwG2YgNG8sgVSiaMWbfXNoI6xwD2stqfHG9w
         b9pg==
X-Gm-Message-State: AOAM531hLQsLpxFcaEcRaHqCYNtQEltumXW9VnbsbUrUL6u9Picrs0De
        NgxMCy3grLux568LqQJIEYSmPI/RZLUwlyh2RwY=
X-Google-Smtp-Source: ABdhPJzDg9aQRn2auGRxriAaS4h41nA3Q6rJ36pJrZXcY6kH5EXGHIKSBYwI0/wTIxvK9/e7oXLE4EDJV4heloeMsHo=
X-Received: by 2002:a1c:3dc3:: with SMTP id k186mr11053163wma.122.1597594713784;
 Sun, 16 Aug 2020 09:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <202008161656.tNX2RwHZ%lkp@intel.com>
In-Reply-To: <202008161656.tNX2RwHZ%lkp@intel.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Mon, 17 Aug 2020 00:31:00 +0800
Message-ID: <CADvbK_fsACs6uzT+iVEG6DdunJvKwgj3aD5Tknz2kO+0pq3C8g@mail.gmail.com>
Subject: Re: net/tipc/udp_media.c:743: undefined reference to `ipv6_dev_find'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 16, 2020 at 4:32 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Xin,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   4b6c093e21d36bede0fd88fd0aeb3b03647260e4
> commit: 5a6f6f579178dbeb33002d93b4f646c31348fac9 tipc: set ub->ifindex for local ipv6 address
> date:   11 days ago
> config: parisc-randconfig-r032-20200816 (attached as .config)
> compiler: hppa-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 5a6f6f579178dbeb33002d93b4f646c31348fac9
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=parisc
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    hppa-linux-ld: net/tipc/udp_media.o: in function `tipc_udp_enable':
> >> net/tipc/udp_media.c:743: undefined reference to `ipv6_dev_find'
>
> vim +743 net/tipc/udp_media.c
>
>    642
>    643  /**
>    644   * tipc_udp_enable - callback to create a new udp bearer instance
>    645   * @net:        network namespace
>    646   * @b:          pointer to generic tipc_bearer
>    647   * @attrs:      netlink bearer configuration
>    648   *
>    649   * validate the bearer parameters and initialize the udp bearer
>    650   * rtnl_lock should be held
>    651   */
>    652  static int tipc_udp_enable(struct net *net, struct tipc_bearer *b,
>    653                             struct nlattr *attrs[])
>    654  {
>    655          int err = -EINVAL;
>    656          struct udp_bearer *ub;
>    657          struct udp_media_addr remote = {0};
>    658          struct udp_media_addr local = {0};
>    659          struct udp_port_cfg udp_conf = {0};
>    660          struct udp_tunnel_sock_cfg tuncfg = {NULL};
>    661          struct nlattr *opts[TIPC_NLA_UDP_MAX + 1];
>    662          u8 node_id[NODE_ID_LEN] = {0,};
>    663          int rmcast = 0;
>    664
>    665          ub = kzalloc(sizeof(*ub), GFP_ATOMIC);
>    666          if (!ub)
>    667                  return -ENOMEM;
>    668
>    669          INIT_LIST_HEAD(&ub->rcast.list);
>    670
>    671          if (!attrs[TIPC_NLA_BEARER_UDP_OPTS])
>    672                  goto err;
>    673
>    674          if (nla_parse_nested_deprecated(opts, TIPC_NLA_UDP_MAX, attrs[TIPC_NLA_BEARER_UDP_OPTS], tipc_nl_udp_policy, NULL))
>    675                  goto err;
>    676
>    677          if (!opts[TIPC_NLA_UDP_LOCAL] || !opts[TIPC_NLA_UDP_REMOTE]) {
>    678                  pr_err("Invalid UDP bearer configuration");
>    679                  err = -EINVAL;
>    680                  goto err;
>    681          }
>    682
>    683          err = tipc_parse_udp_addr(opts[TIPC_NLA_UDP_LOCAL], &local,
>    684                                    &ub->ifindex);
>    685          if (err)
>    686                  goto err;
>    687
>    688          err = tipc_parse_udp_addr(opts[TIPC_NLA_UDP_REMOTE], &remote, NULL);
>    689          if (err)
>    690                  goto err;
>    691
>    692          if (remote.proto != local.proto) {
>    693                  err = -EINVAL;
>    694                  goto err;
>    695          }
>    696
>    697          /* Checking remote ip address */
>    698          rmcast = tipc_udp_is_mcast_addr(&remote);
>    699
>    700          /* Autoconfigure own node identity if needed */
>    701          if (!tipc_own_id(net)) {
>    702                  memcpy(node_id, local.ipv6.in6_u.u6_addr8, 16);
>    703                  tipc_net_init(net, node_id, 0);
>    704          }
>    705          if (!tipc_own_id(net)) {
>    706                  pr_warn("Failed to set node id, please configure manually\n");
>    707                  err = -EINVAL;
>    708                  goto err;
>    709          }
>    710
>    711          b->bcast_addr.media_id = TIPC_MEDIA_TYPE_UDP;
>    712          b->bcast_addr.broadcast = TIPC_BROADCAST_SUPPORT;
>    713          rcu_assign_pointer(b->media_ptr, ub);
>    714          rcu_assign_pointer(ub->bearer, b);
>    715          tipc_udp_media_addr_set(&b->addr, &local);
>    716          if (local.proto == htons(ETH_P_IP)) {
>    717                  struct net_device *dev;
>    718
>    719                  dev = __ip_dev_find(net, local.ipv4.s_addr, false);
>    720                  if (!dev) {
>    721                          err = -ENODEV;
>    722                          goto err;
>    723                  }
>    724                  udp_conf.family = AF_INET;
>    725
>    726                  /* Switch to use ANY to receive packets from group */
>    727                  if (rmcast)
>    728                          udp_conf.local_ip.s_addr = htonl(INADDR_ANY);
>    729                  else
>    730                          udp_conf.local_ip.s_addr = local.ipv4.s_addr;
>    731                  udp_conf.use_udp_checksums = false;
>    732                  ub->ifindex = dev->ifindex;
>    733                  if (tipc_mtu_bad(dev, sizeof(struct iphdr) +
>    734                                        sizeof(struct udphdr))) {
>    735                          err = -EINVAL;
>    736                          goto err;
>    737                  }
>    738                  b->mtu = b->media->mtu;
>    739  #if IS_ENABLED(CONFIG_IPV6)
>    740          } else if (local.proto == htons(ETH_P_IPV6)) {
>    741                  struct net_device *dev;
>    742
>  > 743                  dev = ipv6_dev_find(net, &local.ipv6);
>    744                  if (!dev) {
>    745                          err = -ENODEV;
>    746                          goto err;
>    747                  }
>    748                  udp_conf.family = AF_INET6;
>    749                  udp_conf.use_udp6_tx_checksums = true;
>    750                  udp_conf.use_udp6_rx_checksums = true;
>    751                  if (rmcast)
>    752                          udp_conf.local_ip6 = in6addr_any;
>    753                  else
>    754                          udp_conf.local_ip6 = local.ipv6;
>    755                  ub->ifindex = dev->ifindex;
>    756                  b->mtu = 1280;
>    757  #endif
>    758          } else {
>    759                  err = -EAFNOSUPPORT;
>    760                  goto err;
>    761          }
>    762          udp_conf.local_udp_port = local.port;
>    763          err = udp_sock_create(net, &udp_conf, &ub->ubsock);
>    764          if (err)
>    765                  goto err;
>    766          tuncfg.sk_user_data = ub;
>    767          tuncfg.encap_type = 1;
>    768          tuncfg.encap_rcv = tipc_udp_recv;
>    769          tuncfg.encap_destroy = NULL;
>    770          setup_udp_tunnel_sock(net, ub->ubsock, &tuncfg);
>    771
>    772          err = dst_cache_init(&ub->rcast.dst_cache, GFP_ATOMIC);
>    773          if (err)
>    774                  goto free;
>    775
>    776          /**
>    777           * The bcast media address port is used for all peers and the ip
>    778           * is used if it's a multicast address.
>    779           */
>    780          memcpy(&b->bcast_addr.value, &remote, sizeof(remote));
>    781          if (rmcast)
>    782                  err = enable_mcast(ub, &remote);
>    783          else
>    784                  err = tipc_udp_rcast_add(b, &remote);
>    785          if (err)
>    786                  goto free;
>    787
>    788          return 0;
>    789
>    790  free:
>    791          dst_cache_destroy(&ub->rcast.dst_cache);
>    792          udp_tunnel_sock_release(ub->ubsock);
>    793  err:
>    794          kfree(ub);
>    795          return err;
>    796  }
>    797
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
The patch has been posted:
  [PATCH net] tipc: not enable tipc when ipv6 works as a module
