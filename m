Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C48C2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 08:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98C620672
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 08:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="OilJkqn3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VTthoDyk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgDFIQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 04:16:05 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:51923 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726475AbgDFIQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 04:16:05 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 285C45C0167;
        Mon,  6 Apr 2020 04:16:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 06 Apr 2020 04:16:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=H9DDW6krcFm9emc8mAJUo5dn76q
        nGbVHR/BZkxNxIVU=; b=OilJkqn3TTBiflBLc8yR4+ImLkNbmliJxtUJACQmpnq
        GflGnTJW+E4Wb+BkviwW+CRLEW0TZt5uwaXs5TrLbEtWPBHHj4o6+lWzPA+h+3WH
        seQvWTxvwU+d4ivvmu8fxXSwrqufnnk01Id2Eaa7Qk1MLXDzoBWgFL3Vsqmy5WwH
        MqpoVXtTY/OyF8IOj0AaOwPI52tw1tKDIQ/8DyTzwJDJdS+wjWLZMKwkiiAj62TD
        hQCBqD0yP/wJwLBLt6MnPDUoyRrtdm8YL+G3qP9T6TvYNEbgaxia7wUQjkrPCZcA
        1fbc2R9arn7ua+sMqrQNWEUuze38QgTMZ4D2QHOAivg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=H9DDW6
        krcFm9emc8mAJUo5dn76qnGbVHR/BZkxNxIVU=; b=VTthoDykgEX+CqOKadHdkt
        zMgEn77wzD2l8+LKkCWgf3jmKhsJuQHfQ93U5Bjqn1E0CX4tFqWfzahARLg2bSOt
        UN7zMZt61moy/6ckMog9XBJ/FwZWTGmsK4dB1lJNULp0trA8q9GPJj9nZICf7Yvj
        ne0mLqPlnEgjiZCLR6z/Bw+lDgeouyXt4hAnvpKJ9n+0h0zKiQhVMK/qeaDXNuu/
        y7byojGSSOxw96lR0mkDr+pD6Zzi5421MmoYdBv7C8DfLT00B01ob7PLSYFhYKZi
        hVGINNdOk+okgsHSJOgJ6DhKmLcpqs8k7dn94HaR/VLS3QUhouIkIMFyXsrtqKMg
        ==
X-ME-Sender: <xms:QuWKXnucg85BrvgMhWQr-FeuTf8dX5N6gKzHZHElg209Wua9RHed-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudefgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:QuWKXj-ty1pOoPwyECFFSX5TAQtOuw3kexkV6vy87kLZMvHxF7X1CA>
    <xmx:QuWKXv2slWHDoMC5ilNZwp_2jkQyxjOA7cjIb7pX1bLJLEkVD8i3KA>
    <xmx:QuWKXlLC82ZcFszHiO0q0MSKLXJRWLFugzWKutWJ9CA0wZfe0Jqf7w>
    <xmx:ROWKXiw1hpTi3NI2mVC5A1BDFvGY-0z-f7ptWwDT4zZyReTaLVmTNA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 930C43280063;
        Mon,  6 Apr 2020 04:16:02 -0400 (EDT)
Date:   Mon, 6 Apr 2020 10:16:01 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH v2 4/7] arm64: dts: allwinner: h6: Add GPU Operating
 Performance Points table
Message-ID: <20200406081601.3y6fwb7czr2xdkep@gilmour.lan>
References: <20200405173601.24331-1-peron.clem@gmail.com>
 <20200405173601.24331-5-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6dpks2tu5fnpj4uh"
Content-Disposition: inline
In-Reply-To: <20200405173601.24331-5-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6dpks2tu5fnpj4uh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 05, 2020 at 07:35:58PM +0200, Cl=E9ment P=E9ron wrote:
> Add an Operating Performance Points table for the GPU to
> enable Dynamic Voltage & Frequency Scaling on the H6.
>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> ---
>  .../boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi b/arch/=
arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi
> new file mode 100644
> index 000000000000..4a1814844fe0
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +// Copyright (C) 2020 Cl=E9ment P=E9ron <peron.clem@gmail.com>
> +
> +/ {
> +	gpu_opp_table: opp_table1 {

A node name is supposed to be a generic description, so what about
using gpu-opp-table (and cpu-opp-table) instead?

> +		compatible =3D "operating-points-v2";
> +
> +		opp@756000000 {
> +			opp-hz =3D /bits/ 64 <756000000>;
> +			opp-microvolt =3D <1040000>;
> +		};
> +		opp@624000000 {
> +			opp-hz =3D /bits/ 64 <624000000>;
> +			opp-microvolt =3D <950000>;
> +		};

Ordering by ascending frequency would be great here.

Also, why did you need to create a new DTSI for it? Is there some
downside to enabling it for all the users?

Maxime

--6dpks2tu5fnpj4uh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXorlQQAKCRDj7w1vZxhR
xZxCAP9Ed3XwPlEnD981kjvdZJewNMICIIiLMivOvQOW7QELnQEA48e7gDh+Gv5p
fy5gQba/rD59y7pA4kmRfG5qpwSZsw8=
=/vG6
-----END PGP SIGNATURE-----

--6dpks2tu5fnpj4uh--
