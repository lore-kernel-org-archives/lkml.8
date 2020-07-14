Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED033C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8494207BB
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qa5xbbgS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgGNUIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgGNUIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 16:08:16 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE63BC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:08:16 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id v8so18687643iox.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=7R3dCXqsSoyh387FNpg7of+Vy2Uow0OshGTXM3A59Lo=;
        b=qa5xbbgSqDFSqHmM56KWb16bYK0iDbPVkZs70iYrW4xgJyjSKR/5uqwiLmSlmoCLD9
         /4wNRu7Jy4WdnXZk+YtEC9lEYRjwP60InPz+yhlBVv/xKq/+AFvNv/g7xYLFGs++7V4Q
         EOApNkQiaQV20m1vFh8bJBgBCEP+mZd8wb/VEOnQ4fGygVqEDV8zQxIKGun8GwWZ5xay
         dN++q5KoeejqFDJD/jhkYjkuYrJqBzy3m7PcimIFSz9P2nzhZrLfJzqh7+y+vLqsbvd8
         wImg9/1/81zcreyoQLJzYKEM7unzDAjUfhdMT47DS8NQRt4DLo5FzJ+qY/95TSucfoFT
         0TyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=7R3dCXqsSoyh387FNpg7of+Vy2Uow0OshGTXM3A59Lo=;
        b=k1iahIeGVjcZSgv2Jehi68jwfgybmUdD0BTqPgiq07bIQKiyvHIzKK3nAlY+G+OCtl
         UaCif/m+xrjG1VrTw/i3McuZX0q/+mU7GV2pZCk7dF+lGb7aisZ0b92p5lvBnnAVqKZc
         8NAgW1g/SkuNXxOpTZX2yr5Ltfa6SAYoSnI5idloXNBCFjCmlbHVC6BUau91g4pfUOVA
         OSXVerBzWttWva6KWLgMGKwjEVFfKTiKW+i3gJKrGcD2rj4gqtbREwWWtEaJSICHXHgh
         E4VoabQ7XAwkQ1bRBBTRCdZvPhevKrfzYo+9ZZGt6VeBPPcl3jTpRYOOk5fc/LQHlN/G
         e+Sw==
X-Gm-Message-State: AOAM5310HAjfuZ/Mlau5L+7wf2icDKeTx2vGeMKImrp5rkbpQGkX6jHq
        rddiV4W90tu/rbCWh2XwrSaEgZNR+g0H44Vd+2E=
X-Google-Smtp-Source: ABdhPJx/gIy10Ng7jj3gTMeo9keifXcqF57WgPcsgQR230AKnJadvsLxkWcobRw8wQBX3Wrt45FDeFS0loW5eB++FKM=
X-Received: by 2002:a05:6638:2591:: with SMTP id s17mr7925053jat.23.1594757296233;
 Tue, 14 Jul 2020 13:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200629140928.858507-1-nivedita@alum.mit.edu>
 <20200714023836.2310569-1-nivedita@alum.mit.edu> <CA+icZUXSPfybFtzQB3wKn9spQmEPnQu_iGPWkRisAmRQbJLWXA@mail.gmail.com>
 <20200714141550.GA329060@rani.riverdale.lan> <CA+icZUU88wYmyycthW7AQUZ72HGa9RWPZmxVS5Gm6UW=6ES9kA@mail.gmail.com>
 <CA+icZUWHdsk9+wkTZOdDghM7pRZyk2vHgxpYx62vPooqohzbYw@mail.gmail.com>
 <20200714192956.GA689174@rani.riverdale.lan> <CA+icZUXoZzhUMRsVVexazd=oFK4vKa1KJN5=_KXz+fcYxcA4Rw@mail.gmail.com>
In-Reply-To: <CA+icZUXoZzhUMRsVVexazd=oFK4vKa1KJN5=_KXz+fcYxcA4Rw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 14 Jul 2020 22:08:04 +0200
Message-ID: <CA+icZUXBggJtwtWmyXEwgu1WztrcTiLrZCW1_QqSw2SiThOkfQ@mail.gmail.com>
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

On Tue, Jul 14, 2020 at 9:53 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Tue, Jul 14, 2020 at 9:29 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Tue, Jul 14, 2020 at 08:30:14PM +0200, Sedat Dilek wrote:
> > > > I did a full new build...
> > > >
> > > > ...and it fails with ld.lld-11 as linker:
> > > >
> > > > ld.lld-11 -m elf_x86_64 -pie  --no-dynamic-linker -r -o
> > > > arch/x86/boot/compressed/.tmp_misc.o arch/x86/boot/compressed/misc.o
> > > > -T arch/x86/boot/compressed/.tmp_misc.ver; mv -f
> > > > arch/x86/boot/compressed/.tmp_misc.o arch/x86/boot/compressed/misc.o;
> > > > rm -f arch/x86/boot/compressed/.tmp_misc.ver; fi
> > > > *** ld.lld-11: error: -r and -pie may not be used together ***
> > > > make[5]: *** [scripts/Makefile.build:281:
> > > > arch/x86/boot/compressed/misc.o] Error 1
> > > >
> > > > It's annoying to fail on the last minutes of a build.
> > > > Sorry for being very honest.
> > > >
> > >
> > > I applied this diff...
> > >
> > > $ git diff arch/x86/boot/compressed/Makefile
> > > diff --git a/arch/x86/boot/compressed/Makefile
> > > b/arch/x86/boot/compressed/Makefile
> > > index 789d5d14d8b0..9ba52a656838 100644
> > > --- a/arch/x86/boot/compressed/Makefile
> > > +++ b/arch/x86/boot/compressed/Makefile
> > > @@ -51,7 +51,10 @@ UBSAN_SANITIZE :=n
> > >  KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
> > >  # Compressed kernel should be built as PIE since it may be loaded at any
> > >  # address by the bootloader.
> > > +# LLD linker does not allow -r and -pie options to be used together.
> > > +ifndef CONFIG_LD_IS_LLD
> > >  KBUILD_LDFLAGS += -pie $(call ld-option, --no-dynamic-linker)
> > > +endif
> > >  LDFLAGS_vmlinux := -T
> > >
> > >  hostprogs      := mkpiggy
> > >
> > > ...and was able to build, assemble, link arch/x86/boot/compressed/*.
> > >
> > > - Sedat -
> >
> > Thanks for the test.
> >
> > Can you share your .config? The error messages look like they're coming
> > from running modversions on misc.o, which is unexpected as it shouldn't
> > have any exported symbols, and it doesn't in my builds.
> >
> > In any case, I think the right fix here would be to add -pie and
> > --no-dynamic-linker to LDFLAGS_vmlinux instead of KBUILD_LDFLAGS.
>
> Hmm, you might be right with moving to LDFLAGS_vmlinux.
>

We will need the "ifndef CONFIG_LD_IS_LLD" as -r and -pie cannot be
used together.
Is that the or not the fact when moving to LDFLAGS_vmlinux?

I cannot test as I modified my local Git and re-invoking my
build-script is doing a whole new build-dance.

- Sedat -
