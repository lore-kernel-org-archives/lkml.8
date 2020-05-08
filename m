Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE74DC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B54E420870
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgEHK4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 06:56:01 -0400
Received: from gloria.sntech.de ([185.11.138.130]:58096 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbgEHK4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 06:56:00 -0400
Received: from p5b127ea8.dip0.t-ipconnect.de ([91.18.126.168] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jX0fV-0004DA-5n; Fri, 08 May 2020 12:55:49 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     devicetree@vger.kernel.org, ezequiel@collabora.com,
        hansverk@cisco.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, mchehab@kernel.org,
        robh+dt@kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH v3 2/4] arm64: dts: rockchip: Add RGA support to the PX30
Date:   Fri, 08 May 2020 12:55:48 +0200
Message-ID: <2855296.rNCsY6NMd3@phil>
In-Reply-To: <7112d1fa-a872-c66f-0ece-a77ba1f852de@gmail.com>
References: <20200430164245.1630174-3-paul.kocialkowski@bootlin.com> <20200507202558.GK2422122@aptenodytes> <7112d1fa-a872-c66f-0ece-a77ba1f852de@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 8. Mai 2020, 01:40:08 CEST schrieb Johan Jonker:
> Hi Paul,
> 
> On 5/7/20 10:25 PM, Paul Kocialkowski wrote:
> > Hi,
> > 
> > On Fri 01 May 20, 00:05, Johan Jonker wrote:
> >> Hi Paul,
> >>
> >>> The PX30 features a RGA block: add the necessary node to support it.
> >>>
> >>> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> >>> ---
> >>>  arch/arm64/boot/dts/rockchip/px30.dtsi | 11 +++++++++++
> >>>  1 file changed, 11 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
> >>> index f809dd6d5dc3..3de70aa4f1ce 100644
> >>> --- a/arch/arm64/boot/dts/rockchip/px30.dtsi
> >>> +++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
> >>> @@ -1102,6 +1102,17 @@ vopl_mmu: iommu@ff470f00 {
> >>>  		status = "disabled";
> >>>  	};
> >>>  
> >>> +	rga: rga@ff480000 {
> >>> +		compatible = "rockchip,px30-rga", "rockchip,rk3288-rga";
> >>> +		reg = <0x0 0xff480000 0x0 0x10000>;
> >>> +		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH 0>;
> >>> +		clocks = <&cru ACLK_RGA>, <&cru HCLK_RGA>, <&cru SCLK_RGA_CORE>;
> >>> +		clock-names = "aclk", "hclk", "sclk";
> >>
> >>> +		resets = <&cru SRST_RGA>, <&cru SRST_RGA_A>, <&cru SRST_RGA_H>;
> >>> +		reset-names = "core", "axi", "ahb";
> >>> +		power-domains = <&power PX30_PD_VO>;
> >>
> >> sort
> >>
> >> 		power-domains = <&power PX30_PD_VO>;
> >> 		resets = <&cru SRST_RGA>, <&cru SRST_RGA_A>, <&cru SRST_RGA_H>;
> >> 		reset-names = "core", "axi", "ahb";
> > 
> > What's the rationale behind this (besides alphabetic sorting, which I don't
> > believe is a rule for dt properties)? Some nodes above in the file have it in
> > the same order that I do, and I like to see clocks followed by resets.
> 
> My short list.
> There is no hard rule... It mostly depend on Heiko...

For the record, if needed I do any re-sorting myself normally, so there is
no need to respin patches just because nodes are sorted differently.

But yes, since the early Chromebook project in 2014 we agreed on
doing in Rockchip dts files:

----
compatible
reg
interrupts
[alphabetical]
status [if needed]
----

This works most of the time, but sometimes gets missed but is not _that_
big a deal if that happens ;-) .


Heiko


> For nodes:
> If exists on top: model, compatible and chosen.
> Sort things without reg alphabetical first,
> then sort the rest by reg address.
> 
> Inside nodes:
> If exists on top: compatible, reg and interrupts.
> In alphabetical order the required properties.
> Then in alphabetical order the other properties.
> And as last things that start with '#' in alphabetical order.
> Add status below all other properties for soc internal components with
> any board-specifics.
> Keep an empty line between properties and nodes.
> 
> Exceptions:
> Sort pinctrl-0 above pinctrl-names, so it stays in line with clock-names
> and dma-names.
> Sort simple-audio-card,name above other simple-audio-card properties.
> Sort regulator-name above other regulator properties.
> Sort regulator-min-microvolt above regulator-max-microvolt.
> 
> > 
> > Cheers,
> > 
> > Paul
> > 
> >>
> >>
> >>> +	};
> >>> +
> >>>  	qos_gmac: qos@ff518000 {
> >>>  		compatible = "syscon";
> >>>  		reg = <0x0 0xff518000 0x0 0x20>;
> >>
> > 
> 
> 




