Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D454C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 00:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE7A82098B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 00:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FiER0fGT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387871AbgFXAD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 20:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387584AbgFXAD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 20:03:58 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C0EC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 17:03:58 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 207so37284pfu.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 17:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+SQjl+fYaOOA7iax/1VNOoiac82rND2IfXd1aJY1eOE=;
        b=FiER0fGT2unX4ZU9P3ZO6CUBH546JZGoWyURLQUsdEoKBVzGFwZkr0ngXZU9nsej8T
         0oOE34S2bwEjZWzh2HN+7Ati3iMCoKCiwQWkL57iv/jj+WtaCHuGRLWL2g5wwIq93oKi
         i1ZNgoyxpye/vFw7MhBmUwQ/nosSM+s6AT2SvxgdT1xlQgQqD7TGC32qEAAzVUahFNA0
         Gx+tBVK0qlsUNFSc/nheRf74mXcFCVH7l6478AMemh0CbD2PrHR0hGGi/yxavNc/XANO
         Fg2fixzuBju3VOydvrNS3lFdzAhx8gBMAHKap3+jJb3yuESQ8CdM21+BiEbwdut3kmWd
         +9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+SQjl+fYaOOA7iax/1VNOoiac82rND2IfXd1aJY1eOE=;
        b=i31TkYjTGg2nTdR4lvhJPJGnHOfAnHnqFaOcQz9ixc/LLaNxPOC7kyqgT0+Y6lv5Cc
         zlCqR8dx71xws8vA9CiUTqxrPzPcdyDc3+c+Bq36C3ilQ68MTe5n5zw/pwWkhPnJAxws
         fTrWwGxqKFpSXTl/YzhnP40oR7sBRWZQRyGq18Z4QCyEdAFXZ7MNK/dhgTeC6MaH90Qa
         9OzKKDKy6yfrtROIODnke2oYfNF26sBYBxH6Hf8HkeLYq0Y24M5o9MZAon6V8rAPgTMm
         aS4ebyT714jfZR/tUTVRNICC4febuXl7roDcpWIadejZ6TYZnaDdNvDiIZa0xWp3eOsh
         Oz0w==
X-Gm-Message-State: AOAM532DlyIQzl3thbsYs5wqDjj6adWISDZ6M52MBqwgOTSmX6/9HvuM
        UH+yyAkBUUYZlyjfswT9XSlfSL79Tw1Y8AAIBPIEXA==
X-Google-Smtp-Source: ABdhPJzhTDXEfyQ+vp3g35XXKfBj6Qz6hImqLicmcdSpSSICKjET3Ddw3oMgewgqDdYsR87nEoHcF+QStIuovy2R/Nk=
X-Received: by 2002:aa7:9abc:: with SMTP id x28mr27075848pfi.39.1592957037887;
 Tue, 23 Jun 2020 17:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200622204915.2987555-1-keescook@chromium.org> <20200622204915.2987555-2-keescook@chromium.org>
In-Reply-To: <20200622204915.2987555-2-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 23 Jun 2020 17:03:46 -0700
Message-ID: <CAKwvOdmYa6V=W2eupEmHcuF8+479F8XHxm1NAo0s2N=sawbKAw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm/build: Warn on orphan section placement
To:     Kees Cook <keescook@chromium.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eli Friedman <efriedma@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 1:49 PM Kees Cook <keescook@chromium.org> wrote:
>
> We don't want to depend on the linker's orphan section placement
> heuristics as these can vary between linkers, and may change between
> versions. All sections need to be explicitly named in the linker
> script.
>
> Specifically, this would have made a recently fixed bug very obvious:
>
> ld: warning: orphan section `.fixup' from `arch/arm/lib/copy_from_user.o' being placed in section `.fixup'
>
> Refactor linker script include file for use in standard and XIP linker
> scripts, as well as in the coming boot linker script changes. Add debug
> sections explicitly. Create ARM_COMMON_DISCARD macro with unneeded
> sections .ARM.attributes, .iplt, .rel.iplt, .igot.plt, and .modinfo.
> Create ARM_STUBS_TEXT macro with missed text stub sections .vfp11_veneer,
> and .v4_bx. Finally enable orphan section warning.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/arm/Makefile                             |  4 ++++
>  .../arm/{kernel => include/asm}/vmlinux.lds.h | 22 ++++++++++++++-----
>  arch/arm/kernel/vmlinux-xip.lds.S             |  5 ++---
>  arch/arm/kernel/vmlinux.lds.S                 |  5 ++---
>  4 files changed, 25 insertions(+), 11 deletions(-)
>  rename arch/arm/{kernel => include/asm}/vmlinux.lds.h (92%)
>
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 59fde2d598d8..e414e3732b3a 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -16,6 +16,10 @@ LDFLAGS_vmlinux      += --be8
>  KBUILD_LDFLAGS_MODULE  += --be8
>  endif
>
> +# We never want expected sections to be placed heuristically by the
> +# linker. All sections should be explicitly named in the linker script.
> +LDFLAGS_vmlinux += --orphan-handling=warn
> +
>  ifeq ($(CONFIG_ARM_MODULE_PLTS),y)
>  KBUILD_LDS_MODULE      += $(srctree)/arch/arm/kernel/module.lds
>  endif
> diff --git a/arch/arm/kernel/vmlinux.lds.h b/arch/arm/include/asm/vmlinux.lds.h
> similarity index 92%
> rename from arch/arm/kernel/vmlinux.lds.h
> rename to arch/arm/include/asm/vmlinux.lds.h
> index 381a8e105fa5..3d88ea74f4cd 100644
> --- a/arch/arm/kernel/vmlinux.lds.h
> +++ b/arch/arm/include/asm/vmlinux.lds.h
> @@ -1,4 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> +#include <asm-generic/vmlinux.lds.h>
>
>  #ifdef CONFIG_HOTPLUG_CPU
>  #define ARM_CPU_DISCARD(x)
> @@ -37,6 +38,13 @@
>                 *(.idmap.text)                                          \
>                 __idmap_text_end = .;                                   \
>
> +#define ARM_COMMON_DISCARD                                             \
> +               *(.ARM.attributes)                                      \

I could have sworn that someone (Eli?) once told me that this section
(.ARM.attributes) is used for disambiguating which ARM version or
which optional extensions were used when compiling, and that without
this section, one would not be able to disassemble 32b ARM precisely.
If that's the case, we might not want to discard it?

In fact, in LLVM, I can see quite a few tests under
llvm/test/MC/ARM/directive-arch-armv*.s that reference
.ARM.attributes.  Looks like `{llvm|arm-linux-gnueabihf}-readelf
--arch-specific` can be used to dump these sections.  Though I also
only see code in LLVM's tree for writing this, not necessarily reading
it.  Only did a cursory scan of
llvm/lib/Target/ARM/AsmParser/ARMAsmParser.cpp.

Otherwise patch LGTM.

> +               *(.iplt) *(.rel.iplt) *(.igot.plt)                      \
> +               *(.modinfo)                                             \
> +               *(.discard)                                             \
> +               *(.discard.*)
> +
>  #define ARM_DISCARD                                                    \
>                 *(.ARM.exidx.exit.text)                                 \
>                 *(.ARM.extab.exit.text)                                 \
> @@ -49,8 +57,14 @@
>                 EXIT_CALL                                               \
>                 ARM_MMU_DISCARD(*(.text.fixup))                         \
>                 ARM_MMU_DISCARD(*(__ex_table))                          \
> -               *(.discard)                                             \
> -               *(.discard.*)
> +               ARM_COMMON_DISCARD
> +
> +#define ARM_STUBS_TEXT                                                 \
> +               *(.gnu.warning)                                         \
> +               *(.glue_7t)                                             \
> +               *(.glue_7)                                              \

This changes the order of .glue_7t relative to .glue_7.  Maybe that
doesn't matter.

> +               *(.vfp11_veneer)                                        \
> +               *(.v4_bx)
>
>  #define ARM_TEXT                                                       \
>                 IDMAP_TEXT                                              \
> @@ -64,9 +78,7 @@
>                 CPUIDLE_TEXT                                            \
>                 LOCK_TEXT                                               \
>                 KPROBES_TEXT                                            \
> -               *(.gnu.warning)                                         \
> -               *(.glue_7)                                              \
> -               *(.glue_7t)                                             \
> +               ARM_STUBS_TEXT                                          \
>                 . = ALIGN(4);                                           \
>                 *(.got)                 /* Global offset table */       \
>                 ARM_CPU_KEEP(PROC_INFO)
> diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
> index 6d2be994ae58..0807f40844a2 100644
> --- a/arch/arm/kernel/vmlinux-xip.lds.S
> +++ b/arch/arm/kernel/vmlinux-xip.lds.S
> @@ -9,15 +9,13 @@
>
>  #include <linux/sizes.h>
>
> -#include <asm-generic/vmlinux.lds.h>
> +#include <asm/vmlinux.lds.h>
>  #include <asm/cache.h>
>  #include <asm/thread_info.h>
>  #include <asm/memory.h>
>  #include <asm/mpu.h>
>  #include <asm/page.h>
>
> -#include "vmlinux.lds.h"
> -
>  OUTPUT_ARCH(arm)
>  ENTRY(stext)
>
> @@ -152,6 +150,7 @@ SECTIONS
>         _end = .;
>
>         STABS_DEBUG
> +       DWARF_DEBUG
>  }
>
>  /*
> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
> index 7f24bc08403e..969205f125ca 100644
> --- a/arch/arm/kernel/vmlinux.lds.S
> +++ b/arch/arm/kernel/vmlinux.lds.S
> @@ -9,15 +9,13 @@
>  #else
>
>  #include <linux/pgtable.h>
> -#include <asm-generic/vmlinux.lds.h>
> +#include <asm/vmlinux.lds.h>
>  #include <asm/cache.h>
>  #include <asm/thread_info.h>
>  #include <asm/memory.h>
>  #include <asm/mpu.h>
>  #include <asm/page.h>
>
> -#include "vmlinux.lds.h"
> -
>  OUTPUT_ARCH(arm)
>  ENTRY(stext)
>
> @@ -151,6 +149,7 @@ SECTIONS
>         _end = .;
>
>         STABS_DEBUG
> +       DWARF_DEBUG
>  }
>
>  #ifdef CONFIG_STRICT_KERNEL_RWX
> --
> 2.25.1
>


-- 
Thanks,
~Nick Desaulniers
