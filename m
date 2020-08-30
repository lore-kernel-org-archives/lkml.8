Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8301FC433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 20:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6646F20757
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 20:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgH3Un4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 16:43:56 -0400
Received: from gloria.sntech.de ([185.11.138.130]:48408 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbgH3Unz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 16:43:55 -0400
Received: from p508fca7b.dip0.t-ipconnect.de ([80.143.202.123] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kCUB5-0002r0-FD; Sun, 30 Aug 2020 22:43:51 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] ARM: dts: rockchip: rename and label gpio-led subnodes part 3
Date:   Sun, 30 Aug 2020 22:43:50 +0200
Message-ID: <3705366.uVpFMHbKpm@phil>
In-Reply-To: <20200813193455.19772-1-jbx6244@gmail.com>
References: <20200813193455.19772-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Am Donnerstag, 13. August 2020, 21:34:54 CEST schrieb Johan Jonker:
> Current dts files with 'gpio-led' nodes were manually verified.
> In order to automate this process leds-gpio.txt
> has been converted to yaml. With this conversion a check
> for pattern properties was added. In part 3 rename and label
> gpio-led subnodes with pinctrl. To make things equal to other
> dts files move pinctrl below the compatible property.
> 
> Fix with help of the following rules:
> 
> 1: Add nodename in the preferred form.
> 
> 2: Always add a label that ends with '_led' to prevent conflicts
>    with other labels such as 'power' and 'mmc'
> 
> 3: If leds need pinctrl add a label that ends with '_led_pin'
>    also to prevent conflicts with other labels.

I'm undecided about this ... and while thinking about this,
realized that we already have some changes doing that in the tree.

To explain, in general the pinctrl names should come from the names used
in the actual device schematics, as this makes it easier to find and compare
them between devicetree and schematics files.

So creating an arbitrary foo_led_pin pinctrl instead breaks this searchability
which I'd really like to keep.


Heiko


> 
> patternProperties:
>   # The first form is preferred, but fall back to just 'led'
>   # anywhere in the node name to at least catch some child nodes.
>   "(^led-[0-9a-f]$|led)":
> 
> make ARCH=arm dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/leds/
> leds-gpio.yaml
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  arch/arm/boot/dts/rk3036-kylin.dts | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/rk3036-kylin.dts b/arch/arm/boot/dts/rk3036-kylin.dts
> index 7154b827e..bf808cda6 100644
> --- a/arch/arm/boot/dts/rk3036-kylin.dts
> +++ b/arch/arm/boot/dts/rk3036-kylin.dts
> @@ -15,12 +15,12 @@
>  
>  	leds: gpio-leds {
>  		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&work_led_pin>;
>  
>  		work_led: led-0 {
>  			gpios = <&gpio2 RK_PD6 GPIO_ACTIVE_HIGH>;
>  			label = "kylin:red:led";
> -			pinctrl-names = "default";
> -			pinctrl-0 = <&led_ctl>;
>  		};
>  	};
>  
> @@ -367,7 +367,7 @@
>  
>  &pinctrl {
>  	leds {
> -		led_ctl: led-ctl {
> +		work_led_pin: work-led-pin {
>  			rockchip,pins = <2 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>;
>  		};
>  	};
> 




