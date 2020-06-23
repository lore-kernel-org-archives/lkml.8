Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE801C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CDCF20738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592947296;
	bh=hH450/RCEFZpmzv12pi6XP8AlMHHFigiRqhVuBRK3vQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OZA3t118MEyKEEBeeShH0jm+B2RS8o21BCtJoL6n9YhZatdaIaWiexe5vqGiRreF7
	 I4qIvvyFVe6UGY7C/H0SaNogRKDVqSbp+KoPORBwrp5G/dBOJwvPATyQyOEwmFYELC
	 i2KTZbLsKuiDyhl/4tSIDbKcHN3Ovke5UaSY30L4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393500AbgFWVVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:21:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393496AbgFWVVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 17:21:31 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26F3A20CC7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 21:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592947289;
        bh=hH450/RCEFZpmzv12pi6XP8AlMHHFigiRqhVuBRK3vQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NKsUGmDEgFP/XhFVGEgWf9q+wyyIOyYhKszlw8YCyXWNOrGn6wuKdJ/Q0qPQEZYXZ
         SRo13CfUN50jDI451+3ToeTE1bwDqtyh50e3NXjdn0OaAqnOX5SXCW7Z6b6BWd+OcQ
         p6o3fsZJnxAs1WHGe6mkAY9RKdbDLlKA02Vhls/c=
Received: by mail-ot1-f49.google.com with SMTP id 18so3516472otv.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 14:21:29 -0700 (PDT)
X-Gm-Message-State: AOAM5335p5EIOe3myrUYCljT2SKdJbQ9xNyExqZYv1ONjZutflBmCgio
        Lj/1kbaBMSoQUuKFRkAe1FWg8nNOCgEDHAVUd/o=
X-Google-Smtp-Source: ABdhPJwJxqcQQndidUHcPikOzRx5QX75fQiYitSAp0bpPp974gs22vU4fz87C/VbdWakZaNNKllL9C/kZLRFXu/bJW4=
X-Received: by 2002:a9d:42e:: with SMTP id 43mr19976618otc.108.1592947288306;
 Tue, 23 Jun 2020 14:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200622205815.2988115-1-keescook@chromium.org>
 <20200622205815.2988115-3-keescook@chromium.org> <20200623145218.GC4336@willie-the-truck>
 <CAMj1kXEPe10EY1uE1vberVMXv9sx4ZRHgmssOypYm5ya5G9KoA@mail.gmail.com> <202006231208.F3DA600E18@keescook>
In-Reply-To: <202006231208.F3DA600E18@keescook>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 23 Jun 2020 23:21:16 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGnm=uujNfNGJzQxd7BSF0qT2n6jPX1OqwnGov1nKC_cg@mail.gmail.com>
Message-ID: <CAMj1kXGnm=uujNfNGJzQxd7BSF0qT2n6jPX1OqwnGov1nKC_cg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64/build: Warn on orphan section placement
To:     Kees Cook <keescook@chromium.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jun 2020 at 23:06, Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Jun 23, 2020 at 04:59:39PM +0200, Ard Biesheuvel wrote:
> > On Tue, 23 Jun 2020 at 16:52, Will Deacon <will@kernel.org> wrote:
> > >
> > > On Mon, Jun 22, 2020 at 01:58:15PM -0700, Kees Cook wrote:
> > > > We don't want to depend on the linker's orphan section placement
> > > > heuristics as these can vary between linkers, and may change between
> > > > versions. All sections need to be explicitly named in the linker
> > > > script.
> > > >
> > > > Explicitly include debug sections when they're present. Add .eh_frame*
> > > > to discard as it seems that these are still generated even though
> > > > -fno-asynchronous-unwind-tables is being specified. Add .plt and
> > > > .data.rel.ro to discards as they are not actually used. Add .got.plt
> > > > to the image as it does appear to be mapped near .data. Finally enable
> > > > orphan section warnings.
> > >
> > > Can you elaborate a bit on what .got.plt is being used for, please? I
> > > wonder if there's an interaction with an erratum workaround in the linker
> > > or something.
> > >
> >
> > .got.plt is not used at all, but it has three magic entries at the
> > start that the dynamic linker uses for lazy dispatch, so it turns up
> > as a non-empty section of 0x18 bytes.
>
> Is there a way to suppress the generation? I haven't found a way, so I'd
> left it as-is.
>

Not really. What we could do is assert that it is empty, and emit it
as info, so the 24 bytes are not emitted into the image.


This change

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 6827da7f3aa5..9e13b371559f 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -244,6 +244,9 @@ SECTIONS
        __pecoff_data_size = ABSOLUTE(. - __initdata_begin);
        _end = .;

+       .got.plt (INFO) : { *(.got.plt) }
+        ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18,
".got.plt not empty")
+
        STABS_DEBUG

        HEAD_SYMBOLS

results in

  [28] .bss              NOBITS           ffff800010d71000  00d70200
       0000000000084120  0000000000000000  WA       0     0     4096
  [29] .got.plt          PROGBITS         ffff800010e00000  00d70200
       0000000000000018  0000000000000008   W       0     0     8
  [30] .comment          PROGBITS         0000000000000000  00d70218
       000000000000001c  0000000000000001  MS       0     0     1

in the ELF output, so it will be emitted from the image, unless it
actually have any entries, in which case we fail the build.



> > We should be able to discard it afaict, but given that it does not
> > actually take up any space, it doesn't really matter either way.
>
> I will add it to the discards then.
>

That would prevent us from doing the assert on its size, so i think
the above is more suitable in this case

> > > > diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> > > > index a0d94d063fa8..3e628983445a 100644
> > > > --- a/arch/arm64/Makefile
> > > > +++ b/arch/arm64/Makefile
> > > > @@ -29,6 +29,10 @@ LDFLAGS_vmlinux    += --fix-cortex-a53-843419
> > > >    endif
> > > >  endif
> > > >
> > > > +# We never want expected sections to be placed heuristically by the
> > > > +# linker. All sections should be explicitly named in the linker script.
> > > > +LDFLAGS_vmlinux += --orphan-handling=warn
> > > > +
> > > >  ifeq ($(CONFIG_ARM64_USE_LSE_ATOMICS), y)
> > > >    ifneq ($(CONFIG_ARM64_LSE_ATOMICS), y)
> > > >  $(warning LSE atomics not supported by binutils)
> > > > diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> > > > index 5427f502c3a6..c9ecb3b2007d 100644
> > > > --- a/arch/arm64/kernel/vmlinux.lds.S
> > > > +++ b/arch/arm64/kernel/vmlinux.lds.S
> > > > @@ -94,7 +94,8 @@ SECTIONS
> > > >       /DISCARD/ : {
> > > >               *(.interp .dynamic)
> > > >               *(.dynsym .dynstr .hash .gnu.hash)
> > > > -             *(.eh_frame)
> > > > +             *(.plt) *(.data.rel.ro)
> > > > +             *(.eh_frame) *(.init.eh_frame)
> > >
> > > Do we need to include .eh_frame_hdr here too?
> >
> > It would be better to build with -fno-unwind-tables, in which case
> > these sections should not even exist.
>
> Nothing seems to help with the .eh_frame issue
> (even with -fno-asynchronous-unwind-tables and -fno-unwind-tables):
>
> $ aarch64-linux-gnu-gcc -Wp,-MMD,arch/arm64/kernel/.smccc-call.o.d \
>   -nostdinc -isystem /usr/lib/gcc-cross/aarch64-linux-gnu/9/include \
>   -I./arch/arm64/include -I./arch/arm64/include/generated  -I./include \
>   -I./arch/arm64/include/uapi -I./arch/arm64/include/generated/uapi \
>   -I./include/uapi -I./include/generated/uapi -include \
>   ./include/linux/kconfig.h -D__KERNEL__ -mlittle-endian \
>   -DCC_USING_PATCHABLE_FUNCTION_ENTRY -DKASAN_SHADOW_SCALE_SHIFT=3 \
>   -D__ASSEMBLY__ -fno-PIE -mabi=lp64 -fno-asynchronous-unwind-tables \
>   -fno-unwind-tables -DKASAN_SHADOW_SCALE_SHIFT=3 -Wa,-gdwarf-2 -c -o \
>   arch/arm64/kernel/smccc-call.o arch/arm64/kernel/smccc-call.S
>
> $ readelf -S arch/arm64/kernel/smccc-call.o | grep eh_frame
>   [17] .eh_frame         PROGBITS         0000000000000000  000001f0
>   [18] .rela.eh_frame    RELA             0000000000000000  00000618
>

That is because that file has CFI annotations which it doesn't need
(since we don't unwind data).

The below should fix that - I guess this may have been inherited from
32-bit ARM, where we do use unwind data in the kernel?

diff --git a/arch/arm64/kernel/smccc-call.S b/arch/arm64/kernel/smccc-call.S
index 1f93809528a4..d62447964ed9 100644
--- a/arch/arm64/kernel/smccc-call.S
+++ b/arch/arm64/kernel/smccc-call.S
@@ -9,7 +9,6 @@
 #include <asm/assembler.h>

        .macro SMCCC instr
-       .cfi_startproc
        \instr  #0
        ldr     x4, [sp]
        stp     x0, x1, [x4, #ARM_SMCCC_RES_X0_OFFS]
@@ -21,7 +20,6 @@
        b.ne    1f
        str     x6, [x4, ARM_SMCCC_QUIRK_STATE_OFFS]
 1:     ret
-       .cfi_endproc
        .endm

 /*

> > > >       }
> > > >
> > > >       . = KIMAGE_VADDR + TEXT_OFFSET;
> > > > @@ -209,6 +210,7 @@ SECTIONS
> > > >       _data = .;
> > > >       _sdata = .;
> > > >       RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_ALIGN)
> > > > +     .got.plt : ALIGN(8) { *(.got.plt) }
> > > >
> > > >       /*
> > > >        * Data written with the MMU off but read with the MMU on requires
> > > > @@ -244,6 +246,7 @@ SECTIONS
> > > >       _end = .;
> > > >
> > > >       STABS_DEBUG
> > > > +     DWARF_DEBUG
> > >
> > > I know you didn't add it, but do we _really_ care about stabs debug? Who
> > > generates that for arm64?
>
> It's also where .comment and the .symtab ends up living. As a result,
> I think it's correct to keep it. (If we wanted to split .stabs from
> .comment/.symtab, we could do that, but I'd kind of like to avoid it for
> this series, as it feels kind of unrelated.)
>
> --
> Kees Cook
