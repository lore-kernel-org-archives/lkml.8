Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78821C2D0FA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58B3C20740
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589357474;
	bh=bfszAa0IlVLYn8X862YglQpkl1hzTyD9sMakcFygyHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Zfk67stCIZ8h/X63+YyzzTMFXjsyFQ8QOqW+R1hUAokGyVpY3EfCZXNW2aB6b3mWy
	 BDcNoU+uirEW+tbUcL0JgfeZu/4jipoYx+iSxluoZWPPIe6aEjE8PecRLQ8wyrZ/G0
	 Aj198S1i8BdQh98Mn/hkavz+zFGSAbxmUMjhPTII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbgEMILN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 04:11:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbgEMILN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 04:11:13 -0400
Received: from dragon (unknown [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9332206F5;
        Wed, 13 May 2020 08:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589357473;
        bh=bfszAa0IlVLYn8X862YglQpkl1hzTyD9sMakcFygyHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a2R5joZthiNIbX1qqSdEy/cVNO885fWI1BFKAGzto6rda3f0/ZDXJ75e5eSyQ5mfh
         VMU/TZQ5wDABPLE+3dTUdGNgfBwG/9XJWNLLJne3gH4XaNcrwCb7kds221ljUVnMcU
         yPiBcSj6NKozmpvbutJZu+t8KmLZD6pGGrvoDAFw=
Date:   Wed, 13 May 2020 16:10:59 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: gw552x: add USB OTG support
Message-ID: <20200513081058.GC26997@dragon>
References: <1587748215-9587-1-git-send-email-tharvey@gateworks.com>
 <1588173755-18045-1-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588173755-18045-1-git-send-email-tharvey@gateworks.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 08:22:35AM -0700, Tim Harvey wrote:
> The GW552x-B board revision adds USB OTG support.
> 
> Enable the device-tree node and configure the OTG_ID pin.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Changed prefix to 'ARM: dts: imx6qdl-gw552x: ' and applied patch.

Shawn

> ---
>  arch/arm/boot/dts/imx6qdl-gw552x.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
> index dc646b7..bb35971 100644
> --- a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
> @@ -258,6 +258,14 @@
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
> @@ -359,6 +367,12 @@
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
