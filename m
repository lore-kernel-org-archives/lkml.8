Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50644C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35E6C2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730044AbgDTOkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:40:15 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37398 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgDTOkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:40:14 -0400
Received: by mail-ot1-f68.google.com with SMTP id z17so8285015oto.4;
        Mon, 20 Apr 2020 07:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O9anNXH8lnrBoiZV5ZnF8xymjSTiu/J0BmmiYL091dw=;
        b=EZYDMDxuDc3DOEnY3GTTY5SLhfAXtGRwnMK32Iau+frPNsqb1Np7aYbK4QJyI6iHgf
         FdDgkCCHEfIrWMVa87fNDFSbPE7Vu6wz2k1GDE87KrXJxX60O8ukVJ1Dyr8sgmGgofqt
         fa4TdHgNcblKDdFiCsHh9NiSbwRKK7+yYSKx8dIplHsV7mIyuk1BXEz0n8O2Yyqh4JG0
         GcOg3BE82eHfJ/Ub3L+FEaxOOjY70wbo8PxznwvNC0vTQHdLmnJfxF6UfjAgn4/Wqhmq
         Y9x8Iq8qJbH0bjQ9rOqwtqEyaJaqgaqsVfIoyAc1QfDXRvnSXnLFTR21bJno5dyjwgUN
         +9cQ==
X-Gm-Message-State: AGi0PuZWtW28F4+DB6EYUDhI4j+T/mT03v0ttJ+wQImFumU7KqC17qC0
        jdXOREbr7AMslmgHqfj7HeiA0F/7NEz1m1ZPF2s=
X-Google-Smtp-Source: APiQypLEeSMHr3nV2UgKkx5uoCnPpPqmbnttr9avyU86dHwB041tXKRqT0/S+rmbHer6cU7nRccyNn5kXR6L1wKSRZY=
X-Received: by 2002:a9d:76c7:: with SMTP id p7mr9633351otl.145.1587393613548;
 Mon, 20 Apr 2020 07:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200420123844.3998746-1-arnd@arndb.de>
In-Reply-To: <20200420123844.3998746-1-arnd@arndb.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Apr 2020 16:40:02 +0200
Message-ID: <CAMuHMdUZR9A+nCYL_uUOJt48FQnJTJ9eMwWUuV-Z0UWJZ8SaSA@mail.gmail.com>
Subject: Re: [PATCH 1/2] sh: remove sh5 support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux-sh list <linux-sh@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Magnus Damm <magnus.damm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, Apr 20, 2020 at 2:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
> sh5 never became a product and has probably never really worked.
>
> Remove it by recursively deleting all associated Kconfig options
> and all corresponding files.

Thanks a lot!

> For review purposes, this leaves out the files that can now be
> removed, in particular
>
>  arch/sh/drivers/pci/*-sh5.c
>  arch/sh/include/asm/*_64.h
>  arch/sh/include/uapi/asm/*_64.h
>  arch/sh/include/cpu-sh5/*
>  arch/sh/kernel/cpu/sh5/*
>  arch/sh/lib64/*
>  arch/sh/mm/*-sh5.c
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

A few nits below...

> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -62,7 +62,7 @@ config SUPERH
>           <http://www.linux-sh.org/>.
>
>  config SUPERH32

Why keep the SUPERH32 symbol?
Because you forgot to clean a few files?

    arch/sh/include/asm/bl_bit.h:#ifdef CONFIG_SUPERH32
    arch/sh/include/asm/cache_insns.h:#ifdef CONFIG_SUPERH32
    arch/sh/include/asm/checksum.h:#ifdef CONFIG_SUPERH32

> -       def_bool "$(ARCH)" = "sh"
> +       def_bool y
>         select ARCH_32BIT_OFF_T
>         select GUP_GET_PTE_LOW_HIGH if X2TLB
>         select HAVE_KPROBES

> --- a/arch/sh/include/asm/syscalls.h
> +++ b/arch/sh/include/asm/syscalls.h
> @@ -2,8 +2,6 @@
>  #ifndef __ASM_SH_SYSCALLS_H
>  #define __ASM_SH_SYSCALLS_H
>
> -#ifdef __KERNEL__

Unrelated change, but I guess it doesn't hurt ;-)

> -
>  asmlinkage int old_mmap(unsigned long addr, unsigned long len,
>                         unsigned long prot, unsigned long flags,
>                         int fd, unsigned long off);
> @@ -11,11 +9,6 @@ asmlinkage long sys_mmap2(unsigned long addr, unsigned long len,
>                           unsigned long prot, unsigned long flags,
>                           unsigned long fd, unsigned long pgoff);
>
> -#ifdef CONFIG_SUPERH32
> -# include <asm/syscalls_32.h>
> -#else
> -# include <asm/syscalls_64.h>
> -#endif
> +#include <asm/syscalls_32.h>
>
> -#endif /* __KERNEL__ */
>  #endif /* __ASM_SH_SYSCALLS_H */

> --- a/arch/sh/include/asm/vmlinux.lds.h
> +++ b/arch/sh/include/asm/vmlinux.lds.h
> @@ -15,12 +15,6 @@
>  #define DWARF_EH_FRAME
>  #endif
>
> -#ifdef CONFIG_SUPERH64
> -#define EXTRA_TEXT             \
> -       *(.text64)              \
> -       *(.text..SHmedia32)
> -#else
>  #define EXTRA_TEXT
> -#endif

You might remove the empty definition, too, as you removed the sole user...

> --- a/arch/sh/kernel/vmlinux.lds.S
> +++ b/arch/sh/kernel/vmlinux.lds.S

> @@ -28,14 +21,13 @@ SECTIONS
>
>         _text = .;              /* Text and read-only data */
>
> -       .empty_zero_page : AT(ADDR(.empty_zero_page) - LOAD_OFFSET) {
> +       .empty_zero_page : AT(ADDR(.empty_zero_page)) {
>                 *(.empty_zero_page)
>         } = 0
>
> -       .text : AT(ADDR(.text) - LOAD_OFFSET) {
> +       .text : AT(ADDR(.text)) {
>                 HEAD_TEXT
>                 TEXT_TEXT
> -               EXTRA_TEXT

... here.

>                 SCHED_TEXT
>                 CPUIDLE_TEXT
>                 LOCK_TEXT

I think at least some of the following should be cleant, too:

arch/sh/include/asm/elf.h:#ifdef __SH5__
arch/sh/include/uapi/asm/posix_types.h:# ifdef __SH5__
arch/sh/include/uapi/asm/swab.h:#ifdef __SH5__
arch/sh/include/uapi/asm/swab.h:#ifdef __SH5__
arch/sh/include/uapi/asm/unistd.h:# ifdef __SH5__
tools/arch/sh/include/asm/barrier.h:#if defined(__SH4A__) || defined(__SH5__)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
