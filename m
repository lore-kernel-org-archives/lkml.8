Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C99C2BB85
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 10:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342D420787
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 10:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586515657;
	bh=U3wmJx6hLjdbpi9nNIeT1fEN5cdk/6ttAPKJ4Brye00=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=w6euTUlZ8tsHg3D2/Jy6/4uyntGPm7sPD8old3HJm9+7cFVf28g2QdJzP61xnpeWv
	 u9u7f//hQac0WGSiQ0zSHLudPTXaq+H6kg+oW0ABARWSCH1iGJ7DjaNURyH+45M7zq
	 ZyrdhwalrDrhBhJYLYYnXc0t6YUv+5QTpyzmpdFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgDJKrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 06:47:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgDJKrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 06:47:35 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 307AB20B1F;
        Fri, 10 Apr 2020 10:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586515655;
        bh=U3wmJx6hLjdbpi9nNIeT1fEN5cdk/6ttAPKJ4Brye00=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Kp997bcLfABP723lf8fm7ymzoCZy/BOcnjK6rtWodOzvp8kJN74/xyXNE0RPwAZnX
         ipCy6HSzeQykN+E0hK/HgtKDpuccoOP68HJoF4S+4bywrx6uMTA+sziQCSvnmwEMW2
         cym5bSmxRYBoYkThrYRtGNNvsrN8XqromYU8b5eI=
Received: by mail-io1-f46.google.com with SMTP id o127so1407982iof.0;
        Fri, 10 Apr 2020 03:47:35 -0700 (PDT)
X-Gm-Message-State: AGi0PubZqhTbdRFvt80OV6mKuRMgDwK1ZWxAHyciv/UTD1CFwXr9EJM5
        q57nY3o2HsVxeB82meJKul/UNDnbP7e7Y04JWeQ=
X-Google-Smtp-Source: APiQypKXvEl7sIHmBvdTO2/Sq82nNedbtcTWI9il5KSUN0FhnjNovFdxXB0laKwHoxVv+x13Op2+8K9kQu7VpjrjlQY=
X-Received: by 2002:a5d:8b57:: with SMTP id c23mr3679119iot.161.1586515654446;
 Fri, 10 Apr 2020 03:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200117224839.23531-1-f.fainelli@gmail.com> <20200117224839.23531-8-f.fainelli@gmail.com>
 <CAKv+Gu_6wWhi418=GpMjfMpE2E+XHbL-DYKT8MJ1jE3+VybrAg@mail.gmail.com>
In-Reply-To: <CAKv+Gu_6wWhi418=GpMjfMpE2E+XHbL-DYKT8MJ1jE3+VybrAg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 10 Apr 2020 12:47:23 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEmSk6Sq+WPAMc=x=HyP2EzVYbNYjB-4YSLByUurbXa0A@mail.gmail.com>
Message-ID: <CAMj1kXEmSk6Sq+WPAMc=x=HyP2EzVYbNYjB-4YSLByUurbXa0A@mail.gmail.com>
Subject: Re: [PATCH v7 7/7] ARM: Enable KASan for ARM
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Michal Hocko <mhocko@suse.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Abbott Liu <liuwenliang@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        kasan-dev <kasan-dev@googlegroups.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Jones <drjones@redhat.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Philip Derrin <philip@cog.systems>,
        Jinbum Park <jinb.park7@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Thomas Garnier <thgarnie@google.com>,
        Rob Landley <rob@landley.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin@virtuozzo.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+ Linus)

On Fri, 10 Apr 2020 at 12:45, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 17 Jan 2020 at 23:52, Florian Fainelli <f.fainelli@gmail.com> wrote:
> >
> > From: Andrey Ryabinin <ryabinin@virtuozzo.com>
> >
> > This patch enables the kernel address sanitizer for ARM. XIP_KERNEL has
> > not been tested and is therefore not allowed.
> >
> > Acked-by: Dmitry Vyukov <dvyukov@google.com>
> > Tested-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Abbott Liu <liuwenliang@huawei.com>
> > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > ---
> >  Documentation/dev-tools/kasan.rst     | 4 ++--
> >  arch/arm/Kconfig                      | 9 +++++++++
> >  arch/arm/boot/compressed/Makefile     | 1 +
> >  drivers/firmware/efi/libstub/Makefile | 3 ++-
> >  4 files changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> > index e4d66e7c50de..6acd949989c3 100644
> > --- a/Documentation/dev-tools/kasan.rst
> > +++ b/Documentation/dev-tools/kasan.rst
> > @@ -21,8 +21,8 @@ global variables yet.
> >
> >  Tag-based KASAN is only supported in Clang and requires version 7.0.0 or later.
> >
> > -Currently generic KASAN is supported for the x86_64, arm64, xtensa and s390
> > -architectures, and tag-based KASAN is supported only for arm64.
> > +Currently generic KASAN is supported for the x86_64, arm, arm64, xtensa and
> > +s390 architectures, and tag-based KASAN is supported only for arm64.
> >
> >  Usage
> >  -----
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 96dab76da3b3..70a7eb50984e 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -65,6 +65,7 @@ config ARM
> >         select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
> >         select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
> >         select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
> > +       select HAVE_ARCH_KASAN if MMU && !XIP_KERNEL
> >         select HAVE_ARCH_MMAP_RND_BITS if MMU
> >         select HAVE_ARCH_SECCOMP_FILTER if AEABI && !OABI_COMPAT
> >         select HAVE_ARCH_THREAD_STRUCT_WHITELIST
> > @@ -212,6 +213,14 @@ config ARCH_MAY_HAVE_PC_FDC
> >  config ZONE_DMA
> >         bool
> >
> > +config KASAN_SHADOW_OFFSET
> > +       hex
> > +       depends on KASAN
> > +       default 0x1f000000 if PAGE_OFFSET=0x40000000
> > +       default 0x5f000000 if PAGE_OFFSET=0x80000000
> > +       default 0x9f000000 if PAGE_OFFSET=0xC0000000
> > +       default 0xffffffff
> > +
> >  config ARCH_SUPPORTS_UPROBES
> >         def_bool y
> >
> > diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> > index 83991a0447fa..efda24b00a44 100644
> > --- a/arch/arm/boot/compressed/Makefile
> > +++ b/arch/arm/boot/compressed/Makefile
> > @@ -25,6 +25,7 @@ endif
> >
> >  GCOV_PROFILE           := n
> >  KASAN_SANITIZE         := n
> > +CFLAGS_KERNEL          += -D__SANITIZE_ADDRESS__
> >
> >  # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
> >  KCOV_INSTRUMENT                := n
> > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> > index c35f893897e1..c8b36824189b 100644
> > --- a/drivers/firmware/efi/libstub/Makefile
> > +++ b/drivers/firmware/efi/libstub/Makefile
> > @@ -20,7 +20,8 @@ cflags-$(CONFIG_ARM64)                := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> >                                    -fpie $(DISABLE_STACKLEAK_PLUGIN)
> >  cflags-$(CONFIG_ARM)           := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> >                                    -fno-builtin -fpic \
> > -                                  $(call cc-option,-mno-single-pic-base)
> > +                                  $(call cc-option,-mno-single-pic-base) \
> > +                                  -D__SANITIZE_ADDRESS__
> >
>
> I am not too crazy about this need to unconditionally 'enable' KASAN
> on the command line like this, in order to be able to disable it again
> when CONFIG_KASAN=y.
>
> Could we instead add something like this at the top of
> arch/arm/boot/compressed/string.c?
>
> #ifdef CONFIG_KASAN
> #undef memcpy
> #undef memmove
> #undef memset
> void *__memcpy(void *__dest, __const void *__src, size_t __n) __alias(memcpy);
> void *__memmove(void *__dest, __const void *__src, size_t count)
> __alias(memmove);
> void *__memset(void *s, int c, size_t count) __alias(memset);
> #endif
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
