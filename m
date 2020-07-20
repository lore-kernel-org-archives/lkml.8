Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0A0C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 03:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6593B2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 03:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595214963;
	bh=uCkjYxAEkerXacwjaaK/ELLETaL/ezoqZQTP4glVi7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sArCljHcSoY8aPzG0nsmIpBcNMVTjiUk0CoRPknx00KoN9lYnFys+HyX+2WFEAIsS
	 US2LBv11hrMmeqelpAFvC1HrcTShCMIxzNB/g8XvLsP3qiHTzzHNMjzvI8Y9a/RhTe
	 vMHtC1xYe1qx/AqIA3h+fz6AvYN3Um9XMARV4bfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgGTDQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 23:16:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:41850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbgGTDP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 23:15:59 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2214C2080D;
        Mon, 20 Jul 2020 03:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595214958;
        bh=uCkjYxAEkerXacwjaaK/ELLETaL/ezoqZQTP4glVi7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k0VpuexkzSq33GBOz54eUfsF1G6SxMPq/kweMHv7YQXud2WidgY4BGiMd+b22tTEb
         uwUyz/zygZBY5hcPKobydIl8XFk2tcZ97tVnccf5xxIzikRExfk0C7Ohqjjskl6lZu
         wFNRBYRVAtGFVwWbkoXSUAHM8Q/nztRgVlOB9bpo=
Date:   Mon, 20 Jul 2020 11:15:35 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Chris Healy <cphealy@gmail.com>
Cc:     s.hauer@pengutronix.de, stefan@agner.ch, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, festevam@gmail.com
Subject: Re: [PATCH] ARM: dts: ZII: Disable HW Ethernet switch reset GPIO
Message-ID: <20200720031534.GJ11560@dragon>
References: <20200715212227.26436-1-cphealy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715212227.26436-1-cphealy@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 02:22:27PM -0700, Chris Healy wrote:
> Disable Ethernet switch reset GPIO with ZII platforms that have it
> enabled to sync up with existing ZII platforms that already have
> it disabled.

I do not follow it.  The reset GPIO is part of hardware description.  We
shouldn't add or remove it for sake of sync-up with other platforms.

Shawn

> 
> Signed-off-by: Chris Healy <cphealy@gmail.com>
> ---
>  arch/arm/boot/dts/vf610-zii-cfu1.dts      | 2 --
>  arch/arm/boot/dts/vf610-zii-spb4.dts      | 2 --
>  arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts  | 2 --
>  arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts | 2 --
>  4 files changed, 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/vf610-zii-cfu1.dts b/arch/arm/boot/dts/vf610-zii-cfu1.dts
> index ce1920c052fc..c2668230a4c0 100644
> --- a/arch/arm/boot/dts/vf610-zii-cfu1.dts
> +++ b/arch/arm/boot/dts/vf610-zii-cfu1.dts
> @@ -170,7 +170,6 @@
>  			interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
>  			interrupt-controller;
>  			#interrupt-cells = <2>;
> -			reset-gpios = <&gpio3 11 GPIO_ACTIVE_LOW>;
>  
>  			ports {
>  				#address-cells = <1>;
> @@ -354,7 +353,6 @@
>  	pinctrl_switch: switch-grp {
>  		fsl,pins = <
>  			VF610_PAD_PTB28__GPIO_98		0x3061
> -			VF610_PAD_PTE2__GPIO_107		0x1042
>  		>;
>  	};
>  
> diff --git a/arch/arm/boot/dts/vf610-zii-spb4.dts b/arch/arm/boot/dts/vf610-zii-spb4.dts
> index 55b4201e27f6..261317340189 100644
> --- a/arch/arm/boot/dts/vf610-zii-spb4.dts
> +++ b/arch/arm/boot/dts/vf610-zii-spb4.dts
> @@ -127,7 +127,6 @@
>  			pinctrl-names = "default";
>  			reg = <0>;
>  			eeprom-length = <65536>;
> -			reset-gpios = <&gpio3 11 GPIO_ACTIVE_LOW>;
>  			interrupt-parent = <&gpio3>;
>  			interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
>  			interrupt-controller;
> @@ -312,7 +311,6 @@
>  
>  	pinctrl_gpio_switch0: pinctrl-gpio-switch0 {
>  		fsl,pins = <
> -			VF610_PAD_PTE2__GPIO_107		0x31c2
>  			VF610_PAD_PTB28__GPIO_98		0x219d
>  		>;
>  	};
> diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts b/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
> index a6c22a79779e..e37b9643269b 100644
> --- a/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
> +++ b/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
> @@ -113,7 +113,6 @@
>  			pinctrl-names = "default";
>  			reg = <0>;
>  			eeprom-length = <65536>;
> -			reset-gpios = <&gpio3 11 GPIO_ACTIVE_LOW>;
>  			interrupt-parent = <&gpio3>;
>  			interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
>  			interrupt-controller;
> @@ -288,7 +287,6 @@
>  
>  	pinctrl_gpio_switch0: pinctrl-gpio-switch0 {
>  		fsl,pins = <
> -			VF610_PAD_PTE2__GPIO_107		0x31c2
>  			VF610_PAD_PTB28__GPIO_98		0x219d
>  		>;
>  	};
> diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
> index 3d05c894bdc0..b3d6d4b9fa9c 100644
> --- a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
> +++ b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
> @@ -141,7 +141,6 @@
>  			pinctrl-names = "default";
>  			reg = <0>;
>  			eeprom-length = <65536>;
> -			reset-gpios = <&gpio3 11 GPIO_ACTIVE_LOW>;
>  			interrupt-parent = <&gpio3>;
>  			interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
>  			interrupt-controller;
> @@ -319,7 +318,6 @@
>  
>  	pinctrl_gpio_switch0: pinctrl-gpio-switch0 {
>  		fsl,pins = <
> -			VF610_PAD_PTE2__GPIO_107		0x31c2
>  			VF610_PAD_PTB28__GPIO_98		0x219d
>  		>;
>  	};
> -- 
> 2.21.3
> 
