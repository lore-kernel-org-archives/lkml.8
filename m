Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E397C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 217F22064B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593456088;
	bh=oETRBPxtYtxipIP7tlc+E292rD73tY/GD0pESofHmHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g0aaG6ePp92OerkQ6O8WSAILiyLcOOmpFYk/McBRx/B8XCnnGAv4IN6pqLN913N4z
	 urcm1zqjV4l8k9/fTPGGmbTZJzVYa5hZ2ZkNXi13A8Lwo7lGWe9+LGxJb/7A04kAmf
	 y3Y9nZEfLKacJegPspr164JyEAfrs+bywPKYkgAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgF2Sl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:41:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728796AbgF2SlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:41:21 -0400
Received: from localhost (p54b33454.dip0.t-ipconnect.de [84.179.52.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACB7D23330;
        Mon, 29 Jun 2020 08:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593418843;
        bh=oETRBPxtYtxipIP7tlc+E292rD73tY/GD0pESofHmHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hv4Xb2fnbJvyfdHB8wZrvJezbIXw7C6xj6k7J/4essdp4b7grCD1gPUMJESGnL3Ey
         1ISZ7c+xvK3Gj3jnfmfTBslm5gqxQya1g//4E83DWIZwNgS5sZKtbt+or0+P+PIsIz
         zDrqKeqYSvJ6956wj7DnV70y/k+Jb6pcF9IegBjI=
Date:   Mon, 29 Jun 2020 10:20:37 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] misc: eeprom: eeprom_93cx6: Repair function arg
 descriptions
Message-ID: <20200629082037.GA1063@kunai>
References: <20200626130525.389469-1-lee.jones@linaro.org>
 <20200626130525.389469-7-lee.jones@linaro.org>
 <20200627203357.GA954@ninjato>
 <20200629081436.GH177734@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <20200629081436.GH177734@dell>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > @@ -270,7 +270,7 @@ EXPORT_SYMBOL_GPL(eeprom_93cx6_readb);
> > >   * @eeprom: Pointer to eeprom structure
> > >   * @byte: Index from where we should start reading
> > >   * @data: target pointer where the information will have to be stored
> > > - * @words: Number of bytes that should be read.
> > > + * @bytes: Number of bytes that should be read.
> >=20
> > Now we have 'byte' and 'bytes' here as arguments which is confusing. I
> > think renaming 'words' into 'num_bytes' would be even better.
>=20
> I await your patch with bated breath. :)

? You are touching it already, why a second patch?


--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl75pFEACgkQFA3kzBSg
KbZ+UhAAr9/7V7v960Y8EbQmYPt20ZwDmUSrxcv3w10vVDO1l3vK9mGMUADQGTkd
LYJQnnOHFQ76g3cnWgeX4GBN+q9QZZ4/XlhB7hT6kr0d0PU9VngGmnRLdMeCSBHr
xxNcVQueXka2skTnI5rXfv0NpXCqFqgQAofWJMI5da+m8fLgYr1fZavRjIOfomaf
UtGE4KbCXE5/yveZyINqQWSts3elkJBmDFzsC5XoAj402dNK77dp+y6uSp+Ub0U7
62PxSaTVsk5vlsY6kyM4uJVSzbl3Vf9YFN/i6gLdvDkwFhwRqyhDDtEI1xz0ljww
PK0kqol3Gygwh+IuudwrjZtBV3KkSeFGgE75yz+SoVHWLAhzVlPXqptOPi3QV6eE
PHnLmO2GFyj+fiV3SuyVJ2Y42+mRbyW/7ElsBa1CNMy2djxdn6qk9VeFXdgAtu5x
GvXjgHy0jCU12k69fnForN4X5blL+qwimHM+7SImDsdRBAeOzFGlYpdzoGSgZYOd
L32rqooQtCRifiqy7+oiGhs3sZ9XxGnIRaxbSKAAOAF8F3NtDFUhIGewS/txtYg7
ziE1WXPeL9HyBHHG4zhllNLbAu2lvrcdyXuZmZ3vcFNm5vYQPQDvje2Y4xz3Ovc7
81tAaNigqc4a+/UxotydmPzUrVLfgDAFcy9pEJps2UUh7aWe6mY=
=pbXc
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
