Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3B8C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07D7720748
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="XM/22yqT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R3TN3552"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbgIDJR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 05:17:57 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55319 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730040AbgIDJR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:17:56 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 88B625C00C0;
        Fri,  4 Sep 2020 05:17:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 04 Sep 2020 05:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=ZNvaM+CYXdQnUp+vb+XfGuigeWU
        mn2LideIG2s/TfsQ=; b=XM/22yqT5YHx6nsTiSiJVpKkcQQrCq9yoLbKDfGa2ls
        +7tgnULhUOJ08NBr5zw0Lnvx7IZ9CWQz4f5u6siv9xE7O6c3hbp8yUFGk46wHqww
        eE3gof/nqwK+krzu2Zp20QsCovUih1ukyaq1BGeD44OdC+fhV1ypYt2oEOr1sJnk
        c9wKRuyUs9Us8JBdjSJh13KBpZ2OyhxeD1q4q29jB8BH5oiLCEnQnNCkoXaNF7Fu
        xz0Pi/xUu5qRJBlA1xOsKRANaZRNmvPbt6jNF7bbkn/jyK5LlI6qnBGPxvShPqx5
        JWnUQwc4ABgksacSPVczllBDWJo0C6ceoH83erjQ8JA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ZNvaM+
        CYXdQnUp+vb+XfGuigeWUmn2LideIG2s/TfsQ=; b=R3TN3552rTIDUjWDQEtrA1
        6C441UyqEyXzY1TTZdOXf0S1wdpPlgvpx38/aeXCbCjfb6bDzIg04F2GXhs/4nIh
        mm8HLoefzj/jtru+CmQF0acWJ0woxECP9lKxOdT7iqX26132US/d55G4kjZTC/AM
        YJR27mHzYEd4znvgZfpcWfG4pe1UBW2aOFAtu4i01nlOIXk0n8JYyNTbW7D+lL8C
        aDvG+wbh7b40rLCNMh5JqHLOR7vCqmEVXUh9bUu5pv/AneKD2uwj4Dr1plK/FPA9
        npFEF07k7hP16H+Vd4m6YAswBFv3aamKdwzf3ozthR6jHtHD7eo1+Oidi8gJdZGg
        ==
X-ME-Sender: <xms:QwZSXwXr-iG4hRIl6KnmAOdFUkOLv6Mfl8zWFV-AHQk44R7Z2vm7fw>
    <xme:QwZSX0mrji0avk4tIZxgfX-vDfx6ZPuizeRcvNrFoBud4NQ2st8No1FOc5ztVVVDA
    VmfpCoxQOshtsNS1Dg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegfedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:QwZSX0bcTsDWpHmMMBlj_tA-w-C0djTvlXpXTQ2UmSgfXk9h7QHSLg>
    <xmx:QwZSX_UZ5sSSxy5rPFnUeG3DECeOGVZiUzWTtUNixbNvp3KB2b_krw>
    <xmx:QwZSX6nvajHCf5rMMSAr8ro6akeUpT1iRhyVevSnFv-1oRb_-bY8SQ>
    <xmx:QwZSX8WZDZ5k8q7EJemiVGe1zIevU7cLizMNXTC_KQHLewrzdXrREQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 27D203060057;
        Fri,  4 Sep 2020 05:17:55 -0400 (EDT)
Date:   Fri, 4 Sep 2020 11:17:54 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] ASoC: sun8i-codec: Manage module clock via DAPM
Message-ID: <20200904091754.gqwtj6hjhgrrbudv@gilmour.lan>
References: <20200831034852.18841-1-samuel@sholland.org>
 <20200831034852.18841-10-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="etloxsebhaa6d7ke"
Content-Disposition: inline
In-Reply-To: <20200831034852.18841-10-samuel@sholland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--etloxsebhaa6d7ke
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Aug 30, 2020 at 10:48:52PM -0500, Samuel Holland wrote:
> By representing the module clock as a DAPM widget, we ensure that the
> clock is only enabled when the module is actually in use, without
> additional code in runtime PM hooks.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--etloxsebhaa6d7ke
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX1IGQgAKCRDj7w1vZxhR
xZxKAQCD/2/1W2VmcevYTA04jhWila6rZ5bVzofOrsZMYXDQHwD/S/ajB67MRi9V
3WWmvc+1ekhwHjWMEwfNhM2J2VtZ1As=
=gijx
-----END PGP SIGNATURE-----

--etloxsebhaa6d7ke--
