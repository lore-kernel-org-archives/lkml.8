Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5869CC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 20:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1873F20656
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 20:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MxUKlu72"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388561AbgDMUpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 16:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388526AbgDMUpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 16:45:44 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E17C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 13:45:43 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id n24so1099021plp.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 13:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s4y7no5cyj/YT4NaiWheMZjYGgfrIItnmovUhjd8zTY=;
        b=MxUKlu72lwCrKhGXVxduY0qZRgXn58LJpwf45V1U0IwsLpyYFdO4NTdYRYksGgLThG
         LjcwuJ3qtW/aMeUQVaNoCR1ma+LbIsxDt+WvdppsT2FczWyvqmmrLjAgWAM7YzJ25z/W
         oLHWepdKVIGCwQLht+JmMpwswZQNN24G0wY7DoNIzGmqQD97+DXQ3Zde9wh4Ns6aFowA
         XHYs8XJ5wAqSj3+WS3m1QLefUTIklrwl+d0trYQg0F3S4xbD8RauNnNvjlfKL6ZCZOxN
         lej6UKgs+0tL/1LYKU5znHQXtKQQVM/Cp8L2913iNBFo2GozR80ZWPnTxHl7R0lqArkF
         kafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s4y7no5cyj/YT4NaiWheMZjYGgfrIItnmovUhjd8zTY=;
        b=Jua5rDA1IDn+KWBXLrnjg2i5zeVNEtckKJQO8A9EtecPWbQk4RheqfRTWmp0Iqi/X/
         QaCF77VDru9FlCRdUs35nB+Jr+hBZsq6zlQgtmhtowI1idZ7URFnP9F1p+fExGfhu7MK
         3bYnlodgAVpQ8G7VSQXh2a4fKoNbUN/FugHbBxD8wHshtPMa5d9EDgPYMRAZ0eIekJMD
         pf94xU6VM06jeDtyKKDzoaMoouL7e2u6WmlJz5bY0nl3RVJHMZ4HfEy21qY1OxRBJSiI
         csA5t4fVTixDrq+DpucMgeZrU0xHVLyiZ0n5dTO8UP7Qij2SN7iOyWcHC78GDxlqZfeI
         sjoA==
X-Gm-Message-State: AGi0PubCNOw+GqEfYzqqR2moPKpQ66aYRc8ZYKlegh0Wqv/vnrwdsTnh
        KB0MpxRFNtDBa7n946M27DvxQUxeUU6RBPVqdhLC+g==
X-Google-Smtp-Source: APiQypLGFgm2HK6f87vLVW+fyw7ThkH2RCckD3cUckOMjMHJ/OZZxjo6UusB1aGrqQdsL/tWiDwUbb0lOfwb1s0H7Ro=
X-Received: by 2002:a17:902:7e42:: with SMTP id a2mr8760793pln.223.1586810743007;
 Mon, 13 Apr 2020 13:45:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200409232728.231527-1-caij2003@gmail.com> <CAK8P3a3uj7AHbAo4sNzr6KQx5Fk6v99k4ZixCgKo1tUuGoat9Q@mail.gmail.com>
 <CAMj1kXGXNxXGiC4dmNXHkZ6n=J0Fhim3oSwNx4Bz5m9fEphJvQ@mail.gmail.com>
 <20200410123301.GX25745@shell.armlinux.org.uk> <CAMj1kXFpknCfwb6JMdk_SHopnGqMswgSqaQUeAUEh5yaV10vJg@mail.gmail.com>
In-Reply-To: <CAMj1kXFpknCfwb6JMdk_SHopnGqMswgSqaQUeAUEh5yaV10vJg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 13 Apr 2020 13:45:30 -0700
Message-ID: <CAKwvOdk-xwuppJzxd1+5sfsC8jYiP3t8D=aTNaYxnFCRDiEUmQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: do not assemble iwmmxt.S with LLVM toolchain
To:     Ard Biesheuvel <ardb@kernel.org>,
        Kristof Beyls <Kristof.Beyls@arm.com>,
        Stephen Hines <srhines@google.com>,
        Luis Lozano <llozano@google.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Jian Cai <caij2003@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Smith <Peter.Smith@arm.com>,
        Stefan Agner <stefan@agner.ch>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Manoj Gupta <manojgupta@google.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jian Cai <jiancai@google.com>,
        Doug Anderson <armlinux@m.disordat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 6:09 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 10 Apr 2020 at 14:33, Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
> > On Fri, Apr 10, 2020 at 01:15:08PM +0200, Ard Biesheuvel wrote:
> > > On Fri, 10 Apr 2020 at 11:56, Arnd Bergmann <arnd@arndb.de> wrote:
> > > >
> > > > On Fri, Apr 10, 2020 at 1:28 AM Jian Cai <caij2003@gmail.com> wrote:
> > > > >
> > > > > iwmmxt.S contains XScale instructions LLVM ARM backend does not support.
> > > > > Skip this file if LLVM integrated assemmbler or LLD is used to build ARM
> > > > > kernel.
> > > > >
> > > > > Signed-off-by: Jian Cai <caij2003@gmail.com>
> > > >
> > > > It clearly makes sense to limit the Kconfig option to compilers that
> > > > can actually build it.
> > > > A few questions though:
> > > >
> > > > - Given that Armada XP with its PJ4B was still marketed until fairly
> > > > recently[1],
> > > >   wouldn't it make sense to still add support for it? Is it a lot of work?
> > > >
> > >
> > > The part of that file that the assembler chokes on hasn't been touched
> > > by anyone since Nico added it 15+ years ago. It can only be built in
> > > ARM mode, and it disassembles to the sequence below (the ld/st fe/fp
> > > mnemonics are not document in recent versions of the ARM ARM, and
> > > aren't understood by Clang either)
> >
> > For older CPUs, it doesn't matter what the latest ARM ARM says, the
> > appropriate version of the ARM ARM is the one relevant for the CPU
> > architecture.  This is a mistake frequently made, and it's been pointed
> > out by Arm Ltd in the past (before ARMv6 even came on the scene) that
> > keeping older revisions is necessary if you want to be interested in
> > the older architectures.
> >
> > However, there's an additional complication here: DEC's license from
> > Arm Ltd back in the days of StrongARM allowed them to make changes to
> > the architecture - that was passed over to Intel when they bought that
> > part of DEC.  Consequently, these "non-Arm vendor" cores contain
> > extensions that are not part of the ARM ARM.  iWMMXT is one such
> > example, which first appeared in the Intel PXA270 SoC (an ARMv5
> > derived CPU).
> >
> > In fact, several of the features found in later versions of the ARM
> > architecture came from DEC and Intel enhancements.
> >
> > If your compiler/assembler only implements what is in the latest ARM
> > ARM, then it is not going to be suitable for these older CPUs and
> > alternate vendor "ARM compatible" CPUs.
> >
>
> Indeed, and I'm a bit disappointed at the willingness to leave stuff
> by the wayside, especially since Clang's integrated assembler has no
> other benefit to it than being built into the compiler.

I don't disagree.  I also wish LLVM had a backend for every
architecture that GCC does.  But resources are finite and there are
more fires than firemen.  It gets really hard to justify a high
priority for certain things over others.  Doubly-so for hardware no
longer in production.  Triply-so when the ISA vendor doesn't provide
information in available reference manuals.  I'm happy to push for
more investment in LLVM to support the Linux kernel from Google
internally; maybe you can help do so from ARM?  That was my appeal to
ARM back in February; support for newest ISA extensions is great,
support for existing instructions is great, too.  (And not having to
choose between one or the other is preferrable, given the amount of
resources available).

My thoughts on the benefits of this approach to using Clang's
integrated assembler:
1. continuous integration and randconfigs.  We need CI to help us spot
where things are still broken, and help us from regressing the ground
we've fought for.  We can't expect kernel developers to test with
LLVM.  Currently, we have LLVM builds in numerous kernel continuous
integration services (KernelCI, Kbuild test robot "0day bot", Linaro's
TCWG, Syzcaller, and our own CI).  For services that are bisecting and
notifying authors, they are currently harassing authors for
pre-existing conditions that the service uncovered via randconfig.
This is very very dangerous territory to be in.  If authors start
ignoring build reports due to false positives or false negatives, it
becomes a weak signal that tends to be ignored.  Then when real bugs
are uncovered, the actual bugs get ignored.  We don't want that.  If a
canary dies in a coal mine, but no one notices, was it for naught?

2. It helps us quantify how broken we are, via `grep` and `wc`.  LLVM
is in no way a perfect substitute for GNU utilities, but it's not too
far off either.  As an imperfect substitute, there's a lot of work
both on the toolchain side and sources of various codebases in terms
of toolchain portability.  Being able to quantify what doesn't work
let's us be clear in which ways LLVM is not a perfect substitute, but
also where and how much resources we need to get closer.  That helps
then with planning and prioritization.  The proper thing to do is to
bury the dead but at this point we only have resources to collect dog
tags and keep moving.  That doesn't rule out revisiting implementing
iWMMXT in the future.

3. Testing Clang's assembler allows for us to do kernel builds without
binutils.  This work is helping uncover places within the kernel where
the build is not hermetic.  We're still a long ways away from hermetic
reproducible kernel builds I suspect, but my main worry is when people
have multiple versions of a toolchain in their path, that only one is
used.  Otherwise, it leads to spooky hard to reproduce bug reports.  I
don't think I need to argue about build hermiticity, but it's
important for user trust and verification.

4. Improving toolchain portability of assembler in LLVM itself.
There's plenty of subtle differences, but missing full on instructions
(or are they psuedo's?) is pretty bad.

I value the feedback from you, Russell, and Arnd even when I disagree.
These are just my thoughts on *why* things are the way they are, FWIW.
If there's thoughts on how we might better prioritize one thing over
another, I would appreciate it.
-- 
Thanks,
~Nick Desaulniers
