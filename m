Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0509FC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 14:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D95BB20714
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 14:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgCTOzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 10:55:07 -0400
Received: from sauhun.de ([88.99.104.3]:49310 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727497AbgCTOzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 10:55:05 -0400
Received: from localhost (p54B33339.dip0.t-ipconnect.de [84.179.51.57])
        by pokefinder.org (Postfix) with ESMTPSA id 0182B2C08E7;
        Fri, 20 Mar 2020 15:55:03 +0100 (CET)
Date:   Fri, 20 Mar 2020 15:55:03 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Federico Fuga <fuga@studiofuga.com>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: mv64xxx: Implement I2C_M_RECV_LEN and
 I2C_FUNC_SMBUS_READ_BLOCK_DATA
Message-ID: <20200320145503.GC1282@ninjato>
References: <20200118115820.9080-1-fuga@studiofuga.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1ccMZA6j1vT5UqiK"
Content-Disposition: inline
In-Reply-To: <20200118115820.9080-1-fuga@studiofuga.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +    /* If we should retrieve the length from the buffer, make sure */
> +	/* to read enough bytes to avoid sending the */
> +	/* STOP bit after the read if the first byte */

Please stick to Kernel commenting style.

> +		/* length=0 should not be allowed, but is indeed possible.
> +		 * To avoid locking the chip, we keep reading at least 2 bytes
> +		 */

Ditto.

> +		drv_data->effective_length = data+1;
> +		drv_data->bytes_left = data+1;
> +		drv_data->msg->len = data+1;

Also, checkpatch complains about this if you run it with "--strict'

    CHECKPATCH
CHECK: spaces preferred around that '+' (ctx:VxV)
#81: FILE: drivers/i2c/busses/i2c-mv64xxx.c:384:
+		drv_data->effective_length = data+1;
 		                                 ^

CHECK: spaces preferred around that '+' (ctx:VxV)
#82: FILE: drivers/i2c/busses/i2c-mv64xxx.c:385:
+		drv_data->bytes_left = data+1;
 		                           ^

CHECK: spaces preferred around that '+' (ctx:VxV)
#83: FILE: drivers/i2c/busses/i2c-mv64xxx.c:386:
+		drv_data->msg->len = data+1;
 		                         ^
I think the complaints make sense.

> -	return I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR | I2C_FUNC_SMBUS_EMUL;
> +	return I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR |
> +		I2C_FUNC_SMBUS_READ_BLOCK_DATA | I2C_FUNC_SMBUS_EMUL;

Likely I2C_FUNC_SMBUS_BLOCK_PROC_CALL will work as well, but I assume
you can't test it?

Otherwise, looks good.


--1ccMZA6j1vT5UqiK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl502UcACgkQFA3kzBSg
KbaKrw//YFJRt+AH2+z/C2YoROOW6kIRbQ4RPamkJh+lUbPcfYhQtP1qyVDgoEf0
w7Qrqs915hVP5VDL7QaYXLs/Oe1+/UBvXuMCIdmAwvg7VJUN7YavhgAquqKGWgLb
btrAfjhZncubn/h6k24n+5bcO+EgB4ILmWE+SnUNZI7DiFuzzKHxOlvBglKkgZy/
kv7gK4aIixneO0KD7As/dsNXkFAoXP9fQ+uug6hL/INZMM3Dbu0sWPiZ0qsPGciI
/0fMhmRiTirbmS/d05VTKpK6MiV9kOm/VZybl7jjA67oDdEfV5bLJ17V9K86F+1U
vZ9zLh0nqdScAltK+nNeJzSLMIdnur+kgfnhsd71S+q5bBXtzuCuT4wprhiY4ThD
wWwkz6bLKWDbI8tkq+NGqQZ7zqLp3CCqaYVw41DN71sEAOu1QGDRBh8+DaYR/66j
WZS+UfniiG6lk0N78k+p3yi3R1oQtXM4o7MiCTSlz7P7t9muKuGaXzbXlLaBqJIV
mAHEVvktb+6YqwEk3RueDFVP61cH1MabuSWmMSq0L3WIaptaelKjMCSGdwo1s4A4
FjwIWUxRDkgRR/vaeKmmu3ZQbPHHC8NlLeRxjN2NIPZ7tBer6dec2Hpbtky7qZLI
e3T35fk1I2iB9EcxIjRRbRerROPy4EXt1tDOGzi44LUimg/BWI4=
=NYOi
-----END PGP SIGNATURE-----

--1ccMZA6j1vT5UqiK--
