Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B99C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E791520732
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgFVPd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 11:33:27 -0400
Received: from mga17.intel.com ([192.55.52.151]:17881 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729341AbgFVPd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 11:33:26 -0400
IronPort-SDR: h3jNkWKpvlEz+b47Y+zqGWA6IwGjR6EsNpOoWblEPPpoVb8sORi2vs70dI8MMdmunUR9jcryKN
 /J4hdMIoMe0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9659"; a="124045569"
X-IronPort-AV: E=Sophos;i="5.75,267,1589266800"; 
   d="gz'50?scan'50,208,50";a="124045569"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 07:26:21 -0700
IronPort-SDR: uXcK4dBP1wmJyBMeYwdjnolXsGYjg5Qg6gxGk2idQjLbuHdlrLNuVEXhOlG+gd4WHOedLRDp7p
 Xs49BmgVniXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,267,1589266800"; 
   d="gz'50?scan'50,208,50";a="422644172"
Received: from lkp-server01.sh.intel.com (HELO f484c95e4fd1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 22 Jun 2020 07:26:18 -0700
Received: from kbuild by f484c95e4fd1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jnNOr-0000L1-Ow; Mon, 22 Jun 2020 14:26:17 +0000
Date:   Mon, 22 Jun 2020 22:25:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/gpio/gpio-sa1100.c:104:21: sparse: sparse: cast removes
 address space '__iomem' of expression
Message-ID: <202006222230.CwVZOYsu%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   625d3449788f85569096780592549d0340e9c0c7
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   4 days ago
config: arm-randconfig-s031-20200622 (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.2-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=arm CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/gpio/gpio-sa1100.c:104:21: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/gpio/gpio-sa1100.c:104:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *membase @@     got void * @@
>> drivers/gpio/gpio-sa1100.c:104:21: sparse:     expected void [noderef] __iomem *membase
   drivers/gpio/gpio-sa1100.c:104:21: sparse:     got void *
>> drivers/gpio/gpio-sa1100.c:115:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void *base @@     got void [noderef] __iomem *membase @@
   drivers/gpio/gpio-sa1100.c:115:25: sparse:     expected void *base
>> drivers/gpio/gpio-sa1100.c:115:25: sparse:     got void [noderef] __iomem *membase
>> drivers/gpio/gpio-sa1100.c:121:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/gpio/gpio-sa1100.c:121:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpio/gpio-sa1100.c:121:9: sparse:     got void *
   drivers/gpio/gpio-sa1100.c:122:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpio/gpio-sa1100.c:122:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpio/gpio-sa1100.c:122:9: sparse:     got void *
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
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const [noderef] __user *__pu_ptr @@     got unsigned int [usertype] * @@
>> drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse:     expected unsigned int const [noderef] __user *__pu_ptr
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
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
>> drivers/scsi/mvumi.c:81:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/mvumi.c:81:52: sparse:     expected void [noderef] __iomem *addr
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
   drivers/scsi/mvumi.c:673:35: sparse:     got void *reset_enable

vim +/__iomem +104 drivers/gpio/gpio-sa1100.c

f408c985cefc9b drivers/gpio/gpio-sa1100.c  Russell King            2011-12-18   91  
07242b248119a9 drivers/gpio/gpio-sa1100.c  Russell King            2016-08-31   92  static struct sa1100_gpio_chip sa1100_gpio_chip = {
07242b248119a9 drivers/gpio/gpio-sa1100.c  Russell King            2016-08-31   93  	.chip = {
45528e38173e7d arch/arm/mach-sa1100/gpio.c Dmitry Eremin-Solenikov 2008-04-10   94  		.label			= "gpio",
c65d1fd350fa28 drivers/gpio/gpio-sa1100.c  Russell King            2016-08-31   95  		.get_direction		= sa1100_get_direction,
45528e38173e7d arch/arm/mach-sa1100/gpio.c Dmitry Eremin-Solenikov 2008-04-10   96  		.direction_input	= sa1100_direction_input,
45528e38173e7d arch/arm/mach-sa1100/gpio.c Dmitry Eremin-Solenikov 2008-04-10   97  		.direction_output	= sa1100_direction_output,
45528e38173e7d arch/arm/mach-sa1100/gpio.c Dmitry Eremin-Solenikov 2008-04-10   98  		.set			= sa1100_gpio_set,
45528e38173e7d arch/arm/mach-sa1100/gpio.c Dmitry Eremin-Solenikov 2008-04-10   99  		.get			= sa1100_gpio_get,
f408c985cefc9b drivers/gpio/gpio-sa1100.c  Russell King            2011-12-18  100  		.to_irq			= sa1100_to_irq,
45528e38173e7d arch/arm/mach-sa1100/gpio.c Dmitry Eremin-Solenikov 2008-04-10  101  		.base			= 0,
45528e38173e7d arch/arm/mach-sa1100/gpio.c Dmitry Eremin-Solenikov 2008-04-10  102  		.ngpio			= GPIO_MAX + 1,
07242b248119a9 drivers/gpio/gpio-sa1100.c  Russell King            2016-08-31  103  	},
07242b248119a9 drivers/gpio/gpio-sa1100.c  Russell King            2016-08-31 @104  	.membase = (void *)&GPLR,
07242b248119a9 drivers/gpio/gpio-sa1100.c  Russell King            2016-08-31  105  	.irqbase = IRQ_GPIO0,
45528e38173e7d arch/arm/mach-sa1100/gpio.c Dmitry Eremin-Solenikov 2008-04-10  106  };
45528e38173e7d arch/arm/mach-sa1100/gpio.c Dmitry Eremin-Solenikov 2008-04-10  107  
a0ea298d325616 drivers/gpio/gpio-sa1100.c  Dmitry Eremin-Solenikov 2015-01-15  108  /*
a0ea298d325616 drivers/gpio/gpio-sa1100.c  Dmitry Eremin-Solenikov 2015-01-15  109   * SA1100 GPIO edge detection for IRQs:
a0ea298d325616 drivers/gpio/gpio-sa1100.c  Dmitry Eremin-Solenikov 2015-01-15  110   * IRQs are generated on Falling-Edge, Rising-Edge, or both.
a0ea298d325616 drivers/gpio/gpio-sa1100.c  Dmitry Eremin-Solenikov 2015-01-15  111   * Use this instead of directly setting GRER/GFER.
a0ea298d325616 drivers/gpio/gpio-sa1100.c  Dmitry Eremin-Solenikov 2015-01-15  112   */
07242b248119a9 drivers/gpio/gpio-sa1100.c  Russell King            2016-08-31  113  static void sa1100_update_edge_regs(struct sa1100_gpio_chip *sgc)
07242b248119a9 drivers/gpio/gpio-sa1100.c  Russell King            2016-08-31  114  {
07242b248119a9 drivers/gpio/gpio-sa1100.c  Russell King            2016-08-31 @115  	void *base = sgc->membase;
07242b248119a9 drivers/gpio/gpio-sa1100.c  Russell King            2016-08-31  116  	u32 grer, gfer;
07242b248119a9 drivers/gpio/gpio-sa1100.c  Russell King            2016-08-31  117  
07242b248119a9 drivers/gpio/gpio-sa1100.c  Russell King            2016-08-31  118  	grer = sgc->irqrising & sgc->irqmask;
07242b248119a9 drivers/gpio/gpio-sa1100.c  Russell King            2016-08-31  119  	gfer = sgc->irqfalling & sgc->irqmask;
07242b248119a9 drivers/gpio/gpio-sa1100.c  Russell King            2016-08-31  120  
07242b248119a9 drivers/gpio/gpio-sa1100.c  Russell King            2016-08-31 @121  	writel_relaxed(grer, base + R_GRER);
07242b248119a9 drivers/gpio/gpio-sa1100.c  Russell King            2016-08-31  122  	writel_relaxed(gfer, base + R_GFER);
07242b248119a9 drivers/gpio/gpio-sa1100.c  Russell King            2016-08-31  123  }
a0ea298d325616 drivers/gpio/gpio-sa1100.c  Dmitry Eremin-Solenikov 2015-01-15  124  

:::::: The code at line 104 was first introduced by commit
:::::: 07242b248119a9388a67975aa7fae7c23afc7a07 gpio: sa1100: convert to use IO accessors

:::::: TO: Russell King <rmk+kernel@armlinux.org.uk>
:::::: CC: Linus Walleij <linus.walleij@linaro.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--bg08WKrSYDhXBjb5
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--bg08WKrSYDhXBjb5--
