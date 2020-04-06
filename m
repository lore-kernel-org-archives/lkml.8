Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A78FC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 11:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68BC12072A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 11:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586173812;
	bh=T8JPB2G201IEXtY9alosGKryKAmkDfl6bXQtj/eFyw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LUJCR/AN7n8r8MiLHhhLIH5Db6R91JTMIQlEj7CbvKZ03kmM/2nd9qoCQKLkh7fst
	 sF6Uf6GqOQ1F9vNeqE8O0Tx61lDhh7aL8sf9620biAjajymV2u8qvj+hlr7c5O1Fme
	 3Tqy5q1lyWRrExJyEsT4I3es2sspgsB0pfYLFBhU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbgDFLuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 07:50:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:41534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727376AbgDFLuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 07:50:11 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F841206F8;
        Mon,  6 Apr 2020 11:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586173810;
        bh=T8JPB2G201IEXtY9alosGKryKAmkDfl6bXQtj/eFyw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qvyM70Aitm0A8bkQA9KFhhF+YBMwVWKMlbAXpGvIlOPB5IymIJfiYVSv8iP4QkML/
         lQbPiycMFY5IpuJ8pTonEj1ZtW1CKB1V0TAUX7A3Udswogrt1vu4q0RGwwwsVO7D7/
         +pX6sL+5s606/Oy82X+VJEoRkXsS12NDjvAwn6bo=
Date:   Mon, 6 Apr 2020 12:50:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     lgirdwood@gmail.com, heiko@sntech.de, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: sound: convert rockchip spdif
 bindings to yaml
Message-ID: <20200406115008.GA7650@sirena.org.uk>
References: <20200404115225.4314-1-jbx6244@gmail.com>
 <20200406110703.GA6837@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <20200406110703.GA6837@sirena.org.uk>
X-Cookie: Ahead warp factor one, Mr. Sulu.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 06, 2020 at 12:07:03PM +0100, Mark Brown wrote:
> On Sat, Apr 04, 2020 at 01:52:23PM +0200, Johan Jonker wrote:
> > Current dts files with 'spdif' nodes are manually verified.
> > In order to automate this process rockchip-spdif.txt
> > has to be converted to yaml.
>=20
> Please don't send content free pings and please allow a reasonable time
> for review.  People get busy, go on holiday, attend conferences and so=20

Sorry, I just noticed that there are actually some changes in this
version.

> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

This bit still applies though.

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6LF28ACgkQJNaLcl1U
h9BQDwf/TLMzjvaOS/XrkaDPT2V2JBzzwos/AckUmEy1bGBb3gFmfuV5mHpZFfTM
f1svscqWp5VgXssq6EGCwZnUpmyGjo1AcJTq1aYCAgXa65a7c8D8QS2WwzYlFeFQ
NMTO/Vd5q/9qjreQSvqWCXByFF1lSaNX3LOq4F1b8wEloSjFUv33W4AgewOq8g6P
evxzb1IsiIUv9CJsOgz/cPAud4FseYOuh4H1L+TqigrDd4z1i9nUXeluSvmswf0k
WJGHHvU2xxLjFicbQeJrG5VyXHSELl6JRdbojGFPksD2SKTnHXl3+/mLDWHYzFW4
4YhxljCFCaRnx+ofEiOsmPEjt/HEOQ==
=y6jt
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
