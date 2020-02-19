Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A164C34051
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C4E206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582124105;
	bh=yUZXolpqCAZH46QWupdgcTiTf30FDecbps3Oweo/RYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C78w70/FIqDIBJqosvx7GK2bywoGnacYiyT4P8+MuBUKQzw31XyAnIx3PyC91j0qx
	 QHDzIICb3GYCueiZbc7sK3u7vIB6WA8Ikv+X6OxyygGt4fa+5NQ8ZQsP0sOtExmDnH
	 k9FkS9VYU24YEXjwCosNjDLp+0EzgcxyrZ5WDApM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgBSOzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 09:55:03 -0500
Received: from foss.arm.com ([217.140.110.172]:50528 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbgBSOzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 09:55:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED8391FB;
        Wed, 19 Feb 2020 06:55:02 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 725113F68F;
        Wed, 19 Feb 2020 06:55:02 -0800 (PST)
Date:   Wed, 19 Feb 2020 14:55:00 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 2/2] ASoC: meson: add t9015 internal DAC driver
Message-ID: <20200219145500.GC4488@sirena.org.uk>
References: <20200219133646.1035506-1-jbrunet@baylibre.com>
 <20200219133646.1035506-3-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KN5l+BnMqAQyZLvT"
Content-Disposition: inline
In-Reply-To: <20200219133646.1035506-3-jbrunet@baylibre.com>
X-Cookie: FORTH IF HONK THEN
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KN5l+BnMqAQyZLvT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 19, 2020 at 02:36:46PM +0100, Jerome Brunet wrote:

Looks good, couple of small things below:

> +static const struct snd_kcontrol_new t9015_snd_controls[] = {
> +	/* Volume Controls */
> +	SOC_SINGLE("Playback Mute", VOL_CTRL1, DAC_SOFT_MUTE, 1, 0),

This should be Switch (see control-names.rst).

> +	SOC_SINGLE("Volume Ramp Enable", VOL_CTRL1, VC_RAMP_MODE, 1, 0),
> +	SOC_SINGLE("Mute Ramp Enable", VOL_CTRL1, MUTE_MODE, 1, 0),
> +	SOC_SINGLE("Unmute Ramp Enable", VOL_CTRL1, UNMUTE_MODE, 1, 0),

These too.

> +	/* Channel Src */
> +	SOC_ENUM("Right DAC Source", dacr_in_enum),
> +	SOC_ENUM("Left DAC Source",  dacl_in_enum),

Ideally these would be moved into DAPM (using an AIF_IN widget for the
DAI).

--KN5l+BnMqAQyZLvT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5NTEQACgkQJNaLcl1U
h9Dlbwf9G+Zx9LnUXQiK9vVqNnfJy5o7uz95sBnsBro99NHp8ldxwtBqNpYjnE5w
AT6qUKHSPUuGzRcTYuvILXhcp16Pmcl9TARppPrU3dnOxy+CMf4UfCdQvkU2Z+9z
nVgs2o0WHFrwJaJb1LP8w9onR7Dj0sDx5q63FqSwkp5nTOjxDiwWtnFNcHx8aozG
tL/ADQlqRABlDjvNz+/knxzF3ZIIbIbyYvGMrHTUWCCP8sn2oOUBeqg1wbJ2pFLf
iFSl0OFtrYfRAlAMGwxLZl5utpkWU5DG94EceGpx/fK9hXuomNoeLscr+24dnqko
f/W3R4gTxgSNrt43vmW2os6ejWa6Yg==
=+YY/
-----END PGP SIGNATURE-----

--KN5l+BnMqAQyZLvT--
