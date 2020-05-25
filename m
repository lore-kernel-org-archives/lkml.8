Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AADC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 720552078B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590406273;
	bh=5c6uW1f6UmlpEVp3Jh0kjKBM+YIsIJlZEU+/RGI2ni8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tqEMLRJou7dhxdyEHZE+onpQKWMJy+jQ4w7lBoC7GxmycnToD4AhhaYWXW6nfNKH1
	 5pBy8xuzXWgd2qS4L3n44z4tAgnP4InwqhuGCoFk6GFreRLmOUgjdUfIXJKcwbVmJ1
	 rmQVLnnxBeyINQmifGi8FEqQNRSyCrqOYhsjGT1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390401AbgEYLbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 07:31:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:50972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390387AbgEYLbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 07:31:09 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C5A8208B8;
        Mon, 25 May 2020 11:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590406269;
        bh=5c6uW1f6UmlpEVp3Jh0kjKBM+YIsIJlZEU+/RGI2ni8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bWTUk6/gKbvD8qzv3IlOsJMPWNcBzwNkpcL/S8bgMOG5DDt10lFZ28qvmWpky+QG0
         aUO7VJ9p26/7CDqH2C2Or+XlVa7lTc2H6vPGPzgJt2dzCnnFn7ONx5e3F0UGMovrUL
         F207Oi7ZxuRPhZdUJdSc3GoYJJmEcgrDc/KQjMWk=
Date:   Mon, 25 May 2020 12:31:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Tim Harvey <tharvey@gateworks.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>,
        Timo =?iso-8859-1?B?U2NobPzfbGVy?= <schluessler@krause.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, Jan Glauber <jglauber@marvell.com>,
        Robert Richter <rrichter@marvell.com>
Subject: Re: [PATCH] can: mcp251x: convert to half-duplex SPI
Message-ID: <20200525113106.GB4544@sirena.org.uk>
References: <1582655734-20890-1-git-send-email-tharvey@gateworks.com>
 <0ac77abd-0df5-e437-ea46-f6c77f59b81c@pengutronix.de>
 <CAJ+vNU3vk92_1UnrYH72QgD3-q9Oy9As=jCiup42jzx_2LG9FA@mail.gmail.com>
 <0b351fe3-8fe9-572f-fd85-e2aed22873e3@pengutronix.de>
 <7b85e098-b9a9-dd14-203f-100cdf2e703e@pengutronix.de>
 <CAJ+vNU06DHVS25OQR1Kqyzy2ZxLVq-HdwenGv-jN5Rb3r8F86Q@mail.gmail.com>
 <e0f641bc-5473-792d-fea9-0a2e81fe1e38@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
Content-Disposition: inline
In-Reply-To: <e0f641bc-5473-792d-fea9-0a2e81fe1e38@pengutronix.de>
X-Cookie: Help a swallow land at Capistrano.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2020 at 01:17:01PM +0200, Marc Kleine-Budde wrote:
> On 5/21/20 10:19 PM, Tim Harvey wrote:

>=20
> > Should I be submitting this patch with logic that only does
> > half-duplex if the spi controller doesn't support it (if
> > (spi->controller->flags & SPI_CONTROLLER_HALF_DUPLEX)) or is it
> > acceptable to simply make the driver half-duplex like this for all
> > cases?

> Please make half duplex transfers depending on SPI_CONTROLLER_HALF_DUPLEX=
 as
> most drivers have a considerable overhead at the end of a transfer.

> Most of them wait for a transfer complete interrupt. Which might take lon=
ger
> than the actual SPI transfer. Splitting one full duplex read-register tra=
nsfer
> (which is a write followed by a read) into two half duplex transfers woul=
d kill
> performance on full duplex capable controllers.

This isn't something that every individual driver should be doing, such
rewriting should happen in the core so that everything sees the benefit.

--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7LrHkACgkQJNaLcl1U
h9DwqAf/V+1R+vBRqkKkyks2bM3wtNzPWu0J6yu5m72o4v1ta238UGDZ5MUZhlqF
3ofiN6ZiLfy4a5xnV3JvdhqKJ6vtqbJOFIRH/PJ854KvA1vguhUqg1Nq0mylm2Os
Z9bUOhk7x5MzYEtOntpOm4E+Xx/RSTr07gxz72Lyk/9VovTdsv/3yRSalNAM47zq
wSjJ5YE9nX00qw0NW1S2Ix9b97BMjhcHISFcB14kiLTTpOBQ5G77dPPDXNzNK+fV
BHaMi6S2s0HtwMOnZO5c7huaGrA5a0zX2b+UognPUtZKjDSSIETXbycHFLoR+iqR
zGazUbVbLveAyK65adOFXf2oJOGjRA==
=802q
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--
