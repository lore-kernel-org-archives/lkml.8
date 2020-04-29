Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CD1C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18061206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="CDZaj6HR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PL4Mc2Ik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgD2OfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:35:14 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:40931 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726348AbgD2OfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:35:13 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 628275C0411;
        Wed, 29 Apr 2020 10:35:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 29 Apr 2020 10:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=7NflUZehQMCLBE0ifLIpSr1EDnn
        wo5t9jU2qH5OWXro=; b=CDZaj6HRDXELNSxfD+av0zYYHyXWhNBYgr2hxCGIHpt
        dT3fzI/ebRdxjUpT/rZlO8aI9bUpZEpvFiOahw7TC9LDqyqLL67DTSc+npHmMQ2g
        4NZk5cXzCu+jWESM9r+Opz71MVzSl6nNl5HteenD8LSph9D4IYV3szaZJXptCaBc
        dTyWrrDFaklsBpUH2cdwj3Oh0KYfLXpXZFUhwi+gRQAeMBJPuBBcl2/khSD7VfSH
        MT6+Duybnw70QV7NGC0CgR0YfkgtJ3HFOByPuLdq6NCilTfKBy1N0inuckSrm8uz
        qKnpm2bU4dXr3iOo9R5caKDX2KFSlXjASbL/J6g6CKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=7NflUZ
        ehQMCLBE0ifLIpSr1EDnnwo5t9jU2qH5OWXro=; b=PL4Mc2IkiUGQRB5/B8oLzy
        96gRWt25D+zZDgb2x75EApZrGqmVDoI1G5nKAqqwgUZkkw6GLPLAJXGy7ZGFSHDl
        0kcm00NosuGmYV1byCAXALbHPEcJ29SrJ88mzSCE53sHDaKlcMqXFDummiJ7LpqM
        kZ6cBLKkIGhdZJCmy5x9Sc2zfEWfYrHo3uGOf4Oao9Buph6DZMTp9km55lxFAw4C
        0epjRLagKuco3fBK9LuWhkmM7q9V+jXc2SLdWgleS2PxKqT7D9oMVOf0KxKmN7Fy
        JufLRuaYq4yTG8QOp2rAqAl7Rgq7SDRZV9mEpSRtACguE9QzyuhgnOwuTHmhmdJQ
        ==
X-ME-Sender: <xms:n5CpXk2e7JduXD774By5U3JhJuNdc2wzl3cvDlWlAvAF4LjFfnpIOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrieefgdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:n5CpXpxtmh0h0oNuQXuZjYLr9OfXIp95lirN40XuOw6EP0nE_DhmSA>
    <xmx:n5CpXjiGyrmvqwTSgHK9gO_H8s9i07iAtbZjMN2JEDmLBgiBwJfDSQ>
    <xmx:n5CpXowRmvipaFG-69S5rOqmg3mMuAwWNlEwdmquXLPEyIXKJ3krxg>
    <xmx:oJCpXnfDzSC-0y1ghD9wNxK_x5nJwHD3aRMKonqmvWonG-4oknsw8g>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 52C403280065;
        Wed, 29 Apr 2020 10:35:11 -0400 (EDT)
Date:   Wed, 29 Apr 2020 16:35:10 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Priit Laes <plaes@plaes.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/4] clk: sunxi-ng: a10/a20: rewrite init code to a
 platform driver
Message-ID: <20200429143510.ksi27lok2udtmfas@gilmour.lan>
References: <20200417221730.555954-1-plaes@plaes.org>
 <20200417221730.555954-2-plaes@plaes.org>
 <20200420124935.asfbgv7envb2af55@gilmour.lan>
 <20200420203228.GA4734@plaes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zjre4utny3hlv3nb"
Content-Disposition: inline
In-Reply-To: <20200420203228.GA4734@plaes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zjre4utny3hlv3nb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 20, 2020 at 08:32:28PM +0000, Priit Laes wrote:
> On Mon, Apr 20, 2020 at 02:49:35PM +0200, Maxime Ripard wrote:
> > On Sat, Apr 18, 2020 at 01:17:27AM +0300, Priit Laes wrote:
> > > In order to register regmap for sun7i CCU, there needs to be
> > > a device structure already bound to the CCU device node.
> > >=20
> > > Convert the sun4i/sun7i CCU setup to platform driver to use
> > > it later as platform device.
> > >=20
> > > Signed-off-by: Priit Laes <plaes@plaes.org>
> >=20
> > You can't relly do that though. We have timers that need those clocks b=
efore the
> > device model is initialized.
>=20
> Ok, I'm somewhat lost now... are these the affected timers on sun7i follo=
wing:
> - allwinner,sun4i-a10-timer (timer@1c20c00)
> - allwinner,sun7i-a20-hstimer (hstimer@1c60000)

Yep

> Any ideas on what approach I could actually use?

I guess you could keep the CLK_OF_DECLARE registration, and then have a
platform_driver probe and register the regmap?

> Also, similar timer dependency would affect then sun6i-a31 and sun9i-a80
> platforms too...

Indeed.

Maxime

--zjre4utny3hlv3nb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXqmQngAKCRDj7w1vZxhR
xVUBAPsHWuYy2OQT3UljAEr+aCiI8CLm5ELTsyDmgwGv5k61AgEAvf5uXLGuI8YM
fCSMZorTWij/bLfDbEfqowLUaGK8dQ8=
=MvDN
-----END PGP SIGNATURE-----

--zjre4utny3hlv3nb--
