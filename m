Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20317C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E46B92070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="o5q+AdxP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MEyY+0Sy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgGQQJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 12:09:52 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58985 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726256AbgGQQJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:09:52 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 171845C00BC;
        Fri, 17 Jul 2020 12:09:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 17 Jul 2020 12:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=pJsIwaT04OvIIHzJFXu1NKs61t7
        iLA23ExL+YOdLhKo=; b=o5q+AdxPs6086ttvaj0arF2jYvvafA4zUHjNDp9FdAg
        hTzjB+HhrZUPaBPa+6h9Q6kzAHZeQ2U59TT+libCfaP5h0ijL1U6TEHwN4tKQF1U
        iyL4pQbBO2cJvAyo7017De9t5yJV7YDUUsmb5IjOSWhCo/XWQS6VdsVe/GpSHke6
        7rEJHhzPcypOA96yrcO5m8Y+EduEKd84ii6e8J285+PCLqB63KbhUy18K+xiQ9tt
        2pXCPOIvSy6Ta6hRpoFsR2O/4BUOsBCnv78kh8laVdMFaTO20J5dnW4TFiNsEZi9
        x5lqwXBO1Fzmuo6O2AKsYGmUSkAcbJJZSfhhJ5YUHhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=pJsIwa
        T04OvIIHzJFXu1NKs61t7iLA23ExL+YOdLhKo=; b=MEyY+0SyOLvnFpE/yS3Rgg
        0bIzq1ACCrWs90g2L0sjwQMcDBQU9CMcLCMzJkaxexqo6E+o1bUZFTRMQ5Uqst3P
        Chl1HIR8j/eQ3oTqfbcf+yGAhpSrlnLU1n3Arm7LpskRlashL2/7oLmcUkEALhPR
        XWKpAy2wS00ikdMTaFaNsse2rwl/sw9+tArMG5mXNEhrnkHxK8umFYt/OuRA3M32
        lu9GXo+pUmbFGZ2xoBfLIIsAeU1IH7OpfkLTECwxao0hmCybBrPpgX7z3Fc/K7sq
        rWnQN8XXMAMZ344KlSQB5Gygdamhz79Fq5uIRMpGHumly8LdU8Xmz1esDeTwn1Sg
        ==
X-ME-Sender: <xms:Ts0RXyXJ1nrb5-x-DgqJAg4zMdK-6tS35qZI5F3JZRyNchtMpbMT6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrfeejgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:Ts0RX-n-PBLeYwxbAE-7YrNjWATKHkwoXVEsq6vZVqpJM9Q-r-MB0Q>
    <xmx:Ts0RX2Y3KpX2Ll6sgCLS65OVko_2yOJaw-AqkvOGsVV3flt7w1o6QA>
    <xmx:Ts0RX5WmqjutkUY26p8DfWQrMRw87PjyamsBXULrTeszFNhDpHqLuQ>
    <xmx:T80RX2imJr67aCqDgcT-Aryh5dmv3UPw6AgO-L5l1s9aVRROV-9xFQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 287D8328005E;
        Fri, 17 Jul 2020 12:09:50 -0400 (EDT)
Date:   Fri, 17 Jul 2020 18:09:49 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     robh+dt@kernel.org, wens@csie.org, tiny.windzz@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: allwinner: Use GPIO bank name macro to
 describe GPIO
Message-ID: <20200717160949.uqeyhr7trtqhj2nt@gilmour.lan>
References: <20200715115529.2769-1-frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lqv7skiuvbslab4p"
Content-Disposition: inline
In-Reply-To: <20200715115529.2769-1-frank@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lqv7skiuvbslab4p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2020 at 07:55:29PM +0800, Frank Lee wrote:
> From: Yangtao Li <frank@allwinnertech.com>
>=20
> Convert gpio.h to sunxi-gpio.h, and convert to use gpio bank name macro.
> This is done using the following command.
>=20
> sed -i 's/r_pio 0/r_pio PL/g' arch/arm64/boot/dts/allwinner/*
> sed -i 's/r_pio 1/r_pio PM/g' arch/arm64/boot/dts/allwinner/*
>=20
> sed -i 's/\&pio 0/\&pio PA/g' arch/arm64/boot/dts/allwinner/*
> sed -i 's/\&pio 2/\&pio PC/g' arch/arm64/boot/dts/allwinner/*
> sed -i 's/\&pio 3/\&pio PD/g' arch/arm64/boot/dts/allwinner/*
> sed -i 's/\&pio 4/\&pio PE/g' arch/arm64/boot/dts/allwinner/*
> sed -i 's/\&pio 5/\&pio PF/g' arch/arm64/boot/dts/allwinner/*
> sed -i 's/\&pio 6/\&pio PG/g' arch/arm64/boot/dts/allwinner/*
> sed -i 's/\&pio 7/\&pio PH/g' arch/arm64/boot/dts/allwinner/*
>=20
> sed -i 's/dt-bindings\/gpio\/gpio.h/dt-bindings\/gpio\/sunxi-gpio.h/g' \
> 	arch/arm64/boot/dts/allwinner/*
>=20
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
>=20
> ---
>  .../allwinner/sun50i-a64-amarula-relic.dts    | 18 ++++++------
>  .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 20 ++++++-------
>  .../dts/allwinner/sun50i-a64-nanopi-a64.dts   |  8 +++---
>  .../sun50i-a64-oceanic-5205-5inmfd.dts        |  4 +--
>  .../dts/allwinner/sun50i-a64-olinuxino.dts    | 12 ++++----
>  .../dts/allwinner/sun50i-a64-orangepi-win.dts | 20 ++++++-------
>  .../boot/dts/allwinner/sun50i-a64-pine64.dts  |  4 +--
>  .../dts/allwinner/sun50i-a64-pinebook.dts     | 16 +++++------
>  .../dts/allwinner/sun50i-a64-pinephone.dtsi   | 14 +++++-----
>  .../boot/dts/allwinner/sun50i-a64-pinetab.dts | 28 +++++++++----------
>  .../boot/dts/allwinner/sun50i-a64-sopine.dtsi |  4 +--
>  .../boot/dts/allwinner/sun50i-a64-teres-i.dts | 20 ++++++-------
>  .../sun50i-h5-emlid-neutis-n5-devboard.dts    |  2 +-
>  .../sun50i-h5-libretech-all-h5-cc.dts         |  2 +-
>  .../allwinner/sun50i-h5-nanopi-neo-plus2.dts  | 14 +++++-----
>  .../dts/allwinner/sun50i-h5-nanopi-neo2.dts   | 14 +++++-----
>  .../dts/allwinner/sun50i-h5-orangepi-pc2.dts  | 16 +++++------
>  .../allwinner/sun50i-h5-orangepi-prime.dts    | 18 ++++++------
>  .../sun50i-h5-orangepi-zero-plus.dts          | 13 +++++----
>  .../sun50i-h5-orangepi-zero-plus2.dts         |  6 ++--
>  .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  8 +++---
>  .../dts/allwinner/sun50i-h6-orangepi-3.dts    | 20 ++++++-------
>  .../allwinner/sun50i-h6-orangepi-lite2.dts    |  8 +++---
>  .../allwinner/sun50i-h6-orangepi-one-plus.dts |  2 +-
>  .../dts/allwinner/sun50i-h6-orangepi.dtsi     | 12 ++++----
>  .../boot/dts/allwinner/sun50i-h6-pine-h64.dts | 16 +++++------
>  .../dts/allwinner/sun50i-h6-tanix-tx6.dts     |  6 ++--
>  27 files changed, 163 insertions(+), 162 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b=
/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> index c7bd73f35ed8..92f8caecf939 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
> @@ -7,7 +7,7 @@
>  #include "sun50i-a64.dtsi"
>  #include "sun50i-a64-cpu-opp.dtsi"
> =20
> -#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/gpio/sunxi-gpio.h>
> =20
>  / {
>  	model =3D "Amarula A64-Relic";
> @@ -23,8 +23,8 @@ chosen {
> =20
>  	i2c {
>  		compatible =3D "i2c-gpio";
> -		sda-gpios =3D <&pio 4 13 GPIO_ACTIVE_HIGH>;
> -		scl-gpios =3D <&pio 4 12 GPIO_ACTIVE_HIGH>;
> +		sda-gpios =3D <&pio PE 13 GPIO_ACTIVE_HIGH>;
> +		scl-gpios =3D <&pio PE 12 GPIO_ACTIVE_HIGH>;
>  		i2c-gpio,delay-us =3D <5>;
>  		#address-cells =3D <1>;
>  		#size-cells =3D <0>;
> @@ -40,8 +40,8 @@ ov5640: camera@3c {
>  			AVDD-supply =3D <&reg_aldo1>;
>  			DOVDD-supply =3D <&reg_dldo3>;
>  			DVDD-supply =3D <&reg_eldo3>;
> -			reset-gpios =3D <&pio 4 14 GPIO_ACTIVE_LOW>; /* CSI-RST-R: PE14 */
> -			powerdown-gpios =3D <&pio 4 15 GPIO_ACTIVE_HIGH>; /* CSI-STBY-R: PE15=
 */
> +			reset-gpios =3D <&pio PE 14 GPIO_ACTIVE_LOW>; /* CSI-RST-R: PE14 */
> +			powerdown-gpios =3D <&pio PE 15 GPIO_ACTIVE_HIGH>; /* CSI-STBY-R: PE1=
5 */

The pin name is fairly obvious now, I guess we can just remove the PE14
/ PE15 from the comment (and that applies to the other DT as well)

Maxime

--lqv7skiuvbslab4p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXxHNTQAKCRDj7w1vZxhR
xey2AP0RC7QnnC0lMn7UCywJeZ/mw+NkJp23vTbj2AnZn/W+LAD+NqaMO7lB4rZC
2gTt8Rfe0CYFgcQxUw5uyJs8sT805gs=
=eE9A
-----END PGP SIGNATURE-----

--lqv7skiuvbslab4p--
