Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CFDC32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 13:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17B920718
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 13:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579871905;
	bh=uxsyKgqT5sBNYLL55hI8rV0ZXN6L2aIXtzjFg7MVbmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MLvxGF+8bmzxSxFQeVI7eiwvk4EV3SBcG24wrEIMXLj6VKHmq2LQC5o/HwgMaEdjd
	 ITOIjmJMGWaa0KNQAxJpZ/cZDJJhPEh8aOhzF5tDJN0iKOHxgetReIM0xof18vPFdu
	 WYes1f32xNv6UWsNgdUcWBUlylXwGEB5iLi2Xfs8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389453AbgAXNSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 08:18:24 -0500
Received: from foss.arm.com ([217.140.110.172]:51606 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387736AbgAXNSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 08:18:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B36741FB;
        Fri, 24 Jan 2020 05:18:23 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 330583F68E;
        Fri, 24 Jan 2020 05:18:23 -0800 (PST)
Date:   Fri, 24 Jan 2020 13:18:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>, khilman@baylibre.com,
        tomeu.vizoso@collabora.com, mgalka@collabora.com,
        enric.balletbo@collabora.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: stable-rc/linux-4.19.y bisection: baseline.login on
 sun8i-h3-libretech-all-h3-cc
Message-ID: <20200124131821.GA4918@sirena.org.uk>
References: <5e2ad951.1c69fb81.6d762.dd8e@mx.google.com>
 <0ed4668a-fb29-fca8-558e-385ef118d432@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <0ed4668a-fb29-fca8-558e-385ef118d432@collabora.com>
X-Cookie: Drop that pickle!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2020 at 12:58:32PM +0000, Guillaume Tucker wrote:

> Please see the bisection report below about a boot failure, it
> looks legit as this commit was made today:

> >     Fix it by ignoring the config in the device tree for now: the
> >     later patches in the series will push all inversion handling
> >     over to the gpiolib core and set it up properly in the
> >     boardfiles for legacy devices, but I did not finish that
> >     for this kernel cycle.
> >    =20
> >     Fixes: commit efdfeb079cc3 ("regulator: fixed: Convert to use GPIO =
descriptor only")
> >     Reported-by: Leonard Crestez <leonard.crestez@nxp.com>
> >     Reported-by: Fabio Estevam <festevam@gmail.com>
> >     Reported-by: John Stultz <john.stultz@linaro.org>
> >     Reported-by: Anders Roxell <anders.roxell@linaro.org>
> >     Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> >     Tested-by: John Stultz <john.stultz@linaro.org>
> >     Signed-off-by: Mark Brown <broonie@kernel.org>
> >     Signed-off-by: Sasha Levin <sashal@kernel.org>

Oh dear, this is another bot backported commit which I suspect is
lacking some context or other from all the other work that was done with
GPIO enables :(

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4q7poACgkQJNaLcl1U
h9B4Owf+N6i9oMeuNWr8mW1HmkUANB1Qk8gLI1rgpaXhzAn2Q02rnbPX99d+WcVJ
PLgp7KZynp/512maIlow22Ya0zAxnRKm2RbveHkv9Pj3WeVYVODEcr46bd4bwpsD
RxvYsnx+0QOz1grGpULeAVpaXn5k7OagrqyDkvKH2wGVoI3baYDHKOghPV6prUci
8pFG3I77TDZwiJdhjSvsOX8Tkqie3so6JYt9CKJq1AqktU4uHOXnUqXOaULVno1Z
gUX7b7MPV6x6QFvZ7hgXv2VUVd7ruYdsTFSBCgrSNOfRyxb1iSpunubaoos7VF2S
vEEw7esH+49gu/mnytIrAuQ5mJ3OYQ==
=bpE4
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
