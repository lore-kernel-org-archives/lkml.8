Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813C1C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 06:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5406B20679
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 06:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584338434;
	bh=yl/qPFKKnwQwDufpWRGRjQqmbLS7/fSpdX7eJ+7fhnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Guztz1MAIqX6Zbsb0p35JFdUA1IGw3NDsMotyvDRxDD1eBZlGKGW+KyUlNkUbPtiE
	 l99NM2aUZnIwsKRGOxPE5im+z7RW5G/liaT6UkZMHT6ND/V5QTWiZToxkwsXoV2SEC
	 Jtf5cc2r6svvGHOgyFvdBn74+FecJN25mYyGQsuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbgCPGAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 02:00:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729363AbgCPGAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 02:00:32 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F23AE20674;
        Mon, 16 Mar 2020 06:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584338431;
        bh=yl/qPFKKnwQwDufpWRGRjQqmbLS7/fSpdX7eJ+7fhnQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ypyaa/UQZF2jfFQsJ8Qqr9Ui/KpCleS7pHALam1HC8TRMikfNfrGfG9uTjeVN8sYt
         9gTYYA8lPIesJMDDSJ89snEbaep7vYM37q48wu8xy0mrO2Eomhr6uNTTbzhHd0lDgz
         cj4L1PznVG4DqQ0F+dv8S5ElG2ffDKp+qXpOYzm0=
Date:   Mon, 16 Mar 2020 14:00:25 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, abel.vesa@nxp.com,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2 1/2] arm64: dts: imx8qxp-mek: Sort labels
 alphabetically
Message-ID: <20200316060024.GG17221@dragon>
References: <1584321993-8642-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584321993-8642-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 09:26:32AM +0800, Anson Huang wrote:
> Sort the labels alphabetically for consistency.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
> 	- Rebase to latest branch, no code change.
> ---
>  arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 50 ++++++++++++++++-----------
>  1 file changed, 30 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> index d3d26cc..b1befdb 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> @@ -30,18 +30,7 @@
>  	};
>  };
>  
> -&adma_lpuart0 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_lpuart0>;
> -	status = "okay";
> -};
> -
> -&fec1 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_fec1>;
> -	phy-mode = "rgmii-id";
> -	phy-handle = <&ethphy0>;
> -	fsl,magic-packet;
> +&adma_dsp {
>  	status = "okay";
>  
>  	mdio {

Here is a rebase issue, i.e. adma_dsp shouldn't get a mdio child node.
It came from the conflict with one commit on my fixes branch.  I decided
to drop the series for the coming merge window.  Let's start over again
after 5.7-rc1 becomes available.

Shawn

> @@ -136,6 +125,35 @@
>  	};
>  };
>  
> +&adma_lpuart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_lpuart0>;
> +	status = "okay";
> +};
> +
> +&fec1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_fec1>;
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethphy0>;
> +	fsl,magic-packet;
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy0: ethernet-phy@0 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <0>;
> +		};
> +	};
> +};
> +
> +&scu_key {
> +	status = "okay";
> +};
> +
>  &usdhc1 {
>  	assigned-clocks = <&clk IMX_CONN_SDHC0_CLK>;
>  	assigned-clock-rates = <200000000>;
> @@ -234,11 +252,3 @@
>  		>;
>  	};
>  };
> -
> -&adma_dsp {
> -	status = "okay";
> -};
> -
> -&scu_key {
> -	status = "okay";
> -};
> -- 
> 2.7.4
> 
