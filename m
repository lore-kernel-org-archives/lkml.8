Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97566C8300C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 08:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F135214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 08:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Crn54lkB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MfacvNZm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgD3IqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 04:46:09 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:43957 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726412AbgD3IqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 04:46:07 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 941B190D;
        Thu, 30 Apr 2020 04:46:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 30 Apr 2020 04:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=fpjtGZf8AqSI48exIlo8OnF8z0r
        obzEYf4a720y11JI=; b=Crn54lkBtd00EaqOJspktSUBCz50ahh6oNvAj45B9nN
        Iwl59n8WUN4O2OGxKJz0cNVwsmE3RdYV+3VrQAcA7L7umKCCt2/DUlTmNUBMr56Q
        BxuwEjBk4fF/pEj8TJOyPTUbKDBAkAxpha/IstRwOrsXiHC+nn78wQf7BVCXC8HC
        gRpC2Ih4tLzOA5KnczD36BWaZL6SuZQTuoggbyx8ySwZWqhfeRqjGqznqCne+QIq
        fES7oWLLnLoImdP9lHX0evFtLflOksq9e9Z+1A3dQhGjo+HAPhAQC1voptWLQyUv
        eKp6xf83V69RUKxIEV6G9GTJtNnN3VcfNvpxQPHuc0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=fpjtGZ
        f8AqSI48exIlo8OnF8z0robzEYf4a720y11JI=; b=MfacvNZm1+/+qJ2z+cBQh9
        CWx/PNOje+aXmEZyXakBvlexfUNKWaee4mYIFb4WPcefbzxemjkRDc6nBp4MOoz4
        k4PmL1Flr7D9pvwoY8BiDFGOki1p61NVDqiezlvuKoOoamyRc02v40H2jxlNrfSH
        p35tV48BXr+yHhgL6RNwaDFQcGW+o2mxWIIrDBvLe2ZJkF2cqLh3deifsMOxWXZ6
        TxHjUoJjnji88vysO/jHChZtcWA0V1YRJNM/h1leuNuCrgGlfxMzjGFCN+7+a5bO
        0BDRiH+2y82LZUMIhvbK3dCeWTQU+GRMMcVangrSLfvoYzivKhm5alewsSNa2JFg
        ==
X-ME-Sender: <xms:SpCqXhoWXIPqto5Zw9q9kGy8eExsyYKiFCJs7MvLNuhXR9-EWk8Ryw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrieehgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeduvdduhfekkeehgffftefflefgffdtheffudffgeevteffheeuiedvvdejvdfg
    veenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:SpCqXt8_Xg_kmJW_z9vDfQNvzkNt0Qy2S24GmNMmKFQqiZAiOHBRvw>
    <xmx:SpCqXmYF-MTqX7R7WKqDvEh1JI1fs8uIYh1nZDFpPLjek26B8d0uNQ>
    <xmx:SpCqXn0MbOxK1PQtCxaoNwCyZulXcZPqOBUhbdCAXq3jAvkcAXmQIQ>
    <xmx:TZCqXsEDR3SBul6X-zgv3p3lwGz03BsnL8RlEu8Btqu5aDV62mGCvDcSyRU>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3765C3280067;
        Thu, 30 Apr 2020 04:46:02 -0400 (EDT)
Date:   Thu, 30 Apr 2020 10:46:00 +0200
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
Message-ID: <20200430084600.samghw4zxb5zdbez@gilmour.lan>
References: <20200426104115.22630-1-peron.clem@gmail.com>
 <20200426104115.22630-4-peron.clem@gmail.com>
 <20200428081321.ht3el26yqhsnyfm4@gilmour.lan>
 <CAJiuCcdVs_drs40Q6537BYfz24F7NmC6B8S5-Lt4V4ggs-FXWA@mail.gmail.com>
 <20200429123529.y24dpy63wxq7uvkt@gilmour.lan>
 <CAJiuCcfXqizcq_JuXRCsqEqM2562cr1SGJ0pmy07jcJxAXojOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y3cvvuhxye45tbpz"
Content-Disposition: inline
In-Reply-To: <CAJiuCcfXqizcq_JuXRCsqEqM2562cr1SGJ0pmy07jcJxAXojOw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y3cvvuhxye45tbpz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 29, 2020 at 06:33:00PM +0200, Cl=E9ment P=E9ron wrote:
> On Wed, 29 Apr 2020 at 14:35, Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > On Tue, Apr 28, 2020 at 10:55:47AM +0200, Cl=E9ment P=E9ron wrote:
> > > > > +static int sun50i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
> > > > > +                              unsigned int fmt)
> > > >
> > > > The alignment is off here
> > > >
> > > > > +{
> > > > > +     u32 mode, val;
> > > > > +     u8 offset;
> > > > > +
> > > > > +     /*
> > > > > +      * DAI clock polarity
> > > > > +      *
> > > > > +      * The setup for LRCK contradicts the datasheet, but under a
> > > > > +      * scope it's clear that the LRCK polarity is reversed
> > > > > +      * compared to the expected polarity on the bus.
> > > > > +      */
> > > >
> > > > Did you check this or has it been copy-pasted?
> > >
> > > copy-pasted, I will check this.
> >
> > It's not going to be easy to do this if you only have a board with HDMI=
=2E If you
> > can't test that easily, just remove the comment (or make it explicit th=
at you
> > copy pasted it?), no comment is better than a wrong one.
>=20
> I have talked with Marcus Cooper it may be able to test this this week-en=
d.
> Also this can explain why we need the "
> simple-audio-card,frame-inversion;" in the device-tree.
>=20
> If think this fix has been introduced by you, correct? Could you say
> on which SoC did you see this issue?

This was seen on an H3

Maxime

--y3cvvuhxye45tbpz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXqqQRwAKCRDj7w1vZxhR
xc06AP4quZAf2DNrCglxI3FnGicJEvn/UCQlNMdBjtAZiNt6NAEAklrbdL9EUUv6
PaDu07BZiJ7iqnqxZPn5egwCTM/O1Ac=
=jFs3
-----END PGP SIGNATURE-----

--y3cvvuhxye45tbpz--
