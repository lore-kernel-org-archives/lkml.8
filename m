Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FF5C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFA7520575
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cvDA3ZzY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504114AbgDNSjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504089AbgDNSjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 14:39:04 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279B3C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:39:03 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id i3so303318pgk.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bWzUZ+y/P/VFQc8O9jcjTib7GUAQgeNd8tbzdYTpSw0=;
        b=cvDA3ZzYML1jsmZUCuucVGHQFQLCxJ33Bgh9eFfDJXMVLuLcc1yAOb+M9gYlOoA7i0
         tphAwgTQ4OxU4E0ZQ2rIJf+pOARUXj/w6dRlUJNzfpgwoAxrgf5HTwXk1q298j3Klz5V
         QZAzyYquVsfHiHLlUGgXlfghbRryOY8QBKp7KAuEMVP/nDVVuBUatxj8hVn0s75jwpg+
         mFULRdLkvOP3CsJVrnOMz5ALyQYoSLE8+sE5SjMkOuvYSeflMXa8ERrUhr3PZqYwamIN
         BlDxtxJHL3Pambz2O+O8vFSumOrgCybJZPOOh20FiDFlnql5nHmxSJti1lcusAs8IaJ5
         fmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bWzUZ+y/P/VFQc8O9jcjTib7GUAQgeNd8tbzdYTpSw0=;
        b=rZWCiC5fiNX4r4qjTOiuRya0t1baZY+/cLCaiHRe6nE2b759zv0M1PBtkuIvqGqxc2
         eEGWQMBWLwNYQHYKZd+Z1966WLZ3VyBXslLsM69sWYx2y6G5a+VHhQ9eBHdpScORDqH2
         rxWhFZ9L8E+EfWQ8pW3EVSw5mUtzDNa1IHOTKq84FXrmTzWh4c85kvZgxwpt6cPIVSKr
         /R5wFf3BXn64bVEj0wZT9jqjQu0sGwhFV407gxwEheUgI0+gnQ6U/R0NADs4gvh7CZy5
         Ysel+C2V+ctv2Ej6cNmi2hT4l4l+W3NUFQkqbh0cpYGHtGcvsbHotWVRMetyOLoWiEQ8
         X5Kw==
X-Gm-Message-State: AGi0PuYoE+1R/N4ykgQZeCPEZst5NBIRQWRqgqUowKY6RaticDQ0Hkta
        muoPDuXXe8WdYSeDbHnr8mzxFBTNeojAutZG5f+9Qw==
X-Google-Smtp-Source: APiQypLmoEbM65ygr4Cw9Ko6bBLtNq6iLDhlvuXJY226XFVl2klKiLrKFZLVi/XnOR+awyLdv4DT0+y1Ji4MacwDL7c=
X-Received: by 2002:aa7:919a:: with SMTP id x26mr23877309pfa.39.1586889541893;
 Tue, 14 Apr 2020 11:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200409232728.231527-1-caij2003@gmail.com> <CAK8P3a3uj7AHbAo4sNzr6KQx5Fk6v99k4ZixCgKo1tUuGoat9Q@mail.gmail.com>
 <CAMj1kXGXNxXGiC4dmNXHkZ6n=J0Fhim3oSwNx4Bz5m9fEphJvQ@mail.gmail.com>
 <20200410123301.GX25745@shell.armlinux.org.uk> <CAMj1kXFpknCfwb6JMdk_SHopnGqMswgSqaQUeAUEh5yaV10vJg@mail.gmail.com>
 <CAKwvOdk-xwuppJzxd1+5sfsC8jYiP3t8D=aTNaYxnFCRDiEUmQ@mail.gmail.com> <CAMj1kXFHb8th0rv1yjrsr=c1o-g9_ERPUy4itnrVN13fcQcXag@mail.gmail.com>
In-Reply-To: <CAMj1kXFHb8th0rv1yjrsr=c1o-g9_ERPUy4itnrVN13fcQcXag@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 14 Apr 2020 11:38:50 -0700
Message-ID: <CAKwvOdm5aawsa2-=atB8z6W8zo8YVgdDEVbU3i4evDcpo1_AxQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: do not assemble iwmmxt.S with LLVM toolchain
To:     Ard Biesheuvel <ardb@kernel.org>
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
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 1:59 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 13 Apr 2020 at 22:45, Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > On Fri, Apr 10, 2020 at 6:09 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Fri, 10 Apr 2020 at 14:33, Russell King - ARM Linux admin
> > > <linux@armlinux.org.uk> wrote:
> ...
> > > > If your compiler/assembler only implements what is in the latest ARM
> > > > ARM, then it is not going to be suitable for these older CPUs and
> > > > alternate vendor "ARM compatible" CPUs.
> > > >
> > >
> > > Indeed, and I'm a bit disappointed at the willingness to leave stuff
> > > by the wayside, especially since Clang's integrated assembler has no
> > > other benefit to it than being built into the compiler.
> >
> > I don't disagree.  I also wish LLVM had a backend for every
> > architecture that GCC does.  But resources are finite and there are
> > more fires than firemen.  It gets really hard to justify a high
> > priority for certain things over others.  Doubly-so for hardware no
> > longer in production.  Triply-so when the ISA vendor doesn't provide
> > information in available reference manuals.  I'm happy to push for
> > more investment in LLVM to support the Linux kernel from Google
> > internally; maybe you can help do so from ARM?  That was my appeal to
> > ARM back in February; support for newest ISA extensions is great,
> > support for existing instructions is great, too.  (And not having to
> > choose between one or the other is preferrable, given the amount of
> > resources available).
> >
>
> Sure. But my point was really that disabling stuff left and right just
> so we can get to the finish line is fine for internal kernel-on-clang
> development, but I'd expect the contributions upstream to be a bit
> more considerate of other concerns, such as not regressing in terms of
> functionality.

Does this or any of the proposed patches regress anything for GCC?  Do
they regress anything for Clang?  Is it a regression if it never
worked in the first place? ;)

Disabling things isn't crossing the finish line.  It's admitting where
your weaknesses lie, and where you need to improve.  Crossing the
finish line is implementing and filling out those weaknesses.  We're
running a race we're behind by 10 years! We may never catch up!

>
> > My thoughts on the benefits of this approach to using Clang's
> > integrated assembler:
> > 1. continuous integration and randconfigs.  We need CI to help us spot
> > where things are still broken, and help us from regressing the ground
> > we've fought for.  We can't expect kernel developers to test with
> > LLVM.  Currently, we have LLVM builds in numerous kernel continuous
> > integration services (KernelCI, Kbuild test robot "0day bot", Linaro's
> > TCWG, Syzcaller, and our own CI).  For services that are bisecting and
> > notifying authors, they are currently harassing authors for
> > pre-existing conditions that the service uncovered via randconfig.
> > This is very very dangerous territory to be in.  If authors start
> > ignoring build reports due to false positives or false negatives, it
> > becomes a weak signal that tends to be ignored.  Then when real bugs
> > are uncovered, the actual bugs get ignored.  We don't want that.  If a
> > canary dies in a coal mine, but no one notices, was it for naught?
> >
>
> OK, so you are saying you need the Clang *assembler* to perform CI on
> C pieces that we can now build with the Clang compiler, and we don't
> want to regress on that? Is this because the cross-assemblers are
> missing from the CI build hosts?

We need to disable configs that we know are broken when using certain
LLVM tools until we can dedicate more resources to fixing them.  This
prevents curious failures when doing randconfig builds, which some of
the CI systems do.  It then gives us a nice list we can grep for
configs we need to fix, whether that's via improvements to the
toolchain to changes to the source.  And I think Arnd agreed with me
when he said "It clearly makes sense to limit the Kconfig option to
compilers that can actually build it."

>
> > 2. It helps us quantify how broken we are, via `grep` and `wc`.  LLVM
> > is in no way a perfect substitute for GNU utilities, but it's not too
> > far off either.  As an imperfect substitute, there's a lot of work
> > both on the toolchain side and sources of various codebases in terms
> > of toolchain portability.  Being able to quantify what doesn't work
> > let's us be clear in which ways LLVM is not a perfect substitute, but
> > also where and how much resources we need to get closer.  That helps
> > then with planning and prioritization.  The proper thing to do is to
> > bury the dead but at this point we only have resources to collect dog
> > tags and keep moving.  That doesn't rule out revisiting implementing
> > iWMMXT in the future.
> >
>
> To be honest with you, I don't actually think iwmmxt is that
> important. But I have already demonstrated how we can use a couple of
> macros to emit the same instructions without resorting to bare
> opcodes, so there is really no need to disable pieces left and right
> because the Clang assembler does not support them outright - it just
> needs someone to care enough about this, rather than rush through the
> list with a tick the box attitude, and rip out the pieces that look a
> bit too complicated.

I don't think we have a long list of configs to mark broken; it's not
like we're flooding the list with patches marking tons of things
broken.

In my town where I live, they spray paint the sidewalks that need
repair so that people don't trip.  "Why not just replace the
sidewalk?" you might ask.  Eventually they do, but it takes much more
time and effort, and there are a lot more broken sidewalks than people
and money to repair them.  Was it a waste to highlight the areas where
people might trip?

All I'm suggesting is that we mark the way for future travelers that
this doesn't work, as you'll get a potentially very confusing error
message if you try.  Then `git log` probably has a Link: and more
context as to why.  Then you can `grep` for all of the places that are
broken, and figure out which sidewalk is most important to repair
first, and better estimate the cost to repair all of them.

>
> > 3. Testing Clang's assembler allows for us to do kernel builds without
> > binutils.  This work is helping uncover places within the kernel where
> > the build is not hermetic.  We're still a long ways away from hermetic
> > reproducible kernel builds I suspect, but my main worry is when people
> > have multiple versions of a toolchain in their path, that only one is
> > used.  Otherwise, it leads to spooky hard to reproduce bug reports.  I
> > don't think I need to argue about build hermiticity, but it's
> > important for user trust and verification.
> >
>
> So we need the Clang assembler for reproducible builds?

No; it allows us to not even install binutils on the host, and know
that the Clang assembler and only the Clang assembler is being used;
no other host utilities that happen to be in the $PATH.

When I do a build with any LLVM utility, I'd like to ensure that the
equivalent from binutils isn't invoked.  This is something folks can
already start testing today with multiple installs of GNU or LLVM
utilities, though I don't know of anyone leading a conscious effort.
This is something we've been finding the hard way; we've been doing
builds on hosts with no GCC/binutils, and finding places where as an
example `nm` or `objcopy` is hardcoded, rather than
`$(NM)`/`$(OBCOPY)`, which is the first step towards making the build
more hermetic.

The next step is ensuring the tools produce deterministic output,
which is quite painful.

>
> > 4. Improving toolchain portability of assembler in LLVM itself.
> > There's plenty of subtle differences, but missing full on instructions
> > (or are they psuedo's?) is pretty bad.
> >
>
> I don't think this point belongs in the 'why should we care about the
> Clang assembler' list :-)

If LLVM improves, thanks to efforts to support the Linux kernel, then
I'd call that a win that kernel developers can celebrate.

>
> > I value the feedback from you, Russell, and Arnd even when I disagree.
> > These are just my thoughts on *why* things are the way they are, FWIW.
> > If there's thoughts on how we might better prioritize one thing over
> > another, I would appreciate it.
>
> I think the 'all legacy needs to die' attitude is not particularly
> helpful here. In the 32-bit Linux/ARM community, there are many people
> who care about older systems, and spend a lot of time on keeping
> things in a working order on platforms that Google or ARM have stopped
> caring about long ago.

I think if anyone on this thread had the position that "_all_ legacy
needs to die," then no one here would have anything to work on. :P
--
Thanks,
~Nick Desaulniers
