Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3ADC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 11:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29BEF2063A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 11:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Xop4FSff";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MgAol9a9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgEDLto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 07:49:44 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:42547 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726756AbgEDLto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 07:49:44 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 3981A4CF;
        Mon,  4 May 2020 07:49:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 04 May 2020 07:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=aOCT64fzRTmG4hyK09D049RH30r
        n+qDts7It4/KOpcw=; b=Xop4FSffBO5zPQWboSBJoIVL99fcew62F8kVEboByJb
        ih8r1bYUKw7YiD64gZsWfkkMNsDGXTLIGvLn95lzicdDrC3RO4kBy83Ndt8oIeQI
        HM10Jzb+G2a+8IbAE5M9ASkcLW4w1x6YdJXZy0qSiTAE8hhXv4U5yKA378qLX1Mg
        duDR2jphm8e6a/VkviGze5E54NibDT6xrrHCucD8ocSDlsgYAANgymJB++H8NAY0
        11qBzivJG74Hv8m2dfSxNEH6oum5Tgs4eDPW7tozrNJls3HLz/4JeuAV5Cl6aMyD
        r22Ctofw7ZUQb3uDEXLnb4/QIyRnWOdXIFVy+IgerrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=aOCT64
        fzRTmG4hyK09D049RH30rn+qDts7It4/KOpcw=; b=MgAol9a9iOT6/SQVVl2s6D
        YknxToOieqpigwcA5LkzShBpmVUe1CN3Ui5kYYkURW1XOagweviNczltlJVwqH4X
        7agWVf5rRY907nDHYoplL1QrA25L08e0ZliRdCuhYHFva4ZmgukLxrSqnDofl3iu
        9+j6g5LxCiljuil2apQqr2Hx3e/1kcZm4bSpmYymXTMvhxK7mGorwt0tBELAkKEk
        Gnvq3IaIHMbuL2r3YdZsSBHZanSqceiwPWdKW8asFzHd+SmtX8zjI8CRt+F9xy+/
        wQVkWiK7D1L7jD1edc6GfWW5JnIGnSe3raDjoDO83ORBONHD+oRzejBCMURf5E3Q
        ==
X-ME-Sender: <xms:UAGwXnVO2uNlwtwakKb3U_PiozgjurcVPSwxcYqwBVIp35VxxGX52Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrjeeggdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:UAGwXnPWp-rZzUergCxnLRMkziO5ajExGkJwWx8c4_bibVGbJNqmpQ>
    <xmx:UAGwXqyvgHDjoEGtvJYcaNnZ9YPBY195Ex7i60ZS45PdeCWV9IPOMQ>
    <xmx:UAGwXs1BVi9I8EH6c_8sMMaRlweb8W7n3LyCijpN74pePj5amw_Gpg>
    <xmx:VQGwXnDK4M4__YVgPiyuuxi__3yCtYPF-bsAYJo9j9Qmb2UQXSqXWDequDo>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 786A13280065;
        Mon,  4 May 2020 07:49:36 -0400 (EDT)
Date:   Mon, 4 May 2020 13:49:34 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Samuel Holland <samuel@sholland.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sun6i: dsi: fix gcc-4.8
Message-ID: <20200504114934.4at4qymeinzhntia@gilmour.lan>
References: <20200428215105.3928459-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="36sp7fcv334ahfch"
Content-Disposition: inline
In-Reply-To: <20200428215105.3928459-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--36sp7fcv334ahfch
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2020 at 11:50:51PM +0200, Arnd Bergmann wrote:
> Older compilers warn about initializers with incorrect curly
> braces:
>=20
> drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c: In function 'sun6i_dsi_encoder_en=
able':
> drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c:720:8: error: missing braces aroun=
d initializer [-Werror=3Dmissing-braces]
>   union phy_configure_opts opts =3D { 0 };
>         ^
> drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c:720:8: error: (near initialization=
 for 'opts.mipi_dphy') [-Werror=3Dmissing-braces]
>=20
> Use the GNU empty initializer extension to avoid this.
>=20
> Fixes: bb3b6fcb6849 ("sun6i: dsi: Convert to generic phy handling")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks!
Maxime

--36sp7fcv334ahfch
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXrABTgAKCRDj7w1vZxhR
xZceAQDWqA1wYrHG+lfIkDwv2IQjgIb1xdlrOwmPCXTqeewZ4QD/RSluDlNXx9Qq
blYGsMP6amEH5VFu2RqHB3ZCV33Kbw0=
=M2L1
-----END PGP SIGNATURE-----

--36sp7fcv334ahfch--
