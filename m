Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA47C3B194
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 02:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64542217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 02:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581647099;
	bh=9aNLoYnRCmB2kTD1dounOdkBMu8wUb3Wpo5I/7VnTRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cTTCjcA1koLez+rrEy520VyDGf/Z53rZz+fFQFHisesbdi331UxndWbE4uE+eY+k5
	 UYZmtVKXN9atb/GtYqog3JOYfej5cy2RhmhU0Q10VoiKi61BASQbayLCQKLYjKWUHH
	 Glsy2ERxXPU5YqvehZqtFAuC1jr1I0pLZTav3Wus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgBNCY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 21:24:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:58364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727604AbgBNCY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 21:24:58 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F6792168B;
        Fri, 14 Feb 2020 02:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581647097;
        bh=9aNLoYnRCmB2kTD1dounOdkBMu8wUb3Wpo5I/7VnTRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rWpkKX18iZG8yYDuJmt37sqyvvy/7FcW9xrmyixAoKlakGtAOb/sHSS23q4nnJ1wI
         lCvLN6329IIMorvhKjwayfrM83q1KKKK5fQtg+NC41QIeEewTw3LcHixdBSBN4uCUW
         cGQb2C2h0uoAXnDz75EG9wE2ofJirXyuG/cnGRSs=
Date:   Fri, 14 Feb 2020 10:24:51 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        Anson Huang <Anson.Huang@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mq-librem5-devkit: Add proximity sensor
Message-ID: <20200214022450.GD22842@dragon>
References: <e0434a87d8d46211a076c8a7c75c9f47b9e963c7.1579536647.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e0434a87d8d46211a076c8a7c75c9f47b9e963c7.1579536647.git.agx@sigxcpu.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 05:12:55PM +0100, Guido Günther wrote:
> Support for the vcnl4040 landet a while ago so add it and the
> corresponding pinmux. The irq is currently unused in the driver so don't
> configure it yet.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  .../boot/dts/freescale/imx8mq-librem5-devkit.dts     | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> index c8627f6614ae..b87c2e39b16c 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> @@ -448,6 +448,12 @@
>  		VDDIO-supply = <&reg_1v8_p>;
>  	};
>  
> +	prox@60 {

I changed node name to proximity-sensor and applied the patch.

Shawn

> +		compatible = "vishay,vcnl4040";
> +		reg = <0x60>;
> +		pinctrl-0 = <&pinctrl_prox>;
> +	};
> +
>  	accel-gyro@6a {
>  		compatible = "st,lsm9ds1-imu";
>  		reg = <0x6a>;
> @@ -550,6 +556,12 @@
>  		>;
>  	};
>  
> +	pinctrl_prox: proxgrp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_GPIO1_IO12_GPIO1_IO12	0x80  /* prox intr */
> +		>;
> +	};
> +
>  	pinctrl_pwr_en: pwrengrp {
>  		fsl,pins = <
>  			MX8MQ_IOMUXC_GPIO1_IO08_GPIO1_IO8	0x06
> -- 
> 2.23.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
