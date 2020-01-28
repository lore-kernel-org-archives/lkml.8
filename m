Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E25C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 12:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFFC224688
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 12:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580213027;
	bh=Fy0UsXjvLwh38SAvFXY7MyHHnKDTMMR9HZA94bEZquo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SHu69DkQk/sun5FF2fgqWjsdGeb8vy/EYX4CEtNJhKyxYss3/WXWX0NCL5dSYcyMM
	 YU6sfdnBqIhNZxlY+xriyD31fPpIYKXmyEtRHVTIQPG9JUQIoMdmjJquBA2/tXIwcs
	 V2CfNWLVspycSrvPyN6B+cwVRdjD9jpnFUT/AfUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgA1MDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 07:03:47 -0500
Received: from foss.arm.com ([217.140.110.172]:55916 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgA1MDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 07:03:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DEF81045;
        Tue, 28 Jan 2020 04:03:46 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D20FC3F52E;
        Tue, 28 Jan 2020 04:03:45 -0800 (PST)
Date:   Tue, 28 Jan 2020 12:03:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Axel Lin <axel.lin@ingics.com>
Subject: Re: linux-next: manual merge of the mfd tree with the
 regulator-fixes tree
Message-ID: <20200128120344.GB4689@sirena.org.uk>
References: <20200128120220.53494c29@canb.auug.org.au>
 <20200128073901.GB3548@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Content-Disposition: inline
In-Reply-To: <20200128073901.GB3548@dell>
X-Cookie: Doing gets it done.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 28, 2020 at 07:39:01AM +0000, Lee Jones wrote:

> A pull-request was sent out to avoid this.

> If Mark pulls it, this should just go away.

I didn't pull it in and Linus already took the regulator changes for
this cycle - I tend to only actually merge the pull requests if there's
any issue so that I minimize the extra bits in my pull requests and this
didn't come up in -next until just now.  Sorry about that, it does look
simple enough though.

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4wIx8ACgkQJNaLcl1U
h9DlRQf9Ey6+epFAeW4prJdxkMnbpkjcswISbTZKF553zd6u/HpqL8HF6UTmCwmd
8qTxOJJp6cb4BbV+xq4NLX4lbLvKo9QPkS/4/JTXPo8vaLRj/LGNv8scLc1B9GX0
lAv9IAVnKIMtlRjdAscheQoLKM9efZEQgR9EuXwN6e23WR4+b1ZD3BmyIGlNwDyp
mX6cTrXMznnvpFHJ28fhbq80CqQz98VbWSY0NQaM66zCAK5Ip5S3wXnR64iuKs3a
lKXoJNbra6evaN1AHfie3vpvODTuCyEkQXZXJxqMuFJs1SeAMgR1ETVMl+fDI6Rk
532++edd/yPM8gMN+Baidsnutz0mig==
=bfBp
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--
