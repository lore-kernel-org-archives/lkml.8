Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51511C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24C802064C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7nhBArn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbgGOJAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729856AbgGOJAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:00:22 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188E2C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:00:22 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id p15so1289445ilh.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=3PdI5My1859p1IPLjt/fTz0M9NmoIv3OJiR/upvR4pU=;
        b=G7nhBArnI8dDAWLzn7t0gQ4Jw6E5u2epv+qWi1FMPk19Ks9IQ5Yk+pdt1G4MuhUNLh
         5EJA8w3hkiIKnjeBGkuLfF3UOfRDw9OiDLQ3+Pjhbg/6a8hglmIkUZ7+Mk9bKKmF8QJi
         0jMtaco5NjQRCTNiQTowWYrt/X1jGkiWY+DRet5809UxazXutq86yJ9xZWtJG3LV++eZ
         X+RR+wc4XEoPvcLFG48avjW0OYTneDVSLuf3B/FMx1mUPtBDJ+zTFGcAn1vAq/GSLVkP
         JQ97ms0xaQzSICQ+QllqWF1BfY17i3zDxYGLaLcy4oj26GTSLtDiVBUdObhHLFoAvAcA
         zvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=3PdI5My1859p1IPLjt/fTz0M9NmoIv3OJiR/upvR4pU=;
        b=GcQFVCwU4tdGCN8KveKObK/moQjVCTPFzNoSimSKuF+578FlVTKEqm6e8D/3P1JNK4
         XkZY3Ys0NVCFfsUPUpvRCPdTqDqGUn0/faFkvtRODdcBE7r23XXVwpshQifILxBQFvTO
         oB5Hr8IMVEzSKxY0cbT0/Xq9+uXiYApt8C5sZSQlRUfIjw1Fec4HezxeWnb9uUwLP/u+
         fHjIrDNDG+/BlArk0lcgnXb0WLx9j7aolJZdCh8eM2jj8i/nm5YqEB5ZkdjbyaYm0o7D
         byRC46V+nmnwhpz9yGE5SCiOuP+P3l6FhedTulFCdYgYmDYf7lsbnOpRsXKGp0L47t2P
         Qy3w==
X-Gm-Message-State: AOAM530hWQW550797aECDCRWfkmn37Jt51UorZVFJW9qgDZERTsHpK4P
        Sopt/0yLC9kvOnBFJny4or+KtCUVVnlm1mDrXQTE0EJcWxNMwg==
X-Google-Smtp-Source: ABdhPJwiw/V5cpY9X6o1hhpnLP60M2kWqRtih7nyoTLY1Oqm1DwTl58fYIRsUILEXnNuN94k5Qv2v+VQsvepukPDYWg=
X-Received: by 2002:a92:8b11:: with SMTP id i17mr8783455ild.212.1594803621436;
 Wed, 15 Jul 2020 02:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200714023836.2310569-1-nivedita@alum.mit.edu> <20200715004133.1430068-8-nivedita@alum.mit.edu>
In-Reply-To: <20200715004133.1430068-8-nivedita@alum.mit.edu>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 15 Jul 2020 11:00:10 +0200
Message-ID: <CA+icZUX56cEjdkiuxOXtCgY1F0NWD5QxqMBRQxE5Li3=RUe-7w@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] x86/boot: Check that there are no run-time relocations
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

On Wed, Jul 15, 2020 at 2:41 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Add a linker script check that there are no run-time relocations, and
> remove the old one that tries to check via looking for specially-named
> sections in the object files.
>
> Drop the tests for -fPIE compiler option and -pie linker option, as they
> are available in all supported gcc and binutils versions (as well as
> clang and lld).
>

Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>

Here I reported the breakage with LLD and tested the move to
LDFLAGS_vmlinux with a previous version of the patch.

- Sedat -

> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> Reviewed-by: Fangrui Song <maskray@google.com>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  arch/x86/boot/compressed/Makefile      | 28 +++-----------------------
>  arch/x86/boot/compressed/vmlinux.lds.S |  8 ++++++++
>  2 files changed, 11 insertions(+), 25 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index ae2c0dc98a6a..a9e082b8c720 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -29,7 +29,7 @@ targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
>         vmlinux.bin.xz vmlinux.bin.lzo vmlinux.bin.lz4
>
>  KBUILD_CFLAGS := -m$(BITS) -O2
> -KBUILD_CFLAGS += -fno-strict-aliasing $(call cc-option, -fPIE, -fPIC)
> +KBUILD_CFLAGS += -fno-strict-aliasing -fPIE
>  KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
>  cflags-$(CONFIG_X86_32) := -march=i386
>  cflags-$(CONFIG_X86_64) := -mcmodel=small
> @@ -51,7 +51,7 @@ UBSAN_SANITIZE :=n
>  KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
>  # Compressed kernel should be built as PIE since it may be loaded at any
>  # address by the bootloader.
> -LDFLAGS_vmlinux := $(call ld-option, -pie) $(call ld-option, --no-dynamic-linker)
> +LDFLAGS_vmlinux := -pie $(call ld-option, --no-dynamic-linker)
>  LDFLAGS_vmlinux += -T
>
>  hostprogs      := mkpiggy
> @@ -86,30 +86,8 @@ vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
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
> index a4a4a59a2628..29df99b6cc64 100644
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
> @@ -85,3 +91,5 @@ ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT en
>  #else
>  ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0xc, "Unexpected GOT/PLT entries detected!")
>  #endif
> +
> +ASSERT(SIZEOF(.rel.dyn) == 0 && SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations detected!")
> --
> 2.26.2
>
