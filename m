Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5B2C4BA12
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1572467B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgBZN6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 08:58:49 -0500
Received: from gloria.sntech.de ([185.11.138.130]:40764 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgBZN6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 08:58:49 -0500
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1j6xCz-0003gM-FU; Wed, 26 Feb 2020 14:58:41 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     ezequiel@collabora.com, boris.brezillon@collabora.com,
        devicetree@vger.kernel.org, hverkuil@xs4all.nl, jonas@kwiboo.se,
        kernel@collabora.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, nicolas@ndufresne.ca,
        paul.kocialkowski@bootlin.com, robh+dt@kernel.org,
        sakari.ailus@iki.fi, tfiga@chromium.org
Subject: Re: [PATCH v6 6/6] arm64: dts: rockchip: rk3399: Define the rockchip Video Decoder node
Date:   Wed, 26 Feb 2020 14:21:55 +0100
Message-ID: <3584403.hvncmGE4DP@phil>
In-Reply-To: <817821e3-bc51-8037-b9b9-e429c5eeb280@gmail.com>
References: <20200220163016.21708-7-ezequiel@collabora.com> <817821e3-bc51-8037-b9b9-e429c5eeb280@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 26. Februar 2020, 13:24:53 CET schrieb Johan Jonker:
> Hi Boris,
> 
> Dtsi nodes are sort on address.
> The vdec node is now inserted between:
> 
> vdec_mmu: iommu       @ff660480
> vdec    : video-codec @ff660000
> iep_mmu : iommu       @ff670800
> 
> This should be:
> 
> vpu_mmu : iommu       @ff650800
> vdec    : video-codec @ff660000
> vdec_mmu: iommu       @ff660480
> 

Simple things like this I can (and do) fix when applying.

The interesting question would be, did patches 1-5 get applied yet?
As I only remember seing Hans' mail from v5, but didn't get any
applied mail for v6 so far.


Heiko

> > From: Boris Brezillon <boris.brezillon at collabora.com>
> > 
> > RK3399 has a Video decoder, define the node in the dtsi. We also add
> > the missing power-domain in mmu node and enable the block.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon at collabora.com>
> > Signed-off-by: Ezequiel Garcia <ezequiel at collabora.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > index 33cc21fcf4c1..a07f857df12f 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > @@ -1285,8 +1285,20 @@ vdec_mmu: iommu at ff660480 {
> >  		interrupt-names = "vdec_mmu";
> >  		clocks = <&cru ACLK_VDU>, <&cru HCLK_VDU>;
> >  		clock-names = "aclk", "iface";
> > +		power-domains = <&power RK3399_PD_VDU>;
> >  		#iommu-cells = <0>;
> > -		status = "disabled";
> > +	};
> > +
> > +	vdec: video-codec at ff660000 {
> > +		compatible = "rockchip,rk3399-vdec";
> > +		reg = <0x0 0xff660000 0x0 0x400>;
> > +		interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH 0>;
> > +		interrupt-names = "vdpu";
> > +		clocks = <&cru ACLK_VDU>, <&cru HCLK_VDU>,
> > +			 <&cru SCLK_VDU_CA>, <&cru SCLK_VDU_CORE>;
> > +		clock-names = "axi", "ahb", "cabac", "core";
> > +		power-domains = <&power RK3399_PD_VDU>;
> > +		iommus = <&vdec_mmu>;
> >  	};
> >  
> >  	iep_mmu: iommu at ff670800 {
> 
> 
> 
> 




