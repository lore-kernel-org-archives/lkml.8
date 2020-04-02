Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99C5C2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18DB206F5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388759AbgDBOtY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:49:24 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46876 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388516AbgDBOtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:49:24 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jK19j-0008Cn-0m; Thu, 02 Apr 2020 16:49:19 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     helen.koike@collabora.com, dafna.hirschfeld@collabora.com,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        ezequiel@collabora.com, hverkuil-cisco@xs4all.nl,
        karthik.poduval@gmail.com, kernel@collabora.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, mark.rutland@arm.com,
        robh+dt@kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: add rx0 mipi-phy for rk3399
Date:   Thu, 02 Apr 2020 16:49:18 +0200
Message-ID: <3198644.TY9RtKZRLE@diego>
In-Reply-To: <76211530-73ff-5f36-8915-8bdc036d4369@gmail.com>
References: <20200402000234.226466-4-helen.koike@collabora.com> <105956984.FXDh2DO4ZE@diego> <76211530-73ff-5f36-8915-8bdc036d4369@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 2. April 2020, 16:37:52 CEST schrieb Johan Jonker:
> On 4/2/20 4:31 PM, Heiko Stübner wrote:
> > Am Donnerstag, 2. April 2020, 15:48:02 CEST schrieb Johan Jonker:
> >> Hi Helen,
> >>
> >>> From: Helen Koike <helen.koike@collabora.com>
> >>
> >>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> >>> index 33cc21fcf4c10..fc0295d2a65a1 100644
> >>> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> >>> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> >>> @@ -1394,6 +1394,17 @@ io_domains: io-domains {
> >>>  			status = "disabled";
> >>>  		};
> >>>  
> >>
> >>> +		mipi_dphy_rx0: mipi-dphy-rx0 {
> >>
> >> For Heiko sort syscon@ff770000 subnodes alphabetical or reg value first?
> > 
> > Similar to main nodes ... so things without reg alphabetical,
> > the rest by reg address
> > 
> alphabetical first:
> 
> io-domains
> mipi-dphy-rx0
> usb2-phy@e450

like this ... aka similar to what we do in the core nodes.

For the record, pinctrl at the bottom of a soc.dtsi is ok.


Heiko

> .@..
> 
> or
> 
> with reg values first:
> 
> .@..
> emmc_phy: phy@f780
> mipi-dphy-rx0
> pcie-phy
> 
> > 
> >>
> >>> +			compatible = "rockchip,rk3399-mipi-dphy-rx0";
> >>> +			clocks = <&cru SCLK_MIPIDPHY_REF>,
> >>
> >>> +				<&cru SCLK_DPHY_RX0_CFG>,
> >>> +				<&cru PCLK_VIO_GRF>;
> >>
> >> Align                            ^
> >>
> >>> +			clock-names = "dphy-ref", "dphy-cfg", "grf";
> >>> +			power-domains = <&power RK3399_PD_VIO>;
> >>> +			#phy-cells = <0>;
> >>> +			status = "disabled";
> >>> +		};
> >>> +
> >>>  		u2phy0: usb2-phy@e450 {
> >>>  			compatible = "rockchip,rk3399-usb2phy";
> >>>  			reg = <0xe450 0x10>;
> >>
> >>
> > 
> > 
> > 
> > 
> 
> 




