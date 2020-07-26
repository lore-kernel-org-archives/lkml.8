Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21C3C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 07:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70E76205CB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 07:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgGZHFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 03:05:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:40734 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgGZHFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 03:05:02 -0400
IronPort-SDR: beYuhYB3W8jJ6U82+ZKCSb65/Wn0MSV0qV7xnj2hOtgVmNRM75pocsQWiA9BByNPe/EtaYPWom
 92jnxK44SsIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9693"; a="130429866"
X-IronPort-AV: E=Sophos;i="5.75,397,1589266800"; 
   d="gz'50?scan'50,208,50";a="130429866"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2020 00:04:10 -0700
IronPort-SDR: eQGwaTZXvDYEVGqRUHZyD8TFyGR4gHS7WmoMGkqyXlgYKgjPEta0AeWR7tMD3bgENJBbwgLxjF
 5VLMSi7Sg04Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,397,1589266800"; 
   d="gz'50?scan'50,208,50";a="319712880"
Received: from lkp-server01.sh.intel.com (HELO df0563f96c37) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 26 Jul 2020 00:04:08 -0700
Received: from kbuild by df0563f96c37 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jzahc-0001Jn-3Y; Sun, 26 Jul 2020 07:04:08 +0000
Date:   Sun, 26 Jul 2020 15:04:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: net/ipv6/ip6mr.c:1772:21: sparse: sparse: incorrect type in argument
 1 (different address spaces)
Message-ID: <202007261555.lblL7IwY%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   04300d66f0a06d572d9f2ad6768c38cabde22179
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   5 weeks ago
config: sh-randconfig-s031-20200726 (attached as .config)
compiler: sh4-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-93-g4c6cbe55-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sh 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   net/ipv6/ip6mr.c:1721:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   net/ipv6/ip6mr.c:1721:21: sparse:     expected int const *__gu_addr
   net/ipv6/ip6mr.c:1721:21: sparse:     got int [noderef] __user *
   net/ipv6/ip6mr.c:1721:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   net/ipv6/ip6mr.c:1721:21: sparse:     expected void const volatile [noderef] __user *
   net/ipv6/ip6mr.c:1721:21: sparse:     got int const *__gu_addr
   net/ipv6/ip6mr.c:1738:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   net/ipv6/ip6mr.c:1738:21: sparse:     expected int const *__gu_addr
   net/ipv6/ip6mr.c:1738:21: sparse:     got int [noderef] __user *
   net/ipv6/ip6mr.c:1738:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   net/ipv6/ip6mr.c:1738:21: sparse:     expected void const volatile [noderef] __user *
   net/ipv6/ip6mr.c:1738:21: sparse:     got int const *__gu_addr
   net/ipv6/ip6mr.c:1751:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   net/ipv6/ip6mr.c:1751:21: sparse:     expected int const *__gu_addr
   net/ipv6/ip6mr.c:1751:21: sparse:     got int [noderef] __user *
   net/ipv6/ip6mr.c:1751:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   net/ipv6/ip6mr.c:1751:21: sparse:     expected void const volatile [noderef] __user *
   net/ipv6/ip6mr.c:1751:21: sparse:     got int const *__gu_addr
   net/ipv6/ip6mr.c:1772:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   net/ipv6/ip6mr.c:1772:21: sparse:     expected unsigned int const *__gu_addr
   net/ipv6/ip6mr.c:1772:21: sparse:     got unsigned int [noderef] [usertype] __user *
>> net/ipv6/ip6mr.c:1772:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
   net/ipv6/ip6mr.c:1772:21: sparse:     expected void const volatile [noderef] __user *
   net/ipv6/ip6mr.c:1772:21: sparse:     got unsigned int const *__gu_addr
   net/ipv6/ip6mr.c:1836:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ipv6/ip6mr.c:1836:13: sparse:     expected int const *__gu_addr
   net/ipv6/ip6mr.c:1836:13: sparse:     got int [noderef] __user *optlen
   net/ipv6/ip6mr.c:1836:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   net/ipv6/ip6mr.c:1836:13: sparse:     expected void const volatile [noderef] __user *
   net/ipv6/ip6mr.c:1836:13: sparse:     got int const *__gu_addr
   net/ipv6/ip6mr.c:405:13: sparse: sparse: context imbalance in 'ip6mr_vif_seq_start' - different lock contexts for basic block
   net/ipv6/ip6mr.c: note: in included file (through include/linux/mroute6.h):
   include/linux/mroute_base.h:427:31: sparse: sparse: context imbalance in 'mr_mfc_seq_stop' - unexpected unlock
--
   net/netrom/af_netrom.c:309:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   net/netrom/af_netrom.c:309:13: sparse:     expected unsigned int const *__gu_addr
   net/netrom/af_netrom.c:309:13: sparse:     got unsigned int [noderef] __user *
>> net/netrom/af_netrom.c:309:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
>> net/netrom/af_netrom.c:309:13: sparse:     expected void const volatile [noderef] __user *
   net/netrom/af_netrom.c:309:13: sparse:     got unsigned int const *__gu_addr
   net/netrom/af_netrom.c:359:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/netrom/af_netrom.c:359:13: sparse:     expected int const *__gu_addr
   net/netrom/af_netrom.c:359:13: sparse:     got int [noderef] __user *optlen
>> net/netrom/af_netrom.c:359:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   net/netrom/af_netrom.c:359:13: sparse:     expected void const volatile [noderef] __user *
   net/netrom/af_netrom.c:359:13: sparse:     got int const *__gu_addr
--
   net/rose/af_rose.c:380:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   net/rose/af_rose.c:380:13: sparse:     expected int const *__gu_addr
   net/rose/af_rose.c:380:13: sparse:     got int [noderef] __user *
>> net/rose/af_rose.c:380:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
>> net/rose/af_rose.c:380:13: sparse:     expected void const volatile [noderef] __user *
   net/rose/af_rose.c:380:13: sparse:     got int const *__gu_addr
   net/rose/af_rose.c:438:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/rose/af_rose.c:438:13: sparse:     expected int const *__gu_addr
   net/rose/af_rose.c:438:13: sparse:     got int [noderef] __user *optlen
   net/rose/af_rose.c:438:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   net/rose/af_rose.c:438:13: sparse:     expected void const volatile [noderef] __user *
   net/rose/af_rose.c:438:13: sparse:     got int const *__gu_addr
--
   net/ax25/af_ax25.c:546:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   net/ax25/af_ax25.c:546:13: sparse:     expected unsigned int const *__gu_addr
   net/ax25/af_ax25.c:546:13: sparse:     got unsigned int [noderef] __user *
>> net/ax25/af_ax25.c:546:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
>> net/ax25/af_ax25.c:546:13: sparse:     expected void const volatile [noderef] __user *
   net/ax25/af_ax25.c:546:13: sparse:     got unsigned int const *__gu_addr
   net/ax25/af_ax25.c:695:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ax25/af_ax25.c:695:13: sparse:     expected int const *__gu_addr
   net/ax25/af_ax25.c:695:13: sparse:     got int [noderef] __user *optlen
>> net/ax25/af_ax25.c:695:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   net/ax25/af_ax25.c:695:13: sparse:     expected void const volatile [noderef] __user *
   net/ax25/af_ax25.c:695:13: sparse:     got int const *__gu_addr
   net/ax25/af_ax25.c:1736:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long const *__gu_addr @@     got long [noderef] __user * @@
   net/ax25/af_ax25.c:1736:21: sparse:     expected long const *__gu_addr
   net/ax25/af_ax25.c:1736:21: sparse:     got long [noderef] __user *
>> net/ax25/af_ax25.c:1736:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got long const *__gu_addr @@
   net/ax25/af_ax25.c:1736:21: sparse:     expected void const volatile [noderef] __user *
   net/ax25/af_ax25.c:1736:21: sparse:     got long const *__gu_addr
--
   drivers/watchdog/watchdog_dev.c:680:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user * @@
   drivers/watchdog/watchdog_dev.c:680:21: sparse:     expected char const *__gu_addr
   drivers/watchdog/watchdog_dev.c:680:21: sparse:     got char const [noderef] __user *
>> drivers/watchdog/watchdog_dev.c:680:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got char const *__gu_addr @@
>> drivers/watchdog/watchdog_dev.c:680:21: sparse:     expected void const volatile [noderef] __user *
   drivers/watchdog/watchdog_dev.c:680:21: sparse:     got char const *__gu_addr
   drivers/watchdog/watchdog_dev.c:746:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/watchdog/watchdog_dev.c:746:21: sparse:     expected int const *__gu_addr
   drivers/watchdog/watchdog_dev.c:746:21: sparse:     got int [noderef] __user *p
>> drivers/watchdog/watchdog_dev.c:746:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/watchdog/watchdog_dev.c:746:21: sparse:     expected void const volatile [noderef] __user *
   drivers/watchdog/watchdog_dev.c:746:21: sparse:     got int const *__gu_addr
   drivers/watchdog/watchdog_dev.c:766:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/watchdog/watchdog_dev.c:766:21: sparse:     expected int const *__gu_addr
   drivers/watchdog/watchdog_dev.c:766:21: sparse:     got int [noderef] __user *p
   drivers/watchdog/watchdog_dev.c:766:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/watchdog/watchdog_dev.c:766:21: sparse:     expected void const volatile [noderef] __user *
   drivers/watchdog/watchdog_dev.c:766:21: sparse:     got int const *__gu_addr
   drivers/watchdog/watchdog_dev.c:795:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/watchdog/watchdog_dev.c:795:21: sparse:     expected int const *__gu_addr
   drivers/watchdog/watchdog_dev.c:795:21: sparse:     got int [noderef] __user *p
   drivers/watchdog/watchdog_dev.c:795:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   drivers/watchdog/watchdog_dev.c:795:21: sparse:     expected void const volatile [noderef] __user *
   drivers/watchdog/watchdog_dev.c:795:21: sparse:     got int const *__gu_addr
--
   drivers/w1/slaves/w1_ds28e04.c:342:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char [noderef] __user *__pu_addr @@     got char *buf @@
   drivers/w1/slaves/w1_ds28e04.c:342:13: sparse:     expected char [noderef] __user *__pu_addr
   drivers/w1/slaves/w1_ds28e04.c:342:13: sparse:     got char *buf
>> drivers/w1/slaves/w1_ds28e04.c:356:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got char const *__gu_addr @@
   drivers/w1/slaves/w1_ds28e04.c:356:13: sparse:     expected void const volatile [noderef] __user *
   drivers/w1/slaves/w1_ds28e04.c:356:13: sparse:     got char const *__gu_addr
--
   drivers/fsi/fsi-scom.c:497:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/fsi/fsi-scom.c:497:13: sparse:     expected unsigned int const *__gu_addr
   drivers/fsi/fsi-scom.c:497:13: sparse:     got unsigned int [noderef] [usertype] __user *
>> drivers/fsi/fsi-scom.c:497:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int const *__gu_addr @@
>> drivers/fsi/fsi-scom.c:497:13: sparse:     expected void const volatile [noderef] __user *
   drivers/fsi/fsi-scom.c:497:13: sparse:     got unsigned int const *__gu_addr

vim +1772 net/ipv6/ip6mr.c

6bd521433942d8 Patrick McHardy     2010-05-11  1624  
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1625  /*
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1626   *	Socket options and virtual interface manipulation. The whole
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1627   *	virtual interface system is a complete heap, but unfortunately
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1628   *	that's how BSD mrouted happens to think. Maybe one day with a proper
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1629   *	MOSPF/PIM router set up we can clean this up.
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1630   */
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1631  
b7058842c940ad David S. Miller     2009-09-30  1632  int ip6_mroute_setsockopt(struct sock *sk, int optname, char __user *optval, unsigned int optlen)
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1633  {
660b26dc1a8aeb Nicolas Dichtel     2013-01-21  1634  	int ret, parent = 0;
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1635  	struct mif6ctl vif;
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1636  	struct mf6cctl mfc;
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1637  	mifi_t mifi;
8229efdaef1e79 Benjamin Thery      2008-12-10  1638  	struct net *net = sock_net(sk);
b70432f7319eb7 Yuval Mintz         2018-02-28  1639  	struct mr_table *mrt;
d1db275dd3f6e4 Patrick McHardy     2010-05-11  1640  
99253eb750fda6 Xin Long            2017-02-24  1641  	if (sk->sk_type != SOCK_RAW ||
99253eb750fda6 Xin Long            2017-02-24  1642  	    inet_sk(sk)->inet_num != IPPROTO_ICMPV6)
99253eb750fda6 Xin Long            2017-02-24  1643  		return -EOPNOTSUPP;
99253eb750fda6 Xin Long            2017-02-24  1644  
d1db275dd3f6e4 Patrick McHardy     2010-05-11  1645  	mrt = ip6mr_get_table(net, raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
63159f29be1df7 Ian Morris          2015-03-29  1646  	if (!mrt)
d1db275dd3f6e4 Patrick McHardy     2010-05-11  1647  		return -ENOENT;
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1648  
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1649  	if (optname != MRT6_INIT) {
b70432f7319eb7 Yuval Mintz         2018-02-28  1650  		if (sk != rcu_access_pointer(mrt->mroute_sk) &&
8571ab479a6e1e Yuval Mintz         2018-02-28  1651  		    !ns_capable(net->user_ns, CAP_NET_ADMIN))
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1652  			return -EACCES;
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1653  	}
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1654  
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1655  	switch (optname) {
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1656  	case MRT6_INIT:
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1657  		if (optlen < sizeof(int))
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1658  			return -EINVAL;
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1659  
6bd521433942d8 Patrick McHardy     2010-05-11  1660  		return ip6mr_sk_init(mrt, sk);
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1661  
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1662  	case MRT6_DONE:
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1663  		return ip6mr_sk_done(sk);
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1664  
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1665  	case MRT6_ADD_MIF:
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1666  		if (optlen < sizeof(vif))
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1667  			return -EINVAL;
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1668  		if (copy_from_user(&vif, optval, sizeof(vif)))
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1669  			return -EFAULT;
6ac7eb0868ccc9 Rami Rosen          2008-04-10  1670  		if (vif.mif6c_mifi >= MAXMIFS)
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1671  			return -ENFILE;
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1672  		rtnl_lock();
8571ab479a6e1e Yuval Mintz         2018-02-28  1673  		ret = mif6_add(net, mrt, &vif,
b70432f7319eb7 Yuval Mintz         2018-02-28  1674  			       sk == rtnl_dereference(mrt->mroute_sk));
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1675  		rtnl_unlock();
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1676  		return ret;
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1677  
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1678  	case MRT6_DEL_MIF:
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1679  		if (optlen < sizeof(mifi_t))
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1680  			return -EINVAL;
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1681  		if (copy_from_user(&mifi, optval, sizeof(mifi_t)))
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1682  			return -EFAULT;
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1683  		rtnl_lock();
723b929ca0f79c Nikolay Aleksandrov 2017-04-21  1684  		ret = mif6_delete(mrt, mifi, 0, NULL);
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1685  		rtnl_unlock();
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1686  		return ret;
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1687  
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1688  	/*
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1689  	 *	Manipulate the forwarding caches. These live
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1690  	 *	in a sort of kernel/user symbiosis.
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1691  	 */
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1692  	case MRT6_ADD_MFC:
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1693  	case MRT6_DEL_MFC:
660b26dc1a8aeb Nicolas Dichtel     2013-01-21  1694  		parent = -1;
a8eceea84a3a35 Joe Perches         2020-03-12  1695  		fallthrough;
660b26dc1a8aeb Nicolas Dichtel     2013-01-21  1696  	case MRT6_ADD_MFC_PROXY:
660b26dc1a8aeb Nicolas Dichtel     2013-01-21  1697  	case MRT6_DEL_MFC_PROXY:
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1698  		if (optlen < sizeof(mfc))
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1699  			return -EINVAL;
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1700  		if (copy_from_user(&mfc, optval, sizeof(mfc)))
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1701  			return -EFAULT;
660b26dc1a8aeb Nicolas Dichtel     2013-01-21  1702  		if (parent == 0)
660b26dc1a8aeb Nicolas Dichtel     2013-01-21  1703  			parent = mfc.mf6cc_parent;
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1704  		rtnl_lock();
660b26dc1a8aeb Nicolas Dichtel     2013-01-21  1705  		if (optname == MRT6_DEL_MFC || optname == MRT6_DEL_MFC_PROXY)
660b26dc1a8aeb Nicolas Dichtel     2013-01-21  1706  			ret = ip6mr_mfc_delete(mrt, &mfc, parent);
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1707  		else
660b26dc1a8aeb Nicolas Dichtel     2013-01-21  1708  			ret = ip6mr_mfc_add(net, mrt, &mfc,
8571ab479a6e1e Yuval Mintz         2018-02-28  1709  					    sk ==
b70432f7319eb7 Yuval Mintz         2018-02-28  1710  					    rtnl_dereference(mrt->mroute_sk),
8571ab479a6e1e Yuval Mintz         2018-02-28  1711  					    parent);
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1712  		rtnl_unlock();
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1713  		return ret;
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1714  
ca8d4794f669e7 Callum Sinclair     2019-02-18  1715  	case MRT6_FLUSH:
ca8d4794f669e7 Callum Sinclair     2019-02-18  1716  	{
ca8d4794f669e7 Callum Sinclair     2019-02-18  1717  		int flags;
ca8d4794f669e7 Callum Sinclair     2019-02-18  1718  
ca8d4794f669e7 Callum Sinclair     2019-02-18  1719  		if (optlen != sizeof(flags))
ca8d4794f669e7 Callum Sinclair     2019-02-18  1720  			return -EINVAL;
ca8d4794f669e7 Callum Sinclair     2019-02-18  1721  		if (get_user(flags, (int __user *)optval))
ca8d4794f669e7 Callum Sinclair     2019-02-18  1722  			return -EFAULT;
ca8d4794f669e7 Callum Sinclair     2019-02-18  1723  		rtnl_lock();
ca8d4794f669e7 Callum Sinclair     2019-02-18  1724  		mroute_clean_tables(mrt, flags);
ca8d4794f669e7 Callum Sinclair     2019-02-18  1725  		rtnl_unlock();
ca8d4794f669e7 Callum Sinclair     2019-02-18  1726  		return 0;
ca8d4794f669e7 Callum Sinclair     2019-02-18  1727  	}
ca8d4794f669e7 Callum Sinclair     2019-02-18  1728  
14fb64e1f449ef YOSHIFUJI Hideaki   2008-04-03  1729  	/*
14fb64e1f449ef YOSHIFUJI Hideaki   2008-04-03  1730  	 *	Control PIM assert (to activate pim will activate assert)
14fb64e1f449ef YOSHIFUJI Hideaki   2008-04-03  1731  	 */
14fb64e1f449ef YOSHIFUJI Hideaki   2008-04-03  1732  	case MRT6_ASSERT:
14fb64e1f449ef YOSHIFUJI Hideaki   2008-04-03  1733  	{
14fb64e1f449ef YOSHIFUJI Hideaki   2008-04-03  1734  		int v;
03f52a0a554210 Joe Perches         2012-11-25  1735  
03f52a0a554210 Joe Perches         2012-11-25  1736  		if (optlen != sizeof(v))
03f52a0a554210 Joe Perches         2012-11-25  1737  			return -EINVAL;
14fb64e1f449ef YOSHIFUJI Hideaki   2008-04-03  1738  		if (get_user(v, (int __user *)optval))
14fb64e1f449ef YOSHIFUJI Hideaki   2008-04-03  1739  			return -EFAULT;
53d6841d225b93 Joe Perches         2012-11-25  1740  		mrt->mroute_do_assert = v;
14fb64e1f449ef YOSHIFUJI Hideaki   2008-04-03  1741  		return 0;
14fb64e1f449ef YOSHIFUJI Hideaki   2008-04-03  1742  	}
14fb64e1f449ef YOSHIFUJI Hideaki   2008-04-03  1743  
14fb64e1f449ef YOSHIFUJI Hideaki   2008-04-03  1744  #ifdef CONFIG_IPV6_PIMSM_V2
14fb64e1f449ef YOSHIFUJI Hideaki   2008-04-03  1745  	case MRT6_PIM:
14fb64e1f449ef YOSHIFUJI Hideaki   2008-04-03  1746  	{
a9f83bf3858672 YOSHIFUJI Hideaki   2008-04-10  1747  		int v;
03f52a0a554210 Joe Perches         2012-11-25  1748  
03f52a0a554210 Joe Perches         2012-11-25  1749  		if (optlen != sizeof(v))
03f52a0a554210 Joe Perches         2012-11-25  1750  			return -EINVAL;
14fb64e1f449ef YOSHIFUJI Hideaki   2008-04-03 @1751  		if (get_user(v, (int __user *)optval))
14fb64e1f449ef YOSHIFUJI Hideaki   2008-04-03  1752  			return -EFAULT;
14fb64e1f449ef YOSHIFUJI Hideaki   2008-04-03  1753  		v = !!v;
14fb64e1f449ef YOSHIFUJI Hideaki   2008-04-03  1754  		rtnl_lock();
14fb64e1f449ef YOSHIFUJI Hideaki   2008-04-03  1755  		ret = 0;
6bd521433942d8 Patrick McHardy     2010-05-11  1756  		if (v != mrt->mroute_do_pim) {
6bd521433942d8 Patrick McHardy     2010-05-11  1757  			mrt->mroute_do_pim = v;
6bd521433942d8 Patrick McHardy     2010-05-11  1758  			mrt->mroute_do_assert = v;
14fb64e1f449ef YOSHIFUJI Hideaki   2008-04-03  1759  		}
14fb64e1f449ef YOSHIFUJI Hideaki   2008-04-03  1760  		rtnl_unlock();
14fb64e1f449ef YOSHIFUJI Hideaki   2008-04-03  1761  		return ret;
14fb64e1f449ef YOSHIFUJI Hideaki   2008-04-03  1762  	}
14fb64e1f449ef YOSHIFUJI Hideaki   2008-04-03  1763  
d1db275dd3f6e4 Patrick McHardy     2010-05-11  1764  #endif
d1db275dd3f6e4 Patrick McHardy     2010-05-11  1765  #ifdef CONFIG_IPV6_MROUTE_MULTIPLE_TABLES
d1db275dd3f6e4 Patrick McHardy     2010-05-11  1766  	case MRT6_TABLE:
d1db275dd3f6e4 Patrick McHardy     2010-05-11  1767  	{
d1db275dd3f6e4 Patrick McHardy     2010-05-11  1768  		u32 v;
d1db275dd3f6e4 Patrick McHardy     2010-05-11  1769  
d1db275dd3f6e4 Patrick McHardy     2010-05-11  1770  		if (optlen != sizeof(u32))
d1db275dd3f6e4 Patrick McHardy     2010-05-11  1771  			return -EINVAL;
d1db275dd3f6e4 Patrick McHardy     2010-05-11 @1772  		if (get_user(v, (u32 __user *)optval))
d1db275dd3f6e4 Patrick McHardy     2010-05-11  1773  			return -EFAULT;
75356a8143426a Dan Carpenter       2013-01-23  1774  		/* "pim6reg%u" should not exceed 16 bytes (IFNAMSIZ) */
75356a8143426a Dan Carpenter       2013-01-23  1775  		if (v != RT_TABLE_DEFAULT && v >= 100000000)
75356a8143426a Dan Carpenter       2013-01-23  1776  			return -EINVAL;
b70432f7319eb7 Yuval Mintz         2018-02-28  1777  		if (sk == rcu_access_pointer(mrt->mroute_sk))
d1db275dd3f6e4 Patrick McHardy     2010-05-11  1778  			return -EBUSY;
d1db275dd3f6e4 Patrick McHardy     2010-05-11  1779  
d1db275dd3f6e4 Patrick McHardy     2010-05-11  1780  		rtnl_lock();
d1db275dd3f6e4 Patrick McHardy     2010-05-11  1781  		ret = 0;
e783bb00ad86d9 Sabrina Dubroca     2018-06-05  1782  		mrt = ip6mr_new_table(net, v);
e783bb00ad86d9 Sabrina Dubroca     2018-06-05  1783  		if (IS_ERR(mrt))
e783bb00ad86d9 Sabrina Dubroca     2018-06-05  1784  			ret = PTR_ERR(mrt);
848235edb5c93e Sabrina Dubroca     2018-06-05  1785  		else
d1db275dd3f6e4 Patrick McHardy     2010-05-11  1786  			raw6_sk(sk)->ip6mr_table = v;
d1db275dd3f6e4 Patrick McHardy     2010-05-11  1787  		rtnl_unlock();
d1db275dd3f6e4 Patrick McHardy     2010-05-11  1788  		return ret;
d1db275dd3f6e4 Patrick McHardy     2010-05-11  1789  	}
14fb64e1f449ef YOSHIFUJI Hideaki   2008-04-03  1790  #endif
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1791  	/*
7d120c55df02a2 Rami Rosen          2008-04-23  1792  	 *	Spurious command, or MRT6_VERSION which you cannot
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1793  	 *	set.
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1794  	 */
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1795  	default:
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1796  		return -ENOPROTOOPT;
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1797  	}
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1798  }
7bc570c8b4f75d YOSHIFUJI Hideaki   2008-04-03  1799  

:::::: The code at line 1772 was first introduced by commit
:::::: d1db275dd3f6e4182c4c4b4a1ac6287925d60569 ipv6: ip6mr: support multiple tables

:::::: TO: Patrick McHardy <kaber@trash.net>
:::::: CC: Patrick McHardy <kaber@trash.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--LZvS9be/3tNcYl/X
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--LZvS9be/3tNcYl/X--
