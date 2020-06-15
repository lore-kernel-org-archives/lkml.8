Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D41FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76E96206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="J96A8ef0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O2tglPPH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbgFOIOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:14:36 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:57133 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728162AbgFOIOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:14:35 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 989A65C00A0;
        Mon, 15 Jun 2020 04:14:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 15 Jun 2020 04:14:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=jUgci8k8U3TokZGnj4Urf7+MUxy
        6zfiiWy2Fnf295uw=; b=J96A8ef0a/590vux1U03FiJonoJW7bFlaX0+uLYfd5u
        dgqLrw8BQCtxKNY1S9sciNvm/5nGeUWubxO1zcjJoAW7KhegiuXMxnnyHX9YoVX+
        qGE4o7aVDNQx8BhudlQbbSABCsB/tb6cHcmCGuuiFbRckgS7AypNxS38ZM1eNOEK
        IT++L1cUFj7UskAM8q9YW++jVn3tOatlT8dnID/+YO1jd/NADTjVdnCebAT2PPNn
        b0l31gHT96DuESsZ5fqEHjR7U8unhI+IU9iuOfedygM84acWdFnNX0aZq6+e/6hw
        wiviprJyX+RM93oeTLowea6MmtMWSC/bI2cTAJhyjTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=jUgci8
        k8U3TokZGnj4Urf7+MUxy6zfiiWy2Fnf295uw=; b=O2tglPPHI2ZhPXhPHgdcay
        eVc7DqpX/qvGGgZoNDnvaIuNfpBcAfJd3WXtJgyH94MdTdJcGCM+JaPBOkoHMckq
        Kcz6AGWOPhOgTlewfJgZ2iapmFxtpNiYlpSNhNxeGtseyzlxZT+89g5XxSUhEqLT
        ALL+PLbUx5t42Bt+/+d3a7nLYP9BXx8O3uxe8F00duAo3RDaMyaxkTXhZMgRaRMG
        lCaPVEIgbO+Y1WrMGO60cEQedIetYuTzwjYwtPjt/jPSg1Ct/gXjATZDgwIV+R9C
        57gFjdJCFpNu39XmoVAoBEBPCo40aLkrD/8VL41JhM+ipHPDPDwoC0CHbCYlh3BA
        ==
X-ME-Sender: <xms:6S3nXgxIMtqM2-tRdj4_V36zMNEMZ6uiMDX1HTI8vu2wgtBP74zZdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeikecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgvucft
    ihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtthgvrh
    hnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeguden
    ucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedunecurfgrrh
    grmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:6S3nXkSRKS-grTU_tbhUoxuInKiB4s2FdzUnXuqF-AAfTn5g__itFg>
    <xmx:6S3nXiVKRkdsCC50pYGOi1i--C2QydHc123Sh969TTjHkU9iMEEawA>
    <xmx:6S3nXug7ijSmBoRtGs4W0vDVn6KCSpx4Qr7S9Jriqh4ofNGko7AtzA>
    <xmx:6i3nXtOZQGrAINczXP9C4oSPs2qF40lXOvrd5z-1DrIb5WahPy71Kg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 115DC30618B7;
        Mon, 15 Jun 2020 04:14:32 -0400 (EDT)
Date:   Mon, 15 Jun 2020 10:14:31 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Diego Rondini <diego.rondini@kynetics.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 2/2] ARM: dts: orange-pi-zero-plus2: add leds
 configuration
Message-ID: <20200615081431.sbqezly4jcryvxk6@gilmour.lan>
References: <20200528204712.552964-1-diego.rondini@kynetics.com>
 <20200528204712.552964-2-diego.rondini@kynetics.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ldpz5qc3s34puj3m"
Content-Disposition: inline
In-Reply-To: <20200528204712.552964-2-diego.rondini@kynetics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ldpz5qc3s34puj3m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2020 at 10:47:12PM +0200, Diego Rondini wrote:
> Add pwr and status leds configuration and turn on pwr led by default for =
Orange
> Pi Zero Plus 2 (both H3 and H5 variants).
>=20
> Signed-off-by: Diego Rondini <diego.rondini@kynetics.com>
> ---
>  .../boot/dts/sun8i-h3-orangepi-zero-plus2.dts    | 16 ++++++++++++++++
>  .../allwinner/sun50i-h5-orangepi-zero-plus2.dts  | 16 ++++++++++++++++
>  2 files changed, 32 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts b/arch/ar=
m/boot/dts/sun8i-h3-orangepi-zero-plus2.dts
> index 4376767699a47..4cd0ac706bd2c 100644
> --- a/arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts
> +++ b/arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts
> @@ -82,6 +82,22 @@ wifi_pwrseq: wifi_pwrseq {
>  		reset-gpios =3D <&pio 0 9 GPIO_ACTIVE_LOW>; /* PA9 */
>  		post-power-on-delay-ms =3D <200>;
>  	};
> +
> +	leds {
> +		compatible =3D "gpio-leds";
> +
> +		pwr_led {
> +			label =3D "orangepi:green:pwr";
> +			gpios =3D <&r_pio 0 10 GPIO_ACTIVE_HIGH>;
> +			default-state =3D "on";
> +		};
> +
> +		status_led {

Having an underscore in the node name will trigger a DTC warning. What
about using pwr and status as nodenames?

> +			label =3D "orangepi:red:status";
> +			gpios =3D <&pio 0 17 GPIO_ACTIVE_HIGH>;
> +		};
> +

There's an extra line here that you should remove

Maxime

--ldpz5qc3s34puj3m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXuct5wAKCRDj7w1vZxhR
xUjaAQDkFMomehsDqclVzdruO2gQslavfdE5Z5Nk9MBu53/X4AEAuy/0NEbxdB4m
iIgPxGIxqLa5k/nFdCS+8z/ksmbEdgw=
=N70a
-----END PGP SIGNATURE-----

--ldpz5qc3s34puj3m--
