Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE20C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 03:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6563D20709
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 03:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgGXDbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 23:31:00 -0400
Received: from mga04.intel.com ([192.55.52.120]:37242 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726493AbgGXDbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 23:31:00 -0400
IronPort-SDR: 1/ISWEbi74hV7s3NfUrFKbpfMADP06rg/ZxlD3jkdKHjyNWMp81grZE3i5S1xX7i6SUw4NKvtU
 cqs0EFKqA9YQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="148145169"
X-IronPort-AV: E=Sophos;i="5.75,389,1589266800"; 
   d="gz'50?scan'50,208,50";a="148145169"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 20:17:49 -0700
IronPort-SDR: HDopoqai4YFRn0KOwSgrIFLmravkaz8bNch8dIdNYUytzruzjX4qjKBwe+KKgxlnCAXJLGws8r
 ndIOpPbI0zRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,389,1589266800"; 
   d="gz'50?scan'50,208,50";a="288860183"
Received: from lkp-server01.sh.intel.com (HELO df0563f96c37) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 23 Jul 2020 20:17:47 -0700
Received: from kbuild by df0563f96c37 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jyoDS-00001E-A4; Fri, 24 Jul 2020 03:17:46 +0000
Date:   Fri, 24 Jul 2020 11:17:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/powerpc/platforms/82xx/mpc8272_ads.c:163:9: sparse: sparse:
 incorrect type in argument 1 (different base types)
Message-ID: <202007241125.RZVTZiq9%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d15be546031cf65a0fc34879beca02fd90fe7ac7
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   5 weeks ago
config: powerpc-randconfig-s032-20200723 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-93-g4c6cbe55-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> arch/powerpc/platforms/82xx/mpc8272_ads.c:163:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem * @@
>> arch/powerpc/platforms/82xx/mpc8272_ads.c:163:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
>> arch/powerpc/platforms/82xx/mpc8272_ads.c:163:9: sparse:     got restricted __be32 [noderef] [usertype] __iomem *
>> arch/powerpc/platforms/82xx/mpc8272_ads.c:163:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem * @@
>> arch/powerpc/platforms/82xx/mpc8272_ads.c:163:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
>> arch/powerpc/platforms/82xx/mpc8272_ads.c:163:9: sparse:     got restricted __be32 [noderef] [usertype] __iomem *
   arch/powerpc/platforms/82xx/mpc8272_ads.c:164:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem * @@
   arch/powerpc/platforms/82xx/mpc8272_ads.c:164:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/82xx/mpc8272_ads.c:164:9: sparse:     got restricted __be32 [noderef] [usertype] __iomem *
   arch/powerpc/platforms/82xx/mpc8272_ads.c:164:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem * @@
   arch/powerpc/platforms/82xx/mpc8272_ads.c:164:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/82xx/mpc8272_ads.c:164:9: sparse:     got restricted __be32 [noderef] [usertype] __iomem *
   arch/powerpc/platforms/82xx/mpc8272_ads.c:166:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem * @@
   arch/powerpc/platforms/82xx/mpc8272_ads.c:166:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/82xx/mpc8272_ads.c:166:9: sparse:     got restricted __be32 [noderef] [usertype] __iomem *
   arch/powerpc/platforms/82xx/mpc8272_ads.c:166:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem * @@
   arch/powerpc/platforms/82xx/mpc8272_ads.c:166:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/82xx/mpc8272_ads.c:166:9: sparse:     got restricted __be32 [noderef] [usertype] __iomem *
   arch/powerpc/platforms/82xx/mpc8272_ads.c:167:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem * @@
   arch/powerpc/platforms/82xx/mpc8272_ads.c:167:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/82xx/mpc8272_ads.c:167:9: sparse:     got restricted __be32 [noderef] [usertype] __iomem *
   arch/powerpc/platforms/82xx/mpc8272_ads.c:167:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem * @@
   arch/powerpc/platforms/82xx/mpc8272_ads.c:167:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/82xx/mpc8272_ads.c:167:9: sparse:     got restricted __be32 [noderef] [usertype] __iomem *
   arch/powerpc/platforms/82xx/mpc8272_ads.c:169:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem * @@
   arch/powerpc/platforms/82xx/mpc8272_ads.c:169:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/82xx/mpc8272_ads.c:169:9: sparse:     got restricted __be32 [noderef] [usertype] __iomem *
   arch/powerpc/platforms/82xx/mpc8272_ads.c:169:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem * @@
   arch/powerpc/platforms/82xx/mpc8272_ads.c:169:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/82xx/mpc8272_ads.c:169:9: sparse:     got restricted __be32 [noderef] [usertype] __iomem *
--
>> arch/powerpc/platforms/82xx/pq2fads.c:140:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem * @@
>> arch/powerpc/platforms/82xx/pq2fads.c:140:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
>> arch/powerpc/platforms/82xx/pq2fads.c:140:9: sparse:     got restricted __be32 [noderef] [usertype] __iomem *
>> arch/powerpc/platforms/82xx/pq2fads.c:140:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem * @@
>> arch/powerpc/platforms/82xx/pq2fads.c:140:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
>> arch/powerpc/platforms/82xx/pq2fads.c:140:9: sparse:     got restricted __be32 [noderef] [usertype] __iomem *
   arch/powerpc/platforms/82xx/pq2fads.c:141:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem * @@
   arch/powerpc/platforms/82xx/pq2fads.c:141:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/82xx/pq2fads.c:141:9: sparse:     got restricted __be32 [noderef] [usertype] __iomem *
   arch/powerpc/platforms/82xx/pq2fads.c:141:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem * @@
   arch/powerpc/platforms/82xx/pq2fads.c:141:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/82xx/pq2fads.c:141:9: sparse:     got restricted __be32 [noderef] [usertype] __iomem *
   arch/powerpc/platforms/82xx/pq2fads.c:143:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem * @@
   arch/powerpc/platforms/82xx/pq2fads.c:143:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/82xx/pq2fads.c:143:9: sparse:     got restricted __be32 [noderef] [usertype] __iomem *
   arch/powerpc/platforms/82xx/pq2fads.c:143:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem * @@
   arch/powerpc/platforms/82xx/pq2fads.c:143:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/82xx/pq2fads.c:143:9: sparse:     got restricted __be32 [noderef] [usertype] __iomem *
   arch/powerpc/platforms/82xx/pq2fads.c:144:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem * @@
   arch/powerpc/platforms/82xx/pq2fads.c:144:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/82xx/pq2fads.c:144:9: sparse:     got restricted __be32 [noderef] [usertype] __iomem *
   arch/powerpc/platforms/82xx/pq2fads.c:144:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem * @@
   arch/powerpc/platforms/82xx/pq2fads.c:144:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/82xx/pq2fads.c:144:9: sparse:     got restricted __be32 [noderef] [usertype] __iomem *
--
>> drivers/net/ethernet/apple/mace.c:510:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int volatile [noderef] __iomem control @@     got restricted __le32 [usertype] @@
>> drivers/net/ethernet/apple/mace.c:510:17: sparse:     expected unsigned int volatile [noderef] __iomem control
   drivers/net/ethernet/apple/mace.c:510:17: sparse:     got restricted __le32 [usertype]
   drivers/net/ethernet/apple/mace.c:511:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int volatile [noderef] __iomem control @@     got restricted __le32 [usertype] @@
   drivers/net/ethernet/apple/mace.c:511:17: sparse:     expected unsigned int volatile [noderef] __iomem control
   drivers/net/ethernet/apple/mace.c:511:17: sparse:     got restricted __le32 [usertype]
>> drivers/net/ethernet/apple/mace.c:563:15: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __le16 volatile * @@
>> drivers/net/ethernet/apple/mace.c:563:15: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/apple/mace.c:563:15: sparse:     got restricted __le16 volatile *
   drivers/net/ethernet/apple/mace.c:569:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __le16 volatile * @@
   drivers/net/ethernet/apple/mace.c:569:19: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/apple/mace.c:569:19: sparse:     got restricted __le16 volatile *
   drivers/net/ethernet/apple/mace.c:570:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __le16 volatile * @@
   drivers/net/ethernet/apple/mace.c:570:19: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/apple/mace.c:570:19: sparse:     got restricted __le16 volatile *
   drivers/net/ethernet/apple/mace.c:692:17: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/apple/mace.c:692:17: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/apple/mace.c:692:17: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/apple/mace.c:692:17: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/apple/mace.c:692:17: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/apple/mace.c:692:17: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/apple/mace.c:692:17: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/apple/mace.c:790:23: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __le16 volatile * @@
   drivers/net/ethernet/apple/mace.c:790:23: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/apple/mace.c:790:23: sparse:     got restricted __le16 volatile *
   drivers/net/ethernet/apple/mace.c:791:23: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __le16 volatile * @@
   drivers/net/ethernet/apple/mace.c:791:23: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/apple/mace.c:791:23: sparse:     got restricted __le16 volatile *
   drivers/net/ethernet/apple/mace.c:904:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __le16 volatile * @@
   drivers/net/ethernet/apple/mace.c:904:19: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/apple/mace.c:904:19: sparse:     got restricted __le16 volatile *
   drivers/net/ethernet/apple/mace.c:966:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __le16 volatile * @@
   drivers/net/ethernet/apple/mace.c:966:19: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/apple/mace.c:966:19: sparse:     got restricted __le16 volatile *
   drivers/net/ethernet/apple/mace.c:967:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __le16 volatile * @@
   drivers/net/ethernet/apple/mace.c:967:19: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/apple/mace.c:967:19: sparse:     got restricted __le16 volatile *
   drivers/net/ethernet/apple/mace.c:831:22: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/apple/mace.c:831:22: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/apple/mace.c:831:22: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/apple/mace.c:831:22: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/apple/mace.c:831:22: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/apple/mace.c:831:22: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/apple/mace.c:831:22: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/apple/mace.c:833:15: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __le16 volatile * @@
   drivers/net/ethernet/apple/mace.c:833:15: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/apple/mace.c:833:15: sparse:     got restricted __le16 volatile *
   drivers/net/ethernet/apple/mace.c:853:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __le16 volatile * @@
   drivers/net/ethernet/apple/mace.c:853:19: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/apple/mace.c:853:19: sparse:     got restricted __le16 volatile *
   drivers/net/ethernet/apple/mace.c:854:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __le16 volatile * @@
   drivers/net/ethernet/apple/mace.c:854:19: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/apple/mace.c:854:19: sparse:     got restricted __le16 volatile *
   drivers/net/ethernet/apple/mace.c:313:13: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/apple/mace.c:313:13: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/apple/mace.c:313:13: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/apple/mace.c:313:13: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/apple/mace.c:313:13: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/apple/mace.c:313:13: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/apple/mace.c:313:13: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/apple/mace.c:313:13: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/apple/mace.c:313:13: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/apple/mace.c:692:17: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/apple/mace.c:692:17: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/apple/mace.c:831:22: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/apple/mace.c:831:22: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/apple/mace.c:831:22: sparse: sparse: dereference of noderef expression
--
>> drivers/net/ethernet/apple/bmac.c:1407:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int volatile [noderef] __iomem control @@     got restricted __le32 [usertype] @@
>> drivers/net/ethernet/apple/bmac.c:1407:21: sparse:     expected unsigned int volatile [noderef] __iomem control
   drivers/net/ethernet/apple/bmac.c:1407:21: sparse:     got restricted __le32 [usertype]
   drivers/net/ethernet/apple/bmac.c:1408:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int volatile [noderef] __iomem control @@     got restricted __le32 [usertype] @@
   drivers/net/ethernet/apple/bmac.c:1408:21: sparse:     expected unsigned int volatile [noderef] __iomem control
   drivers/net/ethernet/apple/bmac.c:1408:21: sparse:     got restricted __le32 [usertype]
   drivers/net/ethernet/apple/bmac.c:1502:26: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/apple/bmac.c:1502:26: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/apple/bmac.c:1502:26: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/apple/bmac.c:1502:26: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/apple/bmac.c:1502:26: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/apple/bmac.c:1502:26: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/apple/bmac.c:1502:26: sparse: sparse: dereference of noderef expression
>> drivers/net/ethernet/apple/bmac.c:1504:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __le16 volatile * @@
>> drivers/net/ethernet/apple/bmac.c:1504:19: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/apple/bmac.c:1504:19: sparse:     got restricted __le16 volatile *
   drivers/net/ethernet/apple/bmac.c:1523:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __le16 volatile * @@
   drivers/net/ethernet/apple/bmac.c:1523:27: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/apple/bmac.c:1523:27: sparse:     got restricted __le16 volatile *
   drivers/net/ethernet/apple/bmac.c:1524:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __le16 volatile * @@
   drivers/net/ethernet/apple/bmac.c:1524:27: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/apple/bmac.c:1524:27: sparse:     got restricted __le16 volatile *
   drivers/net/ethernet/apple/bmac.c:201:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __le16 volatile * @@
   drivers/net/ethernet/apple/bmac.c:201:19: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/apple/bmac.c:201:19: sparse:     got restricted __le16 volatile *
   drivers/net/ethernet/apple/bmac.c:202:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __le16 volatile * @@
   drivers/net/ethernet/apple/bmac.c:202:19: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/apple/bmac.c:202:19: sparse:     got restricted __le16 volatile *
>> drivers/net/ethernet/apple/bmac.c:203:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __le32 volatile * @@
>> drivers/net/ethernet/apple/bmac.c:203:19: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/apple/bmac.c:203:19: sparse:     got restricted __le32 volatile *
   drivers/net/ethernet/apple/bmac.c:204:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __le32 volatile * @@
   drivers/net/ethernet/apple/bmac.c:204:19: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/apple/bmac.c:204:19: sparse:     got restricted __le32 volatile *
   drivers/net/ethernet/apple/bmac.c:205:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __le16 volatile * @@
   drivers/net/ethernet/apple/bmac.c:205:19: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/apple/bmac.c:205:19: sparse:     got restricted __le16 volatile *
   drivers/net/ethernet/apple/bmac.c:206:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __le16 volatile * @@
   drivers/net/ethernet/apple/bmac.c:206:19: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/apple/bmac.c:206:19: sparse:     got restricted __le16 volatile *
   drivers/net/ethernet/apple/bmac.c:1502:26: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/apple/bmac.c:1502:26: sparse: sparse: dereference of noderef expression
   drivers/net/ethernet/apple/bmac.c:1502:26: sparse: sparse: dereference of noderef expression
--
>> drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c:95:31: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [noderef] [usertype] __iomem *p @@     got restricted __be32 [noderef] [usertype] __iomem *dat @@
>> drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c:95:31: sparse:     expected unsigned int [noderef] [usertype] __iomem *p
>> drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c:95:31: sparse:     got restricted __be32 [noderef] [usertype] __iomem *dat
   drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c:97:31: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [noderef] [usertype] __iomem *p @@     got restricted __be32 [noderef] [usertype] __iomem *dat @@
   drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c:97:31: sparse:     expected unsigned int [noderef] [usertype] __iomem *p
   drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c:97:31: sparse:     got restricted __be32 [noderef] [usertype] __iomem *dat
>> drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c:100:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *dat @@
>> drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c:100:24: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c:100:24: sparse:     got restricted __be32 [noderef] [usertype] __iomem *dat
   drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c:63:31: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [noderef] [usertype] __iomem *p @@     got restricted __be32 [noderef] [usertype] __iomem *dir @@
   drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c:63:31: sparse:     expected unsigned int [noderef] [usertype] __iomem *p
>> drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c:63:31: sparse:     got restricted __be32 [noderef] [usertype] __iomem *dir
   drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c:65:31: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [noderef] [usertype] __iomem *p @@     got restricted __be32 [noderef] [usertype] __iomem *dir @@
   drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c:65:31: sparse:     expected unsigned int [noderef] [usertype] __iomem *p
   drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c:65:31: sparse:     got restricted __be32 [noderef] [usertype] __iomem *dir
   drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c:68:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *dir @@
   drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c:68:24: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c:68:24: sparse:     got restricted __be32 [noderef] [usertype] __iomem *dir
   drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c:82:31: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [noderef] [usertype] __iomem *p @@     got restricted __be32 [noderef] [usertype] __iomem *dat @@
   drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c:82:31: sparse:     expected unsigned int [noderef] [usertype] __iomem *p
   drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c:82:31: sparse:     got restricted __be32 [noderef] [usertype] __iomem *dat
   drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c:84:31: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [noderef] [usertype] __iomem *p @@     got restricted __be32 [noderef] [usertype] __iomem *dat @@
   drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c:84:31: sparse:     expected unsigned int [noderef] [usertype] __iomem *p
   drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c:84:31: sparse:     got restricted __be32 [noderef] [usertype] __iomem *dat
   drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c:87:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *dat @@
   drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c:87:24: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c:87:24: sparse:     got restricted __be32 [noderef] [usertype] __iomem *dat
   drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c:74:31: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [noderef] [usertype] __iomem *p @@     got restricted __be32 [noderef] [usertype] __iomem *dat @@
   drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c:74:31: sparse:     expected unsigned int [noderef] [usertype] __iomem *p
   drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c:74:31: sparse:     got restricted __be32 [noderef] [usertype] __iomem *dat
--
>> drivers/net/ethernet/marvell/mv643xx_eth.c:1946:35: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct rx_desc *rx_desc_area @@     got void [noderef] __iomem * @@
   drivers/net/ethernet/marvell/mv643xx_eth.c:1946:35: sparse:     expected struct rx_desc *rx_desc_area
>> drivers/net/ethernet/marvell/mv643xx_eth.c:1946:35: sparse:     got void [noderef] __iomem *
>> drivers/net/ethernet/marvell/mv643xx_eth.c:1985:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got struct rx_desc *rx_desc_area @@
>> drivers/net/ethernet/marvell/mv643xx_eth.c:1985:28: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/marvell/mv643xx_eth.c:1985:28: sparse:     got struct rx_desc *rx_desc_area
   drivers/net/ethernet/marvell/mv643xx_eth.c:2016:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got struct rx_desc *rx_desc_area @@
   drivers/net/ethernet/marvell/mv643xx_eth.c:2016:28: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/marvell/mv643xx_eth.c:2016:28: sparse:     got struct rx_desc *rx_desc_area
>> drivers/net/ethernet/marvell/mv643xx_eth.c:2050:35: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct tx_desc *tx_desc_area @@     got void [noderef] __iomem * @@
   drivers/net/ethernet/marvell/mv643xx_eth.c:2050:35: sparse:     expected struct tx_desc *tx_desc_area
   drivers/net/ethernet/marvell/mv643xx_eth.c:2050:35: sparse:     got void [noderef] __iomem *
>> drivers/net/ethernet/marvell/mv643xx_eth.c:2105:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got struct tx_desc *tx_desc_area @@
   drivers/net/ethernet/marvell/mv643xx_eth.c:2105:28: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/marvell/mv643xx_eth.c:2105:28: sparse:     got struct tx_desc *tx_desc_area
   drivers/net/ethernet/marvell/mv643xx_eth.c:2123:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got struct tx_desc *tx_desc_area @@
   drivers/net/ethernet/marvell/mv643xx_eth.c:2123:28: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/marvell/mv643xx_eth.c:2123:28: sparse:     got struct tx_desc *tx_desc_area

vim +163 arch/powerpc/platforms/82xx/mpc8272_ads.c

a70e88bc78d220a arch/powerpc/platforms/82xx/mpc8272_ads.c Anton Vorontsov 2009-08-19  162  
e00c5498a2a6149 arch/powerpc/platforms/82xx/mpc8272_ads.c Scott Wood      2007-09-14 @163  	clrbits32(&bcsr[1], BCSR1_RS232_EN1 | BCSR1_RS232_EN2 | BCSR1_FETHIEN);
e00c5498a2a6149 arch/powerpc/platforms/82xx/mpc8272_ads.c Scott Wood      2007-09-14  164  	setbits32(&bcsr[1], BCSR1_FETH_RST);
91bd61099defb28 arch/powerpc/platforms/82xx/mpc82xx_ads.c Vitaly Bordug   2006-10-02  165  
e00c5498a2a6149 arch/powerpc/platforms/82xx/mpc8272_ads.c Scott Wood      2007-09-14  166  	clrbits32(&bcsr[3], BCSR3_FETHIEN2);
e00c5498a2a6149 arch/powerpc/platforms/82xx/mpc8272_ads.c Scott Wood      2007-09-14  167  	setbits32(&bcsr[3], BCSR3_FETH2_RST);
91bd61099defb28 arch/powerpc/platforms/82xx/mpc82xx_ads.c Vitaly Bordug   2006-10-02  168  
818fcac554397a0 arch/powerpc/platforms/82xx/mpc8272_ads.c Anton Vorontsov 2009-08-19  169  	clrbits32(&bcsr[3], BCSR3_USB_nEN);
818fcac554397a0 arch/powerpc/platforms/82xx/mpc8272_ads.c Anton Vorontsov 2009-08-19  170  
e00c5498a2a6149 arch/powerpc/platforms/82xx/mpc8272_ads.c Scott Wood      2007-09-14  171  	iounmap(bcsr);
91bd61099defb28 arch/powerpc/platforms/82xx/mpc82xx_ads.c Vitaly Bordug   2006-10-02  172  
e00c5498a2a6149 arch/powerpc/platforms/82xx/mpc8272_ads.c Scott Wood      2007-09-14  173  	init_ioports();
e00c5498a2a6149 arch/powerpc/platforms/82xx/mpc8272_ads.c Scott Wood      2007-09-14  174  	pq2_init_pci();
91bd61099defb28 arch/powerpc/platforms/82xx/mpc82xx_ads.c Vitaly Bordug   2006-10-02  175  
e00c5498a2a6149 arch/powerpc/platforms/82xx/mpc8272_ads.c Scott Wood      2007-09-14  176  	if (ppc_md.progress)
e00c5498a2a6149 arch/powerpc/platforms/82xx/mpc8272_ads.c Scott Wood      2007-09-14  177  		ppc_md.progress("mpc8272_ads_setup_arch(), finish", 0);
91bd61099defb28 arch/powerpc/platforms/82xx/mpc82xx_ads.c Vitaly Bordug   2006-10-02  178  }
91bd61099defb28 arch/powerpc/platforms/82xx/mpc82xx_ads.c Vitaly Bordug   2006-10-02  179  

:::::: The code at line 163 was first introduced by commit
:::::: e00c5498a2a614931cbb7d88a53979d5d47594e1 [POWERPC] mpc82xx: Update mpc8272ads, and factor out PCI and reset.

:::::: TO: Scott Wood <scottwood@freescale.com>
:::::: CC: Kumar Gala <galak@kernel.crashing.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--cWoXeonUoKmBZSoM
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--cWoXeonUoKmBZSoM--
