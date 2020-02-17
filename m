Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AFFC34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36AF920801
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581951887;
	bh=9a7TXwZ2XWmh09Mmv+cWAABgd4vU3rDZVU8uG6XGFa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qiU81bxeZn8/uQwKB9tmHF4447GqpEQK/OpbdHzmEJfZgPD1VE9TxSdxEpaDsJhEL
	 JxYXfLfwer8rLiRLNshePFpF0ujz6sIbppd8HwX9eAym2CATOUbP7Le8I74quce3ZW
	 Dpe+ufjd9JT+eKMRRSPG0+hUj6jXZ1pAW0TWl054=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgBQPEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:04:46 -0500
Received: from foss.arm.com ([217.140.110.172]:36962 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729319AbgBQPEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:04:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D586B30E;
        Mon, 17 Feb 2020 07:04:44 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 599683F703;
        Mon, 17 Feb 2020 07:04:44 -0800 (PST)
Date:   Mon, 17 Feb 2020 15:04:42 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        =?iso-8859-1?Q?Myl=E8ne?= Josserand 
        <mylene.josserand@free-electrons.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 04/34] ASoC: sun8i-codec: Remove unused dev from
 codec struct
Message-ID: <20200217150442.GH9304@sirena.org.uk>
References: <20200217064250.15516-1-samuel@sholland.org>
 <20200217064250.15516-5-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zhtSGe8h3+lMyY1M"
Content-Disposition: inline
In-Reply-To: <20200217064250.15516-5-samuel@sholland.org>
X-Cookie: There was a phone call for you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zhtSGe8h3+lMyY1M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 17, 2020 at 12:42:20AM -0600, Samuel Holland wrote:
> This field is not used anywhere in the driver, so remove it.

> Fixes: 36c684936fae ("ASoC: Add sun8i digital audio codec")

This is in no way a bug fix, it's a random cleanup.  This means that the
Fixes tag isn't really appropriate and it should be done after the
subsequent changes in the series that fix real bugs.  You should always
put bug fixes first so that they don't have any unneeded depenencies on
other things and can be merged without them.

--zhtSGe8h3+lMyY1M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5Kq4oACgkQJNaLcl1U
h9A9Vgf9HMozS/Ywu0JGI1L5GM/qN7H8wiz+zVCv1G3I0c+5ZQ+1uicI8yt2ECLS
IBLZEnRacg0QqjVmh9Ht3Ar/Z1j8ZWEFHKW/633TvvKsd+sCGUxhdruB9h54TAuP
Zp+7hjdRerC9Qwm9mZUohiIL/SYarUiuw7rOuaky+K9uhQTfq9XRtQX7AebIuXNh
Zrg/+DrbfQriYkwAvLcS7Adk8LrJ1bDw4WGmBP1zhDFwLCXQ6E2abkf4NltY+TeY
9F481r+90owgmj4x8/yFy+oD0HPgqU3fRXVgXB6H3P4L4HJylgrfjwLXwr3Sg6ln
SR4qJz3ixLII+/p8RcAUkach3NRrww==
=RpUW
-----END PGP SIGNATURE-----

--zhtSGe8h3+lMyY1M--
