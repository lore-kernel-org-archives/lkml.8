Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24FCC11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8522D207FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582217276;
	bh=z+CeYDHC0k5sFg4fqy5ily4/OeLvddh7vB90HYAWDlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ns0cNYugQw5lZ/6KBT/qdkkg/546t8Oup+usSq8H/w6Ztm5QoCpxEmQgX8hfryqY2
	 +Ima+GuHBWL5Xnb5Ud4BnBa1JLuIgvDrG8SnJY6ORad7dZ7mej6sR2Gsk61Pg2XjWB
	 fTy0ClKr2GDAXk37jJhhQIzdkLX3ya3iEqoQ8B3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgBTQrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:47:55 -0500
Received: from foss.arm.com ([217.140.110.172]:46648 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbgBTQrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:47:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88C9E31B;
        Thu, 20 Feb 2020 08:47:54 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F230C3F703;
        Thu, 20 Feb 2020 08:47:53 -0800 (PST)
Date:   Thu, 20 Feb 2020 16:47:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oleksandr Suvorov <cryosay@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opanyuk <igor.opanyuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>
Subject: Re: [PATCH 0/2] trivial fixes for fsl-spi and spidev
Message-ID: <20200220164752.GC3926@sirena.org.uk>
References: <20200220141143.3902922-1-oleksandr.suvorov@toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Pk6IbRAofICFmK5e"
Content-Disposition: inline
In-Reply-To: <20200220141143.3902922-1-oleksandr.suvorov@toradex.com>
X-Cookie: You are number 6!  Who is number one?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Pk6IbRAofICFmK5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2020 at 02:11:46PM +0000, Oleksandr Suvorov wrote:

> Oleksandr Suvorov (2):
>   spi: fsl-lpspi: remove unneeded array
>   spi: spidev: fix a max speed setting

Please don't merge unrelated changes into a patch series, at best it's
confusing at worst it can result in unrelated patches holding each other
up.

--Pk6IbRAofICFmK5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5OuDcACgkQJNaLcl1U
h9B54wf8ChnpYtAo6GZoBiIyPR6xHM0A2f44wKWo1bk/+lN39rm75kZ2Y4c1iypV
stZLFnvLr6TnHyWlkj9oVczi+RkqaNQw7aksUnJPCi6fQkIl/2Cc9VwD1ur0Af5u
Oj+pZtQRnOsLkUdQY9rVSd8KRD1bJK8m2p30FpaHSv3Zj/TYvEwl9hoH6MEq6uuL
dbvWSiiIi0OArO1WEniGx0nOiwSYP6GMWLZXCy3vjp0QxLYc636VT2IkOuRdAwDf
CE4uRGHjmvry4CeZx2m0vus18GmiqMQwML+Q2QNFiu3wTb2tTYxbtBCmN6QMT2p+
6EEKD76g9d03RuDF5bsYmcHfCZWaJg==
=znQo
-----END PGP SIGNATURE-----

--Pk6IbRAofICFmK5e--
