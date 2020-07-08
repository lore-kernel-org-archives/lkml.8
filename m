Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB92C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08E83206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594225592;
	bh=JyxcUBZKMuQeOWNkFD3IhGsYoihTVx8BuPWJrqQpGmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nDje2eUsBw2zpw1GqW6+GeFUoKPsplGZVSAynjcEKnMWOfacg6fpn82+249Aueg8l
	 VJN/rRYKH4Z0m9WQKAdF8J8wPTGZrc4UApMWyJg3n3JoISXvihA868T3pWvlwaQB/f
	 vGTMlEedBPepi31OF+39GmuGkhuJoK5a9FhbtVAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbgGHQ0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:26:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:48750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730141AbgGHQ0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:26:30 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B715B206C3;
        Wed,  8 Jul 2020 16:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594225590;
        bh=JyxcUBZKMuQeOWNkFD3IhGsYoihTVx8BuPWJrqQpGmk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JNx8j2Uhr1iDOFoDHbyJOSCbFwsG666DofJVdQt8Leua6b7WInFHxvgHNlz6RoFan
         s0QZzX77x2EenoMHw3fPqu3oVlJoxO2nXWpXNmLMQnN4luF3q7A97OwfTZ3hf3Cl8v
         N+E9FvkiQN/R/wSFFAXnJSsaXltX9d+4NEHdyvjA=
Date:   Wed, 8 Jul 2020 17:26:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v1 5/5] regmap: irq: Convert to use fwnode directly
Message-ID: <20200708162624.GW4655@sirena.org.uk>
References: <20200708162135.31010-1-andriy.shevchenko@linux.intel.com>
 <20200708162135.31010-6-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="udzYTtuEmHLUHegf"
Content-Disposition: inline
In-Reply-To: <20200708162135.31010-6-andriy.shevchenko@linux.intel.com>
X-Cookie: Oh Dad!  We're ALL Devo!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--udzYTtuEmHLUHegf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 08, 2020 at 07:21:35PM +0300, Andy Shevchenko wrote:
> Since IRQ domain provides an API to take fwnode as a parameter,
> switch regmap IRQ to use that directly instead of be limited
> to OF case only.

Acked-by: Mark Brown <broonie@kernel.org>

--udzYTtuEmHLUHegf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8F87AACgkQJNaLcl1U
h9A5MAf/Wxgn7w1ZCHPlUZoQc9EGM+aO67izkz5ZP1zWHDO4BRc3vogrLmMQ1cfF
yUYcG8scWwlnlllUmMK0VLwi8yx9/xomocSBhTITdQ+LN52bktvEShDfh0WtLbNr
ZsDM8j6Z9ya+TgQNOqdaBLnW0g3IueAf/S/LjGFeU/SseIBzNsblggJBqxrp76Ko
UpvFMP60/7pngnv0eQi39pdSrJy03KbhzdyxP/GdCnf+YjlfJSFL25Y735oe7KKk
Y3SdCbBR+KLGcAJ9P/mqPrNP6TGk+O0tLNTT3GtWXd79ZXes9DV4TsebTb93FSgm
L8kz0k7ECK9i7UHdiOFKFpSg8Zi2HA==
=eAwq
-----END PGP SIGNATURE-----

--udzYTtuEmHLUHegf--
