Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97562C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BBF420873
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="ZmZWy1K9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oY1AFMm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgBNIx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 03:53:56 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:51185 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726179AbgBNIx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 03:53:56 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 6EEBD21F48;
        Fri, 14 Feb 2020 03:53:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 14 Feb 2020 03:53:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=nRZRLhlO/XQ/GfE1zKQ+XfhhpTe
        +BnKJsToqv+ZGaCc=; b=ZmZWy1K9gsQGrOArTXLvec8bCgeBm2/AneSGjYTQ8c0
        f0y88eHnsitkvfMU/gYDZoKbcawS60Akr+SMFmC5cxUV60K/IzKu/ZmsZiHIjsdj
        v6qVTZ2p5512u1vY8OeF3A+B1mkzIJxM8Qli0lc5Y9l6N8OnEeMyAkEDeSjyfpxf
        X6Pzw0hPB6uddkb6Eqr5UxGbZVfTo/SRjWHr+iaMOuy6QujOvbl8gpEzLdN2wCZr
        eVurIej8Xr1+qlOUmLlyLPVWmOxXNDIVcYMGEjVxEHCcjd5Adi8bNR/qwsbewzAN
        lZPWSq335OqLz2xk17uqtqGYtcQL5XXaV35eVNPs5Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=nRZRLh
        lO/XQ/GfE1zKQ+XfhhpTe+BnKJsToqv+ZGaCc=; b=oY1AFMm43qUtgUjN3/PG2o
        F8l1lT6a4E/UHoW2PPyNkPQxt7m8BY0vZYPmLdoCke4/FxmR84o0LstXY9fUoJih
        s+rkE5UHlxfbjsFnVxZfg87xxeKHANm4U0FNdpQfPCuIgJoycKeUOzY++e6/hp0b
        HLVYOW4qOIEZfKA+f5ESUeYD99cHVu5TL09YLw4J212/LkWxC7B/VEAmTnE3Vh0V
        J2KkiZySa7YNj49Pry7tfX4hswQrlQYIfwpntwnrVRmVE8/kRMJfmjk2uiqdlhTb
        iJvZVNe464TEso2jwwGqflUi6hXVk0MDWzkoOs5IdLoUB60AbnxRUdmx05201biQ
        ==
X-ME-Sender: <xms:IWBGXlA-JO5-BXfJA7FlPSZ8U8w8bB4LIB0TXgRE87XTVctvMh1HkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrieelgdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
    drkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:IWBGXlgux4rtcyFJbXJcXusgsm0VFMSZJt8aS8eRYwCy6a38Tta-Ng>
    <xmx:IWBGXpYixtT9ETMGWqEwV1KVzDcvetREVQg7DxSlILiIk9Ns2HOulw>
    <xmx:IWBGXnrqkFNBgW6gjjvMKltDGxEEoN5MXAoFdbsWMd9ZKFzj_LnoWg>
    <xmx:ImBGXggWlN_ZurQ6-ybSfQYFdTP4J8Ay0VaECrqOEYcRy29FFoEIZg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 25B723280064;
        Fri, 14 Feb 2020 03:53:53 -0500 (EST)
Date:   Fri, 14 Feb 2020 09:53:51 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andrey Lebedev <andrey.lebedev@gmail.com>
Cc:     wens@csie.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Andrey Lebedev <andrey@lebedev.lt>
Subject: Re: [PATCH v2 2/2] ARM: sun7i: dts: Add LVDS panel support on A20
Message-ID: <20200214085351.2whnfyulrmyex2va@gilmour.lan>
References: <20200210195633.GA21832@kedthinkpad>
 <20200212222355.17141-2-andrey.lebedev@gmail.com>
 <20200213094304.hf3glhgmquypxpyf@gilmour.lan>
 <20200213200823.GA28336@kedthinkpad>
 <20200214075218.huxdhmd4qfoakat2@gilmour.lan>
 <20200214084358.GA25266@kedthinkpad>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yrgdw63nadrj63rq"
Content-Disposition: inline
In-Reply-To: <20200214084358.GA25266@kedthinkpad>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yrgdw63nadrj63rq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 14, 2020 at 10:43:58AM +0200, Andrey Lebedev wrote:
> On Fri, Feb 14, 2020 at 08:52:18AM +0100, Maxime Ripard wrote:
> > > > This will create a spurious warning message for TCON1, since we
> > > > adjusted the driver to tell it supports LVDS, but there's no LVDS
> > > > reset line, so we need to make it finer grained.
> > >
> > > Yes, I can attribute two of the messages in my dmesg log [1] to this
> > > ("Missing LVDS properties" and "LVDS output disabled". "sun4i-tcon
> > > 1c0d000.lcd-controller" is indeed tcon1). And yes, I can see how they
> > > can be confusing to someone.
> > >
> > > I'd need some pointers on how to deal with that though (if we want to do
> > > it in this scope).
> >
> > Like I was mentionning, you could introduce a new compatible for each
> > TCON (tcon0 and tcon1) and only set the support_lvds flag for tcon0
>
> Can you give me an idea how that compatible might look like?
>
> 		tcon0: lcd-controller@1c0c000 {
> 			compatible = "allwinner,sun7i-a20-tcon", "allwinner,lvds";
>
> or
>
> 		tcon0: lcd-controller@1c0c000 {
> 			compatible = "allwinner,sun7i-a20-tcon", "allwinner,tcon0";
>
> ? Or something completely different?

Something like

&tcon0 {
    compatible = "allwinner,sun7i-a20-tcon0", "allwinner,sun7i-a20-tcon";
};

&tcon1 {
    compatible = "allwinner,sun7i-a20-tcon1", "allwinner,sun7i-a20-tcon";
};

Maxime

--yrgdw63nadrj63rq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXkZgHwAKCRDj7w1vZxhR
xXU4AQDWT+edBWHd1zu1nz5uZCrI1ipyfBT0Yybkb8G4y9PHvgEA+4EZU7Wf0sVS
n0q5MdBsfmkq5YpaYdEOKCA6zutyWgE=
=vUeL
-----END PGP SIGNATURE-----

--yrgdw63nadrj63rq--
