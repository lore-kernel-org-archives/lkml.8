Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E2EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 15:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73C982067B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 15:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Rkdjea0M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FG1fvapU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgFBPy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 11:54:29 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:37131 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726139AbgFBPy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 11:54:29 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id AB6D25C0227;
        Tue,  2 Jun 2020 11:54:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 02 Jun 2020 11:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=cdDGYcXym9L8clxXR7KCFX14lxp
        SPK3OttsaYL6SZMQ=; b=Rkdjea0MH42CeGwamJbTWWfqpvMJsV2xK02vgbSF639
        /oW/Ff3PEMIqdKlqXYKsesOY1H1c6n5qYaf7xIOt+yoSAwQ3acSmVhwhgHjN9cVV
        n/uySVAguavnJqPybHybYNDsAJlScinOT+e1vZP/owqo4c6l4Tb4pF45bxPDqIHe
        ZMY+2xDItJuGfDiqTlfpYcAqSfRDLjcgUfjPcIVWQlwm0ISAlVx/Haem82T8xhq4
        z87xZbNSfyolr7jSgJa+xHN7SuYsjJAaZBMNsdhtRejMrVEUI7Gm+4DfawKZEQ2N
        tpatmLUiErXrKm7HFOwtm04zuOViX7jK7aEEhIMKs4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=cdDGYc
        Xym9L8clxXR7KCFX14lxpSPK3OttsaYL6SZMQ=; b=FG1fvapUBdisWavPjmkg/O
        JzN0HnI76u3btB0Lt/yl8Nr27ZevaEaPaDipHkXmzVImPTcXCkwpy+N8xkpl4njH
        OvBuc+bcIynauF1EZxRx0Vy0kIgADC2Rh8Hj/70AcW2BqdptdFO+t26KIIghuBs9
        99lYLLqwFlIdhrRNxKKEtSDpKRCof25CcIUUfTRb3FSr+GZfrPW8ssDVkpMSvRMv
        GldVQA6DlbouRt5Uu3iKQbw2+7nkvlBF9L1ezRRyZRwqE5l5ycbI2JMz8SCzlmx0
        +rJWzkIv+4hjjdHInHrKAuoJBnFGUHlgZt1GnxdVP5oXRH8zdLRUvuYzrrGbQTMg
        ==
X-ME-Sender: <xms:L3bWXsXx44AiawlHbjJXh4GFdSRZGDT1PhULNJufspRHdmrhD4r3BQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudefjedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:L3bWXgkL16skZvtumvJ5vqnQcghldRxJ9t0TDRArNqNQfJcOj6yERQ>
    <xmx:L3bWXgYhJlDYVM3OTJue3vOCLs_Te6h9oOIZO4vF-0l4pN88pBu-NQ>
    <xmx:L3bWXrXfUkwHji9SEzOWV7DiLoHnhX-RxDYlExIYL-AVa0vqo7fceg>
    <xmx:M3bWXkZSdZp066jr43w93PAXpjkTcQ85bjREF4g_IIhBZKS4W7oV5Q>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 50C1C3280060;
        Tue,  2 Jun 2020 11:54:23 -0400 (EDT)
Date:   Tue, 2 Jun 2020 17:54:21 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Eric Anholt <eric@anholt.net>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH v3 070/105] drm/vc4: hdmi: rework connectors and encoders
Message-ID: <20200602155421.niyvpwqc42xh5c7v@gilmour>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
 <020de18840a1075b2671736c6cc2e451030fad74.1590594512.git-series.maxime@cerno.tech>
 <CADaigPXJ0BnMUp=XN6G92Tx=H9j55pmsBAujO2mcpiiTs-RHnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qxxigstfuc465wjv"
Content-Disposition: inline
In-Reply-To: <CADaigPXJ0BnMUp=XN6G92Tx=H9j55pmsBAujO2mcpiiTs-RHnQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qxxigstfuc465wjv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2020 at 11:41:24AM -0700, Eric Anholt wrote:
> On Wed, May 27, 2020 at 8:51 AM Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > the vc4_hdmi driver has some custom structures to hold the data it need=
s to
> > associate with the drm_encoder and drm_connector structures.
> >
> > However, it allocates them separately from the vc4_hdmi structure which
> > makes it more complicated than it needs to be.
> >
> > Move those structures to be contained by vc4_hdmi and update the code
> > accordingly.
>=20
>=20
> > @@ -1220,7 +1219,7 @@ static int vc4_hdmi_bind(struct device *dev, stru=
ct device *master, void *data)
> >         struct drm_device *drm =3D dev_get_drvdata(master);
> >         struct vc4_dev *vc4 =3D drm->dev_private;
> >         struct vc4_hdmi *hdmi;
> > -       struct vc4_hdmi_encoder *vc4_hdmi_encoder;
> > +       struct drm_encoder *encoder;
> >         struct device_node *ddc_node;
> >         u32 value;
> >         int ret;
> > @@ -1229,14 +1228,10 @@ static int vc4_hdmi_bind(struct device *dev, st=
ruct device *master, void *data)
> >         if (!hdmi)
> >                 return -ENOMEM;
> >
> > -       vc4_hdmi_encoder =3D devm_kzalloc(dev, sizeof(*vc4_hdmi_encoder=
),
> > -                                       GFP_KERNEL);
> > -       if (!vc4_hdmi_encoder)
> > -               return -ENOMEM;
> > -       vc4_hdmi_encoder->base.type =3D VC4_ENCODER_TYPE_HDMI0;
> > -       hdmi->encoder =3D &vc4_hdmi_encoder->base.base;
> > -
> >         hdmi->pdev =3D pdev;
> > +       encoder =3D &hdmi->encoder.base.base;
> > +       encoder->base.type =3D VC4_ENCODER_TYPE_HDMI0;
>=20
> Wait, does this patch build?

All those patches were build tested, so yep

> setting struct drm_encoder->base.type =3D VC4_* seems very wrong, when
> previously we were setting struct vc4_hdmi_encoder->base.type (struct
> vc4_encoder->type).

So the structure layout now is that vc4_hdmi embeds vc4_hdmi_encoder as
encoder. So &hdmi->encoder is a pointer to vc4_hdmi_encoder.
vc4_hdmi_encoder's base is since that patch a struct vc4_encoder. and
vc4_encoder's base is a drm_encoder.

so encoder being a drm_encoder is correct there.

However, drm_encoder's base is drm_mode_object that does have a type
field, which is an uint32_t, which will accept a VC4_ENCODER_TYPE_* just
fine...

Now, drm_encoder_init will then kick in and call drm_mode_object_add
which will override it to a proper value and since the clock select bit
in the PV is the same for both HDMI0 and HDMI1, everything works just
fine...

Good catch, I'll fix it. And I guess it's a good indication we don't
need a separate HDMI0 and HDMI1 encoder type.

> Other than this, patch 68-78 r-b.

Thanks for your review!
Maxime

--qxxigstfuc465wjv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXtZ2LQAKCRDj7w1vZxhR
xfluAP43aoGu2OPb0dq0BcgQ5MBEsuDCQDD5MHgSVl0cRgWGjwD/aa+PuVsSgsR0
5+38Ljq0cbWaxeUJTzW8daGiUZDn8wM=
=KM7l
-----END PGP SIGNATURE-----

--qxxigstfuc465wjv--
