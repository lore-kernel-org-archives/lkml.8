Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645F8C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 22:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EBF721D7D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 22:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UNk3YGiN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgAQWPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 17:15:39 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:50232 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgAQWPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 17:15:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SMbahnT/3TNTcGhSxCVvAMEn2xKSeJz9qPB7q7BC5OA=; b=UNk3YGiN1aR7PqotwWDdY28I2
        ky70czk41LpR41AV32uspJTvFuwDsQifisxAZd3QpmMQcuyVGUL8X2HzKpjYPosLL9GAZFPOX0QyX
        tupb2EjTgZ9doweAXekhMwj9u494SzY588OYVkIZhOc0Rh41T2oHhaG5EapU3/eb2Na1afh0Eygad
        NVM4QXT19TN2PYgCPfBP9OPHJyDFU+IDkhh9aPuVt44bUFmZU1nIfWIPsnhes0/QRAWZtdVKf2dbB
        uExI7QvG+V3UmPoALVCYxOd7QffzVY2Iq2FWo0AGAlFrzp21MTi7JHNufY4n6Phbwd+5eVjQq6lpS
        aX70iUNmg==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:56288)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1isZtu-0007Mw-UI; Fri, 17 Jan 2020 22:15:35 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1isZtu-0000Ep-A5; Fri, 17 Jan 2020 22:15:34 +0000
Date:   Fri, 17 Jan 2020 22:15:34 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: decompressor: simplify libfdt builds
Message-ID: <20200117221534.GR25745@shell.armlinux.org.uk>
References: <20191204044950.10418-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204044950.10418-1-masahiroy@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 01:49:50PM +0900, Masahiro Yamada wrote:
> Copying source files during the build time may not end up with
> as clean code as expected.
> 
> lib/fdt*.c simply wrap scripts/dtc/libfdt/fdt*.c, and it works
> nicely. Let's follow that approach for the arm decompressor, too.
> 
> Add four wrappers, arch/arm/boot/compressed/fdt*.c and remove
> the Makefile messes. Another nice thing is we no longer need to
> maintain the own libfdt_env.h because the decompressor can include
> <linux/libfdt_env.h>.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> KernelVersion: v5.5-rc1
> 
> 
>  arch/arm/boot/compressed/.gitignore     |  9 -------
>  arch/arm/boot/compressed/Makefile       | 33 +++++++------------------
>  arch/arm/boot/compressed/atags_to_fdt.c |  1 +
>  arch/arm/boot/compressed/fdt.c          |  1 +
>  arch/arm/boot/compressed/fdt_ro.c       |  1 +
>  arch/arm/boot/compressed/fdt_rw.c       |  1 +
>  arch/arm/boot/compressed/fdt_wip.c      |  1 +
>  arch/arm/boot/compressed/libfdt_env.h   | 24 ------------------
>  8 files changed, 14 insertions(+), 57 deletions(-)
>  create mode 100644 arch/arm/boot/compressed/fdt.c
>  create mode 100644 arch/arm/boot/compressed/fdt_ro.c
>  create mode 100644 arch/arm/boot/compressed/fdt_rw.c
>  create mode 100644 arch/arm/boot/compressed/fdt_wip.c
>  delete mode 100644 arch/arm/boot/compressed/libfdt_env.h
> 
> diff --git a/arch/arm/boot/compressed/.gitignore b/arch/arm/boot/compressed/.gitignore
> index 86b2f5d28240..2fdb4885846b 100644
> --- a/arch/arm/boot/compressed/.gitignore
> +++ b/arch/arm/boot/compressed/.gitignore
> @@ -6,12 +6,3 @@ hyp-stub.S
>  piggy_data
>  vmlinux
>  vmlinux.lds
> -
> -# borrowed libfdt files
> -fdt.c
> -fdt.h
> -fdt_ro.c
> -fdt_rw.c
> -fdt_wip.c
> -libfdt.h
> -libfdt_internal.h
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index da599c3a1193..d01ce71afac6 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -76,29 +76,23 @@ compress-$(CONFIG_KERNEL_LZMA) = lzma
>  compress-$(CONFIG_KERNEL_XZ)   = xzkern
>  compress-$(CONFIG_KERNEL_LZ4)  = lz4
>  
> -# Borrowed libfdt files for the ATAG compatibility mode
> -
> -libfdt		:= fdt_rw.c fdt_ro.c fdt_wip.c fdt.c
> -libfdt_hdrs	:= fdt.h libfdt.h libfdt_internal.h
> -
> -libfdt_objs	:= $(addsuffix .o, $(basename $(libfdt)))
> -
> -$(addprefix $(obj)/,$(libfdt) $(libfdt_hdrs)): $(obj)/%: $(srctree)/scripts/dtc/libfdt/%
> -	$(call cmd,shipped)
> +ifeq ($(CONFIG_ARM_ATAG_DTB_COMPAT),y)
> +libfdt_objs = fdt_rw.o fdt_ro.o fdt_wip.o fdt.o atags_to_fdt.o
>  
> -$(addprefix $(obj)/,$(libfdt_objs) atags_to_fdt.o): \
> -	$(addprefix $(obj)/,$(libfdt_hdrs))
> +OBJS	+= $(libfdt_objs)
>  
> -ifeq ($(CONFIG_ARM_ATAG_DTB_COMPAT),y)
> -OBJS	+= $(libfdt_objs) atags_to_fdt.o
> +# -fstack-protector-strong triggers protection checks in this code,
> +# but it is being used too early to link to meaningful stack_chk logic.
> +nossp-flags-$(CONFIG_CC_HAS_STACKPROTECTOR_NONE) := -fno-stack-protector
> +$(foreach o, $(libfdt_objs), \
> +	$(eval CFLAGS_$(o) := -I $(srctree)/scripts/dtc/libfdt) $(nossp-flags-y))

The above change causes build breakage over a number of ARM builds,
which unfortunately doesn't result in emails from any build system
containing the cause of the failure.

See
https://kernelci.org/build/rmk/branch/for-next/kernel/v5.5-rc1-12-g9a6545e2fc83/

where the failures are reported as:

../arch/arm/boot/compressed/Makefile:87: *** missing separator. Stop.

Thanks.  Patch dropped.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
