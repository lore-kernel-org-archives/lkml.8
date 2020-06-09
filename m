Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BCAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 11:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C052207ED
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 11:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591701568;
	bh=6oLQbi+VXC1BdFqllwYDYoh8Oblpv+hbligMTtN4J9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ooYuj5V5TLPACn5SJmx1VDAsBg8Ev2EwMVXAqDp9mGeMd+dB1HIqoVur2oSlR5svL
	 B+QGUZGPy7NoxkTIVCsomiYYL0f4pGdD7PjmAzJxFm/XWlUcij9wlBGPZCrbGRibFP
	 ejvLeZwNlHbW6/wpv1FBlKt9eBEHSIs69hkqx4zQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbgFILTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 07:19:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbgFILTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 07:19:22 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 474D6207ED;
        Tue,  9 Jun 2020 11:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591701561;
        bh=6oLQbi+VXC1BdFqllwYDYoh8Oblpv+hbligMTtN4J9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=grNWNDH3GlB+YNv3nWCA/FnuaYvGvyFVA8jL/Y5gTcEYV8LTScYQ+LE56GWpT820v
         CMxIrbcjLrnArBNgWsMIiLgu4ebGojdkmezi3xiDISKdOBUBpiZPg0val06pCT+YFz
         jxwXA9YCaZ4ud06SzK/33S3Q6PVxjqWsEAJ+wI4A=
Date:   Tue, 9 Jun 2020 12:19:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] regulator: Add driver for cros-ec-regulator
Message-ID: <20200609111919.GB4583@sirena.org.uk>
References: <20200609080001.121499-1-pihsun@chromium.org>
 <20200609080001.121499-3-pihsun@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Content-Disposition: inline
In-Reply-To: <20200609080001.121499-3-pihsun@chromium.org>
X-Cookie: Be careful!  Is it classified?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 09, 2020 at 03:59:55PM +0800, Pi-Hsun Shih wrote:

> +static int cros_ec_regulator_set_state(struct regulator_dev *dev, bool enable)
> +{
> +	struct cros_ec_regulator_data *data = rdev_get_drvdata(dev);
> +	struct ec_params_regulator_enable cmd = {
> +		.index = data->index,
> +		.enable = enable ? 1 : 0,

The ternery operator is totally redundant here.

> +static int cros_ec_regulator_enable(struct regulator_dev *dev)
> +{
> +	return cros_ec_regulator_set_state(dev, true);
> +}

> +static int cros_ec_regulator_disable(struct regulator_dev *dev)
> +{
> +	return cros_ec_regulator_set_state(dev, false);
> +}

I'm not sure that the shared function is really worthwhile though,
there's not really enough in it and certainly not anything complicated.

> +static int cros_ec_regulator_set_voltage(struct regulator_dev *dev, int min_uV,
> +					 int max_uV, unsigned int *selector)
> +{
> +	struct cros_ec_regulator_data *data = rdev_get_drvdata(dev);
> +	int min_mV = DIV_ROUND_UP(min_uV, 1000);
> +	int max_mV = max_uV / 1000;
> +	struct ec_params_regulator_set_voltage cmd = {
> +		.index = data->index,
> +		.min_mv = min_mV,
> +		.max_mv = max_mV,
> +	};
> +
> +	if (min_mV > max_mV)
> +		return -EINVAL;

The core will do this for you.

> +	ret = of_property_read_u32(np, "google,remote-regulator",
> +				   &drvdata->index);
> +	if (ret < 0)
> +		return ret;

This remote-regulator property is a bit weird, it feels like it should
be a reg property on a bus.

> +#if defined(CONFIG_OF)
> +static const struct of_device_id regulator_cros_ec_of_match[] = {
> +	{ .compatible = "regulator-cros-ec", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, regulator_cros_ec_of_match);
> +#endif

Your compatible is google,regulator-cros-ec.

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7fcDYACgkQJNaLcl1U
h9A5Fgf/Yyo8CmM9ox3GNrQJJGSsFommmFLc+Zk9J9kySNzjzSAete1eVCX7D8XU
LuLvLP7Adm0+ouCAaty/on0CMaXpnislczWMQDu3wWmIuv8RUGUGb5btlJi4M32p
tcmDal42jgwj49szrLR9BlH96l2pfyfkW6+4lktXHQt51t8xonHBzH4pDptBUqSa
UxQnCS1+lHQI8EG1GYOhWdlYFrV7kiYDVLyA9xJeFjuCE4QYkggyQq7Gy1fGFgw+
WsKRmHQuHajXLFIKR+8SbVpBBVp2OYBCrSmVVWUBC8//VMR49yUOC1KMscDJ7Ujm
eYA9OmT/RzJXN5LmZVsoqlXx93itFw==
=j9T6
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
