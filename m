Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8792FC55181
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D571206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgDUIXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 04:23:48 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46132 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgDUIXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 04:23:48 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jQoC0-0001S4-JW; Tue, 21 Apr 2020 10:23:44 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Johan Jonker <jbx6244@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: add bus-width properties to mmc nodes for rk3328.dtsi
Date:   Tue, 21 Apr 2020 10:23:43 +0200
Message-ID: <2710874.PL6qFFFsBp@diego>
In-Reply-To: <CAGb2v67N6t+C8dVKdjuOv1NzD9=3-n0GZQkshy1Pm6PFPJ87dQ@mail.gmail.com>
References: <20200416181944.5879-1-jbx6244@gmail.com> <CAGb2v67N6t+C8dVKdjuOv1NzD9=3-n0GZQkshy1Pm6PFPJ87dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ChenYu,

Am Dienstag, 21. April 2020, 05:48:52 CEST schrieb Chen-Yu Tsai:
> On Fri, Apr 17, 2020 at 2:19 AM Johan Jonker <jbx6244@gmail.com> wrote:
> >
> > 'bus-width' and pinctrl containing the bus-pins
> > should be in the same file, so add them to
> > all mmc nodes in 'rk3328.dtsi'.
> 
> Nope. First of all, pinctrl usage is with pinctrl-N properties, not the
> pinctrl device, and there are no defaults set for any of the mmc nodes.
> Second, these are board design specific. For example, boards are free to
> use just 4 bits for the eMMC if they so desire. So this should be in each
> board dts file. If a board is missing this property, fix the board.

you are correct that the pinctrl entries are missing from the patches,
bus-width and pinctrl should be defined in the same file each time,
but for the whole idea I tend to disagree. 

So far every board with a Rockchip socs follows Rockchip's reference design
for a lot of parts - for example I only see sdmmc nodes with bus-width=4
etc.

So the basic idea is to have default pinctrl settings for the settings
everybody uses predefined ... if a board comes along that needs different
settings it is free to redefine that.


Heiko


> 
> This applies to all three patches in the series.
> 
> ChenYu
> 
> > Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3328.dtsi | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> > index 175060695..db2c3085e 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> > @@ -861,6 +861,7 @@
> >                 clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
> >                          <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
> >                 clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
> > +               bus-width = <4>;
> >                 fifo-depth = <0x100>;
> >                 max-frequency = <150000000>;
> >                 status = "disabled";
> > @@ -873,6 +874,7 @@
> >                 clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>,
> >                          <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
> >                 clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
> > +               bus-width = <4>;
> >                 fifo-depth = <0x100>;
> >                 max-frequency = <150000000>;
> >                 status = "disabled";
> > @@ -885,6 +887,7 @@
> >                 clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
> >                          <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
> >                 clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
> > +               bus-width = <8>;
> >                 fifo-depth = <0x100>;
> >                 max-frequency = <150000000>;
> >                 status = "disabled";
> > --
> > 2.11.0
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 




