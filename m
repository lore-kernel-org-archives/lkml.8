Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8720C11D32
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93EE2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCD1q2zO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgBXPM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:12:26 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43464 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbgBXPM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:12:26 -0500
Received: by mail-wr1-f68.google.com with SMTP id r11so10783650wrq.10;
        Mon, 24 Feb 2020 07:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F95f71D2jIzfBlGyN1qcD8dXimygAPXCAfU4LdKb+o0=;
        b=NCD1q2zOhFoiUeGO6VR8OUyYMJP6hwbtbvmDyjmFJLXwcw1doFqlMwkyyVL/sQ6ZpX
         oyJC9N7IXaNwTQwOuvUqNhYkGkL9h8fSjVRVUKNtqfz3qA8HBfMgltubP/eTj8aojGXa
         aVLbuO3t+UZl2LcV9OePK2PiAhcASp9+DS+hQoYi4Je7JVICuaS9NkTjpjib2XCm+YDh
         sej2H6GaZxPqJKf/Tkp4d0o4LgPAUDnM+SBOcdwORopj4gtoVi8PIO+MapTC3aKoJJEH
         2EyTKhPTqwJehd7B/7VL1zuyxCOjnt/HdvhvisbkIF9ZyAWxhEssGheJctODYXZYsNJj
         kdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F95f71D2jIzfBlGyN1qcD8dXimygAPXCAfU4LdKb+o0=;
        b=WawE1FHD+aINswLtL63PE4l7vwK8lsqBNnPF8SIG+d4GLbsbuTug6dYeT3C4PQzyBU
         G1IeBSFSYNwoirnTR7NgHGedbZfkQVzTqq4ot+YWiaqM4sz2gaJygjM4xrt9IabwL7hT
         ZHayunt/soodsQZce1l1Ds9fng0Sx0f6fEWjuB/W8tZir0KO/DGXrI76T3XV83pWVJrK
         PcEPmeLenon6L1q01b7DQ6Vm3V0lnUfRNHn8R2CiNQmGRaposAkI8uo/6/m5a7iB9/Vg
         qt+hpCFr/E8D7BCDvJuXHI+O/FAlti6A65o0FTWQKUtbD91lA5LB3lSqsTuv9MGsuW+f
         DTmQ==
X-Gm-Message-State: APjAAAUyvHeI60eS7G4Wij2yIIkim0eYzeaPyKrNbZwUmRHjhWfo3kRu
        jtBlVhdixbCBiLRXAS3BKIY=
X-Google-Smtp-Source: APXvYqzIW2PzbD0FC2D2bnfZTM12DQjzoOZuLMkBl5He0b87Zy5WIbrxoaswSbL3+0O9/qzhyxldzw==
X-Received: by 2002:a5d:51c9:: with SMTP id n9mr68447974wrv.334.1582557143508;
        Mon, 24 Feb 2020 07:12:23 -0800 (PST)
Received: from localhost (pD9E516A9.dip0.t-ipconnect.de. [217.229.22.169])
        by smtp.gmail.com with ESMTPSA id n3sm2247765wrw.52.2020.02.24.07.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 07:12:22 -0800 (PST)
Date:   Mon, 24 Feb 2020 16:12:18 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] phy: tegra: xusb: Don't warn on probe defer
Message-ID: <20200224151218.GA2570205@ulmo>
References: <20200224143641.5851-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <20200224143641.5851-1-jonathanh@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2020 at 02:36:41PM +0000, Jon Hunter wrote:
> Deferred probe is an expected return value for tegra_fuse_readl().
> Given that the driver deals with it properly, there's no need to
> output a warning that may potentially confuse users.
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/phy/tegra/xusb-tegra186.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Kishon,

I already have a couple of PHY subsystem patches from JC and Nagarjuna
in a branch in the Tegra tree that I need to resolve a dependency. Do
you mind if I pick this up into that branch as well and send it to you
as a pull request later on? Say around v5.6-rc6?

Alternatively you could provide an Acked-by and then I can take them all
through ARM SoC.

Thierry

> diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-t=
egra186.c
> index 84c27394c181..12d0f3e30dbc 100644
> --- a/drivers/phy/tegra/xusb-tegra186.c
> +++ b/drivers/phy/tegra/xusb-tegra186.c
> @@ -802,7 +802,9 @@ tegra186_xusb_read_fuse_calibration(struct tegra186_x=
usb_padctl *padctl)
> =20
>  	err =3D tegra_fuse_readl(TEGRA_FUSE_SKU_CALIB_0, &value);
>  	if (err) {
> -		dev_err(dev, "failed to read calibration fuse: %d\n", err);
> +		if (err !=3D -EPROBE_DEFER)
> +			dev_err(dev, "failed to read calibration fuse: %d\n",
> +				err);
>  		return err;
>  	}
> =20
> --=20
> 2.17.1
>=20

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5T58wACgkQ3SOs138+
s6HK2A//Uc6bvnvwYC3R0rgqsjQKhZkzdLOEI8/+qvoe9Q0HvINFsEExyjDNqtDl
ySlshrwTbE3yPM7IYt/McEOKPX3sUu2ohxuPkkJDbmrOvy5pMPJXYehR8eZn54No
9609LoVxtyelAMbBwmHG3ghBN1O81zDIzojocrByUcXWhBZ7Mxvi/gtKUh0P9g2K
us8bcsbrlu93D/hoZ/kRsPe4/diOwwk6Zw+HZo8HyvSeVOhcmGmPStFxx5ggl2+h
LPqskdrqs5nYcCmB9tQEOhfMz6UcnpFvITjowOOKKSuEEZhUdLi2n2JSnOEov7qr
xzK6ZaFUB2akiIwbIBlMhBsIi/yqA1Cc40pFVRuUSZ9qHSVAvfQc8zcg8ppIr4dJ
7ZdN5MFIq+KcWnnz6XM5U02Kuor3AzGgSP5scMEo9Z7ucrzymz1ifJfRUvaWYAC9
lhK+9zNCWRr2Obki3PgaJHLnR4/GDh/7Abj/gxHe2aN7fQDRSJHoH7uTf535UMta
FSA/mGfyr67AnqBvDF3bHg/z9FTqWbUNaq/Y0Q1qT5FV+0n1glOBM7qL15QEt6SI
zlpE81h3YapwAQzg9ce3nnnphepgNXMuEcmiXgDmJjfbQzy01JCPUUWHCUrR3xzi
uw/zZmFsD+rU1Aw6G3jbAvDy9L57GjCeSpcvCnNZI2pSzto5pSg=
=e6/4
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
