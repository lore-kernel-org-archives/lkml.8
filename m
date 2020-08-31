Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB38C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79E252068E
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vNjkYRlm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgHaMih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 08:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgHaMiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 08:38:21 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C935C061575;
        Mon, 31 Aug 2020 05:38:20 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id d26so8310170ejr.1;
        Mon, 31 Aug 2020 05:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2Ghd6benh9pMZkzNgaI8YzCaPdDADCfybHIWxZ0IHe0=;
        b=vNjkYRlmVLW0GIVLbXAQkNtQsKUuTp6QJt7K6gBi3ED95BHkal8KZbvyuv0gP+1KKn
         2B7EkRgVyVfas8Vjx6dqi6nODxOD+QwZSsINJ+WWBeYa5MCe4341MuYwKLWBji102oqa
         REJmK7syTflurowPfAwYVcj9d4B7sQ2zSWHGYdebUQhY5TMDQqw+r3bEcKBIK2RhDxgg
         QHy1Yf01onLCrx8wfx3DZVfAQGACpDzT4o81/4w7HrYvmL4/d8qEBYHVl34M6haMOE/+
         SGzH34jhq/mdNpUDFrHt7k0vs9E1CgIm+RDS5jPbNuKgEsXB54ip8uNmOtjUwHu3ItoP
         X18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Ghd6benh9pMZkzNgaI8YzCaPdDADCfybHIWxZ0IHe0=;
        b=qZapMRdCEjo98VZKQhhPmfY1TDE467gSKO5OMn/Va6AWY+vStDt+wrNhDmsbATqIzb
         dVJNmdyqMvtiUH9hyvj5ZNBNx4TmO/cNrGt39pqFrrKvYb8//XmTAq+pWzHHYwlAslEF
         nAFMxB/jCBk1TvsU+IN/HtwrJBzMu73ajpx/ARXZeERwzFvzSA3aMvUe7QVOSmBe6RVB
         OnyB33fe5S56s0NiejwbAlNk4x2iXyQnWnt13pJmYJA7EoNQDAHUeyYs1O/DRGC+POGs
         A773OjV0BSWvxee2neZFSXazs8kwutQwjYdyP4SXTTTpW6tqRc2UVuyxIOwv72DH7cKL
         5uSw==
X-Gm-Message-State: AOAM531mW/YNA39ujjcKEtIihzbV1gmkIa9MlplPbjVeYanvOro8G8VM
        8gX2Q7XKoah3blyvXom9g0IFnN7lL9LNrw==
X-Google-Smtp-Source: ABdhPJy4KJqocHyGT8PzeWW8y1Eo+3fWSFhgASn0yLg0CJfgmcpwj/WbsIJfvZxqyEwcwMtQ/5CMYA==
X-Received: by 2002:a17:907:205c:: with SMTP id pg28mr942111ejb.22.1598877499116;
        Mon, 31 Aug 2020 05:38:19 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id a15sm4153236eje.16.2020.08.31.05.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 05:38:17 -0700 (PDT)
Date:   Mon, 31 Aug 2020 14:38:16 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     JC Kuo <jckuo@nvidia.com>
Cc:     gregkh@linuxfoundation.org, robh@kernel.org, jonathanh@nvidia.com,
        kishon@ti.com, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, nkristam@nvidia.com
Subject: Re: [PATCH v2 09/12] phy: tegra: xusb: t186: support wake and
 sleepwalk
Message-ID: <20200831123816.GF1689119@ulmo>
References: <20200831044043.1561074-1-jckuo@nvidia.com>
 <20200831044043.1561074-10-jckuo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="juZjCTNxrMaZdGZC"
Content-Disposition: inline
In-Reply-To: <20200831044043.1561074-10-jckuo@nvidia.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--juZjCTNxrMaZdGZC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2020 at 12:40:40PM +0800, JC Kuo wrote:
> This commit implements Tegra186/Tegra194 XUSB PADCTL/AO wake and
> sleepwalk operations.
>=20
> Signed-off-by: JC Kuo <jckuo@nvidia.com>
> ---
>  drivers/phy/tegra/xusb-tegra186.c | 656 ++++++++++++++++++++++++++++++
>  1 file changed, 656 insertions(+)

Same comments as for the Tegra210 patch.

Thierry

--juZjCTNxrMaZdGZC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9M7zgACgkQ3SOs138+
s6GQXhAAhItmDp4JJqO1Dns4AMl+DivcQSPSiqC7eLaqPmiND64oCZhxN4ixp/02
qK8S6bzDnV8mdT/1jz4uU7u3HfYW0qSyGK30oWqmYbbRQHI+bUzckaxUwWiD99PC
+ETRN+/N8KyTG+m8TwdqJK8+5XLuMwRbNc1ChsmxGb5KOl6Ej2ct39qJ7ah9M7mL
FHeS9ll34TMhu46oZU2HwcXUvlwKjKnYhh5KUV/W+/ij3h1T2sYyC2KQt2CLfsp2
V5ESRtBugtybpe47+Ujp1vOk62DHLzzd7XJYoiIafUDg0DOHbfc/kARqtTkuh/4h
Ofr3p/A5muZR+N0A2LjfUMWftf1EGJtHB5e+xQwg8M664vM8jgBaf2seoa8BOJh+
8FkYYFNNzhzUHMpAMPtLm+4ZP/b7qIYVLTzZUeArkzfqk5zZp/qRVeDXXDs6SaaW
Ik7uzYD+eFdFAN1u0E+VvkbN5VvUGJwNR7finsuqiOL+xn1LCqY1CSyKA4rtuhdz
6qa+RTHgocfmd0Bb1fp2cDr/BB4oFqqnPCX67j3tLq6kRx0Vpc1cM2EbRsB2AJz6
0KQ1d133P7KzmhTNUyVhhfoK2xvNISTa7DGEZYsnOwjOCooztCDnRxfWEfsjoYkm
F20eVmaiUE0BhTIjIfxomcKtFrIbo1/JA6ds+TWwmGh/BS5Z+8Y=
=AcBR
-----END PGP SIGNATURE-----

--juZjCTNxrMaZdGZC--
