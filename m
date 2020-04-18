Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03744C38A2B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 10:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E15D6221F4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 10:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgDRKxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 06:53:38 -0400
Received: from gloria.sntech.de ([185.11.138.130]:48358 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgDRKxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 06:53:37 -0400
Received: from p57b77241.dip0.t-ipconnect.de ([87.183.114.65] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jPl6J-00011g-3g; Sat, 18 Apr 2020 12:53:31 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Justin Swartz <justin.swartz@risingedge.co.za>
Cc:     Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, mark.rutland@arm.com,
        robh+dt@kernel.org
Subject: Re: [PATCH v4 2/3] ARM: dts: rockchip: add rga node for rk322x
Date:   Sat, 18 Apr 2020 12:53:30 +0200
Message-ID: <2533855.f5ZhyS2AsA@phil>
In-Reply-To: <b77422198df7c285d824086131371284@risingedge.co.za>
References: <be4f2c802a64562cbab629abc82dd7d228a1a747.1580768038.git.justin.swartz@risingedge.co.za> <3593382.iQIKm1rSL1@phil> <b77422198df7c285d824086131371284@risingedge.co.za>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 18. April 2020, 11:56:03 CEST schrieb Justin Swartz:
> Hi Johan, Heiko,
> 
> On 2020-04-18 11:49, Heiko Stuebner wrote:
> 
> > Am Samstag, 18. April 2020, 11:15:27 CEST schrieb Johan Jonker:
> > 
> >> Hi Justin, Heiko,
> >> 
> >> In the discussion about "rockchip,px30-rga" it was mentioned that:
> >> "no status for soc internal components without any board-specifics".
> >> The binding is in mainline, but the dts node is missing I think.
> >> Should this also be changed?
> > 
> > yep, drop the status disabled from the dtsi and that then results
> > in not needing the board-level enablement
> > 
> > (background: rga is a simple mem2mem device without any
> > board-specific hooks)
> 
> Shall I submit version 5 of this patch series?

I guess so ... especially as we expect patch1 to go through the
media tree and sending a new version might serve as a ping :-)
and include the Ack by Rob for easy applying


Heiko


> 
> > Johan
> > 
> > +&rga {
> > +    status = "okay";
> > +};
> > +
> > 
> > Add a node to define the presence of RGA, a 2D raster
> > graphic acceleration unit.
> > 
> > Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
> > ---
> > arch/arm/boot/dts/rk322x.dtsi | 11 +++++++++++
> > 1 file changed, 11 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/rk322x.dtsi 
> > b/arch/arm/boot/dts/rk322x.dtsi
> > index 340ed6ccb..29d50bebc 100644
> > --- a/arch/arm/boot/dts/rk322x.dtsi
> > +++ b/arch/arm/boot/dts/rk322x.dtsi
> > @@ -621,6 +621,17 @@
> > status = "disabled";
> > };
> > 
> > +    rga: rga@20060000 {
> > +        compatible = "rockchip,rk3228-rga", "rockchip,rk3288-rga";
> > +        reg = <0x20060000 0x1000>;
> > +        interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> > +        clocks = <&cru ACLK_RGA>, <&cru HCLK_RGA>, <&cru SCLK_RGA>;
> > +        clock-names = "aclk", "hclk", "sclk";
> > +        resets = <&cru SRST_RGA>, <&cru SRST_RGA_A>, <&cru 
> > SRST_RGA_H>;
> > +        reset-names = "core", "axi", "ahb";
> > +        status = "disabled";
> > remove?
> > 
> > +    };
> > +
> > iep_mmu: iommu@20070800 {
> > compatible = "rockchip,iommu";
> > reg = <0x20070800 0x100>;
> 




