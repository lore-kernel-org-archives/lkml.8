Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0458C38BE0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 20:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CDF2218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 20:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZRHSZE7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbgBXUqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 15:46:04 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43701 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbgBXUqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 15:46:03 -0500
Received: by mail-pf1-f195.google.com with SMTP id s1so5946104pfh.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 12:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MEUjVJOmmnH8Vpry0d5ts1AnA+rtuK/pfVKzn69oCns=;
        b=ZRHSZE7cvsR8ZpuUv+0O/R6CEbotxvDzUTKr58Hu5rzAVvhc5byGevQLVKGfr3WYRS
         X7rvaAMMuyAAy11+scG8MQkejq/RMoDBKrT/gsnwHzc4uSHxtILLLZczYt7kQ4OvzxsV
         Z0S8qIe4VtwkrnPbdsFsKXclLTRiVLxYNgwlHkeS9YiaTk8xbH8o6VPHtX5q0b+HCWL8
         4xcQpSkdnZwJNj1veGMZSfm4m91IDsNo0htOJ0kCV1y9Qr6c7rbIRiXBpDoPjOYwKTUz
         MUIvnH/WP6X3u6A2SuRGG1vyXqfECTLIi7+bQC959qaY7FpXvMEgH5M/iznKjfT23Rrs
         3+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MEUjVJOmmnH8Vpry0d5ts1AnA+rtuK/pfVKzn69oCns=;
        b=Ue4FvMeV0D7zlTrUI9UPXnZ+QZe2M6iJvdrGJ6cVdIIJBAqi+33oaf6Eb8s7frd895
         j3GlMkP/dXcQfzkjUfMJa9C6bUa3cMTT4KSZfz+E8lyuxtHSCg7dFmeUZ66UYkVCOWZ+
         W2DRwCBi6Oj2ElS4mnnJAWXoMFJsWF3pXTx2RvTdk2N8b4m3b0wNARDjy3D2hHaOy7A4
         sJ/Fm1LwSfbh6FHcULrOUuleOUebBocUC7mvTF0HijVl1xQf06qItN6JwJ/3lXHRHndp
         LVr8r/Ewp59URrYnQHHQgLOs5skfwLm0RkPoZmpy91nl9mi1QPdVs9+17hJLRi8sgUcG
         hAkw==
X-Gm-Message-State: APjAAAUGrWLJcxDHRn6RQsOnKQuZ0tfkfdt8z3eUE1CRCxYAX4j+MC2F
        nL/YSxY/w5ABC15lKHN8bJSojEwqAC4hVkfwihVv/Q==
X-Google-Smtp-Source: APXvYqwYY1dqclugRmuGNa9VUAWt9QQ0+AQN7P4Oqc84Wto02XmTfN071m89dZO+NSy0VOc5Eu6L5g9dOb3pNc4TVUU=
X-Received: by 2002:a62:37c7:: with SMTP id e190mr53707489pfa.165.1582577162505;
 Mon, 24 Feb 2020 12:46:02 -0800 (PST)
MIME-Version: 1.0
References: <20200222235709.GA3786197@rani.riverdale.lan> <20200223193715.83729-3-nivedita@alum.mit.edu>
In-Reply-To: <20200223193715.83729-3-nivedita@alum.mit.edu>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Feb 2020 12:45:51 -0800
Message-ID: <CAKwvOdmqM5aHnDCyL62gmWV5wFrKwAEdkHq+HPnvp3ZYA=dtbg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arch/x86: Drop unneeded linker script discard of .eh_frame
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

On Sun, Feb 23, 2020 at 11:37 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Now that we don't generate .eh_frame sections for the files in setup.elf
> and realmode.elf, the linker scripts don't need the /DISCARD/ any more.
>
> Also remove the one in the main kernel linker script, since there are no
> .eh_frame sections already.

Yep, we could go even further and validate the object files post link
such that $(READELF) reported no .eh_frame section, suggesting the use
of -fno-asynchronous-unwind-tables in KBUILD_CFLAGS.

>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  arch/x86/boot/setup.ld              | 1 -
>  arch/x86/kernel/vmlinux.lds.S       | 3 ---
>  arch/x86/realmode/rm/realmode.lds.S | 1 -
>  3 files changed, 5 deletions(-)
>
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
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index e3296aa028fe..54f7b9f46446 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -412,9 +412,6 @@ SECTIONS
>         DWARF_DEBUG
>
>         DISCARDS
> -       /DISCARD/ : {
> -               *(.eh_frame)
> -       }
>  }

grepping for eh_frame in arch/x86/ there's a comment in
arch/x86/include/asm/dwarf2.h:
 40 #ifndef BUILD_VDSO
 41   /*
 42    * Emit CFI data in .debug_frame sections, not .eh_frame
sections.
 43    * The latter we currently just discard since we don't do DWARF
 44    * unwinding at runtime.  So only the offline DWARF information is
 45    * useful to anyone.  Note we should not use this directive if
 46    * vmlinux.lds.S gets changed so it doesn't discard .eh_frame.
 47    */
 48   .cfi_sections .debug_frame

add via:
commit 7b956f035a9ef ("x86/asm: Re-add parts of the manual CFI infrastructure")

https://sourceware.org/binutils/docs/as/CFI-directives.html#g_t_002ecfi_005fsections-section_005flist
is the manual's section on .cfi_sections directives, and states `The
default if this directive is not used is .cfi_sections .eh_frame.`.
So the comment is slightly stale since we're no longer explicitly
discarding .eh_frame in arch/x86/kernel/vmlinux.lds.S, rather
preventing the generation via -fno-asynchronous-unwind-tables in
KBUILD_CFLAGS (across a few different Makefiles).  Would you mind also
updating the comment in arch/x86/include/asm/dwarf2.h in a V2? The
rest of this patch LGTM.

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
