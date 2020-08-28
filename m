Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF13FC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0F6C2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgH1OWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:22:51 -0400
Received: from mga14.intel.com ([192.55.52.115]:2927 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbgH1OWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:22:47 -0400
IronPort-SDR: tcIesZk3xN2DUtvRZQb+aCDVZo+TIjXQ9bwcnxWfVC2DlaBp8BZyfLyQwXibywiKPL/Bn1CMpM
 nmPbtDJQ/PWA==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="155927504"
X-IronPort-AV: E=Sophos;i="5.76,364,1592895600"; 
   d="gz'50?scan'50,208,50";a="155927504"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 07:22:35 -0700
IronPort-SDR: LBop4YBRggYP0DCS+DpBBR1h0OIWd/eVtR7LCR7tsYjNIld8Yx057BNOs/xHIopRaqgtnNlcrk
 XUn21XVRaDFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,364,1592895600"; 
   d="gz'50?scan'50,208,50";a="280961713"
Received: from lkp-server02.sh.intel.com (HELO 301dc1beeb51) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 28 Aug 2020 07:22:33 -0700
Received: from kbuild by 301dc1beeb51 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kBfGz-00003G-2x; Fri, 28 Aug 2020 14:22:33 +0000
Date:   Fri, 28 Aug 2020 22:21:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] sparse: use static inline for __chk_{user,io}_ptr()
Message-ID: <202008282258.KRQtHEsi%lkp@intel.com>
References: <20200828085301.78423-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200828085301.78423-1-luc.vanoostenryck@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Luc,

I love your patch! Perhaps something to improve:

[auto build test WARNING on 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5]

url:    https://github.com/0day-ci/linux/commits/Luc-Van-Oostenryck/sparse-use-static-inline-for-__chk_-user-io-_ptr/20200828-165431
base:    9123e3a74ec7b934a4a099e98af6a61c2f80bbf5
config: x86_64-randconfig-s022-20200828 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.2-191-g10164920-dirty
        # save the attached .config to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/gpu/drm/radeon/radeon_ttm.c:969:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c:969:21: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/radeon/radeon_ttm.c:969:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int [usertype] * @@
>> drivers/gpu/drm/radeon/radeon_ttm.c:969:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/radeon/radeon_ttm.c:969:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/radeon/radeon_ttm.c:969:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c:969:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c:969:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c:969:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c:969:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c:969:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c:969:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c:969:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c:969:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c:969:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c:969:21: sparse: sparse: cast removes address space '__user' of expression
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:828:42: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2389:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2389:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2389:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2389:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2389:21: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2389:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int [usertype] * @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2389:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2389:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2389:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2389:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2389:21: sparse: sparse: cast removes address space '__user' of expression
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int [usertype] * @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse:     expected void const volatile [noderef] __user *ptr
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
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse:     expected void const volatile [noderef] __user *ptr
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
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse: sparse: cast removes address space '__user' of expression
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:138:17: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t ( *poll )( ... ) @@     got unsigned int ( * )( ... ) @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:138:17: sparse:     expected restricted __poll_t ( *poll )( ... )
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:138:17: sparse:     got unsigned int ( * )( ... )
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:261:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:261:29: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:261:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int [usertype] * @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:261:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:261:29: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:261:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:261:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:261:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:261:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:261:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:261:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:261:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:261:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:261:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:261:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:261:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:263:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:263:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:263:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:263:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:263:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:263:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:263:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:263:29: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:263:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:263:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:263:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:354:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:354:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:354:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:354:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:354:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:354:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:354:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:354:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:354:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:354:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:354:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:354:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:354:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:354:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:354:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:354:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:412:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:412:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:412:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:412:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:412:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:412:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:412:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:412:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:412:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:412:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:412:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:473:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:473:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:473:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:473:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:473:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:473:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:473:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:473:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:473:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:473:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:473:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:473:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:473:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:473:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:473:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:473:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:531:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:531:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:531:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:531:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:531:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:531:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:531:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:531:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:531:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:531:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:531:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:592:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:592:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:592:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:592:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:592:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:592:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:592:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:592:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:592:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:592:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:592:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:592:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:592:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:592:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:592:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:592:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:650:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:650:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:650:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:650:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:650:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:650:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:650:21: sparse:     expected void const volatile [noderef] __user *ptr
--
   arch/x86/ia32/ia32_signal.c:350:9: sparse: sparse: cast removes address space '__user' of expression
>> arch/x86/ia32/ia32_signal.c:350:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long [usertype] * @@
>> arch/x86/ia32/ia32_signal.c:350:9: sparse:     expected void const volatile [noderef] __user *ptr
   arch/x86/ia32/ia32_signal.c:350:9: sparse:     got unsigned long long [usertype] *
   arch/x86/ia32/ia32_signal.c:350:9: sparse: sparse: cast removes address space '__user' of expression
   arch/x86/ia32/ia32_signal.c:350:9: sparse: sparse: cast removes address space '__user' of expression
   arch/x86/ia32/ia32_signal.c:350:9: sparse: sparse: cast removes address space '__user' of expression
   arch/x86/ia32/ia32_signal.c:350:9: sparse: sparse: cast removes address space '__user' of expression
   arch/x86/ia32/ia32_signal.c:350:9: sparse: sparse: cast removes address space '__user' of expression
   arch/x86/ia32/ia32_signal.c:350:9: sparse: sparse: cast removes address space '__user' of expression
   arch/x86/ia32/ia32_signal.c:350:9: sparse: sparse: cast removes address space '__user' of expression
   arch/x86/ia32/ia32_signal.c:350:9: sparse: sparse: cast removes address space '__user' of expression
   arch/x86/ia32/ia32_signal.c:350:9: sparse: sparse: cast removes address space '__user' of expression

# https://github.com/0day-ci/linux/commit/7d01c91ac34a64f0177bc6d058cc50e805f59102
git remote add linux-review https://github.com/0day-ci/linux
git fetch --no-tags linux-review Luc-Van-Oostenryck/sparse-use-static-inline-for-__chk_-user-io-_ptr/20200828-165431
git checkout 7d01c91ac34a64f0177bc6d058cc50e805f59102
vim +969 drivers/gpu/drm/radeon/radeon_ttm.c

771fe6b912fca5 Jerome Glisse         2009-06-05  772  
771fe6b912fca5 Jerome Glisse         2009-06-05 @773  int radeon_ttm_init(struct radeon_device *rdev)
771fe6b912fca5 Jerome Glisse         2009-06-05  774  {
771fe6b912fca5 Jerome Glisse         2009-06-05  775  	int r;
771fe6b912fca5 Jerome Glisse         2009-06-05  776  
771fe6b912fca5 Jerome Glisse         2009-06-05  777  	/* No others user of address space so set it to 0 */
771fe6b912fca5 Jerome Glisse         2009-06-05  778  	r = ttm_bo_device_init(&rdev->mman.bdev,
44d847b7439bde David Herrmann        2013-08-13  779  			       &radeon_bo_driver,
44d847b7439bde David Herrmann        2013-08-13  780  			       rdev->ddev->anon_inode->i_mapping,
8b53e1cb2728b6 Gerd Hoffmann         2019-09-05  781  			       rdev->ddev->vma_offset_manager,
33b3ad3788aba8 Christoph Hellwig     2019-08-15  782  			       dma_addressing_limited(&rdev->pdev->dev));
771fe6b912fca5 Jerome Glisse         2009-06-05  783  	if (r) {
771fe6b912fca5 Jerome Glisse         2009-06-05  784  		DRM_ERROR("failed initializing buffer object driver(%d).\n", r);
771fe6b912fca5 Jerome Glisse         2009-06-05  785  		return r;
771fe6b912fca5 Jerome Glisse         2009-06-05  786  	}
0a0c7596c64323 Jerome Glisse         2009-12-11  787  	rdev->mman.initialized = true;
4c7886791264f0 Jerome Glisse         2009-11-20  788  	r = ttm_bo_init_mm(&rdev->mman.bdev, TTM_PL_VRAM,
312ea8da049a18 Jerome Glisse         2009-12-07  789  				rdev->mc.real_vram_size >> PAGE_SHIFT);
771fe6b912fca5 Jerome Glisse         2009-06-05  790  	if (r) {
771fe6b912fca5 Jerome Glisse         2009-06-05  791  		DRM_ERROR("Failed initializing VRAM heap.\n");
771fe6b912fca5 Jerome Glisse         2009-06-05  792  		return r;
771fe6b912fca5 Jerome Glisse         2009-06-05  793  	}
14eedc32a3c0ec Lauri Kasanen         2014-02-28  794  	/* Change the size here instead of the init above so only lpfn is affected */
14eedc32a3c0ec Lauri Kasanen         2014-02-28  795  	radeon_ttm_set_active_vram_size(rdev, rdev->mc.visible_vram_size);
14eedc32a3c0ec Lauri Kasanen         2014-02-28  796  
441921d5309cfe Daniel Vetter         2011-02-18  797  	r = radeon_bo_create(rdev, 256 * 1024, PAGE_SIZE, true,
831b6966a60fe7 Maarten Lankhorst     2014-09-18  798  			     RADEON_GEM_DOMAIN_VRAM, 0, NULL,
4aa5b92fd48f88 Kent Russell          2017-08-08  799  			     NULL, &rdev->stolen_vga_memory);
771fe6b912fca5 Jerome Glisse         2009-06-05  800  	if (r) {
771fe6b912fca5 Jerome Glisse         2009-06-05  801  		return r;
771fe6b912fca5 Jerome Glisse         2009-06-05  802  	}
4aa5b92fd48f88 Kent Russell          2017-08-08  803  	r = radeon_bo_reserve(rdev->stolen_vga_memory, false);
4c7886791264f0 Jerome Glisse         2009-11-20  804  	if (r)
4c7886791264f0 Jerome Glisse         2009-11-20  805  		return r;
4aa5b92fd48f88 Kent Russell          2017-08-08  806  	r = radeon_bo_pin(rdev->stolen_vga_memory, RADEON_GEM_DOMAIN_VRAM, NULL);
4aa5b92fd48f88 Kent Russell          2017-08-08  807  	radeon_bo_unreserve(rdev->stolen_vga_memory);
771fe6b912fca5 Jerome Glisse         2009-06-05  808  	if (r) {
4aa5b92fd48f88 Kent Russell          2017-08-08  809  		radeon_bo_unref(&rdev->stolen_vga_memory);
771fe6b912fca5 Jerome Glisse         2009-06-05  810  		return r;
771fe6b912fca5 Jerome Glisse         2009-06-05  811  	}
771fe6b912fca5 Jerome Glisse         2009-06-05  812  	DRM_INFO("radeon: %uM of VRAM memory ready\n",
fc986034540102 Niels Ole Salscheider 2013-05-18  813  		 (unsigned) (rdev->mc.real_vram_size / (1024 * 1024)));
4c7886791264f0 Jerome Glisse         2009-11-20  814  	r = ttm_bo_init_mm(&rdev->mman.bdev, TTM_PL_TT,
312ea8da049a18 Jerome Glisse         2009-12-07  815  				rdev->mc.gtt_size >> PAGE_SHIFT);
771fe6b912fca5 Jerome Glisse         2009-06-05  816  	if (r) {
771fe6b912fca5 Jerome Glisse         2009-06-05  817  		DRM_ERROR("Failed initializing GTT heap.\n");
771fe6b912fca5 Jerome Glisse         2009-06-05  818  		return r;
771fe6b912fca5 Jerome Glisse         2009-06-05  819  	}
771fe6b912fca5 Jerome Glisse         2009-06-05  820  	DRM_INFO("radeon: %uM of GTT memory ready.\n",
3ce0a23d2d2531 Jerome Glisse         2009-09-08  821  		 (unsigned)(rdev->mc.gtt_size / (1024 * 1024)));
fa8a123855e200 Dave Airlie           2009-08-26  822  
fa8a123855e200 Dave Airlie           2009-08-26  823  	r = radeon_ttm_debugfs_init(rdev);
fa8a123855e200 Dave Airlie           2009-08-26  824  	if (r) {
fa8a123855e200 Dave Airlie           2009-08-26  825  		DRM_ERROR("Failed to init debugfs\n");
fa8a123855e200 Dave Airlie           2009-08-26  826  		return r;
fa8a123855e200 Dave Airlie           2009-08-26  827  	}
771fe6b912fca5 Jerome Glisse         2009-06-05  828  	return 0;
771fe6b912fca5 Jerome Glisse         2009-06-05  829  }
771fe6b912fca5 Jerome Glisse         2009-06-05  830  
771fe6b912fca5 Jerome Glisse         2009-06-05  831  void radeon_ttm_fini(struct radeon_device *rdev)
771fe6b912fca5 Jerome Glisse         2009-06-05  832  {
4c7886791264f0 Jerome Glisse         2009-11-20  833  	int r;
4c7886791264f0 Jerome Glisse         2009-11-20  834  
0a0c7596c64323 Jerome Glisse         2009-12-11  835  	if (!rdev->mman.initialized)
0a0c7596c64323 Jerome Glisse         2009-12-11  836  		return;
2014b5694182b5 Christian König       2013-12-18  837  	radeon_ttm_debugfs_fini(rdev);
4aa5b92fd48f88 Kent Russell          2017-08-08  838  	if (rdev->stolen_vga_memory) {
4aa5b92fd48f88 Kent Russell          2017-08-08  839  		r = radeon_bo_reserve(rdev->stolen_vga_memory, false);
4c7886791264f0 Jerome Glisse         2009-11-20  840  		if (r == 0) {
4aa5b92fd48f88 Kent Russell          2017-08-08  841  			radeon_bo_unpin(rdev->stolen_vga_memory);
4aa5b92fd48f88 Kent Russell          2017-08-08  842  			radeon_bo_unreserve(rdev->stolen_vga_memory);
4c7886791264f0 Jerome Glisse         2009-11-20  843  		}
4aa5b92fd48f88 Kent Russell          2017-08-08  844  		radeon_bo_unref(&rdev->stolen_vga_memory);
771fe6b912fca5 Jerome Glisse         2009-06-05  845  	}
771fe6b912fca5 Jerome Glisse         2009-06-05  846  	ttm_bo_clean_mm(&rdev->mman.bdev, TTM_PL_VRAM);
771fe6b912fca5 Jerome Glisse         2009-06-05  847  	ttm_bo_clean_mm(&rdev->mman.bdev, TTM_PL_TT);
771fe6b912fca5 Jerome Glisse         2009-06-05  848  	ttm_bo_device_release(&rdev->mman.bdev);
771fe6b912fca5 Jerome Glisse         2009-06-05  849  	radeon_gart_fini(rdev);
0a0c7596c64323 Jerome Glisse         2009-12-11  850  	rdev->mman.initialized = false;
771fe6b912fca5 Jerome Glisse         2009-06-05  851  	DRM_INFO("radeon: ttm finalized\n");
771fe6b912fca5 Jerome Glisse         2009-06-05  852  }
771fe6b912fca5 Jerome Glisse         2009-06-05  853  
5359533801e3dd Dave Airlie           2011-03-14  854  /* this should only be called at bootup or when userspace
5359533801e3dd Dave Airlie           2011-03-14  855   * isn't running */
5359533801e3dd Dave Airlie           2011-03-14  856  void radeon_ttm_set_active_vram_size(struct radeon_device *rdev, u64 size)
5359533801e3dd Dave Airlie           2011-03-14  857  {
5359533801e3dd Dave Airlie           2011-03-14  858  	struct ttm_mem_type_manager *man;
5359533801e3dd Dave Airlie           2011-03-14  859  
5359533801e3dd Dave Airlie           2011-03-14  860  	if (!rdev->mman.initialized)
5359533801e3dd Dave Airlie           2011-03-14  861  		return;
5359533801e3dd Dave Airlie           2011-03-14  862  
5359533801e3dd Dave Airlie           2011-03-14  863  	man = &rdev->mman.bdev.man[TTM_PL_VRAM];
5359533801e3dd Dave Airlie           2011-03-14  864  	/* this just adjusts TTM size idea, which sets lpfn to the correct value */
5359533801e3dd Dave Airlie           2011-03-14  865  	man->size = size >> PAGE_SHIFT;
5359533801e3dd Dave Airlie           2011-03-14  866  }
5359533801e3dd Dave Airlie           2011-03-14  867  
2bfb0b678e48de Souptick Joarder      2018-04-16  868  static vm_fault_t radeon_ttm_fault(struct vm_fault *vmf)
771fe6b912fca5 Jerome Glisse         2009-06-05  869  {
771fe6b912fca5 Jerome Glisse         2009-06-05  870  	struct ttm_buffer_object *bo;
5876dd249e8e47 Matthew Garrett       2010-04-26  871  	struct radeon_device *rdev;
2bfb0b678e48de Souptick Joarder      2018-04-16  872  	vm_fault_t ret;
771fe6b912fca5 Jerome Glisse         2009-06-05  873  
11bac80004499e Dave Jiang            2017-02-24  874  	bo = (struct ttm_buffer_object *)vmf->vma->vm_private_data;
165d3448a1a0e8 Christian König       2019-09-27  875  	if (bo == NULL)
771fe6b912fca5 Jerome Glisse         2009-06-05  876  		return VM_FAULT_NOPAGE;
165d3448a1a0e8 Christian König       2019-09-27  877  
5876dd249e8e47 Matthew Garrett       2010-04-26  878  	rdev = radeon_get_rdev(bo->bdev);
db7fce3983ad9b Christian König       2012-05-11  879  	down_read(&rdev->pm.mclk_lock);
165d3448a1a0e8 Christian König       2019-09-27  880  	ret = ttm_bo_vm_fault(vmf);
db7fce3983ad9b Christian König       2012-05-11  881  	up_read(&rdev->pm.mclk_lock);
2bfb0b678e48de Souptick Joarder      2018-04-16  882  	return ret;
771fe6b912fca5 Jerome Glisse         2009-06-05  883  }
771fe6b912fca5 Jerome Glisse         2009-06-05  884  
165d3448a1a0e8 Christian König       2019-09-27  885  static struct vm_operations_struct radeon_ttm_vm_ops = {
165d3448a1a0e8 Christian König       2019-09-27  886  	.fault = radeon_ttm_fault,
165d3448a1a0e8 Christian König       2019-09-27  887  	.open = ttm_bo_vm_open,
165d3448a1a0e8 Christian König       2019-09-27  888  	.close = ttm_bo_vm_close,
165d3448a1a0e8 Christian König       2019-09-27  889  	.access = ttm_bo_vm_access
165d3448a1a0e8 Christian König       2019-09-27  890  };
165d3448a1a0e8 Christian König       2019-09-27  891  
771fe6b912fca5 Jerome Glisse         2009-06-05  892  int radeon_mmap(struct file *filp, struct vm_area_struct *vma)
771fe6b912fca5 Jerome Glisse         2009-06-05  893  {
771fe6b912fca5 Jerome Glisse         2009-06-05  894  	int r;
bed2dd84212eb0 Thomas Zimmermann     2019-02-07  895  	struct drm_file *file_priv = filp->private_data;
bed2dd84212eb0 Thomas Zimmermann     2019-02-07  896  	struct radeon_device *rdev = file_priv->minor->dev->dev_private;
771fe6b912fca5 Jerome Glisse         2009-06-05  897  
165d3448a1a0e8 Christian König       2019-09-27  898  	if (rdev == NULL)
771fe6b912fca5 Jerome Glisse         2009-06-05  899  		return -EINVAL;
165d3448a1a0e8 Christian König       2019-09-27  900  
771fe6b912fca5 Jerome Glisse         2009-06-05  901  	r = ttm_bo_mmap(filp, vma, &rdev->mman.bdev);
165d3448a1a0e8 Christian König       2019-09-27  902  	if (unlikely(r != 0))
771fe6b912fca5 Jerome Glisse         2009-06-05  903  		return r;
165d3448a1a0e8 Christian König       2019-09-27  904  
771fe6b912fca5 Jerome Glisse         2009-06-05  905  	vma->vm_ops = &radeon_ttm_vm_ops;
771fe6b912fca5 Jerome Glisse         2009-06-05  906  	return 0;
771fe6b912fca5 Jerome Glisse         2009-06-05  907  }
771fe6b912fca5 Jerome Glisse         2009-06-05  908  
fa8a123855e200 Dave Airlie           2009-08-26  909  #if defined(CONFIG_DEBUG_FS)
893d6e6e122386 Christian König       2013-12-12  910  
fa8a123855e200 Dave Airlie           2009-08-26  911  static int radeon_mm_dump_table(struct seq_file *m, void *data)
fa8a123855e200 Dave Airlie           2009-08-26  912  {
fa8a123855e200 Dave Airlie           2009-08-26  913  	struct drm_info_node *node = (struct drm_info_node *)m->private;
893d6e6e122386 Christian König       2013-12-12  914  	unsigned ttm_pl = *(int*)node->info_ent->data;
fa8a123855e200 Dave Airlie           2009-08-26  915  	struct drm_device *dev = node->minor->dev;
fa8a123855e200 Dave Airlie           2009-08-26  916  	struct radeon_device *rdev = dev->dev_private;
bbbb29efa20d55 Christian König       2017-08-07  917  	struct ttm_mem_type_manager *man = &rdev->mman.bdev.man[ttm_pl];
b5c3714fe87897 Daniel Vetter         2016-12-29  918  	struct drm_printer p = drm_seq_file_printer(m);
fa8a123855e200 Dave Airlie           2009-08-26  919  
bbbb29efa20d55 Christian König       2017-08-07  920  	man->func->debug(man, &p);
b5c3714fe87897 Daniel Vetter         2016-12-29  921  	return 0;
fa8a123855e200 Dave Airlie           2009-08-26  922  }
893d6e6e122386 Christian König       2013-12-12  923  
bbbb29efa20d55 Christian König       2017-08-07  924  
893d6e6e122386 Christian König       2013-12-12  925  static int ttm_pl_vram = TTM_PL_VRAM;
893d6e6e122386 Christian König       2013-12-12  926  static int ttm_pl_tt = TTM_PL_TT;
893d6e6e122386 Christian König       2013-12-12  927  
893d6e6e122386 Christian König       2013-12-12  928  static struct drm_info_list radeon_ttm_debugfs_list[] = {
893d6e6e122386 Christian König       2013-12-12  929  	{"radeon_vram_mm", radeon_mm_dump_table, 0, &ttm_pl_vram},
893d6e6e122386 Christian König       2013-12-12  930  	{"radeon_gtt_mm", radeon_mm_dump_table, 0, &ttm_pl_tt},
893d6e6e122386 Christian König       2013-12-12  931  	{"ttm_page_pool", ttm_page_alloc_debugfs, 0, NULL},
893d6e6e122386 Christian König       2013-12-12  932  #ifdef CONFIG_SWIOTLB
893d6e6e122386 Christian König       2013-12-12  933  	{"ttm_dma_page_pool", ttm_dma_page_alloc_debugfs, 0, NULL}
893d6e6e122386 Christian König       2013-12-12  934  #endif
893d6e6e122386 Christian König       2013-12-12  935  };
893d6e6e122386 Christian König       2013-12-12  936  
2014b5694182b5 Christian König       2013-12-18  937  static int radeon_ttm_vram_open(struct inode *inode, struct file *filep)
2014b5694182b5 Christian König       2013-12-18  938  {
2014b5694182b5 Christian König       2013-12-18  939  	struct radeon_device *rdev = inode->i_private;
2014b5694182b5 Christian König       2013-12-18  940  	i_size_write(inode, rdev->mc.mc_vram_size);
2014b5694182b5 Christian König       2013-12-18  941  	filep->private_data = inode->i_private;
2014b5694182b5 Christian König       2013-12-18  942  	return 0;
2014b5694182b5 Christian König       2013-12-18  943  }
2014b5694182b5 Christian König       2013-12-18  944  
2014b5694182b5 Christian König       2013-12-18  945  static ssize_t radeon_ttm_vram_read(struct file *f, char __user *buf,
2014b5694182b5 Christian König       2013-12-18  946  				    size_t size, loff_t *pos)
2014b5694182b5 Christian König       2013-12-18  947  {
2014b5694182b5 Christian König       2013-12-18  948  	struct radeon_device *rdev = f->private_data;
2014b5694182b5 Christian König       2013-12-18  949  	ssize_t result = 0;
2014b5694182b5 Christian König       2013-12-18  950  	int r;
2014b5694182b5 Christian König       2013-12-18  951  
2014b5694182b5 Christian König       2013-12-18  952  	if (size & 0x3 || *pos & 0x3)
2014b5694182b5 Christian König       2013-12-18  953  		return -EINVAL;
2014b5694182b5 Christian König       2013-12-18  954  
2014b5694182b5 Christian König       2013-12-18  955  	while (size) {
2014b5694182b5 Christian König       2013-12-18  956  		unsigned long flags;
2014b5694182b5 Christian König       2013-12-18  957  		uint32_t value;
2014b5694182b5 Christian König       2013-12-18  958  
2014b5694182b5 Christian König       2013-12-18  959  		if (*pos >= rdev->mc.mc_vram_size)
2014b5694182b5 Christian König       2013-12-18  960  			return result;
2014b5694182b5 Christian König       2013-12-18  961  
2014b5694182b5 Christian König       2013-12-18  962  		spin_lock_irqsave(&rdev->mmio_idx_lock, flags);
2014b5694182b5 Christian König       2013-12-18  963  		WREG32(RADEON_MM_INDEX, ((uint32_t)*pos) | 0x80000000);
2014b5694182b5 Christian König       2013-12-18  964  		if (rdev->family >= CHIP_CEDAR)
2014b5694182b5 Christian König       2013-12-18  965  			WREG32(EVERGREEN_MM_INDEX_HI, *pos >> 31);
2014b5694182b5 Christian König       2013-12-18  966  		value = RREG32(RADEON_MM_DATA);
2014b5694182b5 Christian König       2013-12-18  967  		spin_unlock_irqrestore(&rdev->mmio_idx_lock, flags);
2014b5694182b5 Christian König       2013-12-18  968  
2014b5694182b5 Christian König       2013-12-18 @969  		r = put_user(value, (uint32_t *)buf);
2014b5694182b5 Christian König       2013-12-18  970  		if (r)
2014b5694182b5 Christian König       2013-12-18  971  			return r;
2014b5694182b5 Christian König       2013-12-18  972  
2014b5694182b5 Christian König       2013-12-18  973  		result += 4;
2014b5694182b5 Christian König       2013-12-18  974  		buf += 4;
2014b5694182b5 Christian König       2013-12-18  975  		*pos += 4;
2014b5694182b5 Christian König       2013-12-18  976  		size -= 4;
2014b5694182b5 Christian König       2013-12-18  977  	}
2014b5694182b5 Christian König       2013-12-18  978  
2014b5694182b5 Christian König       2013-12-18  979  	return result;
2014b5694182b5 Christian König       2013-12-18  980  }
2014b5694182b5 Christian König       2013-12-18  981  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--NzB8fVQJ5HfG6fxh
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--NzB8fVQJ5HfG6fxh--
