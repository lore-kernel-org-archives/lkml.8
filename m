Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D8EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21F16206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591657316;
	bh=E2VDSxyTsjme/SDDJYb/Ce8BPIu8k9mIpohu+7Y2fi4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=C49EY9IciKFkKbu9YNos9KwZ53ZWpT59I9/3hmczZ4cXJT6qzTr/uhe9HUhD7QeU7
	 nX79AB7bAUGV4R4sDOqkujVJ9Coc8MQoWLlL9MWhQfz1H9kwMoPvRM0p4P0X84jFaf
	 ChSBIODh6Lej3n8uKyQe9lmVg0GKowQYmbSggJHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgFHXBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:01:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726746AbgFHXBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:01:54 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D666206D5;
        Mon,  8 Jun 2020 23:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657313;
        bh=E2VDSxyTsjme/SDDJYb/Ce8BPIu8k9mIpohu+7Y2fi4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QCmsWHtuUrkP99N9zTwI1IYiExbKn+Evf9ftBvwrf3b5ttojeS+Hyn7Edq402+ZVR
         Qy7IVlA83KbFqbAghS2O1o9Vfm+cSqA6RtCL0MpFakR/wFQqZ6tZbJBuAzjZoGNeG2
         9graD5Nhc6mPEcrc7kgBH5k8/4opuDcpntGKKAM4=
Received: by mail-oi1-f178.google.com with SMTP id k4so15398485oik.2;
        Mon, 08 Jun 2020 16:01:53 -0700 (PDT)
X-Gm-Message-State: AOAM5302k/rABPCTx/593gRZMYGMQl2cwuIZFRGWeaYBw7mBzlcjtIaT
        6XSWpGN70ngCIKTBF5rToMP2bi0ZDjDcLPmCow==
X-Google-Smtp-Source: ABdhPJxObAvxE+OOnTXcIgh61N2TLSHvj0BypJ4NL+n+aOPoAluENZ8Z4kbXmRaFm6G3U4eAOxdn3BnGxOwTfQQTlPQ=
X-Received: by 2002:aca:d454:: with SMTP id l81mr1365615oig.152.1591657312818;
 Mon, 08 Jun 2020 16:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
 <e85e24a494a3ff41177c94673ced0f4280b6a0ee.1590594512.git-series.maxime@cerno.tech>
 <20200529181833.GA2685451@bogus> <20200602150834.6xovwdxpgncq3ybh@gilmour>
In-Reply-To: <20200602150834.6xovwdxpgncq3ybh@gilmour>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 8 Jun 2020 17:01:41 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJShNcyUDv1JmdanLKZqFa0TeJGazwmPz6eJ_Rq0GtkpQ@mail.gmail.com>
Message-ID: <CAL_JsqJShNcyUDv1JmdanLKZqFa0TeJGazwmPz6eJ_Rq0GtkpQ@mail.gmail.com>
Subject: Re: [PATCH v3 104/105] dt-bindings: display: vc4: hdmi: Add BCM2711
 HDMI controllers bindings
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 9:08 AM Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi Rob,
>
> On Fri, May 29, 2020 at 12:18:33PM -0600, Rob Herring wrote:
> > On Wed, May 27, 2020 at 05:49:14PM +0200, Maxime Ripard wrote:
> > > The HDMI controllers found in the BCM2711 SoC need some adjustments to the
> > > bindings, especially since the registers have been shuffled around in more
> > > register ranges.
> > >
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: devicetree@vger.kernel.org
> > > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > > ---
> > >  Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml | 109 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 109 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml
> > > new file mode 100644
> > > index 000000000000..6091fe3d315b
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml
> > > @@ -0,0 +1,109 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> >
> > Dual license...
> >
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/display/brcm,bcm2711-hdmi.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Broadcom BCM2711 HDMI Controller Device Tree Bindings
> > > +
> > > +maintainers:
> > > +  - Eric Anholt <eric@anholt.net>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - brcm,bcm2711-hdmi0
> > > +      - brcm,bcm2711-hdmi1
> >
> > What's the difference between the 2 blocks?
>
> The register layout and the lane mapping in the PHY change a bit.
>
> > > +
> > > +  reg:
> > > +    items:
> > > +      - description: HDMI controller register range
> > > +      - description: DVP register range
> > > +      - description: HDMI PHY register range
> > > +      - description: Rate Manager register range
> > > +      - description: Packet RAM register range
> > > +      - description: Metadata RAM register range
> > > +      - description: CSC register range
> > > +      - description: CEC register range
> > > +      - description: HD register range
> > > +
> > > +  reg-names:
> > > +    items:
> > > +      - const: hdmi
> > > +      - const: dvp
> > > +      - const: phy
> > > +      - const: rm
> > > +      - const: packet
> > > +      - const: metadata
> > > +      - const: csc
> > > +      - const: cec
> > > +      - const: hd
> > > +
> > > +  clocks:
> > > +    description: The HDMI state machine clock
> > > +
> > > +  clock-names:
> > > +    const: hdmi
> > > +
> > > +  ddc:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/phandle
> > > +    description: >
> > > +      Phandle of the I2C controller used for DDC EDID probing
> >
> > Goes in the connector.
> >
> > And isn't the standard name ddc-i2c-bus?
> >
> > > +
> > > +  hpd-gpios:
> > > +    description: >
> > > +      The GPIO pin for the HDMI hotplug detect (if it doesn't appear
> > > +      as an interrupt/status bit in the HDMI controller itself)
> >
> > Goes in the connector.
>
> If this was an entirely new binding, I would agree, but this is not
> really the case here.
>
> We discussed it already for the v2, and this binding is essentially the
> same one than the bcm2835 HDMI controller.
>
> I initially sent a patch adding conditionnals for the clocks and regs
> differences too, and you asked to split the binding into a separate file
> to simplify it a bit.

Ah... Best to assume I don't remember what happened last week. ;)

> Supporting both the old binding, and the new one based on the connector
> is going to make the code significantly more complicated, and I'm not
> really sure why we would here.

I'm not really sure I agree on the complexity, but that can be a
discussion for another day.

Reviewed-by: Rob Herring <robh@kernel.org>

Rob
