Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CED6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECFD72067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733204AbgF2Tbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:31:40 -0400
Received: from mga04.intel.com ([192.55.52.120]:36943 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733186AbgF2Tbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:31:37 -0400
IronPort-SDR: jRlfxmrBsxqLoljiEUFBm8WWouXK80uVbu+3vB7hKwx8E/vgWkCFOYOcIOntk1NYv9oxNLQ+YC
 1kjkTS277bvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="143502427"
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; 
   d="gz'50?scan'50,208,50";a="143502427"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 11:09:26 -0700
IronPort-SDR: noQxiex75TNu6Jf9dpXLXESO9mtv+tKTOzI5LUXk4UhTLH+GiWsJHww72EaMrN6niY41MkE8rZ
 Ym14zW7eqZBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; 
   d="gz'50?scan'50,208,50";a="264902645"
Received: from lkp-server01.sh.intel.com (HELO 28879958b202) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 29 Jun 2020 11:09:24 -0700
Received: from kbuild by 28879958b202 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jpyDb-00016y-OX; Mon, 29 Jun 2020 18:09:23 +0000
Date:   Tue, 30 Jun 2020 02:08:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] sparse: use static inline for __chk_{user,io}_ptr()
Message-ID: <202006300219.fQMPm3tC%lkp@intel.com>
References: <20200628072019.67107-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200628072019.67107-1-luc.vanoostenryck@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Luc,

I love your patch! Perhaps something to improve:

[auto build test WARNING on next-20200626]
[cannot apply to linux/master linus/master v5.8-rc2 v5.8-rc1 v5.7 v5.8-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use  as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Luc-Van-Oostenryck/sparse-use-static-inline-for-__chk_-user-io-_ptr/20200628-152401
base:    36e3135df4d426612fc77db26a312c2531108603
config: i386-randconfig-s002-20200629 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-13) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.2-3-gfa153962-dirty
        # save the attached .config to linux build tree
        make W=1 C= CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:818:42: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2388:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2388:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2388:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2388:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2388:21: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2388:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int [usertype] * @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2388:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2388:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2388:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2388:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2388:21: sparse: sparse: cast removes address space '__user' of expression
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

vim +2388 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c

d38ceaf99ed015 Alex Deucher    2015-04-20  2362  
50da51744f005f Tom St Denis    2018-05-09  2363  /**
50da51744f005f Tom St Denis    2018-05-09  2364   * amdgpu_ttm_vram_write - Linear write access to VRAM
50da51744f005f Tom St Denis    2018-05-09  2365   *
50da51744f005f Tom St Denis    2018-05-09  2366   * Accesses VRAM via MMIO for debugging purposes.
50da51744f005f Tom St Denis    2018-05-09  2367   */
08cab989f77582 Tom St Denis    2017-08-29  2368  static ssize_t amdgpu_ttm_vram_write(struct file *f, const char __user *buf,
08cab989f77582 Tom St Denis    2017-08-29  2369  				    size_t size, loff_t *pos)
08cab989f77582 Tom St Denis    2017-08-29  2370  {
08cab989f77582 Tom St Denis    2017-08-29  2371  	struct amdgpu_device *adev = file_inode(f)->i_private;
08cab989f77582 Tom St Denis    2017-08-29  2372  	ssize_t result = 0;
08cab989f77582 Tom St Denis    2017-08-29  2373  	int r;
08cab989f77582 Tom St Denis    2017-08-29  2374  
08cab989f77582 Tom St Denis    2017-08-29  2375  	if (size & 0x3 || *pos & 0x3)
08cab989f77582 Tom St Denis    2017-08-29  2376  		return -EINVAL;
08cab989f77582 Tom St Denis    2017-08-29  2377  
770d13b19fdf36 Christian König 2018-01-12  2378  	if (*pos >= adev->gmc.mc_vram_size)
08cab989f77582 Tom St Denis    2017-08-29  2379  		return -ENXIO;
08cab989f77582 Tom St Denis    2017-08-29  2380  
08cab989f77582 Tom St Denis    2017-08-29  2381  	while (size) {
08cab989f77582 Tom St Denis    2017-08-29  2382  		unsigned long flags;
08cab989f77582 Tom St Denis    2017-08-29  2383  		uint32_t value;
08cab989f77582 Tom St Denis    2017-08-29  2384  
770d13b19fdf36 Christian König 2018-01-12  2385  		if (*pos >= adev->gmc.mc_vram_size)
08cab989f77582 Tom St Denis    2017-08-29  2386  			return result;
08cab989f77582 Tom St Denis    2017-08-29  2387  
08cab989f77582 Tom St Denis    2017-08-29 @2388  		r = get_user(value, (uint32_t *)buf);
08cab989f77582 Tom St Denis    2017-08-29  2389  		if (r)
08cab989f77582 Tom St Denis    2017-08-29  2390  			return r;
08cab989f77582 Tom St Denis    2017-08-29  2391  
08cab989f77582 Tom St Denis    2017-08-29  2392  		spin_lock_irqsave(&adev->mmio_idx_lock, flags);
c30572814df55b Tom St Denis    2017-09-13  2393  		WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)*pos) | 0x80000000);
c30572814df55b Tom St Denis    2017-09-13  2394  		WREG32_NO_KIQ(mmMM_INDEX_HI, *pos >> 31);
c30572814df55b Tom St Denis    2017-09-13  2395  		WREG32_NO_KIQ(mmMM_DATA, value);
08cab989f77582 Tom St Denis    2017-08-29  2396  		spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
08cab989f77582 Tom St Denis    2017-08-29  2397  
08cab989f77582 Tom St Denis    2017-08-29  2398  		result += 4;
08cab989f77582 Tom St Denis    2017-08-29  2399  		buf += 4;
08cab989f77582 Tom St Denis    2017-08-29  2400  		*pos += 4;
08cab989f77582 Tom St Denis    2017-08-29  2401  		size -= 4;
08cab989f77582 Tom St Denis    2017-08-29  2402  	}
08cab989f77582 Tom St Denis    2017-08-29  2403  
08cab989f77582 Tom St Denis    2017-08-29  2404  	return result;
08cab989f77582 Tom St Denis    2017-08-29  2405  }
08cab989f77582 Tom St Denis    2017-08-29  2406  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--huq684BweRXVnRxX
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--huq684BweRXVnRxX--
