Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FD4C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80858208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587558732;
	bh=dKXB2uO6mQCUzEUUTM+d+dpFVk1JgqnCx+z9loVO0P4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Sr8WyfkUmJ/+8Gxzgx62tt7nlTNIceLSe76/Y4HIDvmkgt6aFesIxlO2cg1hUaufR
	 ZYlk3PUW5Y6SLnUZOJDjHuax3D4fDlDwan9/m8fYkVMU48e5SBhfEoUWU980dZGweM
	 LISq8hIYQiwAGz4tuUPwdx5u8hsZrGVK6SPckUN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgDVMcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:32:08 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:32179 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgDVMcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:32:05 -0400
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 03MCVdHu003393
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 21:31:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 03MCVdHu003393
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587558700;
        bh=18U+KD98bGoEuR6HWpNpyNBYDarF4Eglb8nm1vLH1uM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A/dBfb+Rb7SEC0o38ZdVIvNh9O53R1nAOr2NDFimUJhc2fw8nXSDmyQr93f05iVTk
         1D0xtjCWgI2MFdvuQ5TwOEXdDP6lugWik4CbefGpsT08VxCicuR/Sq20unpWZh4cIE
         0NhkcPaqu/A75lJgNHJAhLorsOFCgQz1aYQjZM2yLfG0Kvriuks6D3k2TKp3QyL6un
         jAy3KPoVwjmmnqpalQzOw2KGFRsaQc4wrjzyS5c/AjS2zA8u07muomseUbWyICqzRG
         YBtO14Kyih5GgM7Z3njgZUHhANlwdH0Y+0f46bhepJojQjRJ0pHAwqHxF5jDPZjMuI
         H7HsnjRftqWUQ==
X-Nifty-SrcIP: [209.85.222.47]
Received: by mail-ua1-f47.google.com with SMTP id g10so1373129uae.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 05:31:40 -0700 (PDT)
X-Gm-Message-State: AGi0PuZlkHvosQTbLDd75vE+eCBKzMiLmnB4Rjuaj3ZhTu9oQ5nh041D
        /VbIcSYbsUU81va2SWtGzOAywSZ/+YsjDosBLb8=
X-Google-Smtp-Source: APiQypJ9exjhakXg2Zd4w+0mothFVo9SiU5pXO0nEEgqwxxyrfeuZ5MkvXiVsJT67jzlS06HguNuPV3c6AbphmaUeKo=
X-Received: by 2002:a67:e94d:: with SMTP id p13mr16329166vso.215.1587558699066;
 Wed, 22 Apr 2020 05:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200419191958.208600-1-masahiroy@kernel.org> <CAMuHMdXmJ3gfYzubQRbN6Bx0A=p8TodidmoeaZkJVtYjhDcQnw@mail.gmail.com>
In-Reply-To: <CAMuHMdXmJ3gfYzubQRbN6Bx0A=p8TodidmoeaZkJVtYjhDcQnw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 22 Apr 2020 21:30:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ+3Jgf9sNUju3gTJvvRxUn6bM1r1A6j9HCTNmeOWXFzQ@mail.gmail.com>
Message-ID: <CAK7LNAQ+3Jgf9sNUju3gTJvvRxUn6bM1r1A6j9HCTNmeOWXFzQ@mail.gmail.com>
Subject: Re: [PATCH v4] ARM: decompressor: simplify libfdt builds
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 4:44 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Yamada-san, Kees, Russell,
>
> -CC RMK's patch system
> +CC lakml
>
> On Sun, Apr 19, 2020 at 9:26 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > Copying source files during the build time may not end up with
> > as clean code as expected.
> >
> > lib/fdt*.c simply wrap scripts/dtc/libfdt/fdt*.c, and it works
> > nicely. Let's follow this approach for the arm decompressor, too.
> >
> > Add four wrappers, arch/arm/boot/compressed/fdt*.c and remove
> > the Makefile messes. Another nice thing is we no longer need to
> > maintain the own libfdt_env.h because the decompressor can include
> > <linux/libfdt_env.h>.
> >
> > There is a subtle problem when generated files are turned into
> > check-in files.
> >
> > When you are doing a rebuild of an existing object tree with O=
> > option, there exists stale "shipped" copies that the old Makefile
> > implementation created. The build system ends up with compiling the
> > stale generated files because Make searches for prerequisites in the
> > current directory, i.e. $(objtree) first, and then the directory
> > listed in VPATH, i.e. $(srctree).
> >
> > To mend this issue, I added the following code:
> >
> >   ifdef building_out_of_srctree
> >   $(shell rm -f $(addprefix $(obj)/, fdt_rw.c fdt_ro.c fdt_wip.c fdt.c))
> >   endif
> >
> > This will need to stay for a while because "git bisect" crossing this
> > commit, otherwise, would result in a build error.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> This is now commit 365a6327cd643eed ("ARM: 8968/1: decompressor:
> simplify libfdt builds") in arm/for-next.
>
> In light of reworking "[PATCH v5] ARM: boot: Obtain start of physical
> memory from DTB"[1] on top of this, which would conditionally add
> another source file to libfdt_objs, I have a few questions.
>
> > --- a/arch/arm/boot/compressed/Makefile
> > +++ b/arch/arm/boot/compressed/Makefile
> > @@ -76,29 +76,31 @@ compress-$(CONFIG_KERNEL_LZMA) = lzma
> >  compress-$(CONFIG_KERNEL_XZ)   = xzkern
> >  compress-$(CONFIG_KERNEL_LZ4)  = lz4
> >
> > -# Borrowed libfdt files for the ATAG compatibility mode
> > -
> > -libfdt         := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c
> > -libfdt_hdrs    := fdt.h libfdt.h libfdt_internal.h
> > -
> > -libfdt_objs    := $(addsuffix .o, $(basename $(libfdt)))
> > +ifeq ($(CONFIG_ARM_ATAG_DTB_COMPAT),y)
> > +libfdt_objs = fdt_rw.o fdt_ro.o fdt_wip.o fdt.o atags_to_fdt.o
> >
>
> I guess the code below can be moved out of the ifeq block, as it doesn't
> really do anything if CONFIG_ARM_ATAG_DTB_COMPAT=n, and $(libfdt_objs)
> becomes empty?
> If not, I think I'll have to add a new Kconfig symbol ARM_BOOT_LIBFDT,
> to be selected by ARM_ATAG_DTB_COMPAT and USE_OF.



Right. We can narrow the ifeq block.
I did not know your on-going work.


If I had known your work adding one more file here,
I would have written this part as follows:


------------------------------>8----------------------------------
libfdt_objs := fdt_rw.o fdt_ro.o fdt_wip.o fdt.o

ifeq ($(CONFIG_ARM_ATAG_DTB_COMPAT),y)
OBJS += $(libfdt_objs) atags_to_fdt.o
endif

# -fstack-protector-strong triggers protection checks in this code,
# but it is being used too early to link to meaningful stack_chk logic.
nossp-flags-$(CONFIG_CC_HAS_STACKPROTECTOR_NONE) := -fno-stack-protector
$(foreach o, $(libfdt_objs) atags_to_fdt.o, \
$(eval CFLAGS_$(o) := -I $(srctree)/scripts/dtc/libfdt $(nossp-flags-y)))

# These were previously generated C files. When you are building the kernel
# with O=, make sure to remove the stale files in the output tree. Otherwise,
# the build system wrongly compiles the stale ones.
ifdef building_out_of_srctree
$(shell rm -f $(addprefix $(obj)/, fdt_rw.c fdt_ro.c fdt_wip.c fdt.c))
endif
-------------------------------------->8-----------------------------




So, how shall we move forward?

Leave the necessary Makefile change to Geert?

If Geert and Russell want to replace my patch,
I can send v5 with the code above.



-- 
Best Regards
Masahiro Yamada
