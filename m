Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2263EC54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02F4720722
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="XODGn7RM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgDTNXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:23:35 -0400
Received: from plaes.org ([188.166.43.21]:35158 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgDTNXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:23:34 -0400
Received: from plaes.org (localhost [127.0.0.1])
        by plaes.org (Postfix) with ESMTPSA id CCD8740A7B;
        Mon, 20 Apr 2020 13:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1587389012; bh=C6Dtbg3q0uXybP36NbU5y1NPoiLkrqHskL4a1HmkXWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XODGn7RM9T0LNlWavtietxGietUiG8szqR/r/Ex8cH53BxJoy/0sxZfiVUiDoNyuC
         hrg3crDPBSZHsnYNejAbkrjpBitLNS7R+huQ80GG4dy8r+h2Nfyw5rhFFtecBZ1Um3
         ZoNMkzvaBlAMYLnGKegF78CMqQtL4ru9+sqmfoCeJTrD7kIGeBPgWNxA+jRzS2MyGX
         kMV+h8IfKk/ua0qqJqxirDZ4WG7gS7AFPt7xX6nSe4fCS6tr/2f8z5Tr0Bqb9ZIZQF
         LCe15byUGKpGdooDQ5b1frNivo2UklScnIyoRZVHCxZljVoBSbbn15V66bxuwEkyKg
         1XIujwiTlFzFw==
Date:   Mon, 20 Apr 2020 13:23:31 +0000
From:   Priit Laes <plaes@plaes.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 4/4] ARM: dts: sun7i: Use syscon-based implementation for
 gmac
Message-ID: <20200420132331.GB18522@plaes.org>
References: <20200417221730.555954-1-plaes@plaes.org>
 <20200417221730.555954-5-plaes@plaes.org>
 <20200420125919.3bqosps7nzwvmasn@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420125919.3bqosps7nzwvmasn@gilmour.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 02:59:19PM +0200, Maxime Ripard wrote:
> On Sat, Apr 18, 2020 at 01:17:30AM +0300, Priit Laes wrote:
> > Use syscon-based approach to access gmac clock configuration
> > register, instead of relying on a custom clock driver.
> > 
> > As a bonus, we can now drop the custom clock implementation
> > and dummy clocks making sun7i fully CCU-compatible.
> > 
> > Signed-off-by: Priit Laes <plaes@plaes.org>
> > ---
> >  arch/arm/boot/dts/sun7i-a20.dtsi | 36 +++-----------------------------
> >  1 file changed, 3 insertions(+), 33 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> > index ffe1d10a1a84..750962a94fad 100644
> > --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> > +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> > @@ -219,37 +219,6 @@ osc32k: clk-32k {
> >  			clock-frequency = <32768>;
> >  			clock-output-names = "osc32k";
> >  		};
> > -
> > -		/*
> > -		 * The following two are dummy clocks, placeholders
> > -		 * used in the gmac_tx clock. The gmac driver will
> > -		 * choose one parent depending on the PHY interface
> > -		 * mode, using clk_set_rate auto-reparenting.
> > -		 *
> > -		 * The actual TX clock rate is not controlled by the
> > -		 * gmac_tx clock.
> > -		 */
> > -		mii_phy_tx_clk: clk-mii-phy-tx {
> > -			#clock-cells = <0>;
> > -			compatible = "fixed-clock";
> > -			clock-frequency = <25000000>;
> > -			clock-output-names = "mii_phy_tx";
> > -		};
> > -
> > -		gmac_int_tx_clk: clk-gmac-int-tx {
> > -			#clock-cells = <0>;
> > -			compatible = "fixed-clock";
> > -			clock-frequency = <125000000>;
> > -			clock-output-names = "gmac_int_tx";
> > -		};
> > -
> > -		gmac_tx_clk: clk@1c20164 {
> > -			#clock-cells = <0>;
> > -			compatible = "allwinner,sun7i-a20-gmac-clk";
> > -			reg = <0x01c20164 0x4>;
> > -			clocks = <&mii_phy_tx_clk>, <&gmac_int_tx_clk>;
> > -			clock-output-names = "gmac_tx";
> > -		};
> >  	};
> >  
> >  
> > @@ -1511,11 +1480,12 @@ mali: gpu@1c40000 {
> >  
> >  		gmac: ethernet@1c50000 {
> >  			compatible = "allwinner,sun7i-a20-gmac";
> > +			syscon = <&ccu>;
> >  			reg = <0x01c50000 0x10000>;
> >  			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
> >  			interrupt-names = "macirq";
> > -			clocks = <&ccu CLK_AHB_GMAC>, <&gmac_tx_clk>;
> > -			clock-names = "stmmaceth", "allwinner_gmac_tx";
> > +			clocks = <&ccu CLK_AHB_GMAC>;
> > +			clock-names = "stmmaceth";
> 
> I guess you also need to update the binding so that it considers it valid?

Yes, will do it in the next round.

> 
> Maxime


