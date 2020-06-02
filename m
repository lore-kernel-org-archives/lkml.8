Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7C9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 15:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 357512074B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 15:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Wz5DKjPY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vbCLd6yI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgFBPAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 11:00:25 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:58489 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726139AbgFBPAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 11:00:25 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 662C3580261;
        Tue,  2 Jun 2020 11:00:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 02 Jun 2020 11:00:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=b3vw+BEBApeWgbYfi0W8qA87gNa
        OTuaOwpRsHGgUWV8=; b=Wz5DKjPY/MH34VmLa/Rjgcc5dTJ9z0Sy8AZNKyyjjtG
        GBCu1OUNKsqw06REde27sg13QewMlh7U5k5ESE0q+oCduyTPZWsIOWdOnuIRnan6
        k8F1Lzb4jPLpHT2MnpIWxemjX59HS84wDSHHW4E54vUstVYKH/PYbFJtQarCMIRM
        dV5nDWIkjoo0DTJv7E/ehoYPjNxaaeBSR55ld62494FsllydiJidI0gWk6iU/AMK
        yUKu/S/0t7uDeDDU7Z1cri23nx9hpNUenWz11g2S4cRRe2M3KZ5JAroeva0xdoCY
        Jvm/qVJeglxaQhI2tAZ8bovYjVEbBq1IgqlpmHkK06w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=b3vw+B
        EBApeWgbYfi0W8qA87gNaOTuaOwpRsHGgUWV8=; b=vbCLd6yI9C3XNdf9Y8b4SW
        fFOLnW69TDvEjRYBkUhUZC9qM717BqiUGcVwJSRKGgKtKrS/CQoIFGUU8mKt3lAM
        T76eWQjIo8tOVOupSZI0FNj4kPrHpr0zD0qivWMsAa/eLIGeyJ/V1CxHrRTibtg2
        NZMJngn61d4fL1wc4dvjVmHY79JBbLwsNE48FVdPa+zTOAp0QTdj9K3sz/ZXZTj8
        kfQwmcGDcAw+byJP9ZM9U0l92Bj31rXUHZ+CwZzahXQJWpG39gMlcTucyS0eqNYo
        w9I69LgszlRtXZL4XthX9JDPdrUJLkts6emzQiuiIysM+huo71lyl108yxJgZfTg
        ==
X-ME-Sender: <xms:gWnWXriIF5IdDAo-NgDRUrhHx_8nILtnEmf5V-oAZhWBGo0h5_UnHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudefjedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepffetteevieejteeuhfffgeektefghfeileehhedtuddutefhhfejtddvtddu
    ledvnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucfkphepledtrdekle
    drieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:gWnWXoCicDquGYNN0tAt5-LsGl3G_GQbMDWIKe8VsPExtj2drmtaiQ>
    <xmx:gWnWXrGIVNm5rMRUWDT8HI1W1RKEjri5aG71HH2U3Xd58j0NaBSY8g>
    <xmx:gWnWXoSl3EHIkVURR0MM__f4fh8fZGRuLw8wYorTjKVVhFhO6ty0Wg>
    <xmx:h2nWXnn_al8wj2oSe7N7qqteB_5iyJ37ng_9VYefwVF5kIBM8dOgQg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 884553060FE7;
        Tue,  2 Jun 2020 11:00:17 -0400 (EDT)
Date:   Tue, 2 Jun 2020 17:00:14 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Rob Herring <robh@kernel.org>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 006/105] dt-bindings: display: Convert VC4 bindings to
 schemas
Message-ID: <20200602150014.iyd3i764kgunp5c3@gilmour>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
 <2dc6384c945c7d35ab4f75464d3a77046dc125b3.1590594512.git-series.maxime@cerno.tech>
 <20200527191211.GA2559189@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pne5nkt4apjusbp5"
Content-Disposition: inline
In-Reply-To: <20200527191211.GA2559189@bogus>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pne5nkt4apjusbp5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Wed, May 27, 2020 at 01:12:11PM -0600, Rob Herring wrote:
> On Wed, May 27, 2020 at 05:47:36PM +0200, Maxime Ripard wrote:
> > The BCM283x SoCs have a display pipeline composed of several controllers
> > with device tree bindings that are supported by Linux.
> >=20
> > Now that we have the DT validation in place, let's split into separate
> > files and convert the device tree bindings for those controllers to
> > schemas.
> >=20
> > This is just a 1:1 conversion though, and some bindings were incomplete=
 so
> > it results in example validation warnings that are going to be addresse=
d in
> > the following patches.
> >=20
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > ---
> >  Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt            =
  | 174 +------------------------------------------------------------------=
------
> >  Documentation/devicetree/bindings/display/brcm,bcm2835-dpi.yaml       =
  |  66 +++++++++++++++++++++++++++-
> >  Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml      =
  |  73 ++++++++++++++++++++++++++++++-
> >  Documentation/devicetree/bindings/display/brcm,bcm2835-hdmi.yaml      =
  |  75 +++++++++++++++++++++++++++++++-
> >  Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml       =
  |  37 +++++++++++++++-
> >  Documentation/devicetree/bindings/display/brcm,bcm2835-pixelvalve0.yam=
l |  40 +++++++++++++++++-
> >  Documentation/devicetree/bindings/display/brcm,bcm2835-txp.yaml       =
  |  37 +++++++++++++++-
> >  Documentation/devicetree/bindings/display/brcm,bcm2835-v3d.yaml       =
  |  42 +++++++++++++++++-
> >  Documentation/devicetree/bindings/display/brcm,bcm2835-vc4.yaml       =
  |  34 ++++++++++++++-
> >  Documentation/devicetree/bindings/display/brcm,bcm2835-vec.yaml       =
  |  44 ++++++++++++++++++-
> >  MAINTAINERS                                                           =
  |   2 +-
> >  11 files changed, 449 insertions(+), 175 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/display/brcm,bcm-=
vc4.txt
> >  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2=
835-dpi.yaml
> >  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2=
835-dsi0.yaml
> >  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2=
835-hdmi.yaml
> >  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2=
835-hvs.yaml
> >  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2=
835-pixelvalve0.yaml
> >  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2=
835-txp.yaml
> >  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2=
835-v3d.yaml
> >  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2=
835-vc4.yaml
> >  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2=
835-vec.yaml
>=20
>=20
> > diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2835-dsi=
0.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml
> > new file mode 100644
> > index 000000000000..3887675f844e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml
> > @@ -0,0 +1,73 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/brcm,bcm2835-dsi0.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Broadcom VC4 (VideoCore4) DSI Controller
> > +
> > +maintainers:
> > +  - Eric Anholt <eric@anholt.net>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - brcm,bcm2835-dsi0
> > +      - brcm,bcm2835-dsi1
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: The DSI PLL clock feeding the DSI analog PHY
> > +      - description: The DSI ESC clock
> > +      - description: The DSI pixel clock
> > +
> > +  clock-output-names: true
> > +    # FIXME: The meta-schemas don't seem to allow it for now
> > +    # items:
> > +    #   - description: The DSI byte clock for the PHY
> > +    #   - description: The DSI DDR2 clock
> > +    #   - description: The DSI DDR clock
>=20
> Doesn't pattern work for you?
>=20
> pattern: '^dsi[0-1]_byte$'

That's not really what I was trying to achieve. I don't think
clock-output-names should hardcode the values it expect, since the whole
point is to let the "user" (ie the DT) control the clock names. If these
were to be fixed, it wouldn't even be here in the first place.

I just wanted to have a description of the clocks to provide a name for,
but it looks like clock-output-names can't have an items below. I looked
at why, couldn't really find a reason, and forgot to tell you about it,
sorry

> Either way,
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks!
Maxime

--pne5nkt4apjusbp5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXtZpfgAKCRDj7w1vZxhR
xamNAQDjAcQjFDKW8OoDkZEu895p12GG+6k1yYqfFpE5MzUl0wEA3H4pL01QbNiU
F44qQQa9T1hfzEC775unxWedjQt/aA8=
=R7+B
-----END PGP SIGNATURE-----

--pne5nkt4apjusbp5--
