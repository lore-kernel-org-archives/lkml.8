Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646C7C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C0420658
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583410326;
	bh=2lpSsnV5V9Oa5sNvXz0IcGl2n2PCqLJrUGHbh++pFUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FHMVEOeiqCxTAXEX5JU9tSrzSDUHgIxeagEBc2tW16K0aW1stCcA27uEPpsgB6Gan
	 xAnNeaiKXjH4MY4e4iZ0+Dp8Q0ASoc1bY3Ls+H0TpAd7+brZYeu4MOcoQKO8/vC6L8
	 fZvF6Vh1+4L2dbxo+/brgerYxfOBA4p3+1jZEMqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgCEMMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 07:12:05 -0500
Received: from foss.arm.com ([217.140.110.172]:47830 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbgCEMMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 07:12:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67D0431B;
        Thu,  5 Mar 2020 04:12:04 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEDF23F6C4;
        Thu,  5 Mar 2020 04:12:03 -0800 (PST)
Date:   Thu, 5 Mar 2020 12:12:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        eha@deif.com, angelo@sysam.it, andrew.smirnov@gmail.com,
        gustavo@embeddedor.com, weic@nvidia.com, mhosny@nvidia.com
Subject: Re: [PATCH 07/12] spi: Do spi_take_timestamp_pre for as many times
 as necessary
Message-ID: <20200305121202.GB4046@sirena.org.uk>
References: <20200304220044.11193-1-olteanv@gmail.com>
 <20200304220044.11193-8-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Content-Disposition: inline
In-Reply-To: <20200304220044.11193-8-olteanv@gmail.com>
X-Cookie: When among apes, one must play the ape.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2020 at 12:00:39AM +0200, Vladimir Oltean wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
>=20
> When dealing with a SPI controller driver that is sending more than 1
> byte at once (or the entire buffer at once), and the SPI peripheral
> driver has requested timestamping for a byte in the middle of the
> buffer, we find that spi_take_timestamp_pre never records a "pre"
> timestamp.

This is a fix and so should have been at the start of the series to make
sure there aren't any dependencies.

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5g7JEACgkQJNaLcl1U
h9Chiwf+On3bebnRG/0bCvM4m9UoJ3euPVdOY1kKcGGzF0tOUWjGenpRsTQh+vsp
vAE31eCPdss6Fv5wvgdS3KtJGvcXjptXipSFu3KSrKBoBls23CXGD+c8IpFRvdQ8
tbvLtb3jelZt45+TVASwIKlUXplBRqcpxOKo4wi+9LWYjwK+5HRYJLT9RyS8sTRM
e/2YTw6MMpqAaSTh0S6BOHgg/MNQT9aB2rzDigkO+JbfI84w9eiAzDAN9J/OuT0Z
8j1upFtnkq2vQ4wfg0btLD2ZgWUvr6sr7qC7uyuTw5/D594N1/GPGqg9xIsT5Ayp
dV9ERzRx6f85sqEtI5VbchtOOYN9eg==
=WVjV
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
