Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E59C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E60721532
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599640483;
	bh=21LxBOTrKH0j+egIc6/B0p/g/nvYShniy58Zvs7itDM=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=tBMBMTNWn0QvCGf3Nhmnd5Ri7aq06AJ10vMbtqihH8dQcWMK1L3eqy9tLu7HhZW9d
	 NDkmEq4XtlWUxR4zJEezifkp5ApbDB4MY3n6UISoFtx8h510Y30xHWUCczK+/GQ1ie
	 ECxhPLWmwCIZFizuoSBsBqu6VlvloPnUJfFhP/+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgIIIel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:34:41 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:45769 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgIIIek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:34:40 -0400
Received: by mail-ej1-f68.google.com with SMTP id i26so2283053ejb.12;
        Wed, 09 Sep 2020 01:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vsALB+bxuuEP7Stns5jLN4qt786xLJXYhZvHFA9movY=;
        b=XSf68dHX7NAWM4nzgtejdreYFS8CJQ3ikO4MFMFfcxO6Y+tdjDe2tB0O1K4sUaovBI
         /Bitupjop/7i9/+xc1wyMfyn2yuj4ulAJf8C8VOyYOpopPj6w6QDL/4CBZDC/KPqhORu
         hA3G98yTqRcUwkKWNbtfp5ARmY1kd90v6tm+nAp0jaVrR3+ZAaIJmk8gKrseQTULXZXs
         FcqxRTkfcwbIoEi1AMzCGn5UYweSFuoO+QPRpEvO6DZcXBlxvQ2TG6wpXCDW3K2C1PRt
         /LeLstgTYWRj/5FFbZeXU64AeDh63g1/4pHO+qdGIzjC9GnBozyZrdK1eheRslTykF4d
         uuCA==
X-Gm-Message-State: AOAM5335XkngKzU1Qtff2hlouG5rQqjgO4Qfxw2c3Ydk+kkIhZnBaU0v
        840PeWQ/cbY1ZvRuZ04o1Lw=
X-Google-Smtp-Source: ABdhPJzNWdfEaEJMrGWJQ6SgVZ2LZkowL8XUPe1AidTLBAqeR320x6AIAcMg2mNv6uF3Dy3F+cwHGw==
X-Received: by 2002:a17:906:1b55:: with SMTP id p21mr2628419ejg.457.1599640477647;
        Wed, 09 Sep 2020 01:34:37 -0700 (PDT)
Received: from kozik-lap ([194.230.155.174])
        by smtp.googlemail.com with ESMTPSA id b13sm1320130edf.89.2020.09.09.01.34.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Sep 2020 01:34:36 -0700 (PDT)
Date:   Wed, 9 Sep 2020 10:34:34 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Adam Ford <aford173@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Alifer Moraes <alifer.wsdm@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Kever Yang <kever.yang@rock-chips.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 3/8] arm64: dts: imx8mm: Correct interrupt flags in
 examples
Message-ID: <20200909083434.GB11775@kozik-lap>
References: <20200908150241.5771-1-krzk@kernel.org>
 <20200908150241.5771-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200908150241.5771-3-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 05:02:36PM +0200, Krzysztof Kozlowski wrote:
> GPIO_ACTIVE_x flags are not correct in the context of interrupt flags.
> These are simple defines so they could be used in DTS but they will not
> have the same meaning:
> 1. GPIO_ACTIVE_HIGH = 0 = IRQ_TYPE_NONE
> 2. GPIO_ACTIVE_LOW  = 1 = IRQ_TYPE_EDGE_RISING
> 
> Correct the interrupt flags, assuming the author of the code wanted some
> logical behavior behind the name "ACTIVE_xxx", this is:
>   ACTIVE_LOW  => IRQ_TYPE_LEVEL_LOW
>   ACTIVE_HIGH => IRQ_TYPE_LEVEL_HIGH
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi      | 2 +-
>  arch/arm64/boot/dts/freescale/imx8mm-evk.dts              | 2 +-
>  arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts | 2 +-
>  arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi         | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
> index 620a124dfb5f..fdce665d7ac4 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
> @@ -74,7 +74,7 @@
>  		reg = <0x4b>;
>  		pinctrl-0 = <&pinctrl_pmic>;
>  		interrupt-parent = <&gpio1>;
> -		interrupts = <3 GPIO_ACTIVE_LOW>;
> +		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;

All rohm,bd71847 PMIC interrupts should be rather EDGE_FALLING.  Some of
the boards do not have external pull ups and most of the boards do not
configure internal pull up.  Level low would cause the interrupt line to
stay low all the time.

Best regards,
Krzysztof

>  		rohm,reset-snvs-powered;
>  
>  		regulators {
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> index 38134d201eef..609d73e19fee 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> @@ -166,7 +166,7 @@
>  		reg = <0x4b>;
>  		pinctrl-0 = <&pinctrl_pmic>;
>  		interrupt-parent = <&gpio1>;
> -		interrupts = <3 GPIO_ACTIVE_LOW>;
> +		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
>  		rohm,reset-snvs-powered;
>  
>  		regulators {
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts b/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
> index 0bca737964d5..b84d94e10c26 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
> @@ -133,7 +133,7 @@
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pinctrl_captouch>;
>  		interrupt-parent = <&gpio5>;
> -		interrupts = <4 GPIO_ACTIVE_HIGH>;
> +		interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
>  
>  		touchscreen-size-x = <800>;
>  		touchscreen-size-y = <480>;
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi
> index c371cb34b3f7..49743d2f60c1 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi
> @@ -137,7 +137,7 @@
>  		reg = <0x4b>;
>  		pinctrl-0 = <&pinctrl_pmic>;
>  		interrupt-parent = <&gpio2>;
> -		interrupts = <8 GPIO_ACTIVE_LOW>;
> +		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
>  		rohm,reset-snvs-powered;
>  
>  		regulators {
> -- 
> 2.17.1
> 
