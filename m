Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88605C35670
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 02:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60719206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 02:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582509680;
	bh=axFW7bEh8+eVcpf/My/7t/8mqtcesmwale7L6FdGbQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oKldM1D5RyXl1QUQ6aQhq4HMyNm6PU0+bbR+wC1Ipayvj3LjahdvrouhfAu6k/a51
	 lQK1awVG5ahxHtoR7VvdWJQYwpWkaxnE7HPspthf0uLQGqOTA6ucwgWuHmRZaWfoPF
	 Rj98+uL1LbZPdYPVJ1s/SUciD9oFuQdo1e2E/0S0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbgBXCBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 21:01:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:53522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbgBXCBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 21:01:18 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 471FB205C9;
        Mon, 24 Feb 2020 02:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582509678;
        bh=axFW7bEh8+eVcpf/My/7t/8mqtcesmwale7L6FdGbQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L3qDPbiRb3tIg7oWaK/qPmhpSpgRp5fW8pJcQLlJO+kUCvsL0myrRhM3IiXNOfunh
         sBBNM0vUfP+hPr17+ttytHuxQICnKMia/w1TylUulL4Qzh0fXu0oxIpZL2tK/1eQzA
         kjjUlwmfjleDEYKsRk5KxfwtHRKOpKhswXb++wHg=
Date:   Mon, 24 Feb 2020 10:01:10 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        devicetree@vger.kernel.org, kernel@puri.sm,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: Re: [PATCH v2 3/9] arm64: dts: librem5-devkit: add the simcom 7100
 modem and sgtl5000 audio codec
Message-ID: <20200224020109.GE27688@dragon>
References: <20200218084942.4884-1-martin.kepplinger@puri.sm>
 <20200218084942.4884-4-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218084942.4884-4-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 09:49:36AM +0100, Martin Kepplinger wrote:
> From: "Angus Ainslie (Purism)" <angus@akkea.ca>
> 
> Add the simcomm modem and the sgtl5000 audio codec.
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  .../dts/freescale/imx8mq-librem5-devkit.dts   | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> index 25135b08d4f8..ec12477d925d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> @@ -148,6 +148,53 @@
>  		regulator-always-on;
>  	};
>  
> +	wwan_codec: sound-wwan-codec {
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
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&sai2>;
> +		};
> +
> +		simple-audio-card,codec {
> +			sound-dai = <&audio_codec>;
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

newline

> +		simple-audio-card,cpu {
> +			sound-dai = <&sai6>;
> +		};

newline

> +		telephony_link_master: simple-audio-card,codec {
> +			sound-dai = <&wwan_codec>;
> +			frame-master;
> +			bitclock-master;
> +		};
> +	};
> +
>  	vibrator {
>  		compatible = "gpio-vibrator";
>  		pinctrl-names = "default";
> @@ -426,6 +473,19 @@
>  		vddio-supply = <&reg_3v3_p>;
>  	};
>  
> +	audio_codec: sgtl5000@a {

Node name needs to be generic, not the label name.  So it should be:

	sgtl5000: audio-codec@a {

Shawn

> +		compatible = "fsl,sgtl5000";
> +		clocks = <&clk IMX8MQ_CLK_SAI2_ROOT>;
> +		assigned-clocks = <&clk IMX8MQ_CLK_SAI2>;
> +		assigned-clock-parents = <&clk IMX8MQ_AUDIO_PLL1_OUT>;
> +		assigned-clock-rates = <24576000>;
> +		#sound-dai-cells = <0>;
> +		reg = <0x0a>;
> +		VDDD-supply = <&reg_1v8_p>;
> +		VDDIO-supply = <&reg_3v3_p>;
> +		VDDA-supply = <&reg_3v3_p>;
> +	};
> +
>  	touchscreen@5d {
>  		compatible = "goodix,gt5688";
>  		reg = <0x5d>;
> -- 
> 2.20.1
> 
