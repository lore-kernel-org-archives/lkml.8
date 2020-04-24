Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47769C55191
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 11:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22BEB20736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 11:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgDXLNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 07:13:39 -0400
Received: from sauhun.de ([88.99.104.3]:46584 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbgDXLNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 07:13:39 -0400
Received: from localhost (p5486CE62.dip0.t-ipconnect.de [84.134.206.98])
        by pokefinder.org (Postfix) with ESMTPSA id 7DCDF2C1FE8;
        Fri, 24 Apr 2020 13:13:37 +0200 (CEST)
Date:   Fri, 24 Apr 2020 13:13:37 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     =?utf-8?B?QmrDtnJuIEFyZMO2?= <bjorn.ardo@axis.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        patrick@stwcx.xyz, kernel@axis.com
Subject: Re: [PATCHv2] i2c: slave-eeprom: Make it possible to pre-load eeprom
 data
Message-ID: <20200424111337.GC1959@kunai>
References: <20200424090443.26316-1-bjorn.ardo@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+xNpyl7Qekk2NvDX"
Content-Disposition: inline
In-Reply-To: <20200424090443.26316-1-bjorn.ardo@axis.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+xNpyl7Qekk2NvDX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


On second look, two questions:

> +	if (!error) {
> +		int ret = request_firmware_into_buf(&fw, eeprom_data, &client->dev,
> +						    eeprom->buffer, size);
> +		if (ret)
> +			return ret;

Aren't we leaking 'fw' here?

Also, do we need 'error' and 'ret'? Can't we reuse one of them?

> +		release_firmware(fw);


--+xNpyl7Qekk2NvDX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl6iyd0ACgkQFA3kzBSg
KbZeTRAAhNyhL+7FSGQup4vRp/jUZk7jAOo4aWGHgKTL6jSYMgvIxtUsY+HwS8FX
wqwQpv8xjvc2fiZQTuAnlz7rbMhdK4jGW9GQDjcnWqumJEq20IzN1oF1UNYVl/YR
Rp8gA2sH3+Szjd1g1+0snVbgOEy2iMHLhTQYVkQ7RykcmJ7U4FMEJAGKeJqQkLAI
8LVunTx8yih2nbOmFxlNYg0uYoU+TDkPs/qz24kB+zo3/IXIiQxj8htBszgB/89K
tymOqNV9vlXHZGh1aZLDDmZCnBtHIXgaRPH1bgOu0vhYRnOxiTCpt4/674Pfb9O6
L+jSugI2tISN/ctDTX5mhLFFsGaAjAYU1fBEqwktZ9w2At0EuC8KnkA9TPORnuV1
N95VZ2b5JLvJBhDQuO6vP3QcQeBkyroHzHijPL8TNjiCqrBLIvMJfvf67Zto+LMr
STdmVcOdAG7CVhnUx9qMsn8JJ5ZcFPVd3L5atTsxtBo/lsErGowFOua7zIdIIOVZ
xL5tV7awLAAdqNyGTush4Yhib9qF8zGvsWr56T3PA5pnBB+KBgkaRBO67mM9Y0j+
eGF1BEXDT8SsJKgYKQp+aV7Vvx5rtkwfqtNk7qjqYDBFngEamk1LrGm6H++umgEM
I6V770O4gOy6wAdSlFKjwgvA1KPDB7TCajbY5wwjnT2dT23I6Fo=
=XRl9
-----END PGP SIGNATURE-----

--+xNpyl7Qekk2NvDX--
