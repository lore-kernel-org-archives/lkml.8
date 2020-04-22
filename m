Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F27C5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F41B2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgDVHow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 03:44:52 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42689 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgDVHov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:44:51 -0400
Received: by mail-ot1-f67.google.com with SMTP id m18so1266759otq.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 00:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W8UTgb8AJJo1U8f4exnqk+Ltaibbt3oOSY4Baq5cKuw=;
        b=pkL1h5yNaPrUB5wxnyVMq/bacedbn9F1iV7ZfBRflXErkm/u80eDhV4KUycxmg7jM3
         gihNvmL5eGSFX+6+nt4tN76Q1N1t4eTi6wRVg/cLyqmXxQW+REGANFIt+3SATUei5scW
         4QB1YlKY44wbk2LJKhtOxSvqJRkEtaj7g/nK6oq6kM2FFTHUelUJ1oy8HhM1IWSqANKc
         cnIrCMo79aRnkFsQKG4s7nYuWvmd0KcicIkCaIgXks8gL/z4v3KDivPpJHJqeIetKRic
         7EhHK/TDTY+C56eV83qTD6Em4k9VnCWZROjt0fQd+whY5Y2nVPZ3EevzJEy/wMIyBKaF
         Ew8g==
X-Gm-Message-State: AGi0Puaq1yiCP3KvqZw0lDHoqLvOwkekvsrisVuUPxc33jtOQl44QChr
        /UtAix0pgSu8z160uvgsrI+bc0ZYgyRRAw8QMQA=
X-Google-Smtp-Source: APiQypIQuWSb/KptqNf0JYBzAoXNw5FdyLfnxWcWcL9WWkufg7XYfJEyF59W2Oyod1GqjmPbAgOwdUKzSAqLbd0VOFA=
X-Received: by 2002:a05:6830:3104:: with SMTP id b4mr13049588ots.250.1587541489795;
 Wed, 22 Apr 2020 00:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200419191958.208600-1-masahiroy@kernel.org>
In-Reply-To: <20200419191958.208600-1-masahiroy@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 22 Apr 2020 09:44:38 +0200
Message-ID: <CAMuHMdXmJ3gfYzubQRbN6Bx0A=p8TodidmoeaZkJVtYjhDcQnw@mail.gmail.com>
Subject: Re: [PATCH v4] ARM: decompressor: simplify libfdt builds
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yamada-san, Kees, Russell,

-CC RMK's patch system
+CC lakml

On Sun, Apr 19, 2020 at 9:26 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> Copying source files during the build time may not end up with
> as clean code as expected.
>
> lib/fdt*.c simply wrap scripts/dtc/libfdt/fdt*.c, and it works
> nicely. Let's follow this approach for the arm decompressor, too.
>
> Add four wrappers, arch/arm/boot/compressed/fdt*.c and remove
> the Makefile messes. Another nice thing is we no longer need to
> maintain the own libfdt_env.h because the decompressor can include
> <linux/libfdt_env.h>.
>
> There is a subtle problem when generated files are turned into
> check-in files.
>
> When you are doing a rebuild of an existing object tree with O=
> option, there exists stale "shipped" copies that the old Makefile
> implementation created. The build system ends up with compiling the
> stale generated files because Make searches for prerequisites in the
> current directory, i.e. $(objtree) first, and then the directory
> listed in VPATH, i.e. $(srctree).
>
> To mend this issue, I added the following code:
>
>   ifdef building_out_of_srctree
>   $(shell rm -f $(addprefix $(obj)/, fdt_rw.c fdt_ro.c fdt_wip.c fdt.c))
>   endif
>
> This will need to stay for a while because "git bisect" crossing this
> commit, otherwise, would result in a build error.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

This is now commit 365a6327cd643eed ("ARM: 8968/1: decompressor:
simplify libfdt builds") in arm/for-next.

In light of reworking "[PATCH v5] ARM: boot: Obtain start of physical
memory from DTB"[1] on top of this, which would conditionally add
another source file to libfdt_objs, I have a few questions.

> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -76,29 +76,31 @@ compress-$(CONFIG_KERNEL_LZMA) = lzma
>  compress-$(CONFIG_KERNEL_XZ)   = xzkern
>  compress-$(CONFIG_KERNEL_LZ4)  = lz4
>
> -# Borrowed libfdt files for the ATAG compatibility mode
> -
> -libfdt         := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c
> -libfdt_hdrs    := fdt.h libfdt.h libfdt_internal.h
> -
> -libfdt_objs    := $(addsuffix .o, $(basename $(libfdt)))
> +ifeq ($(CONFIG_ARM_ATAG_DTB_COMPAT),y)
> +libfdt_objs = fdt_rw.o fdt_ro.o fdt_wip.o fdt.o atags_to_fdt.o
>

I guess the code below can be moved out of the ifeq block, as it doesn't
really do anything if CONFIG_ARM_ATAG_DTB_COMPAT=n, and $(libfdt_objs)
becomes empty?
If not, I think I'll have to add a new Kconfig symbol ARM_BOOT_LIBFDT,
to be selected by ARM_ATAG_DTB_COMPAT and USE_OF.

> -$(addprefix $(obj)/,$(libfdt) $(libfdt_hdrs)): $(obj)/%: $(srctree)/scripts/dtc/libfdt/%
> -       $(call cmd,shipped)
> +OBJS   += $(libfdt_objs)
>
> -$(addprefix $(obj)/,$(libfdt_objs) atags_to_fdt.o): \
> -       $(addprefix $(obj)/,$(libfdt_hdrs))
> +# -fstack-protector-strong triggers protection checks in this code,
> +# but it is being used too early to link to meaningful stack_chk logic.
> +nossp-flags-$(CONFIG_CC_HAS_STACKPROTECTOR_NONE) := -fno-stack-protector
> +$(foreach o, $(libfdt_objs), \
> +       $(eval CFLAGS_$(o) := -I $(srctree)/scripts/dtc/libfdt $(nossp-flags-y)))

Is there a real reason this is only applied to a subset of the C object
files, and not to all of them? Or have we been lucky so far, by not
triggering the issue in decompressed.c, misc.c, and string.c (yet)?

Thanks!

> +
> +# These were previously generated C files. When you are building the kernel
> +# with O=, make sure to remove the stale files in the output tree. Otherwise,
> +# the build system wrongly compiles the stale ones.
> +ifdef building_out_of_srctree
> +$(shell rm -f $(addprefix $(obj)/, fdt_rw.c fdt_ro.c fdt_wip.c fdt.c))
> +endif
>
> -ifeq ($(CONFIG_ARM_ATAG_DTB_COMPAT),y)
> -OBJS   += $(libfdt_objs) atags_to_fdt.o
>  endif
>
>  targets       := vmlinux vmlinux.lds piggy_data piggy.o \
>                  lib1funcs.o ashldi3.o bswapsdi2.o \
>                  head.o $(OBJS)
>
> -clean-files += piggy_data lib1funcs.S ashldi3.S bswapsdi2.S \
> -               $(libfdt) $(libfdt_hdrs) hyp-stub.S
> +clean-files += piggy_data lib1funcs.S ashldi3.S bswapsdi2.S hyp-stub.S
>
>  KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
>
> @@ -107,15 +109,6 @@ ORIG_CFLAGS := $(KBUILD_CFLAGS)
>  KBUILD_CFLAGS = $(subst -pg, , $(ORIG_CFLAGS))
>  endif
>
> -# -fstack-protector-strong triggers protection checks in this code,
> -# but it is being used too early to link to meaningful stack_chk logic.
> -nossp-flags-$(CONFIG_CC_HAS_STACKPROTECTOR_NONE) := -fno-stack-protector
> -CFLAGS_atags_to_fdt.o := $(nossp-flags-y)
> -CFLAGS_fdt.o := $(nossp-flags-y)
> -CFLAGS_fdt_ro.o := $(nossp-flags-y)
> -CFLAGS_fdt_rw.o := $(nossp-flags-y)
> -CFLAGS_fdt_wip.o := $(nossp-flags-y)
> -
>  ccflags-y := -fpic $(call cc-option,-mno-single-pic-base,) -fno-builtin \
>              -I$(obj) $(DISABLE_ARM_SSP_PER_TASK_PLUGIN)
>  asflags-y := -DZIMAGE

[1] https://lore.kernel.org/r/20200415153409.30112-1-geert+renesas@glider.be

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
