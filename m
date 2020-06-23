Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AE5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31CB120663
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j78DWRbT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393214AbgFWVGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390515AbgFWVGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 17:06:40 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809F2C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 14:06:40 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id q17so3481767pfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 14:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZBL2aRcchnq3anZZCmM/n3YdrJxQ1yPcC64pjaJoEnQ=;
        b=j78DWRbTC/yWle9y06TBfnGl82zH2z/FQhgsLF1sXV2iIZzR7abFb6067YGEgre2UJ
         Fba921ZmQN/ZNbV1/1hATIvk6Ge9XhEKu43z3J44AJsIsMH9tfsCDMYWF7qlXlNADA8a
         52MSYeNt6i+ongIcgGx4MqoEnibhEDCwUkg3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZBL2aRcchnq3anZZCmM/n3YdrJxQ1yPcC64pjaJoEnQ=;
        b=hf1h1RCLyPwnNlY5Dir0D++ysPjSAevArXjMN+jJfAaynDrO31Hj1KATeY6OxUmVkb
         HeEnTwTmhkrl3xl8XG6fkDodSWNsjY86iGwv8hZDmRaHn6CHeuzNLDbPMqFO1rH/GQOe
         oamKQDePqTVB2jLqf5kslSyiuAowILhq2Mvkt1Q7coQADtm1pZIb6cmgeYasYWxcFBY/
         R9UFr977/kZj8yqDKaV/BgSVFgrKld3COHvOqNQHpW2g/+0FwUlvM1+SVkxh/q7v7iGP
         ZsuAWtnokbfqxBMWoga8hDRxfgzqO3A13SJ8CuoV/zjTlRhN8p1yxahq5CX01WcNWbKU
         GNIw==
X-Gm-Message-State: AOAM533Iu+/JqkQFiCxGJbatsOecVLc+ni+070/njj44azq0HEGtSIYE
        8uakrVZTUW/g+X8d6F8Qjvw9Dg==
X-Google-Smtp-Source: ABdhPJx3Vnft3VkW+IN3ZfC4PaZbxkxZHWmBGNutKlw1+vohd+J2dRi8SVvFwd+LojipRVgS91GF3g==
X-Received: by 2002:a63:9347:: with SMTP id w7mr18414729pgm.409.1592946399794;
        Tue, 23 Jun 2020 14:06:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g17sm3167286pju.11.2020.06.23.14.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 14:06:39 -0700 (PDT)
Date:   Tue, 23 Jun 2020 14:06:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
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
Subject: Re: [PATCH v2 2/2] arm64/build: Warn on orphan section placement
Message-ID: <202006231208.F3DA600E18@keescook>
References: <20200622205815.2988115-1-keescook@chromium.org>
 <20200622205815.2988115-3-keescook@chromium.org>
 <20200623145218.GC4336@willie-the-truck>
 <CAMj1kXEPe10EY1uE1vberVMXv9sx4ZRHgmssOypYm5ya5G9KoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEPe10EY1uE1vberVMXv9sx4ZRHgmssOypYm5ya5G9KoA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 04:59:39PM +0200, Ard Biesheuvel wrote:
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

Is there a way to suppress the generation? I haven't found a way, so I'd
left it as-is.

> We should be able to discard it afaict, but given that it does not
> actually take up any space, it doesn't really matter either way.

I will add it to the discards then.

> > > diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> > > index a0d94d063fa8..3e628983445a 100644
> > > --- a/arch/arm64/Makefile
> > > +++ b/arch/arm64/Makefile
> > > @@ -29,6 +29,10 @@ LDFLAGS_vmlinux    += --fix-cortex-a53-843419
> > >    endif
> > >  endif
> > >
> > > +# We never want expected sections to be placed heuristically by the
> > > +# linker. All sections should be explicitly named in the linker script.
> > > +LDFLAGS_vmlinux += --orphan-handling=warn
> > > +
> > >  ifeq ($(CONFIG_ARM64_USE_LSE_ATOMICS), y)
> > >    ifneq ($(CONFIG_ARM64_LSE_ATOMICS), y)
> > >  $(warning LSE atomics not supported by binutils)
> > > diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> > > index 5427f502c3a6..c9ecb3b2007d 100644
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
> 
> It would be better to build with -fno-unwind-tables, in which case
> these sections should not even exist.

Nothing seems to help with the .eh_frame issue
(even with -fno-asynchronous-unwind-tables and -fno-unwind-tables):

$ aarch64-linux-gnu-gcc -Wp,-MMD,arch/arm64/kernel/.smccc-call.o.d \
  -nostdinc -isystem /usr/lib/gcc-cross/aarch64-linux-gnu/9/include \
  -I./arch/arm64/include -I./arch/arm64/include/generated  -I./include \
  -I./arch/arm64/include/uapi -I./arch/arm64/include/generated/uapi \
  -I./include/uapi -I./include/generated/uapi -include \
  ./include/linux/kconfig.h -D__KERNEL__ -mlittle-endian \
  -DCC_USING_PATCHABLE_FUNCTION_ENTRY -DKASAN_SHADOW_SCALE_SHIFT=3 \
  -D__ASSEMBLY__ -fno-PIE -mabi=lp64 -fno-asynchronous-unwind-tables \
  -fno-unwind-tables -DKASAN_SHADOW_SCALE_SHIFT=3 -Wa,-gdwarf-2 -c -o \
  arch/arm64/kernel/smccc-call.o arch/arm64/kernel/smccc-call.S

$ readelf -S arch/arm64/kernel/smccc-call.o | grep eh_frame
  [17] .eh_frame         PROGBITS         0000000000000000  000001f0
  [18] .rela.eh_frame    RELA             0000000000000000  00000618

> > >       }
> > >
> > >       . = KIMAGE_VADDR + TEXT_OFFSET;
> > > @@ -209,6 +210,7 @@ SECTIONS
> > >       _data = .;
> > >       _sdata = .;
> > >       RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_ALIGN)
> > > +     .got.plt : ALIGN(8) { *(.got.plt) }
> > >
> > >       /*
> > >        * Data written with the MMU off but read with the MMU on requires
> > > @@ -244,6 +246,7 @@ SECTIONS
> > >       _end = .;
> > >
> > >       STABS_DEBUG
> > > +     DWARF_DEBUG
> >
> > I know you didn't add it, but do we _really_ care about stabs debug? Who
> > generates that for arm64?

It's also where .comment and the .symtab ends up living. As a result,
I think it's correct to keep it. (If we wanted to split .stabs from
.comment/.symtab, we could do that, but I'd kind of like to avoid it for
this series, as it feels kind of unrelated.)

-- 
Kees Cook
