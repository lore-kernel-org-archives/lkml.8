Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B117CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78FD52076E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbgHEUAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:00:15 -0400
Received: from mga03.intel.com ([134.134.136.65]:32514 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727780AbgHEQlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:41:46 -0400
IronPort-SDR: aHYtXLEMJ5tcxhxi8erKvv7JUfosHgmN7c5Khjv/rsv3Z4SX3+XougDrM/WYRFtvM/JAcqZi8t
 pVL3JombjN/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="152477360"
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="gz'50?scan'50,208,50";a="152477360"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 03:51:50 -0700
IronPort-SDR: Ouh+hpLHriOJQ9Bo3AQDgE3sOeHTo1rDIsP1/sU9vVOjDlAW5QshawEETH/XRParcN7Noef9Zu
 QBR99OO+Dw9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="gz'50?scan'50,208,50";a="274745618"
Received: from lkp-server02.sh.intel.com (HELO 37a337f97289) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 05 Aug 2020 03:51:46 -0700
Received: from kbuild by 37a337f97289 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k3H1P-0000jw-OQ; Wed, 05 Aug 2020 10:51:47 +0000
Date:   Wed, 5 Aug 2020 18:51:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse:
 incorrect type in initializer (different address spaces)
Message-ID: <202008051812.VUc42kmt%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4da9f3302615f4191814f826054846bf843e24fa
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   7 weeks ago
config: arc-randconfig-s031-20200805 (attached as .config)
compiler: arc-elf-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-117-g8c7aee71-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=arc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:819:42: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:1094:5: sparse: sparse: symbol 'amdgpu_ttm_gart_bind' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __user *__p @@     got unsigned int [usertype] * @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse:     expected void const [noderef] __user *__p
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/arc/include/asm/uaccess.h:619:33: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char *d_char @@     got void [noderef] __user *to @@
   arch/arc/include/asm/uaccess.h:619:33: sparse:     expected unsigned char *d_char
   arch/arc/include/asm/uaccess.h:619:33: sparse:     got void [noderef] __user *to
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __user *__p @@     got unsigned int [usertype] * @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse:     expected void [noderef] __user *__p
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __user *__p @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse:     expected void [noderef] __user *__p
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse: sparse: cast removes address space '__user' of expression
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:138:17: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t ( *poll )( ... ) @@     got unsigned int ( * )( ... ) @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:138:17: sparse:     expected restricted __poll_t ( *poll )( ... )
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:138:17: sparse:     got unsigned int ( * )( ... )
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __user *__p @@     got unsigned int [usertype] * @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse:     expected void [noderef] __user *__p
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __user *__p @@     got unsigned int [usertype] * @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse:     expected void const [noderef] __user *__p
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __user *__p @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse:     expected void [noderef] __user *__p
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __user *__p @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse:     expected void const [noderef] __user *__p
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __user *__p @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse:     expected void [noderef] __user *__p
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: too many warnings
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1256:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1256:25: sparse:    struct dma_fence [noderef] __rcu *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1256:25: sparse:    struct dma_fence *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1257:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1257:17: sparse:    struct dma_fence [noderef] __rcu *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1257:17: sparse:    struct dma_fence *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1313:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1313:17: sparse:    struct dma_fence [noderef] __rcu *

vim +2353 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c

d38ceaf99ed015f Alex Deucher    2015-04-20  2327  
50da51744f005f4 Tom St Denis    2018-05-09  2328  /**
50da51744f005f4 Tom St Denis    2018-05-09  2329   * amdgpu_ttm_vram_write - Linear write access to VRAM
50da51744f005f4 Tom St Denis    2018-05-09  2330   *
50da51744f005f4 Tom St Denis    2018-05-09  2331   * Accesses VRAM via MMIO for debugging purposes.
50da51744f005f4 Tom St Denis    2018-05-09  2332   */
08cab989f77582c Tom St Denis    2017-08-29  2333  static ssize_t amdgpu_ttm_vram_write(struct file *f, const char __user *buf,
08cab989f77582c Tom St Denis    2017-08-29  2334  				    size_t size, loff_t *pos)
08cab989f77582c Tom St Denis    2017-08-29  2335  {
08cab989f77582c Tom St Denis    2017-08-29  2336  	struct amdgpu_device *adev = file_inode(f)->i_private;
08cab989f77582c Tom St Denis    2017-08-29  2337  	ssize_t result = 0;
08cab989f77582c Tom St Denis    2017-08-29  2338  	int r;
08cab989f77582c Tom St Denis    2017-08-29  2339  
08cab989f77582c Tom St Denis    2017-08-29  2340  	if (size & 0x3 || *pos & 0x3)
08cab989f77582c Tom St Denis    2017-08-29  2341  		return -EINVAL;
08cab989f77582c Tom St Denis    2017-08-29  2342  
770d13b19fdf365 Christian König 2018-01-12  2343  	if (*pos >= adev->gmc.mc_vram_size)
08cab989f77582c Tom St Denis    2017-08-29  2344  		return -ENXIO;
08cab989f77582c Tom St Denis    2017-08-29  2345  
08cab989f77582c Tom St Denis    2017-08-29  2346  	while (size) {
08cab989f77582c Tom St Denis    2017-08-29  2347  		unsigned long flags;
08cab989f77582c Tom St Denis    2017-08-29  2348  		uint32_t value;
08cab989f77582c Tom St Denis    2017-08-29  2349  
770d13b19fdf365 Christian König 2018-01-12  2350  		if (*pos >= adev->gmc.mc_vram_size)
08cab989f77582c Tom St Denis    2017-08-29  2351  			return result;
08cab989f77582c Tom St Denis    2017-08-29  2352  
08cab989f77582c Tom St Denis    2017-08-29 @2353  		r = get_user(value, (uint32_t *)buf);
08cab989f77582c Tom St Denis    2017-08-29  2354  		if (r)
08cab989f77582c Tom St Denis    2017-08-29  2355  			return r;
08cab989f77582c Tom St Denis    2017-08-29  2356  
08cab989f77582c Tom St Denis    2017-08-29  2357  		spin_lock_irqsave(&adev->mmio_idx_lock, flags);
c30572814df55bc Tom St Denis    2017-09-13  2358  		WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)*pos) | 0x80000000);
c30572814df55bc Tom St Denis    2017-09-13  2359  		WREG32_NO_KIQ(mmMM_INDEX_HI, *pos >> 31);
c30572814df55bc Tom St Denis    2017-09-13  2360  		WREG32_NO_KIQ(mmMM_DATA, value);
08cab989f77582c Tom St Denis    2017-08-29  2361  		spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
08cab989f77582c Tom St Denis    2017-08-29  2362  
08cab989f77582c Tom St Denis    2017-08-29  2363  		result += 4;
08cab989f77582c Tom St Denis    2017-08-29  2364  		buf += 4;
08cab989f77582c Tom St Denis    2017-08-29  2365  		*pos += 4;
08cab989f77582c Tom St Denis    2017-08-29  2366  		size -= 4;
08cab989f77582c Tom St Denis    2017-08-29  2367  	}
08cab989f77582c Tom St Denis    2017-08-29  2368  
08cab989f77582c Tom St Denis    2017-08-29  2369  	return result;
08cab989f77582c Tom St Denis    2017-08-29  2370  }
08cab989f77582c Tom St Denis    2017-08-29  2371  

:::::: The code at line 2353 was first introduced by commit
:::::: 08cab989f77582cb19df12d4a75a91b68b0017f6 drm/amd/amdgpu: Add write() method to VRAM debugfs entry (v2)

:::::: TO: Tom St Denis <tom.stdenis@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--YiEDa0DAkWCtVeE4
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--YiEDa0DAkWCtVeE4--
