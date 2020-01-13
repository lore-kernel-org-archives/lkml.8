Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDEEC33CAB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2A02082E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgAMJ0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 04:26:38 -0500
Received: from gloria.sntech.de ([185.11.138.130]:53204 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgAMJ0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 04:26:38 -0500
Received: from wf0253.dip.tu-dresden.de ([141.76.180.253] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iqvzU-000219-9u; Mon, 13 Jan 2020 10:26:32 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: add reg property to brcmf sub node
Date:   Mon, 13 Jan 2020 10:26:31 +0100
Message-ID: <2116127.mXfZQK7onI@phil>
In-Reply-To: <CA+z=w3UjX71Nw7W+iiGkQh=UJkPMsEn1phSdp25d--O8QM-ETQ@mail.gmail.com>
References: <20200110142128.13522-1-jbx6244@gmail.com> <CA+z=w3UjX71Nw7W+iiGkQh=UJkPMsEn1phSdp25d--O8QM-ETQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Am Freitag, 10. Januar 2020, 16:40:24 CET schrieb Johan Jonker:
> Hi,
> 
> Question for Heiko or rob+dt.
> Where would should #address-cells and #size-cells go in the dts or to the dtsi.
> In case they become required in a futhure rockchip-dw-mshc.yaml?
> ie. Should we patch all XXX rockchip,rk3288-dw-mshc nodes with them?

I don't think it is a required property for the dw-mmc itself, as only
in special-cases do you need subnodes there. Like emmc and sd-cards
are completely probeable without needing further information and
only the wifi/bt chips _might_ need these.

So I don't think that this is a property of the controller itself, but te
connected card - hence should stay in the board file.

Heiko


> 
> Thanks
> 
> 2020-01-10 15:21 GMT+01:00, Johan Jonker <jbx6244@gmail.com>:
> > An experimental test with the command below gives this error:
> > rk3399-firefly.dt.yaml: dwmmc@fe310000: wifi@1:
> > 'reg' is a required property
> > rk3399-orangepi.dt.yaml: dwmmc@fe310000: wifi@1:
> > 'reg' is a required property
> > rk3399-khadas-edge.dt.yaml: dwmmc@fe310000: wifi@1:
> > 'reg' is a required property
> > rk3399-khadas-edge-captain.dt.yaml: dwmmc@fe310000: wifi@1:
> > 'reg' is a required property
> > rk3399-khadas-edge-v.dt.yaml: dwmmc@fe310000: wifi@1:
> > 'reg' is a required property
> > So fix this by adding a reg property to the brcmf sub node.
> > Also add #address-cells and #size-cells to prevent more warnings.
> >
> > make ARCH=arm64 dtbs_check
> > DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> >
> > Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3399-firefly.dts      | 3 +++
> >  arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi | 3 +++
> >  arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts     | 3 +++
> >  3 files changed, 9 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
> > b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
> > index 92de83dd4..06043179f 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
> > @@ -669,9 +669,12 @@
> >  	vqmmc-supply = &vcc1v8_s3;	/* IO line */
> >  	vmmc-supply = &vcc_sdio;	/* card's power */
> >
> > +	#address-cells = <1>;
> > +	#size-cells = <0>;
> >  	status = "okay";
> >
> >  	brcmf: wifi@1 {
> > +		reg = <1>;
> >  		compatible = "brcm,bcm4329-fmac";
> >  		interrupt-parent = <&gpio0>;
> >  		interrupts = <RK_PA3 GPIO_ACTIVE_HIGH>;
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
> > b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
> > index 4944d78a0..e87a04477 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
> > @@ -654,9 +654,12 @@
> >  	sd-uhs-sdr104;
> >  	vqmmc-supply = <&vcc1v8_s3>;
> >  	vmmc-supply = <&vccio_sd>;
> > +	#address-cells = <1>;
> > +	#size-cells = <0>;
> >  	status = "okay";
> >
> >  	brcmf: wifi@1 {
> > +		reg = <1>;
> >  		compatible = "brcm,bcm4329-fmac";
> >  		interrupt-parent = <&gpio0>;
> >  		interrupts = <RK_PA3 GPIO_ACTIVE_HIGH>;
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
> > b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
> > index 0541dfce9..9c659f311 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
> > @@ -648,9 +648,12 @@
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
> >  	sd-uhs-sdr104;
> > +	#address-cells = <1>;
> > +	#size-cells = <0>;
> >  	status = "okay";
> >
> >  	brcmf: wifi@1 {
> > +		reg = <1>;
> >  		compatible = "brcm,bcm4329-fmac";
> >  		interrupt-parent = <&gpio0>;
> >  		interrupts = <RK_PA3 GPIO_ACTIVE_HIGH>;
> > --
> > 2.11.0
> >
> >
> 




