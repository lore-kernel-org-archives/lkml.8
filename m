Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1A2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 13:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38720207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 13:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgETNib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 09:38:31 -0400
Received: from v6.sk ([167.172.42.174]:60732 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgETNib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 09:38:31 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 0F6AC61300;
        Wed, 20 May 2020 13:38:28 +0000 (UTC)
Date:   Wed, 20 May 2020 15:38:24 +0200
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: Re: [PATCH 2/3] drm/etnaviv: Don't ignore errors on getting clocks
Message-ID: <20200520133824.GK1695525@furthur.local>
References: <20200513150007.1315395-1-lkundrak@v3.sk>
 <20200513150007.1315395-3-lkundrak@v3.sk>
 <CAOMZO5B582=tZ_YBCyVYFtGh=z5hZKFxP7XoUHEmH3jZsk2uYQ@mail.gmail.com>
 <CAOMZO5BdiXCVXs+8jP7PoRvgKd1sxCu4KhjvJBvL=Qig2WOs4g@mail.gmail.com>
 <1e15be39906034a95b86c026e060ed9866586d94.camel@pengutronix.de>
 <20200514082755.GN1551@shell.armlinux.org.uk>
 <ab384507b90474b0030d8ce64fdcfe868b52c3cb.camel@pengutronix.de>
 <20200514085307.GO1551@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514085307.GO1551@shell.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 09:53:08AM +0100, Russell King - ARM Linux admin wrote:
> On Thu, May 14, 2020 at 10:40:58AM +0200, Lucas Stach wrote:
> > Am Donnerstag, den 14.05.2020, 09:27 +0100 schrieb Russell King - ARM Linux admin:
> > > On Thu, May 14, 2020 at 10:18:02AM +0200, Lucas Stach wrote:
> > > > Am Mittwoch, den 13.05.2020, 23:41 -0300 schrieb Fabio Estevam:
> > > > > On Wed, May 13, 2020 at 2:09 PM Fabio Estevam <festevam@gmail.com> wrote:
> > > > > 
> > > > > > The binding doc Documentation/devicetree/bindings/gpu/vivante,gc.yaml
> > > > > > says that only the 'reg' clock could be optional, the others are
> > > > > > required.
> > > > > 
> > > > > arch/arm/boot/dts/dove.dtsi only uses the 'core' clock.
> > > > > arch/arm/boot/dts/stm32mp157.dtsi uses 'bus' and 'core'
> > > > > 
> > > > > Maybe the binding needs to be updated and it seems that using
> > > > > devm_clk_get_optional() like you propose is safe.
> > > > 
> > > > The binding is correct as-is. We want to require those clocks to be
> > > > present, but the dove DT was added before the binding was finalized, so
> > > > the driver still treats the clocks as optional to not break
> > > > compatibility with old DTs. Maybe this warrants a comment in the
> > > > code...
> > > 
> > > The binding doc in mainline says:
> > > 
> > >   clocks:
> > >     items:
> > >       - description: AXI/master interface clock
> > >       - description: GPU core clock
> > >       - description: Shader clock (only required if GPU has feature PIPE_3D)
> > >       - description: AHB/slave interface clock (only required if GPU can gate slave interface independently)
> > >     minItems: 1
> > >     maxItems: 4
> > > 
> > >   clock-names:
> > >     items:
> > >       enum: [ bus, core, shader, reg ]
> > >     minItems: 1
> > >     maxItems: 4
> > > 
> > > which looks correct to me - and means that Dove is compliant with that.
> > 
> > The YAML binding actually did loose something in translation here,
> > which I didn't notice. Previously all those clocks were listed under
> > "Required properties", with the exceptions listed in parenthesis. So
> > the Dove GPU, which is a combined 2D/3D core should have axi, core and
> > shader clocks specified.
> 
> That may be your desire, but that is impossible without knowing that
> (a) it has the clocks
> (b) what those clocks are connected to
> 
> I guess we could "make something up" but as DT is supposed to describe
> hardware, I don't see how we can satisfy that and your requirement.
> 
> The only thing that is known from the documentation is that there is
> one clock for the GPU on Dove.

Yes. This means that in fact "core" is the only required clock for all
implementations of vivante,gc and the common binding needs to be updated
to reflect that. I'll follow with a patch that does that, unless there
are strong objections.

If there are implementations that require different clock inputs, then they
need to use additional compatible string for the particular flavor and the
binding should have conditionals for them. Something like this:

  if:
    properties:
      compatible:
        contains:
          const: fsl,imx6sx-gpu
  then:
    properties:
      clocks:
        minItems: 4

Lubo
