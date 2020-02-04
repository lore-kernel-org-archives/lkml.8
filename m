Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A79C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD4E2051A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580814281;
	bh=vY3Qq+U7Jn5c6tt2grI3S9+S5kIDQYwY4zy6sNCZABs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xd+XaGReWHcWInaivD4/Tqdoq/Dg3tYhRK0XPilHZQW7b/Z/u6uwJ1NhIHfX0W4JJ
	 QWK6SwW9OUcT/oPbrltrAuj2/TyQOQcG8stasUgRDH21yNT1Ly0iWSkEH/nanhENBK
	 HYjBZ2kuIHnreVBYWrmvdUdMi5pPoCjVBSM6Tyho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgBDLEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 06:04:40 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58156 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgBDLEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 06:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vY3Qq+U7Jn5c6tt2grI3S9+S5kIDQYwY4zy6sNCZABs=; b=MOxQIAQicikK15Kj0qop8iY1C
        g5bDWw+WyvmkNNXYQWpVnXHKpJEIwDQ6I3XgKA3rkOAXFL3vmkmU8huVXdo1mghxMVl4cQmb4SiDZ
        Hh3CphlWzl3rDRmIPIUNYmR308WNmMF4KJTQafrd3OOTXo8qhBQXJw0qnU4Val6hZH09c=;
Received: from fw-tnat-cam2.arm.com ([217.140.106.50] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iyw0O-0007Ky-Je; Tue, 04 Feb 2020 11:04:32 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id EE06DD01A54; Tue,  4 Feb 2020 11:04:31 +0000 (GMT)
Date:   Tue, 4 Feb 2020 11:04:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     alsa-devel@alsa-project.org, sfr@canb.auug.org.au,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: wcd934x: Add missing COMMON_CLK dependency
Message-ID: <20200204110431.GC3897@sirena.org.uk>
References: <20200204102428.26021-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3m6ZAtymzEdXvUYk"
Content-Disposition: inline
In-Reply-To: <20200204102428.26021-1-srinivas.kandagatla@linaro.org>
X-Cookie: Programming is an unnatural act.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3m6ZAtymzEdXvUYk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 04, 2020 at 10:24:28AM +0000, Srinivas Kandagatla wrote:
> Looks like some platforms are not yet using COMMON CLK.
>=20
> PowerPC allyesconfig failed with below error in next

This doesn't apply against current code, please check and resend.

--3m6ZAtymzEdXvUYk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl45T78ACgkQJNaLcl1U
h9CV4gf8DoN1L+3ztg3WWNOFL83oV1ry1PG0ADTcRk9kGu6Bvgko4UJq906Df5Or
eptXPYaalkBhWiCTSb8BVHB4zyOCgMRqdOIBa6II2emQStrWOtbP5PEdMuPxuuie
1jMV5D3Tio6GZ/RWQmNhSEZrmizFtKqF9iLFGl21FIu3NtCvrPR7+8V1G8GUsoR8
UntEZCkHvy+QKycJgrZHrAlbRi7fguvG/dVHV7GsKLg9PKkobU1NGVXYfa5hqDTf
oi8gg1xK0Sparvh223uvCYST/QX/w3a+/dvWAJIqPcG0ke9hjtTUPfIxkZMT7W5U
GbzCVPWpVOvL3xQB2yyd5h+h3zH/5g==
=42ud
-----END PGP SIGNATURE-----

--3m6ZAtymzEdXvUYk--
