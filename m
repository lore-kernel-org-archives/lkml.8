Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059A1C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF51D20714
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbgGVSeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 14:34:24 -0400
Received: from gloria.sntech.de ([185.11.138.130]:47246 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbgGVSeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:34:23 -0400
Received: from x2f7fa19.dyn.telefonica.de ([2.247.250.25] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jyJZM-0005FO-8n; Wed, 22 Jul 2020 20:34:20 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        William Wu <william.wu@rock-chips.com>
Subject: Re: [PATCH v3] ARM: dts: rockchip: Add usb host0 ohci node for rk3288
Date:   Wed, 22 Jul 2020 20:34:18 +0200
Message-ID: <8444056.acRTkLjuym@phil>
In-Reply-To: <20200720105846.367776-1-jagan@amarulasolutions.com>
References: <20200720105846.367776-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaganm

Am Montag, 20. Juli 2020, 12:58:46 CEST schrieb Jagan Teki:
> rk3288 and rk3288w have a usb host0 ohci controller.
> 
> Although rk3288 ohci doesn't actually work on hardware, but
> rk3288w ohci can work well.
> 
> So add usb host0 ohci node in rk3288 dtsi and the quirk in
> ohci platform driver will disable ohci on rk3288.

If I remember the discussion correctly, we expect the board dts
or the bootloader to enable the ohci, right?
So that block go away ... just making sure, I don't remember
untrue stuff ;-)


Heiko


> Cc: William Wu <william.wu@rock-chips.com>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - none
> 
>  arch/arm/boot/dts/rk3288.dtsi | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index 0cd88774db95..f0774d9afb67 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -614,7 +614,16 @@ usb_host0_ehci: usb@ff500000 {
>  		status = "disabled";
>  	};
>  
> -	/* NOTE: ohci@ff520000 doesn't actually work on hardware */
> +	/* NOTE: doesn't work on RK3288, but fixed on RK3288W */
> +	usb_host0_ohci: usb@ff520000 {
> +		compatible = "generic-ohci";
> +		reg = <0x0 0xff520000 0x0 0x100>;
> +		interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru HCLK_USBHOST0>;
> +		phys = <&usbphy1>;
> +		phy-names = "usb";
> +		status = "disabled";
> +	};
>  
>  	usb_host1: usb@ff540000 {
>  		compatible = "rockchip,rk3288-usb", "rockchip,rk3066-usb",
> 




