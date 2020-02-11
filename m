Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA50C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 16:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95AE42086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 16:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581439527;
	bh=aCtP2cb8D9+1rYH7hnwsImH/n7sWk2VSHTk5eZtSmfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nfV9+mwDeqdc+9FRFNerSEu33jqT4+B33yg1Jt/9PCd13WR/KNxQ2RT7nQ9TMzKn0
	 03ZfJr/iB5k/ku+xLCtkcie1U9EdULdpugYYJ3pebxkomNc8xvDQH7svnG6Md4xOVt
	 IzZZi9fGi6oWxXZQD9+Sf7j4mtKQ5nVNnx9t3pUc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbgBKQp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 11:45:27 -0500
Received: from foss.arm.com ([217.140.110.172]:49630 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbgBKQp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 11:45:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4071130E;
        Tue, 11 Feb 2020 08:45:26 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B991C3F68E;
        Tue, 11 Feb 2020 08:45:25 -0800 (PST)
Date:   Tue, 11 Feb 2020 16:45:24 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [RFC] ASoC: Use imply for SND_SOC_ALL_CODECS
Message-ID: <20200211164524.GN4543@sirena.org.uk>
References: <20200207091351.18133-1-geert@linux-m68k.org>
 <CAK7LNAQGcw1jbb=fWd_CbWv5hQrkqG_QFCw3uY4LXroONGM6BA@mail.gmail.com>
 <20200211161905.GM4543@sirena.org.uk>
 <CAK7LNARCr8afvs=h5-ZWVs=Bkk7PSMNvX+M_SeBSF-L99UencA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YuJye9aIuN0w6xGV"
Content-Disposition: inline
In-Reply-To: <CAK7LNARCr8afvs=h5-ZWVs=Bkk7PSMNvX+M_SeBSF-L99UencA@mail.gmail.com>
X-Cookie: Hire the morally handicapped.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YuJye9aIuN0w6xGV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 12, 2020 at 01:38:16AM +0900, Masahiro Yamada wrote:
> On Wed, Feb 12, 2020 at 1:19 AM Mark Brown <broonie@kernel.org> wrote:

> > No it doesn't.  Those only enable user selectable options, many CODEC
> > drivers don't have user selectable options as they are selected by
> > machine drivers some of which either have more platform specific
> > dependencies that the CODEC drivers or aren't upstream.

> Maybe, can you add a prompt which is only displayed
> if COMPILE_TEST is enabled?

> For example,

> config SND_SOC_L3
>         tristate "some prompt" if COMPILE_TEST

That's effectively what this is doing, it's just making it a single
option that enables everything en masse rather than lots of per driver
options and isn't as esoteric so is easier to understand (almost all the
existing examples are Renesas specific).

--YuJye9aIuN0w6xGV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5C2iMACgkQJNaLcl1U
h9C39wf+LExhl27QS0xwjrmLu461Qr4UrkCcrNBX4/WGttFKbi2xbL1A7I8Tc9sh
eNIYtW64RUY96X6wT3BeuNRoBDHbJhm4p8j4gRhsbxtXp2nKazBcVURs/p+3ShKd
huwUYOohkLVxJOxlJ2EBV7iode/CfXYs7rfhK0SjjSqZ8edmGZvpXjZTaeWyYHwH
wYUdfWVMMAcQ5vJPGRVYrPBF7oHrjB3fyVtwNgFe7QfoEe0A5LXImI18wMztBifs
1s0gXzUdZGUpcoUXiHyd/qiq18lHGqcrEzOMqSVUyprOK4NE42dvX73LptIIZnEc
Gw9JHwmbgxgHt85hG64pBAnPJ/I7aA==
=ABsK
-----END PGP SIGNATURE-----

--YuJye9aIuN0w6xGV--
