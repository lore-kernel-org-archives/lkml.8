Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE39C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5432063A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tT8N+coB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388286AbgDAQyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:54:01 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60014 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388271AbgDAQbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tp5LnUbTw56wHyeSPmfUWY8H/MgTJs6JAtDGyeNVTzc=; b=tT8N+coBdBtUClsXB6A4SoeJZ
        hwlRmpnvuLLQSa/T0TnqqrvLH/3DFotSNFVmlrTgyuPyJWsTzc7J7rvDQmCHQePT2kqi/TW2iEcj5
        6/SJxWwR805Zf7N0TdPtnwWqeneYvKYjC/uPyeirSmOZAqVlWlFlWi9DkJgHv6Rcogd7aqsXgpuPZ
        0h2ij+q4rAVPqas/VGjPuxuuHCVEEHSEojiIeCk6nGtoLjqdYIJNrmnt8jaBSUYmberLkrqYshzAh
        npGj/8O0mvkybocAtlGF1CZ1kS7uwJKcHUriIQJfG4BkHDN0tOTzuFY7+pLT+ELJH+KawSG9NihKD
        9Ds2ZDuAA==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:60886)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jJgGc-0006uC-Kf; Wed, 01 Apr 2020 17:31:02 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jJgGb-0000pz-Ge; Wed, 01 Apr 2020 17:31:01 +0100
Date:   Wed, 1 Apr 2020 17:31:01 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH] ARM: exynos: update l2c_aux_mask to fix alert message
Message-ID: <20200401163101.GV25745@shell.armlinux.org.uk>
References: <b29f34870380093e6268c11d3033033d6def61b7.1585756648.git.guillaume.tucker@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b29f34870380093e6268c11d3033033d6def61b7.1585756648.git.guillaume.tucker@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 05:08:03PM +0100, Guillaume Tucker wrote:
> Allow setting the number of cycles for RAM reads in the pl310 cache
> controller L2 auxiliary control register mask (bits 0-2) since it
> needs to be changed in software.  This only affects exynos4210 and
> exynos4412 as they use the pl310 cache controller.
> 
> With the mask used until now, the following warnings were generated,
> the 2nd one being a pr_alert():
> 
>   L2C: platform modifies aux control register: 0x02070000 -> 0x3e470001
>   L2C: platform provided aux values permit register corruption.
> 
> This latency cycles value has always been set in software in spite of
> the warnings.  Keep it this way but clear the alert message about
> register corruption to acknowledge it is a valid thing to do.

This is telling you that you are doing something you should not be
doing.  The L2C controller should be configured by board firmware
first and foremost, because if, for example, u-boot makes use of the
L2 cache, or any other pre-main kernel code (in other words,
decompressor) the setup of the L2 controller will be wrong.

So, NAK.

> 
> Tested on exynos4412-odroid-x2.
> 
> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> ---
>  arch/arm/mach-exynos/exynos.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> index 7a8d1555db40..ed1bba49210d 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -194,7 +194,7 @@ static void __init exynos_dt_fixup(void)
>  
>  DT_MACHINE_START(EXYNOS_DT, "Samsung Exynos (Flattened Device Tree)")
>  	.l2c_aux_val	= 0x3c400001,
> -	.l2c_aux_mask	= 0xc20fffff,
> +	.l2c_aux_mask	= 0xc20ffff8,
>  	.smp		= smp_ops(exynos_smp_ops),
>  	.map_io		= exynos_init_io,
>  	.init_early	= exynos_firmware_init,
> -- 
> 2.20.1
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
