Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7183C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68FB62074B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgIIJHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:07:44 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:52210 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgIIJHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:07:40 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id AFE871C0B8F; Wed,  9 Sep 2020 11:07:37 +0200 (CEST)
Date:   Wed, 9 Sep 2020 11:07:36 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Alexander Dahl <post@lespocky.de>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Alexander Dahl <ada@thorsis.com>
Subject: Re: [PATCH v3 1/2] leds: pwm: Allow automatic labels for DT based
 devices
Message-ID: <20200909090736.GE10891@amd>
References: <20200907043459.2961-1-post@lespocky.de>
 <20200907043459.2961-2-post@lespocky.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wchHw8dVAp53YPj8"
Content-Disposition: inline
In-Reply-To: <20200907043459.2961-2-post@lespocky.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wchHw8dVAp53YPj8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

>  	pwm_init_state(led_data->pwm, &led_data->pwmstate);
> =20
> -	ret =3D devm_led_classdev_register(dev, &led_data->cdev);
> +	if (fwnode) {
> +		init_data.fwnode =3D fwnode;
> +		ret =3D devm_led_classdev_register_ext(dev, &led_data->cdev,
> +						     &init_data);
> +	} else {
> +		ret =3D devm_led_classdev_register(dev, &led_data->cdev);
> +	}

Can you always use _ext version, even with null fwnode? If not, can
you fix the core to accept that? Having that conditional in driver is
ugly.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--wchHw8dVAp53YPj8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl9Ym1gACgkQMOfwapXb+vLs4wCggaBNQOb2qvudwfdBW1U0Gr+p
HVQAn2/bC58RWEIDRGUv8GBV/L9xDpf1
=vIz3
-----END PGP SIGNATURE-----

--wchHw8dVAp53YPj8--
