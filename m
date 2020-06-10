Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0421BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3F122074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgFJK4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 06:56:48 -0400
Received: from foss.arm.com ([217.140.110.172]:56960 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728330AbgFJK4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 06:56:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17A5C1FB;
        Wed, 10 Jun 2020 03:56:47 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B64203F66F;
        Wed, 10 Jun 2020 03:56:44 -0700 (PDT)
Date:   Wed, 10 Jun 2020 11:56:42 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     kernel test robot <rong.a.chen@intel.com>
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
Subject: Re: [kmemleak] b751c52bb5: BUG:kernel_hang_in_boot_stage
Message-ID: <20200610105640.GB26099@gaia>
References: <20200610075156.GE12456@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610075156.GE12456@shao2-debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 03:51:56PM +0800, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: b751c52bb587ae66f773b15204ef7a147467f4c7 ("kmemleak: increase DEBUG_KMEMLEAK_EARLY_LOG_SIZE default to 16K")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: boot
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
[...]
> BUG: kernel hang in boot stage
> 
> To reproduce:
> 
>         # build kernel
> 	cd linux
> 	cp config-5.3.0-11789-gb751c52bb587a .config
> 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=i386 olddefconfig prepare modules_prepare bzImage

I've never tried kmemleak on i386.

Anyway, I'm not sure what caused the hang (or whether it's a hang at
all) but I suspect prior to the above commit, kmemleak probably just
disabled itself (early log  buffer exceeded). So the bug may have been
there already, only that kmemleak started working and tripped over it
when the log buffer increased.

Is there a chance that the kernel got much slower with kmemleak enabled
and the test scripts timed out?

Does this problem still exist with the latest mainline?

Thanks.

-- 
Catalin
