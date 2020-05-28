Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAC2C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 03:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78812214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 03:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgE1Djp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 23:39:45 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:42817 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgE1Djo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 23:39:44 -0400
X-Originating-IP: 86.202.110.81
Received: from localhost (lfbn-lyo-1-15-81.w86-202.abo.wanadoo.fr [86.202.110.81])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 0F3A8FF806;
        Thu, 28 May 2020 03:39:41 +0000 (UTC)
Date:   Thu, 28 May 2020 05:39:41 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh@kernel.org>
List-Id: <soc.lore.kernel.org>
Cc:     Lars Povlsen <lars.povlsen@microchip.com>,
        Guenter Roeck <linux@roeck-us.net>, SoC Team <soc@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: sparx5: Add hwmon temperature sensor
Message-ID: <20200528033941.GQ3972@piout.net>
References: <20200513134140.25357-1-lars.povlsen@microchip.com>
 <20200513134140.25357-3-lars.povlsen@microchip.com>
 <20200528022931.GA3238321@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528022931.GA3238321@bogus>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 27/05/2020 20:29:31-0600, Rob Herring wrote:
> On Wed, May 13, 2020 at 03:41:39PM +0200, Lars Povlsen wrote:
> > This adds a hwmon temperature node sensor to the Sparx5 SoC.
> > 
> > Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
> > ---
> >  arch/arm64/boot/dts/microchip/sparx5.dtsi | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
> > index f09a49c41ce19..b5f2d088af30e 100644
> > --- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
> > +++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
> > @@ -233,5 +233,11 @@ i2c1: i2c@600103000 {
> >  			clock-frequency = <100000>;
> >  			clocks = <&ahb_clk>;
> >  		};
> > +
> > +		tmon0: tmon@610508110 {
> > +			compatible = "microchip,sparx5-temp";
> > +			reg = <0x6 0x10508110 0xc>;
> 
> These nodes are all very odd with a couple of registers spread out at 
> randomish addresses. DT nodes should roughly correlate to h/w blocks, 
> not sets of registers for a driver like this seems to be.
> 

The DT nodes correlates to HW block, this and the previous families of
SoCs were designed with packed registers. There is no padding between HW
block registers.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
