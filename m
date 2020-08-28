Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3925AC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B03F2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Vozv8aET";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WW3lPhXU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbgH1KuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 06:50:06 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:59503 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728362AbgH1Ktx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 06:49:53 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id A6035580587;
        Fri, 28 Aug 2020 06:49:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 28 Aug 2020 06:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=VtuzJ97VVsG3s9xSqH164E5SJoT
        +rY8ff3DHViPD1PI=; b=Vozv8aET6hkYKrEPdb/7OVUKbM2nH6HAv6Yyq5G8xOY
        EZGPjeE7T4VPUJetB1DFsNAyl7zfyPkpxDEsj0eedPwfJTWwb452cWfUEm2VLDXp
        Bv8VxsRnbWY5EfffptUa+S/CzAGR5i8PbLBRsDKF1ea8tXIhkvFYTj3DT8ZvXOCM
        RALkvKKJaycbbBo5ASosQIFIbm+9TgI1peq9Xj7JID6g7vvOYfkiYaWVqtVkdPSS
        GsEgdghoPAOXg8UQPhG0A+nxZYNq9HiFqE3qfU6ZVlrRfiue5lJBB7Of/v81uu2B
        DduyRZwaKzo4VOkN5PpEywph9KJV2nz1NojC9mPs5bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=VtuzJ9
        7VVsG3s9xSqH164E5SJoT+rY8ff3DHViPD1PI=; b=WW3lPhXU34aIyvZ/6Of4yB
        TCD435sw0/iEpLBxnEnlkzQWQthOGqd9SybhOQMLSuunjA7zxwXbobfX1pkT3pJi
        xrfh/wEF44sTwS0U/nqhJf9f7P/UzxaR//fUVcsVzNz5nbe28NSz4klZAspPDT1d
        urv7ywgQxlmN9otdg0JC4wljaMxBOGJxT4sezwPmNfO1/I2zNKkbisAPJuyADX+S
        Tviy7nO4uH5h8HBMOGS/E4oQ5VzZVREh2bSPsrmBuuFfU9Jut31sIJra4bEsvnEg
        JC53vnSNUY5rqZw8bzoZnn8U+AdVctwVQT4qvZXe+/lyFGxWKc7L3E3n42swKBGQ
        ==
X-ME-Sender: <xms:TuFIX-Nkm23jogQTjpLvEvjy3ZmWcMTWo4U4S8k8nSZL69AYsUS18g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvjedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:TuFIX88CCGvzHU3tvY9WQ4BV1RQ4Ev_xCXisSaOgerLE1Z6vVRpjMQ>
    <xmx:TuFIX1SEI9UADz-KsxytxCxThchCSt3ZPhsnO0uMOcbmDjsvfY83EQ>
    <xmx:TuFIX-s7VsMHIWCPpqeh1Jwvsfp9FS7mvZzFivhkPecp9dHIQbp71Q>
    <xmx:T-FIX3UjdOEP5w-yE91lgpQqsGdwwSdwXBIuJscXYc7axoFX7P8fQw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id F0E1B3280060;
        Fri, 28 Aug 2020 06:49:49 -0400 (EDT)
Date:   Fri, 28 Aug 2020 12:49:48 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ondrej Jirman <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Allwinner A64 digital audio codec fixes
Message-ID: <20200828104948.sdq2ftwiwyjhh3lc@gilmour.lan>
References: <20200726012557.38282-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yat6lg3ldh2xkhmw"
Content-Disposition: inline
In-Reply-To: <20200726012557.38282-1-samuel@sholland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yat6lg3ldh2xkhmw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 25, 2020 at 08:25:50PM -0500, Samuel Holland wrote:
> This series fixes a couple of issues with the digital audio codec in the
> Allwinner A64 SoC:
>   1) Left/right channels were swapped when playing/recording audio
>   2) DAPM topology was wrong, breaking some kcontrols
>=20
> This is the minimum set of changes necessary to fix these issues in a
> backward-compatible way. For that reason, some DAPM widgets still have
> incorrect or confusing names; those and other issues will be fixed in
> later patch sets.
>=20
> Samuel Holland (7):
>   ASoC: dt-bindings: Add a new compatible for the A64 codec
>   ASoC: sun8i-codec: Fix DAPM to match the hardware topology
>   ASoC: sun8i-codec: Add missing mixer routes
>   ASoC: sun8i-codec: Add a quirk for LRCK inversion
>   ARM: dts: sun8i: a33: Update codec widget names
>   arm64: dts: allwinner: a64: Update codec widget names
>   arm64: dts: allwinner: a64: Update the audio codec compatible

Applied patcehs 5-7

Maxime

--yat6lg3ldh2xkhmw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX0jhTAAKCRDj7w1vZxhR
xZqWAP9GxoV0XxQnuXpla7KwCEoiiBC9jsLVHXrAH8rtQoc2PwD/eELvNUMYy0wh
D/rC/j6ImujUJPGQcP5cCV1lOoISLA8=
=Pxl4
-----END PGP SIGNATURE-----

--yat6lg3ldh2xkhmw--
