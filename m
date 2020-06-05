Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F23C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9494206F0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="IZkXc1mu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oYk+OFQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgFEOfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:35:46 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:55475 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728085AbgFEOfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:35:44 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id E24D19D7;
        Fri,  5 Jun 2020 10:35:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 05 Jun 2020 10:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=+TcduIGFD1Yl/6EGL0XWA7t4aPq
        sN8l5/bEdRQJQWgM=; b=IZkXc1mufcD6ESebLtZlhASRlGjGsL2JkX02LC0BD1M
        7OTn03dW+RBkZ7Fy/1ri9dK0IuWC8Pm9N72nYLOpEkCkOltE8I7bwaOti+v7BAG/
        isE5RjRsHVLffcnutd9OP5t24vWEQWzTLg5YsXK3rl9Yg4oSmCFVyA8rqo5kfEMS
        mpmH1DgqPFH1+Ge6f/Zs96ikPti90K7toW7dWGkIuDgojzo+Es5BvMomWEzd5+0b
        NP1B4QpxLTC8j+uBfDXED8F+qKjPwRLqZnjAVabHbmEBxuE3Fv02G5Kzn0FKfSnu
        KSWlpCPiyfJjJr41rDsgeKk++yM4L3aAKQjom2jpCDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=+TcduI
        GFD1Yl/6EGL0XWA7t4aPqsN8l5/bEdRQJQWgM=; b=oYk+OFQIqmyViTG42oRp/g
        ozFFiZVCn4LGSAVqMINnBHnmd4W0It2T6cvrOInTlMefboenRUIWOR77WEreTRk9
        xD8mGzY4JDYO0YSuOE+Ep0ZfDg9ddRajBqVXad0sQ10pA63O5BHAzzQI9cS/zcbP
        vWLcKiqQJN+jZsgmg5VziBfdIsX898iYMeFcrZplMJSFVElIP/X3IljUnjz4C/vb
        dODrqeOWUPPsXWjAlN+8S4ZgUBn9wdw7u+NQGx1sE+kxZ+QpsLOX/B3Ixn/eaDD7
        05ztSasGREDBmU2apyCO6nGiouAO4lIneI/CMbX5CWcrR7MOmxQmpDIelhKFQoBw
        ==
X-ME-Sender: <xms:O1jaXkx39w52sIJB_7c_hFw4Guc6RJYi-u6QLTeLSNecsdTUWeYWfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudegfedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepuddvudfhkeekhefgffetffelgffftdehffduffegveetffehueeivddvjedv
    gfevnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:O1jaXoQvkt6qmuW1rOsqq45AhwsYVDGtIysU3U520WyhBOo7A9cOdg>
    <xmx:O1jaXmUr_1c-JbGObOE7SO0ge28S1MrcxNReKfb5aFYBReoOpRkEmQ>
    <xmx:O1jaXiikoZR3YOO63WLhQdys8_eARoYMmLWwZDPtk0LabXaJYCB18w>
    <xmx:PljaXsCitqGv6fuw2268hdkSCHD8NVV5CyazocUIjCvT5c3LIrXITGUR5H8>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0F8FA3280065;
        Fri,  5 Jun 2020 10:35:38 -0400 (EDT)
Date:   Fri, 5 Jun 2020 16:35:36 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Eric Anholt <eric@anholt.net>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v3 070/105] drm/vc4: hdmi: rework connectors and encoders
Message-ID: <20200605143536.i6cc2v57eupmlvtn@gilmour.lan>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
 <020de18840a1075b2671736c6cc2e451030fad74.1590594512.git-series.maxime@cerno.tech>
 <CADaigPXJ0BnMUp=XN6G92Tx=H9j55pmsBAujO2mcpiiTs-RHnQ@mail.gmail.com>
 <20200602155421.niyvpwqc42xh5c7v@gilmour>
 <6cd190e0-c81c-8e47-3ca8-22360de9b46d@i2se.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="asvcqtopuuknnpqy"
Content-Disposition: inline
In-Reply-To: <6cd190e0-c81c-8e47-3ca8-22360de9b46d@i2se.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--asvcqtopuuknnpqy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

On Wed, Jun 03, 2020 at 07:32:30PM +0200, Stefan Wahren wrote:
> Am 02.06.20 um 17:54 schrieb Maxime Ripard:
> > On Wed, May 27, 2020 at 11:41:24AM -0700, Eric Anholt wrote:
> >> On Wed, May 27, 2020 at 8:51 AM Maxime Ripard <maxime@cerno.tech> wrot=
e:
> >>> the vc4_hdmi driver has some custom structures to hold the data it ne=
eds to
> >>> associate with the drm_encoder and drm_connector structures.
> >>>
> >>> However, it allocates them separately from the vc4_hdmi structure whi=
ch
> >>> makes it more complicated than it needs to be.
> >>>
> >>> Move those structures to be contained by vc4_hdmi and update the code
> >>> accordingly.
> >>
> >>> @@ -1220,7 +1219,7 @@ static int vc4_hdmi_bind(struct device *dev, st=
ruct device *master, void *data)
> >>>         struct drm_device *drm =3D dev_get_drvdata(master);
> >>>         struct vc4_dev *vc4 =3D drm->dev_private;
> >>>         struct vc4_hdmi *hdmi;
> >>> -       struct vc4_hdmi_encoder *vc4_hdmi_encoder;
> >>> +       struct drm_encoder *encoder;
> >>>         struct device_node *ddc_node;
> >>>         u32 value;
> >>>         int ret;
> >>> @@ -1229,14 +1228,10 @@ static int vc4_hdmi_bind(struct device *dev, =
struct device *master, void *data)
> >>>         if (!hdmi)
> >>>                 return -ENOMEM;
> >>>
> >>> -       vc4_hdmi_encoder =3D devm_kzalloc(dev, sizeof(*vc4_hdmi_encod=
er),
> >>> -                                       GFP_KERNEL);
> >>> -       if (!vc4_hdmi_encoder)
> >>> -               return -ENOMEM;
> >>> -       vc4_hdmi_encoder->base.type =3D VC4_ENCODER_TYPE_HDMI0;
> >>> -       hdmi->encoder =3D &vc4_hdmi_encoder->base.base;
> >>> -
> >>>         hdmi->pdev =3D pdev;
> >>> +       encoder =3D &hdmi->encoder.base.base;
> >>> +       encoder->base.type =3D VC4_ENCODER_TYPE_HDMI0;
> >> Wait, does this patch build?
> > All those patches were build tested, so yep
> >
> >> setting struct drm_encoder->base.type =3D VC4_* seems very wrong, when
> >> previously we were setting struct vc4_hdmi_encoder->base.type (struct
> >> vc4_encoder->type).
> > So the structure layout now is that vc4_hdmi embeds vc4_hdmi_encoder as
> > encoder. So &hdmi->encoder is a pointer to vc4_hdmi_encoder.
> > vc4_hdmi_encoder's base is since that patch a struct vc4_encoder. and
> > vc4_encoder's base is a drm_encoder.
> >
> > so encoder being a drm_encoder is correct there.
> >
> > However, drm_encoder's base is drm_mode_object that does have a type
> > field, which is an uint32_t, which will accept a VC4_ENCODER_TYPE_* just
> > fine...
> >
> > Now, drm_encoder_init will then kick in and call drm_mode_object_add
> > which will override it to a proper value and since the clock select bit
> > in the PV is the same for both HDMI0 and HDMI1, everything works just
> > fine...
> >
> > Good catch, I'll fix it. And I guess it's a good indication we don't
> > need a separate HDMI0 and HDMI1 encoder type.
> >
> FWIW this is the first patch which breaks X on my Raspberry Pi 3 B.
>=20
> Here are the bisect results:
>=20
> 587d6e4a529a8d807a5c0bae583dd432d77064d6 bad (black screen, no heartbeat)
>=20
> b0523c7b1c9d0edcd6c0fe6d2cb558a9ad5c60a8 good
>=20
> 2c6a651cac6359cb0244a40d3b7a14e72918f169 good
>=20
> 1705c3cb40906863ec0d24ee5ea5092f5ee2e994 bad (black screen, but heartbeat)
>=20
> 601527fea6bb226abd088a864e74b25368218e87 good
>=20
> 2165607ede34d229d0cbce916c70c7fb6c0337be good
>=20
> f094f388fc2df848227e2ae648df2c97872df42b good
>=20
> 020de18840a1075b2671736c6cc2e451030fad74 bad (black screen, but heartbeat)
>=20
> 4c4da3823e4d1a8189e96a59a79451fff372f70b good
>=20
> 020de18840a1075b2671736c6cc2e451030fad74 is the first bad commit
> commit 020de18840a1075b2671736c6cc2e451030fad74
> Author: Maxime Ripard <maxime@cerno.tech>
> Date:=A0=A0 Mon Jan 6 17:17:29 2020 +0100
>=20
> =A0=A0=A0 drm/vc4: hdmi: rework connectors and encoders
> =A0=A0=A0
> =A0=A0=A0 the vc4_hdmi driver has some custom structures to hold the data=
 it
> needs to
> =A0=A0=A0 associate with the drm_encoder and drm_connector structures.
> =A0=A0=A0
> =A0=A0=A0 However, it allocates them separately from the vc4_hdmi structu=
re which
> =A0=A0=A0 makes it more complicated than it needs to be.
> =A0=A0=A0
> =A0=A0=A0 Move those structures to be contained by vc4_hdmi and update th=
e code
> =A0=A0=A0 accordingly.
> =A0=A0=A0
> =A0=A0=A0 Signed-off-by: Maxime Ripard <maxime@cerno.tech>

So it looks like there was two issues on the Pi3. The first one was
causing the timeouts (and therefore likely the black screen but
heartbeat case you had) and I've fixed it.

However, I can indeed reproduce the case with the black screen / no
heartbeat you mentionned. My bisection however returns that it's the
patch "drm/vc4: hdmi: Implement finer-grained hooks" that is at fault.
I've pushed my updated branch, if you have some spare time, it would be
great if you could confirm it on your Pi.

Thanks!
Maxime

--asvcqtopuuknnpqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXtpYOAAKCRDj7w1vZxhR
xf9jAQC4sbO7gTPrY+AYp6HoBjwhGF/cKMoBw0aBgSFH6qrDqQEA/3s8NbKTknIO
K4w8V3kQW1l1djAqB8JZNAhrna7IAwU=
=+SaZ
-----END PGP SIGNATURE-----

--asvcqtopuuknnpqy--
