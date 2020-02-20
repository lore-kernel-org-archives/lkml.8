Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F2CC11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 11:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49851208C4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 11:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582198853;
	bh=wbxtfRgBSjGv58kHfznnX+St9qnkc2GFxuMkzh3i23Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yvff78Qi8T6mZeygTm5KMy7ghDavwzG8P/8VJ8k448/J2NYyC9c8Q7EJzfA6VIo3c
	 M39lVWkTFyppNfIBQrwDCkdaRZLSU/ys3emjyzLUYUTRnM7Qy9vohAtUrJq91/wTM0
	 eXOphXPZ5H8re5aIchOdvZz983uzuJUEQ+NH+Vs0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgBTLkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 06:40:52 -0500
Received: from foss.arm.com ([217.140.110.172]:41048 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbgBTLkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 06:40:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3AA630E;
        Thu, 20 Feb 2020 03:40:50 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 785883F6CF;
        Thu, 20 Feb 2020 03:40:50 -0800 (PST)
Date:   Thu, 20 Feb 2020 11:40:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Konrad Kociolek <konrad@cadence.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Add Cadence XSPI driver
Message-ID: <20200220114048.GA3926@sirena.org.uk>
References: <20200128124212.12298-1-konrad@cadence.com>
 <20200210191620.GE14166@sirena.org.uk>
 <20200220082354.GA15619@global.cadence.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <20200220082354.GA15619@global.cadence.com>
X-Cookie: You are number 6!  Who is number one?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2020 at 09:23:56AM +0100, Konrad Kociolek wrote:
> The 02/10/2020 19:16, Mark Brown wrote:

> > >  # Add new SPI master controllers in alphabetical order above this line

> > Please keep Kconfig and Makefile alphabetically sorted as the comment in
> > the context from the diff says.  :/

> What I see is Kconfig is first and Makefile is second file in diff,
> according to:
>  drivers/spi/Kconfig            |  11 +
>  drivers/spi/Makefile           |   1 +
> Is that wrong?

Please keep the *contents* of the files Kconfig and Makefile
alphabetically sorted as the comment in the context from the diff says.

> > > +#ifdef CONFIG_OF
> > > +static const struct of_device_id cdns_xspi_of_match[] = {
> > > +	{
> > > +		.compatible = "cdns,xspi-nor-fpga",
> > > +	},

> > Why -fpga?

> This is because this driver was tested only on FPGA board.
> This driver was not tested for ASIC version as PHY
> initialization algorithm is differ.

So there will need to be a separate compatible for any silicon
integrations?  Will that always be the same for all silicon integrations
or should we have properties for the PHY type?

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5OcD4ACgkQJNaLcl1U
h9DjWwf+Kw59oWOq88WN/+Io2xu9qfSpF63ViQuy5f1M3hFbAlGWYEyUoHWkucac
8fPxVqV+5XC3FtIABoU6DYGYoTLnXul0Q6aPE0RCmCPxiRUHl8h6ZNOgNT6WeKXV
TcETE1T7JepwhjT+FL2Lu/ydw4whC1m+CJ6H7grD7gHLktS0Ks64Wi2279R9COwq
chvI0lHmjsrcnsnqUVngI+ZFRbuF4rKIlzzehUuyOcNEEu64+ZW4NgzC99VbyWpp
GDUMIg3UEcWIAjylC8gwLVHFp/SuX/NK5Odp41Fc4079kxhBz1sgYKn5ty8YyRYc
YhOuT0n1aVA03Ph5WddcvDF5P9gIjQ==
=RQrs
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
