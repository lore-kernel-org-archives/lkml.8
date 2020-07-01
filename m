Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8C4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 21:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 367F9206A1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 21:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgGAVu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 17:50:27 -0400
Received: from mga03.intel.com ([134.134.136.65]:49423 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgGAVuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 17:50:25 -0400
IronPort-SDR: uaLCEVt2zXkF4sg2PID6wbcq3R8DmK6ro+YdD3C0sOyoh78Ik31JxAXl/kpuc2XRN0lQuWz7B7
 zbM9Hisa4wIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="146706671"
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; 
   d="gz'50?scan'50,208,50";a="146706671"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 14:43:57 -0700
IronPort-SDR: tolwaTzYmHTFGDvn4vHphZlFi5FSffVRGs753WScfO2RyvnHSOfrXpCDqQ0+Nkp+xAgt+B6oXy
 l3XSYykPhmdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; 
   d="gz'50?scan'50,208,50";a="321335715"
Received: from lkp-server01.sh.intel.com (HELO 28879958b202) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Jul 2020 14:43:54 -0700
Received: from kbuild by 28879958b202 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jqkWI-0003LG-23; Wed, 01 Jul 2020 21:43:54 +0000
Date:   Thu, 2 Jul 2020 05:43:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/powerpc/sysdev/fsl_rcpm.c:32:9: sparse: sparse: incorrect type
 in argument 1 (different base types)
Message-ID: <202007020529.WtdJUaru%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7c30b859a947535f2213277e827d7ac7dcff9c84
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   13 days ago
config: powerpc64-randconfig-s032-20200701 (attached as .config)
compiler: powerpc64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-3-gfa153962-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> arch/powerpc/sysdev/fsl_rcpm.c:32:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
>> arch/powerpc/sysdev/fsl_rcpm.c:32:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
>> arch/powerpc/sysdev/fsl_rcpm.c:32:9: sparse:     got restricted __be32 [noderef] __iomem *
>> arch/powerpc/sysdev/fsl_rcpm.c:32:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
>> arch/powerpc/sysdev/fsl_rcpm.c:32:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
>> arch/powerpc/sysdev/fsl_rcpm.c:32:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:33:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:33:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:33:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:33:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:33:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:33:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:34:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:34:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:34:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:34:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:34:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:34:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:35:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:35:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:35:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:35:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:35:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:35:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:43:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:43:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:43:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:43:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:43:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:43:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:44:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:44:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:44:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:44:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:44:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:44:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:45:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:45:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:45:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:45:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:45:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:45:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:46:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:46:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:46:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:46:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:46:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:46:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:54:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:54:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:54:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:54:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:54:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:54:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:55:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:55:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:55:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:55:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:55:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:55:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:56:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:56:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:56:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:56:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:56:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:56:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:57:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:57:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:57:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:57:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:57:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:57:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:65:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:65:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:65:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:65:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:65:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:65:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:66:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:66:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:66:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:66:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:66:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:66:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:67:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:67:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:67:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:67:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:67:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:67:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:68:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:68:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:68:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:68:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:68:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:68:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:74:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:74:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:74:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:74:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:74:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:74:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:76:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:76:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:76:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:76:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:76:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:76:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:82:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:82:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:82:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:82:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:82:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:82:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:84:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:84:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:84:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:84:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:84:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:84:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:94:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:94:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:94:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:94:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:94:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:94:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:97:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:97:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:97:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:97:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:97:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:97:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:113:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:113:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:113:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:113:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:113:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:113:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:116:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:116:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:116:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:116:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:116:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:116:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:119:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:119:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:119:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:119:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:119:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:119:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:122:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:122:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:122:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:122:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:122:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:122:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:171:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:171:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:171:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:171:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:171:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:171:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:174:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:174:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:174:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:174:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:174:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:174:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:195:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:195:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:195:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:195:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:195:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:195:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:198:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:198:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:198:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:198:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:198:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:198:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:201:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:201:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:201:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:201:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:201:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:201:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:204:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:204:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:204:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:204:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:204:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:204:17: sparse:     got restricted __be32 [noderef] __iomem *
>> arch/powerpc/sysdev/fsl_rcpm.c:219:27: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] *pmcsr_reg @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:219:27: sparse:     expected unsigned int [usertype] *pmcsr_reg
   arch/powerpc/sysdev/fsl_rcpm.c:219:27: sparse:     got restricted __be32 [noderef] __iomem *
>> arch/powerpc/sysdev/fsl_rcpm.c:225:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got unsigned int [usertype] *pmcsr_reg @@
   arch/powerpc/sysdev/fsl_rcpm.c:225:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:225:17: sparse:     got unsigned int [usertype] *pmcsr_reg
>> arch/powerpc/sysdev/fsl_rcpm.c:225:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got unsigned int [usertype] *pmcsr_reg @@
   arch/powerpc/sysdev/fsl_rcpm.c:225:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:225:17: sparse:     got unsigned int [usertype] *pmcsr_reg
   arch/powerpc/sysdev/fsl_rcpm.c:228:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got unsigned int [usertype] *pmcsr_reg @@
   arch/powerpc/sysdev/fsl_rcpm.c:228:26: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:228:26: sparse:     got unsigned int [usertype] *pmcsr_reg
   arch/powerpc/sysdev/fsl_rcpm.c:228:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got unsigned int [usertype] *pmcsr_reg @@
   arch/powerpc/sysdev/fsl_rcpm.c:228:26: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:228:26: sparse:     got unsigned int [usertype] *pmcsr_reg
   arch/powerpc/sysdev/fsl_rcpm.c:228:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got unsigned int [usertype] *pmcsr_reg @@
   arch/powerpc/sysdev/fsl_rcpm.c:228:26: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:228:26: sparse:     got unsigned int [usertype] *pmcsr_reg
   arch/powerpc/sysdev/fsl_rcpm.c:228:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got unsigned int [usertype] *pmcsr_reg @@
   arch/powerpc/sysdev/fsl_rcpm.c:228:26: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:228:26: sparse:     got unsigned int [usertype] *pmcsr_reg
   arch/powerpc/sysdev/fsl_rcpm.c:245:27: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] *pmcsr_reg @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:245:27: sparse:     expected unsigned int [usertype] *pmcsr_reg
   arch/powerpc/sysdev/fsl_rcpm.c:245:27: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:252:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got unsigned int [usertype] *pmcsr_reg @@
   arch/powerpc/sysdev/fsl_rcpm.c:252:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:252:17: sparse:     got unsigned int [usertype] *pmcsr_reg
   arch/powerpc/sysdev/fsl_rcpm.c:252:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got unsigned int [usertype] *pmcsr_reg @@
   arch/powerpc/sysdev/fsl_rcpm.c:252:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:252:17: sparse:     got unsigned int [usertype] *pmcsr_reg
   arch/powerpc/sysdev/fsl_rcpm.c:254:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got unsigned int [usertype] *pmcsr_reg @@
   arch/powerpc/sysdev/fsl_rcpm.c:254:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:254:17: sparse:     got unsigned int [usertype] *pmcsr_reg
   arch/powerpc/sysdev/fsl_rcpm.c:254:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got unsigned int [usertype] *pmcsr_reg @@
   arch/powerpc/sysdev/fsl_rcpm.c:254:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:254:17: sparse:     got unsigned int [usertype] *pmcsr_reg
   arch/powerpc/sysdev/fsl_rcpm.c:259:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got unsigned int [usertype] *pmcsr_reg @@
   arch/powerpc/sysdev/fsl_rcpm.c:259:26: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:259:26: sparse:     got unsigned int [usertype] *pmcsr_reg
   arch/powerpc/sysdev/fsl_rcpm.c:259:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got unsigned int [usertype] *pmcsr_reg @@
   arch/powerpc/sysdev/fsl_rcpm.c:259:26: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:259:26: sparse:     got unsigned int [usertype] *pmcsr_reg
   arch/powerpc/sysdev/fsl_rcpm.c:259:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got unsigned int [usertype] *pmcsr_reg @@
   arch/powerpc/sysdev/fsl_rcpm.c:259:26: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:259:26: sparse:     got unsigned int [usertype] *pmcsr_reg
   arch/powerpc/sysdev/fsl_rcpm.c:259:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got unsigned int [usertype] *pmcsr_reg @@
   arch/powerpc/sysdev/fsl_rcpm.c:259:26: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:259:26: sparse:     got unsigned int [usertype] *pmcsr_reg
>> arch/powerpc/sysdev/fsl_rcpm.c:289:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got unsigned int [usertype] *tben_reg @@
   arch/powerpc/sysdev/fsl_rcpm.c:289:32: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:289:32: sparse:     got unsigned int [usertype] *tben_reg
>> arch/powerpc/sysdev/fsl_rcpm.c:290:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got unsigned int [usertype] *tben_reg @@
   arch/powerpc/sysdev/fsl_rcpm.c:290:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:290:17: sparse:     got unsigned int [usertype] *tben_reg
   arch/powerpc/sysdev/fsl_rcpm.c:290:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got unsigned int [usertype] *tben_reg @@
   arch/powerpc/sysdev/fsl_rcpm.c:290:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:290:17: sparse:     got unsigned int [usertype] *tben_reg
   arch/powerpc/sysdev/fsl_rcpm.c:292:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got unsigned int [usertype] *tben_reg @@
   arch/powerpc/sysdev/fsl_rcpm.c:292:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:292:17: sparse:     got unsigned int [usertype] *tben_reg
   arch/powerpc/sysdev/fsl_rcpm.c:292:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got unsigned int [usertype] *tben_reg @@
   arch/powerpc/sysdev/fsl_rcpm.c:292:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:292:17: sparse:     got unsigned int [usertype] *tben_reg
   arch/powerpc/sysdev/fsl_rcpm.c:296:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got unsigned int [usertype] *tben_reg @@
   arch/powerpc/sysdev/fsl_rcpm.c:296:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_rcpm.c:296:17: sparse:     got unsigned int [usertype] *tben_reg
>> arch/powerpc/sysdev/fsl_rcpm.c:301:39: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] *tben_reg @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:301:39: sparse:     expected unsigned int [usertype] *tben_reg
   arch/powerpc/sysdev/fsl_rcpm.c:301:39: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_rcpm.c:306:39: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] *tben_reg @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_rcpm.c:306:39: sparse:     expected unsigned int [usertype] *tben_reg
   arch/powerpc/sysdev/fsl_rcpm.c:306:39: sparse:     got restricted __be32 [noderef] __iomem *
--
>> arch/powerpc/sysdev/fsl_soc.c:163:18: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *static [toplevel] rstcr @@
>> arch/powerpc/sysdev/fsl_soc.c:163:18: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
>> arch/powerpc/sysdev/fsl_soc.c:163:18: sparse:     got restricted __be32 [noderef] [usertype] __iomem *static [toplevel] rstcr
--
>> arch/powerpc/sysdev/fsl_pci.c:79:52: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct ccsr_pci [noderef] __iomem *pci @@     got void *private_data @@
>> arch/powerpc/sysdev/fsl_pci.c:79:52: sparse:     expected struct ccsr_pci [noderef] __iomem *pci
   arch/powerpc/sysdev/fsl_pci.c:79:52: sparse:     got void *private_data
>> arch/powerpc/sysdev/fsl_pci.c:81:33: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
>> arch/powerpc/sysdev/fsl_pci.c:81:33: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
>> arch/powerpc/sysdev/fsl_pci.c:81:33: sparse:     got restricted __be32 [noderef] __iomem *
>> arch/powerpc/sysdev/fsl_pci.c:166:35: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
>> arch/powerpc/sysdev/fsl_pci.c:166:35: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_pci.c:166:35: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_pci.c:167:35: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_pci.c:167:35: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_pci.c:167:35: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_pci.c:168:35: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_pci.c:168:35: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_pci.c:168:35: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_pci.c:169:35: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_pci.c:169:35: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_pci.c:169:35: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_pci.c:195:44: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct ccsr_pci [noderef] __iomem *pci @@     got void *private_data @@
   arch/powerpc/sysdev/fsl_pci.c:195:44: sparse:     expected struct ccsr_pci [noderef] __iomem *pci
   arch/powerpc/sysdev/fsl_pci.c:195:44: sparse:     got void *private_data
   arch/powerpc/sysdev/fsl_pci.c:229:30: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_pci.c:229:30: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_pci.c:229:30: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_pci.c:238:35: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_pci.c:238:35: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_pci.c:238:35: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_pci.c:242:43: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_pci.c:242:43: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_pci.c:242:43: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_pci.c:274:43: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_pci.c:274:43: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_pci.c:274:43: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_pci.c:275:43: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_pci.c:275:43: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_pci.c:275:43: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_pci.c:276:43: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_pci.c:276:43: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_pci.c:276:43: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_pci.c:278:43: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_pci.c:278:43: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_pci.c:278:43: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_pci.c:332:44: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __be64 const [usertype] *p @@     got unsigned long long const [usertype] *[assigned] reg @@
   arch/powerpc/sysdev/fsl_pci.c:332:44: sparse:     expected restricted __be64 const [usertype] *p
   arch/powerpc/sysdev/fsl_pci.c:332:44: sparse:     got unsigned long long const [usertype] *[assigned] reg
   arch/powerpc/sysdev/fsl_pci.c:361:43: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_pci.c:361:43: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_pci.c:361:43: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_pci.c:362:43: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_pci.c:362:43: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_pci.c:362:43: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_pci.c:363:43: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_pci.c:363:43: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_pci.c:363:43: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_pci.c:387:51: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_pci.c:387:51: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_pci.c:387:51: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_pci.c:388:51: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_pci.c:388:51: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_pci.c:388:51: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_pci.c:390:51: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_pci.c:390:51: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_pci.c:390:51: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_pci.c:392:51: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_pci.c:392:51: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_pci.c:392:51: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_pci.c:408:43: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_pci.c:408:43: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_pci.c:408:43: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_pci.c:409:43: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_pci.c:409:43: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_pci.c:409:43: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_pci.c:410:43: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_pci.c:410:43: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_pci.c:410:43: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_pci.c:423:51: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_pci.c:423:51: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_pci.c:423:51: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_pci.c:425:51: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_pci.c:425:51: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_pci.c:425:51: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/sysdev/fsl_pci.c:427:51: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_pci.c:427:51: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_pci.c:427:51: sparse:     got restricted __be32 [noderef] __iomem *
>> arch/powerpc/sysdev/fsl_pci.c:562:34: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *private_data @@     got void [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_pci.c:562:34: sparse:     expected void *private_data
>> arch/powerpc/sysdev/fsl_pci.c:562:34: sparse:     got void [noderef] __iomem *
   arch/powerpc/sysdev/fsl_pci.c:569:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/sysdev/fsl_pci.c:569:22: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/sysdev/fsl_pci.c:569:22: sparse:     got restricted __be32 [noderef] __iomem *
>> arch/powerpc/sysdev/fsl_pci.c:640:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *private_data @@
>> arch/powerpc/sysdev/fsl_pci.c:640:21: sparse:     expected void volatile [noderef] __iomem *addr
   arch/powerpc/sysdev/fsl_pci.c:640:21: sparse:     got void *private_data
--
>> drivers/video/fbdev/fsl-diu-fb.c:497:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got unsigned int [usertype] *reg @@
>> drivers/video/fbdev/fsl-diu-fb.c:497:26: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:497:26: sparse:     got unsigned int [usertype] *reg
>> drivers/video/fbdev/fsl-diu-fb.c:496:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got unsigned int [usertype] *reg @@
>> drivers/video/fbdev/fsl-diu-fb.c:496:26: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:496:26: sparse:     got unsigned int [usertype] *reg
   drivers/video/fbdev/fsl-diu-fb.c:493:6: sparse: sparse: symbol 'wr_reg_wa' was not declared. Should it be static?
>> drivers/video/fbdev/fsl-diu-fb.c:509:36: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] *reg @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:509:36: sparse:     expected unsigned int [usertype] *reg
>> drivers/video/fbdev/fsl-diu-fb.c:509:36: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:513:29: sparse: sparse: restricted __be32 degrades to integer
   drivers/video/fbdev/fsl-diu-fb.c:519:44: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] *reg @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:519:44: sparse:     expected unsigned int [usertype] *reg
   drivers/video/fbdev/fsl-diu-fb.c:519:44: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:524:29: sparse: sparse: restricted __be32 degrades to integer
   drivers/video/fbdev/fsl-diu-fb.c:530:44: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] *reg @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:530:44: sparse:     expected unsigned int [usertype] *reg
   drivers/video/fbdev/fsl-diu-fb.c:530:44: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:536:29: sparse: sparse: restricted __be32 degrades to integer
   drivers/video/fbdev/fsl-diu-fb.c:537:44: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] *reg @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:537:44: sparse:     expected unsigned int [usertype] *reg
   drivers/video/fbdev/fsl-diu-fb.c:537:44: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:544:29: sparse: sparse: restricted __be32 degrades to integer
   drivers/video/fbdev/fsl-diu-fb.c:545:44: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] *reg @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:545:44: sparse:     expected unsigned int [usertype] *reg
   drivers/video/fbdev/fsl-diu-fb.c:545:44: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:561:36: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] *reg @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:561:36: sparse:     expected unsigned int [usertype] *reg
   drivers/video/fbdev/fsl-diu-fb.c:561:36: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:566:44: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] *reg @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:566:44: sparse:     expected unsigned int [usertype] *reg
   drivers/video/fbdev/fsl-diu-fb.c:566:44: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:569:44: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] *reg @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:569:44: sparse:     expected unsigned int [usertype] *reg
   drivers/video/fbdev/fsl-diu-fb.c:569:44: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:575:44: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] *reg @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:575:44: sparse:     expected unsigned int [usertype] *reg
   drivers/video/fbdev/fsl-diu-fb.c:575:44: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:578:44: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] *reg @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:578:44: sparse:     expected unsigned int [usertype] *reg
   drivers/video/fbdev/fsl-diu-fb.c:578:44: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:583:29: sparse: sparse: restricted __be32 degrades to integer
   drivers/video/fbdev/fsl-diu-fb.c:589:44: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] *reg @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:589:44: sparse:     expected unsigned int [usertype] *reg
   drivers/video/fbdev/fsl-diu-fb.c:589:44: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:594:29: sparse: sparse: restricted __be32 degrades to integer
   drivers/video/fbdev/fsl-diu-fb.c:600:44: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] *reg @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:600:44: sparse:     expected unsigned int [usertype] *reg
   drivers/video/fbdev/fsl-diu-fb.c:600:44: sparse:     got restricted __be32 [noderef] __iomem *
>> drivers/video/fbdev/fsl-diu-fb.c:612:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:612:19: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:612:19: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:621:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:621:19: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:621:19: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:829:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:829:19: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:829:19: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:831:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:831:19: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:831:19: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:832:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:832:19: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:832:19: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:839:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:839:19: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:839:19: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:845:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:845:19: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:845:19: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:861:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:861:19: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:861:19: sparse:     got restricted __be32 [noderef] __iomem *
>> drivers/video/fbdev/fsl-diu-fb.c:879:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __iomem *screen_base @@     got void *[assigned] p @@
>> drivers/video/fbdev/fsl-diu-fb.c:879:27: sparse:     expected char [noderef] __iomem *screen_base
   drivers/video/fbdev/fsl-diu-fb.c:879:27: sparse:     got void *[assigned] p
>> drivers/video/fbdev/fsl-diu-fb.c:880:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile *address @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/fsl-diu-fb.c:880:49: sparse:     expected void volatile *address
>> drivers/video/fbdev/fsl-diu-fb.c:880:49: sparse:     got char [noderef] __iomem *screen_base
>> drivers/video/fbdev/fsl-diu-fb.c:890:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void *p @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/fsl-diu-fb.c:890:23: sparse:     expected void *p
   drivers/video/fbdev/fsl-diu-fb.c:890:23: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/fsl-diu-fb.c:959:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned int @@     got restricted __le32 [usertype] @@
   drivers/video/fbdev/fsl-diu-fb.c:959:24: sparse:     expected unsigned int
   drivers/video/fbdev/fsl-diu-fb.c:959:24: sparse:     got restricted __le32 [usertype]
   drivers/video/fbdev/fsl-diu-fb.c:962:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned int @@     got restricted __le32 [usertype] @@
   drivers/video/fbdev/fsl-diu-fb.c:962:24: sparse:     expected unsigned int
   drivers/video/fbdev/fsl-diu-fb.c:962:24: sparse:     got restricted __le32 [usertype]
   drivers/video/fbdev/fsl-diu-fb.c:965:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned int @@     got restricted __le32 [usertype] @@
   drivers/video/fbdev/fsl-diu-fb.c:965:24: sparse:     expected unsigned int
   drivers/video/fbdev/fsl-diu-fb.c:965:24: sparse:     got restricted __le32 [usertype]
   drivers/video/fbdev/fsl-diu-fb.c:1051:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:1051:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:1051:27: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:1112:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:1112:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:1112:27: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:1114:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:1114:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:1114:27: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:1154:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] pix_fmt @@     got unsigned int @@
   drivers/video/fbdev/fsl-diu-fb.c:1154:29: sparse:     expected restricted __be32 [usertype] pix_fmt
   drivers/video/fbdev/fsl-diu-fb.c:1154:29: sparse:     got unsigned int
   drivers/video/fbdev/fsl-diu-fb.c:1157:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] pix_fmt @@     got unsigned int @@
   drivers/video/fbdev/fsl-diu-fb.c:1157:29: sparse:     expected restricted __be32 [usertype] pix_fmt
   drivers/video/fbdev/fsl-diu-fb.c:1157:29: sparse:     got unsigned int
   drivers/video/fbdev/fsl-diu-fb.c:1160:32: sparse: sparse: restricted __le32 degrades to integer
   drivers/video/fbdev/fsl-diu-fb.c:1160:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] src_size_g_alpha @@     got unsigned int @@
   drivers/video/fbdev/fsl-diu-fb.c:1160:30: sparse:     expected restricted __le32 [usertype] src_size_g_alpha
   drivers/video/fbdev/fsl-diu-fb.c:1160:30: sparse:     got unsigned int
   drivers/video/fbdev/fsl-diu-fb.c:1294:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] pix_fmt @@     got unsigned int [addressable] [usertype] pix_fmt @@
   drivers/video/fbdev/fsl-diu-fb.c:1294:29: sparse:     expected restricted __be32 [usertype] pix_fmt
   drivers/video/fbdev/fsl-diu-fb.c:1294:29: sparse:     got unsigned int [addressable] [usertype] pix_fmt
   drivers/video/fbdev/fsl-diu-fb.c:1302:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [addressable] [usertype] pix_fmt @@     got restricted __be32 [usertype] pix_fmt @@
   drivers/video/fbdev/fsl-diu-fb.c:1302:25: sparse:     expected unsigned int [addressable] [usertype] pix_fmt
   drivers/video/fbdev/fsl-diu-fb.c:1302:25: sparse:     got restricted __be32 [usertype] pix_fmt
   drivers/video/fbdev/fsl-diu-fb.c:1329:43: sparse: sparse: restricted __le32 degrades to integer
   drivers/video/fbdev/fsl-diu-fb.c:1329:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] src_size_g_alpha @@     got unsigned int @@
   drivers/video/fbdev/fsl-diu-fb.c:1329:38: sparse:     expected restricted __le32 [usertype] src_size_g_alpha
   drivers/video/fbdev/fsl-diu-fb.c:1329:38: sparse:     got unsigned int
   drivers/video/fbdev/fsl-diu-fb.c:1445:39: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:1445:39: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:1445:39: sparse:     got restricted __be32 [noderef] __iomem *
>> drivers/video/fbdev/fsl-diu-fb.c:1582:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct diu [noderef] __iomem *hw @@     got void *dev_id @@
>> drivers/video/fbdev/fsl-diu-fb.c:1582:34: sparse:     expected struct diu [noderef] __iomem *hw
   drivers/video/fbdev/fsl-diu-fb.c:1582:34: sparse:     got void *dev_id
>> drivers/video/fbdev/fsl-diu-fb.c:1583:36: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:1583:36: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:1583:36: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:1588:35: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:1588:35: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:1588:35: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:1590:35: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:1590:35: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:1590:35: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:1763:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] pix_fmt @@     got unsigned int @@
   drivers/video/fbdev/fsl-diu-fb.c:1763:32: sparse:     expected restricted __be32 [usertype] pix_fmt
   drivers/video/fbdev/fsl-diu-fb.c:1763:32: sparse:     got unsigned int
   drivers/video/fbdev/fsl-diu-fb.c:1775:26: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:1775:26: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:1775:26: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:1776:46: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:1776:46: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:1776:46: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:1778:38: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:1778:38: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:1778:38: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:1779:38: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:1779:38: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:1779:38: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:1785:23: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:1785:23: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:1785:23: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:1786:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:1786:22: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:1786:22: sparse:     got restricted __be32 [noderef] __iomem *
>> drivers/video/fbdev/fsl-diu-fb.c:1789:31: sparse: sparse: incorrect type in argument 5 (different address spaces) @@     expected void *dev @@     got struct diu [noderef] __iomem *diu_reg @@
   drivers/video/fbdev/fsl-diu-fb.c:1789:31: sparse:     expected void *dev
>> drivers/video/fbdev/fsl-diu-fb.c:1789:31: sparse:     got struct diu [noderef] __iomem *diu_reg
>> drivers/video/fbdev/fsl-diu-fb.c:1799:49: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void * @@     got struct diu [noderef] __iomem *diu_reg @@
   drivers/video/fbdev/fsl-diu-fb.c:1799:49: sparse:     expected void *
   drivers/video/fbdev/fsl-diu-fb.c:1799:49: sparse:     got struct diu [noderef] __iomem *diu_reg
   drivers/video/fbdev/fsl-diu-fb.c:1835:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void * @@     got struct diu [noderef] __iomem *diu_reg @@
   drivers/video/fbdev/fsl-diu-fb.c:1835:33: sparse:     expected void *
   drivers/video/fbdev/fsl-diu-fb.c:1835:33: sparse:     got struct diu [noderef] __iomem *diu_reg
   drivers/video/fbdev/fsl-diu-fb.c:513:29: sparse: sparse: dereference of noderef expression
   drivers/video/fbdev/fsl-diu-fb.c:524:29: sparse: sparse: dereference of noderef expression
   drivers/video/fbdev/fsl-diu-fb.c:536:29: sparse: sparse: dereference of noderef expression
   drivers/video/fbdev/fsl-diu-fb.c:544:29: sparse: sparse: dereference of noderef expression
   drivers/video/fbdev/fsl-diu-fb.c:583:29: sparse: sparse: dereference of noderef expression
   drivers/video/fbdev/fsl-diu-fb.c:594:29: sparse: sparse: dereference of noderef expression
   drivers/video/fbdev/fsl-diu-fb.c:1392:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:1392:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:1392:9: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:1392:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:1392:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:1392:9: sparse:     got restricted __be32 [noderef] __iomem *
--
>> drivers/net/ethernet/freescale/fsl_pq_mdio.c:214:41: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/ethernet/freescale/fsl_pq_mdio.c:214:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *p @@     got struct gfar * @@
>> drivers/net/ethernet/freescale/fsl_pq_mdio.c:214:41: sparse:     expected void [noderef] __iomem *p
   drivers/net/ethernet/freescale/fsl_pq_mdio.c:214:41: sparse:     got struct gfar *
   drivers/net/ethernet/freescale/fsl_pq_mdio.c:396:22: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/freescale/fsl_pq_mdio.c:396:35: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/net/ethernet/freescale/fsl_pq_mdio.c:396:35: sparse:    void *
>> drivers/net/ethernet/freescale/fsl_pq_mdio.c:396:35: sparse:    void [noderef] __iomem *
   drivers/net/ethernet/freescale/fsl_pq_mdio.c:397:25: sparse: sparse: subtraction of different types can't work (different address spaces)

vim +32 arch/powerpc/sysdev/fsl_rcpm.c

d17799f9c10e283 chenhui zhao 2015-11-20   26  
d17799f9c10e283 chenhui zhao 2015-11-20   27  static void rcpm_v1_irq_mask(int cpu)
d17799f9c10e283 chenhui zhao 2015-11-20   28  {
d17799f9c10e283 chenhui zhao 2015-11-20   29  	int hw_cpu = get_hard_smp_processor_id(cpu);
d17799f9c10e283 chenhui zhao 2015-11-20   30  	unsigned int mask = 1 << hw_cpu;
d17799f9c10e283 chenhui zhao 2015-11-20   31  
d17799f9c10e283 chenhui zhao 2015-11-20  @32  	setbits32(&rcpm_v1_regs->cpmimr, mask);
d17799f9c10e283 chenhui zhao 2015-11-20   33  	setbits32(&rcpm_v1_regs->cpmcimr, mask);
d17799f9c10e283 chenhui zhao 2015-11-20   34  	setbits32(&rcpm_v1_regs->cpmmcmr, mask);
d17799f9c10e283 chenhui zhao 2015-11-20   35  	setbits32(&rcpm_v1_regs->cpmnmimr, mask);
d17799f9c10e283 chenhui zhao 2015-11-20   36  }
d17799f9c10e283 chenhui zhao 2015-11-20   37  
d17799f9c10e283 chenhui zhao 2015-11-20   38  static void rcpm_v2_irq_mask(int cpu)
d17799f9c10e283 chenhui zhao 2015-11-20   39  {
d17799f9c10e283 chenhui zhao 2015-11-20   40  	int hw_cpu = get_hard_smp_processor_id(cpu);
d17799f9c10e283 chenhui zhao 2015-11-20   41  	unsigned int mask = 1 << hw_cpu;
d17799f9c10e283 chenhui zhao 2015-11-20   42  
d17799f9c10e283 chenhui zhao 2015-11-20   43  	setbits32(&rcpm_v2_regs->tpmimr0, mask);
d17799f9c10e283 chenhui zhao 2015-11-20   44  	setbits32(&rcpm_v2_regs->tpmcimr0, mask);
d17799f9c10e283 chenhui zhao 2015-11-20   45  	setbits32(&rcpm_v2_regs->tpmmcmr0, mask);
d17799f9c10e283 chenhui zhao 2015-11-20   46  	setbits32(&rcpm_v2_regs->tpmnmimr0, mask);
d17799f9c10e283 chenhui zhao 2015-11-20   47  }
d17799f9c10e283 chenhui zhao 2015-11-20   48  
d17799f9c10e283 chenhui zhao 2015-11-20   49  static void rcpm_v1_irq_unmask(int cpu)
d17799f9c10e283 chenhui zhao 2015-11-20   50  {
d17799f9c10e283 chenhui zhao 2015-11-20   51  	int hw_cpu = get_hard_smp_processor_id(cpu);
d17799f9c10e283 chenhui zhao 2015-11-20   52  	unsigned int mask = 1 << hw_cpu;
d17799f9c10e283 chenhui zhao 2015-11-20   53  
d17799f9c10e283 chenhui zhao 2015-11-20   54  	clrbits32(&rcpm_v1_regs->cpmimr, mask);
d17799f9c10e283 chenhui zhao 2015-11-20   55  	clrbits32(&rcpm_v1_regs->cpmcimr, mask);
d17799f9c10e283 chenhui zhao 2015-11-20   56  	clrbits32(&rcpm_v1_regs->cpmmcmr, mask);
d17799f9c10e283 chenhui zhao 2015-11-20   57  	clrbits32(&rcpm_v1_regs->cpmnmimr, mask);
d17799f9c10e283 chenhui zhao 2015-11-20   58  }
d17799f9c10e283 chenhui zhao 2015-11-20   59  
d17799f9c10e283 chenhui zhao 2015-11-20   60  static void rcpm_v2_irq_unmask(int cpu)
d17799f9c10e283 chenhui zhao 2015-11-20   61  {
d17799f9c10e283 chenhui zhao 2015-11-20   62  	int hw_cpu = get_hard_smp_processor_id(cpu);
d17799f9c10e283 chenhui zhao 2015-11-20   63  	unsigned int mask = 1 << hw_cpu;
d17799f9c10e283 chenhui zhao 2015-11-20   64  
d17799f9c10e283 chenhui zhao 2015-11-20   65  	clrbits32(&rcpm_v2_regs->tpmimr0, mask);
d17799f9c10e283 chenhui zhao 2015-11-20   66  	clrbits32(&rcpm_v2_regs->tpmcimr0, mask);
d17799f9c10e283 chenhui zhao 2015-11-20   67  	clrbits32(&rcpm_v2_regs->tpmmcmr0, mask);
d17799f9c10e283 chenhui zhao 2015-11-20   68  	clrbits32(&rcpm_v2_regs->tpmnmimr0, mask);
d17799f9c10e283 chenhui zhao 2015-11-20   69  }
d17799f9c10e283 chenhui zhao 2015-11-20   70  
d17799f9c10e283 chenhui zhao 2015-11-20   71  static void rcpm_v1_set_ip_power(bool enable, u32 mask)
d17799f9c10e283 chenhui zhao 2015-11-20   72  {
d17799f9c10e283 chenhui zhao 2015-11-20   73  	if (enable)
d17799f9c10e283 chenhui zhao 2015-11-20   74  		setbits32(&rcpm_v1_regs->ippdexpcr, mask);
d17799f9c10e283 chenhui zhao 2015-11-20   75  	else
d17799f9c10e283 chenhui zhao 2015-11-20   76  		clrbits32(&rcpm_v1_regs->ippdexpcr, mask);
d17799f9c10e283 chenhui zhao 2015-11-20   77  }
d17799f9c10e283 chenhui zhao 2015-11-20   78  
d17799f9c10e283 chenhui zhao 2015-11-20   79  static void rcpm_v2_set_ip_power(bool enable, u32 mask)
d17799f9c10e283 chenhui zhao 2015-11-20   80  {
d17799f9c10e283 chenhui zhao 2015-11-20   81  	if (enable)
d17799f9c10e283 chenhui zhao 2015-11-20   82  		setbits32(&rcpm_v2_regs->ippdexpcr[0], mask);
d17799f9c10e283 chenhui zhao 2015-11-20   83  	else
d17799f9c10e283 chenhui zhao 2015-11-20   84  		clrbits32(&rcpm_v2_regs->ippdexpcr[0], mask);
d17799f9c10e283 chenhui zhao 2015-11-20   85  }
d17799f9c10e283 chenhui zhao 2015-11-20   86  
d17799f9c10e283 chenhui zhao 2015-11-20   87  static void rcpm_v1_cpu_enter_state(int cpu, int state)
d17799f9c10e283 chenhui zhao 2015-11-20   88  {
d17799f9c10e283 chenhui zhao 2015-11-20   89  	int hw_cpu = get_hard_smp_processor_id(cpu);
d17799f9c10e283 chenhui zhao 2015-11-20   90  	unsigned int mask = 1 << hw_cpu;
d17799f9c10e283 chenhui zhao 2015-11-20   91  
d17799f9c10e283 chenhui zhao 2015-11-20   92  	switch (state) {
d17799f9c10e283 chenhui zhao 2015-11-20   93  	case E500_PM_PH10:
d17799f9c10e283 chenhui zhao 2015-11-20   94  		setbits32(&rcpm_v1_regs->cdozcr, mask);
d17799f9c10e283 chenhui zhao 2015-11-20   95  		break;
d17799f9c10e283 chenhui zhao 2015-11-20   96  	case E500_PM_PH15:
d17799f9c10e283 chenhui zhao 2015-11-20   97  		setbits32(&rcpm_v1_regs->cnapcr, mask);
d17799f9c10e283 chenhui zhao 2015-11-20   98  		break;
d17799f9c10e283 chenhui zhao 2015-11-20   99  	default:
d17799f9c10e283 chenhui zhao 2015-11-20  100  		pr_warn("Unknown cpu PM state (%d)\n", state);
d17799f9c10e283 chenhui zhao 2015-11-20  101  		break;
d17799f9c10e283 chenhui zhao 2015-11-20  102  	}
d17799f9c10e283 chenhui zhao 2015-11-20  103  }
d17799f9c10e283 chenhui zhao 2015-11-20  104  
d17799f9c10e283 chenhui zhao 2015-11-20  105  static void rcpm_v2_cpu_enter_state(int cpu, int state)
d17799f9c10e283 chenhui zhao 2015-11-20  106  {
d17799f9c10e283 chenhui zhao 2015-11-20  107  	int hw_cpu = get_hard_smp_processor_id(cpu);
d17799f9c10e283 chenhui zhao 2015-11-20  108  	u32 mask = 1 << cpu_core_index_of_thread(cpu);
d17799f9c10e283 chenhui zhao 2015-11-20  109  
d17799f9c10e283 chenhui zhao 2015-11-20  110  	switch (state) {
d17799f9c10e283 chenhui zhao 2015-11-20  111  	case E500_PM_PH10:
d17799f9c10e283 chenhui zhao 2015-11-20  112  		/* one bit corresponds to one thread for PH10 of 6500 */
d17799f9c10e283 chenhui zhao 2015-11-20  113  		setbits32(&rcpm_v2_regs->tph10setr0, 1 << hw_cpu);
d17799f9c10e283 chenhui zhao 2015-11-20  114  		break;
d17799f9c10e283 chenhui zhao 2015-11-20  115  	case E500_PM_PH15:
d17799f9c10e283 chenhui zhao 2015-11-20  116  		setbits32(&rcpm_v2_regs->pcph15setr, mask);
d17799f9c10e283 chenhui zhao 2015-11-20  117  		break;
d17799f9c10e283 chenhui zhao 2015-11-20  118  	case E500_PM_PH20:
d17799f9c10e283 chenhui zhao 2015-11-20  119  		setbits32(&rcpm_v2_regs->pcph20setr, mask);
d17799f9c10e283 chenhui zhao 2015-11-20  120  		break;
d17799f9c10e283 chenhui zhao 2015-11-20  121  	case E500_PM_PH30:
d17799f9c10e283 chenhui zhao 2015-11-20  122  		setbits32(&rcpm_v2_regs->pcph30setr, mask);
d17799f9c10e283 chenhui zhao 2015-11-20  123  		break;
d17799f9c10e283 chenhui zhao 2015-11-20  124  	default:
d17799f9c10e283 chenhui zhao 2015-11-20  125  		pr_warn("Unknown cpu PM state (%d)\n", state);
d17799f9c10e283 chenhui zhao 2015-11-20  126  	}
d17799f9c10e283 chenhui zhao 2015-11-20  127  }
d17799f9c10e283 chenhui zhao 2015-11-20  128  
d17799f9c10e283 chenhui zhao 2015-11-20  129  static void rcpm_v1_cpu_die(int cpu)
d17799f9c10e283 chenhui zhao 2015-11-20  130  {
d17799f9c10e283 chenhui zhao 2015-11-20  131  	rcpm_v1_cpu_enter_state(cpu, E500_PM_PH15);
d17799f9c10e283 chenhui zhao 2015-11-20  132  }
d17799f9c10e283 chenhui zhao 2015-11-20  133  
d17799f9c10e283 chenhui zhao 2015-11-20  134  #ifdef CONFIG_PPC64
d17799f9c10e283 chenhui zhao 2015-11-20  135  static void qoriq_disable_thread(int cpu)
d17799f9c10e283 chenhui zhao 2015-11-20  136  {
d17799f9c10e283 chenhui zhao 2015-11-20  137  	int thread = cpu_thread_in_core(cpu);
d17799f9c10e283 chenhui zhao 2015-11-20  138  
d17799f9c10e283 chenhui zhao 2015-11-20  139  	book3e_stop_thread(thread);
d17799f9c10e283 chenhui zhao 2015-11-20  140  }
d17799f9c10e283 chenhui zhao 2015-11-20  141  #endif
d17799f9c10e283 chenhui zhao 2015-11-20  142  
d17799f9c10e283 chenhui zhao 2015-11-20  143  static void rcpm_v2_cpu_die(int cpu)
d17799f9c10e283 chenhui zhao 2015-11-20  144  {
d17799f9c10e283 chenhui zhao 2015-11-20  145  #ifdef CONFIG_PPC64
d17799f9c10e283 chenhui zhao 2015-11-20  146  	int primary;
d17799f9c10e283 chenhui zhao 2015-11-20  147  
d17799f9c10e283 chenhui zhao 2015-11-20  148  	if (threads_per_core == 2) {
d17799f9c10e283 chenhui zhao 2015-11-20  149  		primary = cpu_first_thread_sibling(cpu);
d17799f9c10e283 chenhui zhao 2015-11-20  150  		if (cpu_is_offline(primary) && cpu_is_offline(primary + 1)) {
d17799f9c10e283 chenhui zhao 2015-11-20  151  			/* if both threads are offline, put the cpu in PH20 */
d17799f9c10e283 chenhui zhao 2015-11-20  152  			rcpm_v2_cpu_enter_state(cpu, E500_PM_PH20);
d17799f9c10e283 chenhui zhao 2015-11-20  153  		} else {
d17799f9c10e283 chenhui zhao 2015-11-20  154  			/* if only one thread is offline, disable the thread */
d17799f9c10e283 chenhui zhao 2015-11-20  155  			qoriq_disable_thread(cpu);
d17799f9c10e283 chenhui zhao 2015-11-20  156  		}
d17799f9c10e283 chenhui zhao 2015-11-20  157  	}
d17799f9c10e283 chenhui zhao 2015-11-20  158  #endif
d17799f9c10e283 chenhui zhao 2015-11-20  159  
d17799f9c10e283 chenhui zhao 2015-11-20  160  	if (threads_per_core == 1)
d17799f9c10e283 chenhui zhao 2015-11-20  161  		rcpm_v2_cpu_enter_state(cpu, E500_PM_PH20);
d17799f9c10e283 chenhui zhao 2015-11-20  162  }
d17799f9c10e283 chenhui zhao 2015-11-20  163  
d17799f9c10e283 chenhui zhao 2015-11-20  164  static void rcpm_v1_cpu_exit_state(int cpu, int state)
d17799f9c10e283 chenhui zhao 2015-11-20  165  {
d17799f9c10e283 chenhui zhao 2015-11-20  166  	int hw_cpu = get_hard_smp_processor_id(cpu);
d17799f9c10e283 chenhui zhao 2015-11-20  167  	unsigned int mask = 1 << hw_cpu;
d17799f9c10e283 chenhui zhao 2015-11-20  168  
d17799f9c10e283 chenhui zhao 2015-11-20  169  	switch (state) {
d17799f9c10e283 chenhui zhao 2015-11-20  170  	case E500_PM_PH10:
d17799f9c10e283 chenhui zhao 2015-11-20  171  		clrbits32(&rcpm_v1_regs->cdozcr, mask);
d17799f9c10e283 chenhui zhao 2015-11-20  172  		break;
d17799f9c10e283 chenhui zhao 2015-11-20  173  	case E500_PM_PH15:
d17799f9c10e283 chenhui zhao 2015-11-20  174  		clrbits32(&rcpm_v1_regs->cnapcr, mask);
d17799f9c10e283 chenhui zhao 2015-11-20  175  		break;
d17799f9c10e283 chenhui zhao 2015-11-20  176  	default:
d17799f9c10e283 chenhui zhao 2015-11-20  177  		pr_warn("Unknown cpu PM state (%d)\n", state);
d17799f9c10e283 chenhui zhao 2015-11-20  178  		break;
d17799f9c10e283 chenhui zhao 2015-11-20  179  	}
d17799f9c10e283 chenhui zhao 2015-11-20  180  }
d17799f9c10e283 chenhui zhao 2015-11-20  181  
d17799f9c10e283 chenhui zhao 2015-11-20  182  static void rcpm_v1_cpu_up_prepare(int cpu)
d17799f9c10e283 chenhui zhao 2015-11-20  183  {
d17799f9c10e283 chenhui zhao 2015-11-20  184  	rcpm_v1_cpu_exit_state(cpu, E500_PM_PH15);
d17799f9c10e283 chenhui zhao 2015-11-20  185  	rcpm_v1_irq_unmask(cpu);
d17799f9c10e283 chenhui zhao 2015-11-20  186  }
d17799f9c10e283 chenhui zhao 2015-11-20  187  
d17799f9c10e283 chenhui zhao 2015-11-20  188  static void rcpm_v2_cpu_exit_state(int cpu, int state)
d17799f9c10e283 chenhui zhao 2015-11-20  189  {
d17799f9c10e283 chenhui zhao 2015-11-20  190  	int hw_cpu = get_hard_smp_processor_id(cpu);
d17799f9c10e283 chenhui zhao 2015-11-20  191  	u32 mask = 1 << cpu_core_index_of_thread(cpu);
d17799f9c10e283 chenhui zhao 2015-11-20  192  
d17799f9c10e283 chenhui zhao 2015-11-20  193  	switch (state) {
d17799f9c10e283 chenhui zhao 2015-11-20  194  	case E500_PM_PH10:
d17799f9c10e283 chenhui zhao 2015-11-20  195  		setbits32(&rcpm_v2_regs->tph10clrr0, 1 << hw_cpu);
d17799f9c10e283 chenhui zhao 2015-11-20  196  		break;
d17799f9c10e283 chenhui zhao 2015-11-20  197  	case E500_PM_PH15:
d17799f9c10e283 chenhui zhao 2015-11-20  198  		setbits32(&rcpm_v2_regs->pcph15clrr, mask);
d17799f9c10e283 chenhui zhao 2015-11-20  199  		break;
d17799f9c10e283 chenhui zhao 2015-11-20  200  	case E500_PM_PH20:
d17799f9c10e283 chenhui zhao 2015-11-20 @201  		setbits32(&rcpm_v2_regs->pcph20clrr, mask);
d17799f9c10e283 chenhui zhao 2015-11-20  202  		break;
d17799f9c10e283 chenhui zhao 2015-11-20  203  	case E500_PM_PH30:
d17799f9c10e283 chenhui zhao 2015-11-20 @204  		setbits32(&rcpm_v2_regs->pcph30clrr, mask);
d17799f9c10e283 chenhui zhao 2015-11-20  205  		break;
d17799f9c10e283 chenhui zhao 2015-11-20  206  	default:
d17799f9c10e283 chenhui zhao 2015-11-20  207  		pr_warn("Unknown cpu PM state (%d)\n", state);
d17799f9c10e283 chenhui zhao 2015-11-20  208  	}
d17799f9c10e283 chenhui zhao 2015-11-20  209  }
d17799f9c10e283 chenhui zhao 2015-11-20  210  
d17799f9c10e283 chenhui zhao 2015-11-20  211  static void rcpm_v2_cpu_up_prepare(int cpu)
d17799f9c10e283 chenhui zhao 2015-11-20  212  {
d17799f9c10e283 chenhui zhao 2015-11-20  213  	rcpm_v2_cpu_exit_state(cpu, E500_PM_PH20);
d17799f9c10e283 chenhui zhao 2015-11-20  214  	rcpm_v2_irq_unmask(cpu);
d17799f9c10e283 chenhui zhao 2015-11-20  215  }
d17799f9c10e283 chenhui zhao 2015-11-20  216  
d17799f9c10e283 chenhui zhao 2015-11-20  217  static int rcpm_v1_plat_enter_state(int state)
d17799f9c10e283 chenhui zhao 2015-11-20  218  {
d17799f9c10e283 chenhui zhao 2015-11-20 @219  	u32 *pmcsr_reg = &rcpm_v1_regs->powmgtcsr;
d17799f9c10e283 chenhui zhao 2015-11-20  220  	int ret = 0;
d17799f9c10e283 chenhui zhao 2015-11-20  221  	int result;
d17799f9c10e283 chenhui zhao 2015-11-20  222  
d17799f9c10e283 chenhui zhao 2015-11-20  223  	switch (state) {
d17799f9c10e283 chenhui zhao 2015-11-20  224  	case PLAT_PM_SLEEP:
d17799f9c10e283 chenhui zhao 2015-11-20 @225  		setbits32(pmcsr_reg, RCPM_POWMGTCSR_SLP);
d17799f9c10e283 chenhui zhao 2015-11-20  226  
d17799f9c10e283 chenhui zhao 2015-11-20  227  		/* Upon resume, wait for RCPM_POWMGTCSR_SLP bit to be clear. */
d17799f9c10e283 chenhui zhao 2015-11-20  228  		result = spin_event_timeout(
d17799f9c10e283 chenhui zhao 2015-11-20  229  		  !(in_be32(pmcsr_reg) & RCPM_POWMGTCSR_SLP), 10000, 10);
d17799f9c10e283 chenhui zhao 2015-11-20  230  		if (!result) {
d17799f9c10e283 chenhui zhao 2015-11-20  231  			pr_err("timeout waiting for SLP bit to be cleared\n");
d17799f9c10e283 chenhui zhao 2015-11-20  232  			ret = -ETIMEDOUT;
d17799f9c10e283 chenhui zhao 2015-11-20  233  		}
d17799f9c10e283 chenhui zhao 2015-11-20  234  		break;
d17799f9c10e283 chenhui zhao 2015-11-20  235  	default:
d17799f9c10e283 chenhui zhao 2015-11-20  236  		pr_warn("Unknown platform PM state (%d)", state);
d17799f9c10e283 chenhui zhao 2015-11-20  237  		ret = -EINVAL;
d17799f9c10e283 chenhui zhao 2015-11-20  238  	}
d17799f9c10e283 chenhui zhao 2015-11-20  239  
d17799f9c10e283 chenhui zhao 2015-11-20  240  	return ret;
d17799f9c10e283 chenhui zhao 2015-11-20  241  }
d17799f9c10e283 chenhui zhao 2015-11-20  242  

:::::: The code at line 32 was first introduced by commit
:::::: d17799f9c10e283cccd4d598d3416e6fac336ab9 powerpc/rcpm: add RCPM driver

:::::: TO: chenhui zhao <chenhui.zhao@freescale.com>
:::::: CC: Scott Wood <oss@buserror.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--17pEHd4RhPHOinZp
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
/w8WbQi68SYCAA==

--17pEHd4RhPHOinZp--
