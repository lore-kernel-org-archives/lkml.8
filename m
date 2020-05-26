Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE29C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 06:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B09D5208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 06:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590473529;
	bh=ySEa+3x56DEhXDsJ/5BxjWyMNs8ZHKcIGhjiyVJvg+Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PAsGnwFZPV1TSIBE9blVzKdX1sQwYiqbAxYrDc4Hx2+tRM3SmEna7X6g3pH639/hk
	 98vCspKJKh/k6gJuKvB03WHTdZpPwbBewW5Po6hn1NfZj5+UExhhk4qlROVFOuBeCF
	 cU4973PyTbBnnf315uotEm+mYnGEY1P9wN1INfas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbgEZGMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 02:12:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:59824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbgEZGMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 02:12:08 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A71FA20EDD
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 06:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590473527;
        bh=ySEa+3x56DEhXDsJ/5BxjWyMNs8ZHKcIGhjiyVJvg+Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wYzi42jJMIcztM9lOAVmyApIDg2YsU4yqUmxwqz5SZYzeoYOr1L/7rW32T5YrVb4F
         5vtCOpzRXR5Rwz8Fo70V9JvsTZsBhTz8AUCiCbns36n7aaWZFsB/BX7h9ui3I1Nr+Z
         sMVCw3KZApN4kp/Oor+fxolkBAKxnNEt8qb+UT9M=
Received: by mail-io1-f53.google.com with SMTP id d7so20768748ioq.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 23:12:07 -0700 (PDT)
X-Gm-Message-State: AOAM5328II0QKuEjjN7nwYm25qzi+W2lbm4pDVxtRcHU2PFUdnNS29Zt
        3EGjywKniMxi+I1Fs0i58nJBt1WQ6E98biDeC30=
X-Google-Smtp-Source: ABdhPJwWkzq/+TpvYaSSsedLrS+kmTbhs9gJOSZa3GxF6wEZ6Odb8i1gOPUnwbRqugb9RVr8B4A1r7wQkAUSG7B2N/8=
X-Received: by 2002:a02:956f:: with SMTP id y102mr9289995jah.68.1590473526930;
 Mon, 25 May 2020 23:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200524212816.243139-1-nivedita@alum.mit.edu> <20200525225918.1624470-5-nivedita@alum.mit.edu>
In-Reply-To: <20200525225918.1624470-5-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 26 May 2020 08:11:56 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHc4o91VkaChoyVzr4w-HOaashMPtkCKLaszMGCxhR_2A@mail.gmail.com>
Message-ID: <CAMj1kXHc4o91VkaChoyVzr4w-HOaashMPtkCKLaszMGCxhR_2A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] x86/boot: Check that there are no runtime relocations
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 May 2020 at 00:59, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Add a linker script check that there are no runtime relocations, and
> remove the old one that tries to check via looking for specially-named
> sections in the object files.
>
> Drop the tests for -fPIE compiler option and -pie linker option, as they
> are available in all supported gcc and binutils versions (as well as
> clang and lld).
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  arch/x86/boot/compressed/Makefile      | 28 +++-----------------------
>  arch/x86/boot/compressed/vmlinux.lds.S |  8 ++++++++
>  2 files changed, 11 insertions(+), 25 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index d3e882e855ee..679a2b383bfe 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -27,7 +27,7 @@ targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
>         vmlinux.bin.xz vmlinux.bin.lzo vmlinux.bin.lz4
>
>  KBUILD_CFLAGS := -m$(BITS) -O2
> -KBUILD_CFLAGS += -fno-strict-aliasing $(call cc-option, -fPIE, -fPIC)
> +KBUILD_CFLAGS += -fno-strict-aliasing -fPIE
>  KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
>  cflags-$(CONFIG_X86_32) := -march=i386
>  cflags-$(CONFIG_X86_64) := -mcmodel=small
> @@ -49,7 +49,7 @@ UBSAN_SANITIZE :=n
>  KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
>  # Compressed kernel should be built as PIE since it may be loaded at any
>  # address by the bootloader.
> -KBUILD_LDFLAGS += $(call ld-option, -pie) $(call ld-option, --no-dynamic-linker)
> +KBUILD_LDFLAGS += -pie $(call ld-option, --no-dynamic-linker)

Do we still need -pie linking with these changes applied?

>  LDFLAGS_vmlinux := -T
>
>  hostprogs      := mkpiggy
> @@ -84,30 +84,8 @@ vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
>  vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
>  vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
>
> -# The compressed kernel is built with -fPIC/-fPIE so that a boot loader
> -# can place it anywhere in memory and it will still run. However, since
> -# it is executed as-is without any ELF relocation processing performed
> -# (and has already had all relocation sections stripped from the binary),
> -# none of the code can use data relocations (e.g. static assignments of
> -# pointer values), since they will be meaningless at runtime. This check
> -# will refuse to link the vmlinux if any of these relocations are found.
> -quiet_cmd_check_data_rel = DATAREL $@
> -define cmd_check_data_rel
> -       for obj in $(filter %.o,$^); do \
> -               $(READELF) -S $$obj | grep -qF .rel.local && { \
> -                       echo "error: $$obj has data relocations!" >&2; \
> -                       exit 1; \
> -               } || true; \
> -       done
> -endef
> -
> -# We need to run two commands under "if_changed", so merge them into a
> -# single invocation.
> -quiet_cmd_check-and-link-vmlinux = LD      $@
> -      cmd_check-and-link-vmlinux = $(cmd_check_data_rel); $(cmd_ld)
> -
>  $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
> -       $(call if_changed,check-and-link-vmlinux)
> +       $(call if_changed,ld)
>
>  OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
>  $(obj)/vmlinux.bin: vmlinux FORCE
> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> index d826ab38a8f9..f9902c6ffe29 100644
> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> @@ -42,6 +42,12 @@ SECTIONS
>                 *(.rodata.*)
>                 _erodata = . ;
>         }
> +       .rel.dyn : {
> +               *(.rel.*)
> +       }
> +       .rela.dyn : {
> +               *(.rela.*)
> +       }
>         .got : {
>                 *(.got)
>         }
> @@ -83,3 +89,5 @@ ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT en
>  #else
>  ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0xc, "Unexpected GOT/PLT entries detected!")
>  #endif
> +
> +ASSERT(SIZEOF(.rel.dyn) == 0 && SIZEOF(.rela.dyn) == 0, "Unexpected runtime relocations detected!")
> --
> 2.26.2
>
