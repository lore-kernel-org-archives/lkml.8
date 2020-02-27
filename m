Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A311C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC692469F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582817351;
	bh=EODQLJHSbd4botB6vyDb59ep744w4ABceyuwCTRPFd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Lil/TAzWq5Kby1gdudU5GmA2ZjpQ/67EEHNcIgmW/TwnviLOqbhXn2papiIQFB/DS
	 g+o/iJR1byKWipFS6bOBBJAzmmyPmjQ1cCRaBY3Gfqd6YcF0Yj/USEKPfebmtBcjQx
	 P734ZO2fhGekZ4DfJuFHhXaSnlol1a5rWn/PtVrM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbgB0P3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 10:29:09 -0500
Received: from foss.arm.com ([217.140.110.172]:53696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729166AbgB0P3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 10:29:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA1AD30E;
        Thu, 27 Feb 2020 07:29:08 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FF083F7B4;
        Thu, 27 Feb 2020 07:29:08 -0800 (PST)
Date:   Thu, 27 Feb 2020 15:29:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, kdasu.kdev@gmail.com
Subject: Re: [PATCH] spi: spi-bcm-qspi: Use new structure for SPI transfer
 delays
Message-ID: <20200227152906.GD4062@sirena.org.uk>
References: <20200227141050.10969-1-sergiu.cuciurean@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DrWhICOqskFTAXiy"
Content-Disposition: inline
In-Reply-To: <20200227141050.10969-1-sergiu.cuciurean@analog.com>
X-Cookie: Edwin Meese made me wear CORDOVANS!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DrWhICOqskFTAXiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 27, 2020 at 04:10:50PM +0200, Sergiu Cuciurean wrote:

>  	if (qt->byte >= qt->trans->len) {
>  		/* we're at the end of the spi_transfer */
>  		/* in TX mode, need to pause for a delay or CS change */
> -		if (qt->trans->delay_usecs &&
> +		if (qt->trans->delay.value &&
> +		    (qt->trans->delay.unit == SPI_DELAY_UNIT_USECS) &&

It doesn't seem ideal that if the delay ends up specified in a unit over
microseconds that we end up just ignoring the delay entirely.  This
probably needs fixing in the core though, for example allowing the
driver to say what range of delays it can actually implement.

--DrWhICOqskFTAXiy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5X4EEACgkQJNaLcl1U
h9AuKQf/VwDsH35+efmI58edDRHc3b1P9SXWdUTz+6yZOMfKofhGJlhnhkoHheqt
kfVUG2SxvNDzDpmoZLW5KscTW0WcY3Le/15dLQoXpbRyshvNOiP7y4K/GJrlHCr/
fic/79xluk+5b+abPXyARC/wjaVN2lNgl1dPVuvXvIN7Regl45EbWX53gFPybxiF
lIQkR0ZA64jgUsDMF+ogiqW05kE6/rWo4OkMgqKKvkIAHeFoxSFmpxUxQYXDencr
w8tCW4F86F5FifuAhHOmXv95ZvuIaG8Lyu9MCOOI+EBUj062yM3D0FXbWkdy+umU
qKF0F3Y/cCMHZdzA4LIri/M8lk23VA==
=qSJi
-----END PGP SIGNATURE-----

--DrWhICOqskFTAXiy--
