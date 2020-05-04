Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7EFC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EE5B206D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588614959;
	bh=7AASLHxv2Rby4dstXR1mZull2LY1/sl46uo96ENxXog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qY12Ts4wRE4R6dGG7JpOiKw9zgAXhhSb+AWrBvshEIjKm4LsTKwIBo9E1ifOkB8+x
	 Nc/cgW41JZSp+m2+UWaghPZ7UAdW8QwYfyV94ip4E5Nm8NtnJfPJvek4T0L16Kp95g
	 bbb1yPui9etZfWEZc5/sUmIS7X+RR3MOg0peCzlU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730530AbgEDRz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:55:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729386AbgEDRz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:55:58 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40165206B8;
        Mon,  4 May 2020 17:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588614957;
        bh=7AASLHxv2Rby4dstXR1mZull2LY1/sl46uo96ENxXog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T/4b4jqaWekrwSnAOxrrDnnsqhQdyBbqnCTaU4oZvRIk1eLfkoYWFZ1ih5QvyBaPn
         /XDMyxX07GqjYgR0nbxYkb7arLT1aQCJjt4ADoIePOJItfhJ06Z1Gf3LlyxSV+FfeV
         FizZRIenSvfWO2jknmk2ojaBVX7K1p8zWc+VBTk0=
Date:   Mon, 4 May 2020 18:55:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com,
        lgirdwood@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, digetx@gmail.com,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, sharadg@nvidia.com,
        mkumard@nvidia.com, viswanathl@nvidia.com, rlokhande@nvidia.com,
        dramesh@nvidia.com, atalambedu@nvidia.com, nwartikar@nvidia.com,
        swarren@nvidia.com, nicoleotsuka@gmail.com
Subject: Re: [RFC] DPCM for Tegra
Message-ID: <20200504175555.GG5491@sirena.org.uk>
References: <1588250483-10014-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ahP6B03r4gLOj5uD"
Content-Disposition: inline
In-Reply-To: <1588250483-10014-1-git-send-email-spujar@nvidia.com>
X-Cookie: My life is a patio of fun!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ahP6B03r4gLOj5uD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2020 at 06:11:23PM +0530, Sameer Pujar wrote:

>  a) Can I use a DAPM Mux control to activate a BE path? This in turn can
>     program required switch in XBAR.

If it works then sure, that seems sensible.

>  b) I have modelled SFC and MIXER as backends. Is this allowed?
>=20
>     This was done to include SFC or MIXER HW components as part of the
>     sound card and use like below in one of the audio use cases.
> =20
>     ADMAIF1(FE) --> SFC(BE1) --> I2S(BE2) ... OR
>     ADMAIF2(FE) --> SFC(BE1) --> I2S(BE2) ...

This is the sort of setup that'd be a lot happier using a component
model.

>     I used following workaround to connect multiple BE components.
>     With this I can see PCM callbacks happen for all BE DAIs along the DA=
PM
>     path. The obective was to connect multiple components together and (a)
>     was used to connect one component to another. Each "-->" here connects
>     two components and it is a switch in XBAR.=20

This doesn't strike me as something that's likely to be robust but given
that that applies to DPCM in general so long as it doesn't break anyone
else's existing stuff I guess it should be viable, it's not like there
are actually good options that you could use currently.  It's really
hard to get enthusiastic about it though.

>  c) Hostless mode did NOT work:
>      - Following audio path was intended to be tested:
>        I2S1 --> SFC --> I2S2

>      - [3] offers two options:
>          * CODEC<->CODEC: If I were to use a separate DAI link for each B=
E to BE
>            connection, then it will result in a similar design what we ha=
ve
>            currently.

This is more in line with components so will probably be easier going
forwards.

>          * Hostless: I did not come across references for this.
>            (Any references in this regard will be helpful)

Not sure anyone has ever done this with DPCM, could be wrong though.

> May be the current Tegra ASoC design is more suitable for component model=
 as you
> had previously mentioned. I wanted to understand if above, especially (a)=
 and (b),
> are acceptable in this regard or if there are better options to interconn=
ect
> multiple ASoC components.

In general most systems would be happier with components but yeah, I
think that's particularly the case for something as powerful and
flexible as your hardware seems to be.

--ahP6B03r4gLOj5uD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6wVyoACgkQJNaLcl1U
h9BsCQf+NDpQnXUKOhrp8OMCAs73chnv7fTrNscXnf0V+rnrqqSC7b6d0Q2tz3QL
8HYzl1AiMtRaAmybm98BhWpdUWXMGTKdYMBM7uKX2r+uVkm6oWhhK+EST6fOMv3k
ZvgRM35+2mIXUrSR5b62uPIi8O3mtbLuFkPb3oWkw/hT0jQm4MPKl/c6h3f9e2qb
FY8yrgExhRQkp+NAKMSNKV4gEZbViEJG5M9w879aEjQdWWhJ4tqo2s2QQXZmg5p2
x/uNk6mgWU+edW21BN78iaOB8urYcnac5ItgRCiVVCrhRjNeP8qhs0irsRF5l03X
656KL7U44mgySYNW2tlLHsXV/jmJXg==
=W0ip
-----END PGP SIGNATURE-----

--ahP6B03r4gLOj5uD--
