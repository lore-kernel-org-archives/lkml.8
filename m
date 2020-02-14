Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6627AC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 03:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C3432187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 03:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581649460;
	bh=+I1VNRsZ6mWUl7yjg8iW9NTuGybpG3UgnjAdjCwz3ic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CDWlncnPrSWJlrV7OnQilIhxzIwn1t+vLJoKxYlXAk0mPI8ADB5lzyTkNA4rmMdGI
	 T7uWSmqB9wTyxT0/zkHYAJgwwz1tXy/Qewt5S2x+ZwfkuV+SEYKcfzt9jbYGq3sc8Q
	 ivAvNNYgJ6TdATMiIVCVaZxEgEGdbDMfvYLqk4Rk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgBNDET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 22:04:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:39216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727604AbgBNDET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 22:04:19 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F165F2168B;
        Fri, 14 Feb 2020 03:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581649459;
        bh=+I1VNRsZ6mWUl7yjg8iW9NTuGybpG3UgnjAdjCwz3ic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bRSLEz7I7/K3VqtF0M2R2NyvENXiY3sDn2SIk7ASR3xWL1JkeOBbygFpG/w7xCe6R
         3dVtdZ+e/jndq2Oq5aNyIECOfydLcfemhMWMv86S7ksSERC868vbJBYTFNDA+GWMwW
         32kfJ7qnYJqzFnNUglzaO833bB1pZW8kdztVxwK8=
Date:   Fri, 14 Feb 2020 11:04:11 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Robert Jones <rjones@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx: imx6qdl-gw553x.dtsi: add lsm9ds1 iio
 imu/magn support
Message-ID: <20200214030409.GJ22842@dragon>
References: <20200128221326.11393-1-rjones@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128221326.11393-1-rjones@gateworks.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 02:13:26PM -0800, Robert Jones wrote:
> Add one node for the accel/gyro i2c device and another for the separate
> magnetometer device in the lsm9ds1.
> 
> Signed-off-by: Robert Jones <rjones@gateworks.com>
> ---
>  arch/arm/boot/dts/imx6qdl-gw553x.dtsi | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-gw553x.dtsi b/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
> index a106689..305b2f0 100644
> --- a/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
> @@ -173,6 +173,25 @@
>  	pinctrl-0 = <&pinctrl_i2c2>;
>  	status = "okay";
>  
> +	lsm9ds1_m@1c {

Please use a generic node name?

> +		compatible = "st,lsm9ds1-magn";
> +		reg = <0x1c>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_mag>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <2 IRQ_TYPE_EDGE_RISING>;
> +	};
> +
> +	lsm9ds1_ag@6a {

Ditto

> +		compatible = "st,lsm9ds1-imu";
> +		reg = <0x6a>;
> +		st,drdy-int-pin = <1>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_acc_gyro>;
> +		interrupt-parent = <&gpio7>;
> +		interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
>  	ltc3676: pmic@3c {
>  		compatible = "lltc,ltc3676";
>  		reg = <0x3c>;
> @@ -462,6 +481,18 @@
>  		>;
>  	};
>  
> +	pinctrl_mag: maggrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_acc_gyro: acc_gyrogrp {

Sort pinctrl nodes alphabetically.  Also we generally do not use
underscore in node name.

Shawn

> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_18__GPIO7_IO13		0x1b0b0
> +		>;
> +	};
> +
>  	pinctrl_pps: ppsgrp {
>  		fsl,pins = <
>  			MX6QDL_PAD_ENET_RXD1__GPIO1_IO26	0x1b0b1
> -- 
> 2.9.2
> 
