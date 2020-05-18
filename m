Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255BBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 023C2207ED
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgERW3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 18:29:17 -0400
Received: from gloria.sntech.de ([185.11.138.130]:52758 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728575AbgERW3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 18:29:16 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jaoG0-000081-Ec; Tue, 19 May 2020 00:29:12 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] arm64: dts: rockchip: remove include for irq.h
Date:   Tue, 19 May 2020 00:29:11 +0200
Message-ID: <2542759.BOPbJzt3gv@diego>
In-Reply-To: <20200403180159.13387-3-jbx6244@gmail.com>
References: <20200403180159.13387-1-jbx6244@gmail.com> <20200403180159.13387-3-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Am Freitag, 3. April 2020, 20:01:58 CEST schrieb Johan Jonker:
> The 'irq.h' file is already included through 'arm-gic.h',
> so remove them from all Rockchip dtsi files.

I disagree here ... we do use properties from both arm-gic.h and
the main irq.h an therefore should not rely on the arm-gic.h
"accidentially" including irq.h


Heiko


> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/px30.dtsi   | 1 -
>  arch/arm64/boot/dts/rockchip/rk3308.dtsi | 1 -
>  arch/arm64/boot/dts/rockchip/rk3328.dtsi | 1 -
>  arch/arm64/boot/dts/rockchip/rk3368.dtsi | 1 -
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 1 -
>  5 files changed, 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
> index 6f7171290..4820edc7f 100644
> --- a/arch/arm64/boot/dts/rockchip/px30.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
> @@ -6,7 +6,6 @@
>  #include <dt-bindings/clock/px30-cru.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> -#include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/pinctrl/rockchip.h>
>  #include <dt-bindings/power/px30-power.h>
>  #include <dt-bindings/soc/rockchip,boot-mode.h>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> index ac43bc3f7..a9b98555d 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> @@ -7,7 +7,6 @@
>  #include <dt-bindings/clock/rk3308-cru.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> -#include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/pinctrl/rockchip.h>
>  #include <dt-bindings/soc/rockchip,boot-mode.h>
>  #include <dt-bindings/thermal/thermal.h>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> index 470783a48..175060695 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> @@ -6,7 +6,6 @@
>  #include <dt-bindings/clock/rk3328-cru.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> -#include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/pinctrl/rockchip.h>
>  #include <dt-bindings/power/rk3328-power.h>
>  #include <dt-bindings/soc/rockchip,boot-mode.h>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> index 1ebb0eef4..f22475016 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> @@ -5,7 +5,6 @@
>  
>  #include <dt-bindings/clock/rk3368-cru.h>
>  #include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/pinctrl/rockchip.h>
>  #include <dt-bindings/soc/rockchip,boot-mode.h>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 0d895cff5..123b7402a 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -6,7 +6,6 @@
>  #include <dt-bindings/clock/rk3399-cru.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> -#include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/pinctrl/rockchip.h>
>  #include <dt-bindings/power/rk3399-power.h>
>  #include <dt-bindings/thermal/thermal.h>
> 




