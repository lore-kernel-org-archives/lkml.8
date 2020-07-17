Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B4AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DCC22070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="eVVV2VIF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iWUNXNAJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgGQQIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 12:08:46 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60669 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726322AbgGQQIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:08:45 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id A59175C00D1;
        Fri, 17 Jul 2020 12:08:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 17 Jul 2020 12:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=WkgphudWpjJfcSveDDK8GjQybIv
        8aCJebnDnyFDy4cI=; b=eVVV2VIFkKNJWGQcFA9sUsTtyaE+8YFxl579E+Rp1VA
        IY+F4nlPDpzhG+T89FLqy6EF8U5U+gmgvIozydnkYfDviUTSnSRPDDdhaEXKrro1
        3ECpGBLk5vuUtmD+U5hmkA8fEOsLc0AHBUnYcPbKvauJG2Y3UEFx9Q7BBVKSRBWt
        sjlMvto4UZjkbBJYEoZXesIyuCSl2/Ia66tH6VfVL2r2Aswjtw9k0/HQXqoDO8z1
        iXpiJ87FmB6xbqJDT4qlv5CFyVwaENG3uAYRjCpwQJ/9T8zYBw90IfqWwkdl6DRa
        6bXYfW3TTTMGoGelWAShepOw0Rqiz4bTtAx7jgqq2MA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Wkgphu
        dWpjJfcSveDDK8GjQybIv8aCJebnDnyFDy4cI=; b=iWUNXNAJk3kpPvUrg6L85h
        mDVDkYIMu9i9G34UUOpWiDdv/z9lGIf33H98b/MIdqxk6ebO/+PkigkKtrFnemOz
        G1MjBvL3cSvGRjxKb+w6isjqtXWIHvHc9uDwvQ+bFar7ZPqesbPDdUDJuOEv+Fjl
        Ew4XzdG+XA8KV5E7ougsY60fjIb2RJQbnXyZmYiGgnsUwo9b+wxqK4l7+DD+L1Hh
        7MZQLpcVjRMC6qp/30NnzhlmAA914wZTwTk6YVE8TvurXWHG5xQ33g81sy6omuEc
        4JUd6g7A4uxHcmVDTkp3RQDQAa1Au98JJqN8NR3W/1/FLFsMNG3IKUdHxWqRf0gQ
        ==
X-ME-Sender: <xms:Cc0RX56s40Ak4VJxPtLRsImjVsJ7gb7k3Mk069WKdb-PsIdbDOcghw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrfeejgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedunecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:Cc0RX26PpJvvPxMsi5Bsm9OwDQsMmvdUR6_P2vN9Aj_GSO4bci_6xw>
    <xmx:Cc0RXwc-trJ-Hin4Vclnqd_cNTcslKMy1zWNVPwkLKir6u5NNm2Lag>
    <xmx:Cc0RXyIfqlhzAxHUUCKM2rGLb0E7QmhctWb2wGJ9r2thRTO0FqxGOg>
    <xmx:DM0RX91ffeWmk3MQcM3UPBwnISoO8GoEWjGMtoemfUzuu3ZUMr91IA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 912383060067;
        Fri, 17 Jul 2020 12:08:41 -0400 (EDT)
Date:   Fri, 17 Jul 2020 18:08:40 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     robh+dt@kernel.org, wens@csie.org, tiny.windzz@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ARM: dts: allwinner: convert gpio.h to sunxi-gpio.h
Message-ID: <20200717160840.goez5i5nov7twxfx@gilmour.lan>
References: <20200715115507.2690-1-frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a4yvypzj3h4qq5ru"
Content-Disposition: inline
In-Reply-To: <20200715115507.2690-1-frank@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a4yvypzj3h4qq5ru
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2020 at 07:55:07PM +0800, Frank Lee wrote:
> From: Yangtao Li <frank@allwinnertech.com>
>=20
> Use names instead of numbers to describe GPIO. We clean arm64 first.
> Since H5 uses the DTS file in arm directory, we need to modify the
> header file in advance.
>=20
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
>=20
> ---
>  arch/arm/boot/dts/sunxi-h3-h5-emlid-neutis.dtsi  | 2 +-
>  arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/sunxi-h3-h5-emlid-neutis.dtsi b/arch/arm/b=
oot/dts/sunxi-h3-h5-emlid-neutis.dtsi
> index fc67e30fe212..93f9653b43f4 100644
> --- a/arch/arm/boot/dts/sunxi-h3-h5-emlid-neutis.dtsi
> +++ b/arch/arm/boot/dts/sunxi-h3-h5-emlid-neutis.dtsi
> @@ -7,7 +7,7 @@
> =20
>  #include "sunxi-common-regulators.dtsi"
> =20
> -#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/gpio/sunxi-gpio.h>

I think we should have both. The gpio.h header is supposed to be for the
generic defines, while ours would be for the one specific to the
allwinner SoCs (just like it's being done for the GIC vs generic
interrupt flags)

Maxime

--a4yvypzj3h4qq5ru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXxHNCAAKCRDj7w1vZxhR
xau5AP4vcDYTRpMS1JHj676CAcc1DNQ4oPg57GjeXP3KqbPyHwD/Zy50o9zSmvTA
jTL2X/6xJdA7afwMhuA+SeZmueHGkQs=
=9mzD
-----END PGP SIGNATURE-----

--a4yvypzj3h4qq5ru--
