Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D9BC33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 11:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB6620661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 11:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oLPeepQ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgBCL2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 06:28:25 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44433 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgBCL2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 06:28:24 -0500
Received: by mail-wr1-f66.google.com with SMTP id m16so17515234wrx.11;
        Mon, 03 Feb 2020 03:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mruua/QXPoTkXaZhNOYpWNabFdF8EK/IibXlAO62+YU=;
        b=oLPeepQ4OmcmZWIMZhZz4kN7jRFEusSQTjPYJMIO5e2Z6+DYYeOE1qXkrOFZdvDkkO
         PF4J0pvYoTRV2t7ObAtfC9FLVoJt9iN+o3CGo2m8ILE2y857JDTmMmoL8slH49xpJ2+w
         xR8pVrr5m6fp0HHusTTqIhVUyoYY8OORaOxAPyuhXPeAPipwpcQzKInoKWG98DesfBKT
         0dLMInU0ZPqiHCki8VS08cHkbmSRy58rc3t+A7PaktDfxaXmABsjKJ1DJ8PuiAn3Q0It
         hR32DWDelAgLfcDqo6ev3VAElU75NU8SoYGxHVwlRdj76b2hHG57/5oxEscL5wo8Qwe0
         Rm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mruua/QXPoTkXaZhNOYpWNabFdF8EK/IibXlAO62+YU=;
        b=qrUXNwXaY8Jk14oO/YG6RuAF6kWG0EuoBg+QU6yp6I+2Ot4/zs4kPqoWvnqmq+sZYL
         fMIgHst93jT7kNQQqVd/eW7d9tZQKXXBq04xjQstMyQLzxkv1sFobeZmQDiUlK6cZCsV
         TuW6Q8PnhrSq6jcJxyp5aYhq3vMD3vOQKbM8rZZ50eq0KwpIjln63P7sK2j/9bxnPG//
         fQGj00tN5J54u+pIOrUTawD9ILWlAehsq+WBPOtlSTvrfUESISuSCdAcbEbhs6NoO2kK
         8BdUqroXHBLHEaSVWTBKDWmJ6LXthK8rKu0rwRh1bVmOAiwXORmeEJSIwW0J9KRsskfe
         ew0Q==
X-Gm-Message-State: APjAAAVgErIRIkF/inKka7FqVUzcFZtcDTxgvYKgHjKJivcUfnu80C8A
        xDpblxkhlJ2/xKR1yG3fJhc=
X-Google-Smtp-Source: APXvYqwMpxTMmmlsdRwzY/RHj7AI8BNd6KDvoBuz0NnnyIvpnZ+xNuu086sGC67YKFU4I4fgFjydhg==
X-Received: by 2002:adf:e70d:: with SMTP id c13mr14776864wrm.248.1580729301361;
        Mon, 03 Feb 2020 03:28:21 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id b16sm22600565wmj.39.2020.02.03.03.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 03:28:19 -0800 (PST)
Date:   Mon, 3 Feb 2020 12:28:18 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] usb: phy: tegra: Add clarifying comments about the
 shared registers
Message-ID: <20200203112818.GA3506060@ulmo>
References: <20200202224259.29187-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <20200202224259.29187-1-digetx@gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2020 at 01:42:59AM +0300, Dmitry Osipenko wrote:
> Tools like Coccinelle may erroneously recommend to use the
> devm_platform_ioremap_resource() API for the registers mapping because
> these tools are not aware about the implementation details of the driver.
> Let's add a clarifying comments to the code, which should help to stop
> future attempts to break the driver.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/usb/phy/phy-tegra-usb.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-=
usb.c
> index 037e8eee737d..6153cc35aba0 100644
> --- a/drivers/usb/phy/phy-tegra-usb.c
> +++ b/drivers/usb/phy/phy-tegra-usb.c
> @@ -969,6 +969,10 @@ static int utmi_phy_probe(struct tegra_usb_phy *tegr=
a_phy,
>  		return  -ENXIO;
>  	}
> =20
> +	/*
> +	 * Note that UTMI pad registers are shared by all PHYs, therefore
> +	 * devm_platform_ioremap_resource() can't be used here.
> +	 */
>  	tegra_phy->pad_regs =3D devm_ioremap(&pdev->dev, res->start,
>  					   resource_size(res));
>  	if (!tegra_phy->pad_regs) {
> @@ -1087,6 +1091,10 @@ static int tegra_usb_phy_probe(struct platform_dev=
ice *pdev)
>  		return  -ENXIO;
>  	}
> =20
> +	/*
> +	 * Note that PHY and USB controller are using shared registers,
> +	 * therefore devm_platform_ioremap_resource() can't be used here.
> +	 */
>  	tegra_phy->regs =3D devm_ioremap(&pdev->dev, res->start,
>  				       resource_size(res));
>  	if (!tegra_phy->regs) {

I'm not sure it's really going to stop *all* attempts. But at least for
people that go through the trouble of reading the comments, yes, this
should do the trick, so:

Acked-by: Thierry Reding <treding@nvidia.com>

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl44A9AACgkQ3SOs138+
s6E5LA//eA+l0WY720Az8s4VDR4EoNCATb9zoF8BYUaqhMGRF3PGFK2ih0Fblls4
U8foPI8ezcnxqIVwfI8dzfFhGMlAf0lKyJbEmPfBofwLjrprH9jDDcD2aYBEqDtB
Hco1ZZRHmRcSLvzSIZIf5oOfm2aGzqHVjbCbi+eKS4k2LYg3pJbEbZVwV0QYUCkV
bgrxv9+RfTm3umKVXd9pL41j8zhVrvSgE7ta32AilhU7BSSIAQjBD3o/COr2H8w5
rgIPHVlIRgoEEfGUdGc0yk/xHY5uaLy2LX98HZ8O3sI7LdveevDtlUaDowDHU4+k
Y3uZio3jNsUccxRm3lmIB2hpjjJ06J0A1r0Aa6Z/pEpJL3d6Z9U8WoB73SHJGX0t
rNUzt3KC2h4w38sYAUtYm0r2YRc1vcRN6xE+gA74VUn48H2T8Ih3BLSCExaOVwbw
FtAcmq5KYYCHAe2GLITEGqjJ98P5RiG8Irda9N2IRD87HMFUwFFbr5ZRSbDZklpV
WAWCHxf8K6QAjk0HBbSCG1HqMJ0iOVjEXWj48wjJvrLchyrpYnFV9A3TGKTQfUZB
FwVqrua3RIEtzxzstc+z3/6ywa7cg/BOZobL0NiFHqE3s546zymlG7fjqu35xeX+
cWebVl3Pvt/ueJ16bAhtr8ippPBFS9sDlZ9uacJqfBRN7R0d0mM=
=GgDd
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
