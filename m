Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EA4C7619C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 15:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE90822522
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 15:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="txR31kI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgBPP3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 10:29:01 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:36756 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgBPP3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 10:29:01 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0B8DA2AF;
        Sun, 16 Feb 2020 16:28:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1581866938;
        bh=SBcgUjw9x3rOad2pi6wnvIDSAkwZ+PVWqSdvxJ1IPGE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=txR31kI3ukSy8U8AAM8CScHL59YfHYWo6YMJxTSN7WWZDOh9rZgusn9akd+88ZC4u
         PqLsvXsHilHbRAdFNIgrn94uMRleGGjyxie7UZrjK1IHwM27GyHqEUZBYA7lZ0Wary
         OkpuqriUUa99SP/xwsBP89W3p/qcglGHGkWS/wkA=
Date:   Sun, 16 Feb 2020 17:28:40 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Yuti Amonkar <yamonkar@cadence.com>
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, maxime@cerno.tech,
        airlied@linux.ie, daniel@ffwll.ch, mark.rutland@arm.com,
        a.hajda@samsung.com, narmstrong@baylibre.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, praneeth@ti.com, jsarha@ti.com,
        mparab@cadence.com, sjakhade@cadence.com
Subject: Re: [PATCH v5 1/3] dt-bindings: drm/bridge: Document Cadence MHDP
 bridge bindings.
Message-ID: <20200216152840.GB28645@pendragon.ideasonboard.com>
References: <1581481604-24499-1-git-send-email-yamonkar@cadence.com>
 <1581481604-24499-2-git-send-email-yamonkar@cadence.com>
 <b97283b0-e4a5-4b96-e509-b9b5cdd78991@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b97283b0-e4a5-4b96-e509-b9b5cdd78991@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yuti,

Thank you for the patch.

On Thu, Feb 13, 2020 at 11:16:51AM +0200, Tomi Valkeinen wrote:
> On 12/02/2020 06:26, Yuti Amonkar wrote:
> > Document the bindings used for the Cadence MHDP DPI/DP bridge in
> > yaml format.
> > 
> > Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >   .../bindings/display/bridge/cdns,mhdp.yaml    | 125 ++++++++++++++++++
> >   1 file changed, 125 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml
> > new file mode 100644
> > index 000000000000..e7f84ed1d2da
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml
> > @@ -0,0 +1,125 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/display/bridge/cdns,mhdp.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Cadence MHDP bridge
> > +
> > +maintainers:
> > +  - Swapnil Jakhade <sjakhade@cadence.com>
> > +  - Yuti Amonkar <yamonkar@cadence.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - cdns,mhdp8546
> > +      - ti,j721e-mhdp8546
> > +
> > +  reg:
> > +    minItems: 1
> > +    maxItems: 2
> > +    items:
> > +      - description:
> > +          Register block of mhdptx apb registers upto PHY mapped area(AUX_CONFIG_P).
> 
> "up to". Add space before (.
> 
> > +          The AUX and PMA registers are mapped to associated phy driver.

I wouldn't mention driver here, as that's a software concept unrelated
to DT bindings. You could write "The AUX and PMA registers are not part
of this range, they are instead included in the associated PHY.".

> > +      - description:
> > +          Register block for DSS_EDP0_INTG_CFG_VP registers in case of TI J7 SoCs.
> > +
> > +  reg-names:
> > +    minItems: 1
> > +    maxItems: 2
> > +    items:
> > +      - const: mhdptx
> > +      - const: j721e-intg
> > +
> > +  clocks:
> > +    maxItems: 1
> > +    description:
> > +      DP bridge clock, it's used by the IP to know how to translate a number of

s/it's //

> > +      clock cycles into a time (which is used to comply with DP standard timings
> > +      and delays).
> > +
> > +  phys:
> > +    description: Phandle to the DisplyPort phy.
> 
> "Display"

And s/Phandle/phandle/, and s/phy/PHY/.

Shouldn't this bridge also have port nodes ?

-- 
Regards,

Laurent Pinchart
