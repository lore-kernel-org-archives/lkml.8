Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82385C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 23:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29E932067D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 23:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgG2XTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:19:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:22570 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbgG2XTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 19:19:10 -0400
IronPort-SDR: heGbujSWmXKDdy1Pw01p1Vjf+EC2N9BlUBUYiXsXOyKKHqAnGfceB8G2zAm5QXU78N+hvbgCO4
 d0TSMFopNOjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="150685761"
X-IronPort-AV: E=Sophos;i="5.75,412,1589266800"; 
   d="gz'50?scan'50,208,50";a="150685761"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 16:08:32 -0700
IronPort-SDR: heXX+He6U3iygqoUTu4P0Tip8pIYfU7aeUaY6MwVCLDlnG6FLDT/9x1DA1vei/V2NUE46AEVvu
 NI4j03NSJWMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,412,1589266800"; 
   d="gz'50?scan'50,208,50";a="272752333"
Received: from lkp-server02.sh.intel.com (HELO 1bde1f275adc) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 29 Jul 2020 16:08:29 -0700
Received: from kbuild by 1bde1f275adc with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k0vBU-0000FW-IJ; Wed, 29 Jul 2020 23:08:28 +0000
Date:   Thu, 30 Jul 2020 07:07:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/powerpc/sysdev/fsl_rcpm.c:32:9: sparse: sparse: incorrect type
 in argument 1 (different base types)
Message-ID: <202007300754.hEKdCT4Y%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d3590ebf6f91350192737dd1d1b219c05277f067
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   6 weeks ago
config: powerpc-randconfig-s031-20200729 (attached as .config)
compiler: powerpc64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-97-gee4aea9a-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc 

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
>> arch/powerpc/platforms/85xx/smp.c:218:28: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct epapr_spin_table [noderef] __iomem *[assigned] spin_table @@     got void * @@
>> arch/powerpc/platforms/85xx/smp.c:218:28: sparse:     expected struct epapr_spin_table [noderef] __iomem *[assigned] spin_table
   arch/powerpc/platforms/85xx/smp.c:218:28: sparse:     got void *
>> arch/powerpc/platforms/85xx/smp.c:227:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *spin_table @@     got struct epapr_spin_table [noderef] __iomem *[assigned] spin_table @@
   arch/powerpc/platforms/85xx/smp.c:227:36: sparse:     expected void *spin_table
>> arch/powerpc/platforms/85xx/smp.c:227:36: sparse:     got struct epapr_spin_table [noderef] __iomem *[assigned] spin_table
   arch/powerpc/platforms/85xx/smp.c:239:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *spin_table @@     got struct epapr_spin_table [noderef] __iomem *[assigned] spin_table @@
   arch/powerpc/platforms/85xx/smp.c:239:22: sparse:     expected void *spin_table
   arch/powerpc/platforms/85xx/smp.c:239:22: sparse:     got struct epapr_spin_table [noderef] __iomem *[assigned] spin_table
   arch/powerpc/platforms/85xx/smp.c:239:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *spin_table @@     got struct epapr_spin_table [noderef] __iomem *[assigned] spin_table @@
   arch/powerpc/platforms/85xx/smp.c:239:22: sparse:     expected void *spin_table
   arch/powerpc/platforms/85xx/smp.c:239:22: sparse:     got struct epapr_spin_table [noderef] __iomem *[assigned] spin_table
   arch/powerpc/platforms/85xx/smp.c:239:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *spin_table @@     got struct epapr_spin_table [noderef] __iomem *[assigned] spin_table @@
   arch/powerpc/platforms/85xx/smp.c:239:22: sparse:     expected void *spin_table
   arch/powerpc/platforms/85xx/smp.c:239:22: sparse:     got struct epapr_spin_table [noderef] __iomem *[assigned] spin_table
   arch/powerpc/platforms/85xx/smp.c:239:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *spin_table @@     got struct epapr_spin_table [noderef] __iomem *[assigned] spin_table @@
   arch/powerpc/platforms/85xx/smp.c:239:22: sparse:     expected void *spin_table
   arch/powerpc/platforms/85xx/smp.c:239:22: sparse:     got struct epapr_spin_table [noderef] __iomem *[assigned] spin_table
   arch/powerpc/platforms/85xx/smp.c:249:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *spin_table @@     got struct epapr_spin_table [noderef] __iomem *[assigned] spin_table @@
   arch/powerpc/platforms/85xx/smp.c:249:26: sparse:     expected void *spin_table
   arch/powerpc/platforms/85xx/smp.c:249:26: sparse:     got struct epapr_spin_table [noderef] __iomem *[assigned] spin_table
>> arch/powerpc/platforms/85xx/smp.c:252:19: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/powerpc/platforms/85xx/smp.c:252:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long volatile [noderef] [usertype] __iomem *addr @@     got unsigned long long [usertype] * @@
>> arch/powerpc/platforms/85xx/smp.c:252:19: sparse:     expected unsigned long long volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/85xx/smp.c:252:19: sparse:     got unsigned long long [usertype] *
   arch/powerpc/platforms/85xx/smp.c:266:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *spin_table @@     got struct epapr_spin_table [noderef] __iomem *[assigned] spin_table @@
   arch/powerpc/platforms/85xx/smp.c:266:26: sparse:     expected void *spin_table
   arch/powerpc/platforms/85xx/smp.c:266:26: sparse:     got struct epapr_spin_table [noderef] __iomem *[assigned] spin_table
   arch/powerpc/platforms/85xx/smp.c:387:6: sparse: sparse: symbol 'mpc85xx_smp_kexec_cpu_down' was not declared. Should it be static?
>> arch/powerpc/platforms/85xx/smp.c:173:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got unsigned int * @@
>> arch/powerpc/platforms/85xx/smp.c:173:27: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/85xx/smp.c:173:27: sparse:     got unsigned int *
>> arch/powerpc/platforms/85xx/smp.c:173:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got unsigned int * @@
>> arch/powerpc/platforms/85xx/smp.c:173:27: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/85xx/smp.c:173:27: sparse:     got unsigned int *
>> arch/powerpc/platforms/85xx/smp.c:173:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got unsigned int * @@
>> arch/powerpc/platforms/85xx/smp.c:173:27: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/85xx/smp.c:173:27: sparse:     got unsigned int *
>> arch/powerpc/platforms/85xx/smp.c:173:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got unsigned int * @@
>> arch/powerpc/platforms/85xx/smp.c:173:27: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/85xx/smp.c:173:27: sparse:     got unsigned int *
--
   drivers/usb/host/ehci-hcd.c: note: in included file:
   drivers/usb/host/ehci-q.c:1389:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] old_current @@     got int @@
   drivers/usb/host/ehci-q.c:1389:27: sparse:     expected restricted __le32 [usertype] old_current
   drivers/usb/host/ehci-q.c:1389:27: sparse:     got int
   drivers/usb/host/ehci-hcd.c:566:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] old_current @@     got int @@
   drivers/usb/host/ehci-hcd.c:566:27: sparse:     expected restricted __le32 [usertype] old_current
   drivers/usb/host/ehci-hcd.c:566:27: sparse:     got int
   drivers/usb/host/ehci-hcd.c: note: in included file:
>> drivers/usb/host/ehci-ppc-of.c:140:47: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected restricted __le32 [usertype] *ohci_hcctrl_reg @@     got void [noderef] __iomem * @@
   drivers/usb/host/ehci-ppc-of.c:140:47: sparse:     expected restricted __le32 [usertype] *ohci_hcctrl_reg
   drivers/usb/host/ehci-ppc-of.c:140:47: sparse:     got void [noderef] __iomem *

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

--J/dobhs11T7y2rNN
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
YjVjVle57rE4cL3ZqFWJedrFzwaEVIHQrmoTZ8c8a9s8PaYl1a8EeS37SApA7oMiw8Cpthey
AnSb1xkkXVe/L0vlvMN8rBrYFCNy3IhSUEpwz5wi5VCz3JOvpJI3To9luu/PrfrlnWxKCaOO
OOFy3zYeFrhOG5IRXJ4zOskX1khWtevjfkNlYn6rMKBa5kzKk9bI6P1IEzbULL8TWRr8zLgn
Y1vRQwLdmaiuS/XW+98dEc0nceL189t1Fk93Qolu1sRmzw8OlgWTZKj1ADy1kXekEZ4s13GE
3ciMFFI8YBFKt6AyJRHBsNptBvO6nBqiQhuIcE5H+di2CLZtgZMIPe5g32oNZNAVyfHaj3Ud
H6uVCYm2vDpsHdva1NgwQhI42z/cmIAVZSb6ud71yjAzldxUeig0lKwSisGgEbwJqQ5ghYyG
1MBtT2BcFFvbdW6MCMlD29bHYwTTQa0wVKwwWxPCze4i0IuCQvrg2bLgp3DmGFZQ5UmTSbDs
+uD18fPpDTUlZAs5xnJCMWnYMD84uTH7ROGnthgvOkq6Z/9rxl3AqwZyLD123+EOdnZ+nZGY
ZLM/36+zZX4HgvRIktnL6cdgrnJ6fjvP/uxmr1332D3+F21LJ5W06Z6/syeCl/Olmz29fj0P
X0JHs5fTt6fXb7iDbZHEofwSQ6FZbYpZwgRRUhLF/ZSBjusIPJjVmeA4CEpuKK9g85U0mqM+
R3zwIV4pQyUQDLCpcn3+6+fTlY7Xy2z9/N7N8tOP7jKaBjHeKCI6lo+dFCeCTXtWHasyvze0
KNnHysgAhG3HCBi6pjacIXifzBsg0Pxs5/huMiOYMsVbEdUEaRyVMqOhp4xzdMjQFf4qcHr8
1l0/Je+n59/oltaxkZxduv95f7p0XAPgJINmBM8TlLu7139T9izbjeO47vsrfGZVs+hpW7L8
WMqSbKujV0TZcWqjk07cVT6TxJnEOdN1v/4CpB4EBbp6NlUxAFJ8ggAIAnhV+zQQC7B+kAni
AnRAamMb0rGjwlQXcBprX0sXKcPE7DHWMmu26kiqEqQJEE6EiFC9Wg8Ht/mA7FQexoN1j0ke
4zCyhbSQ2Uh1G3wPnICWMaiuoVd5AcyxYejU6pOUtqrsiw9nV86phaPuhJg7vMeP5GgwJHSO
u1qpHGmpPkrjGe9Y1mAd3ptIMvtwV+04K4Fq2F5EhpSNWX0raqOSYPOMaqyg8P88oHnLFFbm
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

--J/dobhs11T7y2rNN--
