Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18B0C34050
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A04524654
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582127069;
	bh=dMrXMbrs9gNU7fLzRfLtwAolv6etgSudzWhW2W2FRn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IFumII8YAU9hH0FHNJIPdR4JdN3eV1O4bvU/ItJ1mqukZDNMYtk8lKH91+TOB6WiU
	 Ct2ftwGaIpfcW05bFRH7CdHgeikxoEe/Ur9sNtmIav8HD9JyY6W4FWpgNUsVnonpgu
	 mnB5EzjV206/FIM2FU6tNndYDIYNjTHsJKr3vXv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgBSPo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 10:44:28 -0500
Received: from foss.arm.com ([217.140.110.172]:51514 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbgBSPo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 10:44:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D0061FB;
        Wed, 19 Feb 2020 07:44:27 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5C233F68F;
        Wed, 19 Feb 2020 07:44:26 -0800 (PST)
Date:   Wed, 19 Feb 2020 15:44:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 2/2] ASoC: meson: add t9015 internal DAC driver
Message-ID: <20200219154425.GD4488@sirena.org.uk>
References: <20200219133646.1035506-1-jbrunet@baylibre.com>
 <20200219133646.1035506-3-jbrunet@baylibre.com>
 <20200219145500.GC4488@sirena.org.uk>
 <1ja75ey4vj.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JwB53PgKC5A7+0Ej"
Content-Disposition: inline
In-Reply-To: <1ja75ey4vj.fsf@starbuckisacylon.baylibre.com>
X-Cookie: FORTH IF HONK THEN
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JwB53PgKC5A7+0Ej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 19, 2020 at 04:27:12PM +0100, Jerome Brunet wrote:
> On Wed 19 Feb 2020 at 15:55, Mark Brown <broonie@kernel.org> wrote:

> >> +	/* Channel Src */
> >> +	SOC_ENUM("Right DAC Source", dacr_in_enum),
> >> +	SOC_ENUM("Left DAC Source",  dacl_in_enum),

> > Ideally these would be moved into DAPM (using an AIF_IN widget for the
> > DAI).

> I can (I initially did) but I don't think it is worth it.

> I would split Playback into 2 AIF for Left and Right, then add a mux to
> select one them if front of both DAC. It will had 4 widgets and 6 routes
> but it won't allow turn anything on or off. There is no PM improvement.

> Do you still want me to change this ?

It can help us track things like external amps connected to the DACs,
especially when we manage to get to the point of tracking individual
audio streams over DAI links.

--JwB53PgKC5A7+0Ej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5NV9gACgkQJNaLcl1U
h9B1bggAg2Hke5eWreSl3h32yjHnSqSd3PP0FGDmBKiB8wwIidEnFIVCpcMesE/D
a6aM9T+fI+H0uiiAhroMreYDklRU+cJaTcDHBfEHMiTB7p8WPTUiGjUz8ZwqbmTM
rn93VmzRm+hGQj9oj6QGxUxpXQ2j3UKh/iXEa/SItvNP7/cGs/mPjpFZ5PLJjSvO
2glHbvcvqLgm54cNrHsC/Wx4LbpVMznw1dXRXNkzi4sWgcpBNwVm6Rph32EijKuE
W4klrGqOa2Oj0ha5e97b+cZbTONpIPgVrDfegcbcPf+EHsYevSyPS4Pzdk0mGNXI
36fS/u8fbsdVLyq3L89UxhOXP6vvMw==
=bIhx
-----END PGP SIGNATURE-----

--JwB53PgKC5A7+0Ej--
