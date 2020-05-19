Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B42C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C670420835
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nrtXpzxk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbgESNlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 09:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729055AbgESNlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 09:41:14 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3336CC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 06:41:13 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id s198so12335928oie.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 06:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OJ0/X+KDsYJg8CyaNbUZIzyGPtenDDvVDD3jODmVGao=;
        b=nrtXpzxkHDE3tsIhjLRKKkG5mSKHuJTK7d5N/OIpvC5/P828VRegB9+9p/HbRq8VNg
         nFVbBrG0M+aQuE9UKTDblgKxh7al8ExlCx7VaOgm7ZxiaWSLamj3Uy2u+v0sZ51YBgEZ
         LL88seHJH23uAX2ojB2Wt4Ld2019QBZ8VHX2UcmS+mhCPF9OT+KQlM3giRHTxLdl6D9g
         3jjtDCbpl36wRw/dAeDG1XPuiuxWfHQZc5RxCkqeFIEJ/yoZ50XodVu2411ICcG/8gO8
         hW9cfcN3awD1ff0LjmNWnhKGgLGnYdzNAWfhPzXjmL9tUditOufPMokQ0u/1TL83xzDX
         KhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OJ0/X+KDsYJg8CyaNbUZIzyGPtenDDvVDD3jODmVGao=;
        b=sl0EDV14uC+2emzkgKrW2f2nZlsCm7sMbC0zXHXh3EQ/kukyYDUUNx9s7OruSi5T9D
         3AdddBoVnLaNwMftgi6B5vUYeGpt+3qiEMkwl2reiNFG+o7B+9y1oJ0au2thRVAAuHv7
         sfCuIpxHatYGJXS0lMuA/TC2gKQdmFaKlA0qaol8zUEKXTyeYxFh/YT5AdH/C5HttLFP
         w8rWD0c2uT04x3mmM3tIvd2r3zT/FgFiJCA7W8xZWcLRHERXNeIKceqESK14OQSNBFcd
         X+4c9PUQKgmIVJbouaIo0vxgpf5KOKmdhDBy/c33oA//IQak2PJLcPCqL9ukMtEMZHs8
         6iIQ==
X-Gm-Message-State: AOAM532a/jY2J7jQdps7Wkae+hgwqgtDU4C0a//I+ld65VSPin4NuZn4
        j7ISm5/y/AmV+Oe3yAtr8tjcTKkQ2nII/4GMOHS+vw==
X-Google-Smtp-Source: ABdhPJyMuziBjjW4lhx6ke4NJO62cbbIQwIRonXAwKOQsmkHq8MltdxzXTeE0Je2oMei47ExoX0ciROlJWHRIbDUAWE=
X-Received: by 2002:aca:ebc5:: with SMTP id j188mr3278271oih.70.1589895672315;
 Tue, 19 May 2020 06:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200517011732.GE24705@shao2-debian> <20200517034739.GO2869@paulmck-ThinkPad-P72>
 <CANpmjNNj37=mgrZpzX7joAwnYk-GsuiE8oOm13r48FYAK0gSQw@mail.gmail.com>
 <CANpmjNMx0+=Cac=WvHuzKb2zJvgNVvVxjo_W1wYWztywxDKeCQ@mail.gmail.com>
 <CANpmjNPcOHAE5d=gaD327HqxTBegf75qeN_pjoszahdk6_i5=Q@mail.gmail.com>
 <CAKwvOd=Gi2z_NjRfpTigCCcV5kUWU7Bm7h1eHLeQ6DZCmrsR8w@mail.gmail.com>
 <20200518180513.GA114619@google.com> <CANpmjNMTRO0TxxTQxFt8EaRLggcPXKLJL2+G2WFL+vakgd2OUg@mail.gmail.com>
In-Reply-To: <CANpmjNMTRO0TxxTQxFt8EaRLggcPXKLJL2+G2WFL+vakgd2OUg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 19 May 2020 15:40:59 +0200
Message-ID: <CANpmjNO0kDVW4uaLcOF95L3FKc8WjawJqXKQtYbCad+W2r=75g@mail.gmail.com>
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

On Tue, 19 May 2020 at 12:16, Marco Elver <elver@google.com> wrote:
>
> On Mon, 18 May 2020 at 20:05, Marco Elver <elver@google.com> wrote:
> >
> > On Mon, 18 May 2020, 'Nick Desaulniers' via kasan-dev wrote:
> >
> > > On Mon, May 18, 2020 at 7:34 AM Marco Elver <elver@google.com> wrote:
> > > >
> > > > On Mon, 18 May 2020 at 14:44, Marco Elver <elver@google.com> wrote:
> > > > >
> > > > > [+Cc clang-built-linux FYI]
> > > > >
> > > > > On Mon, 18 May 2020 at 12:11, Marco Elver <elver@google.com> wrote:
> > > > > >
> > > > > > On Sun, 17 May 2020 at 05:47, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > >
> > > > > > > On Sun, May 17, 2020 at 09:17:32AM +0800, kernel test robot wrote:
> > > > > > > > Greeting,
> > > > > > > >
> > > > > > > > FYI, we noticed the following commit (built with clang-11):
> > > > > > > >
> > > > > > > > commit: 2f08469563550d15cb08a60898d3549720600eee ("rcu: Mark rcu_state.ncpus to detect concurrent writes")
> > > > > > > > https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev.2020.05.14c
> > > > > > > >
> > > > > > > > in testcase: boot
> > > > > > > >
> > > > > > > > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> > > > > > > >
> > > > > > > > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > If you fix the issue, kindly add following tag
> > > > > > > > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > > > > > > >
> > > > > > > >
> > > > > > > > [    0.054943] BRK [0x05204000, 0x05204fff] PGTABLE
> > > > > > > > [    0.061181] BRK [0x05205000, 0x05205fff] PGTABLE
> > > > > > > > [    0.062403] BRK [0x05206000, 0x05206fff] PGTABLE
> > > > > > > > [    0.065200] RAMDISK: [mem 0x7a247000-0x7fffffff]
> > > > > > > > [    0.067344] ACPI: Early table checksum verification disabled
> > > > > > > > BUG: kernel reboot-without-warning in boot stage
> > > > > > >
> > > > > > > I am having some difficulty believing that this commit is at fault given
> > > > > > > that the .config does not list CONFIG_KCSAN=y, but CCing Marco Elver
> > > > > > > for his thoughts.  Especially given that I have never built with clang-11.
> > > > > > >
> > > > > > > But this does invoke ASSERT_EXCLUSIVE_WRITER() in early boot from
> > > > > > > rcu_init().  Might clang-11 have objections to early use of this macro?
> > > > > >
> > > > > > The macro is a noop without KCSAN. I think the bisection went wrong.
> > > > > >
> > > > > > I am able to reproduce a reboot-without-warning when building with
> > > > > > Clang 11 and the provided config. I did a bisect, starting with v5.6
> > > > > > (good), and found this:
> > > > > > - Since v5.6, first bad commit is
> > > > > > 20e2aa812620439d010a3f78ba4e05bc0b3e2861 (Merge tag
> > > > > > 'perf-urgent-2020-04-12' of
> > > > > > git://git.kernel.org/pub/scm/linux/kernel//git/tip/tip)
> > > > > > - The actual commit that introduced the problem is
> > > > > > 2b3b76b5ec67568da4bb475d3ce8a92ef494b5de (perf/x86/intel/uncore: Add
> > > > > > Ice Lake server uncore support) -- reverting it fixes the problem.
> > > >
> > > > Some more clues:
> > > >
> > > > 1. I should have noticed that this uses CONFIG_KASAN=y.
> > >
> > > Thanks for the report, testing, and bisection.  I don't see any
> > > smoking gun in the code.
> > > https://godbolt.org/z/qbK26r
> >
> > My guess is data layout and maybe some interaction with KASAN. I also
> > played around with leaving icx_mmio_uncores empty, meaning none of the
> > data it refers to end up in the data section (presumably because
> > optimized out), which resulted in making the bug disappear as well.
> >
> > > >
> > > > 2. Something about function icx_uncore_mmio_init(). Making it a noop
> > > > also makes the issue go away.
> > > >
> > > > 3. Leaving icx_uncore_mmio_init() a noop but removing the 'static'
> > > > from icx_mmio_uncores also presents the issue. So this seems to be
> > > > something about how/where icx_mmio_uncores is allocated.
> > >
> > > Can you share the disassembly of icx_uncore_mmio_init() in the given
> > > configuration?
> >
> > ffffffff8102c097 <icx_uncore_mmio_init>:
> > ffffffff8102c097:       e8 b4 52 bd 01          callq  ffffffff82c01350 <__fentry__>
> > ffffffff8102c09c:       48 c7 c7 e0 55 c3 83    mov    $0xffffffff83c355e0,%rdi
> > ffffffff8102c0a3:       e8 69 9a 3b 00          callq  ffffffff813e5b11 <__asan_store8>
> > ffffffff8102c0a8:       48 c7 05 2d 95 c0 02    movq   $0xffffffff83c388e0,0x2c0952d(%rip)        # ffffffff83c355e0 <uncore_mmio_uncores>
> > ffffffff8102c0af:       e0 88 c3 83
> > ffffffff8102c0b3:       c3                      retq
> >
> > The problem still happens if we add a __no_sanitize_address (or even
> > KASAN_SANITIZE := n) here. I think this function is a red herring: you
> > can make this function be empty, but as long as icx_mmio_uncores and its
> > dependencies are added to the data section somewhere, does the bug
> > appear.
>
> I also tried to bisect Clang/LLVM, and found that
> https://reviews.llvm.org/D78162 introduced the breaking change to
> Clang/LLVM. Reverting that change results in a bootable kernel *with*
> "perf/x86/intel/uncore: Add Ice Lake server uncore support" still
> applied.

I found that with Clang/LLVM change D78162, a bunch of memcpys are
optimized into just a bunch of loads/stores. It may turn out that this
is again a red herring, because the result is that more code is
generated, affecting layout. So in the end, the Clang/LLVM bisection
might just point at the first change that causes data layout to change
in a way that triggers the bug.

Thanks,
-- Marco
