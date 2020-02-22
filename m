Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_RHS_DOB,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CE0C35672
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 11:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7257206EF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 11:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgBVLdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 06:33:05 -0500
Received: from sauhun.de ([88.99.104.3]:53024 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbgBVLdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 06:33:05 -0500
Received: from localhost (p5486C6B7.dip0.t-ipconnect.de [84.134.198.183])
        by pokefinder.org (Postfix) with ESMTPSA id DAFA52C07F9;
        Sat, 22 Feb 2020 12:33:01 +0100 (CET)
Date:   Sat, 22 Feb 2020 12:33:01 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kamel.bouhara@bootlin.com, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com,
        robh@kernel.org, peda@axentia.se, linux@armlinux.org.uk
Subject: Re: [PATCH v3 1/6] dt-bindings: i2c: at91: document optional bus
 recovery properties
Message-ID: <20200222113301.GA1716@kunai>
References: <20200115115422.17097-1-codrin.ciubotariu@microchip.com>
 <20200115115422.17097-2-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <20200115115422.17097-2-codrin.ciubotariu@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2020 at 01:54:17PM +0200, Codrin Ciubotariu wrote:
> From: Kamel Bouhara <kamel.bouhara@bootlin.com>
>=20
> The at91 I2C controller can support bus recovery by re-assigning SCL
> and SDA to gpios. Add the optional pinctrl and gpio properties to do
> so.
>=20
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> [codrin.ciubotariu@microchip.com: rebased]
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to for-next, thanks!


--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl5REWUACgkQFA3kzBSg
KbYSSQ/+Og6OQ8KKYGzfH/m0bVgrt4ZZ6XseXHSbqLqZPLwt0ZdTqJRwTTC4nGoA
VwQTF8w/OteA1gO2MIX9aibT9CAiqVM3lgPKBNyABF9IAHKVLjkm2eqwe3HoGfbX
30iL3vfiJqkXsgN/l+WQiFzEB0Pzb3XfUJd1WDoKyMRckdKsYiUlMX8tQyP8XN2a
qHebhGgDLLIy4Lf/mYdTYmVsa5U+RHT8oTfMlwDUaYNs+u6cx6CuHdN2bkVvKMqE
0BMoSi6MNpE1jY1C3VrfooxqVlGFoxYIC2mlIxDYY1B6pRJRXuot3cNdvudVPC82
B/+MOeJRCRsMAmZ/eOP8sGBV+D978ackCQvKJtHDaOedf7eIzoeTA7BouAQvpqp/
/KY6mcfNB4JQCjQOWnL0gKPfLTf5p2/C8F1ozdefav+en0CyxGA957KStiXy6YBJ
DeJbJz5TMmEbPzFvysflXbFr9h8kfDbPMuiBJjm1ICS3KJMPmMPAoDQPoTPREHRC
F5vK00iTwuiFTHm8NnmD4FT0qN0XJBC3JCU+eVkPlCCd1Jb9WGZVYP78/vXRmYKx
AAn1SO2fM1MzgxEaE84V3CwCRltuMkE7h9EBTPLCO2iKAFMW1ww2F/Mc2zhs1tbt
wMPhow+wsY9KonG0r4xTplzJjry9EcECTXCJUnti9RNZ3Zdzbao=
=+3Bp
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
