Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D624FC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 10:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93460207EA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 10:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="j3o+sUFn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CN2MS3ME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgIAKTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 06:19:30 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:56323 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725848AbgIAKT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 06:19:27 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 1952CEB1;
        Tue,  1 Sep 2020 06:19:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 01 Sep 2020 06:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=sUIriuDdEGEGb3qXjf0yLWBxBK6
        VbKbmpwiiPPnocWI=; b=j3o+sUFnvkQTt37CkFXstCodCLKl0o84yDR4q71zpEk
        GXvHq6HEjdGACV1BaMQmMLrub7y+cEsgbPxYooUeCDhIuU/pF5kefFvZ0Bi82W+9
        NFQOYfWg0C47cDsSQ2FyEPI0M9dI8qPT08UBY2brHey9eRJc8wAN5KGQD1L0+r5G
        3ZI7+LVYKUdOeeVADs+t0DNCgY76KF3Q14ASbOqIcVJECLHt3jJHWTOjBfctccjE
        JWDAQcHIc5E/Wux+AXA9jgAzz0xRm5/645i1wCWTmLHc5rfHntHfbWGVS6BSns0O
        6ToqZobbm5lDhn4bpLPZUN8I5YuNIiIyRi1Kd865B/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=sUIriu
        DdEGEGb3qXjf0yLWBxBK6VbKbmpwiiPPnocWI=; b=CN2MS3MEeKsFQO6hQP1aG+
        kva8V4WhTtX3OEXc4vmGjDW+hZFMH38jVlksnyhhRztB4FTsYI5d9Ol4vzIWETNE
        CEPcgBYtI0N9PMUYfkw8etJuaQdBFnQnFR5EZb1EaOpF53lDZS+VyBGylRYNh3gf
        ieopMJUjb6RG+nLvoDxgGobtf8jtB5QrMHtgnqjP92abqFXTeBw20rkR0ZDq9e3+
        82NZOw2XpdIGGUtPfFhHIhP0QPioUaCKuHCIIWI6GyepjSlgFlNR/HJNwkX68jSR
        QlrCcp2Qg+DCAepmEu6MDUEKQdQZcSAA5E1gHJtlEmqu0sHMJmPSW86DIYeD42GQ
        ==
X-ME-Sender: <xms:LCBOX8up6Q4ZPYhwrZjpwG148Pj_GLIIb2t-E_T-lGKhFkgSaMbRhg>
    <xme:LCBOX5fJIyEQfDCSp11uNtpHwflZjJeOt4kh0jmbOnol2Qd3DtJ5WFfa3kJg6LqvR
    zGpKlZVevZ9cla0YMk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefjedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:LCBOX3zX7gMwlyKAMJYADGkzJ9XHpSt7jLH31jTTlkoMBYB3tHMVOQ>
    <xmx:LCBOX_OTfrUOi8u2szg9lftfbTQ7j_H-fGrFRc1whT8gPwo-8cbdvg>
    <xmx:LCBOX88UGVoEJ5DbcYA3SMts_BPqQeSBGBrB5gimA3KYo-dP4aG3HA>
    <xmx:LSBOX5Pnfpw5CzRKG1MwpKYsNdO68IOK6eeZ1u16cZ_Ooxv4R1ns_A>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id AC989328005E;
        Tue,  1 Sep 2020 06:19:24 -0400 (EDT)
Date:   Tue, 1 Sep 2020 12:19:23 +0200
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
Subject: Re: [PATCH v4 77/78] drm/vc4: drv: Support BCM2711
Message-ID: <20200901101923.7e744qwtuvmnbtmn@gilmour.lan>
References: <cover.7a1aa1784976093af26cb31fd283cf5b3ed568bb.1594230107.git-series.maxime@cerno.tech>
 <90c53367b289e9c0f9eeb97794a8d3b08d813884.1594230107.git-series.maxime@cerno.tech>
 <CAPY8ntB3eeqqz0hPSfHiJpKs9sJpU5uN5GzLsqmhtxrD0i6TJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dozkezvx4o5iboho"
Content-Disposition: inline
In-Reply-To: <CAPY8ntB3eeqqz0hPSfHiJpKs9sJpU5uN5GzLsqmhtxrD0i6TJg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dozkezvx4o5iboho
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Tue, Jul 28, 2020 at 04:30:16PM +0100, Dave Stevenson wrote:
> > @@ -681,10 +684,14 @@ int vc4_kms_load(struct drm_device *dev)
> >         struct vc4_load_tracker_state *load_state;
> >         int ret;
> >
> > -       /* Start with the load tracker enabled. Can be disabled through=
 the
> > -        * debugfs load_tracker file.
> > -        */
> > -       vc4->load_tracker_enabled =3D true;
> > +       if (!of_device_is_compatible(dev->dev->of_node, "brcm,bcm2711-v=
c5")) {
>=20
> Is it better to look up the compatible string, or pass something via
> the .data element of the of_device_id table? Probably down to personal
> preference?

It's pretty much equivalent, so I'm not sure one is arguably better than
the other. However, checking for the compatible can be pretty cumbersome
when you have to do it repeatedly (like we do in the HDMI controller),
and when you don't it a lot, having a structure associated to the
compatible is also fairly cumbersome.

> > +               vc4->load_tracker_available =3D true;
> > +
> > +               /* Start with the load tracker enabled. Can be
> > +                * disabled through the debugfs load_tracker file.
> > +                */
> > +               vc4->load_tracker_enabled =3D true;
> > +       }
> >
> >         sema_init(&vc4->async_modeset, 1);
> >
> > @@ -698,8 +705,14 @@ int vc4_kms_load(struct drm_device *dev)
> >                 return ret;
> >         }
> >
> > -       dev->mode_config.max_width =3D 2048;
> > -       dev->mode_config.max_height =3D 2048;
> > +       if (of_device_is_compatible(dev->dev->of_node, "brcm,bcm2711-vc=
5")) {
>=20
> We're making the same of_device_is_compatible call twice within
> vc4_kms_load. Set a flag based on it and check that instead?

Good idea, thanks!
Maxime

--dozkezvx4o5iboho
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX04gKwAKCRDj7w1vZxhR
xdjRAP9NRCUkLEG71G/PlhSmiqu8PAfDEFoqOIOabvM3/kj1GAEAxUSCGhv9XmUs
ZhR7LLKC9pnKW5c295ozmuSloS08AQg=
=s4r0
-----END PGP SIGNATURE-----

--dozkezvx4o5iboho--
