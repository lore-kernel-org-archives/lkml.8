Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9DEC433E7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 000BD2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3qqHi6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbgGOI6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbgGOI6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:58:12 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CB6C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:58:12 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id k23so1414431iom.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=jvfhiaQ0ZxylHig36vxLZl3dur0kELp+OxDh9AgCRVc=;
        b=Q3qqHi6Vb4wkdksxz46tFM+5xx30OqKZbSSKW3ASJdtpDmCnfcEhLFQhgDvk9lDm9u
         SBzD9obwRzrhS5z70GLrDUJGJQJh3A1YaPfy4G+8hvpWp6Xo0p2I95y0bvTSUw47vKR5
         TnoVMCtHyHTRbOnpwRncyhTPThc70sZc3eAuKNmRDQaa8eloLqWc4LNojxiLXdpX2WN2
         5Wz35K+OW4Nn3RcUTZztpKGRZdXVL0ZfMDx20nIf4xL9V/ffN8SvoUmf2XqanncWKddO
         K8DpnvcAcwJtoBR7/z+fJNOPOE3RauvE7S+JJRc/Y9/OxiSZ8ieANMG6ULsffxqGeR/+
         jksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=jvfhiaQ0ZxylHig36vxLZl3dur0kELp+OxDh9AgCRVc=;
        b=PwvXtWLfDme7rs8oCgrncsoB+Ezlhu1S4OSWxUWrnmd+i3bNwEPku4IMfOtu+csH4U
         WLBSFgJ2jEODgnvDYIf836LU7rwYlquuo1BpmkEKAxNAZM2/uzt0FcJjSxbiWMUHPcjS
         vSVqRjcLa1Qm8FuCW+tIkeZEyvL7guunyMTgfHkQVmR7WDmjNf57c13KquG/OWPqqx+3
         qN83BY/T6UgFxLHUGXxnMgCC/Ywe6HnXFjlffY05VqprDJ40UPSVHIfcPV0dxBuJMA+Q
         9sJKDxXY9NJ+ZXRJK0meNqtvRioL2N++FE2gDVjQwqL7kij+2CIy766g6XlK3U9Qg4xG
         Hs/Q==
X-Gm-Message-State: AOAM533BTNhCmj/F6QmcrLOuQjmelxHUaplSHt9/CEIkw8M/unT1ZbxK
        IIhHdgKwuHwomrg0YPRQoWjj2XeW3qGjZrNfStc=
X-Google-Smtp-Source: ABdhPJyyPzktAZMM5s/N99YfkgwAsq0iA1bBuBa2p/Ke6PvRarc0kqJCAfWMQr++aRa1GTuUWcQcb61vWT9xu2U+4x4=
X-Received: by 2002:a5e:c91a:: with SMTP id z26mr888628iol.70.1594803491962;
 Wed, 15 Jul 2020 01:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200714023836.2310569-1-nivedita@alum.mit.edu> <20200715004133.1430068-7-nivedita@alum.mit.edu>
In-Reply-To: <20200715004133.1430068-7-nivedita@alum.mit.edu>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 15 Jul 2020 10:58:00 +0200
Message-ID: <CA+icZUXDoeHEcFurBVTv-JMR2xR6oj500n=fVSrN56_KOHiHcw@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] x86/boot: Remove run-time relocations from head_{32,64}.S
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
> The BFD linker generates run-time relocations for z_input_len and
> z_output_len, even though they are absolute symbols.
>
> This is fixed for binutils-2.35 [1]. Work around this for earlier
> versions by defining two variables input_len and output_len in addition
> to the symbols, and use them via position-independent references.
>
> This eliminates the last two run-time relocations in the head code and
> allows us to drop the -z noreloc-overflow flag to the linker.
>
> Move the -pie and --no-dynamic-linker LDFLAGS to LDFLAGS_vmlinux instead
> of KBUILD_LDFLAGS. There shouldn't be anything else getting linked, but
> this is the more logical location for these flags, and modversions might
> call the linker if an EXPORT_SYMBOL is left over accidentally in one of
> the decompressors.
>

Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>

Reported breakage with LLD in previous patchset version.

- Sedat -

> [1] https://sourceware.org/bugzilla/show_bug.cgi?id=25754
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> Reviewed-by: Fangrui Song <maskray@google.com>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  arch/x86/boot/compressed/Makefile  | 12 ++----------
>  arch/x86/boot/compressed/head_32.S | 17 ++++++++---------
>  arch/x86/boot/compressed/head_64.S |  4 ++--
>  arch/x86/boot/compressed/mkpiggy.c |  6 ++++++
>  4 files changed, 18 insertions(+), 21 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index c829d874dcac..ae2c0dc98a6a 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -51,16 +51,8 @@ UBSAN_SANITIZE :=n
>  KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
>  # Compressed kernel should be built as PIE since it may be loaded at any
>  # address by the bootloader.
> -ifeq ($(CONFIG_X86_32),y)
> -KBUILD_LDFLAGS += $(call ld-option, -pie) $(call ld-option, --no-dynamic-linker)
> -else
> -# To build 64-bit compressed kernel as PIE, we disable relocation
> -# overflow check to avoid relocation overflow error with a new linker
> -# command-line option, -z noreloc-overflow.
> -KBUILD_LDFLAGS += $(shell $(LD) --help 2>&1 | grep -q "\-z noreloc-overflow" \
> -       && echo "-z noreloc-overflow -pie --no-dynamic-linker")
> -endif
> -LDFLAGS_vmlinux := -T
> +LDFLAGS_vmlinux := $(call ld-option, -pie) $(call ld-option, --no-dynamic-linker)
> +LDFLAGS_vmlinux += -T
>
>  hostprogs      := mkpiggy
>  HOST_EXTRACFLAGS += -I$(srctree)/tools/include
> diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
> index 8c1a4f5610f5..659fad53ca82 100644
> --- a/arch/x86/boot/compressed/head_32.S
> +++ b/arch/x86/boot/compressed/head_32.S
> @@ -178,18 +178,17 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
>  /*
>   * Do the extraction, and jump to the new kernel..
>   */
> -                               /* push arguments for extract_kernel: */
> -       pushl   $z_output_len   /* decompressed length, end of relocs */
> +       /* push arguments for extract_kernel: */
>
> -       pushl   %ebp            /* output address */
> -
> -       pushl   $z_input_len    /* input_len */
> +       pushl   output_len@GOTOFF(%ebx) /* decompressed length, end of relocs */
> +       pushl   %ebp                    /* output address */
> +       pushl   input_len@GOTOFF(%ebx)  /* input_len */
>         leal    input_data@GOTOFF(%ebx), %eax
> -       pushl   %eax            /* input_data */
> +       pushl   %eax                    /* input_data */
>         leal    boot_heap@GOTOFF(%ebx), %eax
> -       pushl   %eax            /* heap area */
> -       pushl   %esi            /* real mode pointer */
> -       call    extract_kernel  /* returns kernel location in %eax */
> +       pushl   %eax                    /* heap area */
> +       pushl   %esi                    /* real mode pointer */
> +       call    extract_kernel          /* returns kernel location in %eax */
>         addl    $24, %esp
>
>  /*
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index 11429092c224..9e46729cf162 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -534,9 +534,9 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
>         movq    %rsi, %rdi              /* real mode address */
>         leaq    boot_heap(%rip), %rsi   /* malloc area for uncompression */
>         leaq    input_data(%rip), %rdx  /* input_data */
> -       movl    $z_input_len, %ecx      /* input_len */
> +       movl    input_len(%rip), %ecx   /* input_len */
>         movq    %rbp, %r8               /* output target address */
> -       movl    $z_output_len, %r9d     /* decompressed length, end of relocs */
> +       movl    output_len(%rip), %r9d  /* decompressed length, end of relocs */
>         call    extract_kernel          /* returns kernel location in %rax */
>         popq    %rsi
>
> diff --git a/arch/x86/boot/compressed/mkpiggy.c b/arch/x86/boot/compressed/mkpiggy.c
> index 7e01248765b2..52aa56cdbacc 100644
> --- a/arch/x86/boot/compressed/mkpiggy.c
> +++ b/arch/x86/boot/compressed/mkpiggy.c
> @@ -60,6 +60,12 @@ int main(int argc, char *argv[])
>         printf(".incbin \"%s\"\n", argv[1]);
>         printf("input_data_end:\n");
>
> +       printf(".section \".rodata\",\"a\",@progbits\n");
> +       printf(".globl input_len\n");
> +       printf("input_len:\n\t.long %lu\n", ilen);
> +       printf(".globl output_len\n");
> +       printf("output_len:\n\t.long %lu\n", (unsigned long)olen);
> +
>         retval = 0;
>  bail:
>         if (f)
> --
> 2.26.2
>
