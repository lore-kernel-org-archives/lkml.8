Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EDBC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 309722075F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="BAO/udpJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PTp5v662"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgHYNjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:39:39 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:44865 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726449AbgHYNgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 09:36:13 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id EB839CE3;
        Tue, 25 Aug 2020 09:36:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 25 Aug 2020 09:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=W20LfYmY/jq/r96+vAKE5otdRCg
        5oUAy53ig3vgXUYk=; b=BAO/udpJGYYKlpoiXR7z1KvcH3kzYZOu/9U37p4piqb
        EIpqZkorX/aNnW81KgeOxjy+FRP9GTmMSqOadDxJjonzmfTtfXym9xrmCqNBxnET
        6Bd3jEnZk8PxHP8xhIPYNVbambJr9eKkMAT5D6eNVDocFtzvw//yR2lxPM7SRB4n
        rb7KaK85PcLJZ7ghHIjwa0eoBlUkPDTr49DSCetSmY8bVb4eLj4yhFVQelJidyZm
        EdmiX2UOjYVwIR3bEt34cMCWKzxURXZXYID3CWUqtRY8UY2Kvi7z2GfVpBdVowzw
        bo7eesrZxwoinvcFUR3VePg358E/CiOE4GJvY49HePQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=W20LfY
        mY/jq/r96+vAKE5otdRCg5oUAy53ig3vgXUYk=; b=PTp5v662xCZueI+Y2wq88n
        pRmFfLNMVNpNR/Ss+hPDTCIzpW5cLCUuvDzjzg2M5J9TPBHVfS6msPuo4CGHqEXW
        0uZqFgoRsvTvXGd/Ft76p6GvYTdSG/xqTTt4KOQa7YoGqxGsxdF8v+YSczqGPbTx
        FRdZzZvN0Nt8hGMjEF9LAVdezh0D2l/98dRVc783HhtVdSEkqqDydMB8kO3WSF5i
        9oZnkAhKINFEBDxkLYHDwnHfm6cGHrCBYyQRwyTx2E19TUBVu9VpEF5YI6njB9r4
        oTkvXtwDFMPpJpM8mIsPyvYk7khl3NIh6hDTaYdnv/kmFUACvObxRVER5KeZJbnw
        ==
X-ME-Sender: <xms:yxNFXz9DrfW4lixUrqRy8odedgf4IE9r4IwjZrV1JBWNnqn0WJuOsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvtddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudekne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:yxNFX_tXOi1dyJyjqVdEXtuKiK-ODI2MeedO0JKA4Tg-pNiYeKlUMw>
    <xmx:yxNFXxBQp2nCsufYgvojUp0mvpovhdl52cccGmnrRJpHPdZ2bMkFKQ>
    <xmx:yxNFX_fizkFnmVL6msLX6qWnz69SxXXpSsscv-gvT_LcIvZa8pgk7A>
    <xmx:yxNFX32SoVjkDjsg50E3MzoBeb9QNjEjenrQR7aKHec3SLoGMJVryA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 350193280068;
        Tue, 25 Aug 2020 09:36:11 -0400 (EDT)
Date:   Tue, 25 Aug 2020 10:50:20 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     robh+dt@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tiny.windzz@gmail.com, huangshuosheng@allwinnertech.com,
        liyong@allwinnertech.com
Subject: Re: [PATCH v5 14/16] arm64: allwinner: A100: add the basical
 Allwinner A100 DTSI file
Message-ID: <20200825085020.h5xbvcwhxios2pks@gilmour.lan>
References: <cover.1595572867.git.frank@allwinnertech.com>
 <815a458de74b79eb649972de786e647be3846424.1595572867.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pu6nfz4n2q2sbo4w"
Content-Disposition: inline
In-Reply-To: <815a458de74b79eb649972de786e647be3846424.1595572867.git.frank@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pu6nfz4n2q2sbo4w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2020 at 03:18:24PM +0800, Frank Lee wrote:
> From: Yangtao Li <frank@allwinnertech.com>
>=20
> Allwinner A100 is a new SoC with Cortex-A53 cores, this commit adds
> the basical DTSI file of it, including the clock, i2c, pins, sid, ths,
> nmi, and UART support.
>=20
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>

Applied, thanks!
Maxime

--pu6nfz4n2q2sbo4w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX0TQywAKCRDj7w1vZxhR
xQuSAPwPAmxC1bfc73TvEjyu1guct31XNdPAC3s15JE1h8RtZwEAlBbbaKt7V3Xl
3WoVFI6ZQWIdjhXX5FlJvs325lS4ZwU=
=/g2y
-----END PGP SIGNATURE-----

--pu6nfz4n2q2sbo4w--
