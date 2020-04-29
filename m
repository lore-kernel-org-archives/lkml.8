Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B69CC83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FB692082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588153966;
	bh=fgchB9Hy9Q42vSE4QE2yDAjnccaNZoihYV4J2q/0wB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UvJG3963ScfGxU2XdVinY0MYKJydGpBb044SPAaqsbOrXOZImHXSGGSvF7QZvDZYe
	 hmh5BIT9+Th5C0rGYHFvtn1raftllOzcTmnZsyDEPMTpCi79Hb30GqJ8ZnCIHgE1jH
	 XhK0SldnKlP3WCdXGY626qc5zgRUdoYoSu7WIV5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgD2Jwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 05:52:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbgD2Jwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 05:52:45 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C675120775;
        Wed, 29 Apr 2020 09:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588153965;
        bh=fgchB9Hy9Q42vSE4QE2yDAjnccaNZoihYV4J2q/0wB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NL5FjF5ygH7Ft8laDmQpxD/1zZBl4lX0HV+97yFiBP3SIV0MpQXz45XDwJMwNjglc
         FEDk7CKptHwotxvO5Cd09dpOacPlTYCKNWmrAUvU0pSGXDWCVP/xhvJvwf4iFYqlFg
         YYtx6Bg2Ds299GawNfLq0OtE0Le6cISDIGaghFMc=
Date:   Wed, 29 Apr 2020 10:52:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sanjay R Mehta <sanju.mehta@amd.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-amd: remove unused variable
Message-ID: <20200429095242.GA4201@sirena.org.uk>
References: <20200428213711.3643464-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <20200428213711.3643464-1-arnd@arndb.de>
X-Cookie: I know how to do SPECIAL EFFECTS!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 28, 2020 at 11:37:02PM +0200, Arnd Bergmann wrote:
> This variable was defined in the original version of this file but
> never used, so remove it to avoid the warning:

This is already fixed.

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6pTmQACgkQJNaLcl1U
h9ApRQf/Rmb30mXV3uAh+LPCXo9mjqQkznzhNXBAHpkPlLwsvm7t7KJp/JMHRcCA
O2Vn1VadekdHlp8Rq7g8Woq3Vh6/HyT4S5vQHZRI3rFPclIE8Kdzu7Q2PNnDa6JI
BiVNzuL8cBdyYtL8H83BXVB24/NSE4c7eeVvQpv9KGhAkCllG1QclfB/yqISWfub
i8v+ftCj9p2tMxbjfgaw540AYPs1GcvTKy3VN2lYtnR83lNBriHm6tdTX4Hd8/pZ
oMhz9nQvdKGn/OTcM1BVuAuDWV7ZCUDMl5kmeR1Uyms8o6g/j201V4LWHN4Vn21x
UUcwUxzY+piJRQ0V2IMjiQxS8JGnRw==
=YC61
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
