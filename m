Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20BDC33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 810B624673
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580147260;
	bh=nhUtDQVi49Sb7FeCHFaCFuQ1RDzA6HtDWI/yuoK+g+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RupdmS2vmIl05I/EGBdlCAht006nB/GHEOOskZqFv5yq/gHb27mAAM4QSOt2GYWvq
	 CvnWFy1Ii0Qa6tZDjX98yOymFM8E2mBufmGyPUEuzB99UUqhhFkZmtmVfunhoETom5
	 0tBllzISYVs0iy77ujs8eFbV9gIYraZfM+csRAOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgA0Rrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 12:47:39 -0500
Received: from foss.arm.com ([217.140.110.172]:47592 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgA0Rrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 12:47:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBF0231B;
        Mon, 27 Jan 2020 09:47:38 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6462C3F67D;
        Mon, 27 Jan 2020 09:47:37 -0800 (PST)
Date:   Mon, 27 Jan 2020 17:47:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-spi@vger.kernel.org, han.xu@nxp.com,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/5] spi: fspi: enable fspi on imx8qxp and imx8mm
Message-ID: <20200127174736.GE3763@sirena.org.uk>
References: <20200126140913.2139260-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="47eKBCiAZYFK5l32"
Content-Disposition: inline
In-Reply-To: <20200126140913.2139260-1-aford173@gmail.com>
X-Cookie: Hangover, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--47eKBCiAZYFK5l32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 26, 2020 at 08:09:08AM -0600, Adam Ford wrote:
> From: Han Xu <han.xu@nxp.com>
>=20
> Pull in this patch from NXP's upstream repo to
> enable fspi on imx8qxp and imx8mm
>=20
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Signed-off-by: Han Xu <han.xu@nxp.com>

If you're sending a patch from someone else your signoff is supposed to
go after theirs to show the chain of people who forwarded the patch.

--47eKBCiAZYFK5l32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4vIjcACgkQJNaLcl1U
h9A2iAf9E/LfcLBnilsSxkzczDqr1cpeIKWq/wymH+9z0UeY97TMIJB53KX8wO/U
MqeJv4vs1mbnFr9nTYm5Fwgbw+HzCpW/bzFRGQYZZIMc0ANudhUdpLMwUirsnGOo
YU/t5uPyi1TRJlh53nGXj9qFN5HhDBNbgT1wmGY6EzsqlSW0f4foJCR1qxoneyX7
1arf2u6JnQIe10iFkoOQAoSPs4iuoZ6P3MtUZolBL86j31R9GnC0IlWaZJJQrcbO
SCcgqGywY9mjN4aGc89RsKyMMPSIXoW1CCJ9NQC+Widz6IM6YIGI0OobQDKP+hSl
/88QWVJtZljwIHJ1jCETbEpXoJns+g==
=aRZ3
-----END PGP SIGNATURE-----

--47eKBCiAZYFK5l32--
