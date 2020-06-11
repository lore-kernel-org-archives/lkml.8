Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E3AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 02:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ACB02072F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 02:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgFKCVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 22:21:33 -0400
Received: from mga11.intel.com ([192.55.52.93]:54271 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgFKCVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 22:21:33 -0400
IronPort-SDR: WjpSEb5mJSCFMt7WcSmNAmGZ7GKpI9RKKNCXvImrgwc9k5ZDnL3Eb7lCM49GZxFOAhpRdZJi2c
 O5DZm94IxqDg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 19:21:33 -0700
IronPort-SDR: crHdxxHrEsrSH17RRKCC8W6WOJ1FhQ0Lzw7W/xbrTzgcSHk2h/TNE66eFmKFisD6/Q9o1nubH8
 hiiYrLp2H2hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,498,1583222400"; 
   d="scan'208";a="473644260"
Received: from sshen-mobl1.ccr.corp.intel.com (HELO [10.255.28.22]) ([10.255.28.22])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jun 2020 19:21:12 -0700
Subject: Re: [kmemleak] b751c52bb5: BUG:kernel_hang_in_boot_stage
To:     Catalin Marinas <catalin.marinas@arm.com>,
        kernel test robot <rong.a.chen@intel.com>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20200610075156.GE12456@shao2-debian>
 <20200610105640.GB26099@gaia>
From:   Li Zhijian <zhijianx.li@intel.com>
Message-ID: <8795ed06-d67f-7bfe-506b-4f1d79e0170e@intel.com>
Date:   Thu, 11 Jun 2020 10:20:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20200610105640.GB26099@gaia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/10/20 6:56 PM, Catalin Marinas wrote:
> On Wed, Jun 10, 2020 at 03:51:56PM +0800, kernel test robot wrote:
>> FYI, we noticed the following commit (built with gcc-7):
>>
>> commit: b751c52bb587ae66f773b15204ef7a147467f4c7 ("kmemleak: increase DEBUG_KMEMLEAK_EARLY_LOG_SIZE default to 16K")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>> in testcase: boot
>>
>> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> [...]
>> BUG: kernel hang in boot stage
>>
>> To reproduce:
>>
>>          # build kernel
>> 	cd linux
>> 	cp config-5.3.0-11789-gb751c52bb587a .config
>> 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=i386 olddefconfig prepare modules_prepare bzImage
> I've never tried kmemleak on i386.
>
> Anyway, I'm not sure what caused the hang (or whether it's a hang at
> all) but I suspect prior to the above commit, kmemleak probably just
> disabled itself (early log  buffer exceeded).

> So the bug may have been
> there already,
I think so

> only that kmemleak started working and tripped over it
> when the log buffer increased.
>
> Is there a chance that the kernel got much slower with kmemleak enabled
> and the test scripts timed out?

> Does this problem still exist with the latest mainline?
Yes, that's true.

Thanks
Zhijian (0Day CI team)
>
> Thanks.
>

