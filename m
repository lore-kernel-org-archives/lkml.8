Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68214C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 09:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4115C2083B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 09:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Jo2MqWxC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YXKaTS1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgIAJw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 05:52:56 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:51007 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725848AbgIAJwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 05:52:55 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 63005DAA;
        Tue,  1 Sep 2020 05:52:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 01 Sep 2020 05:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=qW82iw+G4D4VB8scsF8Ovdb32gF
        uWpSyhcI0JOB+P94=; b=Jo2MqWxCj8UmeFMLXzg49iSAw9CtMd7Po9ek7KJAv00
        upbkMiqKGQgQGDzN6NqPyP3wkuspAh8gsIIbduX9yjJxyC/IG16TQngJBKVGqnVT
        eO9O6RQ6noUcbZIcgKI79+AdaLlPfYymRyWY6XE3KeGnroGs+/rP0R6M+jS49MDz
        b4yiDjvOoHXzg2wdcXBue4LvvFApBSiSYKhB9nM+XGXnkkki9aqGx4mvDhxBBANp
        QWqAegObF1qDon5kEF3IOaIJfAQgIWz/ai21kb0UlQsnyKrnE8DhKZddAEBi4QiJ
        5okfhY+yQDFrDb0k3zacbtX/QTmtOvxsLvW0xcSl3QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=qW82iw
        +G4D4VB8scsF8Ovdb32gFuWpSyhcI0JOB+P94=; b=YXKaTS1ThLPZazKz1+Lbhb
        uWk2GcWdG00fzAyMPYaGx1/K52ue0GAMnmOiItmX52NHtWw/LvhJEEq/bNkOnVcD
        LpNSniuxDN+FmN2rYtGoz3d72hvMKaYsVwSS0lG2ZDK4tRPZX7UpYIJ9YK1m4qlC
        5CdgFL3d7+P5/HB/TQf7Zk8Qc1usEUCLOizyKheYg7MA3bFwl8IHOWP5MLbQ8bHH
        BvZya76zjPfBzlC0mVwjsPkM4L/LWa5CBb+yX+m+HJE865tW+DNnr6pPM5q5wbNk
        5X/4vFUdkgvSardEeyf/QF/bas9OT+BurUyfRibu9ouS294l1V6/X7LSskI2LMYg
        ==
X-ME-Sender: <xms:9RlOXzuC8HoXhqi8wmtOOo154a_x2bb2KFQhAfHfWYeb5t0dUGNKSg>
    <xme:9RlOX0eRwu2yPZ9OuzVtt4jrzMMtV1tXGaWiT90cjhZNHPBuLQpXm-defbU9VUljt
    TZpAJHDLLHlaaGsWSo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefjedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepieffvdeihefhtdetledugfffgffgtdejheefvdfggedugefhkedvtdefuedt
    hffgnecuffhomhgrihhnpehfihhrvggvhigvrdgtohhmpdguvghvihgtvghtrhgvvgdroh
    hrghenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:9RlOX2z9MYHfsDT5R1Um6QX9qjFnEIU_g0kSBTsHeDqdU8bU0GzNsQ>
    <xmx:9RlOXyNba3ikkvcfe_lkmoXCnEfyjvIWDbXAorEFiX4NaMrB764e5A>
    <xmx:9RlOXz8EH1RjNA8Y5t-GmPWESW_Cj4W-0frg97SOZuppIDhoEFFZcA>
    <xmx:9hlOX6aK6fJo9o9fQIZbNW6V4LKDFTnV1IbjN4y1739ZM5avveXpMk6MRSU>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id C2D843280060;
        Tue,  1 Sep 2020 05:52:52 -0400 (EDT)
Date:   Tue, 1 Sep 2020 11:52:51 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 75/78] dt-bindings: display: vc4: hdmi: Add BCM2711
 HDMI controllers bindings
Message-ID: <20200901095251.awfw45ndc7p6ty4a@gilmour.lan>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <CGME20200708174447epcas1p3c9582567617196b61495ee281b443b91@epcas1p3.samsung.com>
 <a174517d1f57b7a75eabd0361aef5365894d7c1a.1594230107.git-series.maxime@cerno.tech>
 <94c5b8e4-a168-690d-2d60-93462585bef9@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3t57ruatadihu43n"
Content-Disposition: inline
In-Reply-To: <94c5b8e4-a168-690d-2d60-93462585bef9@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3t57ruatadihu43n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 01, 2020 at 01:45:07PM +0900, Chanwoo Choi wrote:
> Hi Maxime,
>=20
> On 7/9/20 2:42 AM, Maxime Ripard wrote:
> > The HDMI controllers found in the BCM2711 SoC need some adjustments to =
the
> > bindings, especially since the registers have been shuffled around in m=
ore
> > register ranges.
> >=20
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > ---
> >  Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml | 109=
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 109 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2=
711-hdmi.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2711-hdm=
i.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml
> > new file mode 100644
> > index 000000000000..6091fe3d315b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml
> > @@ -0,0 +1,109 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: https://protect2.fireeye.com/url?k=3D556aeb05-08b8fda0-556b604a-0=
cc47a31bee8-c3a0ebd1d22c3183&q=3D1&u=3Dhttp%3A%2F%2Fdevicetree.org%2Fschema=
s%2Fdisplay%2Fbrcm%2Cbcm2711-hdmi.yaml%23
> > +$schema: https://protect2.fireeye.com/url?k=3D24fa660c-792870a9-24fbed=
43-0cc47a31bee8-0bf16f4fd60f0ab4&q=3D1&u=3Dhttp%3A%2F%2Fdevicetree.org%2Fme=
ta-schemas%2Fcore.yaml%23
> > +
> > +title: Broadcom BCM2711 HDMI Controller Device Tree Bindings
> > +
> > +maintainers:
> > +  - Eric Anholt <eric@anholt.net>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - brcm,bcm2711-hdmi0
> > +      - brcm,bcm2711-hdmi1
> > +
> > +  reg:
> > +    items:
> > +      - description: HDMI controller register range
> > +      - description: DVP register range
> > +      - description: HDMI PHY register range
> > +      - description: Rate Manager register range
> > +      - description: Packet RAM register range
> > +      - description: Metadata RAM register range
> > +      - description: CSC register range
> > +      - description: CEC register range
> > +      - description: HD register range
> > +
> > +  reg-names:
> > +    items:
> > +      - const: hdmi
> > +      - const: dvp
> > +      - const: phy
> > +      - const: rm
> > +      - const: packet
> > +      - const: metadata
> > +      - const: csc
> > +      - const: cec
> > +      - const: hd
> > +
> > +  clocks:
> > +    description: The HDMI state machine clock
>=20
> I'm not sure the following description is correct.
> But, this description doesn't contain the information of audio clock.
>=20
> 	description: The HDMI state machine and audio clock
>=20
> > +
> > +  clock-names:
> > +    const: hdmi
>=20
> This patch is missing the following clock information for audio clock.
>=20
> 	const: clk-108M
>=20
> > +
> > +  ddc:
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: >
> > +      Phandle of the I2C controller used for DDC EDID probing
> > +
> > +  hpd-gpios:
> > +    description: >
> > +      The GPIO pin for the HDMI hotplug detect (if it doesn't appear
> > +      as an interrupt/status bit in the HDMI controller itself)
> > +
> > +  dmas:
> > +    maxItems: 1
> > +    description: >
> > +      Should contain one entry pointing to the DMA channel used to
> > +      transfer audio data.
> > +
> > +  dma-names:
> > +    const: audio-rx
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - clocks
> > +  - resets
> > +  - ddc
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    hdmi0: hdmi@7ef00700 {
> > +        compatible =3D "brcm,bcm2711-hdmi0";
> > +        reg =3D <0x7ef00700 0x300>,
> > +              <0x7ef00300 0x200>,
> > +              <0x7ef00f00 0x80>,
> > +              <0x7ef00f80 0x80>,
> > +              <0x7ef01b00 0x200>,
> > +              <0x7ef01f00 0x400>,
> > +              <0x7ef00200 0x80>,
> > +              <0x7ef04300 0x100>,
> > +              <0x7ef20000 0x100>;
> > +        reg-names =3D "hdmi",
> > +                    "dvp",
> > +                    "phy",
> > +                    "rm",
> > +                    "packet",
> > +                    "metadata",
> > +                    "csc",
> > +                    "cec",
> > +                    "hd";
> > +        clocks =3D <&firmware_clocks 13>;
> > +        clock-names =3D "hdmi";
>=20
> Also, this example doesn't include the instance of audio clock.
> Need to edit them as following:
>=20
> 	clock-names =3D "hdmi", "clk-108M";
> 	clocks =3D <&firmware_clocks 13>, <&dvp 0>;

Indeed, thanks for pointing it out

Maxime

--3t57ruatadihu43n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX04Z8wAKCRDj7w1vZxhR
xY+DAP463c8+Cx/V7o7lAsKNPNIq50LRUtYa2f/F0i6/uJ9zOgEA6UKWJP2FTPS0
IUEhoE12OvDJJT3wW6r+XxZEFf93+ws=
=vP/V
-----END PGP SIGNATURE-----

--3t57ruatadihu43n--
