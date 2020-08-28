Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F8AC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 13:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6481B20872
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 13:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbgH1NjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 09:39:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:3512 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729523AbgH1Nf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 09:35:28 -0400
IronPort-SDR: Z4vvGXgUCUrtGy883O0KLr4xI8LSXtKbGaVE7rRQsvUOtYdg6QVzojO/Fi1mk+5syVzVSUxuNx
 +lOADUEMsswQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="136717380"
X-IronPort-AV: E=Sophos;i="5.76,363,1592895600"; 
   d="gz'50?scan'50,208,50";a="136717380"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 05:20:47 -0700
IronPort-SDR: UsqAhuEnEw/YeDPe7k8qja0jmSM3Xzz19MN7PpkOHbviFfn/Fevtx+dLQ5tKcIfJK1ykuU1N01
 iKWRCr+BJ5ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,363,1592895600"; 
   d="gz'50?scan'50,208,50";a="444820616"
Received: from lkp-server02.sh.intel.com (HELO 301dc1beeb51) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 28 Aug 2020 05:20:45 -0700
Received: from kbuild by 301dc1beeb51 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kBdN6-00001N-Fm; Fri, 28 Aug 2020 12:20:44 +0000
Date:   Fri, 28 Aug 2020 20:20:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] sparse: use static inline for __chk_{user,io}_ptr()
Message-ID: <202008282038.2vr1pJ5u%lkp@intel.com>
References: <20200828085301.78423-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <20200828085301.78423-1-luc.vanoostenryck@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Luc,

I love your patch! Perhaps something to improve:

[auto build test WARNING on 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5]

url:    https://github.com/0day-ci/linux/commits/Luc-Van-Oostenryck/sparse-use-static-inline-for-__chk_-user-io-_ptr/20200828-165431
base:    9123e3a74ec7b934a4a099e98af6a61c2f80bbf5
config: x86_64-randconfig-s021-20200828 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.2-191-g10164920-dirty
        # save the attached .config to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/firmware/efi/test/efi_test.c:157:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *[addressable] data_size @@
>> drivers/firmware/efi/test/efi_test.c:157:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:157:13: sparse:     got unsigned long *[addressable] data_size
   drivers/firmware/efi/test/efi_test.c:160:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct guid_t [usertype] *[addressable] vendor_guid @@
   drivers/firmware/efi/test/efi_test.c:160:61: sparse:     expected void const [noderef] __user *from
   drivers/firmware/efi/test/efi_test.c:160:61: sparse:     got struct guid_t [usertype] *[addressable] vendor_guid
   drivers/firmware/efi/test/efi_test.c:167:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected unsigned short [noderef] [usertype] __user *src @@     got unsigned short [usertype] *[addressable] variable_name @@
   drivers/firmware/efi/test/efi_test.c:167:60: sparse:     expected unsigned short [noderef] [usertype] __user *src
   drivers/firmware/efi/test/efi_test.c:167:60: sparse:     got unsigned short [usertype] *[addressable] variable_name
>> drivers/firmware/efi/test/efi_test.c:187:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:187:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:187:13: sparse:     got unsigned long [usertype] *[addressable] status
   drivers/firmware/efi/test/efi_test.c:194:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *[addressable] data_size @@
   drivers/firmware/efi/test/efi_test.c:194:35: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:194:35: sparse:     got unsigned long *[addressable] data_size
   drivers/firmware/efi/test/efi_test.c:209:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got void *[addressable] data @@
   drivers/firmware/efi/test/efi_test.c:209:45: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:209:45: sparse:     got void *[addressable] data
>> drivers/firmware/efi/test/efi_test.c:215:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int [usertype] *[addressable] attributes @@
   drivers/firmware/efi/test/efi_test.c:215:19: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:215:19: sparse:     got unsigned int [usertype] *[addressable] attributes
   drivers/firmware/efi/test/efi_test.c:220:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *[addressable] data_size @@
   drivers/firmware/efi/test/efi_test.c:220:19: sparse:     expected void const volatile [noderef] __user *ptr
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
   drivers/firmware/efi/test/efi_test.c:263:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:263:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:263:13: sparse:     got unsigned long [usertype] *[addressable] status
   drivers/firmware/efi/test/efi_test.c:292:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:292:13: sparse:     expected void const volatile [noderef] __user *ptr
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
   drivers/firmware/efi/test/efi_test.c:330:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:330:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:330:13: sparse:     got unsigned long [usertype] *[addressable] status
   drivers/firmware/efi/test/efi_test.c:354:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:354:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:354:13: sparse:     got unsigned long [usertype] *[addressable] status
>> drivers/firmware/efi/test/efi_test.c:360:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char [usertype] *[addressable] enabled @@
   drivers/firmware/efi/test/efi_test.c:360:38: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:360:38: sparse:     got unsigned char [usertype] *[addressable] enabled
   drivers/firmware/efi/test/efi_test.c:365:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got struct efi_time_t [usertype] *[addressable] time @@
   drivers/firmware/efi/test/efi_test.c:365:47: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:365:47: sparse:     got struct efi_time_t [usertype] *[addressable] time
   drivers/firmware/efi/test/efi_test.c:389:60: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct efi_time_t [usertype] *[addressable] time @@
   drivers/firmware/efi/test/efi_test.c:389:60: sparse:     expected void const [noderef] __user *from
   drivers/firmware/efi/test/efi_test.c:389:60: sparse:     got struct efi_time_t [usertype] *[addressable] time
   drivers/firmware/efi/test/efi_test.c:397:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:397:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:397:13: sparse:     got unsigned long [usertype] *[addressable] status
>> drivers/firmware/efi/test/efi_test.c:421:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *[addressable] variable_name_size @@
   drivers/firmware/efi/test/efi_test.c:421:21: sparse:     expected void const volatile [noderef] __user *ptr
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
   drivers/firmware/efi/test/efi_test.c:461:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:461:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:461:13: sparse:     got unsigned long [usertype] *[addressable] status
   drivers/firmware/efi/test/efi_test.c:468:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *[addressable] variable_name_size @@
   drivers/firmware/efi/test/efi_test.c:468:35: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:468:35: sparse:     got unsigned long *[addressable] variable_name_size
   drivers/firmware/efi/test/efi_test.c:479:62: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short [noderef] [usertype] __user *dst @@     got unsigned short [usertype] *[addressable] variable_name @@
   drivers/firmware/efi/test/efi_test.c:479:62: sparse:     expected unsigned short [noderef] [usertype] __user *dst
   drivers/firmware/efi/test/efi_test.c:479:62: sparse:     got unsigned short [usertype] *[addressable] variable_name
   drivers/firmware/efi/test/efi_test.c:487:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *[addressable] variable_name_size @@
   drivers/firmware/efi/test/efi_test.c:487:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:487:21: sparse:     got unsigned long *[addressable] variable_name_size
   drivers/firmware/efi/test/efi_test.c:494:53: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got struct guid_t [usertype] *[addressable] vendor_guid @@
   drivers/firmware/efi/test/efi_test.c:494:53: sparse:     expected void [noderef] __user *to
   drivers/firmware/efi/test/efi_test.c:494:53: sparse:     got struct guid_t [usertype] *[addressable] vendor_guid
   drivers/firmware/efi/test/efi_test.c:522:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:522:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:522:13: sparse:     got unsigned long [usertype] *[addressable] status
>> drivers/firmware/efi/test/efi_test.c:529:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int [usertype] *[addressable] high_count @@
   drivers/firmware/efi/test/efi_test.c:529:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:529:13: sparse:     got unsigned int [usertype] *[addressable] high_count
   drivers/firmware/efi/test/efi_test.c:546:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __user * @@     got void * @@
   drivers/firmware/efi/test/efi_test.c:546:37: sparse:     expected void const [noderef] __user *
   drivers/firmware/efi/test/efi_test.c:546:37: sparse:     got void *
   drivers/firmware/efi/test/efi_test.c:575:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long [usertype] *[addressable] status @@
   drivers/firmware/efi/test/efi_test.c:575:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:575:13: sparse:     got unsigned long [usertype] *[addressable] status
>> drivers/firmware/efi/test/efi_test.c:581:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long [usertype] *[addressable] maximum_variable_storage_size @@
   drivers/firmware/efi/test/efi_test.c:581:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:581:13: sparse:     got unsigned long long [usertype] *[addressable] maximum_variable_storage_size
>> drivers/firmware/efi/test/efi_test.c:585:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long [usertype] *[addressable] remaining_variable_storage_size @@
   drivers/firmware/efi/test/efi_test.c:585:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:585:13: sparse:     got unsigned long long [usertype] *[addressable] remaining_variable_storage_size
   drivers/firmware/efi/test/efi_test.c:589:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long [usertype] *[addressable] maximum_variable_size @@
   drivers/firmware/efi/test/efi_test.c:589:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:589:13: sparse:     got unsigned long long [usertype] *[addressable] maximum_variable_size
>> drivers/firmware/efi/test/efi_test.c:625:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got struct efi_capsule_header_t [usertype] ** @@
   drivers/firmware/efi/test/efi_test.c:625:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:625:21: sparse:     got struct efi_capsule_header_t [usertype] **
   drivers/firmware/efi/test/efi_test.c:629:50: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct efi_capsule_header_t [usertype] *[assigned] c @@
   drivers/firmware/efi/test/efi_test.c:629:50: sparse:     expected void const [noderef] __user *from
   drivers/firmware/efi/test/efi_test.c:629:50: sparse:     got struct efi_capsule_header_t [usertype] *[assigned] c
>> drivers/firmware/efi/test/efi_test.c:643:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long [usertype] *[addressable] [assigned] status @@
   drivers/firmware/efi/test/efi_test.c:643:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:643:13: sparse:     got unsigned long [usertype] *[addressable] [assigned] status
>> drivers/firmware/efi/test/efi_test.c:653:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long [usertype] *[addressable] [assigned] maximum_capsule_size @@
   drivers/firmware/efi/test/efi_test.c:653:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:653:13: sparse:     got unsigned long long [usertype] *[addressable] [assigned] maximum_capsule_size
>> drivers/firmware/efi/test/efi_test.c:658:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int *[addressable] [assigned] reset_type @@
   drivers/firmware/efi/test/efi_test.c:658:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:658:13: sparse:     got int *[addressable] [assigned] reset_type
   drivers/firmware/efi/test/efi_test.c:35:27: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [usertype] *s @@     got unsigned short [noderef] [usertype] __user *str @@
   drivers/firmware/efi/test/efi_test.c:35:27: sparse:     expected unsigned short [usertype] *s
   drivers/firmware/efi/test/efi_test.c:35:27: sparse:     got unsigned short [noderef] [usertype] __user *str
>> drivers/firmware/efi/test/efi_test.c:44:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short [usertype] * @@
   drivers/firmware/efi/test/efi_test.c:44:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:44:13: sparse:     got unsigned short [usertype] *
   drivers/firmware/efi/test/efi_test.c:50:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short [usertype] * @@
   drivers/firmware/efi/test/efi_test.c:50:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:50:21: sparse:     got unsigned short [usertype] *
   drivers/firmware/efi/test/efi_test.c:35:27: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [usertype] *[assigned] s @@     got unsigned short [noderef] [usertype] __user *str @@
   drivers/firmware/efi/test/efi_test.c:35:27: sparse:     expected unsigned short [usertype] *[assigned] s
   drivers/firmware/efi/test/efi_test.c:35:27: sparse:     got unsigned short [noderef] [usertype] __user *str
>> drivers/firmware/efi/test/efi_test.c:44:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short [usertype] * @@
   drivers/firmware/efi/test/efi_test.c:44:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:44:13: sparse:     got unsigned short [usertype] *
   drivers/firmware/efi/test/efi_test.c:50:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short [usertype] * @@
   drivers/firmware/efi/test/efi_test.c:50:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:50:21: sparse:     got unsigned short [usertype] *
   drivers/firmware/efi/test/efi_test.c:35:27: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short [usertype] *[assigned] s @@     got unsigned short [noderef] [usertype] __user *str @@
   drivers/firmware/efi/test/efi_test.c:35:27: sparse:     expected unsigned short [usertype] *[assigned] s
   drivers/firmware/efi/test/efi_test.c:35:27: sparse:     got unsigned short [noderef] [usertype] __user *str
>> drivers/firmware/efi/test/efi_test.c:44:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short [usertype] * @@
   drivers/firmware/efi/test/efi_test.c:44:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:44:13: sparse:     got unsigned short [usertype] *
   drivers/firmware/efi/test/efi_test.c:50:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short [usertype] * @@
   drivers/firmware/efi/test/efi_test.c:50:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firmware/efi/test/efi_test.c:50:21: sparse:     got unsigned short [usertype] *

# https://github.com/0day-ci/linux/commit/7d01c91ac34a64f0177bc6d058cc50e805f59102
git remote add linux-review https://github.com/0day-ci/linux
git fetch --no-tags linux-review Luc-Van-Oostenryck/sparse-use-static-inline-for-__chk_-user-io-_ptr/20200828-165431
git checkout 7d01c91ac34a64f0177bc6d058cc50e805f59102
vim +157 drivers/firmware/efi/test/efi_test.c

ff6301dabc3ca20 Ivan Hu      2016-08-25   26  
ff6301dabc3ca20 Ivan Hu      2016-08-25   27  /*
ff6301dabc3ca20 Ivan Hu      2016-08-25   28   * Count the bytes in 'str', including the terminating NULL.
ff6301dabc3ca20 Ivan Hu      2016-08-25   29   *
ff6301dabc3ca20 Ivan Hu      2016-08-25   30   * Note this function returns the number of *bytes*, not the number of
ff6301dabc3ca20 Ivan Hu      2016-08-25   31   * ucs2 characters.
ff6301dabc3ca20 Ivan Hu      2016-08-25   32   */
ff6301dabc3ca20 Ivan Hu      2016-08-25   33  static inline size_t user_ucs2_strsize(efi_char16_t  __user *str)
ff6301dabc3ca20 Ivan Hu      2016-08-25   34  {
ff6301dabc3ca20 Ivan Hu      2016-08-25   35  	efi_char16_t *s = str, c;
ff6301dabc3ca20 Ivan Hu      2016-08-25   36  	size_t len;
ff6301dabc3ca20 Ivan Hu      2016-08-25   37  
ff6301dabc3ca20 Ivan Hu      2016-08-25   38  	if (!str)
ff6301dabc3ca20 Ivan Hu      2016-08-25   39  		return 0;
ff6301dabc3ca20 Ivan Hu      2016-08-25   40  
ff6301dabc3ca20 Ivan Hu      2016-08-25   41  	/* Include terminating NULL */
ff6301dabc3ca20 Ivan Hu      2016-08-25   42  	len = sizeof(efi_char16_t);
ff6301dabc3ca20 Ivan Hu      2016-08-25   43  
ff6301dabc3ca20 Ivan Hu      2016-08-25  @44  	if (get_user(c, s++)) {
ff6301dabc3ca20 Ivan Hu      2016-08-25   45  		/* Can't read userspace memory for size */
ff6301dabc3ca20 Ivan Hu      2016-08-25   46  		return 0;
ff6301dabc3ca20 Ivan Hu      2016-08-25   47  	}
ff6301dabc3ca20 Ivan Hu      2016-08-25   48  
ff6301dabc3ca20 Ivan Hu      2016-08-25   49  	while (c != 0) {
ff6301dabc3ca20 Ivan Hu      2016-08-25   50  		if (get_user(c, s++)) {
ff6301dabc3ca20 Ivan Hu      2016-08-25   51  			/* Can't read userspace memory for size */
ff6301dabc3ca20 Ivan Hu      2016-08-25   52  			return 0;
ff6301dabc3ca20 Ivan Hu      2016-08-25   53  		}
ff6301dabc3ca20 Ivan Hu      2016-08-25   54  		len += sizeof(efi_char16_t);
ff6301dabc3ca20 Ivan Hu      2016-08-25   55  	}
ff6301dabc3ca20 Ivan Hu      2016-08-25   56  	return len;
ff6301dabc3ca20 Ivan Hu      2016-08-25   57  }
ff6301dabc3ca20 Ivan Hu      2016-08-25   58  
ff6301dabc3ca20 Ivan Hu      2016-08-25   59  /*
ff6301dabc3ca20 Ivan Hu      2016-08-25   60   * Allocate a buffer and copy a ucs2 string from user space into it.
ff6301dabc3ca20 Ivan Hu      2016-08-25   61   */
ff6301dabc3ca20 Ivan Hu      2016-08-25   62  static inline int
ff6301dabc3ca20 Ivan Hu      2016-08-25   63  copy_ucs2_from_user_len(efi_char16_t **dst, efi_char16_t __user *src,
ff6301dabc3ca20 Ivan Hu      2016-08-25   64  			size_t len)
ff6301dabc3ca20 Ivan Hu      2016-08-25   65  {
ff6301dabc3ca20 Ivan Hu      2016-08-25   66  	efi_char16_t *buf;
ff6301dabc3ca20 Ivan Hu      2016-08-25   67  
ff6301dabc3ca20 Ivan Hu      2016-08-25   68  	if (!src) {
ff6301dabc3ca20 Ivan Hu      2016-08-25   69  		*dst = NULL;
ff6301dabc3ca20 Ivan Hu      2016-08-25   70  		return 0;
ff6301dabc3ca20 Ivan Hu      2016-08-25   71  	}
ff6301dabc3ca20 Ivan Hu      2016-08-25   72  
5f72cad65cfaac5 Geliang Tang 2017-06-02   73  	buf = memdup_user(src, len);
5f72cad65cfaac5 Geliang Tang 2017-06-02   74  	if (IS_ERR(buf)) {
ff6301dabc3ca20 Ivan Hu      2016-08-25   75  		*dst = NULL;
5f72cad65cfaac5 Geliang Tang 2017-06-02   76  		return PTR_ERR(buf);
ff6301dabc3ca20 Ivan Hu      2016-08-25   77  	}
ff6301dabc3ca20 Ivan Hu      2016-08-25   78  	*dst = buf;
ff6301dabc3ca20 Ivan Hu      2016-08-25   79  
ff6301dabc3ca20 Ivan Hu      2016-08-25   80  	return 0;
ff6301dabc3ca20 Ivan Hu      2016-08-25   81  }
ff6301dabc3ca20 Ivan Hu      2016-08-25   82  
ff6301dabc3ca20 Ivan Hu      2016-08-25   83  /*
ff6301dabc3ca20 Ivan Hu      2016-08-25   84   * Count the bytes in 'str', including the terminating NULL.
ff6301dabc3ca20 Ivan Hu      2016-08-25   85   *
ff6301dabc3ca20 Ivan Hu      2016-08-25   86   * Just a wrap for user_ucs2_strsize
ff6301dabc3ca20 Ivan Hu      2016-08-25   87   */
ff6301dabc3ca20 Ivan Hu      2016-08-25   88  static inline int
ff6301dabc3ca20 Ivan Hu      2016-08-25   89  get_ucs2_strsize_from_user(efi_char16_t __user *src, size_t *len)
ff6301dabc3ca20 Ivan Hu      2016-08-25   90  {
ff6301dabc3ca20 Ivan Hu      2016-08-25   91  	*len = user_ucs2_strsize(src);
ff6301dabc3ca20 Ivan Hu      2016-08-25   92  	if (*len == 0)
ff6301dabc3ca20 Ivan Hu      2016-08-25   93  		return -EFAULT;
ff6301dabc3ca20 Ivan Hu      2016-08-25   94  
ff6301dabc3ca20 Ivan Hu      2016-08-25   95  	return 0;
ff6301dabc3ca20 Ivan Hu      2016-08-25   96  }
ff6301dabc3ca20 Ivan Hu      2016-08-25   97  
ff6301dabc3ca20 Ivan Hu      2016-08-25   98  /*
ff6301dabc3ca20 Ivan Hu      2016-08-25   99   * Calculate the required buffer allocation size and copy a ucs2 string
ff6301dabc3ca20 Ivan Hu      2016-08-25  100   * from user space into it.
ff6301dabc3ca20 Ivan Hu      2016-08-25  101   *
ff6301dabc3ca20 Ivan Hu      2016-08-25  102   * This function differs from copy_ucs2_from_user_len() because it
ff6301dabc3ca20 Ivan Hu      2016-08-25  103   * calculates the size of the buffer to allocate by taking the length of
ff6301dabc3ca20 Ivan Hu      2016-08-25  104   * the string 'src'.
ff6301dabc3ca20 Ivan Hu      2016-08-25  105   *
ff6301dabc3ca20 Ivan Hu      2016-08-25  106   * If a non-zero value is returned, the caller MUST NOT access 'dst'.
ff6301dabc3ca20 Ivan Hu      2016-08-25  107   *
ff6301dabc3ca20 Ivan Hu      2016-08-25  108   * It is the caller's responsibility to free 'dst'.
ff6301dabc3ca20 Ivan Hu      2016-08-25  109   */
ff6301dabc3ca20 Ivan Hu      2016-08-25  110  static inline int
ff6301dabc3ca20 Ivan Hu      2016-08-25  111  copy_ucs2_from_user(efi_char16_t **dst, efi_char16_t __user *src)
ff6301dabc3ca20 Ivan Hu      2016-08-25  112  {
ff6301dabc3ca20 Ivan Hu      2016-08-25  113  	size_t len;
ff6301dabc3ca20 Ivan Hu      2016-08-25  114  
ff6301dabc3ca20 Ivan Hu      2016-08-25  115  	len = user_ucs2_strsize(src);
ff6301dabc3ca20 Ivan Hu      2016-08-25  116  	if (len == 0)
ff6301dabc3ca20 Ivan Hu      2016-08-25  117  		return -EFAULT;
ff6301dabc3ca20 Ivan Hu      2016-08-25  118  	return copy_ucs2_from_user_len(dst, src, len);
ff6301dabc3ca20 Ivan Hu      2016-08-25  119  }
ff6301dabc3ca20 Ivan Hu      2016-08-25  120  
ff6301dabc3ca20 Ivan Hu      2016-08-25  121  /*
ff6301dabc3ca20 Ivan Hu      2016-08-25  122   * Copy a ucs2 string to a user buffer.
ff6301dabc3ca20 Ivan Hu      2016-08-25  123   *
ff6301dabc3ca20 Ivan Hu      2016-08-25  124   * This function is a simple wrapper around copy_to_user() that does
ff6301dabc3ca20 Ivan Hu      2016-08-25  125   * nothing if 'src' is NULL, which is useful for reducing the amount of
ff6301dabc3ca20 Ivan Hu      2016-08-25  126   * NULL checking the caller has to do.
ff6301dabc3ca20 Ivan Hu      2016-08-25  127   *
ff6301dabc3ca20 Ivan Hu      2016-08-25  128   * 'len' specifies the number of bytes to copy.
ff6301dabc3ca20 Ivan Hu      2016-08-25  129   */
ff6301dabc3ca20 Ivan Hu      2016-08-25  130  static inline int
ff6301dabc3ca20 Ivan Hu      2016-08-25  131  copy_ucs2_to_user_len(efi_char16_t __user *dst, efi_char16_t *src, size_t len)
ff6301dabc3ca20 Ivan Hu      2016-08-25  132  {
ff6301dabc3ca20 Ivan Hu      2016-08-25  133  	if (!src)
ff6301dabc3ca20 Ivan Hu      2016-08-25  134  		return 0;
ff6301dabc3ca20 Ivan Hu      2016-08-25  135  
ff6301dabc3ca20 Ivan Hu      2016-08-25  136  	return copy_to_user(dst, src, len);
ff6301dabc3ca20 Ivan Hu      2016-08-25  137  }
ff6301dabc3ca20 Ivan Hu      2016-08-25  138  
ff6301dabc3ca20 Ivan Hu      2016-08-25  139  static long efi_runtime_get_variable(unsigned long arg)
ff6301dabc3ca20 Ivan Hu      2016-08-25  140  {
ff6301dabc3ca20 Ivan Hu      2016-08-25  141  	struct efi_getvariable __user *getvariable_user;
ff6301dabc3ca20 Ivan Hu      2016-08-25  142  	struct efi_getvariable getvariable;
46b9b7135332d1e Ivan Hu      2016-10-18  143  	unsigned long datasize = 0, prev_datasize, *dz;
ff6301dabc3ca20 Ivan Hu      2016-08-25  144  	efi_guid_t vendor_guid, *vd = NULL;
ff6301dabc3ca20 Ivan Hu      2016-08-25  145  	efi_status_t status;
ff6301dabc3ca20 Ivan Hu      2016-08-25  146  	efi_char16_t *name = NULL;
ff6301dabc3ca20 Ivan Hu      2016-08-25  147  	u32 attr, *at;
ff6301dabc3ca20 Ivan Hu      2016-08-25  148  	void *data = NULL;
ff6301dabc3ca20 Ivan Hu      2016-08-25  149  	int rv = 0;
ff6301dabc3ca20 Ivan Hu      2016-08-25  150  
ff6301dabc3ca20 Ivan Hu      2016-08-25  151  	getvariable_user = (struct efi_getvariable __user *)arg;
ff6301dabc3ca20 Ivan Hu      2016-08-25  152  
ff6301dabc3ca20 Ivan Hu      2016-08-25  153  	if (copy_from_user(&getvariable, getvariable_user,
ff6301dabc3ca20 Ivan Hu      2016-08-25  154  			   sizeof(getvariable)))
ff6301dabc3ca20 Ivan Hu      2016-08-25  155  		return -EFAULT;
ff6301dabc3ca20 Ivan Hu      2016-08-25  156  	if (getvariable.data_size &&
ff6301dabc3ca20 Ivan Hu      2016-08-25 @157  	    get_user(datasize, getvariable.data_size))
ff6301dabc3ca20 Ivan Hu      2016-08-25  158  		return -EFAULT;
ff6301dabc3ca20 Ivan Hu      2016-08-25  159  	if (getvariable.vendor_guid) {
ff6301dabc3ca20 Ivan Hu      2016-08-25  160  		if (copy_from_user(&vendor_guid, getvariable.vendor_guid,
ff6301dabc3ca20 Ivan Hu      2016-08-25  161  					sizeof(vendor_guid)))
ff6301dabc3ca20 Ivan Hu      2016-08-25  162  			return -EFAULT;
ff6301dabc3ca20 Ivan Hu      2016-08-25  163  		vd = &vendor_guid;
ff6301dabc3ca20 Ivan Hu      2016-08-25  164  	}
ff6301dabc3ca20 Ivan Hu      2016-08-25  165  
ff6301dabc3ca20 Ivan Hu      2016-08-25  166  	if (getvariable.variable_name) {
ff6301dabc3ca20 Ivan Hu      2016-08-25  167  		rv = copy_ucs2_from_user(&name, getvariable.variable_name);
ff6301dabc3ca20 Ivan Hu      2016-08-25  168  		if (rv)
ff6301dabc3ca20 Ivan Hu      2016-08-25  169  			return rv;
ff6301dabc3ca20 Ivan Hu      2016-08-25  170  	}
ff6301dabc3ca20 Ivan Hu      2016-08-25  171  
ff6301dabc3ca20 Ivan Hu      2016-08-25  172  	at = getvariable.attributes ? &attr : NULL;
ff6301dabc3ca20 Ivan Hu      2016-08-25  173  	dz = getvariable.data_size ? &datasize : NULL;
ff6301dabc3ca20 Ivan Hu      2016-08-25  174  
ff6301dabc3ca20 Ivan Hu      2016-08-25  175  	if (getvariable.data_size && getvariable.data) {
ff6301dabc3ca20 Ivan Hu      2016-08-25  176  		data = kmalloc(datasize, GFP_KERNEL);
ff6301dabc3ca20 Ivan Hu      2016-08-25  177  		if (!data) {
ff6301dabc3ca20 Ivan Hu      2016-08-25  178  			kfree(name);
ff6301dabc3ca20 Ivan Hu      2016-08-25  179  			return -ENOMEM;
ff6301dabc3ca20 Ivan Hu      2016-08-25  180  		}
ff6301dabc3ca20 Ivan Hu      2016-08-25  181  	}
ff6301dabc3ca20 Ivan Hu      2016-08-25  182  
ff6301dabc3ca20 Ivan Hu      2016-08-25  183  	prev_datasize = datasize;
ff6301dabc3ca20 Ivan Hu      2016-08-25  184  	status = efi.get_variable(name, vd, at, dz, data);
ff6301dabc3ca20 Ivan Hu      2016-08-25  185  	kfree(name);
ff6301dabc3ca20 Ivan Hu      2016-08-25  186  
ff6301dabc3ca20 Ivan Hu      2016-08-25 @187  	if (put_user(status, getvariable.status)) {
ff6301dabc3ca20 Ivan Hu      2016-08-25  188  		rv = -EFAULT;
ff6301dabc3ca20 Ivan Hu      2016-08-25  189  		goto out;
ff6301dabc3ca20 Ivan Hu      2016-08-25  190  	}
ff6301dabc3ca20 Ivan Hu      2016-08-25  191  
ff6301dabc3ca20 Ivan Hu      2016-08-25  192  	if (status != EFI_SUCCESS) {
ff6301dabc3ca20 Ivan Hu      2016-08-25  193  		if (status == EFI_BUFFER_TOO_SMALL) {
ff6301dabc3ca20 Ivan Hu      2016-08-25  194  			if (dz && put_user(datasize, getvariable.data_size)) {
ff6301dabc3ca20 Ivan Hu      2016-08-25  195  				rv = -EFAULT;
ff6301dabc3ca20 Ivan Hu      2016-08-25  196  				goto out;
ff6301dabc3ca20 Ivan Hu      2016-08-25  197  			}
ff6301dabc3ca20 Ivan Hu      2016-08-25  198  		}
ff6301dabc3ca20 Ivan Hu      2016-08-25  199  		rv = -EINVAL;
ff6301dabc3ca20 Ivan Hu      2016-08-25  200  		goto out;
ff6301dabc3ca20 Ivan Hu      2016-08-25  201  	}
ff6301dabc3ca20 Ivan Hu      2016-08-25  202  
ff6301dabc3ca20 Ivan Hu      2016-08-25  203  	if (prev_datasize < datasize) {
ff6301dabc3ca20 Ivan Hu      2016-08-25  204  		rv = -EINVAL;
ff6301dabc3ca20 Ivan Hu      2016-08-25  205  		goto out;
ff6301dabc3ca20 Ivan Hu      2016-08-25  206  	}
ff6301dabc3ca20 Ivan Hu      2016-08-25  207  
ff6301dabc3ca20 Ivan Hu      2016-08-25  208  	if (data) {
ff6301dabc3ca20 Ivan Hu      2016-08-25  209  		if (copy_to_user(getvariable.data, data, datasize)) {
ff6301dabc3ca20 Ivan Hu      2016-08-25  210  			rv = -EFAULT;
ff6301dabc3ca20 Ivan Hu      2016-08-25  211  			goto out;
ff6301dabc3ca20 Ivan Hu      2016-08-25  212  		}
ff6301dabc3ca20 Ivan Hu      2016-08-25  213  	}
ff6301dabc3ca20 Ivan Hu      2016-08-25  214  
ff6301dabc3ca20 Ivan Hu      2016-08-25 @215  	if (at && put_user(attr, getvariable.attributes)) {
ff6301dabc3ca20 Ivan Hu      2016-08-25  216  		rv = -EFAULT;
ff6301dabc3ca20 Ivan Hu      2016-08-25  217  		goto out;
ff6301dabc3ca20 Ivan Hu      2016-08-25  218  	}
ff6301dabc3ca20 Ivan Hu      2016-08-25  219  
ff6301dabc3ca20 Ivan Hu      2016-08-25  220  	if (dz && put_user(datasize, getvariable.data_size))
ff6301dabc3ca20 Ivan Hu      2016-08-25  221  		rv = -EFAULT;
ff6301dabc3ca20 Ivan Hu      2016-08-25  222  
ff6301dabc3ca20 Ivan Hu      2016-08-25  223  out:
ff6301dabc3ca20 Ivan Hu      2016-08-25  224  	kfree(data);
ff6301dabc3ca20 Ivan Hu      2016-08-25  225  	return rv;
ff6301dabc3ca20 Ivan Hu      2016-08-25  226  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--DocE+STaALJfprDB
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
RHaCxkgzrf8BhutfxQFHAgA=

--DocE+STaALJfprDB--
