Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9E0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66CD220738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="b4yjaI1M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NUvLVCP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgHYNrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:47:04 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:38607 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726336AbgHYNf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 09:35:59 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 0C030C36;
        Tue, 25 Aug 2020 09:35:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 25 Aug 2020 09:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=dsnBUaGmbew6qpuWLdGTG7ThydO
        yB1RP+Wp0M/j7v7E=; b=b4yjaI1MRfmZ0bBeJoZe2fCEmiHigvIOzl5F1HrPSXg
        OqENecprlSTSuSB0qcoBD//jusvPDa3VoRP141SU1Pt8zc9eZxFTZPQuyoNeELkX
        sb7pfjrd7p5DhH5+OgAn60HYipH6AR2X5tBrFadV+yA4nXTHnSGJHOtjA6Us7C1V
        kMW20vhBWjow9p/FlfErO7lvkMXhETcBnFE4ZCEYNAPNOQRaYnFubOcTJwVNgSM0
        ygiV5LwQihV0kZZTJUoP6spoCxbFvpEJ1MQFuGnNYa3Xr0ZwYTyGaHtbTzeYzEnC
        WRGrV7onEi3lezaq8D53K6Ooi4JQaWmU3o3hXCPke7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=dsnBUa
        Gmbew6qpuWLdGTG7ThydOyB1RP+Wp0M/j7v7E=; b=NUvLVCP7WzMij9GfKFwxvQ
        Cf5EtveKlSF3FlFXZkLuzYsvY0m8cG3U1TzCo9w4JUSmap97oFl1SY9rnkBJMmyz
        5GMkY2IYZv1zoox5G2jTklVPlH8EPtC9Ed/HKunlb/qE2ta/uF5Lpf7sXLFY0w9O
        IOAN2WgRst/Nj/WJ1s6BfFEoBwcg0wtxajhEoywd29ELiB2csIOKLq6nmb/QSWj9
        vNhAuuI0cpldWMs1qW81UuucUMywGtXQ6/vSSDveFD4GJ+3kPCUknQuA33MxK1E3
        euiEl8rduocEkvK8XIQPpO31hWRgzuSBMGReeL5+ZW4OXnC4CLmuK0PXNVYpDF1A
        ==
X-ME-Sender: <xms:vhNFXwsKJQ62OcN-8GRCxZ0lUI5JzuXCg3uEyuursBorS2o1tOcLog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvtddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepleenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:vhNFX9dE5WCqjW0lCwiDXArUTrWqHg43vpxdAKStXFFxHpcZOaBORw>
    <xmx:vhNFX7zRCx2X7aWEUI10TbjsNgSmH_BWIbvqeWtNOB904IfHSGOtcQ>
    <xmx:vhNFXzOhqqLP2Z2_MiaxXB1Vq6iXhXIh-7XruDRLs9bvlpn1jBwo2w>
    <xmx:vhNFX0ZUzgKrNAEmd0P8_pT0R6Y_pCImCx6LENor12qo4LxmlnSg5w>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 491D430600A6;
        Tue, 25 Aug 2020 09:35:58 -0400 (EDT)
Date:   Tue, 25 Aug 2020 10:42:43 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Qiang Yu <yuq825@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        lima@lists.freedesktop.org
Subject: Re: [PATCH] arm64: dts: allwinner: h5: remove Mali GPU PMU module
Message-ID: <20200825084243.otw47ngedv3iq724@gilmour.lan>
References: <20200822062755.534761-1-yuq825@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5a4easdb4p3fnau3"
Content-Disposition: inline
In-Reply-To: <20200822062755.534761-1-yuq825@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5a4easdb4p3fnau3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 22, 2020 at 02:27:55PM +0800, Qiang Yu wrote:
> H5's Mali GPU PMU is not present or working corretly although
> H5 datasheet record its interrupt vector.
>=20
> Adding this module will miss lead lima driver try to shutdown
> it and get waiting timeout. This problem is not exposed before
> lima runtime PM supoprt is added.
>=20
> Fixes: bb39ed07e55b ("arm64: dts: allwinner: h5: Add device node for Mali=
-450 GPU")
> Signed-off-by: Qiang Yu <yuq825@gmail.com>

Fixed the typo (s/supoprt/support) and applied, thanks!
Maxime

--5a4easdb4p3fnau3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX0TPAwAKCRDj7w1vZxhR
xTp2AQCBwnn+UKN+I4h5RnI4d2aqcybPn8PLNCB/E1LwcXN6CAD+PlGE3ocXoYoe
zg93D3O/mlKrnME0WVbb+4GIloWULQ8=
=1pZ6
-----END PGP SIGNATURE-----

--5a4easdb4p3fnau3--
