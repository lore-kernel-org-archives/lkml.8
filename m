Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231A5C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 11:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA6CC206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 11:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588072470;
	bh=6DTJndgItc1WFWhpZyZ1xM0bC2J9mb3KRo6Obnb4WmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R5wQQZ2nY1ReRrKjE4y7qRuybyhfQ4E0TtstZ0m6CzmoHYI7KiWvAKOozgRHq4Szo
	 RAAMIGXzOgUC5z/JlNydWN8Q7c5isRQaeN1PGXAAckJ2YJaeOza1zcHxiPyiMJahuT
	 0poeOVGFcqpeUBMxTftWZjYYnccENZZIurweEYWw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgD1LOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 07:14:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbgD1LOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 07:14:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BC04206F0;
        Tue, 28 Apr 2020 11:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588072455;
        bh=6DTJndgItc1WFWhpZyZ1xM0bC2J9mb3KRo6Obnb4WmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q3qb34E4bp44JWa6pDDT90Gk7LeUH02t8lh2VwWR1c9Oaw66ERl/dzd5ezZl4DCtW
         iQ7bTY9xXuwovratP2T6vv33tNHxFYnVfCJtej/koTp/bP7CscKrtfOXwKt0MfSfKv
         P6BAeAhkD7oshYsng08lhA2nUgKNAdqTdFkr9aZs=
Date:   Tue, 28 Apr 2020 12:14:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 4/4] ASoC: wm8994: Silence warnings during deferred probe
Message-ID: <20200428111413.GD5677@sirena.org.uk>
References: <20200427074832.22134-1-m.szyprowski@samsung.com>
 <CGME20200427074843eucas1p1a3a265df0c7f14b0aaec25eb65daf606@eucas1p1.samsung.com>
 <20200427074832.22134-5-m.szyprowski@samsung.com>
 <20200427112202.GB4272@sirena.org.uk>
 <20200428103638.GP3559@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M38YqGLZlgb6RLPS"
Content-Disposition: inline
In-Reply-To: <20200428103638.GP3559@dell>
X-Cookie: Eschew obfuscation.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M38YqGLZlgb6RLPS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 28, 2020 at 11:36:38AM +0100, Lee Jones wrote:
> On Mon, 27 Apr 2020, Mark Brown wrote:

> > This completely eliminates the diagnostics which means that if the clock
> > isn't there the user is a bit stuck trying to work out what's missing.
> > There should still be a diagnostic.

> The driver won't defer forever though.  The final pass should fail
> with a different error.  At which point the error will be released to
> the system log, no?

One of the really common cases is that someone forgot to build the
driver for the dependency so it'll just defer forever waiting for
something that never loads.

--M38YqGLZlgb6RLPS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6oEAQACgkQJNaLcl1U
h9BdrQf+NCklPpWwravEIRIAH1rwyigfjx2trNsyl7yEA2AwXk8z7UPMlVo/5tAx
U6MrMNyYDvWsAgZVED3Xd20d7R/7M9+E7vg/73nnG4GIsQSbx1CGxfkaovbmWGWl
jGsqydTS7K3eMMSq2WiwiwfJW6qtX2ah3KWNM/hOkxzzxfkYoBY4whG+0AMJzwzZ
X+ciwLknAY2GiigH3viTy0t9vrAJZq8JpsbLrxzlh55YYPmM9sCfwN9Vi5bCfuet
pbGBfCGj4puRpt9bXB0fcO9q34kGsmGVG0cz/BcNc/hGM4y5xSYbGGeBTAPB0Qg0
3VfbJLNHhewSONj2A74OCuxVJqG47A==
=4bNe
-----END PGP SIGNATURE-----

--M38YqGLZlgb6RLPS--
