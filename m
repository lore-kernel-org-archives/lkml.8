Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB7AC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA7812082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588154177;
	bh=FwWtS3zRCjsJI2YMIBpLfYxO1MWQjhptPjdsF2oub2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DGmhYwmPbMZhkyn2AdDKerfKskvptI2Q1dY6rxm28GBLEsxYm70mrvstJeeTNU7zA
	 M2GskrbdygNDGyTDJrYDeUSlO7ZjJci7xpOrpeKHA+B1n4M7gHjotz3UA+nXSBrucn
	 UkjlVICY6vWumYL4DG5DwRNlFdhGQABKRxImX/5E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgD2J4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 05:56:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:45726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbgD2J4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 05:56:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EC3820775;
        Wed, 29 Apr 2020 09:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588154176;
        bh=FwWtS3zRCjsJI2YMIBpLfYxO1MWQjhptPjdsF2oub2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hk0vatEy+pgK6VYcHbSL62/4Xw9E5vtY1cHL3aLlx/bczOnEAY5aJ+hT4VtpvLF29
         C8PNd+XdHsK71bkwULURGK1CSkmxqj3qcX0h2vJ0kARFiFzcxDbTk3QQMJRmySaqGi
         MOPf6t02D8tCEOVWYLjSVASwS3Pt5d5VHEpzoOlw=
Date:   Wed, 29 Apr 2020 10:56:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 4/4] ASoC: wm8994: Silence warnings during deferred probe
Message-ID: <20200429095613.GC4201@sirena.org.uk>
References: <20200427074832.22134-1-m.szyprowski@samsung.com>
 <CGME20200427074843eucas1p1a3a265df0c7f14b0aaec25eb65daf606@eucas1p1.samsung.com>
 <20200427074832.22134-5-m.szyprowski@samsung.com>
 <20200427112202.GB4272@sirena.org.uk>
 <20200428103638.GP3559@dell>
 <20200428111413.GD5677@sirena.org.uk>
 <20200429071553.GW3559@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
Content-Disposition: inline
In-Reply-To: <20200429071553.GW3559@dell>
X-Cookie: I know how to do SPECIAL EFFECTS!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 29, 2020 at 08:15:53AM +0100, Lee Jones wrote:
> On Tue, 28 Apr 2020, Mark Brown wrote:

> > One of the really common cases is that someone forgot to build the
> > driver for the dependency so it'll just defer forever waiting for
> > something that never loads.

> Need to find another way to identify these failures.  There are 10's
> if not 100's of cases of silently returning if -EPROBE_DEFER is
> caught.

Or someone could go through and improve the diagnostics on those cases.

--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6pTzwACgkQJNaLcl1U
h9D6Xgf9Guv3gkkSrA83WP59TlOCdVlc9WjLo4TwW/puCgPrbYPbbmVFcPlAEuw1
xwkTQ+DV/GI5bYhfgn7/ClPRasITAnfWuTrbc2g0loWrgvpJo3Uh2LXAvUvjGP6A
p4zn5WVTueSRjSJS21/N48q9Scv42sZyeWT+XY0fdRDPf8Gxad44kSCLBXBw2Fwa
ez6bfzmdSASyBSPPeQO+blWMeaMc0aFfOBUmbBDzs0hqYE2jHyZkGDrfRD3y9qem
vhr2gkKcaXV6GAcSMML5RXXWXpwVAAeKdWQ6qb1RihjeMOZlpfFod7TFqy6dDGsJ
JEQ2bIuaNNps/dF3xFH9egl9H6ug7A==
=3L8S
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--
