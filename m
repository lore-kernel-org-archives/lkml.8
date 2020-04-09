Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDCDC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE612082D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jjpV0xYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgDIPBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 11:01:49 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:5968 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbgDIPBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 11:01:49 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e8f38d00000>; Thu, 09 Apr 2020 08:01:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 09 Apr 2020 08:01:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 09 Apr 2020 08:01:49 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 9 Apr
 2020 15:01:48 +0000
Received: from localhost (10.124.1.5) by DRHQMAIL107.nvidia.com (10.27.9.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 9 Apr 2020 15:01:48
 +0000
Date:   Thu, 9 Apr 2020 17:01:46 +0200
From:   Thierry Reding <treding@nvidia.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memory: tegra: avoid unused function warnings
Message-ID: <20200409150146.GA3505571@ulmo>
References: <20200408190043.532711-1-arnd@arndb.de>
MIME-Version: 1.0
In-Reply-To: <20200408190043.532711-1-arnd@arndb.de>
X-NVConfidentiality: public
User-Agent: Mutt/1.13.1 (2019-12-14)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586444496; bh=230bk55FM60HDeEDaVtGNsbVY+5/gRY3TT5xB7NycJQ=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:In-Reply-To:X-NVConfidentiality:User-Agent:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Disposition;
        b=jjpV0xYDrI5Jh1DdqRNFyUEGGwgYhpf7tDYD3Ia41t3pixcPKpQPNo+Wc6h+r4Jpk
         6tE3V0VhfWkegayHAVLVoK+/ATDwEtPMrR7ZHrXTp899PB/kCcCz1hn0Qf+E7+7yec
         D0fX3FXFuHl9Rqfy0yxbrpAK2EF33ZgllfFbyxgsulQ4w7WdL64hrnCb0R1g1Oy+/N
         Tv42Jp6GGBhcItUpf69xckICWh7fMt35EAkYBjjn3x00JJA7WiMYEEV8p9+6Ff3pYB
         j4H7PPB33dALl5r3nGt/fDiQRvDQ0ol03WtHsZr/AsmgWy32JeRjk/jCkGCLIGtgre
         IKZJG42c1OMPg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2020 at 09:00:30PM +0200, Arnd Bergmann wrote:
> The suspend/resume functions have no callers depending on
> configuration, so they must be marked __maybe_unused to
> avoid these harmless warnings:
>=20
> drivers/memory/tegra/tegra186.c:1578:12: error: 'tegra186_mc_resume' defi=
ned but not used [-Werror=3Dunused-function]
>  1578 | static int tegra186_mc_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~
> drivers/memory/tegra/tegra186.c:1573:12: error: 'tegra186_mc_suspend' def=
ined but not used [-Werror=3Dunused-function]
>  1573 | static int tegra186_mc_suspend(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~
>=20
> Fixes: 177602b00641 ("memory: tegra: Add system sleep support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/memory/tegra/tegra186.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Do you want to apply this to ARM SoC directly or would you prefer if I
collected fixes and send a PR sometime later in the cycle?

If the former:

Acked-by: Thierry Reding <treding@nvidia.com>

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6PONkACgkQ3SOs138+
s6GwCxAAqz/EbclxuLXTI0bmj3b7UG7+js/fzr2oWdIIu3SkJWJfoxyfxdWXZDUG
M5989jPwZxiqyZU68dplxAED6TzPTMFJHYqvtk+Ex73gwRidRj5Jpoa8sXuOVsLL
Io7Us/Zhd233Qi+QyfSfmR3Gvq6X9M/HKvLIVj8x/lbLinnunGlmMBE0i4VTt0e0
1yK6L2wMWTolXwmJqRYtZ8Ct8HbSJUfOQnrx4dvrthrxYpEGe9c3mqj7b2ds7TeQ
Y7tAoPxqOmMbju5BKHhmMkY+xpIfE4NNxyCGfiLcGaPuJ0DQtrIqrLGWAtD7RpMj
CXAqI7YUvp3fF/CUIDgVrPRt17G/VR98EYYuyu0YO7Frr3eUx9p7LsWtmC0vQvb5
I2c+crnGHhnb8Rw9I4B9xH3pYt+7bLPg5wz/4stF8SWE3oq3FZc41Dd9k2jir7vy
daz7SxTC++0aBIa3gwk2tXWLbb90fZuMOi0T8QVz5uaGWUpGygaT/WyUBucMTGQ3
qtJJe7nJ6RHwQZL8tvsuxDR6djl0zV3jHtOvT5s17ET/HNCgANp1cSr8UOJOgqdg
F+ape+W428Hgpkp+6Kj6IbCtVHbW1lgmEcLxuLb4BvPIR4mroQNg5ffYzpWZ5TTL
8iUv9Z4kedsuVwd01glV7uMV6+aW3n2u5P34R5s21OTFlF2C8e4=
=KD63
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
