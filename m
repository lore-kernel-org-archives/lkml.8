Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6F5C35242
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5545821744
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581911955;
	bh=o2FZuDF+s0lgyoH3wJzVZ5K7NvTZWMeJj/DeeTi4Y3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bm8jtOapKKZljZcHUCLK0foppMxubOYBZqRB8t7Wh94OMkjEbuH+wFrKd8rIv5lMd
	 +1SNGHznEf/cJ4GXsE9XLOVciWtr80O9ByoPEpkoKjuIcSCuFsZUKvyn3FR6wLFXPv
	 Iwxnh4Mnly0AUk2uX1AEUt6eS0kq8jdoDKfArsfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgBQD7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 22:59:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:36590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbgBQD7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 22:59:13 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E62542072C;
        Mon, 17 Feb 2020 03:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581911952;
        bh=o2FZuDF+s0lgyoH3wJzVZ5K7NvTZWMeJj/DeeTi4Y3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1NQroVDNjPZS+vQNS1YYNhBkwLMGowdfVeG0E2kk6it4e04DF3BAeL8tcgRLb1yFl
         jFIxNhHD0f9wM4r34isWAUVl6rI7xqAqtRzbrWu9LVV1vL+o7u72U6AkuRTcujN2qT
         6Y+Pf/0YRDCKa6EQ6dKVJKrI7Ujamzmk/KqQU61M=
Date:   Mon, 17 Feb 2020 11:59:02 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, devicetree@vger.kernel.org, kernel@puri.sm,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: Re: [PATCH v1 02/12] arm64: dts: librem5-devkit: add the simcom 7100
 modem and audio
Message-ID: <20200217035902.GC5395@dragon>
References: <20200205143003.28408-1-martin.kepplinger@puri.sm>
 <20200205143003.28408-3-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205143003.28408-3-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 03:29:53PM +0100, Martin Kepplinger wrote:
> From: "Angus Ainslie (Purism)" <angus@akkea.ca>
> 
> Add the simcomm modem and the sai6 interface that connects it, as well
> as the sgtl5000 audio codec.
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>

When you forward a patch from others, you need to add your SoB.


> ---
>  .../dts/freescale/imx8mq-librem5-devkit.dts   | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> index 9702db69d3ed..8162576e8f3d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> @@ -148,6 +148,51 @@
>  		regulator-always-on;
>  	};
>  
> +	sim7100_codec: sound-wwan-codec {
> +		compatible = "option,gtm601";
> +		#sound-dai-cells = <0>;
> +	};
> +
> +	sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "sgtl5000";
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,widgets =
> +			"Microphone", "Microphone Jack",
> +			"Headphone", "Headphone Jack",
> +			"Speaker", "Speaker Ext",
> +			"Line", "Line In Jack";
> +		simple-audio-card,routing =
> +			"MIC_IN", "Microphone Jack",
> +			"Microphone Jack", "Mic Bias",
> +			"LINE_IN", "Line In Jack",
> +			"Headphone Jack", "HP_OUT",
> +			"Speaker Ext", "LINE_OUT";

Please have a newline between properties and child node.

> +		simple-audio-card,cpu {
> +			sound-dai = <&sai2>;
> +		};

Also have a newline between nodes.

Shawn

> +		simple-audio-card,codec {
> +			sound-dai = <&sgtl5000>;
> +			clocks = <&clk IMX8MQ_CLK_SAI2_ROOT>;
> +			frame-master;
> +			bitclock-master;
> +		};
> +	};
> +
> +	sound-wwan {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "SIMCom SIM7100";
> +		simple-audio-card,format = "dsp_a";
> +		simple-audio-card,cpu {
> +			sound-dai = <&sai6>;
> +		};
> +		telephony_link_master: simple-audio-card,codec {
> +			sound-dai = <&sim7100_codec>;
> +			frame-master;
> +			bitclock-master;
> +		};
> +	};
> +
>  	vibrator {
>  		compatible = "gpio-vibrator";
>  		pinctrl-names = "default";
> @@ -749,6 +794,16 @@
>  	status = "okay";
>  };
>  
> +&sai6 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai6>;
> +	assigned-clocks = <&clk IMX8MQ_CLK_SAI6>;
> +	assigned-clock-parents = <&clk IMX8MQ_AUDIO_PLL1_OUT>;
> +	assigned-clock-rates = <24576000>;
> +	fsl,sai-synchronous-rx;
> +	status = "okay";
> +};
> +
>  &uart1 { /* console */
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_uart1>;
> -- 
> 2.20.1
> 
