Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDD1C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E510F206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586854788;
	bh=SqkasMSzNH62OqOi5+wpyiV3vZk0yvRWEpx9HrxfKzM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NDeODIGFKjgm47crA/8BOesfA2+mlX3tkvQ3TX8XkI2Yghuc7lmtT0tsGNZUPQrD0
	 WPYOmpSWMBiZY8TUh+kokvcr1wnoCppZgOFegwswrt0vOOeu4W9ubI9IOP4uNmGVSx
	 n4JEYkNAAhiM70rZ01GQzgl+oOrsyvnCqr0aBeTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437279AbgDNI7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 04:59:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437267AbgDNI7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 04:59:38 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4068E214AF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 08:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586854777;
        bh=SqkasMSzNH62OqOi5+wpyiV3vZk0yvRWEpx9HrxfKzM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ovUwlBW+O+NhyFJ9o7obZ1Gx/UuAL3fQjXC+QsgmnIOI5/nSwH8R3LXIrY8heOaly
         8aCuqHOHFJ041BtkaG0PWIn9IBARrus/7Qps6W+kdwQXI2C9sOdQ8/qlZSHtNmgXke
         tONkCm0SWRF7Ym46m6BfNvdKyXPz9oEmdQFICi9I=
Received: by mail-il1-f177.google.com with SMTP id i2so10390193ils.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 01:59:37 -0700 (PDT)
X-Gm-Message-State: AGi0PuY4/Ys/z2MO/JJv+UcgjEXJ2RfDzleegQRhX2mlzrkCErqw1TcI
        YdKMTPQ44a6T02Tdvpov6vQpCPNhzC3MCdYBkXY=
X-Google-Smtp-Source: APiQypIRfriof1Jj1dud2z9ouiN7Oe/s/OcZJNzuZQyx3tYkn3qcDtrnmTeyCNGY5oEhnGqjWgYNdhUKLxylRpjvLFs=
X-Received: by 2002:a92:443:: with SMTP id 64mr16054243ile.258.1586854776281;
 Tue, 14 Apr 2020 01:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200409232728.231527-1-caij2003@gmail.com> <CAK8P3a3uj7AHbAo4sNzr6KQx5Fk6v99k4ZixCgKo1tUuGoat9Q@mail.gmail.com>
 <CAMj1kXGXNxXGiC4dmNXHkZ6n=J0Fhim3oSwNx4Bz5m9fEphJvQ@mail.gmail.com>
 <20200410123301.GX25745@shell.armlinux.org.uk> <CAMj1kXFpknCfwb6JMdk_SHopnGqMswgSqaQUeAUEh5yaV10vJg@mail.gmail.com>
 <CAKwvOdk-xwuppJzxd1+5sfsC8jYiP3t8D=aTNaYxnFCRDiEUmQ@mail.gmail.com>
In-Reply-To: <CAKwvOdk-xwuppJzxd1+5sfsC8jYiP3t8D=aTNaYxnFCRDiEUmQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 14 Apr 2020 10:59:24 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFHb8th0rv1yjrsr=c1o-g9_ERPUy4itnrVN13fcQcXag@mail.gmail.com>
Message-ID: <CAMj1kXFHb8th0rv1yjrsr=c1o-g9_ERPUy4itnrVN13fcQcXag@mail.gmail.com>
Subject: Re: [PATCH] ARM: do not assemble iwmmxt.S with LLVM toolchain
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kristof Beyls <Kristof.Beyls@arm.com>,
        Stephen Hines <srhines@google.com>,
        Luis Lozano <llozano@google.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
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

On Mon, 13 Apr 2020 at 22:45, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Fri, Apr 10, 2020 at 6:09 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Fri, 10 Apr 2020 at 14:33, Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
...
> > > If your compiler/assembler only implements what is in the latest ARM
> > > ARM, then it is not going to be suitable for these older CPUs and
> > > alternate vendor "ARM compatible" CPUs.
> > >
> >
> > Indeed, and I'm a bit disappointed at the willingness to leave stuff
> > by the wayside, especially since Clang's integrated assembler has no
> > other benefit to it than being built into the compiler.
>
> I don't disagree.  I also wish LLVM had a backend for every
> architecture that GCC does.  But resources are finite and there are
> more fires than firemen.  It gets really hard to justify a high
> priority for certain things over others.  Doubly-so for hardware no
> longer in production.  Triply-so when the ISA vendor doesn't provide
> information in available reference manuals.  I'm happy to push for
> more investment in LLVM to support the Linux kernel from Google
> internally; maybe you can help do so from ARM?  That was my appeal to
> ARM back in February; support for newest ISA extensions is great,
> support for existing instructions is great, too.  (And not having to
> choose between one or the other is preferrable, given the amount of
> resources available).
>

Sure. But my point was really that disabling stuff left and right just
so we can get to the finish line is fine for internal kernel-on-clang
development, but I'd expect the contributions upstream to be a bit
more considerate of other concerns, such as not regressing in terms of
functionality.

> My thoughts on the benefits of this approach to using Clang's
> integrated assembler:
> 1. continuous integration and randconfigs.  We need CI to help us spot
> where things are still broken, and help us from regressing the ground
> we've fought for.  We can't expect kernel developers to test with
> LLVM.  Currently, we have LLVM builds in numerous kernel continuous
> integration services (KernelCI, Kbuild test robot "0day bot", Linaro's
> TCWG, Syzcaller, and our own CI).  For services that are bisecting and
> notifying authors, they are currently harassing authors for
> pre-existing conditions that the service uncovered via randconfig.
> This is very very dangerous territory to be in.  If authors start
> ignoring build reports due to false positives or false negatives, it
> becomes a weak signal that tends to be ignored.  Then when real bugs
> are uncovered, the actual bugs get ignored.  We don't want that.  If a
> canary dies in a coal mine, but no one notices, was it for naught?
>

OK, so you are saying you need the Clang *assembler* to perform CI on
C pieces that we can now build with the Clang compiler, and we don't
want to regress on that? Is this because the cross-assemblers are
missing from the CI build hosts?

> 2. It helps us quantify how broken we are, via `grep` and `wc`.  LLVM
> is in no way a perfect substitute for GNU utilities, but it's not too
> far off either.  As an imperfect substitute, there's a lot of work
> both on the toolchain side and sources of various codebases in terms
> of toolchain portability.  Being able to quantify what doesn't work
> let's us be clear in which ways LLVM is not a perfect substitute, but
> also where and how much resources we need to get closer.  That helps
> then with planning and prioritization.  The proper thing to do is to
> bury the dead but at this point we only have resources to collect dog
> tags and keep moving.  That doesn't rule out revisiting implementing
> iWMMXT in the future.
>

To be honest with you, I don't actually think iwmmxt is that
important. But I have already demonstrated how we can use a couple of
macros to emit the same instructions without resorting to bare
opcodes, so there is really no need to disable pieces left and right
because the Clang assembler does not support them outright - it just
needs someone to care enough about this, rather than rush through the
list with a tick the box attitude, and rip out the pieces that look a
bit too complicated.

> 3. Testing Clang's assembler allows for us to do kernel builds without
> binutils.  This work is helping uncover places within the kernel where
> the build is not hermetic.  We're still a long ways away from hermetic
> reproducible kernel builds I suspect, but my main worry is when people
> have multiple versions of a toolchain in their path, that only one is
> used.  Otherwise, it leads to spooky hard to reproduce bug reports.  I
> don't think I need to argue about build hermiticity, but it's
> important for user trust and verification.
>

So we need the Clang assembler for reproducible builds?

> 4. Improving toolchain portability of assembler in LLVM itself.
> There's plenty of subtle differences, but missing full on instructions
> (or are they psuedo's?) is pretty bad.
>

I don't think this point belongs in the 'why should we care about the
Clang assembler' list :-)

> I value the feedback from you, Russell, and Arnd even when I disagree.
> These are just my thoughts on *why* things are the way they are, FWIW.
> If there's thoughts on how we might better prioritize one thing over
> another, I would appreciate it.

I think the 'all legacy needs to die' attitude is not particularly
helpful here. In the 32-bit Linux/ARM community, there are many people
who care about older systems, and spend a lot of time on keeping
things in a working order on platforms that Google or ARM have stopped
caring about long ago.
