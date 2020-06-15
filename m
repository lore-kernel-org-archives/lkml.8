Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A57C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 11:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F7E92067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 11:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592221779;
	bh=KBS3k962uIeoGIj7AE9xCtqXokyAYDPTKBzow9UPIbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A+3vsmUMxtWvprzm7JTBPmd6eGk8buRKIantIQwT+yGY/23q6EgJ8GIr1Vzm9M3cn
	 Hk5EKHCSQjPtE7M+lSicgKGcTWUnZN62mXdeUC57Zj10y2axwJOc/upFAu77+gxpAd
	 5Ex0tviEMz8xP92p2JCO3EkAc/JtWezSolCwN0vs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbgFOLth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 07:49:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728285AbgFOLtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 07:49:36 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F8142067B;
        Mon, 15 Jun 2020 11:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592221776;
        bh=KBS3k962uIeoGIj7AE9xCtqXokyAYDPTKBzow9UPIbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EXLYpGnNS0pqxJH7aoMvgBLh9EaD5elG5QJD6JyGX+QHPiFZUL5IUVRs9E0togdYa
         n61UQYJE0LdU5rekLyFy7YBrYhJ4LCKka89wOoy9B0d7+QCCgYH8hgVmJy2YHIBxAH
         LpYEpVyfxpwdc/uy3azVsoRptB5h1XYCw0jQoSSU=
Date:   Mon, 15 Jun 2020 12:49:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v2 2/2] regulator: Add support for sync_state() callbacks
Message-ID: <20200615114933.GF4447@sirena.org.uk>
References: <20200528190610.179984-1-saravanak@google.com>
 <20200528190610.179984-3-saravanak@google.com>
 <20200529130012.GJ4610@sirena.org.uk>
 <CAGETcx9Y8VoPCjrVFdDwU=+m3_0OTZQgj9b5eSHSTgSqeCZrUQ@mail.gmail.com>
 <20200601172323.GE45647@sirena.org.uk>
 <CAGETcx-T=NstJDV2S8gKmqpOv1r2-fTRs1pwOtSQ6rJumhVGBg@mail.gmail.com>
 <20200609105115.GA4583@sirena.org.uk>
 <CAPDyKFohcYjSvBjjB01mg7bOFCJA8XukgRPsZJm48X44sFzeYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oFbHfjnMgUMsrGjO"
Content-Disposition: inline
In-Reply-To: <CAPDyKFohcYjSvBjjB01mg7bOFCJA8XukgRPsZJm48X44sFzeYA@mail.gmail.com>
X-Cookie: Offer may end without notice.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oFbHfjnMgUMsrGjO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 15, 2020 at 12:27:23PM +0200, Ulf Hansson wrote:

> eMMC is not only about voltage levels, but also about enable/disable
> of the regulator(s).

> More precisely, one needs to follow the steps specified in the eMMC
> spec, when disabling the regulator(s).

> In other words, the mmc host driver needs to be probed (consumer of
> the regulator), before the regulator(s) can be disabled.

Right, though you can generally get away with it if you completely cut
the power.  The big thing is that as part of this we need to actually do
the things at the time the driver asks for them to be done rather than
some other time.

--oFbHfjnMgUMsrGjO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7nYE0ACgkQJNaLcl1U
h9ANLwf/bAnNh2Hd66L+yesQj7Bv7AnAbxPcxAGA1+6KiyAIun81pvU0EmDxmQde
GM6t6O69FNXnOJbYKF2nuk/8DRz5994GzIuIVCHoUu2TQFDvdIy88+a7TKWpaR3u
bXLwDhSAmW4/cl+sZGnnUHAVl+GwdJ3xFCOrxtu35JvNtTaTB5FfbsVkVwF48J5G
Owj9hrQjT9YM3UicHHEsdkpr9Xc3UfzgaUeKmWKU/mAxh/2xeKJ1iRW38TUVK/ZQ
joLOO/QHMzIy0qUs9uqXOa7ZFNfQHey1AljhqfCkqSH5Srvumo2XWTinn30MVr55
d4qgkKQ2R68HJl7OfXXohkoMyBXCow==
=N1d2
-----END PGP SIGNATURE-----

--oFbHfjnMgUMsrGjO--
