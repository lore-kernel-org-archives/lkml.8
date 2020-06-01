Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CB5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAEC720738
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lPZXaaaS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgFAOzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 10:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgFAOzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 10:55:21 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414F0C05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 07:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=U6svMtqcdNVZBeODbLBQ1meD+XZ/5XHSqOip4+ySlb8=; b=lPZXaaaSFtZMIifMSEnnbwo2h
        HbPwcaFT6JtRkMCO/OryCy5BAJzCLMNo3miJkXpqiOSfbNl3CznySB8ClclBky85ckywzPRJMQFlo
        TIyhQcFkNiKp+ApX8TE8E3wyXnrptK3+2NqojscdIKChGJChQyFMuUvnLUlqnv6r5isu9bsWbzKaA
        3Alp3Fn3MIApO2pYbrrmyyYyqOeVlcj/nLDqJWpA8aYkhPbUvRg/VIdNeDbfQD3txGqCSnXl3B47H
        BUi1WmQHVWJSdhyP/WSvN3lcCEIQ56LxT4W7zQWTn/P+TSnYmT4AvooEPO39BxM2601lPageK6yFk
        EamrnkQIA==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:48044)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jflqC-0000Z4-FT; Mon, 01 Jun 2020 15:55:04 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jflqA-0003Oh-6w; Mon, 01 Jun 2020 15:55:02 +0100
Date:   Mon, 1 Jun 2020 15:55:02 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ben Dooks <ben-linux@fluff.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 3/5] arm: decompressor: define a new zImage tag
Message-ID: <20200601145502.GJ1551@shell.armlinux.org.uk>
References: <20200601142754.26139-1-l.stelmach@samsung.com>
 <CGME20200601142810eucas1p1c42ff7c9b417f04bc506261726f08b4f@eucas1p1.samsung.com>
 <20200601142754.26139-4-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200601142754.26139-4-l.stelmach@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 04:27:52PM +0200, Łukasz Stelmach wrote:
> Add DCSZ tag which holds dynamic memory (stack, bss, malloc pool)
> requirements of the decompressor code.

Why do we need to know the stack and BSS size, when the userspace
kexec tool doesn't need to know this to perform the same function.

> 
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
> ---
>  arch/arm/boot/compressed/vmlinux.lds.S |  9 ++++++++-
>  arch/arm/include/asm/image.h           | 13 +++++++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
> index 308e9cd6a897..dcfdb3209c90 100644
> --- a/arch/arm/boot/compressed/vmlinux.lds.S
> +++ b/arch/arm/boot/compressed/vmlinux.lds.S
> @@ -39,6 +39,11 @@ SECTIONS
>      LONG(ARM_ZIMAGE_MAGIC3)
>      LONG(ZIMAGE_MAGIC(__piggy_size_addr - _start))
>      LONG(ZIMAGE_MAGIC(_kernel_bss_size))
> +    LONG(ZIMAGE_MAGIC(5))
> +    LONG(ARM_ZIMAGE_MAGIC4)
> +    LONG(ZIMAGE_MAGIC(_end - __bss_start))
> +    LONG(ZIMAGE_MAGIC(_stack_end - _stack_start))
> +    LONG(ZIMAGE_MAGIC(_malloc_size))
>      LONG(0)
>      _table_end = .;
>    }
> @@ -108,10 +113,12 @@ SECTIONS
>    . = BSS_START;
>    __bss_start = .;
>    .bss			: { *(.bss) }
> +  . = ALIGN(8);		/* the stack must be 64-bit aligned and adjoin bss */
>    _end = .;
>  
> -  . = ALIGN(8);		/* the stack must be 64-bit aligned */
> +  _stack_start = .;
>    .stack		: { *(.stack) }
> +  _stack_end = .;
>  
>    PROVIDE(__pecoff_data_size = ALIGN(512) - ADDR(.data));
>    PROVIDE(__pecoff_end = ALIGN(512));
> diff --git a/arch/arm/include/asm/image.h b/arch/arm/include/asm/image.h
> index d5c18a0f6a34..624438740f23 100644
> --- a/arch/arm/include/asm/image.h
> +++ b/arch/arm/include/asm/image.h
> @@ -15,6 +15,7 @@
>  #define ARM_ZIMAGE_MAGIC1 ZIMAGE_MAGIC(0x016f2818)
>  #define ARM_ZIMAGE_MAGIC2 (0x45454545)
>  #define ARM_ZIMAGE_MAGIC3 ZIMAGE_MAGIC(0x5a534c4b)
> +#define ARM_ZIMAGE_MAGIC4 ZIMAGE_MAGIC(0x5a534344)
>  
>  #ifndef __ASSEMBLY__
>  
> @@ -43,6 +44,18 @@ struct arm_zimage_tag {
>  	} u;
>  };
>  
> +struct arm_zimage_tag_dc {
> +	struct tag_header hdr;
> +	union {
> +#define ZIMAGE_TAG_DECOMP_SIZE ARM_ZIMAGE_MAGIC4
> +		struct zimage_decomp_size {
> +			__le32 bss_size;
> +			__le32 stack_size;
> +			__le32 malloc_size;
> +		} decomp_size;
> +	} u;
> +};
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* __ASM_IMAGE_H */
> -- 
> 2.26.2
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC for 0.8m (est. 1762m) line in suburbia: sync at 13.1Mbps down 424kbps up
