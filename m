Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32D7C3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 11:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C21CE24673
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 11:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581593824;
	bh=KoMi3mqOQE1OFyVlsv0WPVN9MqomVPafDTkEPW+lwaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0jCKIPSK5g6YdFQv+8gtbs9g+MoJov+GVQrdiwnV7ERRS04ortVRspOPdnJ6p/2l/
	 nnaWw6RyRx8tElnLwpY9OMDUlQ48IDfclXfI9PvLu/my4CyXyNnFo6hjArAPKxkE6d
	 93zEJMzbhiXAz46KPlwqRQ9FuvobHdK+0Ak35x6c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbgBMLhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 06:37:04 -0500
Received: from foss.arm.com ([217.140.110.172]:45350 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgBMLhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 06:37:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B9201FB;
        Thu, 13 Feb 2020 03:37:03 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4F8C3F6CF;
        Thu, 13 Feb 2020 03:37:02 -0800 (PST)
Date:   Thu, 13 Feb 2020 11:37:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/4] ASoC: codec2codec: avoid invalid/double-free of pcm
 runtime
Message-ID: <20200213113701.GA4333@sirena.org.uk>
References: <20200213061147.29386-1-samuel@sholland.org>
 <20200213061147.29386-2-samuel@sholland.org>
 <1jr1yyannl.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <1jr1yyannl.fsf@starbuckisacylon.baylibre.com>
X-Cookie: Academicians care, that's who.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 13, 2020 at 09:37:18AM +0100, Jerome Brunet wrote:

> This brings another question/problem:
> A link which has failed in PMU, could try in PMD to hw_free/shutdown a
> dai which has not gone through startup/hw_params, right ?

I think so, yes.

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5FNNoACgkQJNaLcl1U
h9Anuwf/SQT6ubriSIEq1TwGCzPNYCbx2WjOhRIjTbtNwtmezyCgzCOThrEEuRZh
VjvYkn7VqZBgoHsh43+vqiwtI3eLXwrX02o4izW1srdqfh2ZDAMmHH37qf8zfYmv
S7bC9gDSY8sFOjSevEKgk6MC/3h60PKK0Q7FWc/A1B8Fqo5ZaoeuYrMqw0x2yQVI
1DRTlhVoOKIQ+tjKIPmRwTt1KyJi9FlhN5oW2hEpIpMOK34jnVyKBMHESopGF6tT
fFPPHWKfZlxP8SkwtcYsH1xxrZC5LwlPA8haNBQAtniDaVG+PlndvoN69UfBudPw
s7tJfn+2MEXC0NEJzXukYpwwHkuu1A==
=r51Q
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
