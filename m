Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018B1C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5830224F9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kirqayn1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbgGNTVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbgGNTVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:21:22 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944F2C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 12:21:22 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id l1so18524983ioh.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 12:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=6MKTlr7J8Rp2MsMio23TCowkP5+63OkXW2oUskwJZ8w=;
        b=kirqayn1/3LrfNhHlFjphh3zOb/8tQ1wCoTI8dQbkWi4nEZUI0fTq5CzVJHNt6Nai5
         TLe9VCZIBLrCMmsyCGLOm3g4A4iJmYgMwYGZP6MyUQDurP5vDrpC8dqELT9awpkcICtK
         znZNJ/5OcjuiBAdwxLDcpRQPS5FAXykwRstzDFUwNpVeytro4nmwpDgDa01ubbV5Afj4
         59IjcONDDVcfWN2xAB89NPFJZNsDvA3xeQUYNijdIpXxcLUjkns2rrxymX8LaiwZxi+w
         /fOE366hbMqSGsCckOS70SBm04GOHQsU1iwfNNx/mIK40/t+/bX3harB6nh1uAR1zRdP
         eACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=6MKTlr7J8Rp2MsMio23TCowkP5+63OkXW2oUskwJZ8w=;
        b=SFwE77MNjtENxlIalnIpynDcxlcTDZSmPwhkxq5JD8ViuPJV8eSpOMx99bHHMVWgdF
         nGs+as5Vnj9FjqJn+T83u+G8R/7GygcvVJhpHal0Ni3mP00NgFERHVru3HC4TFqm5+eK
         XBS1v0zXZctpt2sCu7f/1sKMss5vIi8lVIYNst731bk9B/uZF4/OkMVj6iFUy+1WVCRD
         u/AmtYW8lZm/HOW+zjkx/iMROhyc0G+5po/HJbyzztGjLY/0rIlEqc6xhMKOQ0BOQgF8
         n86qCOjC0bC/iQyAcR3FH9ZJX2DhXpHv5U2tbDsshkxY3qrzq3JNcZmZuZDbkg7mcUmW
         2rKw==
X-Gm-Message-State: AOAM531M0Er1CEKTRSuK90vsvjdscjecNZcOF1YFoSTmLUXmlOwAVOdK
        5H39N9sxKCuElda4P6meWhHnCu1y4+V6/rNQdD8=
X-Google-Smtp-Source: ABdhPJyIJ0zNzeeZQGOJi/xHoKFzwlo7DIgyEzpWKu9GwQNZj7Ajr7/bys8cNSU1H/dvXN01Mlyz/JAJAuYzSyOGNDU=
X-Received: by 2002:a5e:9309:: with SMTP id k9mr6361130iom.135.1594754481750;
 Tue, 14 Jul 2020 12:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200629140928.858507-1-nivedita@alum.mit.edu>
 <20200714023836.2310569-1-nivedita@alum.mit.edu> <CA+icZUXSPfybFtzQB3wKn9spQmEPnQu_iGPWkRisAmRQbJLWXA@mail.gmail.com>
 <20200714141550.GA329060@rani.riverdale.lan> <CA+icZUU88wYmyycthW7AQUZ72HGa9RWPZmxVS5Gm6UW=6ES9kA@mail.gmail.com>
 <CA+icZUWHdsk9+wkTZOdDghM7pRZyk2vHgxpYx62vPooqohzbYw@mail.gmail.com> <CA+icZUWip6xAFdTiLNWT4QHS0R6bQuCZ6W7dWd+UbbZGnBBh4w@mail.gmail.com>
In-Reply-To: <CA+icZUWip6xAFdTiLNWT4QHS0R6bQuCZ6W7dWd+UbbZGnBBh4w@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 14 Jul 2020 21:21:10 +0200
Message-ID: <CA+icZUUq9Wtut702su0HQ5qALkDvR+cdW7bczdj_mv=p-U3w4g@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] x86/boot: Remove runtime relocations from
 compressed kernel
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 8:33 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Tue, Jul 14, 2020 at 8:30 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > > I did a full new build...
> > >
> > > ...and it fails with ld.lld-11 as linker:
> > >
> > > ld.lld-11 -m elf_x86_64 -pie  --no-dynamic-linker -r -o
> > > arch/x86/boot/compressed/.tmp_misc.o arch/x86/boot/compressed/misc.o
> > > -T arch/x86/boot/compressed/.tmp_misc.ver; mv -f
> > > arch/x86/boot/compressed/.tmp_misc.o arch/x86/boot/compressed/misc.o;
> > > rm -f arch/x86/boot/compressed/.tmp_misc.ver; fi
> > > *** ld.lld-11: error: -r and -pie may not be used together ***
> > > make[5]: *** [scripts/Makefile.build:281:
> > > arch/x86/boot/compressed/misc.o] Error 1
> > >
> > > It's annoying to fail on the last minutes of a build.
> > > Sorry for being very honest.
> > >
> >
> > I applied this diff...
> >
> > $ git diff arch/x86/boot/compressed/Makefile
> > diff --git a/arch/x86/boot/compressed/Makefile
> > b/arch/x86/boot/compressed/Makefile
> > index 789d5d14d8b0..9ba52a656838 100644
> > --- a/arch/x86/boot/compressed/Makefile
> > +++ b/arch/x86/boot/compressed/Makefile
> > @@ -51,7 +51,10 @@ UBSAN_SANITIZE :=n
> >  KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
> >  # Compressed kernel should be built as PIE since it may be loaded at any
> >  # address by the bootloader.
> > +# LLD linker does not allow -r and -pie options to be used together.
> > +ifndef CONFIG_LD_IS_LLD
> >  KBUILD_LDFLAGS += -pie $(call ld-option, --no-dynamic-linker)
> > +endif
> >  LDFLAGS_vmlinux := -T
> >
> >  hostprogs      := mkpiggy
> >
> > ...and was able to build, assemble, link arch/x86/boot/compressed/*.
> >
>
> I checked my last succesfull build without your patchset:
>
> $ grep no-dynamic-linker build-log_5.8.0-rc5-1-amd64-llvm11-ias.txt
> [ EMPTY ]
>

I was able to boot on bare metal.

Feel free to add my...

Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

...when you restore "old" behaviour when CONFIG_LD_IS_LLD=y (apply or
fold-in my diff with comment)...

...and use one "runtime" in your subject-line:

$ git log --oneline
v5.8-rc5..for-5.8/x86-boot-compressed-remove-runtime-relocations-nivedita-v4
| egrep 'runtime|run-time'
9547f8f08689 x86/boot: Check that there are no runtime relocations
ede02a307b30 x86/boot: Remove runtime relocations from head_{32,64}.S
525a67ac7ea9 x86/boot: Remove run-time relocations from .head.text code

Thanks.

- Sedat -
