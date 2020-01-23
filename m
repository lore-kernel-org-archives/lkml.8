Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14C8C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A682021D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dB5eLweq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgAWTo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 14:44:28 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52553 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728809AbgAWTo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 14:44:27 -0500
Received: by mail-pj1-f66.google.com with SMTP id a6so1663814pjh.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 11:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oe3tpj2pn2SzEi+ANvf3NoFA5tjVK51f2HZBdQilqo0=;
        b=dB5eLweqvf35TPBISdU1xwmmdp6QInxS68BBL1qL5puHCpmiDALbpV3Iceg5o3Xo1e
         W9vyT9P27GwgfmQL+35eWYC8IVKOLUrhWpSzN+yFnlnuAVCsjP750kfnlk2magiju4iP
         TZcIkl0c+uYchItL7CKwbwObusC4E6sY7r7zXbX1B/ojCS0WVYzEcVNtx1JUfB2lOFtO
         tyfWXrESpoAwPYGqnrkyczdvDaVlABpA32/y+eSkdL71mt7ZZygAJXVaROuJ8iayFHUq
         L8itS5Da/GoRcsKsGVI7rSpirAnNKWwRLOWJngll6cK7aLp2twegubUI3SfDvO+bKO2L
         TxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oe3tpj2pn2SzEi+ANvf3NoFA5tjVK51f2HZBdQilqo0=;
        b=s8KKcy8/qHdrMiuFVjI7G11/GZG1GGrohEYDbEy2tYVEb7WIP2qDk6lRrmm2C7g2Ll
         vJu6+gJhpP2mzWbCPgEU588pV6qBl5f0QKaS1PaSNWvHlYY93LR4EYqKvcPtGmMWKzSl
         9b/X6I8HlxT8eflOHf5gOULRfeXuJ/djtj+adUMVIlREX5uUovwti8vfh1Td5dFj0JDN
         euf66d9J1oHf2Kip4+BzTanPamp6zGR+Ln5UUzSByISsk1tYHwNvH1+C6SpN1DAxEPbA
         iSTETrAEUQXFqVSilP30qfOutfcs6sbZ1vQFBxRhsDl7Yw/FVKl5agaYc7531jmKwGw7
         GUPg==
X-Gm-Message-State: APjAAAWTav1C/z+tDOC4il4/qE4HMSblsIdlYoq8cyLVvOHd7WCFeo2o
        FTrvAmguK6ezFZOzORNU299EUg==
X-Google-Smtp-Source: APXvYqyD3wqyjLxo2F04nerpBjM8ZiRe3VcD2gewHYuCRmu8XhXMG4uG9TbTYkV/0z+6rFCH5gxrcw==
X-Received: by 2002:a17:90a:a409:: with SMTP id y9mr6265671pjp.119.1579808666706;
        Thu, 23 Jan 2020 11:44:26 -0800 (PST)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id d1sm3704244pjx.6.2020.01.23.11.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 11:44:25 -0800 (PST)
Date:   Thu, 23 Jan 2020 11:44:21 -0800
From:   Benson Leung <bleung@google.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: wilco_ec: Allow wilco to be compiled in
 COMPILE_TEST
Message-ID: <20200123194421.GA38491@google.com>
References: <20200122012434.88274-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <20200122012434.88274-1-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Tue, Jan 21, 2020 at 05:24:34PM -0800, Stephen Boyd wrote:
> Enable this Kconfig on COMPILE_TEST enabled configs so we can get more
> build coverage.
>=20
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Applied to our for-next. Thanks!

> ---
>  drivers/platform/chrome/wilco_ec/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/chrome/wilco_ec/Kconfig b/drivers/platform/=
chrome/wilco_ec/Kconfig
> index 365f30e116ee..49e8530ca0ac 100644
> --- a/drivers/platform/chrome/wilco_ec/Kconfig
> +++ b/drivers/platform/chrome/wilco_ec/Kconfig
> @@ -1,7 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config WILCO_EC
>  	tristate "ChromeOS Wilco Embedded Controller"
> -	depends on ACPI && X86 && CROS_EC_LPC && LEDS_CLASS
> +	depends on X86 || COMPILE_TEST
> +	depends on ACPI && CROS_EC_LPC && LEDS_CLASS
>  	help
>  	  If you say Y here, you get support for talking to the ChromeOS
>  	  Wilco EC over an eSPI bus. This uses a simple byte-level protocol
> --=20
> Sent by a computer, using git, on the internet
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXin3lQAKCRBzbaomhzOw
whJMAP0XYnJILlRQ1+86WnPMH8i2l18UKemSCUSkgLHwqfkCtQEAq7nbNNSGiuVr
uxQVrA5c+J6616WfSQ7qvY986N7bBQY=
=P96i
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
