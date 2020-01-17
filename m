Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7196FC33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 550C720748
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgAQSTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 13:19:03 -0500
Received: from mailoutvs11.siol.net ([185.57.226.202]:49903 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726970AbgAQSTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 13:19:03 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 3B8B7523E9F;
        Fri, 17 Jan 2020 19:19:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id KYaxS-gW__TX; Fri, 17 Jan 2020 19:18:59 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id DB642523E5B;
        Fri, 17 Jan 2020 19:18:59 +0100 (CET)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id F2837523EA2;
        Fri, 17 Jan 2020 19:18:58 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: allwinner: h6: tanix-tx6: enable emmc
Date:   Fri, 17 Jan 2020 19:18:58 +0100
Message-ID: <3332569.R56niFO833@jernej-laptop>
In-Reply-To: <20200117181427.hy7qsyxwomsl3v2q@gilmour.lan>
References: <20200115193441.172902-1-jernej.skrabec@siol.net> <20200117181427.hy7qsyxwomsl3v2q@gilmour.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 17. januar 2020 ob 19:14:27 CET je Maxime Ripard napisal(a):
> On Wed, Jan 15, 2020 at 08:34:41PM +0100, Jernej Skrabec wrote:
> > Tanix TX6 has 32 GiB eMMC. Add a node for it.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> >  .../dts/allwinner/sun50i-h6-tanix-tx6.dts     | 20 +++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> > b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts index
> > 83e6cb0e59ce..8cbf4e4a761e 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> > @@ -31,6 +31,13 @@ hdmi_con_in: endpoint {
> > 
> >  		};
> >  	
> >  	};
> > 
> > +	reg_vcc1v8: vcc1v8 {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vcc1v8";
> > +		regulator-min-microvolt = <1800000>;
> > +		regulator-max-microvolt = <1800000>;
> > +	};
> > +
> > 
> >  	reg_vcc3v3: vcc3v3 {
> >  	
> >  		compatible = "regulator-fixed";
> >  		regulator-name = "vcc3v3";
> > 
> > @@ -78,6 +85,15 @@ &mmc0 {
> > 
> >  	status = "okay";
> >  
> >  };
> > 
> > +&mmc2 {
> > +	vmmc-supply = <&reg_vcc3v3>;
> > +	vqmmc-supply = <&reg_vcc1v8>;
> > +	non-removable;
> > +	cap-mmc-hw-reset;
> > +	bus-width = <8>;
> > +	status = "okay";
> > +};
> > +
> > 
> >  &ohci0 {
> >  
> >  	status = "okay";
> >  
> >  };
> > 
> > @@ -86,6 +102,10 @@ &ohci3 {
> > 
> >  	status = "okay";
> >  
> >  };
> > 
> > +&pio {
> > +	vcc-pc-supply = <&reg_vcc1v8>;
> > +};
> > +
> 
> Can you list all of the regulators for the H6 while you're at it (in a
> preliminary patch, ideally)?

Not sure what you mean. This box has only fixed regulators. I deducted above 
from the fact that port C is mostly dedicated to eMMC, so it has to use same 
regulator as vqmmc. Other than that, I don't know.

Best regards,
Jernej




