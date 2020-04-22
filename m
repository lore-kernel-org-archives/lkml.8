Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219A9C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4DEB2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="u8k5H/L1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgDVMi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725839AbgDVMi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:38:27 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EDFC03C1A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 05:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=s3e/ImNCbheG0gCPqmXlxXQLvDBT5TzvXq/PHODmRsE=; b=u8k5H/L1ZmB7X7Z0TwRQmmncU
        gjOVYAybqT27s1vpVgKPKzqKI+s1hhA1ciP3GhCbDFatI/J04eb1M96uR9kB6Lj6y5p4am+9WzZWR
        s+U/3KmKz/UUH6jR5/+9BTLW1fe3GMRaGSSK1Cu72DTlPfq10gfaIrEfoL+i+jO1mMcqEgsr2S6QV
        RJchU/knLRtBtz85KrlUsqLHPuF0RB65IsFlhpn58TwDq1A+eA61BOfPGYCKdC5xRV9QFfFAZS0aT
        cunygnQmQVm/296yppRUwScRoRVs99rUnwmTuWUsvzeWVbKqgbfbPUv8MLUzNLLi9IXqrq/PH35XU
        et7+7NqJA==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:49598)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jREdr-0008CC-SK; Wed, 22 Apr 2020 13:38:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jREdl-00089l-R0; Wed, 22 Apr 2020 13:38:09 +0100
Date:   Wed, 22 Apr 2020 13:38:09 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4] ARM: decompressor: simplify libfdt builds
Message-ID: <20200422123809.GO25745@shell.armlinux.org.uk>
References: <20200419191958.208600-1-masahiroy@kernel.org>
 <CAMuHMdXmJ3gfYzubQRbN6Bx0A=p8TodidmoeaZkJVtYjhDcQnw@mail.gmail.com>
 <CAK7LNAQ+3Jgf9sNUju3gTJvvRxUn6bM1r1A6j9HCTNmeOWXFzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQ+3Jgf9sNUju3gTJvvRxUn6bM1r1A6j9HCTNmeOWXFzQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 09:30:58PM +0900, Masahiro Yamada wrote:
> On Wed, Apr 22, 2020 at 4:44 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Hi Yamada-san, Kees, Russell,
> >
> > -CC RMK's patch system
> > +CC lakml
> >
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
> 
> 
> 
> 
> So, how shall we move forward?
> 
> Leave the necessary Makefile change to Geert?
> 
> If Geert and Russell want to replace my patch,
> I can send v5 with the code above.

I've no problem with replacing your patch...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
