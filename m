Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBB8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E0F42075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vJXKeOCN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgESScz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 14:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgESScy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:32:54 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952C2C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 11:32:53 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id b3so580756oib.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 11:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zUMaWPm9SlcfCzjrHwM0IpeNPj7KBePW3ACEor5djhA=;
        b=vJXKeOCNlQAaS8PHrLJ5aTOob8igd3SWjW33KesMF+PSs0rjB0EVDfroCHDKhbLHCY
         y3b9nFjHIEdISJ0QKyx+NcrQ5ZQtqrIfFMZKjT19RUnBrIdZusJqkjFhXUJXf8YTnOxI
         Q3xo2te5wXcvO9xnwxhNr4yHWhJMm/QpU4HxYQn6B2i/SszoxhzQEQsOVqK9r3rKSfI4
         h3EA9CQfq3Oo5Z7UzpQm6htNQbpkqsc4alENn76cVAoEdzAImOK2B5DclpbS34pMtKMK
         gA8DtrNV6zU7ShlIQunk3Zqls+aO0tFxTZVKJN7WuXwqQvYVFLdK78qmyvLWR+whaP2v
         5mQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zUMaWPm9SlcfCzjrHwM0IpeNPj7KBePW3ACEor5djhA=;
        b=MGdyD9dveFDgzfdyf4MdfYQQKO0kJ4Csb4cNukGJRRn4C5JVXnZn2pGmZhDxAKPz3X
         1SA7t/7XH74E3e2PTy+F39GW+ui8XiBTMNv7q4XHuTER4Lj73IAH1OkvEVQIMvoRm0Co
         T9WLJFfGox/mSS38ZzJ3bwg7V4fO/fA6BN7vb4aEQ8ZCt4VZjKYpqCvcfuJNOV/1q4KU
         +6SWQx+p0EnN28raCSW+9qZ2W/dLs5/bnGJro6IyiXeXF3CegXkn5NFkmRr/G9Y6S9NS
         2OVT8Cw9FtwIdGXBf7D2A0DGYzwVcZvWpzT81ayUVCYaBNyF85nPqLOU+neIaBXh9jyD
         3hoA==
X-Gm-Message-State: AOAM531s/FLKbcRh5fp2F5KhiZS60pX+STk+46uyPW8kBjQ1C8Wa4sl9
        USsA7eWEFNu1+m3VvdXOX42mtqIOOSwEqNIkXlIIww==
X-Google-Smtp-Source: ABdhPJzUuQ7Ujr4y5GN4XnfUPTSAOlCEK4t2cP8CacKPv8spDkK6QLsujg5F7f4Jn9u1QyojlxcNK2VkRVhDqDopZBw=
X-Received: by 2002:aca:ebc5:: with SMTP id j188mr591152oih.70.1589913172739;
 Tue, 19 May 2020 11:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200517011732.GE24705@shao2-debian> <20200517034739.GO2869@paulmck-ThinkPad-P72>
 <CANpmjNNj37=mgrZpzX7joAwnYk-GsuiE8oOm13r48FYAK0gSQw@mail.gmail.com>
 <CANpmjNMx0+=Cac=WvHuzKb2zJvgNVvVxjo_W1wYWztywxDKeCQ@mail.gmail.com>
 <CANpmjNPcOHAE5d=gaD327HqxTBegf75qeN_pjoszahdk6_i5=Q@mail.gmail.com>
 <CAKwvOd=Gi2z_NjRfpTigCCcV5kUWU7Bm7h1eHLeQ6DZCmrsR8w@mail.gmail.com>
 <20200518180513.GA114619@google.com> <CANpmjNMTRO0TxxTQxFt8EaRLggcPXKLJL2+G2WFL+vakgd2OUg@mail.gmail.com>
 <CANpmjNO0kDVW4uaLcOF95L3FKc8WjawJqXKQtYbCad+W2r=75g@mail.gmail.com>
In-Reply-To: <CANpmjNO0kDVW4uaLcOF95L3FKc8WjawJqXKQtYbCad+W2r=75g@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 19 May 2020 20:32:39 +0200
Message-ID: <CANpmjNOeXmD5E3O50Z3MjkiuCYaYOPyi+1rq=GZvEKwBvLR0Ug@mail.gmail.com>
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

On Tue, 19 May 2020 at 15:40, Marco Elver <elver@google.com> wrote:
>
> On Tue, 19 May 2020 at 12:16, Marco Elver <elver@google.com> wrote:
> >
> > On Mon, 18 May 2020 at 20:05, Marco Elver <elver@google.com> wrote:
> > >
> > > On Mon, 18 May 2020, 'Nick Desaulniers' via kasan-dev wrote:
> > >
> > > > On Mon, May 18, 2020 at 7:34 AM Marco Elver <elver@google.com> wrote:
> > > > >
> > > > > On Mon, 18 May 2020 at 14:44, Marco Elver <elver@google.com> wrote:
> > > > > >
> > > > > > [+Cc clang-built-linux FYI]
> > > > > >
> > > > > > On Mon, 18 May 2020 at 12:11, Marco Elver <elver@google.com> wrote:
> > > > > > >
> > > > > > > On Sun, 17 May 2020 at 05:47, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Sun, May 17, 2020 at 09:17:32AM +0800, kernel test robot wrote:
> > > > > > > > > Greeting,
> > > > > > > > >
> > > > > > > > > FYI, we noticed the following commit (built with clang-11):
> > > > > > > > >
> > > > > > > > > commit: 2f08469563550d15cb08a60898d3549720600eee ("rcu: Mark rcu_state.ncpus to detect concurrent writes")
> > > > > > > > > https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev.2020.05.14c
> > > > > > > > >
> > > > > > > > > in testcase: boot
> > > > > > > > >
> > > > > > > > > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> > > > > > > > >
> > > > > > > > > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > If you fix the issue, kindly add following tag
> > > > > > > > > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > [    0.054943] BRK [0x05204000, 0x05204fff] PGTABLE
> > > > > > > > > [    0.061181] BRK [0x05205000, 0x05205fff] PGTABLE
> > > > > > > > > [    0.062403] BRK [0x05206000, 0x05206fff] PGTABLE
> > > > > > > > > [    0.065200] RAMDISK: [mem 0x7a247000-0x7fffffff]
> > > > > > > > > [    0.067344] ACPI: Early table checksum verification disabled
> > > > > > > > > BUG: kernel reboot-without-warning in boot stage
> > > > > > > >
> > > > > > > > I am having some difficulty believing that this commit is at fault given
> > > > > > > > that the .config does not list CONFIG_KCSAN=y, but CCing Marco Elver
> > > > > > > > for his thoughts.  Especially given that I have never built with clang-11.
> > > > > > > >
> > > > > > > > But this does invoke ASSERT_EXCLUSIVE_WRITER() in early boot from
> > > > > > > > rcu_init().  Might clang-11 have objections to early use of this macro?
> > > > > > >
> > > > > > > The macro is a noop without KCSAN. I think the bisection went wrong.
> > > > > > >
> > > > > > > I am able to reproduce a reboot-without-warning when building with
> > > > > > > Clang 11 and the provided config. I did a bisect, starting with v5.6
> > > > > > > (good), and found this:
> > > > > > > - Since v5.6, first bad commit is
> > > > > > > 20e2aa812620439d010a3f78ba4e05bc0b3e2861 (Merge tag
> > > > > > > 'perf-urgent-2020-04-12' of
> > > > > > > git://git.kernel.org/pub/scm/linux/kernel//git/tip/tip)
> > > > > > > - The actual commit that introduced the problem is
> > > > > > > 2b3b76b5ec67568da4bb475d3ce8a92ef494b5de (perf/x86/intel/uncore: Add
> > > > > > > Ice Lake server uncore support) -- reverting it fixes the problem.
> > > > >
> > > > > Some more clues:
> > > > >
> > > > > 1. I should have noticed that this uses CONFIG_KASAN=y.
> > > >
> > > > Thanks for the report, testing, and bisection.  I don't see any
> > > > smoking gun in the code.
> > > > https://godbolt.org/z/qbK26r
> > >
> > > My guess is data layout and maybe some interaction with KASAN. I also
> > > played around with leaving icx_mmio_uncores empty, meaning none of the
> > > data it refers to end up in the data section (presumably because
> > > optimized out), which resulted in making the bug disappear as well.
> > >
> > > > >
> > > > > 2. Something about function icx_uncore_mmio_init(). Making it a noop
> > > > > also makes the issue go away.
> > > > >
> > > > > 3. Leaving icx_uncore_mmio_init() a noop but removing the 'static'
> > > > > from icx_mmio_uncores also presents the issue. So this seems to be
> > > > > something about how/where icx_mmio_uncores is allocated.
> > > >
> > > > Can you share the disassembly of icx_uncore_mmio_init() in the given
> > > > configuration?
> > >
> > > ffffffff8102c097 <icx_uncore_mmio_init>:
> > > ffffffff8102c097:       e8 b4 52 bd 01          callq  ffffffff82c01350 <__fentry__>
> > > ffffffff8102c09c:       48 c7 c7 e0 55 c3 83    mov    $0xffffffff83c355e0,%rdi
> > > ffffffff8102c0a3:       e8 69 9a 3b 00          callq  ffffffff813e5b11 <__asan_store8>
> > > ffffffff8102c0a8:       48 c7 05 2d 95 c0 02    movq   $0xffffffff83c388e0,0x2c0952d(%rip)        # ffffffff83c355e0 <uncore_mmio_uncores>
> > > ffffffff8102c0af:       e0 88 c3 83
> > > ffffffff8102c0b3:       c3                      retq
> > >
> > > The problem still happens if we add a __no_sanitize_address (or even
> > > KASAN_SANITIZE := n) here. I think this function is a red herring: you
> > > can make this function be empty, but as long as icx_mmio_uncores and its
> > > dependencies are added to the data section somewhere, does the bug
> > > appear.
> >
> > I also tried to bisect Clang/LLVM, and found that
> > https://reviews.llvm.org/D78162 introduced the breaking change to
> > Clang/LLVM. Reverting that change results in a bootable kernel *with*
> > "perf/x86/intel/uncore: Add Ice Lake server uncore support" still
> > applied.
>
> I found that with Clang/LLVM change D78162, a bunch of memcpys are
> optimized into just a bunch of loads/stores. It may turn out that this
> is again a red herring, because the result is that more code is
> generated, affecting layout. So in the end, the Clang/LLVM bisection
> might just point at the first change that causes data layout to change
> in a way that triggers the bug.

This fixes the problem:
https://lkml.kernel.org/r/20200519182459.87166-1-elver@google.com

I suppose there are several things that happened that caused the above
bisected changes to trigger this. Hard to say how exactly the above
bisected changes caused this to manifest, because during early boot
(while uninitialized) KASAN may just randomly enter kasan_report()
before the branch (annotated with likely(), which is caught by the
branch tracer) prevents it from actually generating a report. However,
if it goes branch tracer -> KASAN -> branch tracers -> KASAN ..., then
we crash. If I had to guess some combination of different code gen,
different stack and/or data usage. So all the above bisected changes
(AFAIK) were red herrings. :-)

Thanks,
-- Marco
