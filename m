Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A8BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 02:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90E8221D91
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 02:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594694956;
	bh=FQefL0S3oOa2O4hzm7+iXbr0aZkkdvsbdCRiO+nHzdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Kd3pBor+gFBaPaS8ENcKf1EJ1D16xMsTL2bT/FXONyQOWVT7lp7DBYD9X+TbxfsFU
	 1Ya68VBYtfS2vbW4bZWUUDPjPimjIj74kjrbCheKRKomx3fkAuFHEBY6fVB8yQ34Bz
	 G0rTp7279xnGvDDznFU+x3h4xuVuP/ANNgd6MjYk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgGNCtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 22:49:15 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:40192 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgGNCtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 22:49:15 -0400
Received: by mail-il1-f196.google.com with SMTP id e18so13001279ilr.7;
        Mon, 13 Jul 2020 19:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DdQRU+re2daApc1buZh/NOScJMoADL35yGQLsQdXB0M=;
        b=LtknXvta8Kz1C/vk2tTggkcKoVTwQX+UeiTeQ09r71DwrEb1cCS8P+uB5cP2z8VBIB
         38u5utVpQ56NhggHHm14cR2bjU/w0KvR0Et4Sq2Im1dPr90rmFleWCB6IIzpXOZIhLM3
         htPWqs/+4w2vpm+StWT3IvWXRSeMYtFv1zbDPEm8MGwKIQeaVK3ujyQH44o42AUDPcBh
         kNOb9Ctdz2uKqQSleuibFBezGNVsWohRbUR5il5gmy7xCDon1m3a+Cz8ezMhWcqUoGmM
         uqFK3B2R0fnTwCDnAOuXO1g1w05+JcSL6z2lmTNGMSF8HipoHVMmZo5Ci/gWy92viw5K
         U4kA==
X-Gm-Message-State: AOAM531LnXMRZrTKETwHXYSYMqU9+SrusJqXTmj0N4azxKXeXWMYBYF1
        vKEJuJko31UdbX3wC7cgAA==
X-Google-Smtp-Source: ABdhPJz9igZQqkIyHCZ5N1hs9WTl0MnTGAZmaW5l4R56IePZCqGF6EM/cUpsjUEx18PhvChQvcjoqA==
X-Received: by 2002:a92:c00d:: with SMTP id q13mr2499962ild.222.1594694954000;
        Mon, 13 Jul 2020 19:49:14 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id f18sm8489104ion.47.2020.07.13.19.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 19:49:13 -0700 (PDT)
Received: (nullmailer pid 1187292 invoked by uid 1000);
        Tue, 14 Jul 2020 02:49:12 -0000
Date:   Mon, 13 Jul 2020 20:49:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adrian Pop <pop.adrian61@gmail.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ARM: dts: stm32: Enable MIPI DSI display support.
Message-ID: <20200714024912.GA1184333@bogus>
References: <20200702172714.158786-1-pop.adrian61@gmail.com>
 <20200702172714.158786-2-pop.adrian61@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702172714.158786-2-pop.adrian61@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 08:27:14PM +0300, Adrian Pop wrote:
> STM32f769-disco features a 4" MIPI DSI display: add support for it.
> On Cortex-M7 DMA can't use cached memory. For this reason I use a dedicated
> memory pool for DMA with no-cache attribute which is located at the end of
>  RAM.
> 
> Signed-off-by: Adrian Pop <pop.adrian61@gmail.com>
> ---
>  arch/arm/boot/dts/stm32f746.dtsi      | 34 +++++++++++++++++++
>  arch/arm/boot/dts/stm32f769-disco.dts | 49 +++++++++++++++++++++++++++
>  2 files changed, 83 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
> index 93c063796780..577a812ca01c 100644
> --- a/arch/arm/boot/dts/stm32f746.dtsi
> +++ b/arch/arm/boot/dts/stm32f746.dtsi
> @@ -48,6 +48,19 @@ / {
>  	#address-cells = <1>;
>  	#size-cells = <1>;
>  
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		linux,dma {

Build your DT with W=1. This will have a warning.

> +			compatible = "shared-dma-pool";
> +			linux,dma-default;
> +			no-map;
> +			reg = <0xc0f00000 0x100000>;
> +		};
> +	};
> +
>  	clocks {
>  		clk_hse: clk-hse {
>  			#clock-cells = <0>;
> @@ -75,6 +88,27 @@ clk_i2s_ckin: clk-i2s-ckin {
>  	};
>  
>  	soc {
> +		ltdc: display-controller@40016800 {
> +			compatible = "st,stm32-ltdc";
> +			reg = <0x40016800 0x200>;
> +			interrupts = <88>, <89>;
> +			resets = <&rcc STM32F7_APB2_RESET(LTDC)>;
> +			clocks = <&rcc 1 CLK_LCD>;
> +			clock-names = "lcd";
> +			status = "disabled";
> +		};
> +
> +		dsi: dsi@40016c00 {
> +			compatible = "st,stm32-dsi";
> +			reg = <0x40016c00 0x800>;
> +			interrupts = <98>;
> +			clocks = <&rcc 1 CLK_F769_DSI>, <&clk_hse>;
> +			clock-names = "pclk", "ref";
> +			resets = <&rcc STM32F7_APB2_RESET(DSI)>;
> +			reset-names = "apb";
> +			status = "disabled";
> +		};
> +
>  		timer2: timer@40000000 {
>  			compatible = "st,stm32-timer";
>  			reg = <0x40000000 0x400>;
> diff --git a/arch/arm/boot/dts/stm32f769-disco.dts b/arch/arm/boot/dts/stm32f769-disco.dts
> index 1626e00bb2cb..a9e81b49809c 100644
> --- a/arch/arm/boot/dts/stm32f769-disco.dts
> +++ b/arch/arm/boot/dts/stm32f769-disco.dts
> @@ -153,3 +153,52 @@ &usbotg_hs {
>  	pinctrl-names = "default";
>  	status = "okay";
>  };
> +
> +&dsi {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		port@0 {
> +			reg = <0>;
> +			dsi_in: endpoint {
> +				remote-endpoint = <&ltdc_out_dsi>;
> +			};
> +		};
> +
> +		port@1 {
> +			reg = <1>;
> +			dsi_out: endpoint {
> +				remote-endpoint = <&dsi_in_panel>;
> +			};
> +		};
> +
> +	};
> +
> +	panel: panel {
> +		compatible = "orisetech,otm8009a";
> +		reg = <0>;
> +		reset-gpios = <&gpioj 15 GPIO_ACTIVE_LOW>;
> +		status = "okay";

Don't need status. Enabled is the default.

> +
> +		port {
> +			dsi_in_panel: endpoint {
> +				remote-endpoint = <&dsi_out>;
> +			};
> +		};
> +	};
> +};
> +
> +&ltdc {
> +	status = "okay";
> +
> +	port {
> +		ltdc_out_dsi: endpoint {
> +			remote-endpoint = <&dsi_in>;
> +		};
> +	};
> +};
> -- 
> 2.27.0
> 
