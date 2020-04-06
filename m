Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6545EC2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 08:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6BC20672
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 08:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="KAtyG4FL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ajfasie0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgDFIOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 04:14:16 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55145 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726491AbgDFIOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 04:14:16 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 69D315C018B;
        Mon,  6 Apr 2020 04:14:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 06 Apr 2020 04:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=1VudF3Kq/8asq6hygF6IQCj2Q3h
        SRIw3YwqtF/cFmB0=; b=KAtyG4FLUdBxEWmGPYVjyJRIyxZSpKfNimbo5fH8O2d
        7KT3v+RDbRyRUrmk3PgHwdE1XK3nyBJUGW7AvyDQB8R80SwVDGaknZ8TKBBgg+de
        s0TLX9iEmTRzUgAN9p6xhGLxeGxQyKuixkL+sEoJrpGGDpCm+swKA9xjQ+LVopRJ
        mMAJyJENHvkWXMgRZ/D8HLtqnxRNOFND5p9umNx1QWsLwolGLCDH4vXv8UW47F6v
        EjaUuZ5X8/y8xe7H6ryJsZnSCIL9DO3HBkHskaTaG0n/hFLQD3iMtoV2/s17/Y8B
        apPDLSNQBRSV/VT9KEsB/pPSUKjmA9e6r2A0PMMfYsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=1VudF3
        Kq/8asq6hygF6IQCj2Q3hSRIw3YwqtF/cFmB0=; b=Ajfasie06dlVejF7JyHJ/J
        StWh/U8QQnJRX4iXhwOFGNRmwNUmxpGerWh+iiZJ9aMHgGESCKdp3HhhWYZMZsEP
        Rf2bkHE9UX++NNQEcpr/9NEMfD4nRgmWcxAv327AyWD5KHOAXq7NTTmDORcX0onS
        d7k4E6PQKMBfNf1ulh9fEGCjL+9SpiWthN8aNE0jckNJYg+hxEWBiDwCSbORH5xN
        TdPsJIoaVQo+/p6LFwpFJWwStVrXBQ1JnW9uGGMcjIozQpTwv5CVKsiE95/iMdsT
        J++8Ll2jRog6kRqCuLbHSvinPhVyZGU4jW1kCokHNWNy5yO9O8NpzkrQTMt2RaPw
        ==
X-ME-Sender: <xms:1eSKXqizsLvSFm4mIrHcHSNCHbFO8n0yvS1Q11627rmtnBm9wHqFIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudefgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:1eSKXty6zyI-LsETgxctreM3RAb6T8FzF-BrinAKkMwOmJwfvNyrxw>
    <xmx:1eSKXu_SgBLXeJ4oCvlyJtc_g0LO8XBLL1RQJ7K8UuGcF_vhDc2ZLw>
    <xmx:1eSKXqw6r1HH0xx_jQiU92NlMBzQjYH16Bm7Y-r0ZXqAo4_RMJY8Lw>
    <xmx:1uSKXu3pOBvi-yjoNs6EYkV6PMxWsNvSOZKGSIYEgkJynkn2q7KyJg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2456E306D39B;
        Mon,  6 Apr 2020 04:14:13 -0400 (EDT)
Date:   Mon, 6 Apr 2020 10:14:12 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Ondrej Jirman <megous@megous.com>
Subject: Re: [PATCH v2 3/7] arm64: dts: allwinner: h6: Add CPU Operating
 Performance Points table
Message-ID: <20200406081412.ubdogkjknlofynei@gilmour.lan>
References: <20200405173601.24331-1-peron.clem@gmail.com>
 <20200405173601.24331-4-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mwo6baf4xcdujpro"
Content-Disposition: inline
In-Reply-To: <20200405173601.24331-4-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mwo6baf4xcdujpro
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 05, 2020 at 07:35:57PM +0200, Cl=E9ment P=E9ron wrote:
> From: Ondrej Jirman <megous@megous.com>
>
> Add an Operating Performance Points table for the CPU cores to
> enable Dynamic Voltage & Frequency Scaling on the H6.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> ---
>  .../boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi | 121 ++++++++++++++++++
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |   4 +
>  2 files changed, 125 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi b/arch/=
arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi
> new file mode 100644
> index 000000000000..8c1e413c6af9
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi
> @@ -0,0 +1,121 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +// Copyright (C) 2020 Ondrej Jirman <megous@megous.com>
> +// Copyright (C) 2020 Cl=E9ment P=E9ron <peron.clem@gmail.com>
> +
> +/ {
> +	cpu0_opp_table: opp_table0 {

Node names shouldn't have an underscore, this will trigger a DTC
warning.

> +		compatible =3D "allwinner,sun50i-h6-operating-points";
> +		nvmem-cells =3D <&speedbin_efuse>;
> +		opp-shared;
> +
> +		opp@480000000 {
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +			opp-hz =3D /bits/ 64 <480000000>;
> +
> +			opp-microvolt-speed0 =3D <880000>;
> +			opp-microvolt-speed1 =3D <820000>;
> +			opp-microvolt-speed2 =3D <820000>;
> +		};

And similarly, if you have a unit-address (the part after @), you
should have a matching reg property. You should use a dash instead.

> +		opp@720000000 {
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +			opp-hz =3D /bits/ 64 <720000000>;
> +
> +			opp-microvolt-speed0 =3D <880000>;
> +			opp-microvolt-speed1 =3D <820000>;
> +			opp-microvolt-speed2 =3D <820000>;
> +		};
> +
> +		opp@816000000 {
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +			opp-hz =3D /bits/ 64 <816000000>;
> +
> +			opp-microvolt-speed0 =3D <880000>;
> +			opp-microvolt-speed1 =3D <820000>;
> +			opp-microvolt-speed2 =3D <820000>;
> +		};
> +
> +		opp@888000000 {
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +			opp-hz =3D /bits/ 64 <888000000>;
> +
> +			opp-microvolt-speed0 =3D <880000>;
> +			opp-microvolt-speed1 =3D <820000>;
> +			opp-microvolt-speed2 =3D <820000>;
> +		};
> +
> +		opp@1080000000 {
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +			opp-hz =3D /bits/ 64 <1080000000>;
> +
> +			opp-microvolt-speed0 =3D <940000>;
> +			opp-microvolt-speed1 =3D <880000>;
> +			opp-microvolt-speed2 =3D <880000>;
> +		};
> +
> +		opp@1320000000 {
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +			opp-hz =3D /bits/ 64 <1320000000>;
> +
> +			opp-microvolt-speed0 =3D <1000000>;
> +			opp-microvolt-speed1 =3D <940000>;
> +			opp-microvolt-speed2 =3D <940000>;
> +		};
> +
> +		opp@1488000000 {
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +			opp-hz =3D /bits/ 64 <1488000000>;
> +
> +			opp-microvolt-speed0 =3D <1060000>;
> +			opp-microvolt-speed1 =3D <1000000>;
> +			opp-microvolt-speed2 =3D <1000000>;
> +		};
> +
> +		opp@1608000000 {
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +			opp-hz =3D /bits/ 64 <1608000000>;
> +
> +			opp-microvolt-speed0 =3D <1090000>;
> +			opp-microvolt-speed1 =3D <1030000>;
> +			opp-microvolt-speed2 =3D <1030000>;
> +		};
> +
> +		opp@1704000000 {
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +			opp-hz =3D /bits/ 64 <1704000000>;
> +
> +			opp-microvolt-speed0 =3D <1120000>;
> +			opp-microvolt-speed1 =3D <1060000>;
> +			opp-microvolt-speed2 =3D <1060000>;
> +		};
> +
> +		opp@1800000000 {
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +			opp-hz =3D /bits/ 64 <1800000000>;
> +
> +			opp-microvolt-speed0 =3D <1160000>;
> +			opp-microvolt-speed1 =3D <1100000>;
> +			opp-microvolt-speed2 =3D <1100000>;
> +		};
> +	};
> +};
> +
> +&cpu0 {
> +	operating-points-v2 =3D <&cpu0_opp_table>;
> +	#cooling-cells =3D <2>;
> +};
> +
> +&cpu1 {
> +	operating-points-v2 =3D <&cpu0_opp_table>;
> +	#cooling-cells =3D <2>;
> +};
> +
> +&cpu2 {
> +	operating-points-v2 =3D <&cpu0_opp_table>;
> +	#cooling-cells =3D <2>;
> +};
> +
> +&cpu3 {
> +	operating-points-v2 =3D <&cpu0_opp_table>;
> +	#cooling-cells =3D <2>;
> +};
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/bo=
ot/dts/allwinner/sun50i-h6.dtsi
> index e0dd0757be0b..6b7af858614a 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -253,6 +253,10 @@
>  			#address-cells =3D <1>;
>  			#size-cells =3D <1>;
>
> +			speedbin_efuse: speed@1c {
> +				reg =3D <0x1c 0x4>;
> +			};
> +

You should order this by address, so after the THS calibration. Also,
using a less generic node name than "speed" would be great. What about
soc-bin ?

Maxime

--mwo6baf4xcdujpro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXork1AAKCRDj7w1vZxhR
xf4/AQCEoG5vXYs8jtKK460unM8Rt1R6W0qctIijak1+JmD/SwD/daZLNDlmRB4T
WOmP5a9hbyf30uTxUuDKEDqDvk4DUgs=
=4TEt
-----END PGP SIGNATURE-----

--mwo6baf4xcdujpro--
