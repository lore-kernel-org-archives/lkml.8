Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF14C33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 12:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9FB620658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 12:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="krt68/O4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tXTcfqdN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgBCMXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 07:23:33 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:43495 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726272AbgBCMXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 07:23:32 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 5C70677F;
        Mon,  3 Feb 2020 07:23:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 03 Feb 2020 07:23:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=mK5GRvMA6OUDoG2czNoAx6gpqcM
        IiYNtIFDTy+GwdtA=; b=krt68/O4eS+hXbPUoQNMUGLZE0YG23MSyhZrBmCY8YH
        k+ut/AKHHKapO6RMewDROM9/XDqTjEsA9rCdtw+NRkMXVRR5iXMVj7R1r/2OZETh
        1ggYYGMpjo/LvgByLYJQmuoAOdqSRiisZk0nnHSZZvFh4NI9HkOdSm6Lbu2aZY2t
        Q9sK/V+QPbx0Vfk2K+MDPmAGKwy016w2i1i9gFne7l0fdUS6sz1NTlYWJGNnc51Z
        D4X+SmikI92MewdExBbPGZJXzYSQNQ5bbPDh3iE3Pf/slRIyHCTI4SlQfMeUapLq
        YAhIkF5obLki6wO/OHzdOg3DsLqOEbytLQhMLtPgNRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=mK5GRv
        MA6OUDoG2czNoAx6gpqcMIiYNtIFDTy+GwdtA=; b=tXTcfqdNu5grN+uQaNB053
        DOK96ZgPPwapBCsP82XtlqVoIGkhB1KQRhpzXKX0fgLN9fEjWb7FBtiuF4i+GfIb
        WrqFo5gAWpWdW3D3g149oJPA5UOqcFWdilwrGkGcz29ud3jz327gw6HQhu6/u0Ww
        3M+5lT0wBJdSU1WyphxQ/UGK+/qjf/dc9TePaWOIhQPupkil3OaZTtxe4OFOI1p8
        b4mmlj20Se0G/NjFb/gDUlMQRLSNMOxfU50AmsBM6lMU/DLznm6ntb2fQd4ZLbEm
        /ENpshOWwCagb8SrOnElNnCXDoHzQXEGf4+Hd23zPTRGAJteSZLkye4AclUFc2DQ
        ==
X-ME-Sender: <xms:wRA4Xt27TgAGyDexAd-cK8HZF69HRne4pP5OInIOYFAEDuk3GacaQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrgeejgdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucffohhmrghinh
    epsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrieekrdejieenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrh
    hnohdrthgvtghh
X-ME-Proxy: <xmx:wRA4XujZSucYxluqlAxtlUQeR4R-dWzAIQAUl8bQC5-f9brEBuZNYw>
    <xmx:wRA4XuVlru235DfEwyWpXyi4rwSgz7vcgoCxbH1U1oODHoCDzx-Tcw>
    <xmx:wRA4XtDaMZza1bdRRFSwwXQ2cx7WHjCOVl13HBqcr65LJGJ6IghKew>
    <xmx:wxA4XtCUfrxeJgghef7tzHaq9ZspKYVKe-5GpWdfGk8oZDtyvN_TwQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3087D3280060;
        Mon,  3 Feb 2020 07:23:29 -0500 (EST)
Date:   Mon, 3 Feb 2020 13:23:27 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Stefan Mavrodiev <stefan@olimex.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS FOR ALLWINNER A10" 
        <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 1/1] drm: sun4i: hdmi: Add support for sun4i HDMI
 encoder audio
Message-ID: <20200203122327.fviddfbkfn2bgycn@gilmour.lan>
References: <20200128140642.8404-1-stefan@olimex.com>
 <20200128140642.8404-2-stefan@olimex.com>
 <20200129164321.34mornbi3xvx5dys@gilmour.lan>
 <64676a4b-e149-146c-81b4-7fd5e792efc5@olimex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="us6nvolmdwutyb6n"
Content-Disposition: inline
In-Reply-To: <64676a4b-e149-146c-81b4-7fd5e792efc5@olimex.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--us6nvolmdwutyb6n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Jan 30, 2020 at 08:20:55AM +0200, Stefan Mavrodiev wrote:
> On 1/29/20 6:43 PM, Maxime Ripard wrote:
> > On Tue, Jan 28, 2020 at 04:06:42PM +0200, Stefan Mavrodiev wrote:
> > > diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> > > index 68d4644ac2dc..4cd35c97c503 100644
> > > --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> > > +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> > > @@ -23,6 +23,8 @@
> > >   #include <drm/drm_print.h>
> > >   #include <drm/drm_probe_helper.h>
> > >
> > > +#include <sound/soc.h>
> > > +
> > >   #include "sun4i_backend.h"
> > >   #include "sun4i_crtc.h"
> > >   #include "sun4i_drv.h"
> > > @@ -87,6 +89,10 @@ static void sun4i_hdmi_disable(struct drm_encoder *encoder)
> > >
> > >   	DRM_DEBUG_DRIVER("Disabling the HDMI Output\n");
> > >
> > > +#ifdef CONFIG_DRM_SUN4I_HDMI_AUDIO
> > > +	sun4i_hdmi_audio_destroy(hdmi);
> > > +#endif
> > > +
> > >   	val = readl(hdmi->base + SUN4I_HDMI_VID_CTRL_REG);
> > >   	val &= ~SUN4I_HDMI_VID_CTRL_ENABLE;
> > >   	writel(val, hdmi->base + SUN4I_HDMI_VID_CTRL_REG);
> > > @@ -114,6 +120,11 @@ static void sun4i_hdmi_enable(struct drm_encoder *encoder)
> > >   		val |= SUN4I_HDMI_VID_CTRL_HDMI_MODE;
> > >
> > >   	writel(val, hdmi->base + SUN4I_HDMI_VID_CTRL_REG);
> > > +
> > > +#ifdef CONFIG_DRM_SUN4I_HDMI_AUDIO
> > > +	if (hdmi->hdmi_audio && sun4i_hdmi_audio_create(hdmi))
> > > +		DRM_ERROR("Couldn't create the HDMI audio adapter\n");
> > > +#endif
> > I really don't think we should be creating / removing the audio card
> > at enable / disable time.
>
> For me it's unnatural to have sound card all the time, even when the HDMI
> is not plugged-in.

It's also a matter of being consistent: pretty much everyone else is
doing it:
  * vc4 (RaspberryPi)
    https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/vc4/vc4_hdmi.c#L1437

  * omap
    https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/omapdrm/dss/hdmi4.c#L620

  * sti
    https://elixir.bootlin.com/linux/v5.5.1/source/drivers/gpu/drm/sti/sti_hdmi.c#L1310

  * msm
    https://elixir.bootlin.com/linux/v5.5.1/source/drivers/gpu/drm/msm/hdmi/hdmi.c#L597

etc...

If we were to think about this at a more theorical level though, it's
pretty much the same case than having a sound card but no headphone
attached, or having a display engine but no display attached. In both
case, you register the driver before having a sink, you just let the
userspace know that there's nothing connected on the other end.

Maxime

--us6nvolmdwutyb6n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXjgQvwAKCRDj7w1vZxhR
xdqwAP90ShOJxBbtMrBiG8v3E0faJeHq3afqOhYkhGvBsaMulgEAiXnhh/hbOEYk
AIT/bNNWkq+0/C1clN/tSxpR02pJMwI=
=ubu/
-----END PGP SIGNATURE-----

--us6nvolmdwutyb6n--
