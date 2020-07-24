Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C893C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 23:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE46920737
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 23:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgGXXN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 19:13:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:30706 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbgGXXN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 19:13:28 -0400
IronPort-SDR: UCgrBRg66qy43THolol+Yxqvl+89sif87GKeevKRpWGM8OOssnGF3L3My8CBcJnaNfGg7C0myV
 gWQWRrvV6yCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="152070168"
X-IronPort-AV: E=Sophos;i="5.75,392,1589266800"; 
   d="gz'50?scan'50,208,50";a="152070168"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 16:10:25 -0700
IronPort-SDR: P2IGNmdNlE/J7nU3drP1bDOlhyS8Q9f/HOHD3VCIyCRpXld+X74zXuGBStqDjduCokFTiCiMQ0
 jK/XmxjY+d1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,392,1589266800"; 
   d="gz'50?scan'50,208,50";a="329060468"
Received: from lkp-server01.sh.intel.com (HELO df0563f96c37) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 24 Jul 2020 16:10:22 -0700
Received: from kbuild by df0563f96c37 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jz6pZ-0000cH-P2; Fri, 24 Jul 2020 23:10:21 +0000
Date:   Sat, 25 Jul 2020 07:09:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse:
 incorrect type in initializer (different address spaces)
Message-ID: <202007250720.jcXD7bdu%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f37e99aca03f63aa3f2bd13ceaf769455d12c4b0
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   5 weeks ago
config: arm-randconfig-s032-20200723 (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-93-g4c6cbe55-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const [noderef] __user *__pu_ptr @@     got unsigned int [usertype] * @@
>> drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse:     expected unsigned int const [noderef] __user *__pu_ptr
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
--
>> drivers/mtd/maps/dc21285.c:57:22: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/maps/dc21285.c:64:22: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/maps/dc21285.c:71:22: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/maps/dc21285.c:77:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/maps/dc21285.c:86:11: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/maps/dc21285.c:95:11: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mtd/maps/dc21285.c:102:11: sparse: sparse: cast removes address space '__iomem' of expression
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:819:42: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:1094:5: sparse: sparse: symbol 'amdgpu_ttm_gart_bind' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *register __p @@     got unsigned int [usertype] * @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse:     expected unsigned int [noderef] __user *register __p
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const [noderef] __user *__pu_ptr @@     got unsigned int [usertype] * @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse:     expected unsigned int const [noderef] __user *__pu_ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const [noderef] __user *__pu_ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse:     expected unsigned int const [noderef] __user *__pu_ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse: sparse: cast removes address space '__user' of expression
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:138:17: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t ( *poll )( ... ) @@     got unsigned int ( * )( ... ) @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:138:17: sparse:     expected restricted __poll_t ( *poll )( ... )
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:138:17: sparse:     got unsigned int ( * )( ... )
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const [noderef] __user *__pu_ptr @@     got unsigned int [usertype] * @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse:     expected unsigned int const [noderef] __user *__pu_ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *register __p @@     got unsigned int [usertype] * @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse:     expected unsigned int [noderef] __user *register __p
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const [noderef] __user *__pu_ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse:     expected unsigned int const [noderef] __user *__pu_ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *register __p @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse:     expected unsigned int [noderef] __user *register __p
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const [noderef] __user *__pu_ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse:     expected unsigned int const [noderef] __user *__pu_ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *register __p @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse:     expected unsigned int [noderef] __user *register __p
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const [noderef] __user *__pu_ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse:     expected unsigned int const [noderef] __user *__pu_ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:622:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:622:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:622:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *register __p @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:622:21: sparse:     expected unsigned int [noderef] __user *register __p
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:622:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:622:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:719:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:719:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:719:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const [noderef] __user *__pu_ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:719:21: sparse:     expected unsigned int const [noderef] __user *__pu_ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:719:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:719:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:719:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:793:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:793:29: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:793:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int const [noderef] __user *__pu_ptr @@     got signed int [usertype] * @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:793:29: sparse:     expected signed int const [noderef] __user *__pu_ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:793:29: sparse:     got signed int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:793:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:793:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:875:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:875:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:875:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const [noderef] __user *__pu_ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:875:21: sparse:     expected unsigned int const [noderef] __user *__pu_ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:875:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:875:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:875:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:968:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:968:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:968:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const [noderef] __user *__pu_ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:968:21: sparse:     expected unsigned int const [noderef] __user *__pu_ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:968:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:968:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:968:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1012:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1012:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1012:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *register __p @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1012:21: sparse:     expected unsigned int [noderef] __user *register __p
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1012:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1012:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1256:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1256:25: sparse:    struct dma_fence [noderef] __rcu *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1256:25: sparse:    struct dma_fence *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1257:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1257:17: sparse:    struct dma_fence [noderef] __rcu *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1257:17: sparse:    struct dma_fence *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1307:23: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1313:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1313:17: sparse:    struct dma_fence [noderef] __rcu *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1313:17: sparse:    struct dma_fence *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:1341:32: sparse: sparse: cast to restricted __le32
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:155:9: sparse: sparse: incompatible types in conditional expression (different base types):
   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:155:9: sparse:    void
   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:155:9: sparse:    int
   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:526:5: sparse: sparse: symbol 'psp_ta_invoke' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:2036:36: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:2037:41: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:2038:36: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:2040:33: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:2078:44: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:2079:49: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:2080:42: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:2081:42: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:2083:33: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:2085:33: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:2088:50: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:2090:41: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:2091:50: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:2093:41: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:2097:50: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:2099:53: sparse: sparse: cast to restricted __le32
>> drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:2187:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *to @@     got void *[assigned] cpu_addr @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:2187:9: sparse:     expected void volatile [noderef] __iomem *to
   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:2187:9: sparse:     got void *[assigned] cpu_addr
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:210:21: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:215:34: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:216:34: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:241:30: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:242:30: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:243:30: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:249:40: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:255:28: sparse: sparse: cast to restricted __le32
>> drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:384:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *from @@     got void *[assigned] ptr @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:384:25: sparse:     expected void const volatile [noderef] __iomem *from
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:384:25: sparse:     got void *[assigned] ptr
>> drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:409:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *to @@     got void *[assigned] ptr @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:409:25: sparse:     expected void volatile [noderef] __iomem *to
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:409:25: sparse:     got void *[assigned] ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:418:42: sparse: sparse: cast to restricted __le32
>> drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:419:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *to @@     got void *cpu_addr @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:419:33: sparse:     expected void volatile [noderef] __iomem *to
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:419:33: sparse:     got void *cpu_addr
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:419:33: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:421:41: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:422:40: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:424:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *dst @@     got void *[assigned] ptr @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:424:25: sparse:     expected void volatile [noderef] __iomem *dst
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:424:25: sparse:     got void *[assigned] ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:683:35: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1151:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1151:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1151:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1152:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1152:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1152:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1153:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1153:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1153:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1154:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1154:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1154:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1155:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1155:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1155:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1156:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1156:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1156:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1157:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1157:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1157:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1158:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1158:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1158:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1159:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1159:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1159:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1160:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1160:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1160:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1161:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1161:17: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1161:17: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1163:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1163:24: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1163:24: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1183:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1183:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1183:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1184:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1184:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1184:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1185:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1185:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1185:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1186:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1186:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1186:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1188:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1188:24: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:1188:24: sparse:     got restricted __le32 [usertype]
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c:177:25: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c:314:18: sparse: sparse: cast to restricted __le32
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c:315:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *to @@     got void *[addressable] cpu_addr @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c:315:9: sparse:     expected void volatile [noderef] __iomem *to
   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c:315:9: sparse:     got void *[addressable] cpu_addr
--
   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:456:25: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:456:25: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:456:25: sparse: sparse: cast to restricted __le32
>> drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:567:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *from @@     got void *ptr @@
>> drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:567:17: sparse:     expected void const volatile [noderef] __iomem *from
   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:567:17: sparse:     got void *ptr
>> drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:589:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *to @@     got void *ptr @@
>> drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:589:17: sparse:     expected void volatile [noderef] __iomem *to
   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:589:17: sparse:     got void *ptr
   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:1044:27: sparse: sparse: symbol 'vce_v4_0_ip_funcs' was not declared. Should it be static?
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:131:32: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:139:21: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:143:26: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:144:30: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:146:28: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:147:24: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:153:29: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:154:34: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:155:34: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:162:28: sparse: sparse: cast to restricted __le32
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:260:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *from @@     got void *[assigned] ptr @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:260:17: sparse:     expected void const volatile [noderef] __iomem *from
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:260:17: sparse:     got void *[assigned] ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:271:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *from @@     got void *[assigned] ptr @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:271:17: sparse:     expected void const volatile [noderef] __iomem *from
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:271:17: sparse:     got void *[assigned] ptr
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:292:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *to @@     got void *[assigned] ptr @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:292:25: sparse:     expected void volatile [noderef] __iomem *to
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:292:25: sparse:     got void *[assigned] ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:301:42: sparse: sparse: cast to restricted __le32
>> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:302:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *to @@     got void *cpu_addr @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:302:33: sparse:     expected void volatile [noderef] __iomem *to
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:302:33: sparse:     got void *cpu_addr
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:302:33: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:304:41: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:305:40: sparse: sparse: cast to restricted __le32
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:307:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *dst @@     got void *[assigned] ptr @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:307:25: sparse:     expected void volatile [noderef] __iomem *dst
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:307:25: sparse:     got void *[assigned] ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:317:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *to @@     got void *[assigned] ptr @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:317:25: sparse:     expected void volatile [noderef] __iomem *to
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:317:25: sparse:     got void *[assigned] ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:319:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *dst @@     got void *[assigned] ptr @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:319:25: sparse:     expected void volatile [noderef] __iomem *dst
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:319:25: sparse:     got void *[assigned] ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:503:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:503:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:503:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:504:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:504:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:504:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:505:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:505:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:505:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:506:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:506:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:506:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:507:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:507:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:507:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:508:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:508:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:508:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:509:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:509:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:509:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:510:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:510:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:510:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:511:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:511:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:511:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:512:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:512:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:512:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:513:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:513:17: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:513:17: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:514:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:514:17: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:514:17: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:515:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:515:17: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:515:17: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:516:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:516:17: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:516:17: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:518:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:518:24: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:518:24: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:537:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:537:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:537:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:538:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:538:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:538:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:539:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:539:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:539:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:540:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:540:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:540:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:541:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:541:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:541:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:542:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:542:16: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:542:16: sparse:     got restricted __le32 [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:544:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:544:24: sparse:     expected unsigned int [usertype]
   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:544:24: sparse:     got restricted __le32 [usertype]
--
   drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_smumgr.c:65:25: sparse: sparse: cast to restricted __be32
   drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_smumgr.c:65:25: sparse: sparse: cast to restricted __be32
   drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_smumgr.c:65:25: sparse: sparse: cast to restricted __be32
   drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_smumgr.c:65:25: sparse: sparse: cast to restricted __be32
   drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_smumgr.c:65:25: sparse: sparse: cast to restricted __be32
   drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_smumgr.c:65:25: sparse: sparse: cast to restricted __be32
   drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_smumgr.c:74:26: sparse: sparse: cast to restricted __be32
   drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_smumgr.c:74:26: sparse: sparse: cast to restricted __be32
   drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_smumgr.c:74:26: sparse: sparse: cast to restricted __be32
   drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_smumgr.c:74:26: sparse: sparse: cast to restricted __be32
   drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_smumgr.c:74:26: sparse: sparse: cast to restricted __be32
   drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_smumgr.c:74:26: sparse: sparse: cast to restricted __be32
>> drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_smumgr.c:408:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *to @@     got void *kaddr @@
>> drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_smumgr.c:408:9: sparse:     expected void volatile [noderef] __iomem *to
   drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_smumgr.c:408:9: sparse:     got void *kaddr
--
>> drivers/char/nwflash.c:591:28: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char volatile *static [toplevel] FLASH_BASE @@     got void [noderef] __iomem * @@
   drivers/char/nwflash.c:591:28: sparse:     expected unsigned char volatile *static [toplevel] FLASH_BASE
>> drivers/char/nwflash.c:591:28: sparse:     got void [noderef] __iomem *
>> drivers/char/nwflash.c:598:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got void * @@
>> drivers/char/nwflash.c:598:34: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/char/nwflash.c:598:34: sparse:     got void *
   drivers/char/nwflash.c:608:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got void * @@
   drivers/char/nwflash.c:608:34: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/char/nwflash.c:608:34: sparse:     got void *
   drivers/char/nwflash.c:618:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got void * @@
   drivers/char/nwflash.c:618:18: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/char/nwflash.c:618:18: sparse:     got void *
--
   drivers/scsi/hptiop.c:150:17: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:171:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:171:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:171:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:208:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:208:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:208:18: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:209:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:209:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:209:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:244:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] result @@     got int @@
   drivers/scsi/hptiop.c:244:44: sparse:     expected restricted __le32 [usertype] result
   drivers/scsi/hptiop.c:244:44: sparse:     got int
   drivers/scsi/hptiop.c:289:35: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:276:32: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:277:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] cur_rptr @@     got restricted __le32 [usertype] outlist_rptr @@
   drivers/scsi/hptiop.c:277:34: sparse:     expected unsigned int [usertype] cur_rptr
   drivers/scsi/hptiop.c:277:34: sparse:     got restricted __le32 [usertype] outlist_rptr
   drivers/scsi/hptiop.c:283:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] _tag @@     got restricted __le32 [usertype] val @@
   drivers/scsi/hptiop.c:283:38: sparse:     expected unsigned int [usertype] _tag
   drivers/scsi/hptiop.c:283:38: sparse:     got restricted __le32 [usertype] val
   drivers/scsi/hptiop.c:288:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] outlist_rptr @@     got unsigned int [assigned] [usertype] cur_rptr @@
   drivers/scsi/hptiop.c:288:52: sparse:     expected restricted __le32 [usertype] outlist_rptr
   drivers/scsi/hptiop.c:288:52: sparse:     got unsigned int [assigned] [usertype] cur_rptr
   drivers/scsi/hptiop.c:369:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:369:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:369:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:370:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:370:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:370:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:453:64: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct hpt_iop_request_get_config *info @@     got struct hpt_iop_request_get_config [noderef] __iomem *config @@
   drivers/scsi/hptiop.c:453:64: sparse:     expected struct hpt_iop_request_get_config *info
   drivers/scsi/hptiop.c:453:64: sparse:     got struct hpt_iop_request_get_config [noderef] __iomem *config
   drivers/scsi/hptiop.c:455:25: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:557:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:557:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:557:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:637:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct hpt_iopmv_regs *regs @@     got void [noderef] __iomem * @@
   drivers/scsi/hptiop.c:637:24: sparse:     expected struct hpt_iopmv_regs *regs
   drivers/scsi/hptiop.c:637:24: sparse:     got void [noderef] __iomem *
>> drivers/scsi/hptiop.c:643:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got struct hpt_iopmv_regs *regs @@
>> drivers/scsi/hptiop.c:643:34: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/scsi/hptiop.c:643:34: sparse:     got struct hpt_iopmv_regs *regs
   drivers/scsi/hptiop.c:667:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got struct hpt_iopmv_regs *regs @@
   drivers/scsi/hptiop.c:667:26: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/scsi/hptiop.c:667:26: sparse:     got struct hpt_iopmv_regs *regs
   drivers/scsi/hptiop.c:934:27: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:939:34: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:940:30: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:944:43: sparse: sparse: invalid assignment: &=
   drivers/scsi/hptiop.c:944:43: sparse:    left side has type restricted __le32
   drivers/scsi/hptiop.c:944:43: sparse:    right side has type int
   drivers/scsi/hptiop.c:945:43: sparse: sparse: invalid assignment: ^=
   drivers/scsi/hptiop.c:945:43: sparse:    left side has type restricted __le32
   drivers/scsi/hptiop.c:945:43: sparse:    right side has type int
   drivers/scsi/hptiop.c:950:57: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hptiop.c:950:48: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] intrfc_len @@     got unsigned int @@
   drivers/scsi/hptiop.c:950:48: sparse:     expected restricted __le32 [usertype] intrfc_len
   drivers/scsi/hptiop.c:950:48: sparse:     got unsigned int
   drivers/scsi/hptiop.c:951:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:976:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:978:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:981:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:983:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:986:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:988:9: sparse: sparse: cast from restricted __le32
   drivers/scsi/hptiop.c:991:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] inlist_wptr @@     got unsigned int @@
   drivers/scsi/hptiop.c:991:35: sparse:     expected restricted __le32 [usertype] inlist_wptr
   drivers/scsi/hptiop.c:991:35: sparse:     got unsigned int
   drivers/scsi/hptiop.c:992:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] @@     got unsigned int @@
   drivers/scsi/hptiop.c:992:37: sparse:     expected restricted __le32 [usertype]
   drivers/scsi/hptiop.c:992:37: sparse:     got unsigned int
   drivers/scsi/hptiop.c:993:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] outlist_rptr @@     got unsigned int @@
   drivers/scsi/hptiop.c:993:36: sparse:     expected restricted __le32 [usertype] outlist_rptr
   drivers/scsi/hptiop.c:993:36: sparse:     got unsigned int
   drivers/scsi/hptiop.c:1536:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:1536:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:1536:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:1537:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got restricted __le32 * @@
   drivers/scsi/hptiop.c:1537:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/hptiop.c:1537:9: sparse:     got restricted __le32 *
   drivers/scsi/hptiop.c:150:17: sparse: sparse: dereference of noderef expression
   drivers/scsi/hptiop.c:150:17: sparse: sparse: dereference of noderef expression
--
>> drivers/scsi/mvumi.c:81:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/mvumi.c:81:52: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/mvumi.c:81:52: sparse:     got void *
   drivers/scsi/mvumi.c:90:39: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   drivers/scsi/mvumi.c:90:39: sparse:     expected void *
   drivers/scsi/mvumi.c:90:39: sparse:     got void [noderef] __iomem *
   drivers/scsi/mvumi.c:210:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] baseaddr_l @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:210:34: sparse:     expected unsigned int [usertype] baseaddr_l
   drivers/scsi/mvumi.c:210:34: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:211:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] baseaddr_h @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:211:34: sparse:     expected unsigned int [usertype] baseaddr_h
   drivers/scsi/mvumi.c:211:34: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:213:17: sparse: sparse: invalid assignment: |=
   drivers/scsi/mvumi.c:213:17: sparse:    left side has type unsigned int
   drivers/scsi/mvumi.c:213:17: sparse:    right side has type restricted __le32
   drivers/scsi/mvumi.c:213:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] size @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:213:17: sparse:     expected unsigned int [usertype] size
   drivers/scsi/mvumi.c:213:17: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:242:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] baseaddr_l @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:242:26: sparse:     expected unsigned int [usertype] baseaddr_l
   drivers/scsi/mvumi.c:242:26: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:243:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] baseaddr_h @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:243:26: sparse:     expected unsigned int [usertype] baseaddr_h
   drivers/scsi/mvumi.c:243:26: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:245:9: sparse: sparse: invalid assignment: |=
   drivers/scsi/mvumi.c:245:9: sparse:    left side has type unsigned int
   drivers/scsi/mvumi.c:245:9: sparse:    right side has type restricted __le32
   drivers/scsi/mvumi.c:245:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] size @@     got restricted __le32 [usertype] @@
   drivers/scsi/mvumi.c:245:9: sparse:     expected unsigned int [usertype] size
   drivers/scsi/mvumi.c:245:9: sparse:     got restricted __le32 [usertype]
   drivers/scsi/mvumi.c:407:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *inb_read_pointer @@
   drivers/scsi/mvumi.c:407:40: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:407:40: sparse:     got void *inb_read_pointer
   drivers/scsi/mvumi.c:429:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *ib_shadow @@
   drivers/scsi/mvumi.c:429:30: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:429:30: sparse:     got void *ib_shadow
   drivers/scsi/mvumi.c:458:31: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *ib_shadow @@
   drivers/scsi/mvumi.c:458:31: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:458:31: sparse:     got void *ib_shadow
   drivers/scsi/mvumi.c:459:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *inb_write_pointer @@
   drivers/scsi/mvumi.c:459:48: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:459:48: sparse:     got void *inb_write_pointer
   drivers/scsi/mvumi.c:496:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *outb_copy_pointer @@
   drivers/scsi/mvumi.c:496:41: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:496:41: sparse:     got void *outb_copy_pointer
   drivers/scsi/mvumi.c:497:48: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *ob_shadow @@
   drivers/scsi/mvumi.c:497:48: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:497:48: sparse:     got void *ob_shadow
   drivers/scsi/mvumi.c:516:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *outb_read_pointer @@
   drivers/scsi/mvumi.c:516:33: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:516:33: sparse:     got void *outb_read_pointer
   drivers/scsi/mvumi.c:517:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *outb_copy_pointer @@
   drivers/scsi/mvumi.c:517:33: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:517:33: sparse:     got void *outb_copy_pointer
   drivers/scsi/mvumi.c:578:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *outb_read_pointer @@
   drivers/scsi/mvumi.c:578:42: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:578:42: sparse:     got void *outb_read_pointer
   drivers/scsi/mvumi.c:585:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:585:26: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:585:26: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:586:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *arm_to_pciea_msg1 @@
   drivers/scsi/mvumi.c:586:26: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:586:26: sparse:     got void *arm_to_pciea_msg1
   drivers/scsi/mvumi.c:589:40: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *pciea_to_arm_drbl_reg @@
   drivers/scsi/mvumi.c:589:40: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:589:40: sparse:     got void *pciea_to_arm_drbl_reg
   drivers/scsi/mvumi.c:1281:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *arm_to_pciea_drbl_reg @@
   drivers/scsi/mvumi.c:1281:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1281:28: sparse:     got void *arm_to_pciea_drbl_reg
   drivers/scsi/mvumi.c:1282:28: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *arm_to_pciea_drbl_reg @@
   drivers/scsi/mvumi.c:1282:28: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1282:28: sparse:     got void *arm_to_pciea_drbl_reg
   drivers/scsi/mvumi.c:1284:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *arm_to_pciea_mask_reg @@
   drivers/scsi/mvumi.c:1284:48: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1284:48: sparse:     got void *arm_to_pciea_mask_reg
   drivers/scsi/mvumi.c:1285:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:1285:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1285:28: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:1286:28: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:1286:28: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:1286:28: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:612:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *enpointa_mask_reg @@
   drivers/scsi/mvumi.c:612:26: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:612:26: sparse:     got void *enpointa_mask_reg
   drivers/scsi/mvumi.c:613:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *arm_to_pciea_msg1 @@
   drivers/scsi/mvumi.c:613:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:613:28: sparse:     got void *arm_to_pciea_msg1
   drivers/scsi/mvumi.c:615:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *pciea_to_arm_drbl_reg @@
   drivers/scsi/mvumi.c:615:46: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:615:46: sparse:     got void *pciea_to_arm_drbl_reg
   drivers/scsi/mvumi.c:624:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *arm_to_pciea_msg1 @@
   drivers/scsi/mvumi.c:624:36: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:624:36: sparse:     got void *arm_to_pciea_msg1
   drivers/scsi/mvumi.c:670:32: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *reset_enable @@
   drivers/scsi/mvumi.c:670:32: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:670:32: sparse:     got void *reset_enable
   drivers/scsi/mvumi.c:671:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *reset_request @@
   drivers/scsi/mvumi.c:671:34: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/mvumi.c:671:34: sparse:     got void *reset_request
   drivers/scsi/mvumi.c:673:35: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *reset_enable @@
   drivers/scsi/mvumi.c:673:35: sparse:     expected void volatile [noderef] __iomem *addr
--
   drivers/gpu/drm/ttm/ttm_bo_util.c:219:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[assigned] addr @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:219:30: sparse:     expected void *[assigned] addr
   drivers/gpu/drm/ttm/ttm_bo_util.c:219:30: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/ttm/ttm_bo_util.c:221:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[assigned] addr @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:221:30: sparse:     expected void *[assigned] addr
   drivers/gpu/drm/ttm/ttm_bo_util.c:221:30: sparse:     got void [noderef] __iomem *
>> drivers/gpu/drm/ttm/ttm_bo_util.c:241:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got void *virtual @@
>> drivers/gpu/drm/ttm/ttm_bo_util.c:241:25: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/gpu/drm/ttm/ttm_bo_util.c:241:25: sparse:     got void *virtual
   drivers/gpu/drm/ttm/ttm_bo_util.c:256:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:256:40: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/ttm/ttm_bo_util.c:256:40: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/ttm/ttm_bo_util.c:256:49: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:256:49: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/ttm/ttm_bo_util.c:256:49: sparse:     got unsigned int [usertype] *
>> drivers/gpu/drm/ttm/ttm_bo_util.c:275:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *from @@     got void *[assigned] src @@
>> drivers/gpu/drm/ttm/ttm_bo_util.c:275:9: sparse:     expected void const volatile [noderef] __iomem *from
   drivers/gpu/drm/ttm/ttm_bo_util.c:275:9: sparse:     got void *[assigned] src
>> drivers/gpu/drm/ttm/ttm_bo_util.c:297:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *to @@     got void *[assigned] dst @@
>> drivers/gpu/drm/ttm/ttm_bo_util.c:297:9: sparse:     expected void volatile [noderef] __iomem *to
   drivers/gpu/drm/ttm/ttm_bo_util.c:297:9: sparse:     got void *[assigned] dst
   drivers/gpu/drm/ttm/ttm_bo_util.c:344:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *dst @@     got void *[addressable] new_iomap @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:344:17: sparse:     expected void volatile [noderef] __iomem *dst
   drivers/gpu/drm/ttm/ttm_bo_util.c:344:17: sparse:     got void *[addressable] new_iomap
   drivers/gpu/drm/ttm/ttm_bo_util.c:516:38: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *virtual @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:516:38: sparse:     expected void *virtual
   drivers/gpu/drm/ttm/ttm_bo_util.c:516:38: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/ttm/ttm_bo_util.c:519:38: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *virtual @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:519:38: sparse:     expected void *virtual
   drivers/gpu/drm/ttm/ttm_bo_util.c:519:38: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/ttm/ttm_bo_util.c:608:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got void *virtual @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:608:28: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/gpu/drm/ttm/ttm_bo_util.c:608:28: sparse:     got void *virtual
--
   drivers/gpu/drm/mgag200/mgag200_cursor.c:32:44: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/mgag200/mgag200_cursor.c:32:44: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/mgag200/mgag200_cursor.c:32:44: sparse:     got void *
   drivers/gpu/drm/mgag200/mgag200_cursor.c:85:52: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/mgag200/mgag200_cursor.c:85:52: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/mgag200/mgag200_cursor.c:85:52: sparse:     got void *
>> drivers/gpu/drm/mgag200/mgag200_cursor.c:103:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *to @@     got void * @@
>> drivers/gpu/drm/mgag200/mgag200_cursor.c:103:17: sparse:     expected void volatile [noderef] __iomem *to
   drivers/gpu/drm/mgag200/mgag200_cursor.c:103:17: sparse:     got void *
--
   drivers/gpu/drm/qxl/qxl_kms.c:36:5: sparse: sparse: symbol 'qxl_log_level' was not declared. Should it be static?
   drivers/gpu/drm/qxl/qxl_kms.c:170:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct qxl_rom *rom @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/qxl/qxl_kms.c:170:19: sparse:     expected struct qxl_rom *rom
   drivers/gpu/drm/qxl/qxl_kms.c:170:19: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/qxl/qxl_kms.c:188:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct qxl_ram_header *ram_header @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/qxl/qxl_kms.c:188:26: sparse:     expected struct qxl_ram_header *ram_header
   drivers/gpu/drm/qxl/qxl_kms.c:188:26: sparse:     got void [noderef] __iomem *
>> drivers/gpu/drm/qxl/qxl_kms.c:277:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got struct qxl_ram_header *ram_header @@
>> drivers/gpu/drm/qxl/qxl_kms.c:277:21: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/gpu/drm/qxl/qxl_kms.c:277:21: sparse:     got struct qxl_ram_header *ram_header
>> drivers/gpu/drm/qxl/qxl_kms.c:281:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got struct qxl_rom *rom @@
   drivers/gpu/drm/qxl/qxl_kms.c:281:21: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/gpu/drm/qxl/qxl_kms.c:281:21: sparse:     got struct qxl_rom *rom
   drivers/gpu/drm/qxl/qxl_kms.c:301:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got struct qxl_ram_header *ram_header @@
   drivers/gpu/drm/qxl/qxl_kms.c:301:21: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/gpu/drm/qxl/qxl_kms.c:301:21: sparse:     got struct qxl_ram_header *ram_header
   drivers/gpu/drm/qxl/qxl_kms.c:302:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got struct qxl_rom *rom @@
   drivers/gpu/drm/qxl/qxl_kms.c:302:21: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/gpu/drm/qxl/qxl_kms.c:302:21: sparse:     got struct qxl_rom *rom
--
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:104:58: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:104:58: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:104:58: sparse:     got void *
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:110:58: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:110:58: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:110:58: sparse:     got void *
>> drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:157:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got void *[assigned] emap @@
>> drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:157:25: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:157:25: sparse:     got void *[assigned] emap
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:174:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *map @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:174:19: sparse:     expected void *map
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:174:19: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:225:28: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void *map @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:225:28: sparse:     expected void [noderef] __iomem *
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:225:28: sparse:     got void *map
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:233:28: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void *map @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:233:28: sparse:     expected void [noderef] __iomem *
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:233:28: sparse:     got void *map
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:240:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *map @@     got void *map @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:240:21: sparse:     expected void [noderef] __iomem *map
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:240:21: sparse:     got void *map
>> drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:327:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got void *[assigned] map @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:327:25: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:327:25: sparse:     got void *[assigned] map
--
   drivers/isdn/hardware/mISDN/hfcmulti.c:452:17: sparse: sparse: cast from restricted __le32
   drivers/isdn/hardware/mISDN/hfcmulti.c:457:17: sparse: sparse: cast from restricted __le16
   drivers/isdn/hardware/mISDN/hfcmulti.c:472:17: sparse: sparse: cast from restricted __le32
   drivers/isdn/hardware/mISDN/hfcmulti.c:478:17: sparse: sparse: cast from restricted __le16
   drivers/isdn/hardware/mISDN/hfcmulti.c:496:32: sparse: sparse: cast to restricted __le32
   drivers/isdn/hardware/mISDN/hfcmulti.c:501:32: sparse: sparse: cast to restricted __le16
   drivers/isdn/hardware/mISDN/hfcmulti.c:518:25: sparse: sparse: cast to restricted __le32
   drivers/isdn/hardware/mISDN/hfcmulti.c:524:25: sparse: sparse: cast to restricted __le16
>> drivers/isdn/hardware/mISDN/hfcmulti.c:1092:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got void * @@
>> drivers/isdn/hardware/mISDN/hfcmulti.c:1092:26: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/isdn/hardware/mISDN/hfcmulti.c:1092:26: sparse:     got void *

vim +979 drivers/gpu/drm/radeon/radeon_ttm.c

2014b5694182b5 Christian König 2013-12-18  954  
2014b5694182b5 Christian König 2013-12-18  955  static ssize_t radeon_ttm_vram_read(struct file *f, char __user *buf,
2014b5694182b5 Christian König 2013-12-18  956  				    size_t size, loff_t *pos)
2014b5694182b5 Christian König 2013-12-18  957  {
2014b5694182b5 Christian König 2013-12-18  958  	struct radeon_device *rdev = f->private_data;
2014b5694182b5 Christian König 2013-12-18  959  	ssize_t result = 0;
2014b5694182b5 Christian König 2013-12-18  960  	int r;
2014b5694182b5 Christian König 2013-12-18  961  
2014b5694182b5 Christian König 2013-12-18  962  	if (size & 0x3 || *pos & 0x3)
2014b5694182b5 Christian König 2013-12-18  963  		return -EINVAL;
2014b5694182b5 Christian König 2013-12-18  964  
2014b5694182b5 Christian König 2013-12-18  965  	while (size) {
2014b5694182b5 Christian König 2013-12-18  966  		unsigned long flags;
2014b5694182b5 Christian König 2013-12-18  967  		uint32_t value;
2014b5694182b5 Christian König 2013-12-18  968  
2014b5694182b5 Christian König 2013-12-18  969  		if (*pos >= rdev->mc.mc_vram_size)
2014b5694182b5 Christian König 2013-12-18  970  			return result;
2014b5694182b5 Christian König 2013-12-18  971  
2014b5694182b5 Christian König 2013-12-18  972  		spin_lock_irqsave(&rdev->mmio_idx_lock, flags);
2014b5694182b5 Christian König 2013-12-18  973  		WREG32(RADEON_MM_INDEX, ((uint32_t)*pos) | 0x80000000);
2014b5694182b5 Christian König 2013-12-18  974  		if (rdev->family >= CHIP_CEDAR)
2014b5694182b5 Christian König 2013-12-18  975  			WREG32(EVERGREEN_MM_INDEX_HI, *pos >> 31);
2014b5694182b5 Christian König 2013-12-18  976  		value = RREG32(RADEON_MM_DATA);
2014b5694182b5 Christian König 2013-12-18  977  		spin_unlock_irqrestore(&rdev->mmio_idx_lock, flags);
2014b5694182b5 Christian König 2013-12-18  978  
2014b5694182b5 Christian König 2013-12-18 @979  		r = put_user(value, (uint32_t *)buf);
2014b5694182b5 Christian König 2013-12-18  980  		if (r)
2014b5694182b5 Christian König 2013-12-18  981  			return r;
2014b5694182b5 Christian König 2013-12-18  982  
2014b5694182b5 Christian König 2013-12-18  983  		result += 4;
2014b5694182b5 Christian König 2013-12-18  984  		buf += 4;
2014b5694182b5 Christian König 2013-12-18  985  		*pos += 4;
2014b5694182b5 Christian König 2013-12-18  986  		size -= 4;
2014b5694182b5 Christian König 2013-12-18  987  	}
2014b5694182b5 Christian König 2013-12-18  988  
2014b5694182b5 Christian König 2013-12-18  989  	return result;
2014b5694182b5 Christian König 2013-12-18  990  }
2014b5694182b5 Christian König 2013-12-18  991  

:::::: The code at line 979 was first introduced by commit
:::::: 2014b5694182b54c781b93d26ec993f8a12bca01 drm/radeon: add VRAM debugfs access v3

:::::: TO: Christian König <christian.koenig@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--y0ulUmNC+osPPQO6
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
Cf6MCtIqjMfi/6y6zRd7AwIA

--y0ulUmNC+osPPQO6--
