Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11ADC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC9FA2072A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="lMmqBzMs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gN+Mn29O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgD2Mfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 08:35:34 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:60277 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726864AbgD2Mfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 08:35:33 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4187A5801CC;
        Wed, 29 Apr 2020 08:35:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 29 Apr 2020 08:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=c+9mUYpBdnOaBwykChFhcenmVtw
        9Gzvx3ldZ3YuHZDE=; b=lMmqBzMsWh43/t2YdttBouyW5iVp6dCQdZj/fOz3H1d
        Dm/7Y0wD1t7Qhqaf1dZSlt//mf/V62NMAx9jNyzT2eA52JxeQlxbaESuOjmXbIDM
        BB0q+8AJMOLGufrIrrDmlRP0zFfbj1x4R0k4Kd1st85gvkhoqJHdJsusVXaIjzG6
        IbzGBzdc1gccaVlznMNMauP7u74kYSbQtubCgo1udKZT60Us4JEO7Lhb9w/O16UH
        OUI81hYbXkI8Z10onZX2w3fDwxM2nIxHY9PWjF4WJ4lv/CBXoNatTymKStK+9lOR
        jdc5z7er/S1wADjy2BkMXEZJxYV16xz8aoABYr+yuEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=c+9mUY
        pBdnOaBwykChFhcenmVtw9Gzvx3ldZ3YuHZDE=; b=gN+Mn29OayTJ50jcW1+vxJ
        jolSrul8nF4EHDQq2CdeL9WH36K+vk5qtiVbdhUCMDz2OriGY8S9x5zpEZAQD9XY
        zQDRhqIuXCZNSyBbwkBMSH1LfIHVctO1tYRZ7NHa6ibP1cxLoybEDi/kON/OsHHk
        aeH0W6Sm6r14ZrVLWAOFUoaHEe4cENs+2TcKIlVsZugQy/Qi5nrbwGP3rtUcMb7t
        f+d8mCsKWC3K1OhQnnCB9rnhNyQBLu0M3tDeeawWrGwYod8Ljxr8hXJISYzWYZZ/
        XjZIiNIXJI1B1Oqf5kmp+Zo9o5maELICMhOe2wHq6/N8MM2Z7+d/CBW/liq1p/Qg
        ==
X-ME-Sender: <xms:k3SpXpGA2NsI1LpjKQpePExH66TePqj82Bu0RZA-0E16HKXSo74eiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrieefgdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:k3SpXpcp2cjteMbrV6tVzU1OAb4HfglVBI6S6pWxqvOHWoMc0hStZw>
    <xmx:k3SpXgh6khNMHd7bQAs_djhE6464AP0f1IJNVQhCXkJvenSynyvXow>
    <xmx:k3SpXu7kpl6cHsO55jleUPsBLuO5YGvbwOn8tMIe6nb52uf53qGFtg>
    <xmx:lHSpXl2XuvQ7vHyGfSBrMMkN28yCT0mlxb8jK4PAnimTaNDh77iv3w>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id BD9D13280066;
        Wed, 29 Apr 2020 08:35:30 -0400 (EDT)
Date:   Wed, 29 Apr 2020 14:35:29 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Marcus Cooper <codekipper@gmail.com>
Subject: Re: [PATCH v3 3/7] ASoC: sun4i-i2s: Add support for H6 I2S
Message-ID: <20200429123529.y24dpy63wxq7uvkt@gilmour.lan>
References: <20200426104115.22630-1-peron.clem@gmail.com>
 <20200426104115.22630-4-peron.clem@gmail.com>
 <20200428081321.ht3el26yqhsnyfm4@gilmour.lan>
 <CAJiuCcdVs_drs40Q6537BYfz24F7NmC6B8S5-Lt4V4ggs-FXWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xa3hju3zorbs63j6"
Content-Disposition: inline
In-Reply-To: <CAJiuCcdVs_drs40Q6537BYfz24F7NmC6B8S5-Lt4V4ggs-FXWA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xa3hju3zorbs63j6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2020 at 10:55:47AM +0200, Cl=E9ment P=E9ron wrote:
> > > +static int sun50i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
> > > +                              unsigned int fmt)
> >
> > The alignment is off here
> >
> > > +{
> > > +     u32 mode, val;
> > > +     u8 offset;
> > > +
> > > +     /*
> > > +      * DAI clock polarity
> > > +      *
> > > +      * The setup for LRCK contradicts the datasheet, but under a
> > > +      * scope it's clear that the LRCK polarity is reversed
> > > +      * compared to the expected polarity on the bus.
> > > +      */
> >
> > Did you check this or has it been copy-pasted?
>=20
> copy-pasted, I will check this.

It's not going to be easy to do this if you only have a board with HDMI. If=
 you
can't test that easily, just remove the comment (or make it explicit that y=
ou
copy pasted it?), no comment is better than a wrong one.

Maxime

--xa3hju3zorbs63j6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXql0kQAKCRDj7w1vZxhR
xUWEAP0SrqSZD58viGba5AVL4qJo+eXiSzFllUnrvAolQg9p/gEAqQDc4TVprwLF
ugV0n3K3xZMYx6BObJM8w1vig/EXdAA=
=J0U2
-----END PGP SIGNATURE-----

--xa3hju3zorbs63j6--
