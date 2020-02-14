Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9DAC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 03:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645EA2187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 03:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581649731;
	bh=hjaIkHAO1KvEz7zY4FR2SQIzlH3LDp1v7jaEbLGckhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tc2fAyh+BO1b4CmpsZR2VCETBjwHzucanN3suBWjZ4XnGUH7nWyQxJ/XnhqiAl9mh
	 gAjgz1JI1KCj8ctJOBFwQa+GSBs5iCpfRBQts9c/ovFTBh772VUW2RGRw0mXULNtfs
	 2cRsv3EyzcrWyGeYCKiopqVA9dB28clTfEeRTChc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgBNDIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 22:08:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:41042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727604AbgBNDIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 22:08:50 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 042252168B;
        Fri, 14 Feb 2020 03:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581649730;
        bh=hjaIkHAO1KvEz7zY4FR2SQIzlH3LDp1v7jaEbLGckhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fWjwqkF+s9n3Qw2LqeIfwsVgTdXrmLL+ldw+W9R3MQcJqR81+4SGP5TUYzTEswhNO
         Gn1hb5LD0f2gOYmxStpJePNqURFzsNsw7KlMiM2PDNNk0ozFTG9kvRyTu6bTAqCjez
         m5Uzlvgnb32Uyxccz71sRCQ47mZc12fZtbXFoQfI=
Date:   Fri, 14 Feb 2020 11:08:44 +0800
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
Subject: Re: [PATCH] ARM: dts: imx: ventana: add fxos8700 on gateworks boards
Message-ID: <20200214030843.GL22842@dragon>
References: <20200128221424.11481-1-rjones@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128221424.11481-1-rjones@gateworks.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 02:14:24PM -0800, Robert Jones wrote:
> Add fxos8700 iio imu entries for Gateworks ventana SBCs.
> 
> Signed-off-by: Robert Jones <rjones@gateworks.com>
> ---
>  arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 5 +++++
>  arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 5 +++++
>  arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 5 +++++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
> index 1a9a9d9..2d7d01e 100644
> --- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
> @@ -313,6 +313,11 @@
>  		interrupts = <12 2>;
>  		wakeup-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
>  	};
> +
> +	fxos8700@1e {

Use a generic node name, not the model name.

Shawn

> +		compatible = "nxp,fxos8700";
> +		reg = <0x1e>;
> +	};
>  };
>  
>  &ldb {
> diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
> index 54b2bea..bf1a2c6 100644
> --- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
> @@ -304,6 +304,11 @@
>  		interrupts = <11 2>;
>  		wakeup-gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
>  	};
> +
> +	fxos8700@1e {
> +		compatible = "nxp,fxos8700";
> +		reg = <0x1e>;
> +	};
>  };
>  
>  &ldb {
> diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
> index 1b6c133..d9e09a9 100644
> --- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
> @@ -361,6 +361,11 @@
>  		interrupts = <12 2>;
>  		wakeup-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
>  	};
> +
> +	fxos8700@1e {
> +		compatible = "nxp,fxos8700";
> +		reg = <0x1e>;
> +	};
>  };
>  
>  &ldb {
> -- 
> 2.9.2
> 
