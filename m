Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA227C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C4E20714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581423834;
	bh=woIIGHW54ULqE9ENJaryfMQcckwSF0JpI2ZwNL+u9yQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pvDasH1d7iZcMdUkO8BZT9LBU03g21t223cEZpdZYjlDNVMWd5oVbgRB4zEYSPxoz
	 1s3XfyAUx/4ghSdsefCR6dhsYFWkdDrWvjRqDO+OKtoLNgA85EM+Njeq2v2lI6w0jo
	 jaGHKu6tV4wVydjVgwKDm1pGCQB8zpF8DvpqdYfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgBKMXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:23:54 -0500
Received: from foss.arm.com ([217.140.110.172]:45028 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728540AbgBKMXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:23:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14B7D1FB;
        Tue, 11 Feb 2020 04:23:53 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DE723F6CF;
        Tue, 11 Feb 2020 04:23:52 -0800 (PST)
Date:   Tue, 11 Feb 2020 12:23:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?amVmZl9jaGFuZyjlvLXkuJbkvbMp?= <jeff_chang@richtek.com>
Cc:     Jeff Chang <richtek.jeff.chang@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: MT6660 update to 1.0.8_G
Message-ID: <20200211122351.GJ4543@sirena.org.uk>
References: <1580787697-3041-1-git-send-email-richtek.jeff.chang@gmail.com>
 <20200210185121.GC14166@sirena.org.uk>
 <a9895e583c9b47608aeb3e29d7852f47@ex1.rt.l>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1ou9v+QBCNysIXaH"
Content-Disposition: inline
In-Reply-To: <a9895e583c9b47608aeb3e29d7852f47@ex1.rt.l>
X-Cookie: Hire the morally handicapped.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1ou9v+QBCNysIXaH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2020 at 02:04:42AM +0000, jeff_chang(=E5=BC=B5=E4=B8=96=E4=
=BD=B3) wrote:

> What should I do is just apply them to be hard code into the driver? I ca=
nnot use event a table to descript it like below?
>=20
> static const struct codec_reg_val e4_reg_inits[] =3D {

Doing what you've got here is hard coding it in the driver.

--1ou9v+QBCNysIXaH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5CnNYACgkQJNaLcl1U
h9CmmAf/f2m+iY01h2zxveePh8kLV67hfAIacGMZXGLIzsnhrSXN/FwdW1get7dG
oG5R50Qosg/i9F2Ov0oqOGqJqtc039++uyXkbFR0gxSl5o7ixX5NlXLVRuqV/qWl
KSmiv4UWKiDVGLu3ITfwdwcLU/0mu1++10XgspK4ZDrexG2sXJAJ4rUN/ntD0nz0
utsW2B0LoZyU5bNQ7qoSPMWQaRWbzIoSYlupXIF9exiO6c+Qh3AL1NSHzwcrAOrp
px7Iu0pVaBC3lcaKw3IkDDcbSwzU+kGfl1WaMcQaHior5sQmZhrL1jlTXigvBLn0
8o8LXGIwL0xXh6O3XWKghL+taEW33w==
=twZR
-----END PGP SIGNATURE-----

--1ou9v+QBCNysIXaH--
