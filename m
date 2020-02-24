Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5B4C35DE6
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D0421556
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZH0IMObb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgBXXeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 18:34:08 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41617 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgBXXeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 18:34:08 -0500
Received: by mail-pf1-f196.google.com with SMTP id j9so6161865pfa.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 15:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XFUwyglKUk6D3XnYFci54N4jRavS/ro7uLfU4m/GniE=;
        b=ZH0IMObbBzdbEvGLMiR+AhQjZGn/KBdMbVAUeo871hTKbVzyvOmqjAdj6St5uBXTzW
         WgLB0byK5ETSpcf5NIZAZY2jCOr/zMPBRp/nld3flkLd9hr/nJkErmSW0wkNMmAw2xjt
         NGlcdOCaeo7/OVWl/W2grC68GnqjCQkSHMnML1q5CnEmUhdTWBtCGPFhiCLP4M3ULCG1
         fcr1JXGGh1tKrLKTfrDnUULqzmuERWuhFWtz4fCIrdSciumxtzDm4/pV/p2x2aZ4ivIm
         w279KDWJw7mItg1JRpfAgNV+LYeE5oryl09+C4uDZFVCeEuHnXofk4F82z9hvaK4rBu3
         uiiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XFUwyglKUk6D3XnYFci54N4jRavS/ro7uLfU4m/GniE=;
        b=Dx91cFOlU9q4/1gmPKj/wBe/14ceD4+BKe66CxoL01jkt2AMu8BvAPGyUSt6PR0t4H
         uKPkVhZdYN03g5SjaV6+fP72KxR8h3G2klIUdJlOiXVFPG/D4Gm4AYBHVQ1F0S4qIOHS
         vincDRVInVTl3pjp3bXJZVQO2ZDpGX9deYne08g34BVyn6CGt5Mj3CpK7S/pb63yWuGT
         QAcYwpNHynHdAULkV4QvuhPyMw3RWWT6W3KbgFbLhuaPM4DuLjwWHyj1T7IPscRPSLV+
         D0Fwp+upI+/J3Scxbehu1JKwaudfG/MjwbEa1lyH/HsLu8Y4ulIDMqtk/G2ZjGLWJa/r
         gabw==
X-Gm-Message-State: APjAAAUgkguGGpoAeY2KVJQzEqJzhVcGlWI8ya2/zdxG+f/VOTszcT5F
        nR+JKj532sohuCYNpzJWySY/hrHpdj5z8KeDXwB+qw==
X-Google-Smtp-Source: APXvYqxssqGs7Cd1lrmBD20nEdXSsZWmF/sgEBDu1IZKtH0aM8k0IbjBxLCTR7C85yydryXFiH8QMgo2MmZ1VqHnMgk=
X-Received: by 2002:a62:37c7:: with SMTP id e190mr54344990pfa.165.1582587246762;
 Mon, 24 Feb 2020 15:34:06 -0800 (PST)
MIME-Version: 1.0
References: <CAKwvOdn6cxm9EpB7A9kLasttPwLY2csnhqgNAdkJ6_s2DP1-HA@mail.gmail.com>
 <20200224232129.597160-3-nivedita@alum.mit.edu>
In-Reply-To: <20200224232129.597160-3-nivedita@alum.mit.edu>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Feb 2020 15:33:55 -0800
Message-ID: <CAKwvOdm1yGkYtiqHqDvi_e+jSdbp102AbPsaXG42fR4Tyw42Aw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arch/x86: Drop unneeded linker script discard of .eh_frame
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Michael Matz <matz@suse.de>, Fangrui Song <maskray@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 3:21 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Now that we don't generate .eh_frame sections for the files in setup.elf
> and realmode.elf, the linker scripts don't need the /DISCARD/ any more.
>
> Remove the one in the main kernel linker script as well, since there are
> no .eh_frame sections already, and fix up a comment referencing .eh_frame.
>
> Update the comment in asm/dwarf2.h referring to .eh_frame so it continues
> to make sense, as well as being more specific.
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Thanks for cleaning up the comments.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/x86/boot/compressed/vmlinux.lds.S | 5 -----
>  arch/x86/boot/setup.ld                 | 1 -
>  arch/x86/include/asm/dwarf2.h          | 4 ++--
>  arch/x86/kernel/vmlinux.lds.S          | 7 ++-----
>  arch/x86/realmode/rm/realmode.lds.S    | 1 -
>  5 files changed, 4 insertions(+), 14 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> index 469dcf800a2c..508cfa6828c5 100644
> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> @@ -73,9 +73,4 @@ SECTIONS
>  #endif
>         . = ALIGN(PAGE_SIZE);   /* keep ZO size page aligned */
>         _end = .;
> -
> -       /* Discard .eh_frame to save some space */
> -       /DISCARD/ : {
> -               *(.eh_frame)
> -       }
>  }
> diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
> index 3da1c37c6dd5..24c95522f231 100644
> --- a/arch/x86/boot/setup.ld
> +++ b/arch/x86/boot/setup.ld
> @@ -52,7 +52,6 @@ SECTIONS
>         _end = .;
>
>         /DISCARD/       : {
> -               *(.eh_frame)
>                 *(.note*)
>         }
>
> diff --git a/arch/x86/include/asm/dwarf2.h b/arch/x86/include/asm/dwarf2.h
> index ae391f609840..f71a0cce9373 100644
> --- a/arch/x86/include/asm/dwarf2.h
> +++ b/arch/x86/include/asm/dwarf2.h
> @@ -42,8 +42,8 @@
>          * Emit CFI data in .debug_frame sections, not .eh_frame sections.
>          * The latter we currently just discard since we don't do DWARF
>          * unwinding at runtime.  So only the offline DWARF information is
> -        * useful to anyone.  Note we should not use this directive if
> -        * vmlinux.lds.S gets changed so it doesn't discard .eh_frame.
> +        * useful to anyone.  Note we should not use this directive if we
> +        * ever decide to enable DWARF unwinding at runtime.
>          */
>         .cfi_sections .debug_frame
>  #else
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index e3296aa028fe..5cab3a29adcb 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -313,8 +313,8 @@ SECTIONS
>
>         . = ALIGN(8);
>         /*
> -        * .exit.text is discard at runtime, not link time, to deal with
> -        *  references from .altinstructions and .eh_frame
> +        * .exit.text is discarded at runtime, not link time, to deal with
> +        *  references from .altinstructions
>          */
>         .exit.text : AT(ADDR(.exit.text) - LOAD_OFFSET) {
>                 EXIT_TEXT
> @@ -412,9 +412,6 @@ SECTIONS
>         DWARF_DEBUG
>
>         DISCARDS
> -       /DISCARD/ : {
> -               *(.eh_frame)
> -       }
>  }
>
>
> diff --git a/arch/x86/realmode/rm/realmode.lds.S b/arch/x86/realmode/rm/realmode.lds.S
> index 64d135d1ee63..63aa51875ba0 100644
> --- a/arch/x86/realmode/rm/realmode.lds.S
> +++ b/arch/x86/realmode/rm/realmode.lds.S
> @@ -71,7 +71,6 @@ SECTIONS
>         /DISCARD/ : {
>                 *(.note*)
>                 *(.debug*)
> -               *(.eh_frame*)
>         }
>
>  #include "pasyms.h"
> --
> 2.24.1
>


-- 
Thanks,
~Nick Desaulniers
