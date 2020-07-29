Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E9BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0319F2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cq1fhAjU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgG2OSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgG2OSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:18:05 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8F9C061794;
        Wed, 29 Jul 2020 07:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WCplLGbnmstGGGcwlSbpv1UAL8U4BtQOondsYh8OQRY=; b=cq1fhAjUIfhR5Za1W4qwDm0lw
        Fpub0UNYP8MIHFyezfaHDgCB9Q1l9Jn9hpzWD9AqsluLNwEH+Pm4A1IMG/L+bqIBxIQGaN/oPsrSm
        gkbj1Ztyjmo5jDmwfWsfLokTqDGSTMcpxyLjhvfC9Oj9F6/SC9idqweSRYRfoyqOgCjC+oc1UrodZ
        fkItLkUDv/F3i5QA6xtE0Y8tQDIgroY9iYlWnGJ2TWoRnfPvW0vyoN7SXD3WV5ROJvpdoVzrmiCA0
        I+YncW/AmeYVEIqlKcWLNIXfe8I9WoycgFWzisgkIlWMUBtYR65lNwugyvL0PaO1uIEZtoxNP+ixv
        RmeD/DESQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45708)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1k0muA-0005VQ-G7; Wed, 29 Jul 2020 15:18:02 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1k0muA-0005kW-2U; Wed, 29 Jul 2020 15:18:02 +0100
Date:   Wed, 29 Jul 2020 15:18:02 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, kernel@collabora.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ARM: l2c: update prefetch bits in L2X0_AUX_CTRL
 using DT value
Message-ID: <20200729141801.GB1551@shell.armlinux.org.uk>
References: <860eb8a1eed879e55daf960c96acdac514cbda93.1596028601.git.guillaume.tucker@collabora.com>
 <79a628daef56c2d542e379f550de21da4fe3c901.1596028601.git.guillaume.tucker@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79a628daef56c2d542e379f550de21da4fe3c901.1596028601.git.guillaume.tucker@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 02:47:32PM +0100, Guillaume Tucker wrote:
> The L310_PREFETCH_CTRL register bits 28 and 29 to enable data and
> instruction prefetch respectively can also be accessed via the
> L2X0_AUX_CTRL register.  They appear to be actually wired together in
> hardware between the registers.  Changing them in the prefetch
> register only will get undone when restoring the aux control register
> later on.  For this reason, set these bits in both registers during
> initialisation according to the DT attributes.

How will that happen?

We write the auxiliary control register before the prefetch control
register, so the prefetch control register will take precedence.  See
l2c310_configure() - l2c_configure() writes the auxiliary control
register, and the function writes the prefetch control register later.

I think the real issue is that Exynos has been modifying the prefetch
settings via its machine .aux_mask / .aux_val configuration, and the
opposite is actually true: the prefetch control register values will
overwrite the attempt to modify the auxiliary control values set through
the machine .aux_mask/.aux_val.

> 
> Fixes: ec3bd0e68a67 ("ARM: 8391/1: l2c: add options to overwrite prefetching behavior")
> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
> ---
>  arch/arm/mm/cache-l2x0.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index 12c26eb88afb..43d91bfd2360 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -1249,20 +1249,28 @@ static void __init l2c310_of_parse(const struct device_node *np,
>  
>  	ret = of_property_read_u32(np, "prefetch-data", &val);
>  	if (ret == 0) {
> -		if (val)
> +		if (val) {
>  			prefetch |= L310_PREFETCH_CTRL_DATA_PREFETCH;
> -		else
> +			*aux_val |= L310_PREFETCH_CTRL_DATA_PREFETCH;
> +		} else {
>  			prefetch &= ~L310_PREFETCH_CTRL_DATA_PREFETCH;
> +			*aux_val &= ~L310_PREFETCH_CTRL_DATA_PREFETCH;
> +		}
> +		*aux_mask &= ~L310_PREFETCH_CTRL_DATA_PREFETCH;
>  	} else if (ret != -EINVAL) {
>  		pr_err("L2C-310 OF prefetch-data property value is missing\n");
>  	}
>  
>  	ret = of_property_read_u32(np, "prefetch-instr", &val);
>  	if (ret == 0) {
> -		if (val)
> +		if (val) {
>  			prefetch |= L310_PREFETCH_CTRL_INSTR_PREFETCH;
> -		else
> +			*aux_val |= L310_PREFETCH_CTRL_INSTR_PREFETCH;
> +		} else {
>  			prefetch &= ~L310_PREFETCH_CTRL_INSTR_PREFETCH;
> +			*aux_val &= ~L310_PREFETCH_CTRL_INSTR_PREFETCH;
> +		}
> +		*aux_mask &= ~L310_PREFETCH_CTRL_INSTR_PREFETCH;
>  	} else if (ret != -EINVAL) {
>  		pr_err("L2C-310 OF prefetch-instr property value is missing\n");
>  	}
> -- 
> 2.20.1
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
