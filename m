Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EBAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 697C72088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590613022;
	bh=PJaX6a/wG4EogZDDlFWqXVNgTe80YNLiDmSRl+38vz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yiTqqBcA/TGnbh/A5WgnGUAjEbF/5FQL+KvlQ1YkSii7o7DLVg8WbSziqpfw2olcH
	 LL5JOjY7L1jME9wBUupjDtOQgnTdXUvxW3UxgE1FjmVrl1Eakvyx3FnuEH9+7rEYJq
	 OimAtEfGazqPQw7wV+FJEoYnPuzVX9+CG1ug9wIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgE0U5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 16:57:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgE0U5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 16:57:01 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5111320899;
        Wed, 27 May 2020 20:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590613020;
        bh=PJaX6a/wG4EogZDDlFWqXVNgTe80YNLiDmSRl+38vz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tEierfJlg9cjxL5kZCo+ruC44RyQE9GccF6rbeEjdIDkyVyxkl5iLTG1UeskiTz1U
         qsGoFAK/Rr0QPGHHpdbKOB0cjCpARvKOAYI6QPlfg4KVgAKiXLXeUjyusnJ2OuzyJB
         wVoerKThgLwGnz4i9g5oRhiduWKlCufSs35IGBtc=
Date:   Wed, 27 May 2020 21:56:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: rt5682: split i2c driver into separate module
Message-ID: <20200527205658.GM5308@sirena.org.uk>
References: <20200527193730.930412-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="37nyS7qXrnu4wN2o"
Content-Disposition: inline
In-Reply-To: <20200527193730.930412-1-arnd@arndb.de>
X-Cookie: Drop in any mailbox.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--37nyS7qXrnu4wN2o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 27, 2020 at 09:34:13PM +0200, Arnd Bergmann wrote:

> index 000000000000..c891aa80757f
> --- /dev/null
> +++ b/sound/soc/codecs/rt5682-i2c.c
> @@ -0,0 +1,341 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * rt5682.c  --  RT5682 ALSA SoC audio component driver
> + *

Please keep the entire comment C++ so things look more intentional.

> +static const char *rt5682_supply_names[RT5682_NUM_SUPPLIES] = {
> +	"AVDD",
> +	"MICVDD",
> +	"VBAT",
> +};

I'm *fairly* sure the device needs power even with Soundwire?

> +static void rt5682_jd_check_handler(struct work_struct *work)
> +{
> +	struct rt5682_priv *rt5682 = container_of(work, struct rt5682_priv,
> +		jd_check_work.work);

> +static int rt5682_parse_dt(struct rt5682_priv *rt5682, struct device *dev)
> +{
> +
> +	device_property_read_u32(dev, "realtek,dmic1-data-pin",
> +		&rt5682->pdata.dmic1_data_pin);
> +	device_property_read_u32(dev, "realtek,dmic1-clk-pin",
> +		&rt5682->pdata.dmic1_clk_pin);

This doesn't look very I2C specific either, nor do chunks of the rest of
the code.  The usual pattern with this stuff is to have the bus specific
code do bus specific stuff like setting up the regmap and then call into
a common init function for the shared parts of the chip.  I'd expect a
bit more unshared code here but not this much.

--37nyS7qXrnu4wN2o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7O1BkACgkQJNaLcl1U
h9A0nwf8D3oDJJ7yA5/9c9tZA3Ugn5+YbfRc5KWxk7tChsSTmOaXja9l3B3yoHEh
FB0bDc5yyUL6+iQxUkNzGe9Q//DhUeJTnDYH+FaBS+YyG3NNSqaTlD1JCjC0de6g
JMqaRXuOohN2sW2IX3fVcOnCUUfuJl0c7J6g64mxi/pv5LQTiUuuRWPz7DuIFSr7
ZlqkxNLBnt/U5/kiCZY3RGu1Ol7vPXFQYCOeWnlx5G0q2yrng4/bxpeWxkS0tNUy
SZY4IyOiT++Vqyj6JnPm/B7NQaWjs/xnl7JLKecmXDHmbPMNQUifdJw3+FzsvJwW
4RD1aq7FoWTMXR/LdkmkSw+QhT3MMA==
=1e2i
-----END PGP SIGNATURE-----

--37nyS7qXrnu4wN2o--
