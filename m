Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6D3C35DE4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFDA620732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y9e4ZIE5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbgBXXaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 18:30:39 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33163 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbgBXXaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 18:30:39 -0500
Received: by mail-pg1-f196.google.com with SMTP id 6so5938319pgk.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 15:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZMfELxm44QBYo6rqimr2zJP2ICXy8S+lHokTgtg/D4E=;
        b=Y9e4ZIE5sYme6vUvmNceDkdcQi1HW6RxS/O7bdBL2efZiEFOoPlFp2fix/+QfBXf0H
         EE2ck+WCDQW2gXqsByg98LiFSO+ffvL9TZq43PeHnPAXbUp4/YKlH26meHvoP/ChIy6E
         3RArlP3A0Cv8NcjrvpVhFFF3u44a3UhlLnklcguHhMDxP9h5GI14G984+L4Y2R8DptdE
         2DiTiBc6oN3cR6M5nGciwHJZOKS/EMvGE03g/E7Et2J7x6vVpGlywddysND2+meThPrK
         aSA4FQU/XEpp0SYOaMPhw/GkQ/ohqAHUflYI4Li15KhXT/xqA1cOp3lOQ+peiqSeWt7l
         PTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZMfELxm44QBYo6rqimr2zJP2ICXy8S+lHokTgtg/D4E=;
        b=fQHMbBVwTFA6Dm04kmQ/STuX812GlkvA/s6ZodvLK4k/jvgKDZoNzhRTjVDoQyfQy1
         xPXO30iNZmzC7VWpe5pyL7KU9rdcQpE9rm1N31FygJYlhTSNcFsnDU6B3S1cL3/b0ZAw
         31GADqUu6MnpHvuPUNJNyQlGdCC1VqjTUhiXtckS2UDj+a+dlH3C4O/eBlNTRD9LcXSq
         im9XTc63Dvbih05JqBnxxKb/4kIcASz2zrURa76CIQSXUuL4jXa9hSHfZhTTEj+pyQ8p
         QEeAb3OoHYHGQrNJOJmtht0Hf03rCM1mGeonWvbG4JQbZkcTYUKHTzO7vkwfZoHOsijx
         7Neg==
X-Gm-Message-State: APjAAAVT1UlUGeBxUXGF15+L5qhlAuDCa0R+Q+D5FrSoyzVGcUmCqZna
        xOG/FZkTSMhIzQt0OkhIvohaQ3M8sg3WvOyPTuYIpg==
X-Google-Smtp-Source: APXvYqyaYgD8sF+7bCA4bKk2zu1PgTz4YvdEDHPuaaFjjEjglq/OVNho4DdMEfj698J9qe5fK5qBWwUr/aBynLmqA/w=
X-Received: by 2002:a63:4e22:: with SMTP id c34mr19298985pgb.263.1582587038117;
 Mon, 24 Feb 2020 15:30:38 -0800 (PST)
MIME-Version: 1.0
References: <CAKwvOdn6cxm9EpB7A9kLasttPwLY2csnhqgNAdkJ6_s2DP1-HA@mail.gmail.com>
 <20200224232129.597160-2-nivedita@alum.mit.edu>
In-Reply-To: <20200224232129.597160-2-nivedita@alum.mit.edu>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Feb 2020 15:30:27 -0800
Message-ID: <CAKwvOdkG-fFLce+1UNxRXSptkwWUJU9=MG2Pcd_SJiGUmhaHPg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arch/x86: Use -fno-asynchronous-unwind-tables to
 suppress .eh_frame sections
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
> While discussing a patch to discard .eh_frame from the compressed
> vmlinux using the linker script, Fangrui Song pointed out [1] that these
> sections shouldn't exist in the first place because arch/x86/Makefile
> uses -fno-asynchronous-unwind-tables.
>
> It turns out this is because the Makefiles used to build the compressed
> kernel redefine KBUILD_CFLAGS, dropping this flag.
>
> Add the flag to the Makefile for the compressed kernel, as well as the
> EFI stub Makefile to fix this.
>
> Also add the flag to boot/Makefile and realmode/rm/Makefile so that the
> kernel's boot code (boot/setup.elf) and realmode trampoline
> (realmode/rm/realmode.elf) won't be compiled with .eh_frame sections,
> since their linker scripts also just discard it.
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> Suggested-By: Fangrui Song <maskray@google.com>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> [1] https://lore.kernel.org/lkml/20200222185806.ywnqhfqmy67akfsa@google.com/
> ---
>  arch/x86/boot/Makefile                | 1 +
>  arch/x86/boot/compressed/Makefile     | 1 +
>  arch/x86/realmode/rm/Makefile         | 1 +
>  drivers/firmware/efi/libstub/Makefile | 3 ++-
>  4 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
> index 012b82fc8617..24f011e0adf1 100644
> --- a/arch/x86/boot/Makefile
> +++ b/arch/x86/boot/Makefile
> @@ -68,6 +68,7 @@ clean-files += cpustr.h
>  KBUILD_CFLAGS  := $(REALMODE_CFLAGS) -D_SETUP
>  KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
>  KBUILD_CFLAGS  += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
> +KBUILD_CFLAGS  += -fno-asynchronous-unwind-tables
>  GCOV_PROFILE := n
>  UBSAN_SANITIZE := n
>
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 26050ae0b27e..c33111341325 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -39,6 +39,7 @@ KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
>  KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
>  KBUILD_CFLAGS += -Wno-pointer-sign
>  KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
> +KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
>
>  KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
>  GCOV_PROFILE := n
> diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefile
> index 99b6332ba540..b11ec5d8f8ac 100644
> --- a/arch/x86/realmode/rm/Makefile
> +++ b/arch/x86/realmode/rm/Makefile
> @@ -71,5 +71,6 @@ $(obj)/realmode.relocs: $(obj)/realmode.elf FORCE
>  KBUILD_CFLAGS  := $(REALMODE_CFLAGS) -D_SETUP -D_WAKEUP \
>                    -I$(srctree)/arch/x86/boot
>  KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
> +KBUILD_CFLAGS  += -fno-asynchronous-unwind-tables
>  GCOV_PROFILE := n
>  UBSAN_SANITIZE := n
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 98a81576213d..a1140c4ee478 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -12,7 +12,8 @@ cflags-$(CONFIG_X86)          += -m$(BITS) -D__KERNEL__ -O2 \
>                                    -mno-mmx -mno-sse -fshort-wchar \
>                                    -Wno-pointer-sign \
>                                    $(call cc-disable-warning, address-of-packed-member) \
> -                                  $(call cc-disable-warning, gnu)
> +                                  $(call cc-disable-warning, gnu) \
> +                                  -fno-asynchronous-unwind-tables
>
>  # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
>  # disable the stackleak plugin
> --
> 2.24.1
>


-- 
Thanks,
~Nick Desaulniers
