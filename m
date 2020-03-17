Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45341C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2417020714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgCQPDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 11:03:25 -0400
Received: from sauhun.de ([88.99.104.3]:35330 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgCQPDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 11:03:24 -0400
Received: from localhost (p54B330FD.dip0.t-ipconnect.de [84.179.48.253])
        by pokefinder.org (Postfix) with ESMTPSA id 83B072C1E8B;
        Tue, 17 Mar 2020 16:03:22 +0100 (CET)
Date:   Tue, 17 Mar 2020 16:03:22 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH 13/17] i2c: include/linux/i2c.h: fix a doc warning
Message-ID: <20200317150322.GB1134@ninjato>
References: <cover.1584456635.git.mchehab+huawei@kernel.org>
 <24cbf9166b21531186e5b6d37a3f9201f957abef.1584456635.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Content-Disposition: inline
In-Reply-To: <24cbf9166b21531186e5b6d37a3f9201f957abef.1584456635.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2020 at 03:54:22PM +0100, Mauro Carvalho Chehab wrote:
> Don't let non-letters inside a literal block without escaping it, as
> the toolchain would mis-interpret it:
>=20
> ./include/linux/i2c.h:518: WARNING: Inline strong start-string without en=
d-string.
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Shall I take this via I2C?

If not:

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl5w5rkACgkQFA3kzBSg
KbZfkg//aSwBF24M2bUR133Y8c045B6aXfKMJanxvgG1YhXfEwrBg+fV+N1bJwkM
VUlrOQVUflwbzHMoKbkKoLG0cfCZvTy8XK/m86h1ryOYC+vDtxL1FoegGUDSfuJl
rXVMMp0HyrPBNVg6TJ2lRldK6gdEMmCghsaYLbIMwa60ZyLjmBYKOAiehHOi48sc
hkN/bPwNOhJUaB8NmcclXxqXAwEG6thoN0qJYewukukPfhlcn+M2w9XpsK9XlUMr
VbQ4SB+h6PEncvi7EAOFd1QZhfXvfOkfofRXDhxhVctiTyiwm85f0xp/+1oSnAyn
lLYr46bqky4dS5GYiPlpi4oHXi0lu445+uy1VSA4YY2KSx3z9IHl3PWdiQsJ0yh/
YPMYMQ5hz5P9129RbiZWYzSuNhgsPLAamvcAh86T/BzNKxfgOjcNV8ITGJZAJ3TD
jwATu7SZUwVJduGq7xknoJTyRdONxBzHVbLi+tRGFTlwZYmU1Upmo9o3lmeEmDaQ
tK8eNlKuiNAR5QSAAyJ5yNZquLrhPjWVgnfsFg6HkW2FaNhq/D2ck8iv/n1vl+HU
c38Jwmk0XYRYYc1eeADRM6qC2jbxFb30FR7USfX5HedJGUdYI9gOc4gQwfosOxvQ
mqIDG4s04ADPoZ8KMbr1wdn2LQELsNxwHQkoOnprtipOBTf8nSs=
=xvct
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
