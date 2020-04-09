Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F93C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 10:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC548208FE
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 10:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586429286;
	bh=jEZcX4YrDUr4pT2asu7128wGhsFG02Fltk65Cf+xBlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YlAzrYcQrgR4mhAg9AKYN+euZlgQ/7McZ4gsLMaFNGX1jClmBLJWL4MbclatjnuSn
	 8vwcm/6LH7qyyWjQKaw7J4Qpt/kIyiB1N1B3POWr1qJkvQ/EM6MuV686K7nsvvi/6D
	 P3BlgrYtjkBm5vxz4Z9lv31V9tti42IsiccTDeyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgDIKsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 06:48:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbgDIKsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 06:48:05 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A19D220857;
        Thu,  9 Apr 2020 10:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586429285;
        bh=jEZcX4YrDUr4pT2asu7128wGhsFG02Fltk65Cf+xBlc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1rAHnDHGLDVCM0LlvBOEiBFDbmGYBsU4bqRLs9uKlCKMAr8xALrgNjHwoCsownzPb
         C/if4P8Wq7jqZ+lOHoMgU0SK7647XwfwHgclKqAO1alotZaOrs05+EuwLdKWCNaT5z
         HJzaf9HZcnWxhBTPBVIcm9WWXKDcJw3DswdMqAsk=
Date:   Thu, 9 Apr 2020 11:48:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     lee.jones@linaro.org, arnd@arndb.de, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] mfd: syscon: Add reg_update_bits() callback
 support
Message-ID: <20200409104802.GB5399@sirena.org.uk>
References: <cover.1586422035.git.baolin.wang7@gmail.com>
 <759f7471d03946ae273a06f7bcca8a54528ec08c.1586422035.git.baolin.wang7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Content-Disposition: inline
In-Reply-To: <759f7471d03946ae273a06f7bcca8a54528ec08c.1586422035.git.baolin.wang7@gmail.com>
X-Cookie: HUGH BEAUMONT died in 1982!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 09, 2020 at 04:57:57PM +0800, Baolin Wang wrote:

> --- a/include/linux/regmap.h
> +++ b/include/linux/regmap.h
> @@ -340,6 +340,8 @@ struct regmap_access_table {
>   *		  read operation on a bus such as SPI, I2C, etc. Most of the
>   *		  devices do not need this.
>   * @reg_write:	  Same as above for writing.
> + * @reg_update_bits: Optional, should only be provided for devices whose=
 update
> + *		     operation cannot be represented as read and write.
>   * @fast_io:	  Register IO is fast. Use a spinlock instead of a mutex
>   *	     	  to perform locking. This field is ignored if custom lock/unlo=
ck
>   *	     	  functions are used (see fields lock/unlock of struct regmap_c=
onfig).
> @@ -416,6 +418,8 @@ struct regmap_config {
> =20
>  	int (*reg_read)(void *context, unsigned int reg, unsigned int *val);
>  	int (*reg_write)(void *context, unsigned int reg, unsigned int val);
> +	int (*reg_update_bits)(void *context, unsigned int reg,
> +			       unsigned int mask, unsigned int val);

This is fine, we already have this operation for buses, but why is this
munged in with the MFD patch?

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6O/WEACgkQJNaLcl1U
h9DiMQf/dpfLN7c3XF5kRBzG0HDsE34XXT7rxqy8H4i6q+gpzHSo9JEKnaNs4FaI
wvRBE8knKzPgcQonqIgAQLsKcpNnFSrIGsEVD1tyyCO3kAOevMytSyZJEhQAWdHF
EMB9AhYxdKKEaT5roEWzIlHNR7PTt8o/jYN1FDA2bapv4hF8M3hlAKqwcZfHUExm
AzLV/g9SVVmN4PYLrrIX4o/PTMx6FyHg6GYuMn6Z3+x8a5e/Du1nCeVVCyb5s+XI
7/iUCSuIydQcUJUuA9IYeg9VofYdicMwiQ1pEV6yBa0cMkmnJfo2fkGwjb8KcUvE
+MTkCXqNQf/Yc51+1vspD7Umlly9uw==
=768M
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--
