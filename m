Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13711C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E71D02078D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597864684;
	bh=ja9zTGvas8+5tbhcgcma7CyTxxBOwXM64Fyi2BLBCTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AJUpEydUpeSCvfMJNasnJegLJxWTLgKomJAWcuGMNBTMpCTWAVzgNP/3c3N9FzuzJ
	 Xh32xYbFQBv4INLKLQaCEnUqRC+KC7z0ZlxikFFkAKhl8lpND21in2VsgAWJ1CEB8/
	 5FF2nMuFIe22bKq/N1jHic71z5UVu5vWXaA+oFHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgHSTSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:18:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726870AbgHSTRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:17:54 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 323312078D;
        Wed, 19 Aug 2020 19:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597864673;
        bh=ja9zTGvas8+5tbhcgcma7CyTxxBOwXM64Fyi2BLBCTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j+F1qKX+o3xFhR8SHLgmObhhLP6ZPWEEV3vRBu8SRkLCYEn4lYrxP5NjcauFwMQY+
         XND3i9GRBsU25re0GRwg2yw9z6Km3T0zpp2YRP757LbvI4HBsnrxxvzbrvIk5fX+If
         MT0yayqEf+I0eU/F7u3C0A7Sm6/B+NxPZrNOV4Qs=
Date:   Wed, 19 Aug 2020 20:17:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 01/41] ARM: s3c: Remove unneeded machine header
 includes
Message-ID: <20200819191722.GA38371@sirena.org.uk>
References: <20200806181932.2253-1-krzk@kernel.org>
 <20200806182059.2431-1-krzk@kernel.org>
 <159783932455.55025.7979458249415199743.b4-ty@kernel.org>
 <20200819190232.GA18183@kozik-lap>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <20200819190232.GA18183@kozik-lap>
X-Cookie: Absence makes the heart grow frantic.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 19, 2020 at 09:02:32PM +0200, Krzysztof Kozlowski wrote:

> Thanks Mark.  Could you provide me with a tag/branch with these to pull
> into samsung-soc?

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/samsung-platdrv-boards

for you to fetch changes up to dcacbc0f9bb89ac48d5b602d27a8630e641294cc:

  ASoC: samsung: s3c2412-i2s: avoid hardcoded S3C2410_PA_IIS (2020-08-19 20:15:45 +0100)

----------------------------------------------------------------
ASoC: Convert Samsung drivers to platform drivers

----------------------------------------------------------------
Arnd Bergmann (4):
      ASoC: samsung: h1940: turn into platform driver
      ASoC: samsung: neo1973: turn into platform driver
      ASoC: samsung: rx1950: turn into platform driver
      ASoC: samsung: s3c2412-i2s: avoid hardcoded S3C2410_PA_IIS

 arch/arm/mach-s3c24xx/mach-gta02.c  | 17 ++++++++
 arch/arm/mach-s3c24xx/mach-h1940.c  | 18 ++++++++
 arch/arm/mach-s3c24xx/mach-rx1950.c | 16 +++++++
 sound/soc/samsung/h1940_uda1380.c   | 71 ++++++++++---------------------
 sound/soc/samsung/neo1973_wm8753.c  | 85 ++++++++++++-------------------------
 sound/soc/samsung/rx1950_uda1380.c  | 72 ++++++++++---------------------
 sound/soc/samsung/s3c-i2s-v2.c      |  3 +-
 sound/soc/samsung/s3c-i2s-v2.h      |  3 +-
 sound/soc/samsung/s3c2412-i2s.c     |  2 +-
 9 files changed, 126 insertions(+), 161 deletions(-)

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl89esEACgkQJNaLcl1U
h9Dkwwf/W8mvyfntwp5cuKoybqCa0Ov7tbgr3EOc/YKmnIEHA3IAqAGldEFbc314
kN/6CKhvm49l+Xven7KJmbXDBoEvDe+N96Ejvw/5Mihu3voTChdK/waoxbCAomCl
+o3hIjuj6X+qbfUVO5HyHiklFJoRTRd2i87dJ8dOxeqfrxR+JQAgkTWciQlGrF4x
sxAVUyJHzNFvy+vaRyiTzY7hRMuST1i5ciBlABm4EsMjWJ59rOW3hCrFAvQ5dZyP
LGck2oVKyfHdcNll2lLCcUSJ0plO4iPG4Gg1wxrA6Bi7ZSbvM9HWd6iMG1elca0B
dXmCebRsD0xYBH2xgdLlW/wdfolaXw==
=Wokk
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
