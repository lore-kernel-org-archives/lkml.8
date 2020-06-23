Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A7BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CDF820774
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592924394;
	bh=Rz6H70fxpr0bULW4En5LVbxTJfrpuw59lRzIah3HKSI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Tit0omsk7tMWFzpmJlIJB5gwLzBCbjk+eXrSGtrM+YSF3VZyxlVPED1VCmZuoofwv
	 ZsiMwA5IBUFZ/9MOum2xYspXaa3npZ+QiQuxJqC8SjXGQJTXQrzZ1YPEXx7Ki7dRyv
	 +EMjWLs/AdKM8Wxo6Y8QOvCFsiwtsUuLUY9KjzTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732981AbgFWO7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:59:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732883AbgFWO7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:59:52 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9905520780
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 14:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592924391;
        bh=Rz6H70fxpr0bULW4En5LVbxTJfrpuw59lRzIah3HKSI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=05ORbPdHssFKExRKZ4j+1XIwNPyxWvPEbngCc8r54Sovi+5pCcdN6cky4W9np4EaC
         cm7txPKA2ca7131zOFg9EMcZ2Fea0FKuts17wicnPWHn2vXcS8+sNEOi6m1dxwlR7Q
         u89eEnMUCdbR2mozdxjmIKgpVpnmLzc4HooVWZZk=
Received: by mail-oi1-f171.google.com with SMTP id d67so19047375oig.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 07:59:51 -0700 (PDT)
X-Gm-Message-State: AOAM530D24kXxjCQU7s39dQbwkLhPwDE0PXZh5FEpVEwctFlf0gO6+x4
        SE4vJt0hMhKeYlQJg829FA2pMA25e5URgbyw5yo=
X-Google-Smtp-Source: ABdhPJwHqw5Du12PFCir30KguE0QkP+g73lZpzUVDMywHdt/Lwxn872U89aRo1n6SDzzk0K+7QSZwtCuughgjxTRyfc=
X-Received: by 2002:aca:ba03:: with SMTP id k3mr16438168oif.33.1592924390925;
 Tue, 23 Jun 2020 07:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200622205815.2988115-1-keescook@chromium.org>
 <20200622205815.2988115-3-keescook@chromium.org> <20200623145218.GC4336@willie-the-truck>
In-Reply-To: <20200623145218.GC4336@willie-the-truck>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 23 Jun 2020 16:59:39 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEPe10EY1uE1vberVMXv9sx4ZRHgmssOypYm5ya5G9KoA@mail.gmail.com>
Message-ID: <CAMj1kXEPe10EY1uE1vberVMXv9sx4ZRHgmssOypYm5ya5G9KoA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64/build: Warn on orphan section placement
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jun 2020 at 16:52, Will Deacon <will@kernel.org> wrote:
>
> On Mon, Jun 22, 2020 at 01:58:15PM -0700, Kees Cook wrote:
> > We don't want to depend on the linker's orphan section placement
> > heuristics as these can vary between linkers, and may change between
> > versions. All sections need to be explicitly named in the linker
> > script.
> >
> > Explicitly include debug sections when they're present. Add .eh_frame*
> > to discard as it seems that these are still generated even though
> > -fno-asynchronous-unwind-tables is being specified. Add .plt and
> > .data.rel.ro to discards as they are not actually used. Add .got.plt
> > to the image as it does appear to be mapped near .data. Finally enable
> > orphan section warnings.
>
> Can you elaborate a bit on what .got.plt is being used for, please? I
> wonder if there's an interaction with an erratum workaround in the linker
> or something.
>

.got.plt is not used at all, but it has three magic entries at the
start that the dynamic linker uses for lazy dispatch, so it turns up
as a non-empty section of 0x18 bytes.

We should be able to discard it afaict, but given that it does not
actually take up any space, it doesn't really matter either way.

> > diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> > index a0d94d063fa8..3e628983445a 100644
> > --- a/arch/arm64/Makefile
> > +++ b/arch/arm64/Makefile
> > @@ -29,6 +29,10 @@ LDFLAGS_vmlinux    += --fix-cortex-a53-843419
> >    endif
> >  endif
> >
> > +# We never want expected sections to be placed heuristically by the
> > +# linker. All sections should be explicitly named in the linker script.
> > +LDFLAGS_vmlinux += --orphan-handling=warn
> > +
> >  ifeq ($(CONFIG_ARM64_USE_LSE_ATOMICS), y)
> >    ifneq ($(CONFIG_ARM64_LSE_ATOMICS), y)
> >  $(warning LSE atomics not supported by binutils)
> > diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> > index 5427f502c3a6..c9ecb3b2007d 100644
> > --- a/arch/arm64/kernel/vmlinux.lds.S
> > +++ b/arch/arm64/kernel/vmlinux.lds.S
> > @@ -94,7 +94,8 @@ SECTIONS
> >       /DISCARD/ : {
> >               *(.interp .dynamic)
> >               *(.dynsym .dynstr .hash .gnu.hash)
> > -             *(.eh_frame)
> > +             *(.plt) *(.data.rel.ro)
> > +             *(.eh_frame) *(.init.eh_frame)
>
> Do we need to include .eh_frame_hdr here too?
>

It would be better to build with -fno-unwind-tables, in which case
these sections should not even exist.

> >       }
> >
> >       . = KIMAGE_VADDR + TEXT_OFFSET;
> > @@ -209,6 +210,7 @@ SECTIONS
> >       _data = .;
> >       _sdata = .;
> >       RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_ALIGN)
> > +     .got.plt : ALIGN(8) { *(.got.plt) }
> >
> >       /*
> >        * Data written with the MMU off but read with the MMU on requires
> > @@ -244,6 +246,7 @@ SECTIONS
> >       _end = .;
> >
> >       STABS_DEBUG
> > +     DWARF_DEBUG
>
> I know you didn't add it, but do we _really_ care about stabs debug? Who
> generates that for arm64?
>
> Will
