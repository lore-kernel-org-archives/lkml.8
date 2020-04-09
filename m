Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12EEC2BB86
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 13:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B3020857
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 13:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JY/kUCsc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgDINYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 09:24:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55484 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgDINYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 09:24:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id e26so3876711wmk.5;
        Thu, 09 Apr 2020 06:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M+0i2IZ12XX4E1L28f3PjjMPxx7ophkum/Bqx8qALSk=;
        b=JY/kUCscGqgH+h2xeupK2s/TOWMJV7oXUl95+66lyD2DcGB7XaoE9ck2lB75k3xs0V
         qmrGgIaO8DiMroAtR6MdBi24gLl5QHElboEUcQSFhEDdwId9VoTtJjn0Z+uFwZSAguD9
         YAjxhCVhYDxDq3WU4J5gKJANOIqFH3wyqDkivyzDag1KksEE/vS0Lfl2bPEEfogIgIFV
         IIgY+6kZiMvsXlnlL6vMT+gAKotSty+9VUdw1cbx4kw27PG6Zcs9a1JXRn5EUreqCatS
         WjTzxiXKUVV2XbbwAosjnSQWjm41H3ec3mev6gg7PWXWRKRZj3ZOtetlJGzujipG4Lzg
         D1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M+0i2IZ12XX4E1L28f3PjjMPxx7ophkum/Bqx8qALSk=;
        b=mCRuQQeDSlti3jTHs/TmQT59fa1XaBg9FF1ZezlPtIUU3yM2W14NsAuJRJbvMtuiPa
         PQ5/cx73401Cg01dSMu8ZLML6c1uX09FvBwrnX8ajEIaJRCwCEuqt6PhvCIOStTBrB7R
         KoF6z/0fYmjDI4GWOVeYcf+cxpMVSKO3ZYi802Ki2mT2xoAg2Dgoc6S1cVp9IvqVrzc/
         l9E1Dz6xvFWHRiZ11IiEkNSURja5StM6N094FSIU0sl1LI2oua7geoYROmkG5ENBO5Y/
         j6Nk9QpsM1zbkNc+oN4m9QccGHpggNi/zSG25vcdoGCHRpXj0JweVsE38cBqrLKvtbff
         /6OA==
X-Gm-Message-State: AGi0Puaum+JpvO3uSunqjaTXZc1MCZ+2QAjVXVT6XRPpxSqDtRGYQsXW
        0Xd/5nroYgGjz152KWI1ZL8=
X-Google-Smtp-Source: APiQypIZe+5WHzOMXYBgJE5wOnJb+Kbv+aH+bMUmgGFFvTjM/qblCMf5ND4WJkqQmi07eCqUkjdkHw==
X-Received: by 2002:a1c:5a41:: with SMTP id o62mr2984219wmb.43.1586438677943;
        Thu, 09 Apr 2020 06:24:37 -0700 (PDT)
Received: from localhost (pD9E51D62.dip0.t-ipconnect.de. [217.229.29.98])
        by smtp.gmail.com with ESMTPSA id v131sm489754wmb.19.2020.04.09.06.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 06:24:36 -0700 (PDT)
Date:   Thu, 9 Apr 2020 15:24:35 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Nagarjuna Kristam <nkristam@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] phy: tegra: fix USB dependencies
Message-ID: <20200409132435.GA3263479@ulmo>
References: <20200408200828.124139-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <20200408200828.124139-1-arnd@arndb.de>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2020 at 10:08:14PM +0200, Arnd Bergmann wrote:
> Without CONFIG_USB_SUPPORT, we can get a couple of warnings for
> missing dependencies:
>=20
> WARNING: unmet direct dependencies detected for USB_PHY
>   Depends on [n]: USB_SUPPORT [=3Dn]
>   Selected by [m]:
>   - PHY_TEGRA_XUSB [=3Dm] && ARCH_TEGRA [=3Dy]
>=20
> WARNING: unmet direct dependencies detected for USB_CONN_GPIO
>   Depends on [n]: USB_SUPPORT [=3Dn] && GPIOLIB [=3Dy]
>   Selected by [m]:
>   - PHY_TEGRA_XUSB [=3Dm] && ARCH_TEGRA [=3Dy]
>=20
> Fixes: 6835bdc99580 ("phy: tegra: Select USB_PHY")
> Fixes: f67213cee2b3 ("phy: tegra: xusb: Add usb-role-switch support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/phy/tegra/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I sent a similar patch a couple of days ago:

	http://patchwork.ozlabs.org/patch/1263865/

This should be applied by Greg on top of the PR that I sent for USB. I
did get the semi-automated "we're in the merge window" reply from Greg,
but I was under the impression that he still applied fixes during the
merge window. It seems like he didn't pick this up yet, though.

Greg, anything I should've done differently for you to notice this?

Thierry

> diff --git a/drivers/phy/tegra/Kconfig b/drivers/phy/tegra/Kconfig
> index a208aca4ba7b..4f8c61863411 100644
> --- a/drivers/phy/tegra/Kconfig
> +++ b/drivers/phy/tegra/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config PHY_TEGRA_XUSB
>  	tristate "NVIDIA Tegra XUSB pad controller driver"
> -	depends on ARCH_TEGRA
> +	depends on ARCH_TEGRA && USB_SUPPORT
>  	select USB_CONN_GPIO
>  	select USB_PHY
>  	help
> --=20
> 2.26.0
>=20

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6PIhAACgkQ3SOs138+
s6E8iw//Y9WWnboPxDt/ZMifr8p+Redn8CloOlGCXq6Howr3MxpgVeSK1Zbn5hMN
CmLozFxfT9CCQ1QLFZWsBJB7xlZ4rVWKWNTlkWuAO8nW1R2nXlE6rLyd4z6/M63P
31f9MgD1fcBcr7y3bfus6MXwfWvwaMJV6VQPi2Kcvk5VIiJDCMZkA8zgHikcxlzh
0OBBpzIViwSvclojJP8XaF7DqXz76fhfzNaPyDFlu3H3fDu5/KxMZ4O8bv0v+N2L
KR7XAlLNfbUsLk28NvCddpmkByCOsD2yhvdasuEeAb4Tb+tDSc8NYauwISjKgYAh
ifpC/+YudVHCVdiJ7hlv/zyL/R7YrQtyxoPSXXLoot6HIz1jSJK361uaPJy1lJ3Z
dkVKxfE1F9vI2zCy6NJZ2dhBgHm1jjaP6P863xPZXOJxO5qMriHxvN+UsBa6Uyvp
e9FzjNMmVkKkkwMISJBvLWRUH6+lykFPNvVR4rsTUZPmMLqS68VhC2bCDFU5BVsZ
3jdegKdz8OKxLN7cCnQHSp0MhS12RqKia9fH9Nir3bmdnwpYiHEVxoNBP9ZWuuZX
Db26zPPhWokIDHJEcIWIrOWrjbTL9GokUW0WIUpck4u1tnJRqr7S27rDMEK/PK9W
6vqSi4uYf9xt1RiJDmp6c0VgcfkCBE0n8v3POT4bp+rvIF9gyhE=
=3Kkl
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
