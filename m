Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4F9C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0CB321D91
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587052331;
	bh=f+v0/f94whq+RFELRQRok+Qo9U6CspwMX5WgTcLbQ9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gkwr5cY8MBrpWAE0JcAoid6ea2ikgO9qXADhHm3z3bqyCpDsyzTDSyeElQthzARw2
	 85+lxfwMh7uDvb2HvBBq3vrH5g5t/wJSQqcaZcWKD1pHNtFqRrAjMhnZsXvmT5hED6
	 TAL+4rr7yVJbqJUTpQnbcftYmjQLOj5J1B5SnifA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442807AbgDPPwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:52:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437198AbgDPPvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:51:47 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BACC20732;
        Thu, 16 Apr 2020 15:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587052306;
        bh=f+v0/f94whq+RFELRQRok+Qo9U6CspwMX5WgTcLbQ9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U5nPloWnP86QJZDjWomAThBMqB3yOl2Uupk0oXRpWZqiHwU84G5P6UDuFfyerwmrz
         47p/J30AwMTeW5zSJTvdUs7hXGwYBfQGAj2trgrejwc1aA/IzLb+mqNVbVQm7SC6WA
         CRQ+7UmPmju+ujZ7vz10IPvok54pLnhEoa+V498U=
Date:   Thu, 16 Apr 2020 16:51:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] ASoC: Add initial ZL38060 driver
Message-ID: <20200416155144.GM5354@sirena.org.uk>
References: <20200416001414.25746-1-TheSven73@gmail.com>
 <20200416001414.25746-2-TheSven73@gmail.com>
 <20200416124239.GH5354@sirena.org.uk>
 <CAGngYiVXk+1Qzs3yLwyne3X567_yvbuRfXkjihmGc0EigHo50A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VLAOICcq5m4DWEYr"
Content-Disposition: inline
In-Reply-To: <CAGngYiVXk+1Qzs3yLwyne3X567_yvbuRfXkjihmGc0EigHo50A@mail.gmail.com>
X-Cookie: Tempt me with a spoon!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VLAOICcq5m4DWEYr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 16, 2020 at 11:23:14AM -0400, Sven Van Asbroeck wrote:
> On Thu, Apr 16, 2020 at 8:42 AM Mark Brown <broonie@kernel.org> wrote:

> > > @@ -0,0 +1,643 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Codec driver for Microsemi ZL38060 Connected Home Audio Processor.
> > > + *

> > Please make the entire comment a C++ one so things look more
> > intentional.

> The 'weird' combination of // SPDX and /* Description/copyright */ seems to
> be a kernel-wide standard (for C files, at least) ?

> E.g.:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/soc/codecs/wm9090.c?h=v5.7-rc1#n2
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/soc/codecs/wm8904.c?h=v5.7-rc1#n2

> Ok to keep?

Those were all automatically converted, one of these days I might get
round to updating them :/

> > This external amplifier support shouldn't be here, if there's other
> > devices in the system then they will have their own drivers and the
> > machine driver will take care of linking things together.

> In our application, the amp is a "dumb" class-D amp with a single enable line:
> https://www.onsemi.com/pub/Collateral/FAB3103-D.pdf

> I am not sure how I could make this more general. Could you point me to an
> example somewhere in the tree?

Look for GPIOs in machine drivers, there's quite a lot of examples (eg,
rx51 has a speaker amp although it's not the most modern).

> > > +     priv->regmap = devm_regmap_init(dev, &zl38_regmap_bus, spi,
> > > +                                     &zl38_regmap_conf);
> > > +     if (IS_ERR(priv->regmap))
> > > +             return PTR_ERR(priv->regmap);

> > devm_regmap_init_spi()

> I wish !! This chip has complex SPI addressing, using an "address" which:
> - is variable length, depending on the page of the register being accessed;
> - contains a field with the length of the data to follow.

OK.

--VLAOICcq5m4DWEYr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6Yfw8ACgkQJNaLcl1U
h9BSVwf+P2xC6Q4mb+FyMvkNgT3QFu0YqF4YMuC6akEHl+Ne/WqRC6TSls52JJD1
sLwGV585mfFcdmevXFp/glhZ3sJTIX6kpDGlfBIetsG+bBXZgZ5rwIFdPYPRX94X
OG/2E75aoQzo/RXv7F+7eXEVZHOrwbW1SDy/AF9EOtrr1CvEj9/kiWTdqVLIj/Rm
wfWlFaBraepLOKowIpg/eu5JGvmWbHPZwqYu98FloE20jV6RAaCA231IJoMVSK+d
v4i2SyGZtF7cuG8S6XkBuFPHAwFxTanxxfBs81FazAXLty8VaOfp5GngIYlst1iI
ivYzjobJUeAsZ1PASHds1ris+woLzw==
=9et2
-----END PGP SIGNATURE-----

--VLAOICcq5m4DWEYr--
