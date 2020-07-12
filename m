Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF70C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 21:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA04820657
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 21:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbgGLVW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 17:22:57 -0400
Received: from mga07.intel.com ([134.134.136.100]:5183 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729339AbgGLVW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 17:22:57 -0400
IronPort-SDR: SdT7ioXCLD0ggJAGvrW+CYDGTerCZg3ghfw9rjLbSACMf07DjasiliwF99OVpCawYPYcoXQmhi
 ircRazvRzhFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="213374691"
X-IronPort-AV: E=Sophos;i="5.75,345,1589266800"; 
   d="gz'50?scan'50,208,50";a="213374691"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 14:19:11 -0700
IronPort-SDR: HA0PvLge9DO41e9meDmXg9p6yrmGWLJ+6wtejtjCWzqIUbZXQ5nWESLsiNB0b8G1BtjrVNqnsx
 j88e3ds5YSaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,345,1589266800"; 
   d="gz'50?scan'50,208,50";a="459056082"
Received: from lkp-server02.sh.intel.com (HELO fb03a464a2e3) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 12 Jul 2020 14:19:09 -0700
Received: from kbuild by fb03a464a2e3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jujNM-0000G5-QF; Sun, 12 Jul 2020 21:19:08 +0000
Date:   Mon, 13 Jul 2020 05:18:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: net/atm/pppoatm.c:373:24: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202007130538.QzropfIN%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0aea6d5c5be33ce94c16f9ab2f64de1f481f424b
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   3 weeks ago
config: openrisc-randconfig-s031-20200712 (attached as .config)
compiler: or1k-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-37-gc9676a3b-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=openrisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> net/atm/pppoatm.c:373:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user * @@
   net/atm/pppoatm.c:373:24: sparse:     expected int *__pu_addr
   net/atm/pppoatm.c:373:24: sparse:     got int [noderef] __user *
   net/atm/pppoatm.c:376:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   net/atm/pppoatm.c:376:24: sparse:     expected int const *__gu_addr
   net/atm/pppoatm.c:376:24: sparse:     got int [noderef] __user *
   net/atm/pppoatm.c:453:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short [noderef] [usertype] __user * @@
   net/atm/pppoatm.c:453:21: sparse:     expected unsigned short const *__gu_addr
   net/atm/pppoatm.c:453:21: sparse:     got unsigned short [noderef] [usertype] __user *
   net/atm/pppoatm.c:464:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user * @@
   net/atm/pppoatm.c:464:24: sparse:     expected int *__pu_addr
   net/atm/pppoatm.c:464:24: sparse:     got int [noderef] __user *
   net/atm/pppoatm.c:467:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user * @@
   net/atm/pppoatm.c:467:24: sparse:     expected int *__pu_addr
   net/atm/pppoatm.c:467:24: sparse:     got int [noderef] __user *
--
   net/decnet/af_decnet.c:1537:12: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/decnet/af_decnet.c:1537:12: sparse:     expected int const *__gu_addr
   net/decnet/af_decnet.c:1537:12: sparse:     got int [noderef] __user *optlen
>> net/decnet/af_decnet.c:1632:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user *optlen @@
   net/decnet/af_decnet.c:1632:21: sparse:     expected int *__pu_addr
   net/decnet/af_decnet.c:1632:21: sparse:     got int [noderef] __user *optlen
   net/decnet/af_decnet.c:249:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int hash @@     got restricted __le16 [usertype] sdn_objnamel @@
   net/decnet/af_decnet.c:249:22: sparse:     expected unsigned int hash
   net/decnet/af_decnet.c:249:22: sparse:     got restricted __le16 [usertype] sdn_objnamel
>> net/decnet/af_decnet.c:1241:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user * @@
   net/decnet/af_decnet.c:1241:23: sparse:     expected int *__pu_addr
>> net/decnet/af_decnet.c:1241:23: sparse:     got int [noderef] __user *
   net/decnet/af_decnet.c:1254:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user * @@
   net/decnet/af_decnet.c:1254:23: sparse:     expected int *__pu_addr
   net/decnet/af_decnet.c:1254:23: sparse:     got int [noderef] __user *
   net/decnet/af_decnet.c:1516:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/decnet/af_decnet.c:1516:21: sparse:     expected int const *__gu_addr
   net/decnet/af_decnet.c:1516:21: sparse:     got int [noderef] __user *optlen
   net/decnet/af_decnet.c:1521:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user *optlen @@
   net/decnet/af_decnet.c:1521:31: sparse:     expected int *__pu_addr
   net/decnet/af_decnet.c:1521:31: sparse:     got int [noderef] __user *optlen
   arch/openrisc/include/asm/cmpxchg.h:101:29: sparse: sparse: shift too big (32) for type int
   arch/openrisc/include/asm/cmpxchg.h:101:29: sparse: sparse: shift too big (32) for type int
   include/net/dn.h:192:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] sport @@     got restricted __le16 [usertype] addrloc @@
   include/net/dn.h:192:24: sparse:     expected restricted __be16 [usertype] sport
   include/net/dn.h:192:24: sparse:     got restricted __le16 [usertype] addrloc
   include/net/dn.h:193:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] dport @@     got restricted __le16 [usertype] addrrem @@
   include/net/dn.h:193:24: sparse:     expected restricted __be16 [usertype] dport
   include/net/dn.h:193:24: sparse:     got restricted __le16 [usertype] addrrem
   arch/openrisc/include/asm/cmpxchg.h:101:29: sparse: sparse: shift too big (32) for type int
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   arch/openrisc/include/asm/cmpxchg.h:101:29: sparse: sparse: shift too big (32) for type int
   arch/openrisc/include/asm/cmpxchg.h:101:29: sparse: sparse: shift too big (32) for type int
   net/decnet/af_decnet.c:2159:13: sparse: sparse: context imbalance in 'dn_socket_get_idx' - wrong count at exit
   net/decnet/af_decnet.c:2187:9: sparse: sparse: context imbalance in 'dn_socket_seq_next' - unexpected unlock
   net/decnet/af_decnet.c:2196:17: sparse: sparse: context imbalance in 'dn_socket_seq_stop' - unexpected unlock
--
>> net/dccp/ccid.c:69:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user *optlen @@
   net/dccp/ccid.c:69:13: sparse:     expected int *__pu_addr
>> net/dccp/ccid.c:69:13: sparse:     got int [noderef] __user *optlen
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
--
>> net/dccp/proto.c:390:22: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user * @@
   net/dccp/proto.c:390:22: sparse:     expected int *__pu_addr
   net/dccp/proto.c:390:22: sparse:     got int [noderef] __user *
   net/dccp/proto.c:523:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   net/dccp/proto.c:523:13: sparse:     expected int const *__gu_addr
   net/dccp/proto.c:523:13: sparse:     got int [noderef] __user *
   net/dccp/proto.c:527:52: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be32 const [usertype] service @@     got int [assigned] val @@
   net/dccp/proto.c:527:52: sparse:     expected restricted __be32 const [usertype] service
   net/dccp/proto.c:527:52: sparse:     got int [assigned] val
>> net/dccp/proto.c:610:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user *optlen @@
   net/dccp/proto.c:610:13: sparse:     expected int *__pu_addr
   net/dccp/proto.c:610:13: sparse:     got int [noderef] __user *optlen
>> net/dccp/proto.c:611:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected restricted __be32 *__pu_addr @@     got restricted __be32 [noderef] [usertype] __user *optval @@
   net/dccp/proto.c:611:13: sparse:     expected restricted __be32 *__pu_addr
>> net/dccp/proto.c:611:13: sparse:     got restricted __be32 [noderef] [usertype] __user *optval
   net/dccp/proto.c:625:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/dccp/proto.c:625:13: sparse:     expected int const *__gu_addr
   net/dccp/proto.c:625:13: sparse:     got int [noderef] __user *optlen
   net/dccp/proto.c:681:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user *optlen @@
   net/dccp/proto.c:681:13: sparse:     expected int *__pu_addr
   net/dccp/proto.c:681:13: sparse:     got int [noderef] __user *optlen
   net/dccp/proto.c:736:57: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __be32 [usertype] param @@     got int cmsg_type @@
   net/dccp/proto.c:736:57: sparse:     expected restricted __be32 [usertype] param
   net/dccp/proto.c:736:57: sparse:     got int cmsg_type
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   arch/openrisc/include/asm/cmpxchg.h:101:29: sparse: sparse: shift too big (32) for type int
--
   drivers/watchdog/kempld_wdt.c:349:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/watchdog/kempld_wdt.c:349:21: sparse:     expected int const *__gu_addr
   drivers/watchdog/kempld_wdt.c:349:21: sparse:     got int [noderef] __user *p
>> drivers/watchdog/kempld_wdt.c:357:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user * @@
   drivers/watchdog/kempld_wdt.c:357:23: sparse:     expected int *__pu_addr
>> drivers/watchdog/kempld_wdt.c:357:23: sparse:     got int [noderef] __user *
--
   net/tipc/socket.c:3129:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   net/tipc/socket.c:3129:21: sparse:     expected unsigned int const *__gu_addr
   net/tipc/socket.c:3129:21: sparse:     got unsigned int [noderef] [usertype] __user *
>> net/tipc/socket.c:3212:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user *ol @@
   net/tipc/socket.c:3212:24: sparse:     expected int *__pu_addr
   net/tipc/socket.c:3212:24: sparse:     got int [noderef] __user *ol
   net/tipc/socket.c:3215:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *ol @@
   net/tipc/socket.c:3215:15: sparse:     expected int const *__gu_addr
   net/tipc/socket.c:3215:15: sparse:     got int [noderef] __user *ol
   net/tipc/socket.c:3265:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user *ol @@
   net/tipc/socket.c:3265:16: sparse:     expected int *__pu_addr
   net/tipc/socket.c:3265:16: sparse:     got int [noderef] __user *ol
   arch/openrisc/include/asm/cmpxchg.h:101:29: sparse: sparse: shift too big (32) for type int
   arch/openrisc/include/asm/cmpxchg.h:101:29: sparse: sparse: shift too big (32) for type int
   arch/openrisc/include/asm/cmpxchg.h:101:29: sparse: sparse: shift too big (32) for type int
   arch/openrisc/include/asm/cmpxchg.h:101:29: sparse: sparse: shift too big (32) for type int
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
--
   drivers/isdn/mISDN/socket.c:319:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/isdn/mISDN/socket.c:319:21: sparse:     expected int const *__gu_addr
   drivers/isdn/mISDN/socket.c:319:21: sparse:     got int [noderef] __user *
   drivers/isdn/mISDN/socket.c:333:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/isdn/mISDN/socket.c:333:21: sparse:     expected int const *__gu_addr
   drivers/isdn/mISDN/socket.c:333:21: sparse:     got int [noderef] __user *
>> drivers/isdn/mISDN/socket.c:367:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user * @@
   drivers/isdn/mISDN/socket.c:367:21: sparse:     expected int *__pu_addr
   drivers/isdn/mISDN/socket.c:367:21: sparse:     got int [noderef] __user *
   drivers/isdn/mISDN/socket.c:371:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/isdn/mISDN/socket.c:371:21: sparse:     expected int const *__gu_addr
   drivers/isdn/mISDN/socket.c:371:21: sparse:     got int [noderef] __user *
   drivers/isdn/mISDN/socket.c:417:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/isdn/mISDN/socket.c:417:21: sparse:     expected int const *__gu_addr
   drivers/isdn/mISDN/socket.c:417:21: sparse:     got int [noderef] __user *
   drivers/isdn/mISDN/socket.c:441:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   drivers/isdn/mISDN/socket.c:441:13: sparse:     expected int const *__gu_addr
   drivers/isdn/mISDN/socket.c:441:13: sparse:     got int [noderef] __user *optlen
>> drivers/isdn/mISDN/socket.c:454:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char *__pu_addr @@     got char [noderef] __user *optval @@
   drivers/isdn/mISDN/socket.c:454:21: sparse:     expected char *__pu_addr
>> drivers/isdn/mISDN/socket.c:454:21: sparse:     got char [noderef] __user *optval
   drivers/isdn/mISDN/socket.c:650:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user * @@
   drivers/isdn/mISDN/socket.c:650:21: sparse:     expected int *__pu_addr
   drivers/isdn/mISDN/socket.c:650:21: sparse:     got int [noderef] __user *
   drivers/isdn/mISDN/socket.c:654:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/isdn/mISDN/socket.c:654:21: sparse:     expected int const *__gu_addr
   drivers/isdn/mISDN/socket.c:654:21: sparse:     got int [noderef] __user *
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
--
>> drivers/isdn/mISDN/timerdev.c:124:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user * @@
   drivers/isdn/mISDN/timerdev.c:124:21: sparse:     expected int *__pu_addr
   drivers/isdn/mISDN/timerdev.c:124:21: sparse:     got int [noderef] __user *
   drivers/isdn/mISDN/timerdev.c:229:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/isdn/mISDN/timerdev.c:229:21: sparse:     expected int const *__gu_addr
   drivers/isdn/mISDN/timerdev.c:229:21: sparse:     got int [noderef] __user *
   drivers/isdn/mISDN/timerdev.c:241:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user * @@
   drivers/isdn/mISDN/timerdev.c:241:21: sparse:     expected int *__pu_addr
   drivers/isdn/mISDN/timerdev.c:241:21: sparse:     got int [noderef] __user *
   drivers/isdn/mISDN/timerdev.c:245:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/isdn/mISDN/timerdev.c:245:21: sparse:     expected int const *__gu_addr
   drivers/isdn/mISDN/timerdev.c:245:21: sparse:     got int [noderef] __user *
   drivers/isdn/mISDN/timerdev.c:252:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user * @@
   drivers/isdn/mISDN/timerdev.c:252:21: sparse:     expected int *__pu_addr
   drivers/isdn/mISDN/timerdev.c:252:21: sparse:     got int [noderef] __user *
--
>> drivers/net/wireless/ray_cs.c:733:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem *[usertype] sram @@
   drivers/net/wireless/ray_cs.c:733:22: sparse:     expected void *addr
>> drivers/net/wireless/ray_cs.c:733:22: sparse:     got void [noderef] __iomem *[usertype] sram
>> drivers/net/wireless/ray_cs.c:734:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem *[usertype] rmem @@
   drivers/net/wireless/ray_cs.c:734:22: sparse:     expected void *addr
>> drivers/net/wireless/ray_cs.c:734:22: sparse:     got void [noderef] __iomem *[usertype] rmem
>> drivers/net/wireless/ray_cs.c:735:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem *[usertype] amem @@
   drivers/net/wireless/ray_cs.c:735:22: sparse:     expected void *addr
>> drivers/net/wireless/ray_cs.c:735:22: sparse:     got void [noderef] __iomem *[usertype] amem
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
--
   drivers/net/ethernet/via/via-velocity.h:237:24: sparse: sparse: mixed bitwiseness
   drivers/net/ethernet/via/via-velocity.c:87:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void *addr @@     got struct mac_regs [noderef] __iomem *mac_regs @@
   drivers/net/ethernet/via/via-velocity.c:87:26: sparse:     expected void *addr
   drivers/net/ethernet/via/via-velocity.c:87:26: sparse:     got struct mac_regs [noderef] __iomem *mac_regs
   drivers/net/ethernet/via/via-velocity.c:90:49: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted pci_power_t [usertype] state @@     got char state @@
   drivers/net/ethernet/via/via-velocity.c:90:49: sparse:     expected restricted pci_power_t [usertype] state
   drivers/net/ethernet/via/via-velocity.c:90:49: sparse:     got char state
   drivers/net/ethernet/via/via-velocity.c:92:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/via/via-velocity.c:92:36: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/via/via-velocity.c:92:36: sparse:     got void *
   drivers/net/ethernet/via/via-velocity.c:1727:34: sparse: sparse: cast from restricted __le16
   drivers/net/ethernet/via/via-velocity.c:1727:34: sparse: sparse: cast from restricted __le16
   drivers/net/ethernet/via/via-velocity.c:1727:34: sparse: sparse: cast from restricted __le16
   drivers/net/ethernet/via/via-velocity.c:1727:34: sparse: sparse: cast from restricted __le16
   drivers/net/ethernet/via/via-velocity.c:1727:34: sparse: sparse: cast from restricted __le16
   drivers/net/ethernet/via/via-velocity.c:1727:34: sparse: sparse: cast from restricted __le16
   drivers/net/ethernet/via/via-velocity.c:1730:17: sparse: sparse: cast to restricted __le16
   drivers/net/ethernet/via/via-velocity.c:1730:17: sparse: sparse: cast to restricted __le16
   drivers/net/ethernet/via/via-velocity.c:1730:17: sparse: sparse: cast to restricted __le16
   drivers/net/ethernet/via/via-velocity.c:1730:17: sparse: sparse: cast to restricted __le16
   drivers/net/ethernet/via/via-velocity.c:2222:40: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected char state @@     got restricted pci_power_t [usertype] @@
   drivers/net/ethernet/via/via-velocity.c:2222:40: sparse:     expected char state
   drivers/net/ethernet/via/via-velocity.c:2222:40: sparse:     got restricted pci_power_t [usertype]
   drivers/net/ethernet/via/via-velocity.c:2230:48: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected char state @@     got restricted pci_power_t [usertype] @@
   drivers/net/ethernet/via/via-velocity.c:2230:48: sparse:     expected char state
   drivers/net/ethernet/via/via-velocity.c:2230:48: sparse:     got restricted pci_power_t [usertype]
   drivers/net/ethernet/via/via-velocity.c:2417:48: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected char state @@     got restricted pci_power_t [usertype] @@
   drivers/net/ethernet/via/via-velocity.c:2417:48: sparse:     expected char state
   drivers/net/ethernet/via/via-velocity.c:2417:48: sparse:     got restricted pci_power_t [usertype]
   drivers/net/ethernet/via/via-velocity.c:2430:48: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected char state @@     got restricted pci_power_t [usertype] @@
   drivers/net/ethernet/via/via-velocity.c:2430:48: sparse:     expected char state
   drivers/net/ethernet/via/via-velocity.c:2430:48: sparse:     got restricted pci_power_t [usertype]
   drivers/net/ethernet/via/via-velocity.c:2868:40: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected char state @@     got restricted pci_power_t [usertype] @@
   drivers/net/ethernet/via/via-velocity.c:2868:40: sparse:     expected char state
   drivers/net/ethernet/via/via-velocity.c:2868:40: sparse:     got restricted pci_power_t [usertype]
>> drivers/net/ethernet/via/via-velocity.c:2875:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got struct mac_regs [noderef] __iomem *[assigned] regs @@
   drivers/net/ethernet/via/via-velocity.c:2875:17: sparse:     expected void *addr
>> drivers/net/ethernet/via/via-velocity.c:2875:17: sparse:     got struct mac_regs [noderef] __iomem *[assigned] regs
>> drivers/net/ethernet/via/via-velocity.c:2896:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got struct mac_regs [noderef] __iomem *mac_regs @@
   drivers/net/ethernet/via/via-velocity.c:2896:21: sparse:     expected void *addr
   drivers/net/ethernet/via/via-velocity.c:2896:21: sparse:     got struct mac_regs [noderef] __iomem *mac_regs
   drivers/net/ethernet/via/via-velocity.c:3270:48: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected char state @@     got restricted pci_power_t [usertype] @@
   drivers/net/ethernet/via/via-velocity.c:3270:48: sparse:     expected char state
   drivers/net/ethernet/via/via-velocity.c:3270:48: sparse:     got restricted pci_power_t [usertype]
   drivers/net/ethernet/via/via-velocity.c:3287:48: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected char state @@     got restricted pci_power_t [usertype] @@
   drivers/net/ethernet/via/via-velocity.c:3287:48: sparse:     expected char state
   drivers/net/ethernet/via/via-velocity.c:3287:48: sparse:     got restricted pci_power_t [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:215:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:215:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:215:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
--
   drivers/net/ppp/pptp.c:281:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] ack @@     got restricted __be32 @@
   drivers/net/ppp/pptp.c:281:21: sparse:     expected unsigned int [usertype] ack
   drivers/net/ppp/pptp.c:281:21: sparse:     got restricted __be32
   drivers/net/ppp/pptp.c:283:23: sparse: sparse: cast to restricted __be32
   drivers/net/ppp/pptp.c:358:26: sparse: sparse: cast from restricted __be16
   drivers/net/ppp/pptp.c:358:26: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] call_id @@     got restricted __be16 [usertype] @@
   drivers/net/ppp/pptp.c:358:26: sparse:     expected unsigned short [usertype] call_id
   drivers/net/ppp/pptp.c:358:26: sparse:     got restricted __be16 [usertype]
>> drivers/net/ppp/pptp.c:582:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/pptp.c:582:21: sparse:     expected int *__pu_addr
   drivers/net/ppp/pptp.c:582:21: sparse:     got int [noderef] __user *p
   drivers/net/ppp/pptp.c:587:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/net/ppp/pptp.c:587:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/pptp.c:587:21: sparse:     got int [noderef] __user *p
--
>> drivers/net/ethernet/xircom/xirc2ps_cs.c:935:50: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem * @@
   drivers/net/ethernet/xircom/xirc2ps_cs.c:935:50: sparse:     expected void *addr
>> drivers/net/ethernet/xircom/xirc2ps_cs.c:935:50: sparse:     got void [noderef] __iomem *
   include/asm-generic/io.h:477:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:477:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:477:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:477:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:477:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:477:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:477:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:477:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:511:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:511:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:511:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:511:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:511:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:511:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:477:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:477:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:477:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:477:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:511:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:511:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:511:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:511:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:511:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:511:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:511:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:511:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:511:22: sparse:     got restricted __le16 [usertype]
--
>> net/l2tp/l2tp_ip.c:593:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user * @@
   net/l2tp/l2tp_ip.c:593:16: sparse:     expected int *__pu_addr
>> net/l2tp/l2tp_ip.c:593:16: sparse:     got int [noderef] __user *
   arch/openrisc/include/asm/cmpxchg.h:101:29: sparse: sparse: shift too big (32) for type int
--
>> drivers/iio/adc/men_z188_adc.c:145:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem *base @@
   drivers/iio/adc/men_z188_adc.c:145:20: sparse:     expected void *addr
>> drivers/iio/adc/men_z188_adc.c:145:20: sparse:     got void [noderef] __iomem *base
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:166:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
--
>> drivers/android/binder.c:3609:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/android/binder.c:3609:21: sparse:     expected unsigned int const *__gu_addr
>> drivers/android/binder.c:3609:21: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/android/binder.c:3629:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/android/binder.c:3629:29: sparse:     expected unsigned int const *__gu_addr
   drivers/android/binder.c:3629:29: sparse:     got unsigned int [noderef] [usertype] __user *
>> drivers/android/binder.c:3688:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long const *__gu_addr @@     got unsigned long long [noderef] [usertype] __user * @@
   drivers/android/binder.c:3688:29: sparse:     expected unsigned long long const *__gu_addr
>> drivers/android/binder.c:3688:29: sparse:     got unsigned long long [noderef] [usertype] __user *
   drivers/android/binder.c:3691:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long const *__gu_addr @@     got unsigned long long [noderef] [usertype] __user * @@
   drivers/android/binder.c:3691:29: sparse:     expected unsigned long long const *__gu_addr
   drivers/android/binder.c:3691:29: sparse:     got unsigned long long [noderef] [usertype] __user *
   drivers/android/binder.c:3760:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long const *__gu_addr @@     got unsigned long long [noderef] [usertype] __user * @@
   drivers/android/binder.c:3760:29: sparse:     expected unsigned long long const *__gu_addr
   drivers/android/binder.c:3760:29: sparse:     got unsigned long long [noderef] [usertype] __user *
   drivers/android/binder.c:3857:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/android/binder.c:3857:29: sparse:     expected unsigned int const *__gu_addr
   drivers/android/binder.c:3857:29: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/android/binder.c:3860:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long const *__gu_addr @@     got unsigned long long [noderef] [usertype] __user * @@
   drivers/android/binder.c:3860:29: sparse:     expected unsigned long long const *__gu_addr
   drivers/android/binder.c:3860:29: sparse:     got unsigned long long [noderef] [usertype] __user *
   drivers/android/binder.c:3979:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long const *__gu_addr @@     got unsigned long long [noderef] [usertype] __user * @@
   drivers/android/binder.c:3979:29: sparse:     expected unsigned long long const *__gu_addr
   drivers/android/binder.c:3979:29: sparse:     got unsigned long long [noderef] [usertype] __user *
>> drivers/android/binder.c:4055:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/android/binder.c:4055:13: sparse:     expected unsigned int *__pu_addr
   drivers/android/binder.c:4055:13: sparse:     got unsigned int [noderef] [usertype] __user *
>> drivers/android/binder.c:4059:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long *__pu_addr @@     got unsigned long long [noderef] [usertype] __user * @@
   drivers/android/binder.c:4059:13: sparse:     expected unsigned long long *__pu_addr
   drivers/android/binder.c:4059:13: sparse:     got unsigned long long [noderef] [usertype] __user *
   drivers/android/binder.c:4063:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long *__pu_addr @@     got unsigned long long [noderef] [usertype] __user * @@
   drivers/android/binder.c:4063:13: sparse:     expected unsigned long long *__pu_addr
   drivers/android/binder.c:4063:13: sparse:     got unsigned long long [noderef] [usertype] __user *
   drivers/android/binder.c:4186:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/android/binder.c:4186:21: sparse:     expected unsigned int *__pu_addr
   drivers/android/binder.c:4186:21: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/android/binder.c:4268:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/android/binder.c:4268:29: sparse:     expected unsigned int *__pu_addr
   drivers/android/binder.c:4268:29: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/android/binder.c:4281:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/android/binder.c:4281:29: sparse:     expected unsigned int *__pu_addr
   drivers/android/binder.c:4281:29: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/android/binder.c:4407:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/android/binder.c:4407:29: sparse:     expected unsigned int *__pu_addr
   drivers/android/binder.c:4407:29: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/android/binder.c:4410:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long *__pu_addr @@     got unsigned long long [noderef] [usertype] __user * @@
   drivers/android/binder.c:4410:29: sparse:     expected unsigned long long *__pu_addr
   drivers/android/binder.c:4410:29: sparse:     got unsigned long long [noderef] [usertype] __user *
   drivers/android/binder.c:4482:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/android/binder.c:4482:37: sparse:     expected unsigned int *__pu_addr
   drivers/android/binder.c:4482:37: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/android/binder.c:4502:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/android/binder.c:4502:21: sparse:     expected unsigned int *__pu_addr
   drivers/android/binder.c:4502:21: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/android/binder.c:4567:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/android/binder.c:4567:21: sparse:     expected unsigned int *__pu_addr
   drivers/android/binder.c:4567:21: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/android/binder.c:4806:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __poll_t @@     got int @@
   drivers/android/binder.c:4806:24: sparse:     expected restricted __poll_t
   drivers/android/binder.c:4806:24: sparse:     got int
>> drivers/android/binder.c:5071:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int *__pu_addr @@     got signed int [noderef] __user * @@
   drivers/android/binder.c:5071:21: sparse:     expected signed int *__pu_addr
>> drivers/android/binder.c:5071:21: sparse:     got signed int [noderef] __user *
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
--
   drivers/hwmon/w83793.c:1372:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user * @@
   drivers/hwmon/w83793.c:1372:37: sparse:     expected char const *__gu_addr
   drivers/hwmon/w83793.c:1372:37: sparse:     got char const [noderef] __user *
>> drivers/hwmon/w83793.c:1408:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user * @@
   drivers/hwmon/w83793.c:1408:23: sparse:     expected int *__pu_addr
   drivers/hwmon/w83793.c:1408:23: sparse:     got int [noderef] __user *
   drivers/hwmon/w83793.c:1412:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user * @@
   drivers/hwmon/w83793.c:1412:23: sparse:     expected int *__pu_addr
   drivers/hwmon/w83793.c:1412:23: sparse:     got int [noderef] __user *
   drivers/hwmon/w83793.c:1421:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user * @@
   drivers/hwmon/w83793.c:1421:23: sparse:     expected int *__pu_addr
   drivers/hwmon/w83793.c:1421:23: sparse:     got int [noderef] __user *
   drivers/hwmon/w83793.c:1425:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/hwmon/w83793.c:1425:21: sparse:     expected int const *__gu_addr
   drivers/hwmon/w83793.c:1425:21: sparse:     got int [noderef] __user *
   drivers/hwmon/w83793.c:1431:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user * @@
   drivers/hwmon/w83793.c:1431:31: sparse:     expected int *__pu_addr
   drivers/hwmon/w83793.c:1431:31: sparse:     got int [noderef] __user *
   drivers/hwmon/w83793.c:1435:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/hwmon/w83793.c:1435:21: sparse:     expected int const *__gu_addr
   drivers/hwmon/w83793.c:1435:21: sparse:     got int [noderef] __user *
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
--
   net/appletalk/ddp.c:100:33: sparse: sparse: restricted __be16 degrades to integer
   net/appletalk/ddp.c:113:33: sparse: sparse: restricted __be16 degrades to integer
   net/appletalk/ddp.c:409:47: sparse: sparse: restricted __be16 degrades to integer
>> net/appletalk/ddp.c:1801:22: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user * @@
   net/appletalk/ddp.c:1801:22: sparse:     expected int *__pu_addr
>> net/appletalk/ddp.c:1801:22: sparse:     got int [noderef] __user *
   net/appletalk/ddp.c:1814:22: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user * @@
   net/appletalk/ddp.c:1814:22: sparse:     expected int *__pu_addr
   net/appletalk/ddp.c:1814:22: sparse:     got int [noderef] __user *
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
--
>> drivers/video/fbdev/uvesafb.c:1757:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/uvesafb.c:1757:21: sparse:     expected void *addr
>> drivers/video/fbdev/uvesafb.c:1757:21: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/uvesafb.c:1784:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/uvesafb.c:1784:29: sparse:     expected void *addr
   drivers/video/fbdev/uvesafb.c:1784:29: sparse:     got char [noderef] __iomem *screen_base
--
>> net/ipv4/bpfilter/sockopt.c:63:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ipv4/bpfilter/sockopt.c:63:13: sparse:     expected int const *__gu_addr
>> net/ipv4/bpfilter/sockopt.c:63:13: sparse:     got int [noderef] __user *optlen
--
>> drivers/char/pcmcia/synclink_cs.c:2058:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user *mask_ptr @@
   drivers/char/pcmcia/synclink_cs.c:2058:17: sparse:     expected int *__pu_addr
>> drivers/char/pcmcia/synclink_cs.c:2058:17: sparse:     got int [noderef] __user *mask_ptr
   include/asm-generic/io.h:511:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:511:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:511:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:511:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:511:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:511:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:511:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:511:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:511:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:511:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:511:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:511:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:477:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:477:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:477:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:477:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:511:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:511:22: sparse:     expected unsigned short [usertype] value
   include/asm-generic/io.h:511:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:477:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:477:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:477:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:477:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:477:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:477:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:477:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:477:15: sparse: sparse: cast to restricted __le16
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/asm-generic/io.h:477:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:477:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:477:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:477:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:477:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:477:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:477:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:477:15: sparse: sparse: cast to restricted __le16
--
>> fs/coda/psdev.c:79:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user * @@
   fs/coda/psdev.c:79:24: sparse:     expected int *__pu_addr
>> fs/coda/psdev.c:79:24: sparse:     got int [noderef] __user *
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
--
>> net/netfilter/x_tables.c:277:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__pu_addr @@     got unsigned short [noderef] [usertype] __user *psize @@
   net/netfilter/x_tables.c:277:13: sparse:     expected unsigned short *__pu_addr
>> net/netfilter/x_tables.c:277:13: sparse:     got unsigned short [noderef] [usertype] __user *psize
>> net/netfilter/x_tables.c:281:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char *__pu_addr @@     got unsigned char [noderef] [usertype] __user *prev @@
   net/netfilter/x_tables.c:281:13: sparse:     expected unsigned char *__pu_addr
>> net/netfilter/x_tables.c:281:13: sparse:     got unsigned char [noderef] [usertype] __user *prev
>> net/netfilter/x_tables.c:299:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __user * @@
   net/netfilter/x_tables.c:299:28: sparse:     expected void *addr
   net/netfilter/x_tables.c:299:28: sparse:     got void [noderef] __user *
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from

vim +373 net/atm/pppoatm.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  366  
^1da177e4c3f41 Linus Torvalds 2005-04-16  367  /* This handles ioctls sent to the /dev/ppp interface */
^1da177e4c3f41 Linus Torvalds 2005-04-16  368  static int pppoatm_devppp_ioctl(struct ppp_channel *chan, unsigned int cmd,
^1da177e4c3f41 Linus Torvalds 2005-04-16  369  	unsigned long arg)
^1da177e4c3f41 Linus Torvalds 2005-04-16  370  {
^1da177e4c3f41 Linus Torvalds 2005-04-16  371  	switch (cmd) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  372  	case PPPIOCGFLAGS:
^1da177e4c3f41 Linus Torvalds 2005-04-16 @373  		return put_user(chan_to_pvcc(chan)->flags, (int __user *) arg)
^1da177e4c3f41 Linus Torvalds 2005-04-16  374  		    ? -EFAULT : 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  375  	case PPPIOCSFLAGS:
^1da177e4c3f41 Linus Torvalds 2005-04-16  376  		return get_user(chan_to_pvcc(chan)->flags, (int __user *) arg)
^1da177e4c3f41 Linus Torvalds 2005-04-16  377  		    ? -EFAULT : 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  378  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  379  	return -ENOTTY;
^1da177e4c3f41 Linus Torvalds 2005-04-16  380  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  381  

:::::: The code at line 373 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--HlL+5n6rz5pIUxbD
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--HlL+5n6rz5pIUxbD--
