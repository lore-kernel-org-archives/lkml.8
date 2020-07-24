Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29ADC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 06:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAC4E2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 06:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgGXGuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 02:50:02 -0400
Received: from mga05.intel.com ([192.55.52.43]:13254 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgGXGuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 02:50:02 -0400
IronPort-SDR: z10+IUbC6m+rj/u0PYOQvKWPuPS9J5b03DRyY3C+zI5fnA+JJrcrZGZ3lJnYvWbbGvio06h10Z
 R3fW/4nj7d8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="235543468"
X-IronPort-AV: E=Sophos;i="5.75,389,1589266800"; 
   d="gz'50?scan'50,208,50";a="235543468"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 23:14:59 -0700
IronPort-SDR: uCwOJfXpEJjf9iWnj2Mrk+92jtbSSVzRdwVJZZxtyoci6BUZVKSuGuOXwGtdKSvh3PYEGCWqzz
 KBbHrs6NXNAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,389,1589266800"; 
   d="gz'50?scan'50,208,50";a="432983440"
Received: from lkp-server01.sh.intel.com (HELO df0563f96c37) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 23 Jul 2020 23:14:57 -0700
Received: from kbuild by df0563f96c37 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jyqyu-00006M-S7; Fri, 24 Jul 2020 06:14:56 +0000
Date:   Fri, 24 Jul 2020 14:14:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: net/core/pktgen.c:720:21: sparse: sparse: incorrect type in argument
 1 (different address spaces)
Message-ID: <202007241405.eD6lNLj9%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f37e99aca03f63aa3f2bd13ceaf769455d12c4b0
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   5 weeks ago
config: sh-randconfig-s031-20200724 (attached as .config)
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

   net/core/pktgen.c:720:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user * @@
   net/core/pktgen.c:720:21: sparse:     expected char const *__gu_addr
   net/core/pktgen.c:720:21: sparse:     got char const [noderef] __user *
>> net/core/pktgen.c:720:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got char const *__gu_addr @@
>> net/core/pktgen.c:720:21: sparse:     expected void const volatile [noderef] __user *
   net/core/pktgen.c:720:21: sparse:     got char const *__gu_addr
   net/core/pktgen.c:738:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user * @@
   net/core/pktgen.c:738:21: sparse:     expected char const *__gu_addr
   net/core/pktgen.c:738:21: sparse:     got char const [noderef] __user *
   net/core/pktgen.c:738:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got char const *__gu_addr @@
   net/core/pktgen.c:738:21: sparse:     expected void const volatile [noderef] __user *
   net/core/pktgen.c:738:21: sparse:     got char const *__gu_addr
   net/core/pktgen.c:764:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user * @@
   net/core/pktgen.c:764:21: sparse:     expected char const *__gu_addr
   net/core/pktgen.c:764:21: sparse:     got char const [noderef] __user *
   net/core/pktgen.c:764:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got char const *__gu_addr @@
   net/core/pktgen.c:764:21: sparse:     expected void const volatile [noderef] __user *
   net/core/pktgen.c:764:21: sparse:     got char const *__gu_addr
   net/core/pktgen.c:781:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user * @@
   net/core/pktgen.c:781:21: sparse:     expected char const *__gu_addr
   net/core/pktgen.c:781:21: sparse:     got char const [noderef] __user *
   net/core/pktgen.c:781:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got char const *__gu_addr @@
   net/core/pktgen.c:781:21: sparse:     expected void const volatile [noderef] __user *
   net/core/pktgen.c:781:21: sparse:     got char const *__gu_addr
   net/core/pktgen.c:815:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user * @@
   net/core/pktgen.c:815:21: sparse:     expected char const *__gu_addr
   net/core/pktgen.c:815:21: sparse:     got char const [noderef] __user *
   net/core/pktgen.c:815:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got char const *__gu_addr @@
   net/core/pktgen.c:815:21: sparse:     expected void const volatile [noderef] __user *
   net/core/pktgen.c:815:21: sparse:     got char const *__gu_addr
--
>> fs/nfsd/nfs4recover.c:800:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char const [noderef] __user * @@
   fs/nfsd/nfs4recover.c:800:13: sparse:     expected unsigned char const *__gu_addr
>> fs/nfsd/nfs4recover.c:800:13: sparse:     got unsigned char const [noderef] __user *
>> fs/nfsd/nfs4recover.c:800:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned char const *__gu_addr @@
>> fs/nfsd/nfs4recover.c:800:13: sparse:     expected void const volatile [noderef] __user *
   fs/nfsd/nfs4recover.c:800:13: sparse:     got unsigned char const *__gu_addr
>> fs/nfsd/nfs4recover.c:809:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short const [noderef] __user * @@
   fs/nfsd/nfs4recover.c:809:29: sparse:     expected unsigned short const *__gu_addr
>> fs/nfsd/nfs4recover.c:809:29: sparse:     got unsigned short const [noderef] __user *
>> fs/nfsd/nfs4recover.c:809:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned short const *__gu_addr @@
   fs/nfsd/nfs4recover.c:809:29: sparse:     expected void const volatile [noderef] __user *
   fs/nfsd/nfs4recover.c:809:29: sparse:     got unsigned short const *__gu_addr
   fs/nfsd/nfs4recover.c:815:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char const [noderef] __user * @@
   fs/nfsd/nfs4recover.c:815:25: sparse:     expected unsigned char const *__gu_addr
   fs/nfsd/nfs4recover.c:815:25: sparse:     got unsigned char const [noderef] __user *
   fs/nfsd/nfs4recover.c:815:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned char const *__gu_addr @@
   fs/nfsd/nfs4recover.c:815:25: sparse:     expected void const volatile [noderef] __user *
   fs/nfsd/nfs4recover.c:815:25: sparse:     got unsigned char const *__gu_addr
   fs/nfsd/nfs4recover.c:829:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short const [noderef] __user * @@
   fs/nfsd/nfs4recover.c:829:29: sparse:     expected unsigned short const *__gu_addr
   fs/nfsd/nfs4recover.c:829:29: sparse:     got unsigned short const [noderef] __user *
   fs/nfsd/nfs4recover.c:829:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned short const *__gu_addr @@
   fs/nfsd/nfs4recover.c:829:29: sparse:     expected void const volatile [noderef] __user *
   fs/nfsd/nfs4recover.c:829:29: sparse:     got unsigned short const *__gu_addr
>> fs/nfsd/nfs4recover.c:880:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed short const *__gu_addr @@     got signed short [noderef] __user * @@
   fs/nfsd/nfs4recover.c:880:13: sparse:     expected signed short const *__gu_addr
>> fs/nfsd/nfs4recover.c:880:13: sparse:     got signed short [noderef] __user *
>> fs/nfsd/nfs4recover.c:880:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got signed short const *__gu_addr @@
   fs/nfsd/nfs4recover.c:880:13: sparse:     expected void const volatile [noderef] __user *
   fs/nfsd/nfs4recover.c:880:13: sparse:     got signed short const *__gu_addr
--
   net/ipv6/ip6mr.c:1721:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   net/ipv6/ip6mr.c:1721:21: sparse:     expected int const *__gu_addr
   net/ipv6/ip6mr.c:1721:21: sparse:     got int [noderef] __user *
>> net/ipv6/ip6mr.c:1721:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
>> net/ipv6/ip6mr.c:1721:21: sparse:     expected void const volatile [noderef] __user *
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
   net/kcm/kcmsock.c:1280:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   net/kcm/kcmsock.c:1280:13: sparse:     expected int const *__gu_addr
   net/kcm/kcmsock.c:1280:13: sparse:     got int [noderef] __user *
>> net/kcm/kcmsock.c:1280:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
>> net/kcm/kcmsock.c:1280:13: sparse:     expected void const volatile [noderef] __user *
   net/kcm/kcmsock.c:1280:13: sparse:     got int const *__gu_addr
   net/kcm/kcmsock.c:1310:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/kcm/kcmsock.c:1310:13: sparse:     expected int const *__gu_addr
   net/kcm/kcmsock.c:1310:13: sparse:     got int [noderef] __user *optlen
   net/kcm/kcmsock.c:1310:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   net/kcm/kcmsock.c:1310:13: sparse:     expected void const volatile [noderef] __user *
   net/kcm/kcmsock.c:1310:13: sparse:     got int const *__gu_addr
--
   net/sctp/socket.c:2221:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   net/sctp/socket.c:2221:13: sparse:     expected int const *__gu_addr
   net/sctp/socket.c:2221:13: sparse:     got int [noderef] __user *
>> net/sctp/socket.c:2221:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
>> net/sctp/socket.c:2221:13: sparse:     expected void const volatile [noderef] __user *
   net/sctp/socket.c:2221:13: sparse:     got int const *__gu_addr
   net/sctp/socket.c:3092:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   net/sctp/socket.c:3092:13: sparse:     expected int const *__gu_addr
   net/sctp/socket.c:3092:13: sparse:     got int [noderef] __user *
   net/sctp/socket.c:3092:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   net/sctp/socket.c:3092:13: sparse:     expected void const volatile [noderef] __user *
   net/sctp/socket.c:3092:13: sparse:     got int const *__gu_addr
   net/sctp/socket.c:3252:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   net/sctp/socket.c:3252:13: sparse:     expected int const *__gu_addr
   net/sctp/socket.c:3252:13: sparse:     got int [noderef] __user *
   net/sctp/socket.c:3252:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   net/sctp/socket.c:3252:13: sparse:     expected void const volatile [noderef] __user *
   net/sctp/socket.c:3252:13: sparse:     got int const *__gu_addr
   net/sctp/socket.c:3512:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   net/sctp/socket.c:3512:13: sparse:     expected int const *__gu_addr
   net/sctp/socket.c:3512:13: sparse:     got int [noderef] __user *
   net/sctp/socket.c:3512:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   net/sctp/socket.c:3512:13: sparse:     expected void const volatile [noderef] __user *
   net/sctp/socket.c:3512:13: sparse:     got int const *__gu_addr
   net/sctp/socket.c:3548:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   net/sctp/socket.c:3548:13: sparse:     expected int const *__gu_addr
   net/sctp/socket.c:3548:13: sparse:     got int [noderef] __user *
   net/sctp/socket.c:3548:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   net/sctp/socket.c:3548:13: sparse:     expected void const volatile [noderef] __user *
   net/sctp/socket.c:3548:13: sparse:     got int const *__gu_addr
   net/sctp/socket.c:3937:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   net/sctp/socket.c:3937:13: sparse:     expected int const *__gu_addr
   net/sctp/socket.c:3937:13: sparse:     got int [noderef] __user *
   net/sctp/socket.c:3937:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   net/sctp/socket.c:3937:13: sparse:     expected void const volatile [noderef] __user *
   net/sctp/socket.c:3937:13: sparse:     got int const *__gu_addr
   net/sctp/socket.c:4038:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   net/sctp/socket.c:4038:13: sparse:     expected int const *__gu_addr
   net/sctp/socket.c:4038:13: sparse:     got int [noderef] __user *
   net/sctp/socket.c:4038:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   net/sctp/socket.c:4038:13: sparse:     expected void const volatile [noderef] __user *
   net/sctp/socket.c:4038:13: sparse:     got int const *__gu_addr
   net/sctp/socket.c:4054:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   net/sctp/socket.c:4054:13: sparse:     expected int const *__gu_addr
   net/sctp/socket.c:4054:13: sparse:     got int [noderef] __user *
   net/sctp/socket.c:4054:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   net/sctp/socket.c:4054:13: sparse:     expected void const volatile [noderef] __user *
   net/sctp/socket.c:4054:13: sparse:     got int const *__gu_addr
   net/sctp/socket.c:4443:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   net/sctp/socket.c:4443:13: sparse:     expected int const *__gu_addr
   net/sctp/socket.c:4443:13: sparse:     got int [noderef] __user *
   net/sctp/socket.c:4443:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   net/sctp/socket.c:4443:13: sparse:     expected void const volatile [noderef] __user *
   net/sctp/socket.c:4443:13: sparse:     got int const *__gu_addr
   net/sctp/socket.c:8051:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/sctp/socket.c:8051:13: sparse:     expected int const *__gu_addr
   net/sctp/socket.c:8051:13: sparse:     got int [noderef] __user *optlen
   net/sctp/socket.c:8051:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got int const *__gu_addr @@
   net/sctp/socket.c:8051:13: sparse:     expected void const volatile [noderef] __user *
   net/sctp/socket.c:8051:13: sparse:     got int const *__gu_addr
   net/sctp/socket.c:8447:20: sparse: sparse: context imbalance in 'sctp_get_port_local' - unexpected unlock

vim +720 net/core/pktgen.c

^1da177e4c3f41 Linus Torvalds     2005-04-16  708  
ca6549af77f0f2 Steven Whitehouse  2006-03-23  709  
63adc6fb8ac0de Stephen Hemminger  2009-08-27  710  static int hex32_arg(const char __user *user_buffer, unsigned long maxlen,
63adc6fb8ac0de Stephen Hemminger  2009-08-27  711  		     __u32 *num)
ca6549af77f0f2 Steven Whitehouse  2006-03-23  712  {
ca6549af77f0f2 Steven Whitehouse  2006-03-23  713  	int i = 0;
ca6549af77f0f2 Steven Whitehouse  2006-03-23  714  	*num = 0;
ca6549af77f0f2 Steven Whitehouse  2006-03-23  715  
1ca7768c87ac13 Francesco Fondelli 2006-09-27  716  	for (; i < maxlen; i++) {
82fd5b5d1ec370 Andy Shevchenko    2010-09-20  717  		int value;
ca6549af77f0f2 Steven Whitehouse  2006-03-23  718  		char c;
ca6549af77f0f2 Steven Whitehouse  2006-03-23  719  		*num <<= 4;
ca6549af77f0f2 Steven Whitehouse  2006-03-23 @720  		if (get_user(c, &user_buffer[i]))
ca6549af77f0f2 Steven Whitehouse  2006-03-23  721  			return -EFAULT;
82fd5b5d1ec370 Andy Shevchenko    2010-09-20  722  		value = hex_to_bin(c);
82fd5b5d1ec370 Andy Shevchenko    2010-09-20  723  		if (value >= 0)
82fd5b5d1ec370 Andy Shevchenko    2010-09-20  724  			*num |= value;
ca6549af77f0f2 Steven Whitehouse  2006-03-23  725  		else
ca6549af77f0f2 Steven Whitehouse  2006-03-23  726  			break;
ca6549af77f0f2 Steven Whitehouse  2006-03-23  727  	}
ca6549af77f0f2 Steven Whitehouse  2006-03-23  728  	return i;
ca6549af77f0f2 Steven Whitehouse  2006-03-23  729  }
ca6549af77f0f2 Steven Whitehouse  2006-03-23  730  

:::::: The code at line 720 was first introduced by commit
:::::: ca6549af77f0f28ac5d23b662fb8f72713eb16d3 [PKTGEN]: Add MPLS extension.

:::::: TO: Steven Whitehouse <steve@chygwyn.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--9amGYk9869ThD9tj
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
/wFNtyUharcBAA==

--9amGYk9869ThD9tj--
