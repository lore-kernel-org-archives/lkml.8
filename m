Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC645C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2CC52084C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590387033;
	bh=AAZZMOwgYuHbhevAyyNIUV6liFjVPb2E2iBxUsLpYXU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yyzFMWvCXerppBViS0z1Lx1ZcDGSMT/5m2MtwAqcWtvpVWkxLF9wSQ5uyi7JOA1L3
	 5hQuCh0vo2pF5dTXJLnBtVpuqgm+Fv1eQ+yB4kBLTKupjlMord3mw3n8EIgO8kNzez
	 OZlilgKXJDzXxjh6bS39G9c985LrCiLDwL2RPqKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbgEYGKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 02:10:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:55520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728324AbgEYGKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 02:10:32 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96EF6208A7
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 06:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590387031;
        bh=AAZZMOwgYuHbhevAyyNIUV6liFjVPb2E2iBxUsLpYXU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KEedDt7h4gI7cMtbWw+1YX/0FJf2SwWSbOzXsRwG9XhrP6HcwWpSgFwHBXXMAQ2s2
         yr2AvlrBBhF4mJh5WNRMJzpidKPvaF1WisRg0yLoJ9MZqyHPxavUSmZ8FycGcqot1z
         d4IgietmGNRtUnlP/mEoXbWrYzsMxdqX0d/eIirA=
Received: by mail-io1-f46.google.com with SMTP id s18so3655778ioe.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 23:10:31 -0700 (PDT)
X-Gm-Message-State: AOAM53056m71EpuwdjGiX13K9wjvM8ZOYy3qtB5TdXdNjZRLBSA8MUPw
        XF7E6fHv0aSHHPeOEfrV1E85QVWOrgG6tdThbrc=
X-Google-Smtp-Source: ABdhPJy8D8hDbgtk8fpQ8Ntb6YEBqqJpzeujItn3lwvyAIPmSOKg8HNCtgzXc0u0SdmBRJFkttJWyC+QITv6kKa5ALM=
X-Received: by 2002:a05:6602:2dcd:: with SMTP id l13mr12238753iow.203.1590387030826;
 Sun, 24 May 2020 23:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOd=qB+EoJwfAYUA9Hg7f9op4Q4W+TDnht8pLRG5bPX=29Q@mail.gmail.com>
 <20200524212816.243139-5-nivedita@alum.mit.edu>
In-Reply-To: <20200524212816.243139-5-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 25 May 2020 08:10:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFjDMuLekYKiPoKDqJhfkY8UViApdMd3JaPmGbnKLO+NA@mail.gmail.com>
Message-ID: <CAMj1kXFjDMuLekYKiPoKDqJhfkY8UViApdMd3JaPmGbnKLO+NA@mail.gmail.com>
Subject: Re: [PATCH 4/4] x86/boot: Check that there are no runtime relocations
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

On Sun, 24 May 2020 at 23:28, Arvind Sankar <nivedita@alum.mit.edu> wrote:
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
>  arch/x86/boot/compressed/vmlinux.lds.S | 11 ++++++++++
>  2 files changed, 14 insertions(+), 25 deletions(-)
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
> index d826ab38a8f9..0ac14feacb24 100644
> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> @@ -11,9 +11,15 @@ OUTPUT_FORMAT(CONFIG_OUTPUT_FORMAT)
>  #ifdef CONFIG_X86_64
>  OUTPUT_ARCH(i386:x86-64)
>  ENTRY(startup_64)
> +
> +#define REL .rela
> +
>  #else
>  OUTPUT_ARCH(i386)
>  ENTRY(startup_32)
> +
> +#define REL .rel
> +
>  #endif
>
>  SECTIONS
> @@ -42,6 +48,9 @@ SECTIONS
>                 *(.rodata.*)
>                 _erodata = . ;
>         }
> +       REL.dyn : {
> +               *(REL.*)
> +       }

Do we really need the macro here? Could we just do

.rel.dyn : { *(.rel.* .rela.*) }

(or even

.rel.dyn  : { *(.rel.* }
.rela.dyn : { *(.rela.*) }

if the output section name matters, and always assert that both are empty)?

>         .got : {
>                 *(.got)
>         }
> @@ -83,3 +92,5 @@ ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT en
>  #else
>  ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0xc, "Unexpected GOT/PLT entries detected!")
>  #endif
> +
> +ASSERT(SIZEOF(REL.dyn) == 0, "Unexpected runtime relocations detected!")
> --
> 2.26.2
>
