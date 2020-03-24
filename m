Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2A1C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14A220774
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="O/2P9cnc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G0py85zP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgCXPuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:50:32 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55529 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726915AbgCXPub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:50:31 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 4A0815C01B1;
        Tue, 24 Mar 2020 11:50:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 24 Mar 2020 11:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=0Pu6HeLGr4uD+zkjxE9sHKczNd6
        ZBYS3wZrKUtICS4c=; b=O/2P9cncGMHR3/iVHph7f5JHAMbpIKmR8PDg0jEKoYO
        UQXd4cJmeI8oSj2Ax2UE43i+sxLSzCUn/mKlopSMX5B4MNAMOgNyRqDlGV0Mz5+c
        1rrwW4InKYPjM+U80IYFcmlNriH3iWRCOmCZkZOgxo4hDiMlIENQmjAy8JgcQdFR
        ccgTis6NUar4stMS+80cuVUtYV59dk8XJg5nFuJAYntLYQiDsSBfljGx2clV8Kkj
        OArdTSlcD2JlddGLoDRaDH3Mf5Ov7Z7TusggmyiYpc8MiDCLJ2O55jKBpTZGET73
        VS3fYShFmDeBj9cWBeRnf3N/7XV6Heg0rTIah86Rkew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=0Pu6He
        LGr4uD+zkjxE9sHKczNd6ZBYS3wZrKUtICS4c=; b=G0py85zP/R+q7eeXbXLFSB
        bhA+l/ByNpPYszKXgXcXySnBZPyT2Kwskpp3SmRB7pSojncTvsq1UC0OmeuQp9FD
        pSTT3cTbGi/JGOTIcfs9aSiBUL25THbFN6YPRQttBRnDyy9ObKfpv1Np6RsQths8
        8tASQlcQej015l1nKkOAy2vg4kkefEpVpT+16AGlbWhE6/ql8evXICpO5hZkq+BO
        sP9Sa9u9xjU8BfoZvzigv/aGi5ONAeQqBivKUYSpuCczcxFOtM6bWeONHFPMv7I9
        I+yJ1Smh99giMMu6j1FHjr7U9uO/ag59r2Ca85asSvVH91f61Mm9JRjkI1RpC85A
        ==
X-ME-Sender: <xms:RSx6XtpCEMWc7fF82phOUnsZuBZykBayfx4CRDz2EYX50OZ_DLCSoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudehuddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
    drkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:RSx6XutNXb9Z4FNRSsdyrOiTh1S89k_MsnhznGympRzMcSLpw6N_Ew>
    <xmx:RSx6XgYN7IB4g6thHrGs_FirKgMaE4FBNBn_XrStpLWTZqexWnmTZA>
    <xmx:RSx6XlYNpqIiGEZQ-paGpCME8mOoIJMnkEULbhFq8pYI2gatKMTORg>
    <xmx:Rix6XlRlRRebrKt8Emc0WxGu755Edrxb11l-5bQT1t_2ZM2TkKikxQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3B6843065273;
        Tue, 24 Mar 2020 11:50:29 -0400 (EDT)
Date:   Tue, 24 Mar 2020 16:50:28 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Stefan Mavrodiev <stefan@olimex.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 0/2] Add A20-OLinuXino-LIME-eMMC
Message-ID: <20200324155028.u3shfffoetuqii4x@gilmour.lan>
References: <20200321075757.15853-1-stefan@olimex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kqrycw6rh2fpqmts"
Content-Disposition: inline
In-Reply-To: <20200321075757.15853-1-stefan@olimex.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kqrycw6rh2fpqmts
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 21, 2020 at 09:57:55AM +0200, Stefan Mavrodiev wrote:
> The board is the same as A20-OLinuXino-LIME with added eMMC chip. So the
> dts is almost identical with A20-OLinuXino-LIME2.
>
> This patch series adds a new dts file and appends the bindings
> documentation.

Queued for 5.8, thanks!
Maxime

--kqrycw6rh2fpqmts
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXnosRAAKCRDj7w1vZxhR
xZN+AP9ijoVWA3V+WNmKTAKulfQEX3zkDy8h3UZ+xROn8wVLUAEA4IARh9UJTMFG
Jyj0Lesrd9XoLwHm+hDZK/4dROMZHws=
=ej6K
-----END PGP SIGNATURE-----

--kqrycw6rh2fpqmts--
