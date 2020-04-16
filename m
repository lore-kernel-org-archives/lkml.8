Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12C8C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 12:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD40521D79
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 12:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587040978;
	bh=umyc9davKjGqXHYPYEvThedj9clicVOmBqruhPJYEFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=te6vrYZoMhMM2qlmRNM9Hf6bKn6ND6I0riicfnpAzW0AoVhfTxZ/zhjFOYUKz45pm
	 hrF3elvWC5XPMOYlnTC6okRgNiy/bO+qGcqj4LHGrpSgwLAVyXoB2TNyhTmSM+9FVf
	 OT/yy4DHzbk9F5j7ggxzz3So7ybyaepMPcvqoy18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635980AbgDPMm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 08:42:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2635873AbgDPMmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 08:42:44 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49352217D8;
        Thu, 16 Apr 2020 12:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587040962;
        bh=umyc9davKjGqXHYPYEvThedj9clicVOmBqruhPJYEFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zp7ebm6DopU7sArZWdGxQggJE37jsvDiwSqQhp2ZslVXLlsAtZP9PFkv7rVHZcf6p
         K79sqKU/ej7aOzUyBp6HI0SOB71YVYluma2yTvrzfsOxWKMwUrigfDB21UNHHCqQAl
         m1nMjTZ29M+hj/kIKx/HGl5MNrPVPeYUMrecer6U=
Date:   Thu, 16 Apr 2020 13:42:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] ASoC: Add initial ZL38060 driver
Message-ID: <20200416124239.GH5354@sirena.org.uk>
References: <20200416001414.25746-1-TheSven73@gmail.com>
 <20200416001414.25746-2-TheSven73@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l06SQqiZYCi8rTKz"
Content-Disposition: inline
In-Reply-To: <20200416001414.25746-2-TheSven73@gmail.com>
X-Cookie: Tempt me with a spoon!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l06SQqiZYCi8rTKz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 15, 2020 at 08:14:14PM -0400, Sven Van Asbroeck wrote:

> +++ b/sound/soc/codecs/zl38060.c
> @@ -0,0 +1,643 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Codec driver for Microsemi ZL38060 Connected Home Audio Processor.
> + *

Please make the entire comment a C++ one so things look more
intentional.

> +			err = zl38_fw_send_data(regmap, addr, rec->data, len);
> +		} else if (len == 4) {
> +			/* execution address ihex record */
> +			err = zl38_fw_send_xaddr(regmap, rec->data);
> +		} else
> +			err = -EINVAL;
> +		if (err)

If any part of an if/else has { } then all of them should.

> +skip_setup:
> +	if (priv->amp_en_gpio && tx) {
> +		/* enable the external amplifier before playback starts */
> +		gpiod_set_value_cansleep(priv->amp_en_gpio, 1);
> +		if (priv->amp_startup_delay_ms)
> +			msleep(priv->amp_startup_delay_ms);
> +	}

This external amplifier support shouldn't be here, if there's other
devices in the system then they will have their own drivers and the
machine driver will take care of linking things together.

> +	/* take chip out of reset, if a reset gpio is provided */
> +	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(reset_gpio))
> +		return PTR_ERR(reset_gpio);
> +	if (reset_gpio) {
> +		/* according to the datasheet, chip needs 3ms for its digital
> +		 * section to become stable.
> +		 */
> +		usleep_range(3000, 10000);
> +	}

It would be better to explicitly put the chip into reset and then bring
it out of reset if there's a GPIO, that way the chip is in a known
state.

> +	priv->regmap = devm_regmap_init(dev, &zl38_regmap_bus, spi,
> +					&zl38_regmap_conf);
> +	if (IS_ERR(priv->regmap))
> +		return PTR_ERR(priv->regmap);

devm_regmap_init_spi()

> +	if (device_property_present(dev, "mscc,load-firmware")) {
> +		err = zl38_load_firmware(dev, priv->regmap);
> +		if (err)
> +			return err;
> +	}

I'm assuming this is for the case where the device has a flash attached
to the master SPI port I can see described on the web site and can boot
off it - if that's the case I think it'd be clearer for the DT to
explicitly say that rather than this indirected property.

--l06SQqiZYCi8rTKz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6YUr8ACgkQJNaLcl1U
h9ABcgf/Tj/IGLfLFKTvEn5EJsyFi3tGt5Xy/ZQ29ZIbyGZC+8Gj/85vqttsDvSg
zP2RRJg+LiI2SiuvcT0tXKqZiDJxYTdFWHtfNtQa27h5WWeQUsaaRXBAvhqsO7ST
dkwkYy4HrPqUgCS3C1rZTeWIQpW/T4YvOoWxFdfnlvx71gWeTH+i3KFo6hL3XaxK
meKVm+++KWEaj1Xs+XXyN4mSM3qFOkX0zEvuoGa70UntYXKLMiXKL4F2mXJ0alg9
odPSEnzCtSfguo1tQuoh2h1/zN4kHJ93hJ3i2VciLegnOEom4FOBG+TuNnY6fLfp
Kw/npw1Cv0onjL4GrMLF6DBBC4PtCw==
=0cFL
-----END PGP SIGNATURE-----

--l06SQqiZYCi8rTKz--
