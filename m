Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E0FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D89220838
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgG2H6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 03:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgG2H6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 03:58:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED47C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 00:58:44 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1k0gz3-0007if-Qp; Wed, 29 Jul 2020 09:58:41 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1k0gz3-0005B2-63; Wed, 29 Jul 2020 09:58:41 +0200
Date:   Wed, 29 Jul 2020 09:58:41 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2] arm: dts: imx7: add QSPI
Message-ID: <20200729075841.2fiudq2ypcbvlymx@pengutronix.de>
References: <20200729071106.8213-1-matthias.schiffer@ew.tq-group.com>
 <33fbac338c9d9accda37837eb1338003b28cafee.camel@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33fbac338c9d9accda37837eb1338003b28cafee.camel@ew.tq-group.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:57:24 up 256 days, 23:15, 248 users,  load average: 0.29, 0.22,
 0.14
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 20-07-29 09:14, Matthias Schiffer wrote:
> On Wed, 2020-07-29 at 09:11 +0200, Matthias Schiffer wrote:
> > In preparation for an update of the TQ-Systems TQMa7x/MBa7x DTS, add
> > the
> > QSPI controller to imx7s.dtsi.
> > 
> > Based-on-patch-by: Han Xu <han.xu@nxp.com>
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > ---
> > 
> > v2:
> > - renamed node and label
> > - reordered properties
> > (as suggested by Marco Felsch)
> 
> Ugh, I neglected to check for compile warnings after adjusting the node
> name. This now gives the following warning:
> 
> arch/arm/boot/dts/imx7s.dtsi:1165.24-1176.6: Warning (spi_bus_bridge): 
> /soc/bus@30800000/qspi@30bb0000: node name for SPI buses should be
> 'spi'
> 
> So I guess this should be called spi@ after all?

Unfortunately yes, this would cause a longer discussion but it still
seems wrong to me.

Regards,
  Marco

> > 
> > 
> >  arch/arm/boot/dts/imx7s.dtsi | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx7s.dtsi
> > b/arch/arm/boot/dts/imx7s.dtsi
> > index 1cfaf410aa43..22e4c38223bd 100644
> > --- a/arch/arm/boot/dts/imx7s.dtsi
> > +++ b/arch/arm/boot/dts/imx7s.dtsi
> > @@ -1162,6 +1162,19 @@
> >  				status = "disabled";
> >  			};
> >  
> > +			qspi: qspi@30bb0000 {
> > +				compatible = "fsl,imx7d-qspi";
> > +				reg = <0x30bb0000 0x10000>, <0x60000000
> > 0x10000000>;
> > +				reg-names = "QuadSPI", "QuadSPI-
> > memory";
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				interrupts = <GIC_SPI 107
> > IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clks IMX7D_QSPI_ROOT_CLK>,
> > +					<&clks IMX7D_QSPI_ROOT_CLK>;
> > +				clock-names = "qspi_en", "qspi";
> > +				status = "disabled";
> > +			};
> > +
> >  			sdma: sdma@30bd0000 {
> >  				compatible = "fsl,imx7d-sdma",
> > "fsl,imx35-sdma";
> >  				reg = <0x30bd0000 0x10000>;
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
