Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D29C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2256420657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbgGOIZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:25:54 -0400
Received: from mga06.intel.com ([134.134.136.31]:25354 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729634AbgGOIZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:25:49 -0400
IronPort-SDR: cKR+C0cxxO4ReBVDuAFbpF6F3RWCT87b816WT/NkGde49ifner1YUlYiTxmaBRzepAsunawP+S
 g61YXhciloQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="210649904"
X-IronPort-AV: E=Sophos;i="5.75,354,1589266800"; 
   d="gz'50?scan'50,208,50";a="210649904"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 01:22:43 -0700
IronPort-SDR: 38rdSZD5IwhYMVzD/LJltgeXnRnhLU2ANIE+/SQGmQdSasg8Q6sAvLfoGrABybwdFU5ikoLNBr
 chPK+iQRWCBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,354,1589266800"; 
   d="gz'50?scan'50,208,50";a="485652308"
Received: from lkp-server01.sh.intel.com (HELO b157d87b7ee7) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 15 Jul 2020 01:22:40 -0700
Received: from kbuild by b157d87b7ee7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jvcga-00005a-AD; Wed, 15 Jul 2020 08:22:40 +0000
Date:   Wed, 15 Jul 2020 16:21:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/mtd/maps/pxa2xx-flash.c:71:26: sparse: sparse: incorrect
 type in assignment (different address spaces)
Message-ID: <202007151639.zUt59oak%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e9919e11e219eaa5e8041b7b1a196839143e9125
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   4 weeks ago
config: arm-randconfig-s031-20200715 (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-49-g707c5017-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/mtd/maps/pxa2xx-flash.c:71:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *cached @@     got void [noderef] __iomem * @@
   drivers/mtd/maps/pxa2xx-flash.c:71:26: sparse:     expected void *cached
>> drivers/mtd/maps/pxa2xx-flash.c:71:26: sparse:     got void [noderef] __iomem *
>> drivers/mtd/maps/pxa2xx-flash.c:87:26: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/mtd/maps/pxa2xx-flash.c:87:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got void * @@
>> drivers/mtd/maps/pxa2xx-flash.c:87:26: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/mtd/maps/pxa2xx-flash.c:87:26: sparse:     got void *
>> drivers/mtd/maps/pxa2xx-flash.c:89:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got void *cached @@
   drivers/mtd/maps/pxa2xx-flash.c:89:42: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/mtd/maps/pxa2xx-flash.c:89:42: sparse:     got void *cached
   drivers/mtd/maps/pxa2xx-flash.c:110:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *iomem_cookie @@     got void *cached @@
   drivers/mtd/maps/pxa2xx-flash.c:110:34: sparse:     expected void volatile [noderef] __iomem *iomem_cookie
   drivers/mtd/maps/pxa2xx-flash.c:110:34: sparse:     got void *cached
--
   drivers/net/ethernet/ethoc.c:313:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *vma @@     got void [noderef] __iomem *membase @@
   drivers/net/ethernet/ethoc.c:313:13: sparse:     expected void *vma
   drivers/net/ethernet/ethoc.c:313:13: sparse:     got void [noderef] __iomem *membase
>> drivers/net/ethernet/ethoc.c:450:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *from @@     got void *src @@
>> drivers/net/ethernet/ethoc.c:450:33: sparse:     expected void const volatile [noderef] __iomem *from
   drivers/net/ethernet/ethoc.c:450:33: sparse:     got void *src
>> drivers/net/ethernet/ethoc.c:908:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *to @@     got void *[assigned] dest @@
>> drivers/net/ethernet/ethoc.c:908:9: sparse:     expected void volatile [noderef] __iomem *to
   drivers/net/ethernet/ethoc.c:908:9: sparse:     got void *[assigned] dest
   drivers/net/ethernet/ethoc.c:1108:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *membase @@     got void * @@
   drivers/net/ethernet/ethoc.c:1108:31: sparse:     expected void [noderef] __iomem *membase
   drivers/net/ethernet/ethoc.c:1108:31: sparse:     got void *
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
--
>> drivers/video/fbdev/pxa3xx-gcu.c:412:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got char const *buff @@
>> drivers/video/fbdev/pxa3xx-gcu.c:412:43: sparse:     expected void const [noderef] __user *from
   drivers/video/fbdev/pxa3xx-gcu.c:412:43: sparse:     got char const *buff
   drivers/video/fbdev/pxa3xx-gcu.c:572:33: sparse: sparse: incorrect type in initializer (incompatible argument 2 (different address spaces)) @@     expected int ( *write )( ... ) @@     got int ( * )( ... ) @@
   drivers/video/fbdev/pxa3xx-gcu.c:572:33: sparse:     expected int ( *write )( ... )
   drivers/video/fbdev/pxa3xx-gcu.c:572:33: sparse:     got int ( * )( ... )
   drivers/video/fbdev/pxa3xx-gcu.c:153:15: sparse: sparse: memset with byte count of 262144
--
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
>> drivers/soc/qcom/smd-rpm.c:177:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *from @@     got unsigned char const * @@
>> drivers/soc/qcom/smd-rpm.c:177:25: sparse:     expected void const volatile [noderef] __iomem *from
   drivers/soc/qcom/smd-rpm.c:177:25: sparse:     got unsigned char const *

vim +71 drivers/mtd/maps/pxa2xx-flash.c

e644f7d6289456 Todd Poynor        2005-11-07   45  
06f25510692385 Bill Pemberton     2012-11-19   46  static int pxa2xx_flash_probe(struct platform_device *pdev)
e644f7d6289456 Todd Poynor        2005-11-07   47  {
d20d5a5780a014 Jingoo Han         2013-07-30   48  	struct flash_platform_data *flash = dev_get_platdata(&pdev->dev);
e644f7d6289456 Todd Poynor        2005-11-07   49  	struct pxa2xx_flash_info *info;
e644f7d6289456 Todd Poynor        2005-11-07   50  	struct resource *res;
e644f7d6289456 Todd Poynor        2005-11-07   51  
e644f7d6289456 Todd Poynor        2005-11-07   52  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
e644f7d6289456 Todd Poynor        2005-11-07   53  	if (!res)
e644f7d6289456 Todd Poynor        2005-11-07   54  		return -ENODEV;
e644f7d6289456 Todd Poynor        2005-11-07   55  
2bfefa4c9632fb Julia Lawall       2010-05-13   56  	info = kzalloc(sizeof(struct pxa2xx_flash_info), GFP_KERNEL);
e644f7d6289456 Todd Poynor        2005-11-07   57  	if (!info)
e644f7d6289456 Todd Poynor        2005-11-07   58  		return -ENOMEM;
e644f7d6289456 Todd Poynor        2005-11-07   59  
7c4bb4f8f8ad6d Geert Uytterhoeven 2013-11-12   60  	info->map.name = flash->name;
e644f7d6289456 Todd Poynor        2005-11-07   61  	info->map.bankwidth = flash->width;
e644f7d6289456 Todd Poynor        2005-11-07   62  	info->map.phys = res->start;
28f65c11f2ffb3 Joe Perches        2011-06-09   63  	info->map.size = resource_size(res);
e644f7d6289456 Todd Poynor        2005-11-07   64  
e644f7d6289456 Todd Poynor        2005-11-07   65  	info->map.virt = ioremap(info->map.phys, info->map.size);
e644f7d6289456 Todd Poynor        2005-11-07   66  	if (!info->map.virt) {
e644f7d6289456 Todd Poynor        2005-11-07   67  		printk(KERN_WARNING "Failed to ioremap %s\n",
e644f7d6289456 Todd Poynor        2005-11-07   68  		       info->map.name);
e644f7d6289456 Todd Poynor        2005-11-07   69  		return -ENOMEM;
e644f7d6289456 Todd Poynor        2005-11-07   70  	}
97ef08ae275e38 Christoph Hellwig  2019-08-17  @71  	info->map.cached = ioremap_cache(info->map.phys, info->map.size);
e644f7d6289456 Todd Poynor        2005-11-07   72  	if (!info->map.cached)
e644f7d6289456 Todd Poynor        2005-11-07   73  		printk(KERN_WARNING "Failed to ioremap cached %s\n",
e644f7d6289456 Todd Poynor        2005-11-07   74  		       info->map.name);
e644f7d6289456 Todd Poynor        2005-11-07   75  	info->map.inval_cache = pxa2xx_map_inval_cache;
e644f7d6289456 Todd Poynor        2005-11-07   76  	simple_map_init(&info->map);
e644f7d6289456 Todd Poynor        2005-11-07   77  
e644f7d6289456 Todd Poynor        2005-11-07   78  	printk(KERN_NOTICE
e644f7d6289456 Todd Poynor        2005-11-07   79  	       "Probing %s at physical address 0x%08lx"
e644f7d6289456 Todd Poynor        2005-11-07   80  	       " (%d-bit bankwidth)\n",
e644f7d6289456 Todd Poynor        2005-11-07   81  	       info->map.name, (unsigned long)info->map.phys,
e644f7d6289456 Todd Poynor        2005-11-07   82  	       info->map.bankwidth * 8);
e644f7d6289456 Todd Poynor        2005-11-07   83  
e644f7d6289456 Todd Poynor        2005-11-07   84  	info->mtd = do_map_probe(flash->map_name, &info->map);
e644f7d6289456 Todd Poynor        2005-11-07   85  
e644f7d6289456 Todd Poynor        2005-11-07   86  	if (!info->mtd) {
e644f7d6289456 Todd Poynor        2005-11-07  @87  		iounmap((void *)info->map.virt);
e644f7d6289456 Todd Poynor        2005-11-07   88  		if (info->map.cached)
e644f7d6289456 Todd Poynor        2005-11-07  @89  			iounmap(info->map.cached);
e644f7d6289456 Todd Poynor        2005-11-07   90  		return -EIO;
e644f7d6289456 Todd Poynor        2005-11-07   91  	}
2451581f94e3f5 Frans Klaver       2015-06-10   92  	info->mtd->dev.parent = &pdev->dev;
e644f7d6289456 Todd Poynor        2005-11-07   93  
42d7fbe223ab87 Artem Bityutskiy   2012-03-09   94  	mtd_device_parse_register(info->mtd, probes, NULL, flash->parts,
42d7fbe223ab87 Artem Bityutskiy   2012-03-09   95  				  flash->nr_parts);
e644f7d6289456 Todd Poynor        2005-11-07   96  
7a192ec334cab9 Ming Lei           2009-02-06   97  	platform_set_drvdata(pdev, info);
e644f7d6289456 Todd Poynor        2005-11-07   98  	return 0;
e644f7d6289456 Todd Poynor        2005-11-07   99  }
e644f7d6289456 Todd Poynor        2005-11-07  100  

:::::: The code at line 71 was first introduced by commit
:::::: 97ef08ae275e388321dcde9190adbaa0c67b93fe mtd: pxa2xx: Use ioremap_cache insted of ioremap_cached

:::::: TO: Christoph Hellwig <hch@lst.de>
:::::: CC: Richard Weinberger <richard@nod.at>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--T4sUOijqQbZv57TR
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--T4sUOijqQbZv57TR--
