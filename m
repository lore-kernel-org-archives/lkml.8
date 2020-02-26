Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627A3C4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3637320838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582717630;
	bh=z6J9fTqAyypWlJzEtsf2ZsFxAYr+K/7v3vId7HLMfMk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Bu0yLw/7Gh7idm5ETdswCvKdHNygV7UzCyRdZXkrKYZeXA6ya79yRepyA8ixS8Bok
	 qUlO1zvm2sbLW/axJTTDUmioBXKrUEaqySZKsUkyKWr1O5Rwh1jNbtO/bahQV4egzG
	 DsOV82bFiU9Ea7C0rMskV73TvU0JMyYwBj1yNnWw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgBZLrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 06:47:09 -0500
Received: from foss.arm.com ([217.140.110.172]:34722 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbgBZLrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:47:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 034F01FB;
        Wed, 26 Feb 2020 03:47:08 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CDD13FA00;
        Wed, 26 Feb 2020 03:47:07 -0800 (PST)
Date:   Wed, 26 Feb 2020 11:47:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Wen Su <wen.su@mediatek.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Applied "regulator: mt6359: Add support for MT6359 regulator" to
 the regulator tree
Message-ID: <20200226114706.GE4136@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BQPnanjtCNWHyqYD"
Content-Disposition: inline
X-Cookie: May all your PUSHes be POPped.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BQPnanjtCNWHyqYD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2020 at 01:24:11PM +0000, Mark Brown wrote:
> The patch
>=20
>    regulator: mt6359: Add support for MT6359 regulator
>=20
> has been applied to the regulator tree at

=2E..and dropped because the MFD dependency isn't on a newly added driver
like it appeared.

--BQPnanjtCNWHyqYD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5WWrkACgkQJNaLcl1U
h9CcEQf/fTClkyhw91wJ8T4PYzaeB2YSTLUcovlEKQtLgoRLhr64DdJChFwOpVbo
itCCdetK4Jf5iR5XWK08ATROaahFfV67rKex99LgRzhT9fqjLZE8HzW3HBIXSsgz
xw0mUNVQzzvcXGw2MVsJW6Hc/ETLbmzhvmic8SubZ1pEX9L4zt2SGfJXyR0UY2CN
f2ca9n3qa1YlGA0KpFbjTgJSvt8WPcCSXZcszFcw2L/iuan/X6LNCY622V5E0jp6
1MY5N9BpkQXz/otHQih0n5m+AnwtCZsCzOmupA0JMMPi3xolctAEdo245I0h7PmH
bRMYK1sbMPTqh+fEpLabJ2buc9kFEg==
=a6a7
-----END PGP SIGNATURE-----

--BQPnanjtCNWHyqYD--
