Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69F4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 12:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C161120B80
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 12:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="RipJvTN4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tp0tdt6/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgGCMRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 08:17:14 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:43557 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725984AbgGCMRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 08:17:13 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id CBC44580B40;
        Fri,  3 Jul 2020 08:17:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 03 Jul 2020 08:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=rTAW5gwN1+eRVhnOurD7jQuXi4p
        UqbQePveppBGQdEw=; b=RipJvTN4fMIJGnPXzaFbH2xdYeXlEM/TLctg/+dGVFw
        hUE2Yj8IAutcexKEPxJj4fDjPLfOU6p6cR28VWPmXRUY7l3UcT3kIWwphonjaL8A
        Qks3wiMJHd3qDBq0BOGkOpdiJr5GAm7SADf+i9Aub45Rr2xFm3CExJX0DYFd4Y6x
        S1xVHZt/yDDmkWzhBDnpIHeoeoq4UrVcut4evC6/F4NzpePePCjC7sGRGNeBTSU8
        ZU6y4zriP90AyZPumw4zEmArRs/wpGrV+x0YR1nowyno6HDdx6Z4vEvMlK4Xqvdc
        UUrzm39uGrUysaBPACcEisxuVMFjGqDsc0nFveOlXxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=rTAW5g
        wN1+eRVhnOurD7jQuXi4pUqbQePveppBGQdEw=; b=tp0tdt6/H2GLCGlRnPCcSP
        8rqvOJRVFL4dpHscL4XPeQNuA8C+Ik+UI48jSjPz2fbdb3ieehNukO29NdP5a5Gw
        DOEqTWwlVCLYr7AVDcAnDO/2qqCaA9/rybp0a2AMSkH6e6Nh1iRQ9a/SM330IvAK
        z3pYZi/FLNFXXD3dktC7sR43Uhb1hD6UrI0S15ZUwMkxk+hiqrPd6LAKWDPB/1FV
        I8YxfhdfNw7TPuDeBOii2ef/YlhAMnRkiKY7St5GaLdzfAua8hxkfO3ngQ8CtJS3
        bRQKD4ks/EWjr7loPth7ntGGuqnyH0qrBcOP3rE+kODCYLtar45LqQnAicFI17UA
        ==
X-ME-Sender: <xms:xCH_XpjujNdZw9ynwVpavu_25HyW7GdCPcx8nxWSGBfMuas_vkVtNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrtdeigdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:xCH_XuBCdHEGYbUJDSlkZD4IpyOL-G6J86mquzuvVEX1lu2v7MKOZA>
    <xmx:xCH_XpERdqBFHoRf_K8JqMBhBNlTXBiJs636znioMFvF3nHP9DXl_Q>
    <xmx:xCH_XuQsnZqfvfktYxQOBio_oBvNGbBlctzeJ21umTMIn5BqRzBEyw>
    <xmx:xyH_XlmAgDeTfR89SNC-x3NNHz0TRSJ1B5vFcyRh8gMQ0922L-O51A>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2A6DF306006D;
        Fri,  3 Jul 2020 08:17:08 -0400 (EDT)
Date:   Fri, 3 Jul 2020 14:17:06 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Ondrej Jirman <megous@megous.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v8 2/2] arm64: dts: sun50i-a64-pinephone: Add touchscreen
 support
Message-ID: <20200703121706.gf2yxfe7crleatlm@gilmour.lan>
References: <20200702081432.1727696-1-megous@megous.com>
 <20200702081432.1727696-3-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cxgywaqrrd6jmrsp"
Content-Disposition: inline
In-Reply-To: <20200702081432.1727696-3-megous@megous.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cxgywaqrrd6jmrsp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 02, 2020 at 10:14:32AM +0200, Ondrej Jirman wrote:
> Pinephone has a Goodix GT917S capacitive touchscreen controller on
> I2C0 bus. Add support for it.
>=20
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../dts/allwinner/sun50i-a64-pinephone.dtsi   | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/ar=
ch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> index a89425ad3727..5c7386566053 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> @@ -121,6 +121,25 @@ &ehci1 {
>  	status =3D "okay";
>  };
> =20
> +&i2c0 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&i2c0_pins>;
> +	status =3D "okay";

I didn't spot this earlier, but the pinctrl properties are already set
in the DTSI. I've removed them while applying the patch.

Thanks!
Maxime

--cxgywaqrrd6jmrsp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXv8hwQAKCRDj7w1vZxhR
xZHoAQDeaPm5c6iWX8CcvBcL8Vrae7EAun13r2RrsQbElBt06AD/RGPN7dt9hGp8
nvnWM3MC/4nwVVPKFdGRLOiTy6Tg1AI=
=+CVs
-----END PGP SIGNATURE-----

--cxgywaqrrd6jmrsp--
