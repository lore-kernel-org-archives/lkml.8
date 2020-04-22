Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7B5C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B41220857
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgDVM4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:56:53 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33763 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgDVM4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:56:53 -0400
Received: by mail-oi1-f194.google.com with SMTP id m14so1808461oic.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 05:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zzvL78lEZJZZBFAXY+TFKarBpBEWri4b/Z4UmBJWwmg=;
        b=lhvCF0GzNRzwcgW/dubpmKYMvQth2BddJxYbxnGQyts8Lv413DACRkzfypPB8BKJXP
         0NMXEwvP0aMGBNIWxVLzdUQFq3Q1ulXn26NSbfU3e2jwk9EH+3LnltHJU6bIX8XzFUqf
         2qnta3QV6LlFYZE3Z7Rz8tvPQMP10G2uk596f9xXd3Aixdcxr0hix82zUkkU6FMuB8uc
         cM4brw+EAZf8AReWWBPq2FetnqXw0sgso02dnzZwWwaJkpw+mV6vB3SFWQVg7a6Rgvl7
         z//yS38Bv5iLMWuWF9w7ML0mOBbIM+jZv49OoQgWyv+hIilDtxi169ewQoPaGSw66Lgm
         y4Ew==
X-Gm-Message-State: AGi0Pua74Nl+P0rUxUfOIMvdItD7pWAs+cM2QmOXczwKm7G8T16X9GX7
        ptyVzldbI/fy2UUJt+QZ78XrlLNnSzMNXS11xjc=
X-Google-Smtp-Source: APiQypKlY9AL9oGCHqvsvq7HAWEqYxiJe7tzeW13eiPtbh5rx3VI9q+k/Vw2MPNuwYHJurl61ZqmAuVx/CG57PjPTFc=
X-Received: by 2002:aca:f541:: with SMTP id t62mr6438042oih.148.1587560212232;
 Wed, 22 Apr 2020 05:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200419191958.208600-1-masahiroy@kernel.org> <CAMuHMdXmJ3gfYzubQRbN6Bx0A=p8TodidmoeaZkJVtYjhDcQnw@mail.gmail.com>
 <CAK7LNAQ+3Jgf9sNUju3gTJvvRxUn6bM1r1A6j9HCTNmeOWXFzQ@mail.gmail.com>
In-Reply-To: <CAK7LNAQ+3Jgf9sNUju3gTJvvRxUn6bM1r1A6j9HCTNmeOWXFzQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 22 Apr 2020 14:56:40 +0200
Message-ID: <CAMuHMdUcFk0AW+A-=4MMWsLNX41cPopWjBcEh+Hn6OQT_gSv8g@mail.gmail.com>
Subject: Re: [PATCH v4] ARM: decompressor: simplify libfdt builds
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yamada-san,

On Wed, Apr 22, 2020 at 2:32 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> On Wed, Apr 22, 2020 at 4:44 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Sun, Apr 19, 2020 at 9:26 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > Copying source files during the build time may not end up with
> > > as clean code as expected.
> > >
> > > lib/fdt*.c simply wrap scripts/dtc/libfdt/fdt*.c, and it works
> > > nicely. Let's follow this approach for the arm decompressor, too.
> > >
> > > Add four wrappers, arch/arm/boot/compressed/fdt*.c and remove
> > > the Makefile messes. Another nice thing is we no longer need to
> > > maintain the own libfdt_env.h because the decompressor can include
> > > <linux/libfdt_env.h>.
> > >
> > > There is a subtle problem when generated files are turned into
> > > check-in files.
> > >
> > > When you are doing a rebuild of an existing object tree with O=
> > > option, there exists stale "shipped" copies that the old Makefile
> > > implementation created. The build system ends up with compiling the
> > > stale generated files because Make searches for prerequisites in the
> > > current directory, i.e. $(objtree) first, and then the directory
> > > listed in VPATH, i.e. $(srctree).
> > >
> > > To mend this issue, I added the following code:
> > >
> > >   ifdef building_out_of_srctree
> > >   $(shell rm -f $(addprefix $(obj)/, fdt_rw.c fdt_ro.c fdt_wip.c fdt.c))
> > >   endif
> > >
> > > This will need to stay for a while because "git bisect" crossing this
> > > commit, otherwise, would result in a build error.
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> >
> > This is now commit 365a6327cd643eed ("ARM: 8968/1: decompressor:
> > simplify libfdt builds") in arm/for-next.
> >
> > In light of reworking "[PATCH v5] ARM: boot: Obtain start of physical
> > memory from DTB"[1] on top of this, which would conditionally add
> > another source file to libfdt_objs, I have a few questions.
> >
> > > --- a/arch/arm/boot/compressed/Makefile
> > > +++ b/arch/arm/boot/compressed/Makefile
> > > @@ -76,29 +76,31 @@ compress-$(CONFIG_KERNEL_LZMA) = lzma
> > >  compress-$(CONFIG_KERNEL_XZ)   = xzkern
> > >  compress-$(CONFIG_KERNEL_LZ4)  = lz4
> > >
> > > -# Borrowed libfdt files for the ATAG compatibility mode
> > > -
> > > -libfdt         := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c
> > > -libfdt_hdrs    := fdt.h libfdt.h libfdt_internal.h
> > > -
> > > -libfdt_objs    := $(addsuffix .o, $(basename $(libfdt)))
> > > +ifeq ($(CONFIG_ARM_ATAG_DTB_COMPAT),y)
> > > +libfdt_objs = fdt_rw.o fdt_ro.o fdt_wip.o fdt.o atags_to_fdt.o
> > >
> >
> > I guess the code below can be moved out of the ifeq block, as it doesn't
> > really do anything if CONFIG_ARM_ATAG_DTB_COMPAT=n, and $(libfdt_objs)
> > becomes empty?
> > If not, I think I'll have to add a new Kconfig symbol ARM_BOOT_LIBFDT,
> > to be selected by ARM_ATAG_DTB_COMPAT and USE_OF.
>
>
>
> Right. We can narrow the ifeq block.
> I did not know your on-going work.
>
>
> If I had known your work adding one more file here,
> I would have written this part as follows:
>
>
> ------------------------------>8----------------------------------
> libfdt_objs := fdt_rw.o fdt_ro.o fdt_wip.o fdt.o
>
> ifeq ($(CONFIG_ARM_ATAG_DTB_COMPAT),y)
> OBJS += $(libfdt_objs) atags_to_fdt.o
> endif
>
> # -fstack-protector-strong triggers protection checks in this code,
> # but it is being used too early to link to meaningful stack_chk logic.
> nossp-flags-$(CONFIG_CC_HAS_STACKPROTECTOR_NONE) := -fno-stack-protector
> $(foreach o, $(libfdt_objs) atags_to_fdt.o, \
> $(eval CFLAGS_$(o) := -I $(srctree)/scripts/dtc/libfdt $(nossp-flags-y)))
>
> # These were previously generated C files. When you are building the kernel
> # with O=, make sure to remove the stale files in the output tree. Otherwise,
> # the build system wrongly compiles the stale ones.
> ifdef building_out_of_srctree
> $(shell rm -f $(addprefix $(obj)/, fdt_rw.c fdt_ro.c fdt_wip.c fdt.c))
> endif
> -------------------------------------->8-----------------------------

Thanks, looks good to me!

> So, how shall we move forward?
>
> Leave the necessary Makefile change to Geert?
>
> If Geert and Russell want to replace my patch,
> I can send v5 with the code above.

I can fix it myself when rebasing my patch, unless you get to a v5 before me.
I just wanted to find a good approach, to avoid delaying my patch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
