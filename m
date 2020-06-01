Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EEFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED12D20738
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 14:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xJ3jMVda"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgFAO43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 10:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgFAO42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 10:56:28 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30843C05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 07:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nDf9cvm/ZefW9y6efpBbORsXzUNCnvBktxgDSUJOFe0=; b=xJ3jMVdaSmg2Ny7iJI06PVpl7
        SCS6f+oZDfUj0tkfF5DLpvqlKPdRpf1oDCW6w2N4xY8LHAMKQ27jM3FruT0cBSJGsF0iUMXZ5gz4l
        Frfyv4n59QLbmn9BqF/9v8aFUg8QZknM3BGdSEw8eklEHRwu/UMk00KY8muN3FPe+5MJNJmvyFYDW
        P7GutIGYA6/jn37IhfdMUzZYgM0zLD1U1BARdCSNYFMDnHAMJ0bnxiTj3d5hyfI5TIE5xV3fOm0OH
        WLUcluznY6uGxGFu3ZuNvly1dphT7bh0apG/41hfx4vv1vtaLxEBbxvM/co/7H6x2cMIluUzYpJbF
        tUn9zw3cw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39986)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jflrL-0000Zg-2t; Mon, 01 Jun 2020 15:56:15 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jflrK-0003Or-Gl; Mon, 01 Jun 2020 15:56:14 +0100
Date:   Mon, 1 Jun 2020 15:56:14 +0100
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
Subject: Re: [PATCH 4/5] arm: Add kexec_image_info
Message-ID: <20200601145614.GK1551@shell.armlinux.org.uk>
References: <20200601142754.26139-1-l.stelmach@samsung.com>
 <CGME20200601142811eucas1p260e5a434ea7743eecdb37c4d975c5f05@eucas1p2.samsung.com>
 <20200601142754.26139-5-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200601142754.26139-5-l.stelmach@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 04:27:53PM +0200, Łukasz Stelmach wrote:
> Add kexec_image_info to print detailed information about a kexec image.

Isn't this already visible through kexec debugging?  Why do we need
to duplicate the same output in the kernel?  Do we think that the
kexec interfaces are that fragile that they don't work?

> 
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
> ---
>  arch/arm/kernel/machine_kexec.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
> index 76300f3813e8..c10a2dfd53d1 100644
> --- a/arch/arm/kernel/machine_kexec.c
> +++ b/arch/arm/kernel/machine_kexec.c
> @@ -31,6 +31,32 @@ extern unsigned long kexec_boot_atags;
>  
>  static atomic_t waiting_for_crash_ipi;
>  
> +/**
> + * kexec_image_info - For debugging output.
> + */
> +#define kexec_image_info(_i) _kexec_image_info(__func__, __LINE__, _i)
> +static void _kexec_image_info(const char *func, int line,
> +	const struct kimage *kimage)
> +{
> +	unsigned long i;
> +
> +	pr_debug("%s:%d:\n", func, line);
> +	pr_debug("  kexec kimage info:\n");
> +	pr_debug("    type:        %d\n", kimage->type);
> +	pr_debug("    start:       %lx\n", kimage->start);
> +	pr_debug("    head:        %lx\n", kimage->head);
> +	pr_debug("    nr_segments: %lu\n", kimage->nr_segments);
> +
> +	for (i = 0; i < kimage->nr_segments; i++) {
> +		pr_debug("      segment[%lu]: %08lx - %08lx, 0x%x bytes, %lu pages\n",
> +			i,
> +			kimage->segment[i].mem,
> +			kimage->segment[i].mem + kimage->segment[i].memsz,
> +			kimage->segment[i].memsz,
> +			kimage->segment[i].memsz /  PAGE_SIZE);
> +	}
> +}
> +
>  /*
>   * Provide a dummy crash_notes definition while crash dump arrives to arm.
>   * This prevents breakage of crash_notes attribute in kernel/ksysfs.c.
> @@ -42,6 +68,8 @@ int machine_kexec_prepare(struct kimage *image)
>  	__be32 header;
>  	int i, err;
>  
> +	kexec_image_info(image);
> +
>  	image->arch.kernel_r2 = image->start - KEXEC_ARM_ZIMAGE_OFFSET
>  				     + KEXEC_ARM_ATAGS_OFFSET;
>  
> -- 
> 2.26.2
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC for 0.8m (est. 1762m) line in suburbia: sync at 13.1Mbps down 424kbps up
