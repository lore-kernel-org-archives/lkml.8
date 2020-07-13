Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CF9C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E19BB206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594625673;
	bh=e6jzQB+yelkADZi8uvbp4lGHJxM3YEbR3QvF0P7e2rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=In2plL3elsy0V+cabP968LzbeUa+cSJUN6627mwMv3yQBBIuG/UiGQ7wBJtQn1KT3
	 3yNzJ1R9+QhxjFwmZQpEmx0UwvUxvEYU/H49zBBfhz0R8ImX669DQy2D972PgnjuG+
	 gJXSP/kONz8e4sNkPMtUrobqSJ9vOisTZxjpN5AQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbgGMHec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 03:34:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:60402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgGMHea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 03:34:30 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 319B1206F0;
        Mon, 13 Jul 2020 07:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594625669;
        bh=e6jzQB+yelkADZi8uvbp4lGHJxM3YEbR3QvF0P7e2rc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i4+tXN4UxtVQ999+u86eMNphcynmsx8PQQYNc7zo8kbktxd6kAQTSJDxlM39Bvp/R
         zE1K15jgANTAd1gKssSv5xYweImFsmR2HHCpLLcxJuNCBjlx3m6o0trho+fMOrdk0W
         LdrQGjYC1xAd90H8Rl0y5c841T6fTVuGfS3kGBIw=
Date:   Mon, 13 Jul 2020 15:34:22 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Chris Healy <cphealy@gmail.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, stefan@agner.ch, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch
Subject: Re: [PATCH v2] ARM: dts: ZII: update MDIO speed and preamble
Message-ID: <20200713071957.GL12113@dragon>
References: <20200708002500.4563-1-cphealy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708002500.4563-1-cphealy@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 05:25:00PM -0700, Chris Healy wrote:
> Update MDIO configuration with ZII devices to fully utilize
> MDIO endpoint capabilities.  All devices support 12.5MHz clock and
> don't require MDIO preable.
> 
> Signed-off-by: Chris Healy <cphealy@gmail.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> ---
> v2:
> - Fix subject line to reference ZII:
> - Get rid of "=<1>;" from suppress-preamble lines
> 
>  arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi   | 2 ++
>  arch/arm/boot/dts/vf610-zii-cfu1.dts      | 2 ++
>  arch/arm/boot/dts/vf610-zii-dev.dtsi      | 2 ++
>  arch/arm/boot/dts/vf610-zii-spb4.dts      | 2 ++
>  arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts  | 2 ++
>  arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts | 2 ++
>  6 files changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> index 20350e803377..58cc421042e1 100644
> --- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> @@ -720,6 +720,8 @@
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  		status = "okay";
> +		suppress-preamble;
> +		clock-frequency = <12500000>;

We usually have 'status' at end of property list, so please move them
up.

Shawn

>  
>  		switch: switch@0 {
>  			compatible = "marvell,mv88e6085";
> diff --git a/arch/arm/boot/dts/vf610-zii-cfu1.dts b/arch/arm/boot/dts/vf610-zii-cfu1.dts
> index ce1920c052fc..c27cacbe6a73 100644
> --- a/arch/arm/boot/dts/vf610-zii-cfu1.dts
> +++ b/arch/arm/boot/dts/vf610-zii-cfu1.dts
> @@ -159,6 +159,8 @@
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  		status = "okay";
> +		suppress-preamble;
> +		clock-frequency = <12500000>;
>  
>  		switch0: switch0@0 {
>  			compatible = "marvell,mv88e6085";
> diff --git a/arch/arm/boot/dts/vf610-zii-dev.dtsi b/arch/arm/boot/dts/vf610-zii-dev.dtsi
> index 95d0060fb56c..9694d3b53607 100644
> --- a/arch/arm/boot/dts/vf610-zii-dev.dtsi
> +++ b/arch/arm/boot/dts/vf610-zii-dev.dtsi
> @@ -138,6 +138,8 @@
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  		status = "okay";
> +		suppress-preamble;
> +		clock-frequency = <12500000>;
>  	};
>  };
>  
> diff --git a/arch/arm/boot/dts/vf610-zii-spb4.dts b/arch/arm/boot/dts/vf610-zii-spb4.dts
> index 55b4201e27f6..d2ad07ed5318 100644
> --- a/arch/arm/boot/dts/vf610-zii-spb4.dts
> +++ b/arch/arm/boot/dts/vf610-zii-spb4.dts
> @@ -120,6 +120,8 @@
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  		status = "okay";
> +		suppress-preamble;
> +		clock-frequency = <12500000>;
>  
>  		switch0: switch0@0 {
>  			compatible = "marvell,mv88e6190";
> diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts b/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
> index a6c22a79779e..0bb3dcff0b79 100644
> --- a/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
> +++ b/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
> @@ -106,6 +106,8 @@
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  		status = "okay";
> +		suppress-preamble;
> +		clock-frequency = <12500000>;
>  
>  		switch0: switch0@0 {
>  			compatible = "marvell,mv88e6190";
> diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
> index 3d05c894bdc0..e12e11805b71 100644
> --- a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
> +++ b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
> @@ -134,6 +134,8 @@
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  		status = "okay";
> +		suppress-preamble;
> +		clock-frequency = <12500000>;
>  
>  		switch0: switch0@0 {
>  			compatible = "marvell,mv88e6190";
> -- 
> 2.21.3
> 
