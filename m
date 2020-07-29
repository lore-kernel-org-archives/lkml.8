Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568F2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ED7220809
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="EYN7iWWE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LyKuQZ/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgG2Om5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:42:57 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:51919 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726385AbgG2Om4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:42:56 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 6A25A5C010E;
        Wed, 29 Jul 2020 10:42:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 29 Jul 2020 10:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=GzwVm6BSp1ZpDRDfO3rdNYnD6Uv
        13RpFnX4V+Vax2sQ=; b=EYN7iWWEksJ77iqIIeKYYbvHG81CngqUXgg3mE536K2
        VPPUvgFbqWXWi5CP9T75H7YVimk9w7RoHk1QYI3y6JPMbhpYU8q/oJXXkObPPRfS
        50LRisXUN9kDWPi/+D5mxray0jCmRozF+b16goF9hdqjryt9mM/wC7a7LYAK/aNU
        PKw1c7Rw8Aiv9pVx6Ul2Ctp+HAyrJBEAGWTWmkNnULLLYRqQAvszYw9k309Jkqhi
        /sOHd16SCbLQ7YrRqnDyV4dE+SNsBmMCJrmRBtkeZTeNVpd0l9YtOZEBaZMoafEA
        OroAZyKsV6XMSefybgRfQwKmlE6ey+e8udp9ZIQtVuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=GzwVm6
        BSp1ZpDRDfO3rdNYnD6Uv13RpFnX4V+Vax2sQ=; b=LyKuQZ/7iYq0YDjnQKy+36
        8fN88UQprKwp1IxLhrluFXHy4bfISn8IIGFIb0DKmchN2aGHbZvRW2nfdHhqShCG
        11oXYUxq7WCc1On1RKhYHrYnIwW4LSyE6lYWGuSz4oUvFhri9Etie2DdxhvG4Vnh
        FB1jJJ68Bxb44YLsZOYfJKPr0UpRXXVs4U0kYG159RLjOmi+N/bgf924ppRoMYod
        n1DyHxvOWHBceItDnMypktJhGKlLdoH02qArYKJY/kSSFEMH70XRGUECZfS4NR9J
        LaR8hn8UjmI55kMzLaHnUY6olaO1alM5vS1g+82D9+Y98tZ7Tf3gl/p1vaRAneKw
        ==
X-ME-Sender: <xms:7YohX4ewiCVAOFMx0l3ZS65cHcBZGaUAvRRYw_1V1qquBtlrJfLJig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrieeggdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:7YohX6OPNuAsPXjyPdjNMDGyDSR8oaiRw1kORJ9pvx4RyrjOoCTn0Q>
    <xmx:7YohX5jy6zc7bhZ9wnBcE3fW7kAqJ2jl83RrJJyTDLy7t8DN3DkGzw>
    <xmx:7YohX99GboQKJT7nVsiJsvfMK7O8xdCWFFXx6gihboxqYaY4y4BN8Q>
    <xmx:74ohX4hFr-Ez06vsH64PR9G77XZlo7yKidvmk6pDZ4esocs2x0BBKQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1E63C30600B9;
        Wed, 29 Jul 2020 10:42:53 -0400 (EDT)
Date:   Wed, 29 Jul 2020 16:42:51 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH v4 29/78] drm/vc4: crtc: Add a delay after disabling the
 PixelValve output
Message-ID: <20200729144251.us6a2pgkjjmm53ov@gilmour.lan>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <a1f22aadc60a2f32022831a6348c8bbd6e1954c3.1594230107.git-series.maxime@cerno.tech>
 <CAPY8ntBLWrfagZ5-kQz+5Mkw4_KaaTP63_L3D4owJAfA5kFpzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7egmvjdmvf73mwty"
Content-Disposition: inline
In-Reply-To: <CAPY8ntBLWrfagZ5-kQz+5Mkw4_KaaTP63_L3D4owJAfA5kFpzw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7egmvjdmvf73mwty
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 29, 2020 at 03:09:21PM +0100, Dave Stevenson wrote:
> On Wed, 8 Jul 2020 at 18:43, Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > In order to avoid pixels getting stuck in the (unflushable) FIFO between
> > the HVS and the PV, we need to add some delay after disabling the PV ou=
tput
> > and before disabling the HDMI controller. 20ms seems to be good enough =
so
> > let's use that.
> >
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > ---
> >  drivers/gpu/drm/vc4/vc4_crtc.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_c=
rtc.c
> > index d0b326e1df0a..7b178d67187f 100644
> > --- a/drivers/gpu/drm/vc4/vc4_crtc.c
> > +++ b/drivers/gpu/drm/vc4/vc4_crtc.c
> > @@ -403,6 +403,8 @@ static void vc4_crtc_atomic_disable(struct drm_crtc=
 *crtc,
> >         ret =3D wait_for(!(CRTC_READ(PV_V_CONTROL) & PV_VCONTROL_VIDEN)=
, 1);
> >         WARN_ONCE(ret, "Timeout waiting for !PV_VCONTROL_VIDEN\n");
> >
> > +       mdelay(20);
>=20
> mdelay for 20ms seems a touch unfriendly as it's a busy wait. Can we
> not msleep instead?

Since the timing was fairly critical, sleeping didn't seem like a good
solution since there's definitely some chance you overshoot and end up
with a higher time than the one you targeted.

Maxime

--7egmvjdmvf73mwty
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXyGK6wAKCRDj7w1vZxhR
xW7BAQDwt5j9Pshu1GKCULxSDv9PS+5o32//+Xr9V03eudzzWgD/ez5A4HPtG6s1
iaSko1HSa8F3EhSBN2c4qShUyYpkhAI=
=fvZ0
-----END PGP SIGNATURE-----

--7egmvjdmvf73mwty--
