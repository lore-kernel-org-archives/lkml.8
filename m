Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF27C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 09:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8175C20774
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 09:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597139041;
	bh=rpWfntgslhiWsYxwpCA3VLVWINp42udnFJltYOaR91g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tlB6MIvZJkd+sYerV7GZZbnrDND0qTVZC0MaStd6MH3KOgL6I541Urm7Bs/sSWA/G
	 Hb4MIkWjccAKjU/JwaFo/55OSAYrP7ZvHzSoXEytRgvD/egqVeaxSG8ntvG9rx+cxj
	 ZjNyIpholeMr1Ca1Vzg8Pj0UShvb2+fmUQXqwbSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgHKJoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 05:44:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:36546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728397AbgHKJn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 05:43:59 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90F44205CB;
        Tue, 11 Aug 2020 09:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597139039;
        bh=rpWfntgslhiWsYxwpCA3VLVWINp42udnFJltYOaR91g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ce6cpE3DcUA/ir63x1m+EMAvOW6H0AHBYl6SpjYWAUN7qeF/wEzMRvvzB/x4yHKhN
         bTtH6XmFgt+/rRAmEbCV5YfYDW3Kz+rnc3sxoQLcnoawrunNz510PE5+8DvYYlGOeH
         CjBEZsdjGkOtH3JuxsM2UBijMMXQOg9VwWUvsBLQ=
Date:   Tue, 11 Aug 2020 10:43:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Let dev_err_probe() use the symbolic error
 code
Message-ID: <20200811094332.GB6967@sirena.org.uk>
References: <20200811072036.4596-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
In-Reply-To: <20200811072036.4596-1-u.kleine-koenig@pengutronix.de>
X-Cookie: Gravity is a myth, the Earth sucks.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2020 at 09:20:36AM +0200, Uwe Kleine-K=F6nig wrote:
> This makes the error message:
>=20
> 	error -EIO: ...
>=20
> instead of
>=20
> 	error -5: ...

Reviewed-by: Mark Brown <broonie@kernel.org>

Having the plain text is very much nicer when reading the logs!

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8yaEMACgkQJNaLcl1U
h9ApQgf/YmCk4Px9R/riexpyNZehE1Xo9NEmNjILKXXcYVvLWpZ5sYh7RiPRyJRe
K1g4/QuPClH9oFdBftlHdVhgDzoIlvOl1dG9diM/kfJjxQtRfukikMgPyQRfXSG7
zPhdQbK67eIAutCivDirhe1+xtV5wDok60xGbkdo1zNbJco5Rgy7YqNhSWo1m0aY
mbR5ZzLoGEeBKg/RMKGOJibEPK6dRQ68+uI1xOmTAFhGdqNe1v6aJOH4EiRFHeQR
KE2OqRuE9fnqg7nUqymZAjX8jQ0yz7WEijaCUUGdto2BIlHfjjb9wHZneHMr8iT7
YW5yCLdYcVmQHEdQoThyQgQCBrOfAg==
=79Tx
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
