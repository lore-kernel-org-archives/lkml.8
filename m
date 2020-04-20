Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6533C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0DE020B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="vvkimXxX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kBCxFHsq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgDTN1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:27:54 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:41617 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725897AbgDTN1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:27:53 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 4FCB253A;
        Mon, 20 Apr 2020 09:27:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 20 Apr 2020 09:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=C1acu8SOYXvfCrT29OikkU8tqdr
        tQ88j/dfAu0WvkG0=; b=vvkimXxXCrJAXaUZFh9Qb2mhAU8anR4eWyvNHVUjkKv
        3ffCHDg1hncrLGuYgwm6/cX6y+RLcBQL8Prwoqgj/UWGvMci1Nb2JrI6vy1Bs6lx
        jouwojDVTdWMS+CPS6NlcJeJI/TnoxPyXecl76tlAf4B5e6k+WtyqJe2vF0gkruj
        7207wqQ02t4nPmOt90NkJ6kTI/vn9D1SjprMi7T/rgjTpRMUomj2bOaFbz0lyJdz
        IJ69d4CPNjF+J/Gkz5R6GSYJvfjqELm1xxxC/Kgsu/bVXFKAFrLnOIorA2PE/d80
        pxCTb0/KtBY5WGp4nrpej8qp/dtGxr2nWck8F6Guo7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=C1acu8
        SOYXvfCrT29OikkU8tqdrtQ88j/dfAu0WvkG0=; b=kBCxFHsqpKac7qMEIGr8Fm
        y2f+bDdBSXx9PTzgT9s8OZDuCZ853MVb9qP2HKpSb3lkDuWg1KyJJrCpjdfbfKEt
        xL5GNn0OciaSIEuoXwTAt2D/qWDnSzZ/Lo59AlXZBufnucpK4R0gy1V3aFoHjyE1
        A7ERK5F9veSaLKtFlmqnm5gsur9p/2SVC6TX/j2+Fntui/d9cFcVIrUF6cr6oIkN
        CGr1j3nBjhvn7rq8IEUCx2kuOWAwhHKB0S0BbC6KHcn7NfIR3VvIQ63mhKi+iD1a
        jdolVonx84aakDsW7s43GQPmF2XeY+GuOiw/+z3/wvdFpwd/C10TptLyVrZaglHg
        ==
X-ME-Sender: <xms:UqOdXhtx8HTOSqU3DX4z4eehe4Fw8qON_pPgj_3zXkeM2pOVt9BqRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrgeefgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:UqOdXokU1CLUum6CNOsVRCBwnMltaVCJ6DAU3R_-SX26_g3n4AgjgQ>
    <xmx:UqOdXvUrA9MtKTCZJ0LlfvgJR9BR07kEVKUb6G-5uJ0yctdLLeZDOA>
    <xmx:UqOdXsvrVzdoOLrptwf2Vd-YLiAqIRQhdzR4IG56CPqux0EVW44PgQ>
    <xmx:V6OdXsUhYIqsRhlW-qjcISecj48hamvzoL52E7GJTLe7P8eetin5HQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 778AE3065C16;
        Mon, 20 Apr 2020 09:27:46 -0400 (EDT)
Date:   Mon, 20 Apr 2020 15:27:45 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: allwinner: sun50i-a64: Add missing
 address/size-cells
Message-ID: <20200420132745.7sa4zf2c2xp7ffrc@gilmour.lan>
References: <20200420103113.577969-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="knpeiqpl5v5uzrh4"
Content-Disposition: inline
In-Reply-To: <20200420103113.577969-1-megous@megous.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--knpeiqpl5v5uzrh4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2020 at 12:31:13PM +0200, Ondrej Jirman wrote:
> The binding specifies #address-cells and #size-cells should be present.
> Without them present, dtc issues a warning because default for
> #address-cells seems to be <2>:
>=20
> arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi:1108.4-52:
>   Warning (dma_ranges_format):
>     /soc/dram-controller@1c62000:dma-ranges:
>     "dma-ranges" property has invalid length (12 bytes)
>     (parent #address-cells =3D=3D 1, child #address-cells =3D=3D 2,
>     #size-cells =3D=3D 1)
>=20
> mbus #address-cells should be 1.
>=20
> Signed-off-by: Ondrej Jirman <megous@megous.com>

Applied, thanks

Maxime

--knpeiqpl5v5uzrh4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXp2jUQAKCRDj7w1vZxhR
xTOZAQDH2dxXT4rG7cY/ZynLPx95CqmiIV9TpnSMdmyts6jejgD+L7nEB36P07Yi
F2c44pcXcdYfUaXsokS1a2/3IdEFHgM=
=PFLR
-----END PGP SIGNATURE-----

--knpeiqpl5v5uzrh4--
