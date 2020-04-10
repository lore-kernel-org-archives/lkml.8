Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B04FC2BB85
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 10:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 719F720787
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 10:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586515551;
	bh=UqujX8a43UgZ2wUq7+fHBdtk9fNTH/dOK9O/vJ62NsM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iwLVnVIjG9WMrGHGGTKl9XAfHLklJtWU5ElxWU7jIInf9+sHinBLVpZLDbVCQs7p1
	 E5Hc9J1i/3Fcgyl7jCIgpySKOmwFdPzKwgQghWRgOOl2GUxRJOL8gAfs7IvjO5T6ZE
	 xkeRRRyZxqmVhjLS/0r2SIBtKDhk84s/erNhei8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgDJKpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 06:45:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgDJKps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 06:45:48 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECCE121D6C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 10:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586515548;
        bh=UqujX8a43UgZ2wUq7+fHBdtk9fNTH/dOK9O/vJ62NsM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OTKASfANggkF37DxhfvdvwCPeTVJkE4IDlUmSzTKdXah4Elde0A1NoLT3z8pLzf+B
         aGPqOGTJrRgdOS5OX2sB7sklYAOnq5zqlZiHUQ5jNBFdiSaXCOYsPLSc7yKe3WKXg1
         cyRaJgVZRtEAdDkp4vIUasg3udPuVbRYmqYtmDgg=
Received: by mail-wm1-f46.google.com with SMTP id a201so1965101wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 03:45:47 -0700 (PDT)
X-Gm-Message-State: AGi0PuaHhb0IzxP2bx/KlODI13dxfyUeaGa8eYhhI23pzE9B37gvci8a
        H3GSVeg5WG2oKd/be7C93hN4uRmKwXmJb12RUrWi7A==
X-Google-Smtp-Source: APiQypLdUVvA7CnaTTssOnJwPrxl1HW+oM2zu/RKuq6utGp1zVYRYHMkZBBXsZe+0MrT9FW/+152MfO9CABs8P181vo=
X-Received: by 2002:a7b:c050:: with SMTP id u16mr4992457wmc.68.1586515545554;
 Fri, 10 Apr 2020 03:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200117224839.23531-1-f.fainelli@gmail.com> <20200117224839.23531-8-f.fainelli@gmail.com>
In-Reply-To: <20200117224839.23531-8-f.fainelli@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 10 Apr 2020 12:45:34 +0200
X-Gmail-Original-Message-ID: <CAKv+Gu_6wWhi418=GpMjfMpE2E+XHbL-DYKT8MJ1jE3+VybrAg@mail.gmail.com>
Message-ID: <CAKv+Gu_6wWhi418=GpMjfMpE2E+XHbL-DYKT8MJ1jE3+VybrAg@mail.gmail.com>
Subject: Re: [PATCH v7 7/7] ARM: Enable KASan for ARM
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Andrey Ryabinin <ryabinin@virtuozzo.com>,
        Abbott Liu <liuwenliang@huawei.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nicolas Pitre <nico@fluxnic.net>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Jinbum Park <jinb.park7@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Rob Landley <rob@landley.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Garnier <thgarnie@google.com>,
        David Howells <dhowells@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Philip Derrin <philip@cog.systems>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2020 at 23:52, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> From: Andrey Ryabinin <ryabinin@virtuozzo.com>
>
> This patch enables the kernel address sanitizer for ARM. XIP_KERNEL has
> not been tested and is therefore not allowed.
>
> Acked-by: Dmitry Vyukov <dvyukov@google.com>
> Tested-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Abbott Liu <liuwenliang@huawei.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  Documentation/dev-tools/kasan.rst     | 4 ++--
>  arch/arm/Kconfig                      | 9 +++++++++
>  arch/arm/boot/compressed/Makefile     | 1 +
>  drivers/firmware/efi/libstub/Makefile | 3 ++-
>  4 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index e4d66e7c50de..6acd949989c3 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -21,8 +21,8 @@ global variables yet.
>
>  Tag-based KASAN is only supported in Clang and requires version 7.0.0 or later.
>
> -Currently generic KASAN is supported for the x86_64, arm64, xtensa and s390
> -architectures, and tag-based KASAN is supported only for arm64.
> +Currently generic KASAN is supported for the x86_64, arm, arm64, xtensa and
> +s390 architectures, and tag-based KASAN is supported only for arm64.
>
>  Usage
>  -----
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 96dab76da3b3..70a7eb50984e 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -65,6 +65,7 @@ config ARM
>         select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
>         select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
>         select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
> +       select HAVE_ARCH_KASAN if MMU && !XIP_KERNEL
>         select HAVE_ARCH_MMAP_RND_BITS if MMU
>         select HAVE_ARCH_SECCOMP_FILTER if AEABI && !OABI_COMPAT
>         select HAVE_ARCH_THREAD_STRUCT_WHITELIST
> @@ -212,6 +213,14 @@ config ARCH_MAY_HAVE_PC_FDC
>  config ZONE_DMA
>         bool
>
> +config KASAN_SHADOW_OFFSET
> +       hex
> +       depends on KASAN
> +       default 0x1f000000 if PAGE_OFFSET=0x40000000
> +       default 0x5f000000 if PAGE_OFFSET=0x80000000
> +       default 0x9f000000 if PAGE_OFFSET=0xC0000000
> +       default 0xffffffff
> +
>  config ARCH_SUPPORTS_UPROBES
>         def_bool y
>
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index 83991a0447fa..efda24b00a44 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -25,6 +25,7 @@ endif
>
>  GCOV_PROFILE           := n
>  KASAN_SANITIZE         := n
> +CFLAGS_KERNEL          += -D__SANITIZE_ADDRESS__
>
>  # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
>  KCOV_INSTRUMENT                := n
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index c35f893897e1..c8b36824189b 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -20,7 +20,8 @@ cflags-$(CONFIG_ARM64)                := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
>                                    -fpie $(DISABLE_STACKLEAK_PLUGIN)
>  cflags-$(CONFIG_ARM)           := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
>                                    -fno-builtin -fpic \
> -                                  $(call cc-option,-mno-single-pic-base)
> +                                  $(call cc-option,-mno-single-pic-base) \
> +                                  -D__SANITIZE_ADDRESS__
>

I am not too crazy about this need to unconditionally 'enable' KASAN
on the command line like this, in order to be able to disable it again
when CONFIG_KASAN=y.

Could we instead add something like this at the top of
arch/arm/boot/compressed/string.c?

#ifdef CONFIG_KASAN
#undef memcpy
#undef memmove
#undef memset
void *__memcpy(void *__dest, __const void *__src, size_t __n) __alias(memcpy);
void *__memmove(void *__dest, __const void *__src, size_t count)
__alias(memmove);
void *__memset(void *s, int c, size_t count) __alias(memset);
#endif
