Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F04C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 14:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D3322073A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 14:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgGIOl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 10:41:58 -0400
Received: from mga11.intel.com ([192.55.52.93]:7317 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgGIOl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 10:41:57 -0400
IronPort-SDR: tYc/v0nB4ooJqX+lLEQ6EQXTOegzd7NZZsRZIppxNDj11zsK7Ge+uzVV0Z64tXAkXhvQq1bl/I
 j7LeOARUAQHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="146087448"
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="gz'50?scan'50,208,50";a="146087448"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 07:29:40 -0700
IronPort-SDR: QW70VToaDVzTFXD3GNhxVgp2YXcDqNmx1zABvVURYsw3dBDwMzQcW74fHrxSIpAJA7A/A5DD8B
 KzEPp5344ppg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="gz'50?scan'50,208,50";a="268765286"
Received: from lkp-server01.sh.intel.com (HELO 5019aad283e6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 09 Jul 2020 07:29:38 -0700
Received: from kbuild by 5019aad283e6 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jtXYQ-00005E-3q; Thu, 09 Jul 2020 14:29:38 +0000
Date:   Thu, 9 Jul 2020 22:29:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/video/fbdev/sstfb.c:337:23: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202007092242.tTvuHF20%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0bddd227f3dc55975e2b8dfa7fc6f959b062a2c7
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   3 weeks ago
config: microblaze-randconfig-s032-20200709 (attached as .config)
compiler: microblaze-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-37-gc9676a3b-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=microblaze 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/video/fbdev/sstfb.c:337:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/sstfb.c:337:23: sparse:     expected void *
   drivers/video/fbdev/sstfb.c:337:23: sparse:     got char [noderef] __iomem *screen_base
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
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
--
>> drivers/video/fbdev/aty/atyfb_base.c:3715:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned char [usertype] *addr @@
>> drivers/video/fbdev/aty/atyfb_base.c:3715:37: sparse:     expected void [noderef] __iomem *addr
   drivers/video/fbdev/aty/atyfb_base.c:3715:37: sparse:     got unsigned char [usertype] *addr
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
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
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
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
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
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
--
   drivers/video/fbdev/riva/fbdev.c:493:14: sparse: sparse: cast to restricted __le16
   drivers/video/fbdev/riva/fbdev.c:493:14: sparse: sparse: cast to restricted __le16
   drivers/video/fbdev/riva/fbdev.c:493:14: sparse: sparse: cast to restricted __le16
   drivers/video/fbdev/riva/fbdev.c:493:14: sparse: sparse: cast to restricted __le16
   drivers/video/fbdev/riva/fbdev.c:494:14: sparse: sparse: cast to restricted __le16
   drivers/video/fbdev/riva/fbdev.c:494:14: sparse: sparse: cast to restricted __le16
   drivers/video/fbdev/riva/fbdev.c:494:14: sparse: sparse: cast to restricted __le16
   drivers/video/fbdev/riva/fbdev.c:494:14: sparse: sparse: cast to restricted __le16
>> drivers/video/fbdev/riva/fbdev.c:2064:42: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void [noderef] __iomem *addr @@     got unsigned int volatile [noderef] [usertype] __iomem *[usertype] PRAMIN @@
>> drivers/video/fbdev/riva/fbdev.c:2064:42: sparse:     expected void [noderef] __iomem *addr
   drivers/video/fbdev/riva/fbdev.c:2064:42: sparse:     got unsigned int volatile [noderef] [usertype] __iomem *[usertype] PRAMIN
   drivers/video/fbdev/riva/fbdev.c:2097:34: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void [noderef] __iomem *addr @@     got unsigned int volatile [noderef] [usertype] __iomem *[usertype] PRAMIN @@
   drivers/video/fbdev/riva/fbdev.c:2097:34: sparse:     expected void [noderef] __iomem *addr
   drivers/video/fbdev/riva/fbdev.c:2097:34: sparse:     got unsigned int volatile [noderef] [usertype] __iomem *[usertype] PRAMIN
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
--
   drivers/tty/synclinkmp.c:3562:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char *[usertype] memory_base @@     got void [noderef] __iomem * @@
   drivers/tty/synclinkmp.c:3562:27: sparse:     expected unsigned char *[usertype] memory_base
   drivers/tty/synclinkmp.c:3562:27: sparse:     got void [noderef] __iomem *
   drivers/tty/synclinkmp.c:3571:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char *[usertype] lcr_base @@     got void [noderef] __iomem * @@
   drivers/tty/synclinkmp.c:3571:24: sparse:     expected unsigned char *[usertype] lcr_base
   drivers/tty/synclinkmp.c:3571:24: sparse:     got void [noderef] __iomem *
   drivers/tty/synclinkmp.c:3580:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char *[usertype] sca_base @@     got void [noderef] __iomem * @@
   drivers/tty/synclinkmp.c:3580:24: sparse:     expected unsigned char *[usertype] sca_base
   drivers/tty/synclinkmp.c:3580:24: sparse:     got void [noderef] __iomem *
   drivers/tty/synclinkmp.c:3589:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char *[usertype] statctrl_base @@     got void [noderef] __iomem * @@
   drivers/tty/synclinkmp.c:3589:29: sparse:     expected unsigned char *[usertype] statctrl_base
   drivers/tty/synclinkmp.c:3589:29: sparse:     got void [noderef] __iomem *
>> drivers/tty/synclinkmp.c:3642:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned char *[usertype] memory_base @@
>> drivers/tty/synclinkmp.c:3642:29: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/synclinkmp.c:3642:29: sparse:     got unsigned char *[usertype] memory_base
>> drivers/tty/synclinkmp.c:3647:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned char * @@
   drivers/tty/synclinkmp.c:3647:40: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/synclinkmp.c:3647:40: sparse:     got unsigned char *
   drivers/tty/synclinkmp.c:3652:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned char * @@
   drivers/tty/synclinkmp.c:3652:45: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/synclinkmp.c:3652:45: sparse:     got unsigned char *
   drivers/tty/synclinkmp.c:3657:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned char * @@
   drivers/tty/synclinkmp.c:3657:40: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/synclinkmp.c:3657:40: sparse:     got unsigned char *
   drivers/tty/synclinkmp.c:5383:15: sparse: sparse: memset with byte count of 262144

vim +337 drivers/video/fbdev/sstfb.c

^1da177e4c3f415 drivers/video/sstfb.c Linus Torvalds 2005-04-16  330  
^1da177e4c3f415 drivers/video/sstfb.c Linus Torvalds 2005-04-16  331  /*
^1da177e4c3f415 drivers/video/sstfb.c Linus Torvalds 2005-04-16  332   * clear lfb screen
^1da177e4c3f415 drivers/video/sstfb.c Linus Torvalds 2005-04-16  333   */
^1da177e4c3f415 drivers/video/sstfb.c Linus Torvalds 2005-04-16  334  static void sstfb_clear_screen(struct fb_info *info)
^1da177e4c3f415 drivers/video/sstfb.c Linus Torvalds 2005-04-16  335  {
^1da177e4c3f415 drivers/video/sstfb.c Linus Torvalds 2005-04-16  336  	/* clear screen */
^1da177e4c3f415 drivers/video/sstfb.c Linus Torvalds 2005-04-16 @337  	fb_memset(info->screen_base, 0, info->fix.smem_len);
^1da177e4c3f415 drivers/video/sstfb.c Linus Torvalds 2005-04-16  338  }
^1da177e4c3f415 drivers/video/sstfb.c Linus Torvalds 2005-04-16  339  

:::::: The code at line 337 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--vkogqOf2sHV7VnPd
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--vkogqOf2sHV7VnPd--
