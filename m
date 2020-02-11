Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06FAC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B3F20848
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="hKmAjTBX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gIhFm9Xi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbgBKNPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:15:21 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:53937 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727111AbgBKNPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:15:20 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 0909921EA0;
        Tue, 11 Feb 2020 08:15:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 11 Feb 2020 08:15:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=yVbF4foO66tk7oEeIZR06TCxnf1
        3LrD2gieXWTmEk58=; b=hKmAjTBXoWv8ggoLwqIkUnMixNGduzTFn21ZswnJhUa
        z+1DqpcqcHLWxgK6F+3867zPX8POVpXOhyTEo/lcCk9usWjm5C5cteHYssLRzP4C
        bPxovzgavQdac8m58EgdnrF4eAakUmtVbS+k8nES8UtTOz5CPcJux/NsOrxdGaVS
        C7P4BRjPkHFKdwMqr1Hf2rBsUoSUCUmMG1ZtJDLSIG1y9V8lOx0TEcFks+yHxnOM
        28u2BjE5K1UDeWG2AgmbcnO/RPLsryHotd3UJygT9oFWh3nTPEE99LWIXi1Tw88J
        cvp2npUYVy0tlosmd4j+Xgmw+Y62RWCUz6MMEranCCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=yVbF4f
        oO66tk7oEeIZR06TCxnf13LrD2gieXWTmEk58=; b=gIhFm9XiUnebwgiYXxOpWX
        D7HNOLc7o6JYZFsqgCSx9xn2IRLnXOJ1hVS06WJG5Qi+4gCO8IHuY2gKJff84FRb
        5LINOtjQjPFx1Ap6X8OzfGCy+eVBkUCJywzU3FBico/lwbC3/WFFWB6GNmeWt3rW
        Gl2mHgO0/m43JWJmqD0dEf+Q8RxvRnWbNUlbHgn0ySu7J4U1so8l/N/0GeK9jt04
        Z6d5lb+2C5qeRglr3Aseej/cSLZYuua0sEepM1FGYGjbkfjwobwmIHCD6MaWtR7z
        i1g46joV1zoYXsFEnv4CPvGoL/oPGBEqEPw1u5g11hGW/PB48W7CRMe1iWBdQmsw
        ==
X-ME-Sender: <xms:56hCXuXm5x3tnIdlJ6s7AKnllRyQK2bCQ8vmioT38WT8oYgJ43zonQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrieefgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghr
    nhhordhtvggthheqnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordht
    vggthh
X-ME-Proxy: <xmx:56hCXhnOeelM6FcFMTvflb8y_yCKu7ngWrHGo-3WS4EzhjfeJBjLQQ>
    <xmx:56hCXnZE_fIIGzrNsQYswC4AqbxZVVKHjgfV7YqMCadk6yu6EQ0KMQ>
    <xmx:56hCXkM4QEvJB6fZ76eL0p61uWd8Kj7uxm-bzyjRcZjvi02EY3SbMg>
    <xmx:6KhCXknONb451L3j89kWYt0UEBctt0bMeMauzUHGu1_fmvsIaSQ3JA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 128433280062;
        Tue, 11 Feb 2020 08:15:18 -0500 (EST)
Date:   Tue, 11 Feb 2020 14:15:17 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     agriveaux@deutnet.info
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sun5i: Add dts for inet86v_rev2
Message-ID: <20200211131517.e7lpjtz2njekadee@gilmour.lan>
References: <20200210103552.3210406-1-agriveaux@deutnet.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="exjtvn6out2zqnif"
Content-Disposition: inline
In-Reply-To: <20200210103552.3210406-1-agriveaux@deutnet.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--exjtvn6out2zqnif
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 10, 2020 at 11:35:52AM +0100, agriveaux@deutnet.info wrote:
> From: Alexandre GRIVEAUX <agriveaux@deutnet.info>
>
> Add Inet 86V Rev 2 support, based upon Inet 86VS.
>
> Missing things:
> - Accelerometer (MXC6225X)
> - Touchpanel (Sitronix SL1536)
> - Nand (29F32G08CBACA)
> - Camera (HCWY0308)
>
> Signed-off-by: Alexandre GRIVEAUX <agriveaux@deutnet.info>

Please read the documentation I sent you yesterday. In particular,
when submitting multiple versions, you should remove have the version
number in the title and a changelog.

Also, please ask questions if you're unsure about something, or
discuss something you do not agree with instead of ignoring the
comment.

Maxime

--exjtvn6out2zqnif
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXkKo5QAKCRDj7w1vZxhR
xSq1AP9Ki+pyoW9cDq2noR16u9LyNomV39YK3+wRQ6m3F2eQHAD/UNkPJcRNzZS8
yH+3zSrdbi9oP5vhChFBgilvZToV3Qs=
=lf/Y
-----END PGP SIGNATURE-----

--exjtvn6out2zqnif--
