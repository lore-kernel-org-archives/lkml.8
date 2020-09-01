Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A13C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 09:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F16FD2083B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 09:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="MJkvAFab";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HBBaWnBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgIAJpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 05:45:21 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:43019 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726174AbgIAJpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 05:45:14 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 41796638;
        Tue,  1 Sep 2020 05:45:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 01 Sep 2020 05:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=4gcyFzed9X7eNC7JzpnKedk4o4e
        NcTrAMfkvVcC89lk=; b=MJkvAFabzYnLIuY8R6cMW1TKfX3Z01jyYZqBVsx0iJj
        kaVPG09Kvm5zLsQBGnseFzZ7CdjPPgek2sIOsHRjaAvsLqg4iERsSzzJ2HzMg56u
        chvcdPJW914+nOBtkiiNQo17fgf92eLjdIk9f9Sxei8m1bn2bi8kIAeL84/XrD+d
        MMTWaRvsG4QZnVp738UtbWsW8iE/o13rVP2gwBIZlO2dGyzMm60G23TeELgXiQ0V
        CEgasM23QQ0xnvG0iR3+ZoJM1U8aq7+P50kU2PXJ3Jj+nfo2szEsPYWTuhrBztxG
        uhIzPJipzF2fvlE5l5aETJcCfc5BY2nFT/mMA2rFvSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=4gcyFz
        ed9X7eNC7JzpnKedk4o4eNcTrAMfkvVcC89lk=; b=HBBaWnBsPg9041RHVLgrHY
        iU6422JtfjgK93fFnZh6tOcjmm7qYs9RnbcSJl4WJwvDr4elf4CRlo3+vdEf58Lm
        yMQq15DmAiQCPwYCMbiRhksdHdyiRQKufj3YdWbpfN7xVWKL0Y1JXiCGfWqnx3Fg
        4JQROsFW2egQU28hv6aOsv/i7JmOI+XP+Bougqrkqr8sqGdWPdZ3OUK4FqVr05Xv
        s2Aeb5Ng/zOKAM1+05jB63aVcffSuBdOc/kqRlsILcRyF9sBuXcUfUsu2zdhjP2N
        BpuRjtTQBjv7n5DPkA5yKOX45YQ0r8Hjtxl6WoTeMuppW0WTT0yKldBlmlhSV5LQ
        ==
X-ME-Sender: <xms:JxhOX7YlJZzhbsmZXY9KU9wu_acJhSM_WO75amykEsTlKYLEHKnRZg>
    <xme:JxhOX6aucLsV89BqrtQng2xIUEsv2lpEXv1kPSOkH2XpJ6gl6BEOCAPkK7cp6AGZP
    0LyMVzOnpJUPnRSWSE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefjedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:JxhOX9_YS_ijvM0h8Qmjwums0DuFkL6xcKaJY3Am23bKEC9qq16ZSw>
    <xmx:JxhOXxodm3EMTzXe5IwQucVyVZMRsx2XkgOy66XwLR5j2uFJnRewvw>
    <xmx:JxhOX2qEbFfwPMhklXLUkPZs9ThbrhsPeU6m35r5DihuR2QUvkgXAg>
    <xmx:KBhOXye3rr_neJTUrYOWteh1q0iCgCh0qoi-uE1oqqzGI-EKioia-lPaTTE>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5B5F03280059;
        Tue,  1 Sep 2020 05:45:11 -0400 (EDT)
Date:   Tue, 1 Sep 2020 11:45:09 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH v4 62/78] drm/vc4: hdmi: Adjust HSM clock rate depending
 on pixel rate
Message-ID: <20200901094509.spgxtkfybebo7mmb@gilmour.lan>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <CGME20200708174513epcas1p2c059db88d8dad1d58aae3651b3c98c2b@epcas1p2.samsung.com>
 <5919dccdd4a792936e6cb7eb55983c530c9a468d.1594230107.git-series.maxime@cerno.tech>
 <95172a9a-e861-5e5d-bf51-2ec03c730237@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l2cz7keizc6yoqv4"
Content-Disposition: inline
In-Reply-To: <95172a9a-e861-5e5d-bf51-2ec03c730237@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l2cz7keizc6yoqv4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Chanwoo,

On Tue, Sep 01, 2020 at 01:36:17PM +0900, Chanwoo Choi wrote:
> On 7/9/20 2:42 AM, Maxime Ripard wrote:
> > The HSM clock needs to be setup at around 101% of the pixel rate. This
> > was done previously by setting the clock rate to 163.7MHz at probe time=
 and
> > only check in mode_valid whether the mode pixel clock was under the pix=
el
> > clock +1% or not.
> >=20
> > However, with 4k we need to change that frequency to a higher frequency
> > than 163.7MHz, and yet want to have the lowest clock as possible to hav=
e a
> > decent power saving.
> >=20
> > Let's change that logic a bit by setting the clock rate of the HSM clock
> > to the pixel rate at encoder_enable time. This would work for the
> > BCM2711 that support 4k resolutions and has a clock that can provide it,
> > but we still have to take care of a 4k panel plugged on a BCM283x SoCs
> > that wouldn't be able to use those modes, so let's define the limit in
> > the variant.
> >=20
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > ---
> >  drivers/gpu/drm/vc4/vc4_hdmi.c | 79 ++++++++++++++++-------------------
> >  drivers/gpu/drm/vc4/vc4_hdmi.h |  3 +-
> >  2 files changed, 41 insertions(+), 41 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_h=
dmi.c
> > index 17797b14cde4..9f30fab744f2 100644
> > --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> > +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> > @@ -53,7 +53,6 @@
> >  #include "vc4_hdmi_regs.h"
> >  #include "vc4_regs.h"
> > =20
> > -#define HSM_CLOCK_FREQ 163682864
> >  #define CEC_CLOCK_FREQ 40000
> > =20
> >  static int vc4_hdmi_debugfs_regs(struct seq_file *m, void *unused)
> > @@ -326,6 +325,7 @@ static void vc4_hdmi_encoder_disable(struct drm_enc=
oder *encoder)
> >  	HDMI_WRITE(HDMI_VID_CTL,
> >  		   HDMI_READ(HDMI_VID_CTL) & ~VC4_HD_VID_CTL_ENABLE);
> > =20
> > +	clk_disable_unprepare(vc4_hdmi->hsm_clock);
> >  	clk_disable_unprepare(vc4_hdmi->pixel_clock);
> > =20
> >  	ret =3D pm_runtime_put(&vc4_hdmi->pdev->dev);
> > @@ -423,6 +423,7 @@ static void vc4_hdmi_encoder_enable(struct drm_enco=
der *encoder)
> >  	struct vc4_hdmi *vc4_hdmi =3D encoder_to_vc4_hdmi(encoder);
> >  	struct vc4_hdmi_encoder *vc4_encoder =3D to_vc4_hdmi_encoder(encoder);
> >  	bool debug_dump_regs =3D false;
> > +	unsigned long pixel_rate, hsm_rate;
> >  	int ret;
> > =20
> >  	ret =3D pm_runtime_get_sync(&vc4_hdmi->pdev->dev);
> > @@ -431,9 +432,8 @@ static void vc4_hdmi_encoder_enable(struct drm_enco=
der *encoder)
> >  		return;
> >  	}
> > =20
> > -	ret =3D clk_set_rate(vc4_hdmi->pixel_clock,
> > -			   mode->clock * 1000 *
> > -			   ((mode->flags & DRM_MODE_FLAG_DBLCLK) ? 2 : 1));
> > +	pixel_rate =3D mode->clock * 1000 * ((mode->flags & DRM_MODE_FLAG_DBL=
CLK) ? 2 : 1);
> > +	ret =3D clk_set_rate(vc4_hdmi->pixel_clock, pixel_rate);
> >  	if (ret) {
> >  		DRM_ERROR("Failed to set pixel clock rate: %d\n", ret);
> >  		return;
> > @@ -445,6 +445,36 @@ static void vc4_hdmi_encoder_enable(struct drm_enc=
oder *encoder)
> >  		return;
> >  	}
> > =20
> > +	/*
> > +	 * As stated in RPi's vc4 firmware "HDMI state machine (HSM) clock mu=
st
> > +	 * be faster than pixel clock, infinitesimally faster, tested in
> > +	 * simulation. Otherwise, exact value is unimportant for HDMI
> > +	 * operation." This conflicts with bcm2835's vc4 documentation, which
> > +	 * states HSM's clock has to be at least 108% of the pixel clock.
> > +	 *
> > +	 * Real life tests reveal that vc4's firmware statement holds up, and
> > +	 * users are able to use pixel clocks closer to HSM's, namely for
> > +	 * 1920x1200@60Hz. So it was decided to have leave a 1% margin between
> > +	 * both clocks. Which, for RPi0-3 implies a maximum pixel clock of
> > +	 * 162MHz.
> > +	 *
> > +	 * Additionally, the AXI clock needs to be at least 25% of
> > +	 * pixel clock, but HSM ends up being the limiting factor.
> > +	 */
> > +	hsm_rate =3D max_t(unsigned long, 120000000, (pixel_rate / 100) * 101=
);
> > +	ret =3D clk_set_rate(vc4_hdmi->hsm_clock, hsm_rate);
> > +	if (ret) {
> > +		DRM_ERROR("Failed to set HSM clock rate: %d\n", ret);
> > +		return;
> > +	}
> > +
> > +	ret =3D clk_prepare_enable(vc4_hdmi->hsm_clock);
> > +	if (ret) {
> > +		DRM_ERROR("Failed to turn on HSM clock: %d\n", ret);
> > +		clk_disable_unprepare(vc4_hdmi->pixel_clock);
> > +		return;
> > +	}
>=20
> About vc4_hdmi->hsm_clock instance, usually, we need to enable the clock
> with clk_prepare_enable() and then touch the clock like clk_set_rate().
> I think that need to enable the clock before calling clk_set_rate().
>=20
> When I tested this patchset, it is well working because I think that
> vc4_hdmi->hsm_clock was already enabled on other side.

There's no clear rule here on the ordering (at least enforced by the
framework). There's clocks that need to be disabled to change their rate
(CLK_SET_RATE_GATE) and some that need to be enabled to change their
rate (CLK_SET_RATE_UNGATE).

Generally speaking, it seems more logical to me to have first the rate
changed and then the clock enabled since it won't create any "hiccup",
but I could very well see the opposite to be preferred.

Maxime

--l2cz7keizc6yoqv4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX04YJQAKCRDj7w1vZxhR
xW70AQD/ZlQ9or7xShXk/2/RckodgJ+4vJLaVsavf7Tsd0WhvAEAiTeK619R18o6
OPxacjLjaE8/DQ+zuJRSY/O8LFoIdgU=
=OBfP
-----END PGP SIGNATURE-----

--l2cz7keizc6yoqv4--
