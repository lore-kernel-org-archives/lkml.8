Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25EAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4ADC20768
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="eOMTvTR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgFVIKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 04:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgFVIKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 04:10:32 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BA5C061794;
        Mon, 22 Jun 2020 01:10:32 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1007)
        id 49r2CS5Jqfz9sTY; Mon, 22 Jun 2020 18:10:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1592813428;
        bh=Ce43B/8Fubqa8dR1cOJzDW7Y73JAHwovWlhBSJzM3CY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eOMTvTR7p3iDDktQO7xf6iq/zZY+SqaX7YzQZnmBeYAdU3Vb/iQW6iSId9wrg+T/G
         klMmNjOjAq/y35tT0XYpcgIJnBf3nkM1Eks9Krb4rfNgXFoOLWn/qetTtk+T9dtFg/
         z1hpQeFKEzeUNGGfPgmFy02oxsjVvRdlcpB952DI=
Date:   Mon, 22 Jun 2020 17:53:18 +1000
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Joel Stanley <joel@jms.id.au>
Cc:     devicetree-compiler@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 0/2] dtc: Improve checks for i2c reg properties
Message-ID: <20200622075318.GT17085@umbus.fritz.box>
References: <20200622031005.1890039-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZXzThk3vFZecBD04"
Content-Disposition: inline
In-Reply-To: <20200622031005.1890039-1-joel@jms.id.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZXzThk3vFZecBD04
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2020 at 12:40:03PM +0930, Joel Stanley wrote:
> This is to fix a build warning in the Linux kernel caused by dtc
> incorrectly warning about I2C_OWN_SLAVE_ADDRESS.

Applied, thanks.

>=20
> v4 adds a U to the defines
> v3 fixes the 10 bit size check
> v2 contains a second patch to check for 10 bit vs 7 bit addresses.
>=20
> Joel Stanley (2):
>   checks: Remove warning for I2C_OWN_SLAVE_ADDRESS
>   checks: Improve i2c reg property checking
>=20
>  checks.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZXzThk3vFZecBD04
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7wY20ACgkQbDjKyiDZ
s5LIHg/+JowiaWp26ONSiUBMBOOlj5fnSduXGzDLt6S/0xo3qTWsIwMoB9579Yk5
KwX4uuHoMseEC9KNwxK7cX6JpHLOkXMXzUbTrs7wqQcUbG4H+poYG53Ha5/IgTFp
j8E5IbKUR4zXme3zv9oOj5D7Nsc14EARFo7DxKAWNwL11Wmo9oKFZyUeQJH2S0UH
29ijTWoEeCLYIhgydCPR3zcvVza3f1KX/01yYseVExsnzdqb0xLbtOeAfiSmwWj6
uqWRPc5Uepp9gPaz/mgGKtbQ3CHnOirV4p3e4d6YgNbdBbutCsubQcsJoda5Wigw
/QpkcxDVJvus5WWoKGI7NXnXOcLEInA+dqZHbuM8J+roXGzhK3Q5jxx2xirs/LDX
JqsVMkA1986o4X9m4zQxXywvnw15oLokzO6kv3WA5RpFvHoXPURQLmZgHzH2BOJm
WK/N5mvt61sjL59e/RW7ggEGauJoKzv6SBfZP+VSvO59txZ+wZPOjAu1Lbx9A3TA
RGDwDjn+C7/QyTobLlFT0Wgw+WNJ3k/fGsFrDw7Pr+4BXaF8XI9Nuqo4j58nTsqw
Hcy7mk5WJZzjxbrMNm4QbdT4S4zMcqFQ06zifd/BoAggRBspcsjOMAD6sT13PTqE
8Oqb96+xqyWnTJLpqA4ZvvfF7guTw0HQQJxDnVKI9Mf84mDv00c=
=Qy89
-----END PGP SIGNATURE-----

--ZXzThk3vFZecBD04--
