Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE78C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E12F207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="l2oNMmzb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgGXKCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 06:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgGXKCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 06:02:01 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9D3C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 03:02:00 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j18so7429342wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 03:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:autocrypt:organization:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=ETTFf4wmiYAwG37FeR1CBrvLhZ/8pGjI5/6LrVnomJo=;
        b=l2oNMmzberdgprEA9LKbZQY4jQi5ZqynbIOLbJdbz3ATL/y++RRnhA2bDMqTbSkvbJ
         geaWP7V2Bxvswpr7YVTitzWW0bCYC26fXIW5KdRKeCWxUzr1+tN8DF0KdOQpYDjX3HUh
         5ZMI01HzLqoi3zLGLUwXFvlDqgUkGfpgWAZBAt/0TJzt+aNWC0vJPrYbR4v07mhuU6Kj
         wSjP0Zr6vl6hmepm8le6xIMLssYBUihBZG1S582pkpJQAziC13UoeH2nAOimg7Oygbeh
         /ZnHXeuVGGbje+6Favy6OD4p9PC13bIkYm33lcf2HYhNRvBHmaQTXMbqjPte/uMPvZVE
         FaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to;
        bh=ETTFf4wmiYAwG37FeR1CBrvLhZ/8pGjI5/6LrVnomJo=;
        b=J8PukvFRv9CFT1rQ7v3DP9lOaWXAAr8MydKiG732x4oLflN/J5I7fxB7eMMX7AM5lv
         m7mA15h+mgAdkPyW0QvOdw9WTjCQ6eO3PphdAQLQFubEqn72HVUnUAYlb2DBpbm5Zv/3
         KIEgRYf8oLIB/aDbA0wHadeOgFYa5o3H1KQLiRseeKE2csGAiXBy2YWIXeFJNTq77wp/
         zf+8K9aoIEW+43YTNdEghYvF84RPPHbc8ew2J59E62w06VyCe9L47Mse+gUn0dgjoWxj
         8Pmw14VoPj7ZwbuUvhh+nxftU1fOl0DkhK9AGcAwAGcZ2RoEQj9Rmcp1n7AVX1io+20W
         C38g==
X-Gm-Message-State: AOAM530O5aQd5bIUO4HqYfKJAS5bEe0K7eKKu+7qNnPkAZSiQ98R+J+4
        SIJZzkWZDbvBGbKvgE+PUF4o34Y/1g+72g==
X-Google-Smtp-Source: ABdhPJwFSlLC2uwvbRJEVrmm11MnZBmhuVWfFqzMz30ulb+OVEiKJ26SxOJdTBt+DQaYaUQzP+6/Pg==
X-Received: by 2002:a1c:2e10:: with SMTP id u16mr8586176wmu.121.1595584918955;
        Fri, 24 Jul 2020 03:01:58 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2ec0:82b0:c02:85df:32ef:2826? ([2a01:e35:2ec0:82b0:c02:85df:32ef:2826])
        by smtp.gmail.com with ESMTPSA id z207sm6675425wmc.2.2020.07.24.03.01.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 03:01:57 -0700 (PDT)
Subject: Re: [PATCH] mtd: rawnand: oxnas: cleanup/simplify code
To:     Pavel Machek <pavel@ucw.cz>, trivial@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        nishkadg.linux@gmail.com, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io,
        linux-kernel@vger.kernel.org
References: <20200724083825.GA31437@amd>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <7037f4aa-6b6d-9354-ab4a-261dd754312e@baylibre.com>
Date:   Fri, 24 Jul 2020 12:01:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724083825.GA31437@amd>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="1osgL1HrQRCyLuS36Y5b591kCssibF0Ud"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1osgL1HrQRCyLuS36Y5b591kCssibF0Ud
Content-Type: multipart/mixed; boundary="MLFbQRSFKY5Y0iWBFLltuOdIA1HjCBgfD";
 protected-headers="v1"
From: Neil Armstrong <narmstrong@baylibre.com>
To: Pavel Machek <pavel@ucw.cz>, trivial@kernel.org,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 nishkadg.linux@gmail.com, linux-mtd@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io,
 linux-kernel@vger.kernel.org
Message-ID: <7037f4aa-6b6d-9354-ab4a-261dd754312e@baylibre.com>
Subject: Re: [PATCH] mtd: rawnand: oxnas: cleanup/simplify code
References: <20200724083825.GA31437@amd>
In-Reply-To: <20200724083825.GA31437@amd>

--MLFbQRSFKY5Y0iWBFLltuOdIA1HjCBgfD
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24/07/2020 10:38, Pavel Machek wrote:
> Simplify oxnas_nand_probe.
>=20
> Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>
>=20
> diff --git a/drivers/mtd/nand/raw/oxnas_nand.c b/drivers/mtd/nand/raw/o=
xnas_nand.c
> index 8d0d76ad319d..f44947043e5a 100644
> --- a/drivers/mtd/nand/raw/oxnas_nand.c
> +++ b/drivers/mtd/nand/raw/oxnas_nand.c
> @@ -144,8 +144,7 @@ static int oxnas_nand_probe(struct platform_device =
*pdev)
>  		if (err)
>  			goto err_cleanup_nand;
> =20
> -		oxnas->chips[oxnas->nchips] =3D chip;
> -		++oxnas->nchips;
> +		oxnas->chips[oxnas->nchips++] =3D chip;
>  	}
> =20
>  	/* Exit if no chips found */
>=20

Acked-by: Neil Armstrong <narmstrong@baylibre.com>


--MLFbQRSFKY5Y0iWBFLltuOdIA1HjCBgfD--

--1osgL1HrQRCyLuS36Y5b591kCssibF0Ud
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEPVPGJshWBf4d9CyLd9zb2sjISdEFAl8asZQACgkQd9zb2sjI
SdFGgg//UK29TR3ksZypqacBWZP7/6as2cXDn/e/IT5U1e3hqfvTlsefQWcM6wDm
o0aVwOyP+PLqPTRv3zdQYptZB+55aaZQu1osQv3YZ5+1FII6Vo7gbXOZ3V0W0KYq
jeASNlkDJ9QqrlyjNUQx8KbWIRfisgTl58Ld0uRA5QY7Iq7P4AeoTjBb66lJU2jM
Tm+vZWN1LMsuQBT61m5xA0AHQKswN8cUmByf4dr71mLr+/wcePPVD9SeLwaQ1uSF
hncE1VYf05QZPtZTZ5Yvc15dfSFdAS/MpyqVpl9rHAXeAnrFMkEVc2TVUyMEMmNs
PVVZlr55KqMJwJbI0U1AE7S7tW8pBnDjxkc02Zf1TENlPvmNfwTEvAP9oJpIb0VT
JvVAFR/h9GMP/Q74RgjUqmalspNdasq8w/3ki5bexhlOfv7xNSPhhMTepXetcthV
u05E1TcAJyaKdrdAKpBfkbPy+oyOoojG4rjveM3pO9iXD7zLYVdZuNvc2qEpR4ex
+gFEcY26qlbC+Rh0INZpXM2aqcEIDqgMcspIqRUNndmjH2PHqjgrZ9ZHDeLjrPAG
jfFH2rbDsvsgZjw7C2CmsjjwP+MXwBocCuwq2U77OsezCieYFLGek6LXm9eWsXpQ
QjpgRBDOBOyWamhIcRMRTu3Gvk8mQ8lPrqYecVs1rnGWPQ4blu4=
=krkY
-----END PGP SIGNATURE-----

--1osgL1HrQRCyLuS36Y5b591kCssibF0Ud--
