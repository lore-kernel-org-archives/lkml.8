Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B4FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B504F20809
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="rCOLBMOK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m44MQnC4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgG2Mev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 08:34:51 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:43683 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726950AbgG2Met (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 08:34:49 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 44F6A5C0156;
        Wed, 29 Jul 2020 08:34:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 29 Jul 2020 08:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=2W2Yj2pam7ZJP/prlQsRPaGYtKd
        XT6hqJ6A5Z7BBCKE=; b=rCOLBMOKNT1xXuHcBUQSWiiWQSurfYd/eOpbXR5xWLE
        2DjBVyf77Xwxgz460VLz5CggzrtlewHoTD952x5ASHGcDJH79KsQVeZo+Hwb33PR
        M/SDbpDED7wexjwHlXVcZ8z6f2tTlb71DddCVfElMlmP8EfQEs5Z1IWe4a5A4xEI
        ncMLkOwAH2ujw44HCGPPPNxpwAsRk0ctY7fXJSLdXWL6RjcI6DV538ZcqH2g6NQ0
        U6A7i9t+eLfqNOLD87Ab/cvgS/OmJGtHopPQeuwybPLnRtqUG/eIzxd7Z5UvNPGk
        m+3khXggAr7oEYO4uoYCJIMHx15fpxxHd8uudXeM7BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=2W2Yj2
        pam7ZJP/prlQsRPaGYtKdXT6hqJ6A5Z7BBCKE=; b=m44MQnC4dEg3aNrVV65Nz2
        9/DIi6yeAoHk9C2R/mIC+ybJH9UrwwtqDo7wVLFn4hwEEr1cRJw0YnKokd93tNxJ
        025qRa3gCwlUbL1TSRqWlyTyiCTqVMM3fDr7z227U00OXKmDKXN7IH/VUCd27DRZ
        R0+WurpDYdkgMHTsZ1ruMPIJ21zW1i0myHC+19WMz83bExN6SNbASSPm4QpC5yGU
        0QvMPlsRijAnuJ+0mvLiYEuBIuHIbRI9aNMVjrbrs8vWoa3knvNvzikMSqm6y1ut
        BSqZCSkmrmFxfUzuSDIRAGVQo2K5/AWLDGGyhdTKBtFZFDIyI6r21KbdjE8+UnbA
        ==
X-ME-Sender: <xms:5mwhX5HdxDGcXzbEFDp7ii-KKKq4ob46shK4eC6senXPh33ou98VsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrieeggdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculddvfedmnecujfgurhepfffhvffukfhfgggtuggjsehgtderredttddv
    necuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhord
    htvggthheqnecuggftrfgrthhtvghrnhepleekgeehhfdutdeljefgleejffehfffgieej
    hffgueefhfdtveetgeehieehgedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegt
    vghrnhhordhtvggthh
X-ME-Proxy: <xmx:5mwhX-W4hFeFn4AFM93v6CYZzNx-4PBDMAYjbeAg-cLRcn6UsHd0xA>
    <xmx:5mwhX7LPHIKns_4c4KRtdDGVPQ8VdRs9TxO7FyIDAwoNB7d0QmfJEQ>
    <xmx:5mwhX_HG2WFyY46UYaR3gojNMRlirZJUbEYUPtL9wlIVstvRDijmKw>
    <xmx:52whX6T_HRdj2ZwQjAvhY1oMD3ia6kRk4RkHNiWWn3kGacfZfiYBow>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5445E3280063;
        Wed, 29 Jul 2020 08:34:46 -0400 (EDT)
Date:   Wed, 29 Jul 2020 14:34:44 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-kernel@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: sun50i-pinephone: add led flash
Message-ID: <20200729123444.5t5cv47umhwu7jnd@gilmour.lan>
References: <20200725110812.199529-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zk6atuhnwc7zlxxx"
Content-Disposition: inline
In-Reply-To: <20200725110812.199529-1-luca@z3ntu.xyz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zk6atuhnwc7zlxxx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Sat, Jul 25, 2020 at 01:08:12PM +0200, Luca Weiss wrote:
> All revisions of the PinePhone have an SGM3140 LED flash. The gpios were
> swapped on v1.0 of the board but this was fixed in later revisions.
>=20
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  .../boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts   |  5 +++++
>  .../boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts   |  5 +++++
>  .../boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts   |  5 +++++
>  .../boot/dts/allwinner/sun50i-a64-pinephone.dtsi      | 11 +++++++++++
>  4 files changed, 26 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts b=
/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts
> index 0c42272106afa..b579b03d4e026 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts
> @@ -9,3 +9,8 @@ / {
>  	model =3D "Pine64 PinePhone Developer Batch (1.0)";
>  	compatible =3D "pine64,pinephone-1.0", "allwinner,sun50i-a64";
>  };
> +
> +&sgm3140 {
> +	flash-gpios =3D <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
> +	enable-gpios =3D <&pio 2 3 GPIO_ACTIVE_HIGH>; /* PC3 */
> +};
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts b=
/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts
> index 3e99a87e9ce52..8552587aac248 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts
> @@ -28,3 +28,8 @@ &backlight {
>  	num-interpolated-steps =3D <50>;
>  	default-brightness-level =3D <400>;
>  };
> +
> +&sgm3140 {
> +	flash-gpios =3D <&pio 2 3 GPIO_ACTIVE_HIGH>; /* PC3 */
> +	enable-gpios =3D <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
> +};
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts b=
/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts
> index a9f5b670c9b82..ec77715ba4a2a 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts
> @@ -38,3 +38,8 @@ &lis3mdl {
>  	interrupt-parent =3D <&pio>;
>  	interrupts =3D <1 1 IRQ_TYPE_EDGE_RISING>; /* PB1 */
>  };
> +
> +&sgm3140 {
> +	flash-gpios =3D <&pio 2 3 GPIO_ACTIVE_HIGH>; /* PC3 */
> +	enable-gpios =3D <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
> +};
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/ar=
ch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> index 25150aba749dc..e0bc1bcc1c1f3 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> @@ -60,6 +60,17 @@ vibrator {
>  		enable-gpios =3D <&pio 3 2 GPIO_ACTIVE_HIGH>; /* PD2 */
>  		vcc-supply =3D <&reg_dcdc1>;
>  	};
> +
> +	sgm3140: led-controller {

The nodes should be ordered by node-name here

> +		compatible =3D "sgmicro,sgm3140";
> +		vin-supply =3D <&reg_dcdc1>;
> +
> +		sgm3140_flash: led {

What do you need the label for?

Thanks!
Maxime

--zk6atuhnwc7zlxxx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXyFs5AAKCRDj7w1vZxhR
xSdYAP9w/fsQfQ4tNqf7h0+C92tE5O5wQryb8LSwfwlx9qYE6QEAn0bOJ4CbYCX0
zjz8lGW/kDfed/4sE69A6yTq7Qcq8go=
=Ue3s
-----END PGP SIGNATURE-----

--zk6atuhnwc7zlxxx--
