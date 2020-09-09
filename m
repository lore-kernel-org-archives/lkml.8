Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00772C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 12:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D83A21941
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 12:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbgIIMWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 08:22:16 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:50807 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728631AbgIIMQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 08:16:46 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id F1233B69;
        Wed,  9 Sep 2020 08:09:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 09 Sep 2020 08:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=qgmKJTwOkmNLv6CnsBRjRV5ovLB
        zayDFMlR39hZ62tw=; b=gtM93QSfeTvz12PXC93haJEoEh9MeMsyieRCrVRdmb1
        HalO7bI93tAYNjGAtHgw8pIx5AqKp4Wb9OhzZWISZygf+oj3SCDrTRxqyvQseoR3
        E4GMusARP3poxNWNWLI2mMn0gYq9JDXkpj5blb4CfuCvC2PHgA6orpuXaznJFatz
        NMYx/AI04duW3DWGxRh0kt6X6SJOWFeaCguepspYFcZL92rCd7AvEPrF5t4Aa5ZB
        v7CG/GKPS4QffebHW2VwgJzk0IZW6kbTg1YI+iJG9CMQj3VNPdMPvksJN1+e21C9
        L7GthBmWQkOom1qNGUrrKruG/cU+t/pcSPOfEkau3qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=qgmKJT
        wOkmNLv6CnsBRjRV5ovLBzayDFMlR39hZ62tw=; b=c0Nia7ZSizJu84O+TcXxV3
        i4nh4Jc+Lf9O2TiXDGDB2Ld0bUqCEjORZmhrADmqgGr2hNKRaLmjchpMrQv56FZz
        Ic8GX9w84WSTTa76z37yp2gkao0PgFZ0YbrmClVFt27ZY72o1lafvJYmnplV7A6E
        L4gh0VxmNq3A+R7MrZFy0T4XgQKPujmxmM6gP9njAdlKzmiHjUfVXEun3oaniIqT
        gjla3oTHf/0dSY3hzKIdqAH/FWQWbYk7s4cSVHjnXSzf7k/TmmJUI4Gr2101WDiw
        Uoeute5eMHnGm8xpFgQCXRIZjdPdZOdnNja++Fp2GBy+m9ER+vCLC4ze5dp7jKMA
        ==
X-ME-Sender: <xms:3cVYX1e7AYEdKyKz8K9OuHdFNtj3bUGaTLnwPbntdmTO19jxC3-G2Q>
    <xme:3cVYXzMKN-pUhSRK7b3fvCSVzulH5_CCavK4f1j1FXzAP4g1SH9U-BL9AppanoGL_
    sBLTIsibfQNG7W_eF0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehhedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepveegudetkeethfetgffgtdekkefghefhffefgeduleehgeehieeuveefgedv
    ieegnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepledtrdekledrieekrd
    ejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehm
    rgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:3cVYX-iB_cRoe9PJ1RaEAW15ua8dD8bwSXs5fHVb9HuExtZ5EECwHQ>
    <xmx:3cVYX-8ratkdu5nhjDS27__t4AZl3YsKF7qWfNn6qRIx5t4xEN8iHw>
    <xmx:3cVYXxszRfT_6BJUTl8YTjp_Vy7LEKqRvO6DPdBG80zJQBtFydgw6A>
    <xmx:3sVYXyUm2928P1JI4gNPkmeFb_rZqsA5mDrUTkgpQQpNDn-Y7LfVUA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id A565D3280059;
        Wed,  9 Sep 2020 08:09:01 -0400 (EDT)
Date:   Wed, 9 Sep 2020 14:08:59 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Wilken Gottwalt <wilken.gottwalt@mailbox.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] dt-bindings: arm: sunxi: update H2+/H3 cpu clocks
Message-ID: <20200909120859.yosl2vgs3rj34stu@gilmour.lan>
References: <20200903100708.GA466735@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6q6cx2imwkgwfpoc"
Content-Disposition: inline
In-Reply-To: <20200903100708.GA466735@monster.powergraphx.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6q6cx2imwkgwfpoc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Thanks for contributing

The prefix isn't right though.

dt-bindings is used when you're modifying the binding itself, ie the
description of what the node is supposed to look like, not when you
actually use that node in a DT.

In that case, that would be ARM: dts: sunxi:

(we're on the ARM architecture, modifying dts's, for the sunxi platform)

On Thu, Sep 03, 2020 at 12:07:08PM +0200, Wilken Gottwalt wrote:
> Change H2+/H3 clocks to 8 steps from 528 MHz up to 1200 MHz to support a
> more fine-grained powersave setup. The SoCs are made for 1296 MHz, so
> these clocks are still in a safe range. Tested on a NanoPi Duo and
> OrangePi Zero.

How was this tested?

cpufreq OPP misconfiguration on Allwinner SoCs has been known to create
some errors that are fairly hard to spot and be quite easy to go
unnoticed (like caches corruptions).

The only reliable test we have is:
https://github.com/ssvb/cpuburn-arm/blob/master/cpufreq-ljt-stress-test

> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@mailbox.org>
> ---
>  arch/arm/boot/dts/sun8i-h3.dtsi | 34 +++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3=
=2Edtsi
> index 4e89701df91f..5517fcc02b7d 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -48,23 +48,53 @@ cpu0_opp_table: opp_table0 {
>  		compatible =3D "operating-points-v2";
>  		opp-shared;
> =20
> -		opp-648000000 {
> -			opp-hz =3D /bits/ 64 <648000000>;
> +		opp-528000000 {
> +			opp-hz =3D /bits/ 64 <528000000>;
> +			opp-microvolt =3D <1020000 1020000 1300000>;
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +		};
> +
> +		opp-624000000 {
> +			opp-hz =3D /bits/ 64 <624000000>;
>  			opp-microvolt =3D <1040000 1040000 1300000>;
>  			clock-latency-ns =3D <244144>; /* 8 32k periods */
>  		};
> =20
> +		opp-720000000 {
> +			opp-hz =3D /bits/ 64 <720000000>;
> +			opp-microvolt =3D <1060000 1060000 1300000>;
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +		};
> +
>  		opp-816000000 {
>  			opp-hz =3D /bits/ 64 <816000000>;
>  			opp-microvolt =3D <1100000 1100000 1300000>;
>  			clock-latency-ns =3D <244144>; /* 8 32k periods */
>  		};
> =20
> +		opp-912000000 {
> +			opp-hz =3D /bits/ 64 <912000000>;
> +			opp-microvolt =3D <1140000 1140000 1300000>;
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +		};
> +
>  		opp-1008000000 {
>  			opp-hz =3D /bits/ 64 <1008000000>;
>  			opp-microvolt =3D <1200000 1200000 1300000>;
>  			clock-latency-ns =3D <244144>; /* 8 32k periods */
>  		};
> +
> +		opp-1104000000 {
> +			opp-hz =3D /bits/ 64 <1104000000>;
> +			opp-microvolt =3D <1240000 1240000 1300000>;
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +		};
> +
> +		opp-1200000000 {
> +			opp-hz =3D /bits/ 64 <1200000000>;
> +			opp-microvolt =3D <1300000 1300000 1300000>;
> +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> +		};
>  	};

IIRC U-Boot will start the CPU at 1008 MHz on the H3, so in the
situation where a board doesn't list the regulators attached to the CPU,
the kernel will happily use the 1104 and 1200 MHz frequencies, even
though it won't adjust the voltage accordingly, causing errors.

The way we worked around that is to provide the extra OOPs in a separate
DTSI so that the boards with regulator support can opt-in.

Maxime

> =20
>  	cpus {
> --=20
> 2.28.0
>=20

--6q6cx2imwkgwfpoc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX1jF2wAKCRDj7w1vZxhR
xcH9AQDJvzXidnvkJd8/Lj/MOSojj8wH2SaJCLE/Z+bNCKoW/gD+KiYd05Z6+eQC
/P+oX8UofONcHBiZZIc97MMNseKtvw8=
=xb5A
-----END PGP SIGNATURE-----

--6q6cx2imwkgwfpoc--
