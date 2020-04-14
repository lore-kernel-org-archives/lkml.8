Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF925C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A565C20644
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438209AbgDNKQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 06:16:38 -0400
Received: from gloria.sntech.de ([185.11.138.130]:39236 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438198AbgDNKQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 06:16:20 -0400
Received: from [95.90.166.74] (helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jOIbu-0007oY-6y; Tue, 14 Apr 2020 12:16:06 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: remove bus-width from mmc nodes in rk3308.dtsi
Date:   Tue, 14 Apr 2020 12:16:05 +0200
Message-ID: <22353886.YAKSXtfJYZ@diego>
In-Reply-To: <20c81edc-247c-8db0-2b3c-a6c2fcad6b4e@arm.com>
References: <20200413193652.1952-1-jbx6244@gmail.com> <20c81edc-247c-8db0-2b3c-a6c2fcad6b4e@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 14. April 2020, 12:02:46 CEST schrieb Robin Murphy:
> On 2020-04-13 8:36 pm, Johan Jonker wrote:
> > The 'bus-width' property for mmc nodes is defined both in
> > 'rk3308.dtsi' and 'rk3308-roc-cc.dts'.
> > In line with the other Rockchip SoCs define that in a user dts only,
> > so remove all entries from mmc nodes in 'rk3308.dtsi'.
> 
> Judging by the pinctrl entries, these represent the number of pins 
> provided by the SoC itself. Obviously boards need to override that if 
> for some reason they don't wire up all the available data lines, but it 
> seems backwards to have every board restate the SoC's default value.

Yep, especially as most boards follow the reference layout to some extent
and so far I haven't seen any board not use the full 4 pins for sdmmc
for example :-)


> In fact, having brought it up, for this particular case the pinctrl 
> setting is inherently related to the bus width, so having one without 
> the other in either place doesn't smell right.

So the bus width should be removed from the board file.


> > Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> > ---
> >   arch/arm64/boot/dts/rockchip/rk3308.dtsi | 3 ---
> >   1 file changed, 3 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> > index a9b98555d..130771ede 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> > @@ -587,7 +587,6 @@
> >   		compatible = "rockchip,rk3308-dw-mshc", "rockchip,rk3288-dw-mshc";
> >   		reg = <0x0 0xff480000 0x0 0x4000>;
> >   		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
> > -		bus-width = <4>;
> >   		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
> >   			 <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
> >   		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
> > @@ -602,7 +601,6 @@
> >   		compatible = "rockchip,rk3308-dw-mshc", "rockchip,rk3288-dw-mshc";
> >   		reg = <0x0 0xff490000 0x0 0x4000>;
> >   		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
> > -		bus-width = <8>;
> >   		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
> >   			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
> >   		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
> > @@ -615,7 +613,6 @@
> >   		compatible = "rockchip,rk3308-dw-mshc", "rockchip,rk3288-dw-mshc";
> >   		reg = <0x0 0xff4a0000 0x0 0x4000>;
> >   		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
> > -		bus-width = <4>;
> >   		clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>,
> >   			 <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
> >   		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
> > 
> 




