Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136EEC43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2B7D21D20
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Aa5DMMRr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b2QNltio"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgICU5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:57:46 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:45821 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726088AbgICU5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:57:45 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id A9C25EBC;
        Thu,  3 Sep 2020 16:57:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 16:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=7xx2c+sURY2BGLNN4PINqRBclr9
        XFzFHQ6iOqlHyL/E=; b=Aa5DMMRrbjGVB7O78paeHjAcMcuE3VSjemEERDLYO8m
        6um7dmOKlNqWoVzfXLgP6aRQ/nL26kK7PtNYQ4Xy6zoqDcvRYaCEdGwcgmw9dPLr
        VTgWwg7kgbtP3oel2lU1s6uqH5K2xoQ/n2cURuHL6rS3o/XO+ZpMpIE7bN6GZbMn
        MVhN1k+xThBbA5GD1VGI63Eu/ayGD9IKjjDxSLM3KnumRWovxtYkwcieHksCy/Oe
        ws9C8/Z8VTMwOol64EmSUDN0QB3uhPmdiV7QQIwDVyFhkOwBf+FxghY0TqNV02LI
        01gF4juWRM03K7r080Wq3Bv11OzvbRbjSq9hBHBvNpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=7xx2c+
        sURY2BGLNN4PINqRBclr9XFzFHQ6iOqlHyL/E=; b=b2QNltio4/RPP3JKHAkMrp
        wrIS3Qp35QbrpaCiS38VD+1OBiCZX0CSgDuNMfWn1hvvbbRaxRFjx5vNYnbSv6HJ
        xj4/fxOywREePlYj/T9uVOAzM4+1Cwk2M1eQymJnWr36w0jGbeZ699sHKQ8Ngfb7
        +ZEZt1lnDWrtZJgiRGUF7tcdhzoe2naW3Svrt46kriNPZQCqZqprzVtu5MXhwaUy
        sUlbQhFjdLZ/2orkAj7nKKltSmJl9jaw+xbPFOdJtiKFWD2YRwTOgqeUYI20ZC12
        +298NjS4IxOgDDyGYxKjjNE+SwjxkLBnc8Zc5CmMffD8RIm9DH60JH1dskx+MvpQ
        ==
X-ME-Sender: <xms:xVhRXxjCm6r1tCIN1HtYKG7k_qtkIKI9k7rpAusVr8OMvSWLKv4nMA>
    <xme:xVhRX2BQyZqqFejYyfukF74HDH8WqayTVExiXIrDPHOaRVSOOVoVj_xc4n3kRgaL-
    PSk2E8iFB7aMeb5l-0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudeguddgudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeduvdduhfekkeehgffftefflefgffdtheffudffgeevteffheeuiedvvdej
    vdfgveenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:xVhRXxHRzRXNCI0aMtcKIBktnk3ChjEHqZIwJlfJkx3RiAD-y-uzmg>
    <xmx:xVhRX2S2BvHIgUnn9IpWfTupyg_A__TT3BnBsP3wVXa76k6X0KLD5Q>
    <xmx:xVhRX-xELcAVnIE3LwDwq9nyaibYrlrJvIvNeaMjZBRnAgXSAk4dUg>
    <xmx:x1hRXzrqXnGkVGSfM5_915DTstig_aeLw-XMgvLtvSbJAxdmpC8QArpXB-s>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id A19873280063;
        Thu,  3 Sep 2020 16:57:41 -0400 (EDT)
Date:   Thu, 3 Sep 2020 22:57:39 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 01/20] Revert "ASoC: sun4i-i2s: Fix the LRCK polarity"
Message-ID: <20200903205739.43dnsu7du6m44u5c@gilmour.lan>
References: <20200903203034.1057334-1-peron.clem@gmail.com>
 <20200903203034.1057334-2-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p6v5j2ugxblige7u"
Content-Disposition: inline
In-Reply-To: <20200903203034.1057334-2-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p6v5j2ugxblige7u
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Sep 03, 2020 at 10:30:15PM +0200, Cl=E9ment P=E9ron wrote:
> This reverts commit dd657eae8164f7e4bafe8b875031a7c6c50646a9.
>=20
> There was a misinterpretation of the analysis using a scope.
> After rechecking this using a logical analyzer the LRCK polarity is
> fine.

Yes, it's fine indeed, so there's no need to change anything?

Maxime

--p6v5j2ugxblige7u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX1FYwwAKCRDj7w1vZxhR
xbBKAQCBV+rE9UZoCrdpdAa3jQ9KOPalRBYJ5WnRoj1MUDwpXwEAi95nCcuHlPwE
O/UMdDgPQbAc4AnYf7asF/A+X7ZbSg4=
=kbla
-----END PGP SIGNATURE-----

--p6v5j2ugxblige7u--
