Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D95BC433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FB9C204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594943120;
	bh=WpG9Nz+vUXsNwnnFQo6kTLy37Q40YlIhwgs82GMReoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sKtMaabENaoFrFwECKOxZQh7o0jzFt0nXQu7yscMfP9PqJCKj4rCuzSgz1dxdnSPU
	 ash+/1ax956b5B3v1cikuKMElkHHWameDtnUqzNbkJQRzRJ8uIg1/CxRdNIvrsg6HZ
	 0F3lsat9Gn32k0NPJJ8yo2pvzszWac8XjaXbY5QU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgGPXpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:45:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbgGPXpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 19:45:17 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA8B8208A7;
        Thu, 16 Jul 2020 22:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594938609;
        bh=WpG9Nz+vUXsNwnnFQo6kTLy37Q40YlIhwgs82GMReoA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=beoOAfeRf8b/t27dYfPS7Rb7VXMa5PE7oMxXI/bN7PmvjrUBqI1xJDceo2wt+fu09
         a/hGt+le8EUrIV3u47mTbEsa+2pOxt4LMagSGCojrPCpbYyL/pP0WSEK6z2SdBdEFP
         bJq1/UdSbzdHgJ/huB+EfjrxNTZX2YzPJgXnoke4=
Date:   Thu, 16 Jul 2020 23:29:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     mnlife qiao <mnlife.qiao@gmail.com>
Cc:     lgirdwood@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        open list <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org, mnlife <mnlife@foxmail.com>
Subject: Re: [PATCH] ASoC: soc-jack: calling snd_soc_jack_report causes a
 null pointer access
Message-ID: <20200716222958.GA25428@sirena.org.uk>
References: <5f0e49da.1c69fb81.1ede7.a8fbSMTPIN_ADDED_MISSING@mx.google.com>
 <CAGjHXR2ExzMO3ntwzZy9QUhpuqe-VZAXOucNkXXZK+0XZcaQWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <CAGjHXR2ExzMO3ntwzZy9QUhpuqe-VZAXOucNkXXZK+0XZcaQWQ@mail.gmail.com>
X-Cookie: Yow!  I threw up on my window!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2020 at 08:24:04AM +0800, mnlife qiao wrote:
> When snd_soc_card_jack_new is not called or the call fails,
> calling this function causes a null pointer access

> --- a/sound/soc/soc-jack.c
> +++ b/sound/soc/soc-jack.c
> @@ -44,7 +44,7 @@ void snd_soc_jack_report(struct snd_soc_jack *jack, int=
 status, int mask)
> 	unsigned int sync =3D 0;
> 	int enable;
>=20
> -	if (!jack)
> +	if (!jack || !jack->jack)
> 		return;

I'm afraid this still won't apply - there's a text/html version of the
patch, in the text portion tabs have been converted into spaces and it
appears some other issues that mean git am can't understand it.

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8Q1OYACgkQJNaLcl1U
h9ARUgf+Mg9kwI/C/ZcV8nUJRP/ff392AISPJd5Xt5EZjYci1c9uk8JW9HhtNcdi
fWwj02+qZRaR8EWVlJUgLLQGLJ+rgm4dRdGkXzrYUXS4CCdeJVf4MPEmw6oMD76v
j+a7qx7btZnuspKbSQe8Lky4xN/cRd3QVW9axOsBiyn6PqiEmyHhO9TjjjrdckLA
TMOC+JtadYnmytwk4OkVu8KEaAVDcVPfKA3TklIx5fIA6mZoLBqqyN+hJmZS90z9
KWXGPnT8/Hxa3fQh4p1kWefphZ0K2Szd6T62EQw7YRczfoR6eeISfVun6Z8WYrTM
CqBHRH9jRWJquvn/0QAZKhyMBf7pFw==
=bQhM
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
