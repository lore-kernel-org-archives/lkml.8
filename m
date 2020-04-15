Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE49CC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9C12206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586946915;
	bh=77bP08nDJwkuMBIczKe44qfyWWYykJVxclcbNqH4VLE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dwGkjurnWfqSyc+fZvA/OWIVH2J2uZAzxNb8PQAG1/QcRKN6/lgkGhC9DE7jFZVcv
	 HNotQZKoLouuGMrdmJrz0OcGfHi9JGqz45OSQiUpC3CnvS2kyCLJrH9+cQsYXjPt1R
	 jmnDVp7KwgKjaXI2JyUvIPlDih/UpuQPcd12RSys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408666AbgDOKfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 06:35:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408675AbgDOKca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 06:32:30 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 392C621734
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 10:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586946749;
        bh=77bP08nDJwkuMBIczKe44qfyWWYykJVxclcbNqH4VLE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IDz65g7Uaxp34zLubiGGNINQl8Jm03rAZA2ZyB+IlE2uEO2sehJaeH63vh5UpIkZG
         pHhO9kpbU0QWTmsz5X//QAbGduHTHEYv0YJJYZfCe1mvdIA6oy3VlSG+1FZETwno0H
         m+UhGCFNWmVD8PjIlaOywMttsl5+nUkwievYMBR4=
Received: by mail-io1-f53.google.com with SMTP id u11so1000634iow.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 03:32:29 -0700 (PDT)
X-Gm-Message-State: AGi0PuayFkYGD/eZPrMjK6LGZEg59R/tDU+JQHm6UbYsvekM1pf1oWxL
        WUGTpK54W7+x3cuJ5Ig4GUrvXb1CmrZxEwZByGU=
X-Google-Smtp-Source: APiQypKs/dssNLkwQF7Y6iZnfEqqaGRDYSqqtHnQ8mo1ghodoyGLM+E/adJ/pRaj/JHSfFfAohcDzcQidwXd2DtCqho=
X-Received: by 2002:a05:6602:1550:: with SMTP id h16mr25731080iow.171.1586946748454;
 Wed, 15 Apr 2020 03:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200409232728.231527-1-caij2003@gmail.com> <CAK8P3a3uj7AHbAo4sNzr6KQx5Fk6v99k4ZixCgKo1tUuGoat9Q@mail.gmail.com>
 <CAMj1kXGXNxXGiC4dmNXHkZ6n=J0Fhim3oSwNx4Bz5m9fEphJvQ@mail.gmail.com>
 <20200410123301.GX25745@shell.armlinux.org.uk> <CAMj1kXFpknCfwb6JMdk_SHopnGqMswgSqaQUeAUEh5yaV10vJg@mail.gmail.com>
 <CAKwvOdk-xwuppJzxd1+5sfsC8jYiP3t8D=aTNaYxnFCRDiEUmQ@mail.gmail.com>
 <CAMj1kXFHb8th0rv1yjrsr=c1o-g9_ERPUy4itnrVN13fcQcXag@mail.gmail.com>
 <CAKwvOdm5aawsa2-=atB8z6W8zo8YVgdDEVbU3i4evDcpo1_AxQ@mail.gmail.com> <202004141258.6D9CB92507@keescook>
In-Reply-To: <202004141258.6D9CB92507@keescook>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 15 Apr 2020 12:32:17 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG6_CO6pzeJCSeWiCDyLfWw+ZMuvkv_DLxe-si00fLd1Q@mail.gmail.com>
Message-ID: <CAMj1kXG6_CO6pzeJCSeWiCDyLfWw+ZMuvkv_DLxe-si00fLd1Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: do not assemble iwmmxt.S with LLVM toolchain
To:     Kees Cook <keescook@chromium.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Kristof Beyls <Kristof.Beyls@arm.com>,
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

On Tue, 14 Apr 2020 at 22:53, Kees Cook <keescook@chromium.org> wrote:
>
> I don't know if this will help, but I feel like folks might be talking
> past each other a little here. I see two primary issues that are
> colliding, and I just want to call them out specifically...
>

Thanks Kees.

I don't think there is a huge difference of opinion here, and I hope I
managed to strike the right tone, which was not meant to be a grumpy
one.

To reiterate my point: I strongly prefer minor asm surgery over
elaborate Kconfig plumbing if it means we can retain the functionality
even when using LLVM tools. In particular, the use of macros to
implement missing ISA support should be considered before any other
solution, as these are already being used widely across architectures
to fill in such gaps.


> On Tue, Apr 14, 2020 at 1:59 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> > On Mon, 13 Apr 2020 at 22:45, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > 1. continuous integration and randconfigs.  We need CI to help us spot
> > > where things are still broken, and help us from regressing the ground
> > > we've fought for.  We can't expect kernel developers to test with
> > > LLVM.  Currently, we have LLVM builds in numerous kernel continuous
>
> First, is this one. To paraphrase, "we don't want to lose hard-won
> ground."
>
> > To be honest with you, I don't actually think iwmmxt is that
> > important. But I have already demonstrated how we can use a couple of
> > macros to emit the same instructions without resorting to bare
> > opcodes, so there is really no need to disable pieces left and right
> > because the Clang assembler does not support them outright - it just
> > needs someone to care enough about this, rather than rush through the
> > list with a tick the box attitude, and rip out the pieces that look a
> > bit too complicated.
>
> The second is this one. To paraphrase, "we can just fix things instead
> of disabling them."
>
> This feels a lot to me like the pain I (and plenty of others) have felt
> when doing treewide changes (adding full compiler support is kind of a
> treewide change). The above two points were really strongly felt when we
> were trying to remove VLAs. In our case, we didn't even have the option
> to disable stuff, so the pain was even worse: VLAs were being added to
> the kernel faster than we could remove them.
>
> What's a good middle ground here? For VLAs, I ended up getting akpm's
> help by having him add -Wvla to his local builds and send nag emails
> to people when they added VLAs. That's not really a thing here, but it
> seems like there should be a way to avoid losing ground (in this case,
> it's the erosion of attention: repeated known-issue warnings means the
> CI gets ignored for the warnings on newly added issues). It does seem
> to me like adding the negative depends is a reasonable first step: it
> marks what hard things need fixing later without losing coverage for
> things that can be more easily fixed now with available resources.
>
> For the specific iwmmxt.S case, perhaps the solution is the suggested
> changes? I imagine it should be possible to do a binary diff to see zero
> changes before/after.
>

This code has been around since 2004. It has never been possible to
assemble it with Clang's assembler. So the only thing this patch gives
you is the ability to switch from a .config where IWMMXT was disabled
by hand to one where it gets disabled automatically by Kconfig.

So what hard-won ground are we losing here? Did IWMMXT recently get
enabled in a defconfig that you care about?

> For others, is a negative depends acceptable? Given how responsive
> Nick, Nathan, and others are, I don't think there is any real risk of a
> "slippery slope" of things just getting swept under the rug forever.
> Everyone here wants to see the kernel be awesome. :)
>

I am not disagreeing with you here, and I have worked with Nick,
Nathan and Stefan on numerous occasions to get Clang related build
issues solved.
