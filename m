Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AF8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBB7C20756
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgETOEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 10:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETOEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 10:04:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7B5C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 07:04:51 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1jbPKq-0006ID-Kl; Wed, 20 May 2020 16:04:40 +0200
Message-ID: <ebcfc9843b57c5611b2106a3fe3553efb48734f0.camel@pengutronix.de>
Subject: Re: [PATCH 2/3] drm/etnaviv: Don't ignore errors on getting clocks
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Lubomir Rintel <lkundrak@v3.sk>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     The etnaviv authors <etnaviv@lists.freedesktop.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Fabio Estevam <festevam@gmail.com>
Date:   Wed, 20 May 2020 16:04:39 +0200
In-Reply-To: <20200520133824.GK1695525@furthur.local>
References: <20200513150007.1315395-1-lkundrak@v3.sk>
         <20200513150007.1315395-3-lkundrak@v3.sk>
         <CAOMZO5B582=tZ_YBCyVYFtGh=z5hZKFxP7XoUHEmH3jZsk2uYQ@mail.gmail.com>
         <CAOMZO5BdiXCVXs+8jP7PoRvgKd1sxCu4KhjvJBvL=Qig2WOs4g@mail.gmail.com>
         <1e15be39906034a95b86c026e060ed9866586d94.camel@pengutronix.de>
         <20200514082755.GN1551@shell.armlinux.org.uk>
         <ab384507b90474b0030d8ce64fdcfe868b52c3cb.camel@pengutronix.de>
         <20200514085307.GO1551@shell.armlinux.org.uk>
         <20200520133824.GK1695525@furthur.local>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, den 20.05.2020, 15:38 +0200 schrieb Lubomir Rintel:
> On Thu, May 14, 2020 at 09:53:08AM +0100, Russell King - ARM Linux admin wrote:
> > On Thu, May 14, 2020 at 10:40:58AM +0200, Lucas Stach wrote:
> > > Am Donnerstag, den 14.05.2020, 09:27 +0100 schrieb Russell King - ARM Linux admin:
> > > > On Thu, May 14, 2020 at 10:18:02AM +0200, Lucas Stach wrote:
> > > > > Am Mittwoch, den 13.05.2020, 23:41 -0300 schrieb Fabio Estevam:
> > > > > > On Wed, May 13, 2020 at 2:09 PM Fabio Estevam <festevam@gmail.com> wrote:
> > > > > > 
> > > > > > > The binding doc Documentation/devicetree/bindings/gpu/vivante,gc.yaml
> > > > > > > says that only the 'reg' clock could be optional, the others are
> > > > > > > required.
> > > > > > 
> > > > > > arch/arm/boot/dts/dove.dtsi only uses the 'core' clock.
> > > > > > arch/arm/boot/dts/stm32mp157.dtsi uses 'bus' and 'core'
> > > > > > 
> > > > > > Maybe the binding needs to be updated and it seems that using
> > > > > > devm_clk_get_optional() like you propose is safe.
> > > > > 
> > > > > The binding is correct as-is. We want to require those clocks to be
> > > > > present, but the dove DT was added before the binding was finalized, so
> > > > > the driver still treats the clocks as optional to not break
> > > > > compatibility with old DTs. Maybe this warrants a comment in the
> > > > > code...
> > > > 
> > > > The binding doc in mainline says:
> > > > 
> > > >   clocks:
> > > >     items:
> > > >       - description: AXI/master interface clock
> > > >       - description: GPU core clock
> > > >       - description: Shader clock (only required if GPU has feature PIPE_3D)
> > > >       - description: AHB/slave interface clock (only required if GPU can gate slave interface independently)
> > > >     minItems: 1
> > > >     maxItems: 4
> > > > 
> > > >   clock-names:
> > > >     items:
> > > >       enum: [ bus, core, shader, reg ]
> > > >     minItems: 1
> > > >     maxItems: 4
> > > > 
> > > > which looks correct to me - and means that Dove is compliant with that.
> > > 
> > > The YAML binding actually did loose something in translation here,
> > > which I didn't notice. Previously all those clocks were listed under
> > > "Required properties", with the exceptions listed in parenthesis. So
> > > the Dove GPU, which is a combined 2D/3D core should have axi, core and
> > > shader clocks specified.
> > 
> > That may be your desire, but that is impossible without knowing that
> > (a) it has the clocks
> > (b) what those clocks are connected to
> > 
> > I guess we could "make something up" but as DT is supposed to describe
> > hardware, I don't see how we can satisfy that and your requirement.
> > 
> > The only thing that is known from the documentation is that there is
> > one clock for the GPU on Dove.
> 
> Yes. This means that in fact "core" is the only required clock for all
> implementations of vivante,gc and the common binding needs to be updated
> to reflect that. I'll follow with a patch that does that, unless there
> are strong objections.
> 
> If there are implementations that require different clock inputs, then they
> need to use additional compatible string for the particular flavor and the
> binding should have conditionals for them. Something like this:
> 
>   if:
>     properties:
>       compatible:
>         contains:
>           const: fsl,imx6sx-gpu
>   then:
>     properties:
>       clocks:
>         minItems: 4

The DT binding of a device should describe the hardware of the device,
not the specific integration into a SoC. Now it's a bit hard to make
any definite statements about the Vivante GC GPU module itself, as most
of the information we have is from reverse engineering. It's pretty
clear though that the GPU module has at least 2 clock inputs: axi and
core, as there is a feature bit that tells us if it's okay to gate the
axi clock independently from core. 

I'm not 100% sure about the older cores as found in Dove, but all the
more recent cores allow to clock the shader partition independently of
the core partition, so that's another clock input.

Now when it comes to a SoC integration, it's totally fine to have all
those GPU module clock inputs fed from the same clock source and behind
a shared gate maybe. But that doesn't change the clock inputs from the
device perspective, it's still 3 independent clock inputs, which then
just point to the same clock source in the DT.

imx6sx.dtsi is even a precedent of such a setup: all module clock
inputs are fed by a common clock and share a single gate.

Regards,
Lucas

