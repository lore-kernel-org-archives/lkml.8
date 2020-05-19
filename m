Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67ACC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 10:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8139206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 10:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qhrBnwjJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgESKQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 06:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgESKQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 06:16:19 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44707C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 03:16:18 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id l6so5945554oic.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 03:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eSUUGwovgEAFUWOh5GaQ33PRSsYhOgKLOqbhYaUm0d4=;
        b=qhrBnwjJVX9dBXOPM1D9+nU0CnUI/by5fhsZCAO6GPKiNghFF1vVAWTBq644FNndX+
         DNi3bcnDrK9CdTWEhLxtpxLp6OdcvhswXcHs4DZ3WhEtkrb5Rz+F4R3WpMXAQ0IxkjG3
         iGv8cFzRF8gAwqCOXikn69HmdbUFeKKc5CUWH+9/Ls2igN0jZOGpTExPVKuehSwdVoEz
         buSDA7lBKdhRwcgIfPF0z1AiSYXCnoIs/lrzRxlyMJTpITiPhy/9uIrAWgx7EnRwzY2b
         gHSVuwuTBl5/wB2qGSpGICSGFZEyuqEDHeSt9Y7hx0BtorAfesn3WVKyPy1GcZPg0kgM
         I1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eSUUGwovgEAFUWOh5GaQ33PRSsYhOgKLOqbhYaUm0d4=;
        b=IFSl3fTKfbTLWCTGckdovkwDeCbdJxJc6+CK6DQpU4gOyN0vYp/B3ak71AZPXG52oA
         0OOBiSBh+2fHMbRw3Z3wVKvv+9cxQ3gTQYCZEZreeGu7l20NN2g7REzkuK/WIN1bayn8
         SscLK7cbWvxt30dlaBOWO0bBzdcE2xFkXpsJ6czdnWYlFcZ+oANiqPbKh1bYkXmAUwm6
         MmNw3ySA4g9uVCOxhOq24qTvt1cbDOvAC9cV1ab2jV4rwv+qmWH802inVjFlepOvI1Cy
         2YivCcxpySDwDALl3yh0QOkKNGG56bDwS2gULBFXqouv9Vvg6+ahRN3PQXcnqnUMFa6I
         VUew==
X-Gm-Message-State: AOAM531XfTOP+37Ml2hCytp+YN22c2Mf8zSARaNFgeaqmPvj4Y2nETaQ
        sN19KtLcNlo5H+ubB/TViFcjhZJ0n2o2NiLGCpUh5VmQAwk=
X-Google-Smtp-Source: ABdhPJwiv7BWrhIVVzgVwf9oMUYpSiviwvKiPqgJMRCwV5kLIsLXWRR6zVDuXZlDj3NG7MCh8ZpZTqo6r7sXXPeCqEg=
X-Received: by 2002:aca:3254:: with SMTP id y81mr2617327oiy.172.1589883377228;
 Tue, 19 May 2020 03:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200517011732.GE24705@shao2-debian> <20200517034739.GO2869@paulmck-ThinkPad-P72>
 <CANpmjNNj37=mgrZpzX7joAwnYk-GsuiE8oOm13r48FYAK0gSQw@mail.gmail.com>
 <CANpmjNMx0+=Cac=WvHuzKb2zJvgNVvVxjo_W1wYWztywxDKeCQ@mail.gmail.com>
 <CANpmjNPcOHAE5d=gaD327HqxTBegf75qeN_pjoszahdk6_i5=Q@mail.gmail.com>
 <CAKwvOd=Gi2z_NjRfpTigCCcV5kUWU7Bm7h1eHLeQ6DZCmrsR8w@mail.gmail.com> <20200518180513.GA114619@google.com>
In-Reply-To: <20200518180513.GA114619@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 19 May 2020 12:16:05 +0200
Message-ID: <CANpmjNMTRO0TxxTQxFt8EaRLggcPXKLJL2+G2WFL+vakgd2OUg@mail.gmail.com>
Subject: Re: [rcu] 2f08469563: BUG:kernel_reboot-without-warning_in_boot_stage
To:     Nick Desaulniers <ndesaulniers@google.com>,
        george.burgess.iv@gmail.com
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, LKP <lkp@lists.01.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 May 2020 at 20:05, Marco Elver <elver@google.com> wrote:
>
> On Mon, 18 May 2020, 'Nick Desaulniers' via kasan-dev wrote:
>
> > On Mon, May 18, 2020 at 7:34 AM Marco Elver <elver@google.com> wrote:
> > >
> > > On Mon, 18 May 2020 at 14:44, Marco Elver <elver@google.com> wrote:
> > > >
> > > > [+Cc clang-built-linux FYI]
> > > >
> > > > On Mon, 18 May 2020 at 12:11, Marco Elver <elver@google.com> wrote:
> > > > >
> > > > > On Sun, 17 May 2020 at 05:47, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > >
> > > > > > On Sun, May 17, 2020 at 09:17:32AM +0800, kernel test robot wrote:
> > > > > > > Greeting,
> > > > > > >
> > > > > > > FYI, we noticed the following commit (built with clang-11):
> > > > > > >
> > > > > > > commit: 2f08469563550d15cb08a60898d3549720600eee ("rcu: Mark rcu_state.ncpus to detect concurrent writes")
> > > > > > > https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev.2020.05.14c
> > > > > > >
> > > > > > > in testcase: boot
> > > > > > >
> > > > > > > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> > > > > > >
> > > > > > > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > If you fix the issue, kindly add following tag
> > > > > > > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > > > > > >
> > > > > > >
> > > > > > > [    0.054943] BRK [0x05204000, 0x05204fff] PGTABLE
> > > > > > > [    0.061181] BRK [0x05205000, 0x05205fff] PGTABLE
> > > > > > > [    0.062403] BRK [0x05206000, 0x05206fff] PGTABLE
> > > > > > > [    0.065200] RAMDISK: [mem 0x7a247000-0x7fffffff]
> > > > > > > [    0.067344] ACPI: Early table checksum verification disabled
> > > > > > > BUG: kernel reboot-without-warning in boot stage
> > > > > >
> > > > > > I am having some difficulty believing that this commit is at fault given
> > > > > > that the .config does not list CONFIG_KCSAN=y, but CCing Marco Elver
> > > > > > for his thoughts.  Especially given that I have never built with clang-11.
> > > > > >
> > > > > > But this does invoke ASSERT_EXCLUSIVE_WRITER() in early boot from
> > > > > > rcu_init().  Might clang-11 have objections to early use of this macro?
> > > > >
> > > > > The macro is a noop without KCSAN. I think the bisection went wrong.
> > > > >
> > > > > I am able to reproduce a reboot-without-warning when building with
> > > > > Clang 11 and the provided config. I did a bisect, starting with v5.6
> > > > > (good), and found this:
> > > > > - Since v5.6, first bad commit is
> > > > > 20e2aa812620439d010a3f78ba4e05bc0b3e2861 (Merge tag
> > > > > 'perf-urgent-2020-04-12' of
> > > > > git://git.kernel.org/pub/scm/linux/kernel//git/tip/tip)
> > > > > - The actual commit that introduced the problem is
> > > > > 2b3b76b5ec67568da4bb475d3ce8a92ef494b5de (perf/x86/intel/uncore: Add
> > > > > Ice Lake server uncore support) -- reverting it fixes the problem.
> > >
> > > Some more clues:
> > >
> > > 1. I should have noticed that this uses CONFIG_KASAN=y.
> >
> > Thanks for the report, testing, and bisection.  I don't see any
> > smoking gun in the code.
> > https://godbolt.org/z/qbK26r
>
> My guess is data layout and maybe some interaction with KASAN. I also
> played around with leaving icx_mmio_uncores empty, meaning none of the
> data it refers to end up in the data section (presumably because
> optimized out), which resulted in making the bug disappear as well.
>
> > >
> > > 2. Something about function icx_uncore_mmio_init(). Making it a noop
> > > also makes the issue go away.
> > >
> > > 3. Leaving icx_uncore_mmio_init() a noop but removing the 'static'
> > > from icx_mmio_uncores also presents the issue. So this seems to be
> > > something about how/where icx_mmio_uncores is allocated.
> >
> > Can you share the disassembly of icx_uncore_mmio_init() in the given
> > configuration?
>
> ffffffff8102c097 <icx_uncore_mmio_init>:
> ffffffff8102c097:       e8 b4 52 bd 01          callq  ffffffff82c01350 <__fentry__>
> ffffffff8102c09c:       48 c7 c7 e0 55 c3 83    mov    $0xffffffff83c355e0,%rdi
> ffffffff8102c0a3:       e8 69 9a 3b 00          callq  ffffffff813e5b11 <__asan_store8>
> ffffffff8102c0a8:       48 c7 05 2d 95 c0 02    movq   $0xffffffff83c388e0,0x2c0952d(%rip)        # ffffffff83c355e0 <uncore_mmio_uncores>
> ffffffff8102c0af:       e0 88 c3 83
> ffffffff8102c0b3:       c3                      retq
>
> The problem still happens if we add a __no_sanitize_address (or even
> KASAN_SANITIZE := n) here. I think this function is a red herring: you
> can make this function be empty, but as long as icx_mmio_uncores and its
> dependencies are added to the data section somewhere, does the bug
> appear.

I also tried to bisect Clang/LLVM, and found that
https://reviews.llvm.org/D78162 introduced the breaking change to
Clang/LLVM. Reverting that change results in a bootable kernel *with*
"perf/x86/intel/uncore: Add Ice Lake server uncore support" still
applied.

Thanks,
-- Marco
