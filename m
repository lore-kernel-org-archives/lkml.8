Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4AAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94E5620759
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="JKF2RLxI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AtwYEx3u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731005AbgF3Har (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:30:47 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:34217 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726943AbgF3Har (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:30:47 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 04B83882;
        Tue, 30 Jun 2020 03:30:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 30 Jun 2020 03:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=QLnlN1GIamFpAnpFCQURrJYtNy5
        7NrXSIOmRV8y9wUQ=; b=JKF2RLxIBXte86OafrU1CczjM7wWmITOnY9j6EQiyh5
        oSql38PtjeMbOMzdI1J/cHnSu3VGniq0Ynf6Lqmr6eNRMSNoaXktJc2/lP420gN7
        LjJzidoSBSWxFImJiVr9SH+aZdrGLCLEgWGIjg4pT3OrEIAcTtikSnSBYd3iwL1/
        YI/95CcUACkFObnta6KT5HaJ+MmZmtfkxtBJs8JPYMVYLGK0nj5MqRlAKSpi66y0
        sPWWzQ4l+gD71UtXH/XE5qSjwWs4HSUD2d6wAotYI8nqgyJPpmA7hFCoX8Ww6MID
        QK2XuuElENbTiLGrB3Fqxn8n03l1gFPgU+UTFv7/h8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=QLnlN1
        GIamFpAnpFCQURrJYtNy57NrXSIOmRV8y9wUQ=; b=AtwYEx3ucEB9E+0uMzHvA5
        hBUFzf4DxPQBa1/IZXAexFcW08u3w/JwlH4C/cYllTW/7usQxQL9knN/rsHftvEh
        WwTvsfqsc0nFRSuaNERTH2PSaKKPINuaokfwZZciA31pGLvyd1Gpfp7SFEm7Sza+
        khjdoi4F+JLhEjjSMsCavQyNVT3JDrKN+3QUxT1jB+Vk0infVVRxW1UER8uoWKOo
        NPfG8uwLTQjQ1AdiCKxIBeHkUKFIX7ixvhV5Cr6WZixMfG/pYzgCw5+a7fBoO/5P
        xFgT+rBcH+gffQUBZErPAOTRQO1MrAMzfLkQjtOpmf54yRI8nKG3eGbb//yFgRnA
        ==
X-ME-Sender: <xms:I-r6XiusM8TAxYDB6oPtHE1yNYVFSZtJWD7unqnIMj7WgzaitngYsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrvddttddguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
    heegudenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:I-r6XncMSUAYpIG0ckwaMJDG-XHcRQS9zM0laKvzuuD-ngk85iLC2A>
    <xmx:I-r6XtyQYadn044eZFyYfk29n0i-2Pg2jyCOtxhCoJR9oy_UINb3MQ>
    <xmx:I-r6XtPBY4ReJfJO41cPLwmzktTJWawBjvE8dTP8EaVJqmoI_DgTrQ>
    <xmx:I-r6XkLB9toL2myt6Bvvi3mG-Ddw8RqCa9XurJw7vREaW0XVLwWWug>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B902F3280059;
        Tue, 30 Jun 2020 03:30:42 -0400 (EDT)
Date:   Tue, 30 Jun 2020 09:30:40 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     wens@csie.org, kishon@ti.com, vkoul@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] phy: allwinner: phy-sun6i-mipi-dphy: Constify structs
Message-ID: <20200630073040.t7mrd4jwldfgqov5@gilmour.lan>
References: <20200629195727.9717-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wlgtdw6dwhcbgcba"
Content-Disposition: inline
In-Reply-To: <20200629195727.9717-1-rikard.falkeborn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wlgtdw6dwhcbgcba
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2020 at 09:57:27PM +0200, Rikard Falkeborn wrote:
> sun6i_dphy_ops and sun6i_dphy_regmap_config are not modified so make them
> const structs to allow the compiler to put them in read-only memory.
>=20
> Before:
>    text    data     bss     dec     hex filename
>    4407    1944      64    6415    190f drivers/phy/allwinner/phy-sun6i-m=
ipi-dphy.o
>=20
> After:
>    text    data     bss     dec     hex filename
>    4835    1496      64    6395    18fb drivers/phy/allwinner/phy-sun6i-m=
ipi-dphy.o
>=20
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--wlgtdw6dwhcbgcba
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXvrqIAAKCRDj7w1vZxhR
xfZ8AP9tdMkrg9oG7LM4vUF/Iy0hPfSCqDBI9oYxGR7atDeCjgEAtv6SPo9jII4a
j55hopR07Yh3O2qa9eqIlPbKd5rMvwA=
=QrJC
-----END PGP SIGNATURE-----

--wlgtdw6dwhcbgcba--
