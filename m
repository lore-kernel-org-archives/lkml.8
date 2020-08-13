Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B96CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 09:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FCB920781
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 09:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sVAPWrVK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgHMJXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 05:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgHMJXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 05:23:10 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F35C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 02:23:09 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 9so4074289wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 02:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2K6+RoeuBQlm0IsRzXt1NhKSqZfuKNPs2u/9rtksF/A=;
        b=sVAPWrVKkD5jUs4jNOuBnPy7I+D9RG7yw538F2is62Y0u2yYthN6Ek/slCIdbuaRnC
         kf32QNRx3dYQ5QgN2hlbjOtA8Hh+AwFCiSEeCTZ+mhMS4CJPA+V3cFYWyJ7D/5yqJ+eh
         hFgIj0OyRglhZcEpSk8NPsxFA+m4W0RnjEEiR8/DRRCKmvO6xXLF5KWr4zce9fLQNGJI
         o9grRXHt8ukscKQypc1qMN4PEGxVhmpzujmfclXKOjGzsv2qKvO8hBKxAlVoxyXGzdOo
         8p0E4aL6vee+S1ZCXX9FOrYoFxE7eSzWPM2NDpP4/emqLDP2UidnJvSWTcxAiU64k/mK
         xm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2K6+RoeuBQlm0IsRzXt1NhKSqZfuKNPs2u/9rtksF/A=;
        b=QscoHTLhKf4+L5lsg9H/dXjoSTOuYwBjVVstpGZ79TDr2J8w2h3RCc8Niu0k3M07Ff
         A3pshOSj83fuAzHRBazd1KCEkRzEn+3wBonNmsYXFffM5EZefOyPgt5g475R2iBN+ONG
         U6QP/1S/O231UZ1qeb77HrZcEeEZZESAUh0uViWH9Ua2nHGisg16kMUnYRU9AUrUe7PB
         EOf5lKSLoU2gZOVPyGXPOpGR/Vx6Mn/6+t8v+tvca58PUnvVWXsiL8VpiJQykJ/jDfCt
         G1U8+XSxADIAxNvStHS6Vp3g0P5OYfooRcFyq4sUavqhmzwAIpx62wAJRbVG5eSNLxLe
         xtAg==
X-Gm-Message-State: AOAM531F9PNuGTVjPH1pejcwy1KeZyKmD4eu0ZkM/O9ND3jvi/Wc2gaD
        CU8mVvfIyZAXUQiF/4SHdKHDU4tbcLfSkST61XztnMvDD0M=
X-Google-Smtp-Source: ABdhPJySjPEnTjiiOk6CHlsZcfXBEyturRz6SwmXdk6870FMGQ6lvM5XG1n1kXgbmKFxgDkSLgEdBJNpgtRgHKFH1HE=
X-Received: by 2002:a7b:cc8e:: with SMTP id p14mr3406688wma.111.1597310588444;
 Thu, 13 Aug 2020 02:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <202008120718.VxKCVIJX%lkp@intel.com>
In-Reply-To: <202008120718.VxKCVIJX%lkp@intel.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Thu, 13 Aug 2020 17:35:23 +0800
Message-ID: <CADvbK_fycBSAL5Xz1XjGNmEfQ6499n+4Wr01GTn-vNi0Fuj2FQ@mail.gmail.com>
Subject: Re: net/tipc/udp_media.c:743: undefined reference to `ipv6_dev_find'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 7:21 AM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   c636eef2ee3696f261a35f34989842701a107895
> commit: 5a6f6f579178dbeb33002d93b4f646c31348fac9 tipc: set ub->ifindex for local ipv6 address
> date:   6 days ago
> config: ia64-randconfig-r005-20200811 (attached as .config)
> compiler: ia64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 5a6f6f579178dbeb33002d93b4f646c31348fac9
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=ia64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    ia64-linux-ld: net/tipc/udp_media.o: in function `tipc_udp_enable':
> >> net/tipc/udp_media.c:743: undefined reference to `ipv6_dev_find'
To use some APIs exported from ipv6 code.
We need add this:

--- a/net/tipc/Kconfig
+++ b/net/tipc/Kconfig
@@ -6,6 +6,7 @@
 menuconfig TIPC
        tristate "The TIPC Protocol"
        depends on INET
+       depends on IPV6 || IPV6=n

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
