Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EF2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ADDB2177B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgHGLN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 07:13:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:46841 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbgHGLGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 07:06:23 -0400
IronPort-SDR: LyA9vtAWvuj1YkUC8efHNU4uOdXWKJZIIjk2O6sHEGjciWucq2TV26gBM3aI/7VxnrXqs8uFMm
 mVzJnAiB5FWw==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="140920148"
X-IronPort-AV: E=Sophos;i="5.75,445,1589266800"; 
   d="gz'50?scan'50,208,50";a="140920148"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2020 03:38:14 -0700
IronPort-SDR: wG9tG7OsaHSV/iHPQ1ThecJqYFVSesQVz0iWwTQx4AU0PPOBw5MA+FUNYMexJv+2VXuFVBVZMF
 js4KlYKbQHkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,445,1589266800"; 
   d="gz'50?scan'50,208,50";a="331506727"
Received: from lkp-server02.sh.intel.com (HELO 090e49ab5480) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Aug 2020 03:38:11 -0700
Received: from kbuild by 090e49ab5480 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k3zlL-0000Bg-3p; Fri, 07 Aug 2020 10:38:11 +0000
Date:   Fri, 7 Aug 2020 18:37:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/video/fbdev/pxafb.c:916:24: sparse: sparse: incorrect type
 in assignment (different address spaces)
Message-ID: <202008071833.kUoyxyIe%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   86cfccb66937dd6cbf26ed619958b9e587e6a115
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   7 weeks ago
config: arm-randconfig-s031-20200807 (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-118-ge1578773-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/video/fbdev/pxafb.c:916:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *video_mem @@     got void * @@
>> drivers/video/fbdev/pxafb.c:916:24: sparse:     expected void [noderef] __iomem *video_mem
   drivers/video/fbdev/pxafb.c:916:24: sparse:     got void *
>> drivers/video/fbdev/pxafb.c:921:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile *x @@     got void [noderef] __iomem *video_mem @@
   drivers/video/fbdev/pxafb.c:921:47: sparse:     expected void const volatile *x
>> drivers/video/fbdev/pxafb.c:921:47: sparse:     got void [noderef] __iomem *video_mem
>> drivers/video/fbdev/pxafb.c:977:53: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *virt @@     got void [noderef] __iomem *video_mem @@
   drivers/video/fbdev/pxafb.c:977:53: sparse:     expected void *virt
   drivers/video/fbdev/pxafb.c:977:53: sparse:     got void [noderef] __iomem *video_mem
   drivers/video/fbdev/pxafb.c:1714:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *video_mem @@     got void * @@
   drivers/video/fbdev/pxafb.c:1714:24: sparse:     expected void [noderef] __iomem *video_mem
   drivers/video/fbdev/pxafb.c:1714:24: sparse:     got void *
   drivers/video/fbdev/pxafb.c:1718:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile *x @@     got void [noderef] __iomem *video_mem @@
   drivers/video/fbdev/pxafb.c:1718:47: sparse:     expected void const volatile *x
   drivers/video/fbdev/pxafb.c:1718:47: sparse:     got void [noderef] __iomem *video_mem
   drivers/video/fbdev/pxafb.c:2392:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *virt @@     got void [noderef] __iomem *video_mem @@
   drivers/video/fbdev/pxafb.c:2392:29: sparse:     expected void *virt
   drivers/video/fbdev/pxafb.c:2392:29: sparse:     got void [noderef] __iomem *video_mem
   drivers/video/fbdev/pxafb.c:2418:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *virt @@     got void [noderef] __iomem *video_mem @@
   drivers/video/fbdev/pxafb.c:2418:29: sparse:     expected void *virt
   drivers/video/fbdev/pxafb.c:2418:29: sparse:     got void [noderef] __iomem *video_mem
--
>> drivers/firmware/efi/test/efi_test.c:157:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *register __p @@     got unsigned long *[addressable] data_size @@
>> drivers/firmware/efi/test/efi_test.c:157:13: sparse:     expected unsigned long [noderef] __user *register __p
   drivers/firmware/efi/test/efi_test.c:157:13: sparse:     got unsigned long *[addressable] data_size
   drivers/firmware/efi/test/efi_test.c:160:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct guid_t [usertype] *[addressable] vendor_guid @@
   drivers/firmware/efi/test/efi_test.c:160:61: sparse:     expected void const [noderef] __user *from
   drivers/firmware/efi/test/efi_test.c:160:61: sparse:     got struct guid_t [usertype] *[addressable] vendor_guid
   drivers/firmware/efi/test/efi_test.c:167:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected unsigned short [noderef] [usertype] __user *src @@     got unsigned short [usertype] *[addressable] variable_name @@
   drivers/firmware/efi/test/efi_test.c:167:60: sparse:     expected unsigned short [noderef] [usertype] __user *src
   drivers/firmware/efi/test/efi_test.c:167:60: sparse:     got unsigned short [usertype] *[addressable] variable_name
>> drivers/firmware/efi/test/efi_test.c:187:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__pu_ptr @@     got unsigned long [usertype] *[addressable] status @@
>> drivers/firmware/efi/test/efi_test.c:187:13: sparse:     expected unsigned long const [noderef] __user *__pu_ptr
   drivers/firmware/efi/test/efi_test.c:187:13: sparse:     got unsigned long [usertype] *[addressable] status
>> drivers/firmware/efi/test/efi_test.c:194:35: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__pu_ptr @@     got unsigned long *[addressable] data_size @@
   drivers/firmware/efi/test/efi_test.c:194:35: sparse:     expected unsigned long const [noderef] __user *__pu_ptr
   drivers/firmware/efi/test/efi_test.c:194:35: sparse:     got unsigned long *[addressable] data_size
   drivers/firmware/efi/test/efi_test.c:209:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got void *[addressable] data @@
   drivers/firmware/efi/test/efi_test.c:209:45: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:209:45: sparse:     got void *[addressable] data
>> drivers/firmware/efi/test/efi_test.c:215:19: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const [noderef] __user *__pu_ptr @@     got unsigned int [usertype] *[addressable] attributes @@
>> drivers/firmware/efi/test/efi_test.c:215:19: sparse:     expected unsigned int const [noderef] __user *__pu_ptr
   drivers/firmware/efi/test/efi_test.c:215:19: sparse:     got unsigned int [usertype] *[addressable] attributes
   drivers/firmware/efi/test/efi_test.c:220:19: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__pu_ptr @@     got unsigned long *[addressable] data_size @@
   drivers/firmware/efi/test/efi_test.c:220:19: sparse:     expected unsigned long const [noderef] __user *__pu_ptr
   drivers/firmware/efi/test/efi_test.c:220:19: sparse:     got unsigned long *[addressable] data_size
   drivers/firmware/efi/test/efi_test.c:243:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct guid_t [usertype] *[addressable] vendor_guid @@
   drivers/firmware/efi/test/efi_test.c:243:53: sparse:     expected void const [noderef] __user *from
   drivers/firmware/efi/test/efi_test.c:243:53: sparse:     got struct guid_t [usertype] *[addressable] vendor_guid
   drivers/firmware/efi/test/efi_test.c:248:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected unsigned short [noderef] [usertype] __user *src @@     got unsigned short [usertype] *[addressable] variable_name @@
   drivers/firmware/efi/test/efi_test.c:248:60: sparse:     expected unsigned short [noderef] [usertype] __user *src
   drivers/firmware/efi/test/efi_test.c:248:60: sparse:     got unsigned short [usertype] *[addressable] variable_name
   drivers/firmware/efi/test/efi_test.c:253:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __user * @@     got void *[addressable] data @@
   drivers/firmware/efi/test/efi_test.c:253:39: sparse:     expected void const [noderef] __user *
   drivers/firmware/efi/test/efi_test.c:253:39: sparse:     got void *[addressable] data
   drivers/firmware/efi/test/efi_test.c:263:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__pu_ptr @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:263:13: sparse:     expected unsigned long const [noderef] __user *__pu_ptr
   drivers/firmware/efi/test/efi_test.c:263:13: sparse:     got unsigned long [usertype] *[addressable] status
   drivers/firmware/efi/test/efi_test.c:292:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__pu_ptr @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:292:13: sparse:     expected unsigned long const [noderef] __user *__pu_ptr
   drivers/firmware/efi/test/efi_test.c:292:13: sparse:     got unsigned long [usertype] *[addressable] status
   drivers/firmware/efi/test/efi_test.c:301:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct efi_time_cap_t [noderef] [usertype] __user *cap_local @@     got struct efi_time_cap_t [usertype] * @@
   drivers/firmware/efi/test/efi_test.c:301:27: sparse:     expected struct efi_time_cap_t [noderef] [usertype] __user *cap_local
   drivers/firmware/efi/test/efi_test.c:301:27: sparse:     got struct efi_time_cap_t [usertype] *
   drivers/firmware/efi/test/efi_test.c:308:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got struct efi_time_t [usertype] *[addressable] time @@
   drivers/firmware/efi/test/efi_test.c:308:41: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:308:41: sparse:     got struct efi_time_t [usertype] *[addressable] time
   drivers/firmware/efi/test/efi_test.c:325:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct efi_time_t [usertype] *[addressable] time @@
   drivers/firmware/efi/test/efi_test.c:325:46: sparse:     expected void const [noderef] __user *from
   drivers/firmware/efi/test/efi_test.c:325:46: sparse:     got struct efi_time_t [usertype] *[addressable] time
   drivers/firmware/efi/test/efi_test.c:330:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__pu_ptr @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:330:13: sparse:     expected unsigned long const [noderef] __user *__pu_ptr
   drivers/firmware/efi/test/efi_test.c:330:13: sparse:     got unsigned long [usertype] *[addressable] status
   drivers/firmware/efi/test/efi_test.c:354:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__pu_ptr @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:354:13: sparse:     expected unsigned long const [noderef] __user *__pu_ptr
   drivers/firmware/efi/test/efi_test.c:354:13: sparse:     got unsigned long [usertype] *[addressable] status
>> drivers/firmware/efi/test/efi_test.c:360:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const [noderef] __user *__pu_ptr @@     got unsigned char [usertype] *[addressable] enabled @@
>> drivers/firmware/efi/test/efi_test.c:360:38: sparse:     expected unsigned char const [noderef] __user *__pu_ptr
   drivers/firmware/efi/test/efi_test.c:360:38: sparse:     got unsigned char [usertype] *[addressable] enabled
   drivers/firmware/efi/test/efi_test.c:365:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got struct efi_time_t [usertype] *[addressable] time @@
   drivers/firmware/efi/test/efi_test.c:365:47: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:365:47: sparse:     got struct efi_time_t [usertype] *[addressable] time
   drivers/firmware/efi/test/efi_test.c:389:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct efi_time_t [usertype] *[addressable] time @@
   drivers/firmware/efi/test/efi_test.c:389:60: sparse:     expected void const [noderef] __user *from
   drivers/firmware/efi/test/efi_test.c:389:60: sparse:     got struct efi_time_t [usertype] *[addressable] time
   drivers/firmware/efi/test/efi_test.c:397:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__pu_ptr @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:397:13: sparse:     expected unsigned long const [noderef] __user *__pu_ptr
   drivers/firmware/efi/test/efi_test.c:397:13: sparse:     got unsigned long [usertype] *[addressable] status
>> drivers/firmware/efi/test/efi_test.c:421:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long [noderef] __user *register __p @@     got unsigned long *[addressable] variable_name_size @@
   drivers/firmware/efi/test/efi_test.c:421:21: sparse:     expected unsigned long [noderef] __user *register __p
   drivers/firmware/efi/test/efi_test.c:421:21: sparse:     got unsigned long *[addressable] variable_name_size
   drivers/firmware/efi/test/efi_test.c:429:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct guid_t [usertype] *[addressable] vendor_guid @@
   drivers/firmware/efi/test/efi_test.c:429:52: sparse:     expected void const [noderef] __user *from
   drivers/firmware/efi/test/efi_test.c:429:52: sparse:     got struct guid_t [usertype] *[addressable] vendor_guid
   drivers/firmware/efi/test/efi_test.c:439:52: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short [noderef] [usertype] __user *src @@     got unsigned short [usertype] *[addressable] variable_name @@
   drivers/firmware/efi/test/efi_test.c:439:52: sparse:     expected unsigned short [noderef] [usertype] __user *src
   drivers/firmware/efi/test/efi_test.c:439:52: sparse:     got unsigned short [usertype] *[addressable] variable_name
   drivers/firmware/efi/test/efi_test.c:452:52: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected unsigned short [noderef] [usertype] __user *src @@     got unsigned short [usertype] *[addressable] variable_name @@
   drivers/firmware/efi/test/efi_test.c:452:52: sparse:     expected unsigned short [noderef] [usertype] __user *src
   drivers/firmware/efi/test/efi_test.c:452:52: sparse:     got unsigned short [usertype] *[addressable] variable_name
   drivers/firmware/efi/test/efi_test.c:461:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__pu_ptr @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:461:13: sparse:     expected unsigned long const [noderef] __user *__pu_ptr
   drivers/firmware/efi/test/efi_test.c:461:13: sparse:     got unsigned long [usertype] *[addressable] status
>> drivers/firmware/efi/test/efi_test.c:468:35: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__pu_ptr @@     got unsigned long *[addressable] variable_name_size @@
   drivers/firmware/efi/test/efi_test.c:468:35: sparse:     expected unsigned long const [noderef] __user *__pu_ptr
   drivers/firmware/efi/test/efi_test.c:468:35: sparse:     got unsigned long *[addressable] variable_name_size
   drivers/firmware/efi/test/efi_test.c:479:62: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short [noderef] [usertype] __user *dst @@     got unsigned short [usertype] *[addressable] variable_name @@
   drivers/firmware/efi/test/efi_test.c:479:62: sparse:     expected unsigned short [noderef] [usertype] __user *dst
   drivers/firmware/efi/test/efi_test.c:479:62: sparse:     got unsigned short [usertype] *[addressable] variable_name
   drivers/firmware/efi/test/efi_test.c:487:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__pu_ptr @@     got unsigned long *[addressable] variable_name_size @@
   drivers/firmware/efi/test/efi_test.c:487:21: sparse:     expected unsigned long const [noderef] __user *__pu_ptr
   drivers/firmware/efi/test/efi_test.c:487:21: sparse:     got unsigned long *[addressable] variable_name_size
   drivers/firmware/efi/test/efi_test.c:494:53: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got struct guid_t [usertype] *[addressable] vendor_guid @@
   drivers/firmware/efi/test/efi_test.c:494:53: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:494:53: sparse:     got struct guid_t [usertype] *[addressable] vendor_guid
   drivers/firmware/efi/test/efi_test.c:522:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__pu_ptr @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:522:13: sparse:     expected unsigned long const [noderef] __user *__pu_ptr
   drivers/firmware/efi/test/efi_test.c:522:13: sparse:     got unsigned long [usertype] *[addressable] status
>> drivers/firmware/efi/test/efi_test.c:529:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const [noderef] __user *__pu_ptr @@     got unsigned int [usertype] *[addressable] high_count @@
   drivers/firmware/efi/test/efi_test.c:529:13: sparse:     expected unsigned int const [noderef] __user *__pu_ptr
   drivers/firmware/efi/test/efi_test.c:529:13: sparse:     got unsigned int [usertype] *[addressable] high_count
   drivers/firmware/efi/test/efi_test.c:546:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __user * @@     got void * @@
   drivers/firmware/efi/test/efi_test.c:546:37: sparse:     expected void const [noderef] __user *
   drivers/firmware/efi/test/efi_test.c:546:37: sparse:     got void *
   drivers/firmware/efi/test/efi_test.c:575:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__pu_ptr @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:575:13: sparse:     expected unsigned long const [noderef] __user *__pu_ptr
   drivers/firmware/efi/test/efi_test.c:575:13: sparse:     got unsigned long [usertype] *[addressable] status
>> drivers/firmware/efi/test/efi_test.c:581:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long const [noderef] __user *__pu_ptr @@     got unsigned long long [usertype] *[addressable] maximum_variable_storage_size @@
>> drivers/firmware/efi/test/efi_test.c:581:13: sparse:     expected unsigned long long const [noderef] __user *__pu_ptr
   drivers/firmware/efi/test/efi_test.c:581:13: sparse:     got unsigned long long [usertype] *[addressable] maximum_variable_storage_size
   drivers/firmware/efi/test/efi_test.c:585:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long const [noderef] __user *__pu_ptr @@     got unsigned long long [usertype] *[addressable] remaining_variable_storage_size @@
   drivers/firmware/efi/test/efi_test.c:585:13: sparse:     expected unsigned long long const [noderef] __user *__pu_ptr
   drivers/firmware/efi/test/efi_test.c:585:13: sparse:     got unsigned long long [usertype] *[addressable] remaining_variable_storage_size
   drivers/firmware/efi/test/efi_test.c:589:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long const [noderef] __user *__pu_ptr @@     got unsigned long long [usertype] *[addressable] maximum_variable_size @@
   drivers/firmware/efi/test/efi_test.c:589:13: sparse:     expected unsigned long long const [noderef] __user *__pu_ptr
   drivers/firmware/efi/test/efi_test.c:589:13: sparse:     got unsigned long long [usertype] *[addressable] maximum_variable_size
>> drivers/firmware/efi/test/efi_test.c:625:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct efi_capsule_header_t [usertype] *[noderef] __user *register __p @@     got struct efi_capsule_header_t [usertype] ** @@
>> drivers/firmware/efi/test/efi_test.c:625:21: sparse:     expected struct efi_capsule_header_t [usertype] *[noderef] __user *register __p
   drivers/firmware/efi/test/efi_test.c:625:21: sparse:     got struct efi_capsule_header_t [usertype] **
   drivers/firmware/efi/test/efi_test.c:629:50: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct efi_capsule_header_t [usertype] *[assigned] c @@
   drivers/firmware/efi/test/efi_test.c:629:50: sparse:     expected void const [noderef] __user *from
   drivers/firmware/efi/test/efi_test.c:629:50: sparse:     got struct efi_capsule_header_t [usertype] *[assigned] c
   drivers/firmware/efi/test/efi_test.c:643:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const [noderef] __user *__pu_ptr @@     got unsigned long [usertype] *[addressable] [assigned] status @@
   drivers/firmware/efi/test/efi_test.c:643:13: sparse:     expected unsigned long const [noderef] __user *__pu_ptr
   drivers/firmware/efi/test/efi_test.c:643:13: sparse:     got unsigned long [usertype] *[addressable] [assigned] status
   drivers/firmware/efi/test/efi_test.c:653:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long const [noderef] __user *__pu_ptr @@     got unsigned long long [usertype] *[addressable] [assigned] maximum_capsule_size @@
   drivers/firmware/efi/test/efi_test.c:653:13: sparse:     expected unsigned long long const [noderef] __user *__pu_ptr
   drivers/firmware/efi/test/efi_test.c:653:13: sparse:     got unsigned long long [usertype] *[addressable] [assigned] maximum_capsule_size
>> drivers/firmware/efi/test/efi_test.c:658:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const [noderef] __user *__pu_ptr @@     got int *[addressable] [assigned] reset_type @@
>> drivers/firmware/efi/test/efi_test.c:658:13: sparse:     expected int const [noderef] __user *__pu_ptr
   drivers/firmware/efi/test/efi_test.c:658:13: sparse:     got int *[addressable] [assigned] reset_type
   drivers/firmware/efi/test/efi_test.c:35:27: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [usertype] *s @@     got unsigned short [noderef] [usertype] __user *str @@
   drivers/firmware/efi/test/efi_test.c:35:27: sparse:     expected unsigned short [usertype] *s
   drivers/firmware/efi/test/efi_test.c:35:27: sparse:     got unsigned short [noderef] [usertype] __user *str
>> drivers/firmware/efi/test/efi_test.c:44:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *register __p @@     got unsigned short [usertype] * @@
>> drivers/firmware/efi/test/efi_test.c:44:13: sparse:     expected unsigned short [noderef] __user *register __p
   drivers/firmware/efi/test/efi_test.c:44:13: sparse:     got unsigned short [usertype] *
   drivers/firmware/efi/test/efi_test.c:50:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *register __p @@     got unsigned short [usertype] * @@
   drivers/firmware/efi/test/efi_test.c:50:21: sparse:     expected unsigned short [noderef] __user *register __p
   drivers/firmware/efi/test/efi_test.c:50:21: sparse:     got unsigned short [usertype] *
   drivers/firmware/efi/test/efi_test.c:35:27: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [usertype] *[assigned] s @@     got unsigned short [noderef] [usertype] __user *str @@
   drivers/firmware/efi/test/efi_test.c:35:27: sparse:     expected unsigned short [usertype] *[assigned] s
   drivers/firmware/efi/test/efi_test.c:35:27: sparse:     got unsigned short [noderef] [usertype] __user *str
>> drivers/firmware/efi/test/efi_test.c:44:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *register __p @@     got unsigned short [usertype] * @@
>> drivers/firmware/efi/test/efi_test.c:44:13: sparse:     expected unsigned short [noderef] __user *register __p
   drivers/firmware/efi/test/efi_test.c:44:13: sparse:     got unsigned short [usertype] *
   drivers/firmware/efi/test/efi_test.c:50:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *register __p @@     got unsigned short [usertype] * @@
   drivers/firmware/efi/test/efi_test.c:50:21: sparse:     expected unsigned short [noderef] __user *register __p
   drivers/firmware/efi/test/efi_test.c:50:21: sparse:     got unsigned short [usertype] *
   drivers/firmware/efi/test/efi_test.c:35:27: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [usertype] *[assigned] s @@     got unsigned short [noderef] [usertype] __user *str @@
   drivers/firmware/efi/test/efi_test.c:35:27: sparse:     expected unsigned short [usertype] *[assigned] s
   drivers/firmware/efi/test/efi_test.c:35:27: sparse:     got unsigned short [noderef] [usertype] __user *str
>> drivers/firmware/efi/test/efi_test.c:44:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *register __p @@     got unsigned short [usertype] * @@
>> drivers/firmware/efi/test/efi_test.c:44:13: sparse:     expected unsigned short [noderef] __user *register __p
   drivers/firmware/efi/test/efi_test.c:44:13: sparse:     got unsigned short [usertype] *
   drivers/firmware/efi/test/efi_test.c:50:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [noderef] __user *register __p @@     got unsigned short [usertype] * @@
   drivers/firmware/efi/test/efi_test.c:50:21: sparse:     expected unsigned short [noderef] __user *register __p
   drivers/firmware/efi/test/efi_test.c:50:21: sparse:     got unsigned short [usertype] *

vim +916 drivers/video/fbdev/pxafb.c

782385ae176b304 drivers/video/pxafb.c Eric Miao          2009-03-19  909  
48c68c4f1b54244 drivers/video/pxafb.c Greg Kroah-Hartman 2012-12-21  910  static int pxafb_overlay_map_video_memory(struct pxafb_info *pxafb,
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  911  					  struct pxafb_layer *ofb)
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  912  {
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  913  	/* We assume that user will use at most video_mem_size for overlay fb,
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  914  	 * anyway, it's useless to use 16bpp main plane and 24bpp overlay
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  915  	 */
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11 @916  	ofb->video_mem = alloc_pages_exact(PAGE_ALIGN(pxafb->video_mem_size),
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  917  		GFP_KERNEL | __GFP_ZERO);
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  918  	if (ofb->video_mem == NULL)
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  919  		return -ENOMEM;
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  920  
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11 @921  	ofb->video_mem_phys = virt_to_phys(ofb->video_mem);
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  922  	ofb->video_mem_size = PAGE_ALIGN(pxafb->video_mem_size);
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  923  
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  924  	mutex_lock(&ofb->fb.mm_lock);
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  925  	ofb->fb.fix.smem_start	= ofb->video_mem_phys;
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  926  	ofb->fb.fix.smem_len	= pxafb->video_mem_size;
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  927  	mutex_unlock(&ofb->fb.mm_lock);
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  928  
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  929  	ofb->fb.screen_base	= ofb->video_mem;
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  930  
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  931  	return 0;
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  932  }
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  933  
48c68c4f1b54244 drivers/video/pxafb.c Greg Kroah-Hartman 2012-12-21  934  static void pxafb_overlay_init(struct pxafb_info *fbi)
198fc108ee4c2cd drivers/video/pxafb.c Eric Miao          2008-12-23  935  {
198fc108ee4c2cd drivers/video/pxafb.c Eric Miao          2008-12-23  936  	int i, ret;
198fc108ee4c2cd drivers/video/pxafb.c Eric Miao          2008-12-23  937  
782385ae176b304 drivers/video/pxafb.c Eric Miao          2009-03-19  938  	if (!pxafb_overlay_supported())
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  939  		return;
782385ae176b304 drivers/video/pxafb.c Eric Miao          2009-03-19  940  
198fc108ee4c2cd drivers/video/pxafb.c Eric Miao          2008-12-23  941  	for (i = 0; i < 2; i++) {
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  942  		struct pxafb_layer *ofb = &fbi->overlay[i];
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  943  		init_pxafb_overlay(fbi, ofb, i);
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  944  		ret = register_framebuffer(&ofb->fb);
198fc108ee4c2cd drivers/video/pxafb.c Eric Miao          2008-12-23  945  		if (ret) {
198fc108ee4c2cd drivers/video/pxafb.c Eric Miao          2008-12-23  946  			dev_err(fbi->dev, "failed to register overlay %d\n", i);
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  947  			continue;
198fc108ee4c2cd drivers/video/pxafb.c Eric Miao          2008-12-23  948  		}
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  949  		ret = pxafb_overlay_map_video_memory(fbi, ofb);
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  950  		if (ret) {
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  951  			dev_err(fbi->dev,
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  952  				"failed to map video memory for overlay %d\n",
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  953  				i);
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  954  			unregister_framebuffer(&ofb->fb);
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  955  			continue;
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  956  		}
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  957  		ofb->registered = 1;
198fc108ee4c2cd drivers/video/pxafb.c Eric Miao          2008-12-23  958  	}
198fc108ee4c2cd drivers/video/pxafb.c Eric Miao          2008-12-23  959  
198fc108ee4c2cd drivers/video/pxafb.c Eric Miao          2008-12-23  960  	/* mask all IU/BS/EOF/SOF interrupts */
198fc108ee4c2cd drivers/video/pxafb.c Eric Miao          2008-12-23  961  	lcd_writel(fbi, LCCR5, ~0);
198fc108ee4c2cd drivers/video/pxafb.c Eric Miao          2008-12-23  962  
198fc108ee4c2cd drivers/video/pxafb.c Eric Miao          2008-12-23  963  	pr_info("PXA Overlay driver loaded successfully!\n");
198fc108ee4c2cd drivers/video/pxafb.c Eric Miao          2008-12-23  964  }
198fc108ee4c2cd drivers/video/pxafb.c Eric Miao          2008-12-23  965  
48c68c4f1b54244 drivers/video/pxafb.c Greg Kroah-Hartman 2012-12-21  966  static void pxafb_overlay_exit(struct pxafb_info *fbi)
198fc108ee4c2cd drivers/video/pxafb.c Eric Miao          2008-12-23  967  {
198fc108ee4c2cd drivers/video/pxafb.c Eric Miao          2008-12-23  968  	int i;
198fc108ee4c2cd drivers/video/pxafb.c Eric Miao          2008-12-23  969  
782385ae176b304 drivers/video/pxafb.c Eric Miao          2009-03-19  970  	if (!pxafb_overlay_supported())
782385ae176b304 drivers/video/pxafb.c Eric Miao          2009-03-19  971  		return;
782385ae176b304 drivers/video/pxafb.c Eric Miao          2009-03-19  972  
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  973  	for (i = 0; i < 2; i++) {
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  974  		struct pxafb_layer *ofb = &fbi->overlay[i];
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  975  		if (ofb->registered) {
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  976  			if (ofb->video_mem)
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11 @977  				free_pages_exact(ofb->video_mem,
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  978  					ofb->video_mem_size);
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  979  			unregister_framebuffer(&ofb->fb);
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  980  		}
1b98d7c4491e5ea drivers/video/pxafb.c Vasily Khoruzhick  2011-03-11  981  	}
198fc108ee4c2cd drivers/video/pxafb.c Eric Miao          2008-12-23  982  }
198fc108ee4c2cd drivers/video/pxafb.c Eric Miao          2008-12-23  983  #else
198fc108ee4c2cd drivers/video/pxafb.c Eric Miao          2008-12-23  984  static inline void pxafb_overlay_init(struct pxafb_info *fbi) {}
198fc108ee4c2cd drivers/video/pxafb.c Eric Miao          2008-12-23  985  static inline void pxafb_overlay_exit(struct pxafb_info *fbi) {}
198fc108ee4c2cd drivers/video/pxafb.c Eric Miao          2008-12-23  986  #endif /* CONFIG_FB_PXA_OVERLAY */
198fc108ee4c2cd drivers/video/pxafb.c Eric Miao          2008-12-23  987  

:::::: The code at line 916 was first introduced by commit
:::::: 1b98d7c4491e5eaba7c403ec1bc5997e6596e569 ARM: pxafb: rework pxafb overlay memory management

:::::: TO: Vasily Khoruzhick <anarsoul@gmail.com>
:::::: CC: Eric Miao <eric.y.miao@gmail.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--G4iJoqBmSsgzjUCe
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
AQA=

--G4iJoqBmSsgzjUCe--
