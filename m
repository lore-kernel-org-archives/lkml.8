Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03992C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAD8820C56
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599222245;
	bh=oi8x44wFUQteZiTcFdiPvZp8rHfw5Ycq1uBXFQAYp4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TzyW7semkl5lYpWhB8/f5jBG7UJpfAYPGen9PY0Eyn+tMqP0+QRKDXYUgG1zFRtuV
	 KFkkjSgvhpZwVAlMJsmiCp2xQEfj1vhfpkIeMHXY48GyjyTo8eJdu7T9wRWSuYAw4+
	 oqWxJ9gwbnHNHC99xYCZVS1sj8INk3VB18FWVPIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbgIDMYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 08:24:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730006AbgIDMXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 08:23:46 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0F422087C;
        Fri,  4 Sep 2020 12:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599222225;
        bh=oi8x44wFUQteZiTcFdiPvZp8rHfw5Ycq1uBXFQAYp4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tuv8q937FHgf0hDBwT0818j05Q0KN2AkiT75Sq9gRXyQUSPlffOm1m6rK9ZsqRIZP
         jK5tohbqdYzYDujf/OIMPUTORwo8Ik30NPtSL+pFRz3cw4qfQ6vyhoLPEqk0soGwj9
         laQWBKqqpC1Lq7yqfJ7e5yjUPO0S+OZdnkxDbkoE=
Date:   Fri, 4 Sep 2020 13:23:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 09/10] misc: hisi_hikey_usb: add support for Hikey 970
Message-ID: <20200904122303.GC4625@sirena.org.uk>
References: <cover.1599214329.git.mchehab+huawei@kernel.org>
 <f45f7663b694b16214604b55527f38eb9232f95b.1599214329.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QRj9sO5tAVLaXnSD"
Content-Disposition: inline
In-Reply-To: <f45f7663b694b16214604b55527f38eb9232f95b.1599214329.git.mchehab+huawei@kernel.org>
X-Cookie: Heisenberg might have been here.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 04, 2020 at 12:23:31PM +0200, Mauro Carvalho Chehab wrote:

> +	regulator = devm_regulator_get_optional(&pdev->dev, "hub-vdd");
> +	if (IS_ERR(regulator)) {
> +		if (PTR_ERR(regulator) == -EPROBE_DEFER) {
> +			dev_info(&pdev->dev,
> +				 "waiting for hub-vdd-supply to be probed\n");
> +			return PTR_ERR(regulator);
> +		}
> +
> +		/* let it fall back to regulator dummy */
> +		regulator = devm_regulator_get(&pdev->dev, "hub-vdd");
> +		if (IS_ERR(regulator)) {
> +			dev_err(&pdev->dev,
> +				"get hub-vdd-supply failed with error %ld\n",
> +				PTR_ERR(regulator));
> +			return PTR_ERR(regulator);
> +		}
> +	}

This seems weird - if the supply is non-optional why is the code trying
with devm_regulator_get_optional()?  Just use normal get directly.

> +	ret = regulator_set_voltage(regulator, 3300000, 3300000);
> +	if (ret)
> +		dev_err(&pdev->dev, "set hub-vdd-supply voltage failed\n");

Unless the device is actively managing the voltage at runtime it should
just let the voltage be set by machine constraints, most of the time
this will do nothing.  This only sets the voltage in this one place.

> +	hub_reset_en_gpio = of_get_named_gpio(pdev->dev.of_node,
> +					      "hub_reset_en_gpio", 0);
> +	if (!gpio_is_valid(hub_reset_en_gpio)) {
> +		dev_err(&pdev->dev, "Failed to get a valid reset gpio\n");
> +		return -ENODEV;
> +	}

Why not just use devm_gpio_request() which already asks for the GPIO by
name?

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9SMaYACgkQJNaLcl1U
h9BAZAf9F0GBH2s2mwraiURwcRGD/oHmdss9DyNNa0RzZ30x9ueRv76JA9IGeMba
Cam5eKlaWoxCO2P4BKoQcRO0OcsV+tLrIo3kO9a8EUmb8SLhTkTl+/xZJ6GT8t3h
TcPBz3lurppndlQQVwWR5C5PR4/9uIK+U7IMVa6MtnDEWEm12JWhvcmy/JCx/Euw
d20grMn+Qyq8D89y37Bj1nfwk5l9jN5j+V8X+OnJrNZkmeJVxYeYJqSeOAv8cdmm
rCHf1KKBBODtwadGjj3iHhCioPW/ImzmaJVlxngU7b0gXm7k3XNLQoJx2ZhNsUoi
zXYZfXZ7JvGjNJsn8QOu5WiEz+yV5w==
=0E0v
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--
