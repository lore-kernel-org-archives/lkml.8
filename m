Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0DAC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 14:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5678A206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 14:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="R5hKELuj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbgG1OFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 10:05:50 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:2343 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730211AbgG1OFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 10:05:49 -0400
IronPort-SDR: 9rVtzBnD6A5OKhyNl21/X/x5qCc5m8+RXg3wl/dKLgwSuapmG2Fm/gKVgaNfrLMrjMLHR+2wX5
 dMiDTTW8BuXXcTvCT+cO0cVbtJQ3HrfrjAEE3XdgtwDb4RpzgKe2sQcW7NBw37CY8Mht3mSHVl
 IfOF/pHHFku+5MIzCokG91VqithBCYagMgdIRDRFfh81u1YnscN3bQPLHl+O1IFDD/fGVsnvFi
 MfDKte5skXU6zapRsxB59ktCqJPnsuamVDgqEkjzuK7CsIOKDbQi3UbBGwpYnV3oF9CTNZE0eE
 Tw0=
X-IronPort-AV: E=Sophos;i="5.75,406,1589234400"; 
   d="scan'208";a="13265251"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 28 Jul 2020 16:05:47 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 28 Jul 2020 16:05:47 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 28 Jul 2020 16:05:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1595945147; x=1627481147;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8xSG/F2gvCwdxzDaRbBlDsjYKXzG6JG+0E3m3q1z7jA=;
  b=R5hKELujCuAAgDrHfnlh8BwD5YVvYvG+qdxPH+TTAKRL/l6jZi+RqnQ+
   +s+Hn+iHh9vyzsIFQH8eOsSTIcLv8VzeYjF+GclqEmTQlwakAsOYPEIz3
   0gXpEAWnTeJaT5dCPR72OJekvthRlrz3W/20hol33dfVZld7vkRnctu9A
   OWWq3G3r5lJ61vLigQVTbPot4XKs1tZZ0FX3jfu8aQlqcm+daNjYX//3E
   7TfOXn+s6HDscHFMSfJYRUyjjjW8KuQOiwFkGFqGfevXGqILo0viSeocs
   PT/TFKo49Ssy+L7b/p6RiIOW2+TuHh2jg5xo/Md8IZTvimhrpaUDPina4
   A==;
IronPort-SDR: Qo4GZXqj6aPQr1FabmXcmOi6BmJI01chr0R5EOpeCzHVZISWjmdIdMk3zcf4c3Xw/OJwGHPmLG
 0kzG3ci5mb/K2if1KTpVaV0peiEKC80UVL5hy7BHqCq1Urta/ZZI7ZJl0GgzWt2NAu/gL0YT3K
 ewlShmNXUuJ7YaHWNDWMDz0xbE/5Nk+Ys55EybHlRjzi3ptqryWlzkmUhgfHeTCYKbe1RKbNdL
 Hy4lLcr5VuTzzUXx+7k7XrzUhSThxo3ekvVcxgn1tMKG1O+TmfX6VqZgWmi6LJNO6q7jsH4f1x
 fMI=
X-IronPort-AV: E=Sophos;i="5.75,406,1589234400"; 
   d="scan'208";a="13265250"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 28 Jul 2020 16:05:47 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 42966280065;
        Tue, 28 Jul 2020 16:05:47 +0200 (CEST)
Message-ID: <8ea0b3f655b60be02384f22c0aa4dfee9d788d71.camel@ew.tq-group.com>
Subject: Re: (EXT) Re: [PATCH] arm: dts: imx7: add QSPI
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 28 Jul 2020 16:05:47 +0200
In-Reply-To: <20200728135155.aqz3xkcwpgqmvzro@pengutronix.de>
References: <20200728112814.14158-1-matthias.schiffer@ew.tq-group.com>
         <20200728135155.aqz3xkcwpgqmvzro@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-07-28 at 15:51 +0200, Marco Felsch wrote:
> Hi Matthias,
> 
> thanks for the patch.
> 
> On 20-07-28 13:28, Matthias Schiffer wrote:
> > In preparation for an update of the TQ-Systems TQMa7x/MBa7x DTS,
> > add the
> > QSPI controller to imx7s.dtsi.
> > 
> > Based-on-patch-by: Han Xu <han.xu@nxp.com>
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com
> > >
> > ---
> >  arch/arm/boot/dts/imx7s.dtsi | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx7s.dtsi
> > b/arch/arm/boot/dts/imx7s.dtsi
> > index 1cfaf410aa43..e45683e61593 100644
> > --- a/arch/arm/boot/dts/imx7s.dtsi
> > +++ b/arch/arm/boot/dts/imx7s.dtsi
> > @@ -1162,6 +1162,19 @@
> >  				status = "disabled";
> >  			};
> >  
> > +			qspi1: spi@30bb0000 {
> 
> Are there more controllers and why not using "qspi@30bb0000" as node
> name?

The vast majority of QSPI controllers use spi@ node names, qspi@ only
appears in a single example in Documentation/devicetree/bindings/, and
in no actual DTS(I) files.

There is only one controller. The label "qspi1" is chosen as this has
been in use in the linux-imx vendor kernels for years; IMHO, switching
to "qspi" would just cause unnecessary churn for dependent device
trees. I have no strong opinions on this though.

> 
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				compatible = "fsl,imx7d-qspi";
> > +				reg = <0x30bb0000 0x10000>, <0x60000000
> > 0x10000000>;
> > +				reg-names = "QuadSPI", "QuadSPI-
> > memory";
> 
> The node should begin with compatible, reg, reg-names properties.
> Pls check the current .dtsi file for examples.

Thanks, will fix.

> 
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
> Regards,
>   Marco

