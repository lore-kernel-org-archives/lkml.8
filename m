Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2D2C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 112992465D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582052600;
	bh=AOzSoobEDE7EhEFICl1pLxHiCCZDR6d7DRTiE1UV2SM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WEYnARn2yTHe7jtkRy5z5+92Xv83KvWQvrSqE22/4bgkJb7lbZUj/hx4CPszeWP5E
	 0NwtEm8Fo+md/Kk8BGhf7LwxK1qtFYVJ+1a6vSjYlGmnw33gggMtURVmP7a47g1f7/
	 H3p0gKcX4wqDaWL0fQj3mL6+E4skK5Rshs2e1klg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgBRTDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:03:18 -0500
Received: from foss.arm.com ([217.140.110.172]:59188 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgBRTDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:03:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8442831B;
        Tue, 18 Feb 2020 11:03:16 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07DEC3F703;
        Tue, 18 Feb 2020 11:03:15 -0800 (PST)
Date:   Tue, 18 Feb 2020 19:03:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Applied "ASoC: core: ensure component names are unique" to the
 asoc tree
Message-ID: <20200218190314.GM4232@sirena.org.uk>
References: <20200214134704.342501-1-jbrunet@baylibre.com>
 <applied-20200214134704.342501-1-jbrunet@baylibre.com>
 <1jblpvraho.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DXTueXWT3Da08pik"
Content-Disposition: inline
In-Reply-To: <1jblpvraho.fsf@starbuckisacylon.baylibre.com>
X-Cookie: No alcohol, dogs or horses.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DXTueXWT3Da08pik
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2020 at 07:55:31PM +0100, Jerome Brunet wrote:

> 1) Multiple components :
> I found out that in fact it is common for linux devices to register
> multiple components. For most, it is a combination of the dmaengine
> generic and the actual device component, but other register more
> component. Ex:
> - vc4-hdmi
> - atmel-classd
> - atmel-pdmic
> - cros-ec-codec
> - mtXXXX-afe-pcm
> I suspect these trigger the debugfs warning
> Even dummy register two components :D

I hadn't realized we have so many - I'd have expected the debugfs
complaints would've been noticable to people, I was hoping based on the
initial discussion that it was just a couple of quick fixed needed.
Guess not :/

Anyway, I agree that a revert is probably sensible for the time being
and getting this done is more involved - can you send patches doing the
revert with a changelog explaining the rationale please?

--DXTueXWT3Da08pik
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5MNPEACgkQJNaLcl1U
h9BjvAf+Pmlt7fyU83FfsWzxULYtc7fHXyMM3Gf12+JrIrwu/PfdPt3ip6EdC8Zl
qK6l8aX76eSj3zVwp8XZtQzqNflip6GgTbIT6eO1JslOAGWXRPbKFs0XAuu5jOMf
LfNEZoaFYp7FTrgltQsZ9viQyk8oO8/WWFwcomy717MTimKsBCiU8A0itn+0zQj7
wobZKZ03lqgIaEgwhUdmGhCBZzKNbpAlgN+tFIsYZtm+d3oPHQHO/MG8m1YBjlzs
UlhBrFJPUp4Wovahwd/OI7frBmGOLX6QhZSm7A0aoVs8c9I+icM73/sbqKSmsqq7
crR5zlLSQuqvMLLIuX47uaEEcFXSOg==
=GtzH
-----END PGP SIGNATURE-----

--DXTueXWT3Da08pik--
