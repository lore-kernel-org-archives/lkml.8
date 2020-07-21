Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFC4C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D28AC20792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbgGULu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:50:56 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:53286 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgGULu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:50:56 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 7AE771C0BE5; Tue, 21 Jul 2020 13:50:53 +0200 (CEST)
Date:   Tue, 21 Jul 2020 13:50:53 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 4.19 123/133] thermal/drivers/cpufreq_cooling: Fix wrong
 frequency converted from power
Message-ID: <20200721115053.GD17778@duo.ucw.cz>
References: <20200720152803.732195882@linuxfoundation.org>
 <20200720152809.664822211@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k4f25fnPtRuIRUb3"
Content-Disposition: inline
In-Reply-To: <20200720152809.664822211@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k4f25fnPtRuIRUb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Finley Xiao <finley.xiao@rock-chips.com>
>=20
> commit 371a3bc79c11b707d7a1b7a2c938dc3cc042fffb upstream.
>=20
> The function cpu_power_to_freq is used to find a frequency and set the
> cooling device to consume at most the power to be converted. For example,
> if the power to be converted is 80mW, and the em table is as follow.
> struct em_cap_state table[] =3D {
> 	/* KHz     mW */
> 	{ 1008000, 36, 0 },
> 	{ 1200000, 49, 0 },
> 	{ 1296000, 59, 0 },
> 	{ 1416000, 72, 0 },
> 	{ 1512000, 86, 0 },
> };
> The target frequency should be 1416000KHz, not 1512000KHz.

It is possible that table is always sorted in the opposite direction
in 4.19...

@@ -86,7 +72,7 @@ struct cpufreq_cooling_device {
-       struct freq_table *freq_table;  /* In descending order */

(This was changed by a4e893e802e6a807df2e2f3f660f7399bc7e104e).

> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -278,11 +278,11 @@ static u32 cpu_power_to_freq(struct cpuf
>  	int i;
>  	struct freq_table *freq_table =3D cpufreq_cdev->freq_table;
> =20
> -	for (i =3D 1; i <=3D cpufreq_cdev->max_level; i++)
> -		if (power > freq_table[i].power)
> +	for (i =3D 0; i < cpufreq_cdev->max_level; i++)
> +		if (power >=3D freq_table[i].power)
>  			break;
> =20
> -	return freq_table[i - 1].frequency;
> +	return freq_table[i].frequency;
>  }

In that case the patch makes some sense.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--k4f25fnPtRuIRUb3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXxbWnQAKCRAw5/Bqldv6
8q/RAJ9Sry87gkY8fVH9iRr2xhJEx8reGACdEQYdzu8cHPwsttl2CUMAY98gKIo=
=+M6z
-----END PGP SIGNATURE-----

--k4f25fnPtRuIRUb3--
