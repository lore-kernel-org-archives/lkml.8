Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5614DC3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E95620714
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="e3dGEldH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SbBzEUht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgBXJ1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:27:08 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:38987 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727229AbgBXJ1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:27:07 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id BD80C20A3C;
        Mon, 24 Feb 2020 04:27:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:27:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=7U30ksunGq91DjO/yXEChQMx3ng
        imz//YkooslE9lIU=; b=e3dGEldHtxihm3SnTWFiwqYkb7aEJ3wXwPQU9lJnfWS
        Yal0lwDTmld81Z5+o0LF/0RtdhU1qg1qChHlZHvze1Vd+3fCHfXXyaDVIfPDulng
        Eboi5uzYTkM1gWbrOtvUzqiffOgvpYTRQMAgRUyRfQKETUwbEVsKf7zW8VonYcEo
        W99MirS8X48nLOqJ6f7zrlGYDU2D5U+P/9r1pQ6EkqIfdwuNEW3mcBqN0IvHSGcv
        W5brblO/N/ObabFc39WfX9ONQ2LKdM+9VfCVQXtjeCa74gRAeMMcCCQo8CqZLta5
        eYo2nivEU5qAOVpekaO2SP1vYMEfp4RBk17M+/fs+2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=7U30ks
        unGq91DjO/yXEChQMx3ngimz//YkooslE9lIU=; b=SbBzEUhtKguE8DTSpxnFaS
        fBdUsEgGSx6UqxQJeGwPfzuWHqx6AMwn8GMHjurHLvXvpa/77o5tRocDlPVfvRoI
        fbzOln9hnpRxyV5TrlKrZ6EDuvtVLzy1Shgfckuapybu/RzUhQjNfsuYBP9gXmqz
        S/WVlHJxET5Y/gdxMfpt/P2Q6szbteNp4k8/sr/SibZ+ztFqPex8Fy3ZWHU+Ob6V
        Bw+3T+hBOmGgBgWMqf/x7AxF4pfVt5ixc6QSGF4hcooxFQC+1zwXUXHo5hHgr3Rr
        KWfY0JeLoYAW5VUzO777lENETuZpEw4U22FZZP/txRsCrpQzO60FebpUbpV3UgYA
        ==
X-ME-Sender: <xms:6ZZTXjOC_yWJgQ6mC7bbNKDYl94And8ilihzw5a1SWEXrOkt7662Dg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:6ZZTXt3Aqh6Ho_ocPD0vwSmjtEr_Pr53SVQhaSY401HEzZliLXVepA>
    <xmx:6ZZTXvmyjkBD-03PKjv50TTQt6JwGErOtn_q-GT-YGEtnyaMetuqqA>
    <xmx:6ZZTXj6hyoTD_g8ISR0cFzvy0omAWfJdeH6OLjGfS3bNznErq-GqIA>
    <xmx:6pZTXvdba5kCF1gUAxit4doFcvkziTOigOFR1wt7-THbc6J2LSfNNg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id A2EB8328005A;
        Mon, 24 Feb 2020 04:27:05 -0500 (EST)
Date:   Mon, 24 Feb 2020 10:27:04 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: sun50i-h5-orange-pi-pc2: Add CPUX voltage
 regulator
Message-ID: <20200224092704.gnnjwds3zmmravrw@gilmour.lan>
References: <20200223104019.527587-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w6i3mdfkts3errvh"
Content-Disposition: inline
In-Reply-To: <20200223104019.527587-1-megous@megous.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w6i3mdfkts3errvh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 23, 2020 at 11:40:19AM +0100, Ondrej Jirman wrote:
> Orange Pi PC2 features sy8106a regulator just like Orange Pi PC.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> Reviewed-by: Samuel Holland <samuel@sholland.org>
> ---
>  .../dts/allwinner/sun50i-h5-orangepi-pc2.dts  | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)

Having a changelog would be great

> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
> index 70b5f09984218..7b2572dc84857 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
> @@ -93,6 +93,10 @@ &codec {
>  	status = "okay";
>  };
>
> +&cpu0 {
> +	cpu-supply = <&reg_vdd_cpux>;
> +};
> +
>  &de {
>  	status = "okay";
>  };
> @@ -168,6 +172,22 @@ &ohci3 {
>  	status = "okay";
>  };
>
> +&r_i2c {
> +	status = "okay";
> +
> +	reg_vdd_cpux: regulator@65 {
> +		compatible = "silergy,sy8106a";
> +		reg = <0x65>;
> +		regulator-name = "vdd-cpux";
> +		silergy,fixed-microvolt = <1100000>;
> +		regulator-min-microvolt = <1000000>;
> +		regulator-max-microvolt = <1400000>;
> +		regulator-ramp-delay = <200>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +};
> +

Looks like you fixed the issues reported by Samuel though. I've
applied it.

Maxime

--w6i3mdfkts3errvh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXlOW6AAKCRDj7w1vZxhR
xWtLAP4yR1HaRlwGnk2FD+X7VmQ1E2adEITk68bc4hxUIUKccwD8C/Rd+mzb3MJG
pJZDFLurNHJRviqoRUqvCcAGuJPY9gI=
=j0Ge
-----END PGP SIGNATURE-----

--w6i3mdfkts3errvh--
