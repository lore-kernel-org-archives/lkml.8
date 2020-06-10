Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B00C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B57982064C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezhpSs3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgFJKZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 06:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgFJKZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 06:25:14 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB0AC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 03:25:14 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b201so936021pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 03:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IVvxfD6LJ1VJT5bk17pFq2+4XZMLtrWkfmXcgio0a2A=;
        b=ezhpSs3oxrpdjzLsFEbhFaEaPGKsh6XiigBpHojxQcZRj8k6Qj78xiDQ7DzhPy2UBe
         kKCXMUQDYjsa7b6tmsp6znzSKiPSh4FaDNiS9QvgKG72vtvsy7//JfO5jLrQOwf0eEBH
         usHQFzZGxE+7v6+UiqWWMXHexjmWC5O4pYcWXoig/H7tSk6G8CL+J32Mr348FVS1ryAQ
         dzHQSC2Xzqpt+MqjwpZ59kCWcRBSb3LqHFP39v6z2x/7q7GIdyt/+3vHbP4LCoXb9X9o
         mV9CCDAHEWmhpPkfxPSmEI8/HqhdKhd9EVGDHjLJowH7i6RDT/Q6VDXfkDBZ9YnWA1VO
         8B+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IVvxfD6LJ1VJT5bk17pFq2+4XZMLtrWkfmXcgio0a2A=;
        b=IAocMrNicJ0Ek6YpY8QLpNzE6UbtCJRfNg9/ok/QZN32mTcyUfM7D0BFZuFCScfwoV
         XgOrUUd+Lrn0O4d5He56zWpgWdhIbe3L8p5OLaWBV4TGfCgN+mct1zRnm7uVxkzCfZ6+
         OaafXbtqNAfFb0Xu1lHjDQtGo0A0IpchkL3ofx03g7LogTrIeLO9FrMIE2HGF1hIVUiE
         n7EkTgTDPtXKbkevHyspg3fkvsG4/OM3IIwGCwN1oCsfx0d5KUvAsoh3zHBxnRNFEHlP
         R3l8xaNQ6ZL+6hQTNj/YRRw5jusn29poKYWbBB5mh268p8ArjzBKlE3A7fdzV1ho3IXs
         1Mbg==
X-Gm-Message-State: AOAM531fxU3Pp9GiUTA9EhSf4yc0516XyObTShU0kR3foG3Iyzv24b9k
        1eZiJPhksrw6AFNo4Fc9KOjOTwRXsotPuFTlx1c=
X-Google-Smtp-Source: ABdhPJwZEjhfhzofthPl+xRw+pEUqn6Mn3fM/ZFFXnb7XAI6gwCa8yu696kpTwMiTNgusVFOINyHoeczzdZw4Vh3yNU=
X-Received: by 2002:a63:ff52:: with SMTP id s18mr2130004pgk.203.1591784713836;
 Wed, 10 Jun 2020 03:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200610075156.GE12456@shao2-debian> <CANMq1KCf3Q2DDBMJkCM=PB8AHOPKJOhKA+C8TqY5v7AsAfD63A@mail.gmail.com>
In-Reply-To: <CANMq1KCf3Q2DDBMJkCM=PB8AHOPKJOhKA+C8TqY5v7AsAfD63A@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 10 Jun 2020 13:25:01 +0300
Message-ID: <CAHp75VcRmqkkPM0RPMzEcDNG4TKFtNC4O3FGjqCBGdHh-CFhVQ@mail.gmail.com>
Subject: Re: [kmemleak] b751c52bb5: BUG:kernel_hang_in_boot_stage
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 12:35 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> On Wed, Jun 10, 2020 at 3:52 PM kernel test robot <rong.a.chen@intel.com> wrote:
> >
> > Greeting,
> >
> > FYI, we noticed the following commit (built with gcc-7):
> >
> > commit: b751c52bb587ae66f773b15204ef7a147467f4c7 ("kmemleak: increase DEBUG_KMEMLEAK_EARLY_LOG_SIZE default to 16K")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> Huh, It's not impossible there is an underlying issue, but I really
> don't see how that change could cause any of the issues below...

In Linux Next we have the

commit c5665868183fec689dbab9fb8505188b2c4f0757
Author: Catalin Marinas <catalin.marinas@arm.com>
Date:   Mon Sep 23 15:34:05 2019 -0700

   mm: kmemleak: use the memory pool for early allocations


I'm wondering if it should be backported to fix this.

> > in testcase: boot
> >
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> >
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> >
> >
> > +-------------------------------------------------+------------+------------+
> > |                                                 | 9d5f0be0f7 | b751c52bb5 |
> > +-------------------------------------------------+------------+------------+
> > | boot_successes                                  | 0          | 0          |
> > | boot_failures                                   | 3          | 4          |
> > | WARNING:at_kernel/locking/mutex.c:#__mutex_lock | 3          |            |
> > | EIP:__mutex_lock                                | 3          |            |
> > | BUG:kernel_hang_in_boot_stage                   | 0          | 4          |
> > +-------------------------------------------------+------------+------------+
> >
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> >
> >
> > [    0.247058] ------------------------
> > [    0.247878] | Locking API testsuite:
> > [    0.248695] ----------------------------------------------------------------------------
> > [    0.250509]                                  | spin |wlock |rlock |mutex | wsem | rsem |
> > [    0.252429]   --------------------------------------------------------------------------
> > [    0.254369]                      A-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
> > [    0.263731]                  A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
> > [    0.273828]              A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
> > [    0.284876]              A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
> > [    0.296642]          A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
> > [    0.308919]          A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
> > [    0.320993]          A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
> > [    0.333668]                     double unlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
> > [    0.343237]                   initialize held:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
> > [    0.352761]   --------------------------------------------------------------------------
> > [    0.354703]               recursive read-lock:             |  ok  |             |  ok  |
> > [    0.358943]            recursive read-lock #2:             |  ok  |             |  ok  |
> > [    0.363056]             mixed read-write-lock:             |  ok  |             |  ok  |
> > [    0.367191]             mixed write-read-lock:             |  ok  |             |  ok  |
> > [    0.371251]   mixed read-lock/lock-write ABBA:             |FAILED|             |  ok  |
> > [    0.373667]    mixed read-lock/lock-read ABBA:             |  ok  |             |  ok  |
> > [    0.377895]  mixed write-lock/lock-write ABBA:             |  ok  |             |  ok  |
> > [    0.381888]   --------------------------------------------------------------------------
> > [    0.385416]      hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
> > [    0.389990]      soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
> > [    0.395489]      hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
> > [    0.400157]      soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
> > [    0.408936]        sirq-safe-A => hirqs-on/12:  ok  |  ok  |  ok  |
> > [    0.413666]        sirq-safe-A => hirqs-on/21:  ok  |  ok  |  ok  |
> > [    0.418073]          hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
> > [    0.422942]          soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
> > [    0.427616]          hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
> > [    0.433873]          soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
> > [    0.442630]     hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
> > [    0.447955]     soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
> > [    0.453324]     hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
> > [    0.458298]     soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
> > [    0.463422]     hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
> > [    0.468262]     soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
> > [    0.473090]     hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
> > [    0.478066]     soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
> > [    0.482982]     hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
> > [    0.490885]     soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
> > [    0.496095]     hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
> > [    0.501193]     soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
> > [    0.506457]     hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
> > [    0.516060]     soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
> > [    0.521157]     hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
> > [    0.530477]     soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
> > [    0.535387]     hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
> > [    0.540393]     soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
> > [    0.552196]     hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
> > [    0.557088]     soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
> > [    0.562135]     hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
> > [    0.567072]     soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
> > [    0.572107]     hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
> > [    0.577276]     soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
> > [    0.582592]       hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
> > [    0.587839]       soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
> > [    0.593347]       hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
> > [    0.598574]       soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
> > [    0.603629]       hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
> > [    0.608515]       soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
> > [    0.613650]       hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
> > [    0.620111]       soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
> > [    0.625090]       hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
> > [    0.630141]       soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
> > [    0.634948]       hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
> > [    0.639932]       soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
> > [    0.645786]       hard-irq read-recursion/123:  ok  |
> > [    0.648025]       soft-irq read-recursion/123:  ok  |
> > [    0.650400]       hard-irq read-recursion/132:  ok  |
> > [    0.652820]       soft-irq read-recursion/132:  ok  |
> > [    0.655214]       hard-irq read-recursion/213:  ok  |
> > [    0.657531]       soft-irq read-recursion/213:  ok  |
> > [    0.659993]       hard-irq read-recursion/231:  ok  |
> > [    0.662498]       soft-irq read-recursion/231:  ok  |
> > [    0.664895]       hard-irq read-recursion/312:  ok  |
> > [    0.667422]       soft-irq read-recursion/312:  ok  |
> > [    0.669851]       hard-irq read-recursion/321:  ok  |
> > [    0.672222]       soft-irq read-recursion/321:  ok  |
> > [    0.674713]   --------------------------------------------------------------------------
> > [    0.676711]   | Wound/wait tests |
> > [    0.677592]   ---------------------
> > [    0.678496]                   ww api failures:  ok  |  ok  |  ok  |
> > [    0.684457]                ww contexts mixing:  ok  |  ok  |
> > [    0.688135]              finishing ww context:  ok  |  ok  |  ok  |  ok  |
> > [    0.694329]                locking mismatches:  ok  |  ok  |  ok  |
> > [    0.699328]                  EDEADLK handling:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
> > [    0.714881]            spinlock nest unlocked:  ok  |
> > [    0.717152]   -----------------------------------------------------
> > [    0.718723]                                  |block | try  |context|
> > [    0.720196]   -----------------------------------------------------
> > [    0.721677]                           context:  ok  |  ok  |  ok  |
> > [    0.727929]                               try:  ok  |  ok  |  ok  |
> > [    0.732790]                             block:  ok  |  ok  |  ok  |
> > [    0.737894]                          spinlock:  ok  |  ok  |  ok  |
> > [    0.743082] -------------------------------------------------------
> > [    0.744547] Good, all 261 testcases passed! |
> > [    0.745547] ---------------------------------
> > BUG: kernel hang in boot stage
> >
> >
> >
> > To reproduce:
> >
> >         # build kernel
> >         cd linux
> >         cp config-5.3.0-11789-gb751c52bb587a .config
> >         make HOSTCC=gcc-7 CC=gcc-7 ARCH=i386 olddefconfig prepare modules_prepare bzImage
> >
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> >
> >
> >
> > Thanks,
> > Rong Chen
> >



-- 
With Best Regards,
Andy Shevchenko
