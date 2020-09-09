Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB0EC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10C84206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599668505;
	bh=d1VPp2eGTbfk4sew+NdAoO5ayog5TMbbY751vFWzHYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v6218IYf5aCPL/bjbm+n7xt+e3dMgQVDF5P6FTGuhPxNPfNksuCVb+rIHV70MDS9h
	 tv2Z5TMZAgd+tusx5KZ5RLYC9ka8ldqAGhjY/tLv0MaYiZtlcBBC9GbgVDbCx/hA58
	 eBB+eVpKBPcacEvHHPXAtpz+94V+30PMKhqTNEqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731020AbgIIQVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:21:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:43206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730960AbgIIQUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:20:37 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C78FD2080A;
        Wed,  9 Sep 2020 12:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599652954;
        bh=d1VPp2eGTbfk4sew+NdAoO5ayog5TMbbY751vFWzHYk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MIdj8AT1nbtAiLWaw61l4SSyyy7x4leBftdyuc+EbAK1AoirXhmDAnnB12j5oIeFz
         aeZbokP+qcIvyQgnp7VSRVs3Js8Pd1X+BySDq882jN6wDpRoxAsAwJlVOYp8JlaDgL
         KWJS1ETKifh0+aqDbYT3hwXgsWBb2L31bCJ8oNNQ=
Date:   Wed, 9 Sep 2020 13:01:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
Cc:     Ashish Kumar <ashish.kumar@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Varun Sethi <V.Sethi@nxp.com>,
        Arokia Samy <arokia.samy@nxp.com>
Subject: Re: [PATCH v1] spi: spi-nxp-fspi: Add ACPI support
Message-ID: <20200909120148.GC4926@sirena.org.uk>
References: <20200908060227.299-1-kuldip.dwivedi@puresoftware.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
Content-Disposition: inline
In-Reply-To: <20200908060227.299-1-kuldip.dwivedi@puresoftware.com>
X-Cookie: MIT:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 08, 2020 at 11:32:27AM +0530, kuldip dwivedi wrote:

This appears to be v2 not v1?

> Currently NXP fspi  driver has support of DT only. Adding ACPI
> support to the driver so that it can be used by UEFI firmware
> booting in ACPI mode. This driver will be probed if any firmware
> will expose HID "NXP0009" in DSDT table.

As I said on your previous version:

| Does NXP know about this ID assignment from their namespace?  ACPI IDs
| should be namespaced by whoever's assigning the ID to avoid collisions.

Please don't ignore review comments, people are generally making them
for a reason and are likely to have the same concerns if issues remain
unaddressed.  Having to repeat the same comments can get repetitive and
make people question the value of time spent reviewing.  If you disagree
with the review comments that's fine but you need to reply and discuss
your concerns so that the reviewer can understand your decisions.

> @@ -900,6 +910,8 @@ static int nxp_fspi_default_setup(struct nxp_fspi *f)
>  		return ret;
> =20
>  	/* Reset the module */
> +	fspi_writel(f, FSPI_MCR0_SWRST, (base + FSPI_MCR0));
> +
>  	/* w1c register, wait unit clear */
>  	ret =3D fspi_readl_poll_tout(f, f->iobase + FSPI_MCR0,
>  				   FSPI_MCR0_SWRST, 0, POLL_TOUT, false);

Why are you adding this reset?  How is it connected to adding ACPI
support - it looks like it should be a separate patch.

--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9YxCwACgkQJNaLcl1U
h9Dw+Qf/Q3uvLOUD0+1rXIWEQAQHg8wHohO05a6mn6uFYSxUUPgXEy8Z6uSVAhwV
4f7yQVvZohw3A88mE0kNp4/9FJ5Lr0P7s6iFSWmkVKC8oYRAjuy04BYARUeLr/GS
LFoMyxc4OzGUUpqRXNiw6+i7aYZjjQlJ4/OlJwxQGhfW8/vfy+R0fFQE7rpekkvb
mwLVKCbPDhdryUi+ehCqkJ24Yb+DaQFUutr205wGKxbMm0Yv8QWOeuRoUnaysr5e
FbaW0iGGSejcmKezQHqqF99YfY5yPJeFCAUP/n0diqJBcypJHmZBJjV4PgSBAkAA
92ipwXC0WYVajy+isIB3W7zfzmfwXw==
=t/eJ
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--
