Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F6FC83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 043C3206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588131468;
	bh=XbNWCnLk1VJPpYjGpv8ddyaXOVe2sfB+lNDckroYR1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JCe0HTVQtN/PvtAY7CyVBjzXL2hZelZCVHngZLOWpk/sVMD3G7VBlfnH5W800qvtK
	 V+bMxZ3+HaYnkkgjSXadEcNtRmavPEpdCKSPF5GUCLSMghNJhXEeCotiVZ3EE6/uyU
	 0u1KBQBPxqxm9kGIC1okRIksd7nHBtY/qNzQdVPw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgD2Dhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 23:37:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbgD2Dhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 23:37:46 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B7AC206D8;
        Wed, 29 Apr 2020 03:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588131466;
        bh=XbNWCnLk1VJPpYjGpv8ddyaXOVe2sfB+lNDckroYR1o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E/4usoYtdF9PVQPYzt54/5009sCBniMu2IzjuKl7ts7q7qrUciiPhA6z2Dt8HaP3R
         aU7BgKO8q3boSawQOnHhnEQLUybWYF9R1SUAYf0ZPwVGjMJ/VaU06ENJFnXDrMzSM8
         V/GQ3k0tec/OcBL1S11qEt4X3rqgC3Ch65lEeaVk=
Date:   Wed, 29 Apr 2020 11:37:41 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: gw552x: add USB OTG support
Message-ID: <20200429033740.GP32592@dragon>
References: <1587748215-9587-1-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587748215-9587-1-git-send-email-tharvey@gateworks.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 10:10:15AM -0700, Tim Harvey wrote:
> The GW552x-B board revision adds USB OTG support.
> 
> Enable the device-tree node and configure the OTG_ID pin.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  arch/arm/boot/dts/imx6qdl-gw552x.dtsi | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
> index dc646b7..133a1e3 100644
> --- a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
> @@ -12,8 +12,6 @@
>  		led1 = &led1;
>  		led2 = &led2;
>  		nand = &gpmi;
> -		usb0 = &usbh1;
> -		usb1 = &usbotg;

Have some comments about this change in the commit log?

Shawn

>  	};
>  
>  	chosen {
> @@ -258,6 +256,14 @@
>  	status = "okay";
>  };
>  
> +&usbotg {
> +	vbus-supply = <&reg_5p0v>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usbotg>;
> +	disable-over-current;
> +	status = "okay";
> +};
> +
>  &wdog1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_wdog>;
> @@ -359,6 +365,12 @@
>  		>;
>  	};
>  
> +	pinctrl_usbotg: usbotggrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID	0x13059
> +		>;
> +	};
> +
>  	pinctrl_wdog: wdoggrp {
>  		fsl,pins = <
>  			MX6QDL_PAD_DISP0_DAT8__WDOG1_B		0x1b0b0
> -- 
> 2.7.4
> 
