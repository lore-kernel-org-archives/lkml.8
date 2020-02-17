Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12E6C34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5CB20801
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581951732;
	bh=i3w6j1ZUqa4zQcrNEJCoUxstV7rhZ/PlDo4HaCcOZYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=arjtNy0iGG8erLymW2FBHgamnHeW5ekbRV6Jg94CKaaiT2SvT9FELHXKS3Cpx7r9r
	 VhmWxc3qZARzbkphrNNX/P8oOscV1cmpf32qNFg7gARX5RXVfmoUkrptavInVG7e3R
	 woYAQxLP1JmQBhoOYDvkogdz5kpVg7/1HfyE3XyU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbgBQPCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:02:11 -0500
Received: from foss.arm.com ([217.140.110.172]:36896 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729315AbgBQPCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:02:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CD3730E;
        Mon, 17 Feb 2020 07:02:10 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FF8C3F703;
        Mon, 17 Feb 2020 07:02:09 -0800 (PST)
Date:   Mon, 17 Feb 2020 15:02:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        =?iso-8859-1?Q?Myl=E8ne?= Josserand 
        <mylene.josserand@free-electrons.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [RFC PATCH 05/34] ASoC: sun8i-codec: Remove incorrect
 SND_SOC_DAIFMT_DSP_B
Message-ID: <20200217150208.GG9304@sirena.org.uk>
References: <20200217064250.15516-1-samuel@sholland.org>
 <20200217064250.15516-6-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xjyYRNSh/RebjC6o"
Content-Disposition: inline
In-Reply-To: <20200217064250.15516-6-samuel@sholland.org>
X-Cookie: There was a phone call for you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xjyYRNSh/RebjC6o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2020 at 12:42:21AM -0600, Samuel Holland wrote:
> DSP_A and DSP_B are not interchangeable. The timing used by the codec in
> DSP mode is consistent with DSP_A. This is verified with an EG25-G modem
> connected to AIF2, as well as by comparing with the BSP driver.
>=20
> Remove the DSP_B option, as it is not supported by the hardware.
>=20
> Cc: stable@kernel.org
> Fixes: 36c684936fae ("ASoC: Add sun8i digital audio codec")

This can only break things for existing systems using stable, if they
haven't noticed a problem with DSP B they'll certainly notice failing to
set up the DAI at all without it.

--xjyYRNSh/RebjC6o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5Kqu8ACgkQJNaLcl1U
h9BrrQf8Cpji+kb3X7isTpniyau/SbCQwZlUb8Csww/ottxImXAngZtFxVJ223Tb
sRxaUEFcUFbKuAx1BOMaW70RQ6qQskiNlrtvd2GxnKYNpGcSk6TsMHY185iiTu2s
EeozYIThsqRXhDCrv0hRArGLf5kBFM1OaSm9idhJJgfY8gjO+aBsPJqz8mp0gxWN
3jGVVLz7aNTaOxwTl6CcTvMm+7xj4f1tsYTkC7jYTysRVrf6rXkV9KBL7euDjMrg
JTa3RdwK0VAKZus8KiAecYZfI5K+F8Kj8Stk4R9GtMpIbVDR4Sxy5giVnrY+XVoF
hq2TJ94ZfIBzhexsmd+tDPsvUDHHtQ==
=eNti
-----END PGP SIGNATURE-----

--xjyYRNSh/RebjC6o--
