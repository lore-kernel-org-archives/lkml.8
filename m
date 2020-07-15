Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E06C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D96E8206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REAg+4jM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbgGOIzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbgGOIzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:55:01 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D2DC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:55:01 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id k23so1406542iom.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=E2KzDTTFRMDiRWJvyL1sP2xPLBu+h45b96i3t1+zICg=;
        b=REAg+4jMgFjTriSI5Lb0DMOgace/gsHcOhmNuScsAQpLlZNqocusWWB0jZYfdmjSxP
         38l7QutyQ1JxMOQlHKZLh0wI17gFE2diQLmCqTGo00F/QJD2N8xY8Hr6cmS/nTG3iFe2
         ElK1iW+HwQhoKoHVP7+a6W4MuY5rb4rVJzF1KRdBhBuQTs6t+xfubC5Ptl7CxjypZ1P4
         C0tFFyfZZuSttYWNi+p+kpFEMjCm6elPYU7jq7CvJZUHVjTE+0hzQVQcltD2FrJcnMqy
         OnPyfIU0IflA0aaqOXFaeiuHmSDMQ8ozB2UNnguweCdAJ18RMhLDOD9SlH1xs8gkVALP
         G2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=E2KzDTTFRMDiRWJvyL1sP2xPLBu+h45b96i3t1+zICg=;
        b=hT1YZp71qoUezFgoQXKa4YtK3gv10xDe6eSYDo9P7pwwWLpqjCsuPGQ8p8Xd5aeTjI
         6cwh0mDylST/CmXZ6N8UUP6L3TeCt/xQ+AudUb1mHxjrp/h72mFxFtLwjzqo6NKrJd+8
         4q+okqwDJ8d35mqb0oFqGW320uUciRwTBVLIgBgcEeD79POGNVfqkvTBGAfToepc9QbL
         h7JFSoAheB5B0iTISSDj/awOz+VfSJjBMWuojWyh3mjDlqXBLSZdWVGd7wMT1EuXZlWj
         HcEfOHexbhG3nC3yPyb/RRg8mOdUxPKY2mazK6//Hoi2q2J35LT6RYEjNXbLd08kW6e+
         7U9Q==
X-Gm-Message-State: AOAM533ztRjkxbs3JK7dE8FmCcG9oVRR9CUM5u474tm4n0Zxop8/KQf8
        LXiXAumhnp20FNplM2BV/wyLS3c64RmYyxp/tP4=
X-Google-Smtp-Source: ABdhPJz7vNmjqPEigVUxaXZKf2QB7tcA/b2b+Q3C0oB6IQ4cfmzqBcJ5BN8+V+V89TuDMyBt64LqaV1Nd1j4r2f8x0c=
X-Received: by 2002:a05:6602:1555:: with SMTP id h21mr8957112iow.163.1594803300431;
 Wed, 15 Jul 2020 01:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200714023836.2310569-1-nivedita@alum.mit.edu> <20200715004133.1430068-4-nivedita@alum.mit.edu>
In-Reply-To: <20200715004133.1430068-4-nivedita@alum.mit.edu>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 15 Jul 2020 10:54:49 +0200
Message-ID: <CA+icZUVPzMnEe-VUabCCA_Kb9X00NZTUoms1Q0Wm6sK-5fHn=A@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] x86/boot/compressed: Get rid of GOT fixup code
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
> From: Ard Biesheuvel <ardb@kernel.org>
>
> In a previous patch, we have eliminated GOT entries from the decompressor
> binary and added an assertion that the .got section is empty. This means
> that the GOT fixup routines that exist in both the 32-bit and 64-bit
> startup routines have become dead code, and can be removed.
>
> While at it, drop the KEEP() from the linker script, as it has no effect
> on the contents of output sections that are created by the linker itself.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Acked-by: Arvind Sankar <nivedita@alum.mit.edu>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> From: Ard Biesheuvel <ardb@kernel.org>
> Link: https://lore.kernel.org/r/20200523120021.34996-4-ardb@kernel.org

Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

- Sedat -

> ---
>  arch/x86/boot/compressed/head_32.S     | 24 ++---------
>  arch/x86/boot/compressed/head_64.S     | 57 --------------------------
>  arch/x86/boot/compressed/vmlinux.lds.S |  4 +-
>  3 files changed, 5 insertions(+), 80 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
> index 03557f2174bf..39f0bb43218f 100644
> --- a/arch/x86/boot/compressed/head_32.S
> +++ b/arch/x86/boot/compressed/head_32.S
> @@ -49,16 +49,13 @@
>   * Position Independent Executable (PIE) so that linker won't optimize
>   * R_386_GOT32X relocation to its fixed symbol address.  Older
>   * linkers generate R_386_32 relocations against locally defined symbols,
> - * _bss, _ebss, _got, _egot and _end, in PIE.  It isn't wrong, just less
> - * optimal than R_386_RELATIVE.  But the x86 kernel fails to properly handle
> - * R_386_32 relocations when relocating the kernel.  To generate
> - * R_386_RELATIVE relocations, we mark _bss, _ebss, _got, _egot and _end as
> - * hidden:
> + * _bss, _ebss and _end, in PIE.  It isn't wrong, just less optimal than
> + * R_386_RELATIVE.  But the x86 kernel fails to properly handle R_386_32
> + * relocations when relocating the kernel.  To generate R_386_RELATIVE
> + * relocations, we mark _bss, _ebss and _end as hidden:
>   */
>         .hidden _bss
>         .hidden _ebss
> -       .hidden _got
> -       .hidden _egot
>         .hidden _end
>
>         __HEAD
> @@ -192,19 +189,6 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
>         shrl    $2, %ecx
>         rep     stosl
>
> -/*
> - * Adjust our own GOT
> - */
> -       leal    _got(%ebx), %edx
> -       leal    _egot(%ebx), %ecx
> -1:
> -       cmpl    %ecx, %edx
> -       jae     2f
> -       addl    %ebx, (%edx)
> -       addl    $4, %edx
> -       jmp     1b
> -2:
> -
>  /*
>   * Do the extraction, and jump to the new kernel..
>   */
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index 97d37f0a34f5..bf1ab30acc5b 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -40,8 +40,6 @@
>   */
>         .hidden _bss
>         .hidden _ebss
> -       .hidden _got
> -       .hidden _egot
>         .hidden _end
>
>         __HEAD
> @@ -353,25 +351,6 @@ SYM_CODE_START(startup_64)
>         /* Set up the stack */
>         leaq    boot_stack_end(%rbx), %rsp
>
> -       /*
> -        * paging_prepare() and cleanup_trampoline() below can have GOT
> -        * references. Adjust the table with address we are running at.
> -        *
> -        * Zero RAX for adjust_got: the GOT was not adjusted before;
> -        * there's no adjustment to undo.
> -        */
> -       xorq    %rax, %rax
> -
> -       /*
> -        * Calculate the address the binary is loaded at and use it as
> -        * a GOT adjustment.
> -        */
> -       call    1f
> -1:     popq    %rdi
> -       subq    $1b, %rdi
> -
> -       call    .Ladjust_got
> -
>         /*
>          * At this point we are in long mode with 4-level paging enabled,
>          * but we might want to enable 5-level paging or vice versa.
> @@ -464,21 +443,6 @@ trampoline_return:
>         pushq   $0
>         popfq
>
> -       /*
> -        * Previously we've adjusted the GOT with address the binary was
> -        * loaded at. Now we need to re-adjust for relocation address.
> -        *
> -        * Calculate the address the binary is loaded at, so that we can
> -        * undo the previous GOT adjustment.
> -        */
> -       call    1f
> -1:     popq    %rax
> -       subq    $1b, %rax
> -
> -       /* The new adjustment is the relocation address */
> -       movq    %rbx, %rdi
> -       call    .Ladjust_got
> -
>  /*
>   * Copy the compressed kernel to the end of our buffer
>   * where decompression in place becomes safe.
> @@ -556,27 +520,6 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
>         jmp     *%rax
>  SYM_FUNC_END(.Lrelocated)
>
> -/*
> - * Adjust the global offset table
> - *
> - * RAX is the previous adjustment of the table to undo (use 0 if it's the
> - * first time we touch GOT).
> - * RDI is the new adjustment to apply.
> - */
> -.Ladjust_got:
> -       /* Walk through the GOT adding the address to the entries */
> -       leaq    _got(%rip), %rdx
> -       leaq    _egot(%rip), %rcx
> -1:
> -       cmpq    %rcx, %rdx
> -       jae     2f
> -       subq    %rax, (%rdx)    /* Undo previous adjustment */
> -       addq    %rdi, (%rdx)    /* Apply the new adjustment */
> -       addq    $8, %rdx
> -       jmp     1b
> -2:
> -       ret
> -
>         .code32
>  /*
>   * This is the 32-bit trampoline that will be copied over to low memory.
> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> index 4bcc943842ab..a4a4a59a2628 100644
> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> @@ -43,9 +43,7 @@ SECTIONS
>                 _erodata = . ;
>         }
>         .got : {
> -               _got = .;
> -               KEEP(*(.got))
> -               _egot = .;
> +               *(.got)
>         }
>         .got.plt : {
>                 *(.got.plt)
> --
> 2.26.2
>
