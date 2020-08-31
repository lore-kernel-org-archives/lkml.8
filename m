Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF3FC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 07:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6294F20738
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 07:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="guEhH34J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jRv9hY5R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgHaHks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 03:40:48 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:41097 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725794AbgHaHkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 03:40:45 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 6E4FA5C01AB;
        Mon, 31 Aug 2020 03:40:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 31 Aug 2020 03:40:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=IhGb3DeuuYHu5Na6nUBIcRvk2Xi
        EHRuVQRQsWSf8LSs=; b=guEhH34JK1YWBukKPEDBve4BhY6Cdjs7GSrwDd7bf53
        TWDVRj5n5NE2FtHwQMdbfDp1r5BRNQRzvlyikAUkp8CNaLdJ5u+kKTMhSe7Sjihq
        /+KxaboI9k7Pcn+5w/I/Ud6R972q5/i5PmW/U1SNwaCDfY/pISuHfiuj5+3TY22J
        6Nb4KczXF/Ny8awPSrjw1R+uDm265UJg0tQd26Za+jmSF8YWqFSYRfBTkOvXSYHt
        DGfJFicTgN6uUUDLw3mHnoV4HzWnsHZQ40LztVQ+XA2c1E6puD13DpOOE68jsndq
        oZYG8JUSQoZh/hhzLla9I+ThoFYBdiS2cdhW8hL7TgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=IhGb3D
        euuYHu5Na6nUBIcRvk2XiEHRuVQRQsWSf8LSs=; b=jRv9hY5RDrNFs80Tmo1+iE
        WDerJU2Jh6nREyJ+KDG1/9Z69bF7bVbhAhufOJWwL70eEbOj6DFGLFShvV3QrN/p
        Dj+EOCsDfEqR+fP1ntZVaBfx+pAwGTvStapVYQklmZgTSN1JS0jP1eKmaDvkZ74Y
        5fIfU41Rr482FYYSKDS9lIBWehe7By6txyzOVFjF8r7M4rHXSCUiYBFvgvhoGkKg
        cm7iCttD5rCoiX/OKK/E7rE9le/9XfCS0AagPD/TFosKtojfAW7U16nGaKb5MigU
        jkwdBBUopf9bYRCMCuIIIEZWesup6igBJ7A1Xh6IktTkZKanEKL40iugXc2m5U8Q
        ==
X-ME-Sender: <xms:e6lMX8W1PHlzxpg9rGyfEXTjXa7txhDxCgcMu6n2ZYlvVv8d8C4rBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefgedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
    heegudenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:e6lMXwl_utngBevTFE3wvwg0_Op8ZJrHSESmLzR_ksxP3sYTIzpfsA>
    <xmx:e6lMXwaFNiRx3euzTEhn_va6rSlq-DLr22A35W_Zk2LGMAiuC-tlFg>
    <xmx:e6lMX7VzJYEtzIVJgT5x5ohHv5wAv3Lq1XTf2_XqH6bcX2SNvfEumA>
    <xmx:fKlMX3DF1nu_i8zvhVVblhjXetqwaMIwAJl13POfFAn5paDxcGi6iw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 118403280064;
        Mon, 31 Aug 2020 03:40:42 -0400 (EDT)
Date:   Mon, 31 Aug 2020 09:40:41 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: gpu: arm,mali-utgard: Correct Maxime's email
Message-ID: <20200831074041.wn25id7u3kci7l4i@gilmour.lan>
References: <20200830085122.20826-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jncvpyk7tscua4j6"
Content-Disposition: inline
In-Reply-To: <20200830085122.20826-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jncvpyk7tscua4j6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2020 at 10:51:22AM +0200, Krzysztof Kozlowski wrote:
> Update the address of Maxime Ripard as one in @free-electrons.com does
> not work.
>=20
> Cc: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--jncvpyk7tscua4j6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX0ypdAAKCRDj7w1vZxhR
xdV4AQCUFFfso3akR5K79GMeFdFb1myFiHtYWRErzQjYWMa9dAD9G8K5A5llzHoH
DBAwcresf2RMY5DtX2ao+WhFPjCJPwI=
=zrs4
-----END PGP SIGNATURE-----

--jncvpyk7tscua4j6--
