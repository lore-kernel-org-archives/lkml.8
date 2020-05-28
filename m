Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98976C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73D9F20721
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="MOlOp9ER"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437319AbgE1Wsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 18:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437260AbgE1Wst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 18:48:49 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61BBC08C5C6;
        Thu, 28 May 2020 15:48:48 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D64742A8;
        Fri, 29 May 2020 00:48:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1590706127;
        bh=cdsHXo6OKUnTW5BR3DkvIcc+0E7wWVVJF01vOkcdybU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MOlOp9ERp7sP/cv0RcfSVx08Rs5F2NJ38mNzxDiouoKsk3hbBPCZ4D3usqCEltwlx
         H0bzwLrayVMrscNMyMLoVT9bgJyUqzqTHKq63rbHmmyoT6zhhe85OroD/VutySHmBt
         p1Fb6nOSufjvYXgzSFrPc29VlFgr1gGJP+7C/UeQ=
Date:   Fri, 29 May 2020 01:48:32 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 1/6] dt-bindings: display/bridge: Add binding for
 input mux bridge
Message-ID: <20200528224832.GE14756@pendragon.ideasonboard.com>
References: <cover.1589548223.git.agx@sigxcpu.org>
 <14a44a664f40584ffa25c1764aab5ebf97809c71.1589548223.git.agx@sigxcpu.org>
 <20200528194804.GA541078@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200528194804.GA541078@bogus>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thu, May 28, 2020 at 01:48:04PM -0600, Rob Herring wrote:
> On Fri, May 15, 2020 at 03:12:10PM +0200, Guido Günther wrote:
> > The bridge allows to select the input source via a mux controller.
> > 
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > ---
> >  .../display/bridge/mux-input-bridge.yaml      | 123 ++++++++++++++++++
> >  1 file changed, 123 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/bridge/mux-input-bridge.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/display/bridge/mux-input-bridge.yaml b/Documentation/devicetree/bindings/display/bridge/mux-input-bridge.yaml
> > new file mode 100644
> > index 000000000000..4029cf63ee5c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/bridge/mux-input-bridge.yaml
> > @@ -0,0 +1,123 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/bridge/mux-input-bridge.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: DRM input source selection via multiplexer
> 
> DRM is not a hardware thing.
> 
> The graph binding is already designed to support muxing. Generally, 
> multiple endpoints on an input node is a mux. So either the device with 
> the input ports knows how to select the input, or you just need a 
> mux-control property for the port to have some other device implement 
> the control.

The mux modelled by this binding is used by Guido with the NWL DSI
bridge integrated in the i.MX8. The NWL DSI is an IP core that has a
single input. The i.MX8 has an additional mux in front of the NWL DSI,
to select between the two display controllers in the SoC (eLCDIF and
DCSS). The mux doesn't belong to any of the display controller, it's
really glue logic between the display controllers and the NWL DSI
bridge.

I agree that the bindings shouldn't mention DRM. I would however prefer
not adding a mux-control property and multiple input ports to the NWL
DSI binding, as the mux isn't internal to that IP core (if we go that
route, we would need to add mux control to any IP core that would be
integrated in an SoC with a mux in front). As DT should describe the
hardware, I think describing the standalone mux between the display
controllers and the NWL DSI bridge makex sense.

We already have a DT binding for a video mux
(Documentation/devicetree/bindings/media/video-mux.txt). From a DT point
of view, I see no reason not to reuse that. From a driver point of view
that will be messy, as the driver that binds to the video-mux compatible
string is part of V4L2. That's a driver issue however (and not a new
one, we already have devices that can be part of a video capture
pipeline or a video display pipeline), and should be solved on the
software side, not the DT side. It will however not be easy work, which
explains why, so far, everybody has ignored the issue hoping that
someone else would be hit by it first. We may have reached that day.

> You could do it like you have below. That would be appropriate if 
> there's a separate h/w device controlling the muxing. Say for example 
> some board level device controlled by i2c.

-- 
Regards,

Laurent Pinchart
