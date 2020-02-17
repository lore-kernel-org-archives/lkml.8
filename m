Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A32C34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7987C214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581951956;
	bh=TRXzS1/3PZIMdCqxv0UFvbQGi3roNuI+NYhk587bOns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GAfCpKzD0S7mE+AjMgxb9czoyS/t19YG9TPGaUyx0b7SuIIBxnxIzuYktyycP4q3V
	 i02IMfXt88JPJ1D6eRT8AlHjNtt7KO4rfgu56QbzIV2fn0DQppMO/9nHzoq4s6mLSx
	 MrRTR2qimu50bqXvwpx1oBe5Nj3Dm277ESws9PX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbgBQPFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:05:55 -0500
Received: from foss.arm.com ([217.140.110.172]:36996 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729226AbgBQPFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:05:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76B05106F;
        Mon, 17 Feb 2020 07:05:54 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEE463F703;
        Mon, 17 Feb 2020 07:05:53 -0800 (PST)
Date:   Mon, 17 Feb 2020 15:05:52 +0000
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
Subject: Re: [RFC PATCH 07/34] ASoC: sun8i-codec: Remove extraneous widgets
Message-ID: <20200217150552.GI9304@sirena.org.uk>
References: <20200217064250.15516-8-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e5GLnnZ8mDMEwH4V"
Content-Disposition: inline
In-Reply-To: <20200217064250.15516-8-samuel@sholland.org>
X-Cookie: There was a phone call for you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e5GLnnZ8mDMEwH4V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2020 at 12:42:23AM -0600, Samuel Holland wrote:
> This driver is for the digital part of the codec, which has no
> microphone input. These widgets look like they were copied from
> sun4i-codec. Since they do not belong here, remove them.
>=20
> Cc: stable@kernel.org
> Fixes: eda85d1fee05 ("ASoC: sun8i-codec: Add ADC support for a33")

This is a cleanup, why send it to stable?

--e5GLnnZ8mDMEwH4V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5Kq88ACgkQJNaLcl1U
h9AO/wf+MRxer75LjO64950mSzyZv03H08zeydq4EqDjAfmEz4SKcz7U2c4saLDV
rnK6SSDhIk+37PQH7f3K1vOkeS2vbdZ4jLlfv37BZM8W4Gjvmskw55ALcWYyEJUT
NLbZapLoOL+r6G0jTNchN/Y9RxH02zUZjpaCkAu8pYQJ4H9uj4Tmo2ma08gsKe6Z
5hJJGjVeiJMF7vekIeY6qzV44uWDXL2fEkP41L05NPQBA3bPzo0E35uJEz+q2aZC
6M7cH9ezGYL4AtEJIFqzZnIUcQxVZkLHG/zpMqY4bxC1xFmNihLDzqi7HKQtGOEF
NTKdQfX3VCJwv2632jbbdyiKMpeIUg==
=zg40
-----END PGP SIGNATURE-----

--e5GLnnZ8mDMEwH4V--
