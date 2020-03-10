Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2219BC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24D224680
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="E8boOYMH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbgCJOEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 10:04:54 -0400
Received: from vps.xff.cz ([195.181.215.36]:40144 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbgCJOEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 10:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1583849092; bh=E024hw0nCcOAz/evtUeh0SKgeswiCLbymOv+Vx8NBeE=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=E8boOYMHPpL1w1uF1IVT3DJGWFABQDdAcfZtNaNhdKlmQScsKUlgFNmMBLqb0n7Ni
         Oj1qpMNZz3sFL8LqTXtcjanCirwI+z0qDA2E2WY6yh7uMt5pLkwGC0IjesrmeyZHhG
         cg6bMYy7FZJ6MceeYI+i7Ss68wVXfHVrOk2nu5to=
Date:   Tue, 10 Mar 2020 15:04:52 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Pascal Roeleven <dev@pascalroeleven.nl>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] [PATCH 2/2] ARM: dts: sun4i: Add support for
 Topwise A721 tablet
Message-ID: <20200310140452.cfzw2o7al6uf2fpp@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Pascal Roeleven <dev@pascalroeleven.nl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com
References: <20200310102725.14591-1-dev@pascalroeleven.nl>
 <20200310102725.14591-3-dev@pascalroeleven.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310102725.14591-3-dev@pascalroeleven.nl>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 11:27:24AM +0100, Pascal Roeleven wrote:
> The Topwise A721/LY-F1 tablet is a tablet sold around 2012 under
> different brands. The mainboard mentions A721 clearly, so this tablet
> is best known under this name.
> 
> Signed-off-by: Pascal Roeleven <dev@pascalroeleven.nl>
> ---
>  arch/arm/boot/dts/Makefile                   |   3 +-
>  arch/arm/boot/dts/sun4i-a10-topwise-a721.dts | 302 +++++++++++++++++++
>  2 files changed, 304 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/sun4i-a10-topwise-a721.dts
> 
> +/dts-v1/;
> +#include "sun4i-a10.dtsi"
> +#include "sunxi-common-regulators.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/pwm/pwm.h>
> +
> +/ {
> +	model = "Topwise A721";
> +	compatible = "topwise,a721", "allwinner,sun4i-a10";

And you also need to add the compatible to:

  Documentation/devicetree/bindings/arm/sunxi.yaml

regards,
	o.

