Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE896C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B419020781
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732304AbgGVSkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 14:40:05 -0400
Received: from gloria.sntech.de ([185.11.138.130]:47304 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbgGVSkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:40:05 -0400
Received: from x2f7fa19.dyn.telefonica.de ([2.247.250.25] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jyJes-0005Ha-2r; Wed, 22 Jul 2020 20:40:02 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: Mark rock-pi-4 as rock-pi-4a dts
Date:   Wed, 22 Jul 2020 20:40:00 +0200
Message-ID: <2191096.Ll8P9v0SIb@phil>
In-Reply-To: <20200720105531.367671-1-jagan@amarulasolutions.com>
References: <20200720105531.367671-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan,

Am Montag, 20. Juli 2020, 12:55:29 CEST schrieb Jagan Teki:
> Rock PI 4 has 3 variants of hardware platforms called
> RockPI 4A, 4B, and 4C.
> 
> - Rock PI 4A has no Wif/BT.
> - Rock PI 4B has AP6256 Wifi/BT, PoE.
> - Rock PI 4C has AP6256 Wifi/BT, PoE, miniDP, USB Host enable
>   GPIO pin change compared to 4B, 4C
> 
> So move common nodes, properties into dtsi file and include
> on respective variant dts files.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile               |  2 +-
>  .../{rk3399-rock-pi-4.dts => rk3399-rock-pi-4.dtsi} |  3 ---
>  arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts  | 13 +++++++++++++
>  3 files changed, 14 insertions(+), 4 deletions(-)
>  rename arch/arm64/boot/dts/rockchip/{rk3399-rock-pi-4.dts => rk3399-rock-pi-4.dtsi} (99%)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index b87b1f773083..42f9e1861461 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -33,7 +33,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-pinebook-pro.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc-mezzanine.dtb
> -dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4a.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock960.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rockpro64-v2.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rockpro64.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> similarity index 99%
> rename from arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts
> rename to arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> index 3923ec01ef66..c39334b139cc 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> @@ -11,9 +11,6 @@
>  #include "rk3399-opp.dtsi"
>  
>  / {
> -	model = "Radxa ROCK Pi 4";
> -	compatible = "radxa,rockpi4", "rockchip,rk3399";
> -
>  	chosen {
>  		stdout-path = "serial2:1500000n8";
>  	};
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts
> new file mode 100644
> index 000000000000..d96dd3ebd3e0
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4a.dts
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2019 Akash Gajjar <Akash_Gajjar@mentor.com>
> + * Copyright (c) 2019 Pragnesh Patel <Pragnesh_Patel@mentor.com>
> + */
> +
> +/dts-v1/;
> +#include "rk3399-rock-pi-4.dtsi"
> +
> +/ {
> +	model = "Radxa ROCK Pi 4A";
> +	compatible = "radxa,rockpi4", "rockchip,rk3399";

please add a new compatible for the board variants, so ideally we'd get
something like:

	compatible = "radxa,rockpi4a", "radxa,rockpi4", "rockchip,rk3399";

Same for the other 2 board variants + adding them to the binding doc.

Thanks
Heiko




