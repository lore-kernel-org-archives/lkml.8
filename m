Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BE8C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 12:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA39620863
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 12:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583238805;
	bh=2rCSLxe62hKFmu9Wq3m9gb95gGynLEiWwhZ3yjr9GzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tp0JRCPYoyVrf83nRq+qIsalOaXGPD5NTQwh3KTq3WsdpWoQpqjACfuLyNGRZXS8d
	 FB+hmihHPe1pdXPnXjRWJwPVm8qHPxy/uhrFFKwfX7rhDvwfRSV1Fkw6hkWLXfeJy8
	 ecvPtkA0eN803r+GFfVfZqEdr5pjLwx7bmfLPrkE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbgCCMdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 07:33:24 -0500
Received: from foss.arm.com ([217.140.110.172]:46406 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbgCCMdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 07:33:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8B93FEC;
        Tue,  3 Mar 2020 04:33:23 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A66D3F534;
        Tue,  3 Mar 2020 04:33:23 -0800 (PST)
Date:   Tue, 3 Mar 2020 12:33:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ASoc: amd: use correct format specifier for a long
 int
Message-ID: <20200303123321.GC3866@sirena.org.uk>
References: <20200303103903.9259-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JgQwtEuHJzHdouWu"
Content-Disposition: inline
In-Reply-To: <20200303103903.9259-1-colin.king@canonical.com>
X-Cookie: Drilling for oil is boring.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 03, 2020 at 10:39:03AM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Currently the format specifier %d is being used for a long int. Fix
> the by using %ld instead.

Someone already sent a fix for this.

--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5eTpEACgkQJNaLcl1U
h9AKuQf/U01aci745PIHD/iQ86xIE2c0Ph5wIDFYgVS45kaTlPwBGX6iX72t/5tT
/BesrakIoU6wHxO5wNQst+QuxCauSfQTqwuqtA4k4P/sizM7M5NPcoxeM/uECmGf
Z91qqtfZq492X6yWceLwhCt9SA+5xzJ1bKdeETaOGaiJ594qhD/4+22WjhuibSF5
FHcllXvFPVKZCVGB0QOAVtUpBK0NQfRBsjshPlNLwMsop+dXJSfI3YhrhiIq5+sS
41UM1RDsJu3jGE6Lld3dBl5BgUdxR5yxudSuCqPtliEYnKyINev6qqWrrGoiwZ4B
SbuwgxiOqB11TS0lW97afaTVtdAETQ==
=tEk3
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--
