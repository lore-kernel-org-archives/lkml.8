Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99912C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 19:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C8892082F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 19:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MWwQozrA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387529AbgFWTSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 15:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733258AbgFWTSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 15:18:52 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15831C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 12:18:52 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p3so1497pgh.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 12:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JfKvbarsGZfb2E+mqEclhl4xXUNIs4ydQ/HWpkkQqp0=;
        b=MWwQozrAHJRMq+/cvcTdAwe3zei+JjjSHHYCG4eOfhDmYrAA5Pw/t6btgc6CjfuYCT
         XL1sSZodE9OXZT7ZfQ5sUHdg895Uv/lTR4sBrNtVEXI2c5UxKNHOUX2iCQgKyfGr7e8w
         Xdhx/KgBHHOFr/XPQIiPu91B8XLAuR3nlAqaOV5E5K/E/T3g7rAez5Vd4VFHfmXCryT9
         R2E5Uzidsn/HKME7hJ/qOdjmhb7a1nxL59KOn3iwVp/eVXTWvIxPBp0LDXbVGH2hBgYc
         B5F5iaP5KrZTMaDGYnVbR6LIYn/tq+TRNmOv6upmU1nFCD4pt+Xx0sC4BhdGV7IteuH+
         aGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JfKvbarsGZfb2E+mqEclhl4xXUNIs4ydQ/HWpkkQqp0=;
        b=rSeqBFOlH/C0hCf1kK2VWO3hQKBFHEri4maroe4PPwghkPFhcgIsUGpQrnJG4WTzlc
         g+h+gmrSdANnY5/IWHzh2wU0/ixVJhMRRXhytd+jbBU5BLmLJuFT5+w4NegID7o44eIH
         GZl+LbL64fLmBS34CsBLZWGDXVqouFfWNh6hjE5vchl67gHyJtchgptxigEalkJ+pA8w
         PdFm6/IzkrBd09QlgJ0SVevGRPIyi6pk77dghEg8pdGJjxCdfhw+RW2RFdhtlPyHRwKC
         Lp1t7KwEplD/4n2rQeP3W21Z9mAOVOmKcthpe+Yi1YNez/m0SEJwFfYce3Ett+xMHFgn
         druQ==
X-Gm-Message-State: AOAM530prsa/SP+9pD3+3vv61AlmC9eTEO3F2bqRR3pmIrgi8jOnkRPF
        UGz6x3VsfbKY4/KMgSiEtATb1pz/smhkzhKwc54zpg==
X-Google-Smtp-Source: ABdhPJyunI8b/N2yX/yH7SiD7L2xzMxqJOJf6p2VTSPo9swohpMvj9gyai3TdhcJ2yTZ6XpM4xjyVJFyB39XBQd1m4Q=
X-Received: by 2002:a63:5644:: with SMTP id g4mr17857821pgm.381.1592939931153;
 Tue, 23 Jun 2020 12:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200622205815.2988115-1-keescook@chromium.org>
 <20200622205815.2988115-3-keescook@chromium.org> <20200623145218.GC4336@willie-the-truck>
 <CAMj1kXEPe10EY1uE1vberVMXv9sx4ZRHgmssOypYm5ya5G9KoA@mail.gmail.com>
In-Reply-To: <CAMj1kXEPe10EY1uE1vberVMXv9sx4ZRHgmssOypYm5ya5G9KoA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 23 Jun 2020 12:18:40 -0700
Message-ID: <CAKwvOdkeW6Ynvkcg0bd9Q9A-9tT=B6bfwO=mDHt9j9E2=sgj-A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64/build: Warn on orphan section placement
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 7:59 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 23 Jun 2020 at 16:52, Will Deacon <will@kernel.org> wrote:
> >
> > On Mon, Jun 22, 2020 at 01:58:15PM -0700, Kees Cook wrote:
> > > We don't want to depend on the linker's orphan section placement
> > > heuristics as these can vary between linkers, and may change between
> > > versions. All sections need to be explicitly named in the linker
> > > script.
> > >
> > > Explicitly include debug sections when they're present. Add .eh_frame*
> > > to discard as it seems that these are still generated even though
> > > -fno-asynchronous-unwind-tables is being specified. Add .plt and
> > > .data.rel.ro to discards as they are not actually used. Add .got.plt
> > > to the image as it does appear to be mapped near .data. Finally enable
> > > orphan section warnings.
> >
> > Can you elaborate a bit on what .got.plt is being used for, please? I
> > wonder if there's an interaction with an erratum workaround in the linker
> > or something.
> >
>
> .got.plt is not used at all, but it has three magic entries at the
> start that the dynamic linker uses for lazy dispatch, so it turns up
> as a non-empty section of 0x18 bytes.

Interesting; is there a way to dump those entries? `--dynamic-reloc`
flag to objdump? (I suspect the answer might be hexdump...)

> We should be able to discard it afaict, but given that it does not
> actually take up any space, it doesn't really matter either way.

True, but I would prefer to explicitly discard it if we know we're not
using it, that way something explicitly breaks if someone tries to
make use of it in the future.  Then we can consider not discarding it,
only if necessary.  Modules on arm64 use .got.plt, IIRC? But they have
their own linker script so irrelevant I guess.

> > > --- a/arch/arm64/kernel/vmlinux.lds.S
> > > +++ b/arch/arm64/kernel/vmlinux.lds.S
> > > @@ -94,7 +94,8 @@ SECTIONS
> > >       /DISCARD/ : {
> > >               *(.interp .dynamic)
> > >               *(.dynsym .dynstr .hash .gnu.hash)
> > > -             *(.eh_frame)
> > > +             *(.plt) *(.data.rel.ro)
> > > +             *(.eh_frame) *(.init.eh_frame)
> >
> > Do we need to include .eh_frame_hdr here too?
> >
>
> It would be better to build with -fno-unwind-tables, in which case
> these sections should not even exist.

Interesting, so we have -fno-asynchronous-unwind-tables and
-fno-unwind-tables.  Is your suggestion for -fno-unwind-tables a
global KBUILD_CFLAG (vs limited to a particular arch)?  Interestingly,
there a few users of -fasynchronous-unwind-tables in the kernel.
vdso's make sense, I think, less sure about the rest.

-- 
Thanks,
~Nick Desaulniers
