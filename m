Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60EFC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BC8206E9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403964AbgDCQIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:08:15 -0400
Received: from gloria.sntech.de ([185.11.138.130]:56740 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727882AbgDCQIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:08:12 -0400
Received: from p5b127fb0.dip0.t-ipconnect.de ([91.18.127.176] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jKOrV-0005vZ-5e; Fri, 03 Apr 2020 18:08:05 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] ARM: dts: rockchip: remove include for irq.h
Date:   Fri, 03 Apr 2020 18:08:04 +0200
Message-ID: <2606579.xTHnjFkxbI@phil>
In-Reply-To: <20200403154329.11256-2-jbx6244@gmail.com>
References: <20200403154329.11256-1-jbx6244@gmail.com> <20200403154329.11256-2-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Am Freitag, 3. April 2020, 17:43:28 CEST schrieb Johan Jonker:
> The 'irq.h' file is already included through 'arm-gic.h',
> so remove them from all Rockchip dtsi files.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  arch/arm/boot/dts/rk3036.dtsi | 3 +--
>  arch/arm/boot/dts/rk322x.dtsi | 3 +--
>  arch/arm/boot/dts/rk3288.dtsi | 5 ++---
>  arch/arm/boot/dts/rk3xxx.dtsi | 1 -
>  arch/arm/boot/dts/rv1108.dtsi | 4 ++--
>  5 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
> index 781ac7583..55f3838b2 100644
> --- a/arch/arm/boot/dts/rk3036.dtsi
> +++ b/arch/arm/boot/dts/rk3036.dtsi
> @@ -1,10 +1,9 @@
>  // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>  
> +#include <dt-bindings/clock/rk3036-cru.h>
>  #include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/pinctrl/rockchip.h>
> -#include <dt-bindings/clock/rk3036-cru.h>
>  #include <dt-bindings/soc/rockchip,boot-mode.h>

that movement of the *-cru.h files are unrelated changes,
as they're not described in the commit message.

If you really want to move these this should be a separate commit.


Heiko


