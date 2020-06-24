Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7742C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 00:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F3E320B80
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 00:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H/YP5wjn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387907AbgFXAFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 20:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387584AbgFXAFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 20:05:52 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E1BC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 17:05:51 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id d6so226379pjs.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 17:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eeMcryoES1Zk+WEQVanRwk+k+RAQLRwTLDMRlv6REFI=;
        b=H/YP5wjnVlNLdzMThqAWzH1hEfMpADoV9e9ixZd1VzbfbF6ogS0fwNGuL4JyxZRGEP
         5LbzyRJRfMDtKS/v+zCnGm3TpYgBd+zyQpqt5JgRg1o3dlvkU/d/I7PBOkKFMTRclMKw
         zkT0Cvb3xSOuLa3mqch6Of1FSPXvXB3QcTy3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eeMcryoES1Zk+WEQVanRwk+k+RAQLRwTLDMRlv6REFI=;
        b=bQJqYzk+3S+b0N0Xy1cf2zLfvDcTxJHnIc71DVjigvXzuBq+BPuT5p3ja2BxfH2Jrj
         +fbWuqz1MWgp25K1Qde96jQqI8bc4YX7E1J32VkTeHkjHo4A1z7e+KeMWeY8rtMd7Te1
         jfWymv8QUGM8PP3WkhzQfWmmB2wXPeeB0yjHBOyf4EyB8S07/BNTDYa18s8tNRDmx4kE
         djyfbQ6abDHj+YhsKRYBK5eCxdfS0kZ2pMLwFRAxJoK4kw5y8kMm3m1AcVfjYVWrKYX0
         IoM+19yPfLM3JkwgpvT3bNy5cJS7HINVAMXdFFqTqZMWUb4fulmlUzTNgnOnCp4o332m
         Fc4g==
X-Gm-Message-State: AOAM532QUv2b23SFKxm7k5SLnOXF4+YzyCLPZsL2mAsEEzng9V1AacVs
        4ukeTzFpn5Z20dzPS/drUH9M+w==
X-Google-Smtp-Source: ABdhPJzoCrUIdqwzJwHg+VINCL47TE2E/MRo/HUaViyKu1dAE4Z+ZKr7UbP+xKhjnXnvKsQXHo7p+w==
X-Received: by 2002:a17:90a:2070:: with SMTP id n103mr26561317pjc.109.1592957150621;
        Tue, 23 Jun 2020 17:05:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u12sm3220898pjy.37.2020.06.23.17.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 17:05:49 -0700 (PDT)
Date:   Tue, 23 Jun 2020 17:05:48 -0700
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
Message-ID: <202006231704.EBCD26CE7@keescook>
References: <20200622205815.2988115-1-keescook@chromium.org>
 <20200622205815.2988115-3-keescook@chromium.org>
 <20200623145218.GC4336@willie-the-truck>
 <CAMj1kXEPe10EY1uE1vberVMXv9sx4ZRHgmssOypYm5ya5G9KoA@mail.gmail.com>
 <202006231208.F3DA600E18@keescook>
 <CAMj1kXGnm=uujNfNGJzQxd7BSF0qT2n6jPX1OqwnGov1nKC_cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGnm=uujNfNGJzQxd7BSF0qT2n6jPX1OqwnGov1nKC_cg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 11:21:16PM +0200, Ard Biesheuvel wrote:
> On Tue, 23 Jun 2020 at 23:06, Kees Cook <keescook@chromium.org> wrote:
> >
> > On Tue, Jun 23, 2020 at 04:59:39PM +0200, Ard Biesheuvel wrote:
> > > On Tue, 23 Jun 2020 at 16:52, Will Deacon <will@kernel.org> wrote:
> > > >
> > > > On Mon, Jun 22, 2020 at 01:58:15PM -0700, Kees Cook wrote:
> > > > > We don't want to depend on the linker's orphan section placement
> > > > > heuristics as these can vary between linkers, and may change between
> > > > > versions. All sections need to be explicitly named in the linker
> > > > > script.
> > > > >
> > > > > Explicitly include debug sections when they're present. Add .eh_frame*
> > > > > to discard as it seems that these are still generated even though
> > > > > -fno-asynchronous-unwind-tables is being specified. Add .plt and
> > > > > .data.rel.ro to discards as they are not actually used. Add .got.plt
> > > > > to the image as it does appear to be mapped near .data. Finally enable
> > > > > orphan section warnings.
> > > >
> > > > Can you elaborate a bit on what .got.plt is being used for, please? I
> > > > wonder if there's an interaction with an erratum workaround in the linker
> > > > or something.
> > > >
> > >
> > > .got.plt is not used at all, but it has three magic entries at the
> > > start that the dynamic linker uses for lazy dispatch, so it turns up
> > > as a non-empty section of 0x18 bytes.
> >
> > Is there a way to suppress the generation? I haven't found a way, so I'd
> > left it as-is.
> >
> 
> Not really. What we could do is assert that it is empty, and emit it
> as info, so the 24 bytes are not emitted into the image.
> 
> 
> This change
> 
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 6827da7f3aa5..9e13b371559f 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -244,6 +244,9 @@ SECTIONS
>         __pecoff_data_size = ABSOLUTE(. - __initdata_begin);
>         _end = .;
> 
> +       .got.plt (INFO) : { *(.got.plt) }
> +        ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18,
> ".got.plt not empty")
> +

Oh yes, I like that. I will do so.

>         STABS_DEBUG
> 
>         HEAD_SYMBOLS
> 
> results in
> 
>   [28] .bss              NOBITS           ffff800010d71000  00d70200
>        0000000000084120  0000000000000000  WA       0     0     4096
>   [29] .got.plt          PROGBITS         ffff800010e00000  00d70200
>        0000000000000018  0000000000000008   W       0     0     8
>   [30] .comment          PROGBITS         0000000000000000  00d70218
>        000000000000001c  0000000000000001  MS       0     0     1
> 
> in the ELF output, so it will be emitted from the image, unless it
> actually have any entries, in which case we fail the build.
> 
> 
> 
> > > We should be able to discard it afaict, but given that it does not
> > > actually take up any space, it doesn't really matter either way.
> >
> > I will add it to the discards then.
> >
> 
> That would prevent us from doing the assert on its size, so i think
> the above is more suitable in this case
> 
> > > > > diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> > > > > index a0d94d063fa8..3e628983445a 100644
> > > > > --- a/arch/arm64/Makefile
> > > > > +++ b/arch/arm64/Makefile
> > > > > @@ -29,6 +29,10 @@ LDFLAGS_vmlinux    += --fix-cortex-a53-843419
> > > > >    endif
> > > > >  endif
> > > > >
> > > > > +# We never want expected sections to be placed heuristically by the
> > > > > +# linker. All sections should be explicitly named in the linker script.
> > > > > +LDFLAGS_vmlinux += --orphan-handling=warn
> > > > > +
> > > > >  ifeq ($(CONFIG_ARM64_USE_LSE_ATOMICS), y)
> > > > >    ifneq ($(CONFIG_ARM64_LSE_ATOMICS), y)
> > > > >  $(warning LSE atomics not supported by binutils)
> > > > > diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> > > > > index 5427f502c3a6..c9ecb3b2007d 100644
> > > > > --- a/arch/arm64/kernel/vmlinux.lds.S
> > > > > +++ b/arch/arm64/kernel/vmlinux.lds.S
> > > > > @@ -94,7 +94,8 @@ SECTIONS
> > > > >       /DISCARD/ : {
> > > > >               *(.interp .dynamic)
> > > > >               *(.dynsym .dynstr .hash .gnu.hash)
> > > > > -             *(.eh_frame)
> > > > > +             *(.plt) *(.data.rel.ro)
> > > > > +             *(.eh_frame) *(.init.eh_frame)
> > > >
> > > > Do we need to include .eh_frame_hdr here too?
> > >
> > > It would be better to build with -fno-unwind-tables, in which case
> > > these sections should not even exist.
> >
> > Nothing seems to help with the .eh_frame issue
> > (even with -fno-asynchronous-unwind-tables and -fno-unwind-tables):
> >
> > $ aarch64-linux-gnu-gcc -Wp,-MMD,arch/arm64/kernel/.smccc-call.o.d \
> >   -nostdinc -isystem /usr/lib/gcc-cross/aarch64-linux-gnu/9/include \
> >   -I./arch/arm64/include -I./arch/arm64/include/generated  -I./include \
> >   -I./arch/arm64/include/uapi -I./arch/arm64/include/generated/uapi \
> >   -I./include/uapi -I./include/generated/uapi -include \
> >   ./include/linux/kconfig.h -D__KERNEL__ -mlittle-endian \
> >   -DCC_USING_PATCHABLE_FUNCTION_ENTRY -DKASAN_SHADOW_SCALE_SHIFT=3 \
> >   -D__ASSEMBLY__ -fno-PIE -mabi=lp64 -fno-asynchronous-unwind-tables \
> >   -fno-unwind-tables -DKASAN_SHADOW_SCALE_SHIFT=3 -Wa,-gdwarf-2 -c -o \
> >   arch/arm64/kernel/smccc-call.o arch/arm64/kernel/smccc-call.S
> >
> > $ readelf -S arch/arm64/kernel/smccc-call.o | grep eh_frame
> >   [17] .eh_frame         PROGBITS         0000000000000000  000001f0
> >   [18] .rela.eh_frame    RELA             0000000000000000  00000618
> >
> 
> That is because that file has CFI annotations which it doesn't need
> (since we don't unwind data).

Oh no, another TLA collision. ;) "Call Frame Information". Nice find. I
will fix this as you've suggested too.

> The below should fix that - I guess this may have been inherited from
> 32-bit ARM, where we do use unwind data in the kernel?
> 
> diff --git a/arch/arm64/kernel/smccc-call.S b/arch/arm64/kernel/smccc-call.S
> index 1f93809528a4..d62447964ed9 100644
> --- a/arch/arm64/kernel/smccc-call.S
> +++ b/arch/arm64/kernel/smccc-call.S
> @@ -9,7 +9,6 @@
>  #include <asm/assembler.h>
> 
>         .macro SMCCC instr
> -       .cfi_startproc
>         \instr  #0
>         ldr     x4, [sp]
>         stp     x0, x1, [x4, #ARM_SMCCC_RES_X0_OFFS]
> @@ -21,7 +20,6 @@
>         b.ne    1f
>         str     x6, [x4, ARM_SMCCC_QUIRK_STATE_OFFS]
>  1:     ret
> -       .cfi_endproc
>         .endm

-- 
Kees Cook
