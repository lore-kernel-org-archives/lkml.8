Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D82FC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74A3820857
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgDTQc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:32:28 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:35914 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgDTQc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 12:32:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 380E6FB03;
        Mon, 20 Apr 2020 18:32:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id f8gHlc_cdbh4; Mon, 20 Apr 2020 18:32:25 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 5748D400FB; Mon, 20 Apr 2020 18:32:24 +0200 (CEST)
Date:   Mon, 20 Apr 2020 18:32:24 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mq-librem5-devkit: Use 0.9V for VDD_GPU
Message-ID: <20200420163224.GA44571@bogon.m.sigxcpu.org>
References: <d9bfb11e3d66376792089d54d7d52fe3778efa33.1584636213.git.agx@sigxcpu.org>
 <20200420145459.GE32419@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200420145459.GE32419@dragon>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Mon, Apr 20, 2020 at 10:54:59PM +0800, Shawn Guo wrote:
> On Thu, Mar 19, 2020 at 05:46:02PM +0100, Guido Günther wrote:
> > According to the imx8mq data sheet running VDD_GPU at 0.9V is enough
> > when not overclocking to 1GHz (which we currently don't do).
> > 
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> 
> It doesn't apply to my branch.

This was against linux next when i sent it, can you link to the branch
it should apply to please?
 -- Guido

> 
> Shawn
> 
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> > index c47a26cf8e43..736b250bc9c2 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> > @@ -318,7 +318,7 @@
> >  				regulator-min-microvolt = <700000>;
> >  				regulator-max-microvolt = <1300000>;
> >  				regulator-always-on;
> > -				rohm,dvs-run-voltage = <1000000>;
> > +				rohm,dvs-run-voltage = <900000>;
> >  			};
> >  
> >  			buck4_reg: BUCK4 {
> > -- 
> > 2.23.0
> > 
> 
