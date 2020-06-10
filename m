Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86830C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 05:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63D77207F9
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 05:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgFJFif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 01:38:35 -0400
Received: from mga17.intel.com ([192.55.52.151]:29874 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725270AbgFJFif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 01:38:35 -0400
IronPort-SDR: sEhrUSelEQUOvyCZfD07huhGmoYPIwGVyNgZUomdMIQrZMkTQN6nqYfpbsBDrlBq5ZGVPQwUaL
 z7l/o6u3GQVA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 22:38:33 -0700
IronPort-SDR: Jh98UpqBE+irruJrjuF63PYRxhFGIGJ+//fv6RL8eiITuw1f419WJTlRYg8uEx8FYtwO+2Iw5o
 W3tLfTt8Gl1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,494,1583222400"; 
   d="scan'208";a="314403654"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Jun 2020 22:38:31 -0700
Subject: Re: [PATCH v7 2/4] lib/test_bitmap.c: Add for_each_set_clump test
 cases
To:     Syed Nayyar Waris <syednwaris@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     kbuild test robot <lkp@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kbuild-all@lists.01.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <042eddd4b87f0db3588a79d829afe6b23fa8365c.1590017578.git.syednwaris@gmail.com>
 <202005310310.EOelU2v3%lkp@intel.com>
 <CACG_h5oHmkAp68q0EFXZEWhG15EQSHLgx=78gZ72aLShZOztFA@mail.gmail.com>
 <20200605122428.GD2428291@smile.fi.intel.com>
 <CACG_h5pHC1gQ62zAatUvgHakuGO6P-OLEwMHoU4_ObNDufXFqA@mail.gmail.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <ff824cb9-f8ed-50e2-2ae3-6d2211054334@intel.com>
Date:   Wed, 10 Jun 2020 13:38:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CACG_h5pHC1gQ62zAatUvgHakuGO6P-OLEwMHoU4_ObNDufXFqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/7/20 7:15 AM, Syed Nayyar Waris wrote:
> On Fri, Jun 5, 2020 at 5:54 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>> On Fri, Jun 05, 2020 at 02:12:54AM +0530, Syed Nayyar Waris wrote:
>>> On Sun, May 31, 2020 at 12:50 AM kbuild test robot <lkp@intel.com> wrote:
>>>>>> WARNING: modpost: lib/test_bitmap.o(.data+0xe80): Section mismatch in reference from the variable clump_test_data to the variable .init.rodata:clump_exp1
>>>> The variable clump_test_data references
>>>> the variable __initconst clump_exp1
>>>> If the reference is valid then annotate the
>>>> variable with or __refdata (see linux/init.h) or name the variable:
>>>>
>>>> --
>>>>>> WARNING: modpost: lib/test_bitmap.o(.data+0xec8): Section mismatch in reference from the variable clump_test_data to the variable .init.rodata:clump_exp2
>>>> The variable clump_test_data references
>>>> the variable __initconst clump_exp2
>>>> If the reference is valid then annotate the
>>>> variable with or __refdata (see linux/init.h) or name the variable:
>>>>
>>>> --
>>>>>> WARNING: modpost: lib/test_bitmap.o(.data+0xf10): Section mismatch in reference from the variable clump_test_data to the variable .init.rodata:clump_exp3
>>>> The variable clump_test_data references
>>>> the variable __initconst clump_exp3
>>>> If the reference is valid then annotate the
>>>> variable with or __refdata (see linux/init.h) or name the variable:
>>>>
>>>> --
>>>>>> WARNING: modpost: lib/test_bitmap.o(.data+0xf58): Section mismatch in reference from the variable clump_test_data to the variable .init.rodata:clump_exp4
>>>> The variable clump_test_data references
>>>> the variable __initconst clump_exp4
>>>> If the reference is valid then annotate the
>>>> variable with or __refdata (see linux/init.h) or name the variable:
>>> I am unable to reproduce the compilation warning.
>> You have to enable section mismatch checker.
>>
>>> I ran the command:
>>> make W=1 C=1 ARCH=x86_64 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'  lib/
>>>
>>> But the compilation warning didn't show up. Can anyone please point to me
>>> what I am doing wrong here? How shall I reproduce the warning? Thanks !
>> You put some data into init section of the object, while you are trying to
>> access it from non-init one. It's easy-to-fix issue.
>>
>> --
>> With Best Regards,
>> Andy Shevchenko
> Thanks! I have made code changes for the above warning. Actually I am
> still unable to reproduce the compilation warning. But I believe the
> following code fix will fix the compilation warning:
>
> In file lib/test_bitmap.c
>
> @@ -692,7 +692,7 @@ struct clump_test_data_params {
>          unsigned long const *exp;
>   };
>
> -struct clump_test_data_params clump_test_data[] =
> +static struct clump_test_data_params clump_test_data[] __initdata =
>                                          { {{0}, 2, 0, 64, 8, clump_exp1},
>                                          {{0}, 8, 2, 240, 24, clump_exp2},
>                                          {{0}, 8, 10, 240, 30, clump_exp3},
>
>
>
> Let me know if I should submit a new patchset (v8) for
> 'for_each_set_clump' including above code fix.
>
> Just to share how I attempted to reproduce the warning (but unsuccessful):
>
> Step 1: Use the config file in attachment. Download, extract, rename
> file to .config at the root of the tree.
> Step 2: '$ make lib/'
> No warning reproduced after above step 2.
> Step 3: '$ make W=1 C=1 ARCH=x86_64 CF='-fdiagnostic-prefix
> -D__CHECK_ENDIAN__' lib/'
> After step 3 I got error in build:
> scripts/kconfig/conf  --syncconfig Kconfig
>    CHECK   scripts/mod/empty.c
> No such file: asan-globals=1
> scripts/Makefile.build:266: recipe for target 'scripts/mod/empty.o' failed
> make[1]: *** [scripts/mod/empty.o] Error 1
> Makefile:1147: recipe for target 'prepare0' failed
> make: *** [prepare0] Error 2
>
> The command in above step 3 was mentioned in the bot mail.
>
> Regards
> Syed Nayyar Waris
>

Hi Syed Nayyar Waris,

We can reproduce the warning with the steps in original report,
you may need to build the whole kernel instead of the 'lib'.

Best Regards,
Rong Chen
