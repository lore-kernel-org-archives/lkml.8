Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434A0C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 06:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18908206DB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 06:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgC2GaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 02:30:19 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:52103 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbgC2GaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 02:30:19 -0400
X-Greylist: delayed 493 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Mar 2020 02:30:19 EDT
Received: from tarshish (unknown [10.0.8.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 548D744039C;
        Sun, 29 Mar 2020 09:22:03 +0300 (IDT)
References: <20200328212115.12477-1-eichest@gmail.com>
User-agent: mu4e 1.2.0; emacs 26.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Stefan Eichenberger <eichest@gmail.com>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Stefan Eichenberger <eichest@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Rabeeh Khoury <rabeeh@solid-run.com>
Subject: Re: [PATCH] arm64: dts: clearfog-gt-8k: fix ge phy reset pin
In-reply-to: <20200328212115.12477-1-eichest@gmail.com>
Date:   Sun, 29 Mar 2020 09:22:03 +0300
Message-ID: <877dz3el4k.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Sun, Mar 29 2020, eichest@gmail.com wrote:
> From: Stefan Eichenberger <eichest@gmail.com>
>
> According to the ClearFog-GT-8K-rev-1_1-Simplified-Schematic the reset
> pin for the gigabit phy is MPP62 and not MPP43.

Have you tested that on real hardware?

The 1Gb PHY reset on my Clearfog GT-8K is connected to MPP43. Russell's
commit 46f94c7818e7 ("arm64: dts: clearfog-gt-8k: set gigabit PHY reset
deassert delay") indicates that this is the case on his board as well.

In case there was a hardware change between board revisions, we need
another dtb for that revision.

baruch

> Signed-off-by: Stefan Eichenberger <eichest@gmail.com>
> ---
>  .../dts/marvell/armada-8040-clearfog-gt-8k.dts     | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
> index b90d78a5724b..d371d938b41e 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
> @@ -144,7 +144,6 @@
>  	 * [35-38] CP0 I2C1 and I2C0
>  	 * [39] GPIO reset button
>  	 * [40,41] LED0 and LED1
> -	 * [43] 1512 phy reset
>  	 * [47] USB VBUS EN (active low)
>  	 * [48] FAN PWM
>  	 * [49] SFP+ present signal
> @@ -155,6 +154,7 @@
>  	 * [54] NFC reset
>  	 * [55] Micro SD card detect
>  	 * [56-61] Micro SD
> +	 * [62] 1512 phy reset
>  	 */
>
>  	cp0_pci0_reset_pins: pci0-reset-pins {
> @@ -197,11 +197,6 @@
>  		marvell,function = "gpio";
>  	};
>
> -	cp0_copper_eth_phy_reset: copper-eth-phy-reset {
> -		marvell,pins = "mpp43";
> -		marvell,function = "gpio";
> -	};
> -
>  	cp0_xhci_vbus_pins: xhci0-vbus-pins {
>  		marvell,pins = "mpp47";
>  		marvell,function = "gpio";
> @@ -232,6 +227,11 @@
>  			       "mpp60", "mpp61";
>  		marvell,function = "sdio";
>  	};
> +
> +	cp0_copper_eth_phy_reset: copper-eth-phy-reset {
> +		marvell,pins = "mpp62";
> +		marvell,function = "gpio";
> +	};
>  };
>
>  &cp0_pcie0 {
> @@ -365,7 +365,7 @@
>  		reg = <0>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&cp0_copper_eth_phy_reset>;
> -		reset-gpios = <&cp0_gpio2 11 GPIO_ACTIVE_LOW>;
> +		reset-gpios = <&cp0_gpio2 30 GPIO_ACTIVE_LOW>;
>  		reset-assert-us = <10000>;
>  		reset-deassert-us = <10000>;
>  	};


--
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
