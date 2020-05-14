Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A168FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 10:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75E8F206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 10:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589451435;
	bh=Hjnqtf6r7/XeH0rPJKhpaCd250LS4mEfzl1RNp4Sfyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l+8BjcBC94E8ftVcUbuzSm8q1XXvFUCXGkmzEuBCV6Yh6rU5hr/YZkB1bIiZmCwJv
	 ZZD8qt/gdYCdRft0pMbxyPSdh3ynrM1KAxgVCpZCncas7mWBNLOCVEzFUdkJTCFy7P
	 /onlmbWNmH6jLpWAnAO0lKP2rHAoOYsGNqvlM550=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgENKRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 06:17:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgENKRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 06:17:14 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1810F2065D;
        Thu, 14 May 2020 10:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589451433;
        bh=Hjnqtf6r7/XeH0rPJKhpaCd250LS4mEfzl1RNp4Sfyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D3zjKHn8NR/8To9fLf0fHyreRT1kzJk58Z3fWsPILa95k5xHi5sL0y9TYFLy/u5Ep
         h7KFg/LqEovaeVIZR1hHa7K2rles1Q0eg1sKhJzdrbkdn1DjbBFRAGNkLLQwVomqNk
         LVXINSpYITqJsfUS0gxo9b8dgpaQQUYOItfCEdf8=
Date:   Thu, 14 May 2020 11:17:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     Steve Lee <steves.lee.maxim@gmail.com>, jack.yu@realtek.com,
        ALSA development <alsa-devel@alsa-project.org>,
        ryan.lee.maxim@gmail.com, ckeepax@opensource.cirrus.com,
        ryans.lee@maximintegrated.com, steves.lee@maximintegrated.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, nuno.sa@analog.com,
        geert@linux-m68k.org, dmurphy@ti.com,
        Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        rf@opensource.wolfsonmicro.com
Subject: Re: [V3 PATCH 2/2] ASoC: max98390: Added Amplifier Driver
Message-ID: <20200514101711.GC5127@sirena.org.uk>
References: <20200513074523.21086-1-steves.lee@maximintegrated.com>
 <20200513105144.GC4803@sirena.org.uk>
 <CA+Px+wU_tjgWgG_xPR6SNBC5oM3nzVnhxjD85mrxfZW+_w6mKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2/5bycvrmDh4d1IB"
Content-Disposition: inline
In-Reply-To: <CA+Px+wU_tjgWgG_xPR6SNBC5oM3nzVnhxjD85mrxfZW+_w6mKQ@mail.gmail.com>
X-Cookie: I think we're in trouble.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 13, 2020 at 07:58:12PM +0800, Tzung-Bi Shih wrote:
> On Wed, May 13, 2020 at 6:53 PM Mark Brown <broonie@kernel.org> wrote:
> > On Wed, May 13, 2020 at 04:45:23PM +0900, Steve Lee wrote:

> > > Changes since V2:
> > >       * Removed warn massage in max98390_dsm_calib_get func
> > >         and add comment.

> > The problem isn't the warning, the problem is that you have an empty
> > operation.  You should either implement the function (eg, by caching the
> > value written) or remove it and fix whatever problems you were running
> > into further up the stack when it's missing.

> The purpose for the mixer control is: to signal max98390 to start to
> calibrate from userspace.
> Thus,
> max98390_dsm_calib_get() -> do nothing.
> max98390_dsm_calib_put() -> call max98390_dsm_calibrate().

In that case it should probably do something like read back if a
callibration is currently running.

--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl69GqYACgkQJNaLcl1U
h9DNxQf/QQdNXRHEhFVhciOu10vEivLtB4etHg6e0+9DlP5UaqQzSlo8qhxUVOLg
vvn1YSiYncGYeehx+d2wpZHDsRTuC7t6l8fmJPgX5dU9U8cuaCfEL6MpLTRxWvtd
70W0gvdgF06FJsCQQW/vdFxXMYQrnSULSVbsXP+WTSntRA1q0UgT39iVNB4oLLJa
YfnwI6H8B9V/0BLvGNJeQh0CeboCekKQxF02A1gPld096jo3CA0OYae75LLtgV9A
4rkEwexhCG14FuzijzZ56w2JSVjqaqgOHQXtZBcv6zMthny2y08q9Y1+iYTOydAY
O9da5PaWDFoscL0AYaMZemx8ryXTYg==
=hO61
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--
