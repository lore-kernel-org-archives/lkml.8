Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8774EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 13:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DBAC204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 13:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597671625;
	bh=DpLtEeCc7osoHKspUjh3s0M2UFGfAdKBrZ9NCbDLJus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Rabzl/8f1Hhx0DPy48FWiMf55IwAIyxw6xYCRN2u7/PinwlmmKbvbs+bt3rOfg1CY
	 rjundJBq+q/rwHk3MsvBt2uQ8AuH1lYmBydQrRZT3qsw1rUvnxTNU2ayc4OBY7rlcZ
	 idYRJTorSh69WX9r5dh7p7V6YpGGUMbnOUZ5xQFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbgHQNkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 09:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728388AbgHQNkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 09:40:11 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F76B204FD;
        Mon, 17 Aug 2020 13:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597671610;
        bh=DpLtEeCc7osoHKspUjh3s0M2UFGfAdKBrZ9NCbDLJus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X6klsXTpEEaXqfqTcVJypMXzfzu9JQ4TaCW/J3Tq/B1oovyfR9P4jk/Xsiz5AIOjr
         dNJmFX0fb4QyMDVanUJ2gbr1jdLdcZnLojOcoPrn3TmaOAl+8jzaZ8yramQa9sSE6i
         vDeNlv785AJ5Q+GXYwAdtudNncn2E0CYUNuhKayQ=
Date:   Mon, 17 Aug 2020 21:40:05 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx7d-sdb: Add notes for audio sound card
Message-ID: <20200817134003.GI16951@dragon>
References: <1595483016-8822-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595483016-8822-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 01:43:36PM +0800, Shengjiu Wang wrote:
> Configure the SAI device node, configure audio clock
> and pinctrl.
> 
> Enable the audio sound card, which use the SAI1 and
> wm8960, and enable headphone detection.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

s/notes/nodes in subject?

I fixed it up and applied the patch.

Shawn

> ---
>  arch/arm/boot/dts/imx7d-sdb.dts | 81 +++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
> index 17cca8a9f77b..b50b19f2d0f1 100644
> --- a/arch/arm/boot/dts/imx7d-sdb.dts
> +++ b/arch/arm/boot/dts/imx7d-sdb.dts
> @@ -146,6 +146,24 @@ panel_in: endpoint {
>  			};
>  		};
>  	};
> +
> +	sound {
> +		compatible = "fsl,imx7d-evk-wm8960",
> +			     "fsl,imx-audio-wm8960";
> +		model = "wm8960-audio";
> +		audio-cpu = <&sai1>;
> +		audio-codec = <&codec>;
> +		hp-det-gpio = <&gpio2 28 GPIO_ACTIVE_HIGH>;
> +		audio-routing =
> +			"Headphone Jack", "HP_L",
> +			"Headphone Jack", "HP_R",
> +			"Ext Spk", "SPK_LP",
> +			"Ext Spk", "SPK_LN",
> +			"Ext Spk", "SPK_RP",
> +			"Ext Spk", "SPK_RN",
> +			"LINPUT1", "AMIC",
> +			"AMIC", "MICB";
> +	};
>  };
>  
>  &adc1 {
> @@ -363,6 +381,13 @@ codec: wm8960@1a {
>  		clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_CLK>;
>  		clock-names = "mclk";
>  		wlf,shared-lrclk;
> +		wlf,hp-cfg = <2 2 3>;
> +		wlf,gpio-cfg = <1 3>;
> +		assigned-clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_SRC>,
> +				  <&clks IMX7D_PLL_AUDIO_POST_DIV>,
> +				  <&clks IMX7D_AUDIO_MCLK_ROOT_CLK>;
> +		assigned-clock-parents = <&clks IMX7D_PLL_AUDIO_POST_DIV>;
> +		assigned-clock-rates = <0>, <884736000>, <12288000>;
>  	};
>  };
>  
> @@ -391,6 +416,28 @@ &reg_1p2 {
>  	vin-supply = <&sw2_reg>;
>  };
>  
> +&sai1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai1>;
> +	assigned-clocks = <&clks IMX7D_SAI1_ROOT_SRC>,
> +			  <&clks IMX7D_PLL_AUDIO_POST_DIV>,
> +			  <&clks IMX7D_SAI1_ROOT_CLK>;
> +	assigned-clock-parents = <&clks IMX7D_PLL_AUDIO_POST_DIV>;
> +	assigned-clock-rates = <0>, <884736000>, <36864000>;
> +	status = "okay";
> +};
> +
> +&sai3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai3 &pinctrl_sai3_mclk>;
> +	assigned-clocks = <&clks IMX7D_SAI3_ROOT_SRC>,
> +			  <&clks IMX7D_PLL_AUDIO_POST_DIV>,
> +			  <&clks IMX7D_SAI3_ROOT_CLK>;
> +	assigned-clock-parents = <&clks IMX7D_PLL_AUDIO_POST_DIV>;
> +	assigned-clock-rates = <0>, <884736000>, <36864000>;
> +	status = "okay";
> +};
> +
>  &snvs_pwrkey {
>  	status = "okay";
>  };
> @@ -550,6 +597,7 @@ MX7D_PAD_SD2_WP__GPIO5_IO10		0x59
>  		pinctrl_hog: hoggrp {
>  			fsl,pins = <
>  				MX7D_PAD_ECSPI2_SS0__GPIO4_IO23		0x34  /* bt reg on */
> +				MX7D_PAD_EPDC_BDR0__GPIO2_IO28		0x59  /* headphone detect */
>  			>;
>  		};
>  
> @@ -615,6 +663,33 @@ MX7D_PAD_LCD_RESET__LCD_RESET		0x79
>  			>;
>  		};
>  
> +		pinctrl_sai1: sai1grp {
> +			fsl,pins = <
> +				MX7D_PAD_SAI1_MCLK__SAI1_MCLK           0x1f
> +				MX7D_PAD_ENET1_RX_CLK__SAI1_TX_BCLK     0x1f
> +				MX7D_PAD_ENET1_CRS__SAI1_TX_SYNC	0x1f
> +				MX7D_PAD_ENET1_COL__SAI1_TX_DATA0	0x30
> +				MX7D_PAD_ENET1_TX_CLK__SAI1_RX_DATA0	0x1f
> +			>;
> +		};
> +
> +		pinctrl_sai2: sai2grp {
> +			fsl,pins = <
> +				MX7D_PAD_SAI2_TX_BCLK__SAI2_TX_BCLK     0x1f
> +				MX7D_PAD_SAI2_TX_SYNC__SAI2_TX_SYNC     0x1f
> +				MX7D_PAD_SAI2_TX_DATA__SAI2_TX_DATA0    0x30
> +				MX7D_PAD_SAI2_RX_DATA__SAI2_RX_DATA0    0x1f
> +			>;
> +		};
> +
> +		pinctrl_sai3: sai3grp {
> +			fsl,pins = <
> +				MX7D_PAD_UART3_TX_DATA__SAI3_TX_BCLK   0x1f
> +				MX7D_PAD_UART3_CTS_B__SAI3_TX_SYNC     0x1f
> +				MX7D_PAD_UART3_RTS_B__SAI3_TX_DATA0    0x30
> +			>;
> +		};
> +
>  		pinctrl_spi4: spi4grp {
>  			fsl,pins = <
>  				MX7D_PAD_GPIO1_IO09__GPIO1_IO9	0x59
> @@ -776,4 +851,10 @@ pinctrl_usb_otg2_vbus_reg: usbotg2vbusreggrp {
>  			MX7D_PAD_LPSR_GPIO1_IO07__GPIO1_IO7	  0x14
>  		>;
>  	};
> +
> +	pinctrl_sai3_mclk: sai3grp_mclk {
> +		fsl,pins = <
> +			MX7D_PAD_LPSR_GPIO1_IO03__SAI3_MCLK	0x1f
> +		>;
> +	};
>  };
> -- 
> 2.27.0
> 
