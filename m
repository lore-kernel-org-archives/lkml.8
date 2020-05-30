Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91F9C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 13:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7BC820810
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 13:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbgE3N0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 09:26:40 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:42442 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728797AbgE3N0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 09:26:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id B933EFB03;
        Sat, 30 May 2020 15:26:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jH8te9rYstS2; Sat, 30 May 2020 15:26:35 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id A29C944AF9; Sat, 30 May 2020 15:26:34 +0200 (CEST)
Date:   Sat, 30 May 2020 15:26:34 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
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
Message-ID: <20200530132634.GA3337@bogon.m.sigxcpu.org>
References: <cover.1589548223.git.agx@sigxcpu.org>
 <14a44a664f40584ffa25c1764aab5ebf97809c71.1589548223.git.agx@sigxcpu.org>
 <20200528194804.GA541078@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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

I thought about naming the mux pixel-input-mux (input-mux sounding too
generic) but then i hit rockchip-drm and went for that name.  The
binding itself is not a drm thing in itself it really aims to model how
the mux is placed in the 'display pipeline' of the SoC (as Laurent
explained). Should I go with pixel-input-mux?

> The graph binding is already designed to support muxing. Generally, 
> multiple endpoints on an input node is a mux. So either the device with 
> the input ports knows how to select the input, or you just need a 
> mux-control property for the port to have some other device implement 
> the control.

A mux control property is how it's modeled at the moment but that is
very SoC specific.

> You could do it like you have below. That would be appropriate if 
> there's a separate h/w device controlling the muxing. Say for example 
> some board level device controlled by i2c.

It's a different part of the SoC that lives in a register range very
separate (iomuxc_gpr) from MIPI/DSI (nwl). Does that qualify?

Cheers,
 -- Guido

> 
> Rob
> 
