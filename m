Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50BBC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B67424125
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582053805;
	bh=gQhUGUSeGYs+1xZPVYd52aPv3VYM0O0vUd+5QxYItLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Nn7G927ngiA9R9DXqNAykcA+hWFxL1P/+FH+mTp0hIAY7Vl+7P03xW2MkmzvrNkHt
	 ghIbEW+Glkkz/sSyKMkeHfgi9b0OE57FhXCb6BfdAMk37pimsb0wYtXbadjnStdGkL
	 qpDROuh2ct3a9kyC6Dd4qwfz3BeC8M6EhxXmlDbw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgBRTXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:23:24 -0500
Received: from foss.arm.com ([217.140.110.172]:59522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbgBRTXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:23:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39CFD31B;
        Tue, 18 Feb 2020 11:23:23 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE5633F703;
        Tue, 18 Feb 2020 11:23:22 -0800 (PST)
Date:   Tue, 18 Feb 2020 19:23:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ASoC: tlv320adcx140: Add the tlv320adcx140 codec
 driver family
Message-ID: <20200218192321.GN4232@sirena.org.uk>
References: <20200218172140.23740-1-dmurphy@ti.com>
 <20200218172140.23740-3-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b1ERR0FXR0PvNIRE"
Content-Disposition: inline
In-Reply-To: <20200218172140.23740-3-dmurphy@ti.com>
X-Cookie: No alcohol, dogs or horses.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b1ERR0FXR0PvNIRE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2020 at 11:21:40AM -0600, Dan Murphy wrote:

A couple of very small things, otherwise this looks good:

> +	if (unlikely(!tx_mask)) {
> +		dev_err(component->dev, "tx and rx masks need to be non 0\n");
> +		return -EINVAL;
> +	}

Do you really need the unlikely() annotation here?  This is *hopefully*
not a hot path.

> +static int adcx140_codec_probe(struct snd_soc_component *component)
> +{
> +	struct adcx140_priv *adcx140 = snd_soc_component_get_drvdata(component);
> +	int sleep_cfg_val = ADCX140_WAKE_DEV;
> +	u8 bias_source;
> +	u8 vref_source;
> +	int ret;
> +
> +	adcx140->supply_areg = devm_regulator_get_optional(adcx140->dev,
> +							   "areg");
> +	if (IS_ERR(adcx140->supply_areg)) {

You should really do the request and defer at the I2C level, that avoids
running through the whole card initialization repeatedly when the device
isn't ready.  Basically try to do all resource aquisition at the device
level and then use it at the card level.

--b1ERR0FXR0PvNIRE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5MOagACgkQJNaLcl1U
h9Chkwf/aMC28AErRf96cbNZaa0JETsT1ZBpqi+o02dFL9JyXHDeMaOYtKdHNSkd
AaY5N6tioO/1AuvEed8mWfrlwnDjF2phkINUIZEZMqUHaU/YPRZrmGJvLfTMV2R4
aXyjU31pkz+VNNAwmX42BagezDOUh4XR1hpVInqNSbhUfv7mUeZCiemsYmwsNgXU
Q8fGLBTDHMDAQ3D0HsowNJKTSfcuNzIKbU1K3W4ZRsJrr7Be8zVhzZll/IqBzkdN
CMvufpVukGPruNgFdFQpiswM4oqBbKs5vEPrrrzYURxK+9G+nN4qP3rRb323o6LE
KhaVYwNfXlfsL0RViR7OgbcQpYRTtg==
=n7UO
-----END PGP SIGNATURE-----

--b1ERR0FXR0PvNIRE--
