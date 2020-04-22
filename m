Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EEEC5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E2762070B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PuUhW6L3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgDVH7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 03:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725786AbgDVH7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:59:06 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F085EC03C1A6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 00:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=y8zwg/4nYCbTWpF0JCDU3rnEy9NBEw0BuwpBupWprWA=; b=PuUhW6L30ovlK0ErliYvZNjvE
        pmENsbjXK4bGEascDh/yz5T/4KfMUs3bzS5LVIOKqCkdNAJvN5JlffNTUX/PnZszHT4wyaByLW5MW
        YeJkVlGAftAguunBzmeal1yit+Oifw7Pb+ntH3JZ2oU/zS1M1FrIn5RDMtQcz8GCmrFZOW/25OHnD
        LuJ4CuTTIrD9K2zHAXL0Gs5na12PDkZa4fi+6qH7vVt56cT5GdgN3ErdGzIJ0rSIjzXqtKPGpbepw
        x0lO+PCJVGxnqaAB4p7Gp+4Fe9BAJlMB0TrAE2iF4L7/OakxIiPKg7V63N4O/Flxrv1N2GFQeU/Jy
        YtZb/+3hQ==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:42000)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jRAHX-0006mq-VF; Wed, 22 Apr 2020 08:58:56 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jRAHW-0007ya-6v; Wed, 22 Apr 2020 08:58:54 +0100
Date:   Wed, 22 Apr 2020 08:58:54 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] ARM: decompressor: simplify libfdt builds
Message-ID: <20200422075854.GK25745@shell.armlinux.org.uk>
References: <20200419191958.208600-1-masahiroy@kernel.org>
 <CAMuHMdXmJ3gfYzubQRbN6Bx0A=p8TodidmoeaZkJVtYjhDcQnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXmJ3gfYzubQRbN6Bx0A=p8TodidmoeaZkJVtYjhDcQnw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 09:44:38AM +0200, Geert Uytterhoeven wrote:
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
> 
> > -$(addprefix $(obj)/,$(libfdt) $(libfdt_hdrs)): $(obj)/%: $(srctree)/scripts/dtc/libfdt/%
> > -       $(call cmd,shipped)
> > +OBJS   += $(libfdt_objs)
> >
> > -$(addprefix $(obj)/,$(libfdt_objs) atags_to_fdt.o): \
> > -       $(addprefix $(obj)/,$(libfdt_hdrs))
> > +# -fstack-protector-strong triggers protection checks in this code,
> > +# but it is being used too early to link to meaningful stack_chk logic.
> > +nossp-flags-$(CONFIG_CC_HAS_STACKPROTECTOR_NONE) := -fno-stack-protector
> > +$(foreach o, $(libfdt_objs), \
> > +       $(eval CFLAGS_$(o) := -I $(srctree)/scripts/dtc/libfdt $(nossp-flags-y)))
> 
> Is there a real reason this is only applied to a subset of the C object
> files, and not to all of them? Or have we been lucky so far, by not
> triggering the issue in decompressed.c, misc.c, and string.c (yet)?

I don't remember the details. See commit 7f66cd3f5420, which came from
Kees which introduced this.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
