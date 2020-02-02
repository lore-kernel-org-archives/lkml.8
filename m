Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604D0C35249
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 17:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A89120679
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 17:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TbPtfQQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgBBRzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 12:55:03 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40187 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgBBRzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 12:55:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id t14so14384330wmi.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Feb 2020 09:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l16/jWBg5TdkuLQMSLdNnEO2hLRau3tU8l2zd5isbi4=;
        b=TbPtfQQyQotPasF9Z3NIeqbz+pg3LRy9qOf3r/F8o0SAuMeEGwyaj1diE1wJHCSiit
         DjSQ4VJQcEbXLhFs7iAoizPsguYDlcmG7czPm8igOCw8aeRZgNK+n72FnMNYa5iCIXMy
         5qxme+/q37VpO36jGjOzrGwmzj+EFr3oKrsBK4n+2+kEes5I2k7cPAoey128xlr1C8/M
         kj/2QOUZYuuPI/6QlZQAiwnwFVCMsCr83XLwF2BpqILBEWWNZxsg4eLePxR8Y5agiGNj
         iJpR3uHd+TlnPvTwWTkP6fw7nycKk+/xL6tCnYknnYA8N+DEY6w/4hrk7Eg1N4BZhE6r
         3EbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l16/jWBg5TdkuLQMSLdNnEO2hLRau3tU8l2zd5isbi4=;
        b=fwOB0JC5aeHnzuYgoXRV25UQ4aT92jzV9kF74yMbT5F1+PfMERhy9rz7kGNkfmLsx7
         km2rfmQLLUx9O9/CZ3uDICYb3mzN7j0zLIBMzgPTa2xL8UkOCeiTZ1MPZNZn8OsHraVn
         7trB3PrWQtv8RH3nORfm+P+ppu19mEEmfn6Ec2HJBo5Blco5FS8+Cl2ripRO2uevHTgn
         Az7n0FFBrJ7dRUD2N9uKgp4QI85sDXPH5l82HveLrkYAOi288RbNf3yad+qjIOnSRlN9
         aluWVP2LLYXQdYRh5ViKWF9/HnA7sbi0gYHdqHP5iRK/kxjX+fnsWLgmIodOiYYPW1dS
         XbAA==
X-Gm-Message-State: APjAAAV8cqlPrk+pMarpu5Xg0dG3Q4z5wR3H5OXI7fkjGlIZ40K+qd+G
        Ez9GmdLu9JFAAwog6wAVdlsD7RVWL7XeVdh3v4mvBA==
X-Google-Smtp-Source: APXvYqzd+spEUZojR0Pta6mmrqcc+UjO+w2JlWfu6GM0fkKNdW6/l6Q/Tl8cMlgwoxSBGrzoFniwdsxwOCEAVzy/U+I=
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr26387310wmk.68.1580666101359;
 Sun, 02 Feb 2020 09:55:01 -0800 (PST)
MIME-Version: 1.0
References: <20200130200440.1796058-1-nivedita@alum.mit.edu>
 <20200202171353.3736319-1-nivedita@alum.mit.edu> <20200202171353.3736319-3-nivedita@alum.mit.edu>
In-Reply-To: <20200202171353.3736319-3-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sun, 2 Feb 2020 18:54:48 +0100
Message-ID: <CAKv+Gu9_bXmRMqs3Es7XXFjRafAm0HjyM6EasuKP1nka-dLdVA@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] efi/x86: Don't depend on firmware GDT layout
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Feb 2020 at 18:13, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> At handover entry in efi32_stub_entry, the firmware's GDT is still
> installed. We save the GDTR for later use in __efi64_thunk but we are
> assuming that descriptor 2 (__KERNEL_CS) is a valid 32-bit code segment
> descriptor and that descriptor 3 (__KERNEL_DS/__BOOT_DS) is a valid data
> segment descriptor.
>
> This happens to be true for OVMF (it actually uses descriptor 1 for data
> segments, but descriptor 3 is also setup as data), but we shouldn't
> depend on this being the case.
>
> Fix this by saving the code and data selectors in addition to the GDTR
> in efi32_stub_entry, and restoring them in __efi64_thunk before calling
> the firmware. The UEFI specification guarantees that selectors will be
> flat, so using the DS selector for all the segment registers should be
> enough.
>
> We also need to install our own GDT before initializing segment
> registers in startup_32, so move the GDT load up to the beginning of the
> function.
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

It might be useful to mention /somewhere/ in the commit log that this
applies to mixed mode

> ---
>  arch/x86/boot/compressed/efi_thunk_64.S | 29 +++++++++++++++++++-----
>  arch/x86/boot/compressed/head_64.S      | 30 +++++++++++++++----------
>  2 files changed, 42 insertions(+), 17 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/efi_thunk_64.S b/arch/x86/boot/compressed/efi_thunk_64.S
> index 8fb7f6799c52..2b2049259619 100644
> --- a/arch/x86/boot/compressed/efi_thunk_64.S
> +++ b/arch/x86/boot/compressed/efi_thunk_64.S
> @@ -54,11 +54,16 @@ SYM_FUNC_START(__efi64_thunk)
>          * Switch to gdt with 32-bit segments. This is the firmware GDT
>          * that was installed when the kernel started executing. This
>          * pointer was saved at the EFI stub entry point in head_64.S.
> +        *
> +        * Pass the saved DS selector to the 32-bit code, and use far return to
> +        * restore the saved CS selector.
>          */
>         leaq    efi32_boot_gdt(%rip), %rax
>         lgdt    (%rax)
>
> -       pushq   $__KERNEL_CS
> +       movzwl  efi32_boot_ds(%rip), %edx
> +       movzwq  efi32_boot_cs(%rip), %rax
> +       pushq   %rax
>         leaq    efi_enter32(%rip), %rax
>         pushq   %rax
>         lretq
> @@ -73,6 +78,10 @@ SYM_FUNC_START(__efi64_thunk)
>         movl    %ebx, %es
>         pop     %rbx
>         movl    %ebx, %ds
> +       /* Clear out 32-bit selector from FS and GS */
> +       xorl    %ebx, %ebx
> +       movl    %ebx, %fs
> +       movl    %ebx, %gs
>
>         /*
>          * Convert 32-bit status code into 64-bit.
> @@ -92,10 +101,12 @@ SYM_FUNC_END(__efi64_thunk)
>   * The stack should represent the 32-bit calling convention.
>   */
>  SYM_FUNC_START_LOCAL(efi_enter32)
> -       movl    $__KERNEL_DS, %eax
> -       movl    %eax, %ds
> -       movl    %eax, %es
> -       movl    %eax, %ss
> +       /* Load firmware selector into data and stack segment registers */
> +       movl    %edx, %ds
> +       movl    %edx, %es
> +       movl    %edx, %fs
> +       movl    %edx, %gs
> +       movl    %edx, %ss
>
>         /* Reload pgtables */
>         movl    %cr3, %eax
> @@ -157,6 +168,14 @@ SYM_DATA_START(efi32_boot_gdt)
>         .quad   0
>  SYM_DATA_END(efi32_boot_gdt)
>
> +SYM_DATA_START(efi32_boot_cs)
> +       .word   0
> +SYM_DATA_END(efi32_boot_cs)
> +
> +SYM_DATA_START(efi32_boot_ds)
> +       .word   0
> +SYM_DATA_END(efi32_boot_ds)
> +
>  SYM_DATA_START(efi_gdt64)
>         .word   efi_gdt64_end - efi_gdt64
>         .long   0                       /* Filled out by user */
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index bd44d89540d3..c56b30bd9c7b 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -54,10 +54,6 @@ SYM_FUNC_START(startup_32)
>          */
>         cld
>         cli
> -       movl    $(__BOOT_DS), %eax
> -       movl    %eax, %ds
> -       movl    %eax, %es
> -       movl    %eax, %ss
>
>  /*
>   * Calculate the delta between where we were compiled to run
> @@ -72,10 +68,20 @@ SYM_FUNC_START(startup_32)
>  1:     popl    %ebp
>         subl    $1b, %ebp
>
> +       /* Load new GDT with the 64bit segments using 32bit descriptor */
> +       addl    %ebp, gdt+2(%ebp)
> +       lgdt    gdt(%ebp)
> +
> +       /* Load segment registers with our descriptors */
> +       movl    $__BOOT_DS, %eax
> +       movl    %eax, %ds
> +       movl    %eax, %es
> +       movl    %eax, %fs
> +       movl    %eax, %gs
> +       movl    %eax, %ss
> +
>  /* setup a stack and make sure cpu supports long mode. */
> -       movl    $boot_stack_end, %eax
> -       addl    %ebp, %eax
> -       movl    %eax, %esp
> +       leal    boot_stack_end(%ebp), %esp
>
>         call    verify_cpu
>         testl   %eax, %eax
> @@ -112,10 +118,6 @@ SYM_FUNC_START(startup_32)
>   * Prepare for entering 64 bit mode
>   */
>
> -       /* Load new GDT with the 64bit segments using 32bit descriptor */
> -       addl    %ebp, gdt+2(%ebp)
> -       lgdt    gdt(%ebp)
> -
>         /* Enable PAE mode */
>         movl    %cr4, %eax
>         orl     $X86_CR4_PAE, %eax
> @@ -232,9 +234,13 @@ SYM_FUNC_START(efi32_stub_entry)
>
>         movl    %ecx, efi32_boot_args(%ebp)
>         movl    %edx, efi32_boot_args+4(%ebp)
> -       sgdtl   efi32_boot_gdt(%ebp)
>         movb    $0, efi_is64(%ebp)
>
> +       /* Save firmware GDTR and code/data selectors */
> +       sgdtl   efi32_boot_gdt(%ebp)
> +       movw    %cs, efi32_boot_cs(%ebp)
> +       movw    %ds, efi32_boot_ds(%ebp)
> +
>         /* Disable paging */
>         movl    %cr0, %eax
>         btrl    $X86_CR0_PG_BIT, %eax
> --
> 2.24.1
>
