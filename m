Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD3EC55186
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 09:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A57C20776
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 09:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="XR0NLN0T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3e+wNdrI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgDWJtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 05:49:43 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:53745 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726145AbgDWJtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 05:49:43 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 35EA7706;
        Thu, 23 Apr 2020 05:49:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 23 Apr 2020 05:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=G2jAMqcEuXOVO6A3EqfT0UwmQC6
        hpWGRqcPB7zT18FI=; b=XR0NLN0Tc/bjTcDKyiBF9Bi1VseQHjJpKT+6m1IgsVu
        MQZAgGlbV9FvUCcLjsHp5d35vLvrOnamQUu/3Eb36CdfTZQLc36FJJ4pPVEXtL6t
        6Zv/vbt2Naz/+iEcj8kkzvMhWHJOfiTWgP2+IcC07xWjegEikYqIbgOpbaj1LIEI
        JmQgXU5GegRyAMZ548/Da56pZ2lWNV47Th9VxZ0Vkou83BSj6zwGkw3j7Ya3dTRY
        YOzA1dtVGsMUxbHnpiUnt4hwUQfwY1PsMUpImNnjcsqENhN+l0qp/AQ9/LY/J1VD
        zRCBTYQDqzm9A9tOYoaft+5c6fp72A6IBbY7XCpDJJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=G2jAMq
        cEuXOVO6A3EqfT0UwmQC6hpWGRqcPB7zT18FI=; b=3e+wNdrI89BclXcsWi0yhS
        4TIADRP45sSloOBv3wF5tHrunYVaYBHIMt3JeeITEOiA7KYoOXaI3SJ9WtJYqWWV
        St9BLQppu755QRVLqFpOOnVURycMLNVaxv4SOMBa2ZUECvdikGgivHLfRxfYEbTD
        /Emb4r1VR22MqWnWi3ygnXBXZAkDxVAxKQn9f4WkL5OgF2VcaYkr4yc480Tti+yd
        W723bB/diLFTD0z/xN0lFGZSX4c7yPeobHbQTNC5ho56m9g4zFAXu3XOxCUTTyzz
        9IoijklLHunQeUj5MAsRi9syt28tyMtEVvusPChYWlmbc7YUyfAsjx8+maDzPuyA
        ==
X-ME-Sender: <xms:tWShXt5yZfSr4sDijqtNTkelGzbyauEJucaos-_5CicLmz6mJmibeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrgeelgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:tWShXnNJuF5ko7bAbCjsHgVJjljSW5m_uebp-IJIBzhRsfO8krEUeA>
    <xmx:tWShXnOhd2XX_xUwqmdKD6eLotpNM9O6dSxfbVptGgx5p78WpPv9PQ>
    <xmx:tWShXn-vlBfu8TwkRxKqOHllAvK7ufBlG0DQw9gJda16gd8ycoAhIA>
    <xmx:tWShXsbUEdZoZlKd9rJm9PTD_r1bp2igdvkr7naqHFlyvJ2Gw-Ywrw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 13F053280064;
        Thu, 23 Apr 2020 05:49:40 -0400 (EDT)
Date:   Thu, 23 Apr 2020 11:49:39 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Disable SPDIF by default
Message-ID: <20200423094939.os74dohwkdoig4eq@gilmour.lan>
References: <20200422041502.7497-1-samuel@sholland.org>
 <20200422151616.httmhmo2tbd4m4eu@gilmour.lan>
 <b554ea70-16da-1637-d349-db51dddcf95b@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qhzqxzvlhlzjufin"
Content-Disposition: inline
In-Reply-To: <b554ea70-16da-1637-d349-db51dddcf95b@sholland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qhzqxzvlhlzjufin
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2020 at 06:50:54PM -0500, Samuel Holland wrote:
> Maxime,
>=20
> On 4/22/20 10:16 AM, Maxime Ripard wrote:
> > On Tue, Apr 21, 2020 at 11:15:02PM -0500, Samuel Holland wrote:
> >> As of v5.7-rc2, Linux now prints the following message at boot:
> >>
> >>   [   33.848525] platform sound_spdif: deferred probe pending
> >>
> >> This is because &sound_spdif is waiting on its DAI link component
> >> &spdif to probe, but &spdif is disabled in the DTS. Disable the
> >> audio card as well to match.
> >>
> >> Signed-off-by: Samuel Holland <samuel@sholland.org>
> >=20
> > The patch looks good, but don't we have some boards with SPDIF enabled =
that
> > should be modified accordingly?
>=20
> I don't see any in-tree. The only A64 DTS that references &spdif at all is
> sun50i-a64-pine64.dts, which explicitly disables it:
>=20
> 	/* On Euler connector */
> 	&spdif {
>   		status =3D "disabled";
> 	};
>=20
> I'm leaning toward agreeing with Clement that the sound_spdif node (and a=
lso
> spdif_out) should be removed altogether from the A64 DTSI.

Yeah, I agree, it's pretty much what we've been doing in other SoCs. Especi=
ally
if we don't have any DT in-tree using it, we don't really have any incentiv=
e to
make it common.

Maxime

--qhzqxzvlhlzjufin
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXqFkswAKCRDj7w1vZxhR
xcXYAP0YCJVCZ13NxvfRPVD96Em/vCf6tbVNq2xSDRxJvc/HXgEArMdDscxqBjIi
+IipThGZM45abULaOWDYaEdv6VvqOwQ=
=5Z/9
-----END PGP SIGNATURE-----

--qhzqxzvlhlzjufin--
