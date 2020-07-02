Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBB1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 847BF2067D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbgGBOpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:45:38 -0400
Received: from foss.arm.com ([217.140.110.172]:59216 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728179AbgGBOpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:45:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 453DE31B;
        Thu,  2 Jul 2020 07:45:37 -0700 (PDT)
Received: from [10.57.21.32] (unknown [10.57.21.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A88F3F68F;
        Thu,  2 Jul 2020 07:45:35 -0700 (PDT)
Subject: Re: [PATCH] ARM: dts: rockchip: Add usb host0 ohci node for rk3288
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        mylene.josserand@collabora.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        William Wu <william.wu@rock-chips.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org
References: <20200702090259.36595-1-jagan@amarulasolutions.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <5a32f7f5-8c70-d261-569b-c807210d17cc@arm.com>
Date:   Thu, 2 Jul 2020 15:45:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200702090259.36595-1-jagan@amarulasolutions.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-02 10:02, Jagan Teki wrote:
> rk3288 and rk3288w have a usb host0 ohci controller.
> 
> Although rk3288 ohci doesn't actually work on hardware, but
> rk3288w ohci can work well.
> 
> So add usb host0 ohci node in rk3288 dtsi and the quirk in
> ohci platform driver will disable ohci on rk3288.
> 
> The bootloader must update the compatible in order to bypass
> host0_ohci in legacy rk3288 platform.
> 
> Cc: William Wu <william.wu@rock-chips.com>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Note:
> - U-Boot patch for compatible update
> https://patchwork.ozlabs.org/project/uboot/patch/20200702084820.35942-1-jagan@amarulasolutions.com/
> 
>   arch/arm/boot/dts/rk3288.dtsi | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index 0cd88774db95..fd0066d07dfc 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -614,7 +614,19 @@ usb_host0_ehci: usb@ff500000 {
>   		status = "disabled";
>   	};
>   
> -	/* NOTE: ohci@ff520000 doesn't actually work on hardware */
> +	/**
> +	 * NOTE: ohci@ff520000 doesn't actually work on hardware
> +	 * hardware, but can work on rk3288w hardware.
> +	 */

Hardware hardware, hardware - seems like things got a bit mangled there ;)

How about simply something like this?:

	/* NOTE: doesn't work on RK3288, but fixed on RK3288W */

Robin.

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
>   	usb_host1: usb@ff540000 {
>   		compatible = "rockchip,rk3288-usb", "rockchip,rk3066-usb",
> 
