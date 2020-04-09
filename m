Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A36AC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503A420692
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rryVHpI+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgDIPCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 11:02:35 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6001 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbgDIPCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 11:02:35 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e8f38fe0000>; Thu, 09 Apr 2020 08:02:22 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 09 Apr 2020 08:02:35 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 09 Apr 2020 08:02:35 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 9 Apr
 2020 15:02:35 +0000
Received: from localhost (10.124.1.5) by DRHQMAIL107.nvidia.com (10.27.9.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 9 Apr 2020 15:02:34
 +0000
Date:   Thu, 9 Apr 2020 17:02:31 +0200
From:   Thierry Reding <treding@nvidia.com>
To:     Arnd Bergmann <arnd@arndb.de>
List-Id: <soc.lore.kernel.org>
CC:     <soc@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
        "Jonathan Hunter" <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Venkat Reddy Talla <vreddytalla@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: tegra: fix tegra_pmc_get_suspend_mode definition
Message-ID: <20200409150231.GB3505571@ulmo>
References: <20200408190127.587768-1-arnd@arndb.de>
MIME-Version: 1.0
In-Reply-To: <20200408190127.587768-1-arnd@arndb.de>
X-NVConfidentiality: public
User-Agent: Mutt/1.13.1 (2019-12-14)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586444542; bh=ntEzEcDK7qFFQ5MRDfSpyPN3i0B0OGhn7ZR8O7yPDEg=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:In-Reply-To:X-NVConfidentiality:User-Agent:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Disposition;
        b=rryVHpI+ggy0ulgypiiSLZINLweYm/+7Q/qWKjDXHk0z67QEUCHqF3O3hNYXNj6UE
         u859EIPaDUS/HPa7HIfMP8EnwJ5Ab6Zsix5MebiHKK5UObENw+GEqTbS/DcVX7R9lj
         6g575bxuYjjCN/jkHsURVbUg79seg/yzCvgqflHwkdbmCIggisPaCErADpkBdfkrjX
         LSkTYlQ36XZtWuxr8lNQdbg/W6URMv5R1ok0rGTLc9a6/+DivPTVOoh5xwQAAIvhDx
         vVbbZWUXwc4NLYzWTtu1DXsbh+7z6pXfSBjKgZ+eeW0La2xm9AX3jqjdBzRmX/Xz5f
         qJVkcZz5QHmjw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2020 at 09:01:15PM +0200, Arnd Bergmann wrote:
> When CONFIG_PM_SLEEP is disabled, the function is not defined,
> causing a link failure:
>=20
> arm-linux-gnueabi-ld: drivers/cpuidle/cpuidle-tegra.o: in function `tegra=
_cpuidle_probe':
> cpuidle-tegra.c:(.text+0x24): undefined reference to `tegra_pmc_get_suspe=
nd_mode'
>=20
> Change the #ifdef check according to the definition.
>=20
> Fixes: 382ac8e22b90 ("cpuidle: tegra: Disable CC6 state if LP2 unavailabl=
e")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/soc/tegra/pmc.h | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

Let me know if you'd prefer me to send this in a pull request later on.

Thanks,
Thierry

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6POQcACgkQ3SOs138+
s6F7ZhAAvVQ5d5Dr9bT31eAT6TA/weF92Mw2WXqCGnhT/tDE5mSqIkGHnhLvMHXa
h334Mk0SNxcgKec5lXumw2TFlnvfFy2aEItOrMP4U4CIe99AYpknMfE+LvQplfb4
JDzqugOFS7c9rUOPfQQy9WJ0YL/7qYm01gPtTAor+yGY5dJJW3vHl8I/issqJQnU
xPbY0EzD4qPyKe8e3T1OwpgiF1vHQCDrNtFsNt6otc/2lV5t+/OxLWxRx9skp9A4
zTMFVOK8CuhyUnE5Ik0y/ZmzmUFbrjOqOntuvO/NUotkPB95x5/AYy+P3Eu+qBqT
/3510BE94NojOZu7rY7PKlCkI0DuwXV4qV6FrRLvpAWa3xf/Y6/afJMgRSWNKKHj
ODOfgPrR71u0om9DG+/CrlD7QpYWXbpGQUB1JUtoQTU53UNSo9ZNgsvngzEwcqUY
6WYVi5EWitfVXcmvyEWyJ002EJAvLNgnwxmPZl1zVDAVB8NOsQhV0Qvi5lwLFGhF
u4Qmc9b+WndPwHaELLB3ScUPCD3+gT8WSOLavYZdQl3x48aFySWjm1OeXiBGfebq
4mVHghjV3/7YVPIvOom+EhAoEAJox5WnZzeRht1AleTmDt7IqNvPSUygNk2L/lrQ
XRZcVXx3nNe+vcwsJaW6Ln8z0gtTlKmUjN8Xzmy2wRhtPFaSziU=
=lZ2U
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
