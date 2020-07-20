Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB97C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF21A20B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="DvcOMRPY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q9O851UY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgGTOLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:11:45 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:47837 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725934AbgGTOLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:11:44 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 5FBD35C014B;
        Mon, 20 Jul 2020 10:11:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 20 Jul 2020 10:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=prraTOjwRw0ez/AQwdcYRGL2HR1
        rZLnwK1FuDQttWNA=; b=DvcOMRPY+pJWNLOKoDY54i5Bn1HEpvxm7hABYr+fNIo
        VrqaK86jSXGpz7DOSuv/e4SRqQh6++L/4zAT8jRW6nXVPi9IkNDpLCZEBEUApW4Y
        T433UIRrDZv4oD29H3kutVL8hbIEvXRHlgxtjsgt4p9vvhBrnPvTrPPVLtSmys2O
        HtoQjDJ/RCsnyxSAUC+QPfanwy5+1xWnDthoEY9V4N9wusCXsaKxCkapKqvmM8SM
        APZrUc19myOo39SBIlRbYBovuR0K4IetbijVCo+Ek5KSZqLlEfsI3NJT/rO25Apg
        GpPzveoSISAOjrfZZYqvkUNRc6Ik0LwmRpHHOZTMHDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=prraTO
        jwRw0ez/AQwdcYRGL2HR1rZLnwK1FuDQttWNA=; b=q9O851UYlpvYofqSu04xWU
        POAsDzN7gJoZMDVTx9m1dD7SsMlHNjNF2EQ1lXBy1Uch2Bk5iJLbOLFBIl4OAIjz
        KvdKqy2ql3fTaYNDKupzLAnZRSaanE6rbLt0lEJN0wk/YTjpUO8KST5vy1moxGin
        51rtmnNj/w9c8P1PpBELGeEAgN4Evzb98OKEjlOz/jpPFPAvMyBYEGx2wYjqQpRM
        lUxp8GQcvNxVt/soyuS5LMV2v3AGI1Ww/YCaUnEheFVZ658ylAnBYW3xR7oziWev
        zb9lNv72i5l9kERvhp8Vme/W+VN9C/Bf2RSnjkEKvogzu21x3iMeYKPOmmkzjbQg
        ==
X-ME-Sender: <xms:HaYVX1h9FI_r4lr2KI8kCPef_--T1KqYltV7SHBrNWckQX15Cailyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrgeeggdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghr
    nhhordhtvggthheqnecuggftrfgrthhtvghrnhepleekgeehhfdutdeljefgleejffehff
    fgieejhffgueefhfdtveetgeehieehgedunecukfhppeeltddrkeelrdeikedrjeeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimh
    gvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:HaYVX6CKbHmnrMNbeKn4e0xcnTdEI1aUWsve5e2aGeNDcVbqSTLEsQ>
    <xmx:HaYVX1Eeo7r25FHA3VhyNK20DNrHylb0OBrJHS46uf-bdGgk9Lp4VA>
    <xmx:HaYVX6QaQHo_vad_gGj8dBPIinWpBoj2liB1Ss7NzJJA8z8VrIDHzA>
    <xmx:H6YVX99ay_N8V1Er25QFIOHWibIQP2G3SqcEfDxJHAcmAjqmHWSQjg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0FDF43280065;
        Mon, 20 Jul 2020 10:11:40 -0400 (EDT)
Date:   Mon, 20 Jul 2020 16:11:39 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] arm64: dts: allwinner: h5: Enable CPU DVFS
 (cpufreq)
Message-ID: <20200720141139.w3pgnoozqqfjhj3r@gilmour.lan>
References: <20200717160053.31191-1-wens@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ypd46vk4pvx5y2fo"
Content-Disposition: inline
In-Reply-To: <20200717160053.31191-1-wens@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ypd46vk4pvx5y2fo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 18, 2020 at 12:00:45AM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
>=20
> Hi everyone,
>=20
> This is v2 of my Allwinner H5 SoC cpufreq support series from way
> back [1]. The series enables DVFS for the CPU cores (aka cpufreq)
> on the Allwinner H5 SoC. The OPP table was taken from Armbian, with
> minor tweaks to the maximum voltage to account for slightly increased
> voltage on some of the boards.
>=20
> In this version, the OPP table and tie in to the CPU cores has been
> split out into a separate file, like what was done for the H6. The
> patches adding CPU regulator supplies for all the boards that I don't
> have have been removed. The series now only enables cpufreq for Libre
> Computer ALL-H3-CC and ALL-H5-CC, and Bananapi M2+ v1.2.
>=20
> For the original Bananapi M2+, if I add the fixed regulator with the
> enable pin, it ends up causing some sort of glitch or lock up on the
> v1.2, which includes the original dts file. Since I haven't been able
> to sort it out yet, I've left it out for now.
>=20
> Patch 1 assigns the CPU regulator supply to all the CPU cores on the
> Libre Computer ALL-H3-CC.
>=20
> Patch 2 assigns the CPU regulator supply to all the CPU cores on the
> Bananapi M2+ v1.2.
>=20
> Patch 3 fixes the voltages specified for the GPIO-controlled regulator
> on the Bananapi M2+ v1.2. The voltages are slightly higher than what
> was originally written.
>=20
> Patch 4 ties the CPU clock to the CPU cores.
>=20
> Patch 5 adds trip points and cooling maps to the CPU thermal zones.
>=20
> Patch 6 adds the OPP table, based on the one from Armbian.
>=20
> Patch 7 hooks up the CPU regulator supply for the Libre Computer
> ALL-H3-CC H5 variant, and by extension, the ALL-H5-CC.
>=20
> Patch 8 hooks up the CPU regulator supply for the Bananapi M2+ v1.2.

Applied all of them (and fixed the OPP node names in the patch 6)

Maxime

--ypd46vk4pvx5y2fo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXxWmGwAKCRDj7w1vZxhR
xbADAQDypKO/+2UXD6CXAqQv1jmyMM0AyMRN0DCiYMXR765BXgD/Y04IeT/7Iix5
tiaIRU+WePHpysLDKYAZ4XfY+/t0qAk=
=bJbC
-----END PGP SIGNATURE-----

--ypd46vk4pvx5y2fo--
