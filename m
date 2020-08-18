Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEA9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9E3F204EA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="TNhDrsR+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z4gCmEWJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgHYNmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:42:47 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:46361 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726570AbgHYNlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 09:41:40 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id D71A7C10;
        Tue, 25 Aug 2020 09:35:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 25 Aug 2020 09:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=/JRUPYnRLa2QMCNAdK0p5F/lGHS
        w/13qa1e91vLfa2U=; b=TNhDrsR+oMzM71Tv212Uq2yPrdhDxXPmPEa9DF1Resm
        IaJ8fT7PCS4hMLCMdJEHd/bxuhcSL4CERMLcv3U7NFiHov/LTrPtcuIGsF+fB0vF
        v5JVu4L06X4RgnQ7pGPqcRtOvo6+qsHOgDx4Pagx/AGEUixWDq/c1BjK2OfgEXwS
        5oUkvZLk6s7kODqqIInOi92S59KvlKG3tK5VMMZLzj2Q/FLU4Lb+Z4CYLBT4zjyY
        pR4PfCfs83uTZAsg1lVONF4x39OY5MQyBKRIf+b9noQlgAG00HQm2BPK0TG7gq5F
        pL/T5ebTRgi6k34tcIkxKg0z5D/SHilYRtWF8c7/XtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=/JRUPY
        nRLa2QMCNAdK0p5F/lGHSw/13qa1e91vLfa2U=; b=Z4gCmEWJjkycjCAUl4N+2X
        1tvAQ6vj/dYF8E1lfYX9B5jPl86vWnSncSgfjt5MIREOk+1yceNXK48ZKnvAW/oe
        8yvXt1+qtFjWx6BaF81PPGOhOtqx+vLuCRj5+j9AgwwqYyCaaemBGI0/x9eCJufJ
        0Rl6ypYst6WcAPkYl+52BWkGiPE8l4j+haLy1DIQlsvHUbaDb4237Es8Vj/xFkBJ
        TH5kRFsIHCoOofjdUfl8x8dJLDHL1rb4eDL0xczg+MPDtWE5uKIMgqYfuOK9DzTC
        XW4X/68mbtj3i7fOkyx22gSsX7YIoF4njGer7f2U071L8KIL2hCmK6KGN9nau4ig
        ==
X-ME-Sender: <xms:oRNFX3S5XzeWSETb2tPW9tuRHuV2BovB4BCfDOitIt8o1B4vQe6DZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvtddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:oRNFX4xKRmsDg59xI5K-OsajaUxdiKEtcRJYoImEf2b007dULH2z_w>
    <xmx:oRNFX83dV-xpqfoxlWj0vehFofnQaWEy7D5VFCs3LRGplKCy4WC90w>
    <xmx:oRNFX3AKjxbRmuAcAB_PQda4EEqN1YsVb8gof912D5I4qggXXIZY_A>
    <xmx:oRNFX8bzcu31Ak_zIJokZuct-UUfFnH8WZ6IlaeE8GY3CeKz4cD2mg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 113883060067;
        Tue, 25 Aug 2020 09:35:28 -0400 (EDT)
Date:   Tue, 18 Aug 2020 11:10:38 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: Mark timer as stopped in suspend
Message-ID: <20200818091038.uie3gxn7i74loho6@gilmour.lan>
References: <20200809021822.5285-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6lj3l6uq3mnmvdcg"
Content-Disposition: inline
In-Reply-To: <20200809021822.5285-1-samuel@sholland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6lj3l6uq3mnmvdcg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Sat, Aug 08, 2020 at 09:18:22PM -0500, Samuel Holland wrote:
> When possible, system firmware on 64-bit Allwinner platforms disables
> OSC24M during system suspend. Since this oscillator is the clock source
> for the ARM architectural timer, this causes the timer to stop counting.
> Therefore, the ARM architectural timer must not be marked as NONSTOP on
> these platforms, or the time will be wrong after system resume.
>=20
> Adding the arm,no-tick-in-suspend property forces the kernel to ignore
> the ARM architectural timer when calculating sleeptime; it falls back to
> reading the RTC. Note that this only affects deep suspend, not s2idle.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied, thanks!

I assume it affects all the SoCs with a Cortex-A7 as well?

Maxime

--6lj3l6uq3mnmvdcg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXzubDgAKCRDj7w1vZxhR
xfaWAQDnZwRS7XpoHeidnQOOdUYkTt6m+Is8lK6qswz3CJ3H3AD/bkPTIL8YJmR/
TYXu8yTTBp42sy7Dl2zcqs1H+JDybAQ=
=GC+Q
-----END PGP SIGNATURE-----

--6lj3l6uq3mnmvdcg--
