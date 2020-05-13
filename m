Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05030C2D0F9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C561720769
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="b8H3/C8I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RgT8M9sA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbgEMINx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 04:13:53 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:53329 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726092AbgEMINw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 04:13:52 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2175F5801B1;
        Wed, 13 May 2020 04:13:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 13 May 2020 04:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=IGYOtJGhA33KVDBJeTx7LYHUsdb
        eHZGIIUvV55V/pTo=; b=b8H3/C8IbYqfZrWAZDXls/QijycsCbs+xDvfu6K8u8W
        5AQ/eTVHtwSbkcntqYZHPN0amfjE76nFi6IimdDSsxzMeNIxY1Pd+U7Zr5dLcyt6
        t6Ir/bGJB85Pf3Hx11oMIeZUrA+KGV75Wl68Xw8wS/xFwnVvzZxScynqNA/J8+n/
        f9jxDWit2CpPsBxbHw2M7EdwIXAhvfm4eLBO1Xb5PsLZhTgDdv5JfXAGKjnZT5+X
        0YFziQghcrvVlgUyabEtY3eeay5znE1oM8nBlG0t67Y+sGviGpwd0I+7eQFMoICJ
        VWiBn+0Fc67m++efoWcJwFstzZFslbPKvOk0QeFAdXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=IGYOtJ
        GhA33KVDBJeTx7LYHUsdbeHZGIIUvV55V/pTo=; b=RgT8M9sARsIBM7K0v2kxbW
        3vdVUdBfWTY1uN/32ARoO7SEwTcqOU4ScxvSGS6339FCUqVQdI9IhOxDxattfrVT
        ADTWifW9FKJuSMCwJYPiiEMbL5dfrYfE0GcV80sv3L+cmoWREOzbPGdM1avQwIa/
        QZjvKn83IbWVv1OatKyyVpoYN2a2wrJI9+2AHtbsyUTDmj+DYZRYJwvwysnh0+SD
        8p4jL5wUK7PHY/HMxxHH1Wzu4SRF9nFDIE6gDf5coSg2mLACDMz3mvctMmshZmtl
        ZiCban1pvxftHA3yCFUudXcTZy85RWa3s1xvrBM/pW2+wZ+uxB9ghUbzznfM1UUw
        ==
X-ME-Sender: <xms:O6y7Xo1gWNRjX-uUeIA21csySJCs40dts9pgbWjr25yvCN92r9NJUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrleeggddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:O6y7XjHmUWAg7jfXhBO8YZpU6LpxIbYSYV6vXLs5_3QGcI3MfhWnWQ>
    <xmx:O6y7Xg5hO0LEpGli15YGEIItHzmJ7b8BQZlFKWFPnjuKvFmmZW_m8g>
    <xmx:O6y7Xh1TRm5CCQl3T2_VeXBT9eT0JFpgeiPaZ-3ZI0JmNNOZ2PhIpg>
    <xmx:P6y7Xi-b_jpaSvZ34-DHJuWqeJEpw28r6AwybMhBBAQRdSR0SJ4www>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0D151328005E;
        Wed, 13 May 2020 04:13:46 -0400 (EDT)
Date:   Wed, 13 May 2020 10:13:45 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Rob Herring <robh@kernel.org>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 03/91] dt-bindings: clock: Add a binding for the RPi
 Firmware clocks
Message-ID: <20200513081345.zgey4k2ff4njtovm@gilmour.lan>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
 <69e869b0a79ea17f2cdb79df986409963672495a.1587742492.git-series.maxime@cerno.tech>
 <20200511214727.GA20924@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4inkvqvn6iczrxel"
Content-Disposition: inline
In-Reply-To: <20200511214727.GA20924@bogus>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4inkvqvn6iczrxel
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Mon, May 11, 2020 at 04:47:27PM -0500, Rob Herring wrote:
> On Fri, Apr 24, 2020 at 05:33:44PM +0200, Maxime Ripard wrote:
> > The firmware running on the RPi VideoCore can be used to discover and
> > change the various clocks running in the BCM2711. Since devices will
> > need to use them through the DT, let's add a pretty simple binding.
> >=20
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: linux-clk@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > ---
> >  Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware=
=2Eyaml | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2=
835-firmware.yaml b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,b=
cm2835-firmware.yaml
> > index cec540c052b6..b48ed875eb8e 100644
> > --- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-fir=
mware.yaml
> > +++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-fir=
mware.yaml
> > @@ -22,6 +22,25 @@ properties:
> >        Phandle to the firmware device's Mailbox.
> >        (See: ../mailbox/mailbox.txt for more information)
> > =20
> > +  clocks:
> > +    type: object
> > +
> > +    properties:
> > +      compatible:
> > +        const: raspberrypi,firmware-clocks
> > +
> > +      "#clock-cells":
> > +        const: 1
> > +        description: >
> > +          The argument is the ID of the clocks contained by the
> > +          firmware messages.
>=20
> Not really any reason to make this a child node. The parent can be a=20
> clock provider.

This was meant to provide some consistency for that driver. It already has =
a nod
for the GPIOs exposed through the firmware in the RPi where you could make =
the
exact same argument, so I guess that, while we shouldn't make the same choi=
ces
if we had to design it from scratch, it's more important to keep the same d=
esign
choices for a given binding?

Maxime

--4inkvqvn6iczrxel
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXrusOQAKCRDj7w1vZxhR
xeVJAQDmR19y9u8phgKYgLVg8JA98FXCMq4WNwsekwqGe+stqgD9FsYBv4DsAMVZ
IsGpCnj5GT0yoXdBxhf+6rQUuVZMMA4=
=cQQz
-----END PGP SIGNATURE-----

--4inkvqvn6iczrxel--
