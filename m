Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7984FC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BF3B2078B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594395338;
	bh=gI3yEGsGyMaUOOnDy+UZFfrMEPrpJsahOsnjo0T8Coc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g3L3wqHUgDaqvfL+1njac1MuP5hSooJ/T0vzRbDTxgvKcvr1ntzlPOKD5pLLkiaKa
	 gPtNwDP+DN+CnZEgMU7K9tbRcDBUUGs0HrYdfkwFuD+/8QqqxRJ+KpQgetkZOBgD/U
	 dtfx5b3gGX3yFRfPSStdO+dAtWmdhYerid11Xl6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgGJPfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 11:35:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbgGJPfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 11:35:37 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53F9E20725;
        Fri, 10 Jul 2020 15:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594395336;
        bh=gI3yEGsGyMaUOOnDy+UZFfrMEPrpJsahOsnjo0T8Coc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0HLdx85blFvC788EU5GISpD8YvLXgUcUqFLh1FxvQIhJA12/km9XIFkEF3IXMXm2P
         nsw8XESdyQSCcinvt3Aq6Moa/pDJO2nANG7PoXscm0YfNnjvrNSGS9JuyXQk+dUxWG
         4BKm0M/Zfk5CDuyE0QEo0tTk8dRS76QzbWH4m4jk=
Date:   Fri, 10 Jul 2020 16:35:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shreyas Joshi <shreyas.joshi@biamp.com>
Cc:     linux-spi@vger.kernel.org, shreyasjoshi15@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-cadence: add support for chip select high
Message-ID: <20200710153530.GA46888@sirena.org.uk>
References: <20200710045140.458-1-shreyas.joshi@biamp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <20200710045140.458-1-shreyas.joshi@biamp.com>
X-Cookie: Do clones have navels?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 10, 2020 at 02:51:40PM +1000, Shreyas Joshi wrote:

> spi cadence driver should support spi-cs-high in mode bits
> so that the peripherals that needs the chip select to be high active can
> use it. Add the SPI-CS-HIGH flag in the supported mode bits.

This doesn't apply against current code, please check and resend:

HEAD is now at 3ea4eac3e29f SPI SUBSYSTEM: Replace HTTP links with HTTPS ones
Applying: spi: spi-cadence: add support for chip select high
error: corrupt patch at line 18
error: could not build fake ancestor
Patch failed at 0001 spi: spi-cadence: add support for chip select high

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8IisIACgkQJNaLcl1U
h9DBxwf/SNduPQaFfCuvDvvx11pYNTr1Jepbd3k5HKVQ+kEu7WG40id0/bBfbnFg
apY8ORg1zqSq4Q1zogVp42+OnQ0qVrKOIYPEAXr4ztDzA7pM0LfNdKtkon2ZBkJS
IJ6p0ic+/j4X4FTZddd/cNn6oFERL2Gjnoa0QD5MjRhlEufMyybvRZj1zGWWpcF+
hIXIEuKJrrUzyF2BCVHnmdr9Bn2jqcMsIVXc8Mm5VDdHSTyax0V8TxSlttKmnBLa
LoXyvqRE4T3hF/WmOHswjhlXaZKNVhkw1O5mzkyUun5mAya9wtmtrU1QXqGvv1P7
f8nmdDKKnccShhOjafcjckrcH2Uwiw==
=NRw/
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
