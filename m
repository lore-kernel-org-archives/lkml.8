Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4FCC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 11:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 693082085B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 11:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592478763;
	bh=9s6Wyhe9pYAC3VVIw7629js9Jb5aKrb4IUxiFgGqm3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OTN1DWp2UepFvAk6l1kjvT/vOi4l7mZod/bCaJQTCOYJH58w6578r2q1jRad1LxRS
	 7HX51pqr3MpJLcCX2HYpM47UrfpB+JqKQ8tYDxnV+BVR/z7hdgzlMl359QfhFhyeu1
	 gf7E/0rNZNY1kdR/pRpCTBYuJITScyy4SDFu+59o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbgFRLMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 07:12:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:49096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729424AbgFRLKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 07:10:08 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9BFA2078D;
        Thu, 18 Jun 2020 11:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592478607;
        bh=9s6Wyhe9pYAC3VVIw7629js9Jb5aKrb4IUxiFgGqm3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OHjUyyZk77g7rFyiuxjkusPCBhr/N/W80fCNPiHfTXD+yTBEM4XeG/A2vaDYps12W
         hNvWB5yakMJTVxQrH12IyG7PYYVTKxeLLD3z7qCH/B8LH8/WBBZ2HtAOHQXMAhsuRW
         i7BIMbX1AU4/Ax/qZs5rS+3q4ulVdkjT0j+ht3Lw=
Date:   Thu, 18 Jun 2020 12:10:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, michael@walle.cc,
        Rob Herring <robh+dt@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        DTML <devicetree@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] mfd: Add I2C based System Configuaration (SYSCON)
 access
Message-ID: <20200618111004.GF5789@sirena.org.uk>
References: <20200618080223.951737-1-lee.jones@linaro.org>
 <CAK8P3a3iRmXC2jDj92QHKqyD+x_UJ7rWU_KcGt=MFOD9UW38RA@mail.gmail.com>
 <20200618100704.GC954398@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wtjvnLv0o8UUzur2"
Content-Disposition: inline
In-Reply-To: <20200618100704.GC954398@dell>
X-Cookie: Androphobia:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wtjvnLv0o8UUzur2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 18, 2020 at 11:07:04AM +0100, Lee Jones wrote:

> Does Regmap let you register/initialise an I2C address more than once?

> When I attempt it, I get:

> [    0.522988] i2c i2c-0: Failed to register i2c client tmp105 at 0x32 (-16)

That's not regmap, that's the I2C core.

--wtjvnLv0o8UUzur2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7rS4sACgkQJNaLcl1U
h9Dl1gf/Zr4G4iqC1b7LIlHVA5rpT17+P/nHXKbb2jLXw2yw+gvkK03x4xEbGurw
ZUP2iZyCovu56VFHlIQeDUEJyVDt+8HKl2pcYxZMvTjs1xagjVPOJAeo1rjKgYaN
STH6iacWeUejdQN3HkcwqF4NbapIqoFXoxG9rLQnbNxrLt+QGPzzJNiPkCaWqdkd
FWxzU2l+/4pmVprMkBcG+j3FLqpZqy0G3U6Xxmf81ufaD4yqRtBsY7JEAinijAh/
57ypLQbhP4LSjNE0bAwK1xbD51J7e22Ev+HGPbLALcYRElVKLw96GjCLikXrXoIm
Do1MeaNZ+RuWEjn8xUBhzyEstiFHRA==
=JFIi
-----END PGP SIGNATURE-----

--wtjvnLv0o8UUzur2--
