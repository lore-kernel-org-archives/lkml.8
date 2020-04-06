Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FEEC2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CA62078A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RSirfZOQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgDFJM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 05:12:28 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14512 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgDFJM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 05:12:27 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e8af2140000>; Mon, 06 Apr 2020 02:10:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 06 Apr 2020 02:12:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 06 Apr 2020 02:12:25 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Apr
 2020 09:12:25 +0000
Received: from localhost (10.124.1.5) by DRHQMAIL107.nvidia.com (10.27.9.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Apr 2020 09:12:24
 +0000
Date:   Mon, 6 Apr 2020 11:12:22 +0200
From:   Thierry Reding <treding@nvidia.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Michael Turquette <mturquette@baylibre.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Paul Walmsley <paul@pwsan.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/9] arm64: tegra: Remove redundant CLKDEV_LOOKUP selects
Message-ID: <20200406091222.GA475156@ulmo>
References: <20200405025123.154688-1-sboyd@kernel.org>
 <20200405025123.154688-4-sboyd@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200405025123.154688-4-sboyd@kernel.org>
X-NVConfidentiality: public
User-Agent: Mutt/1.13.1 (2019-12-14)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586164244; bh=9kmRTXF8Etb9YX4oOcNjQcdL+srESuC5aHGqMIaGSiA=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:In-Reply-To:X-NVConfidentiality:User-Agent:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Disposition;
        b=RSirfZOQYdXD3Ox0BliIItemQ8d/Bs/Qcj6c5eKsQ0snKTh+/f1HotOfmbQ2aM3IZ
         mrGAb9Z7Y0qX/nLscwBRp/cavq14ZCHvCicFVGMzuw1YflXdDXZKXHjKAHcQ0Hp7kY
         k1t8+8YkXqZRT8Zd5Ik0qf12UuLipIUiNbmQoQFBpRLeZ3Aq6DAWgoTDmcbEI+EW1l
         F6sjSc+xU5uNYzKF6hOiwzUVsXIWSTX/8atYdil/PfdAerWZg6YKqA+Hj3bNlf7sXk
         Jjce3njkD3Pas7l5ePr6PDRpT62sBA6JgV3L38tL+xUFOwWmW0QEFup+TGwwZmMLYN
         aW1kAXEjN9iXg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 04, 2020 at 07:51:17PM -0700, Stephen Boyd wrote:
> The arm64 architecture selects COMMON_CLK at the toplevel ARM64 config.
> The COMMON_CLK config option already selects CLKDEV_LOOKUP so it's
> redundant to have this selected again for the Tegra specific config.
>=20
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: <linux-arm-kernel@lists.infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  arch/arm64/Kconfig.platforms | 1 -
>  1 file changed, 1 deletion(-)

We rarely touch this, so I think it's fine for this to go through the
clock tree. I'll make a mental note just in case there's going to be
something touching this area in the next release, but I'm sure it'll be
all minor so we could easily work that out:

Acked-by: Thierry Reding <treding@nvidia.com>

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6K8nMACgkQ3SOs138+
s6GYOxAAl16bdJdFCTM/is7vcybWugFQqwYZ6YQqMs8mYm7vVkbuX24Mw4Imq8Dh
kCzqbiCOnF0Bzotqm2ZQH2DwFHuevqCcIVvFM3dFapq5vE+T/42fernYfv2Jcdt+
D5+aKv994tvCXMPKPq6oJyJGR3Frf2BcIjxThfduw+B68ILLaImTwoW5p6fWyrUL
jR9F3hCCASjWQS+fCNuEcNRlsEBmWw1u/c4iqjfU7JMHXpPE/DZuYeS2daLoQmEl
5li51m8hyES7/R9/tVaJlZIfOM3t9O4V58aZDnP/ieJ4nzFGLUWg3eveOm0b88ex
2jaQhn5zNUliym+sSa4/vZKXPkzUTW4zMtiNR2B/QZyEZdD7veQmlVVPWauSsH4S
1NCqegINAAaBAFZnS3Xz+iJsEqnK+iHiR6sZzckpChCN8znGgpK/sqGvY3gUj9bt
R7wI7snHv59hJSbU2NBZKl95G5JH22GlU/RT3exDgQd2LHyi9WcPbvg6lqYbydM4
FC/YOBQjSIBr1oC1ECh9XtGiGN614I3JextBY+NIFMONb/UN2b6K842uKhETt2U7
gCjXTkdSIGwf5m3QSSxUjPYUnMycFQ0XXhKjyNed0V7daaxrfS5LbgN2sVA/WC6G
cvGn2OsSZnLdE0dAY9hpANrWX2RFIhIqINKHTQqc+pqGieWXvJE=
=rq9p
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
