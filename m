Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_RHS_DOB,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1559C35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 11:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3A3206EF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 11:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgBVLeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 06:34:02 -0500
Received: from sauhun.de ([88.99.104.3]:53062 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbgBVLeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 06:34:01 -0500
Received: from localhost (p5486C6B7.dip0.t-ipconnect.de [84.134.198.183])
        by pokefinder.org (Postfix) with ESMTPSA id 4BB2A2C07F9;
        Sat, 22 Feb 2020 12:33:59 +0100 (CET)
Date:   Sat, 22 Feb 2020 12:33:58 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kamel.bouhara@bootlin.com, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com,
        robh@kernel.org, peda@axentia.se, linux@armlinux.org.uk
Subject: Re: [PATCH v3 2/6] i2c: at91: implement i2c bus recovery
Message-ID: <20200222113358.GB1716@kunai>
References: <20200115115422.17097-1-codrin.ciubotariu@microchip.com>
 <20200115115422.17097-3-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline
In-Reply-To: <20200115115422.17097-3-codrin.ciubotariu@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2020 at 01:54:18PM +0200, Codrin Ciubotariu wrote:
> From: Kamel Bouhara <kamel.bouhara@bootlin.com>
>=20
> Implement i2c bus recovery when slaves devices might hold SDA low.
> In this case re-assign SCL/SDA to gpios and issue 9 dummy clock pulses
> until the slave release SDA.
>=20
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

Applied to for-next, thanks!

The implementation is very similar to i2c-imx. Maybe we should move this
mechanism into the core somewhen...


--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl5REaYACgkQFA3kzBSg
Kbb/5BAAjIRoPQE9LABWbJpndp9jLdUzU84jFgAC8Doa8diKtDq4FRlalY3b3N+D
ciV1rCm+jDxHbvrtSkzoB4zzqVwoHbCYG2UqCDeb6kGQW+64oCn2PaRGETahlzTt
t6xJGm/VCwYNoDOTlp6M27TWtP89PAIc2byd6YgejLdkPld5gfYatdWT5WIv4zci
ayDRoh7drxaSKT3umNfixWaafLSLnrVP4ylTA+2FZ2mgp9luw6y6scnSj0Yyk0do
elir7QNRItWLYJdtEI5oo2Jfm8wII5P0V3MMS9RWK3diOheswZBdJuX7mEMHXHLz
7hqFRGpkW9U0/7kXfFaLBQWJFAANZeoNHVKg7MyA9rIbRwAqrngy6uVwZD1KPtxn
DIYRKZotx/PNmOOaZEMGuwwU70vM9ff0b/ZOYQtYBTzwYDDirXO/ZGipUFLyfaIl
sfvCQB6FNb8f8qQpOip20ecYjorUP4duRY2kK0ZTvfqJQTyQi7ziRPLVSB1ukNv+
LG8jlj0RyWojDK/jl0lTUW4mbncWkqBMhWigd5nIJp5qAGRZLfCjKW+xhGos7CNc
AJAYLMyGhVazIidpUhju9zqqsTMNXVLwbmwqXd76TmK4hhneqjJqN+uRndSiZNY8
EfnrgyJ6mdYSBxh6MhBZ6fw/s1FplEMs1SR5aOMN1LzGdYIoQg0=
=BEk4
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
