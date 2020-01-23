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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E45CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB4B2253D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cAeYIJmS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgAWTrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 14:47:32 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:56173 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgAWTrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 14:47:31 -0500
Received: by mail-pj1-f67.google.com with SMTP id d5so1664776pjz.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 11:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vdmU0jLpSD9ykGfPb5QcN6awzc1uTtm75lH4f546Rsc=;
        b=cAeYIJmScJMrNPFeHyWgE6Ln9g52Rg53ikr1/WLf6WcBGsLnUsFxtORsXbbCI7/q1l
         IiU8e+OBL8fAhKZ5XTAAOUSsAnCqnpyOeUH5gBs4zFmUm76eELJDlSnIqYGEHLytwK1m
         uMQ/tM8xApO+7Kg2Ga9sQM3BnII/x+XQiFFtTUfGsjJurISi08ku8W0xjtNmuC43KPES
         r8FEvD+zWKfEqiBkFBZQHmN4Gaf3J5wv8WBRQ5hBw9EBFMKFMJsHv37giJ4zXUUvGELS
         prj/+UQ9LyzhuwU9ZznmeW/WLF9ylSSW7KhAkKg6KZBsJpU142M6s1Jw57dDmdUvI3c7
         3f1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vdmU0jLpSD9ykGfPb5QcN6awzc1uTtm75lH4f546Rsc=;
        b=jsRluyIzoMgCmtxYE3nACkDrF6V2kIrnd9FsmOelqC7PhZ1Lz93NuH28I/lTBgPuNO
         h7BDQlVgsRhfqQ9QUW3Ge+sU9QchLTXnZ/OfuAkEigDnoG0felaFp8+93DGIK+Vp/FFN
         3Y06TzuIJRpmV30HIwjlSepeAos8V6xmuPxE0hktZTRW1/T1SPI4FELdeUhU+adTjaBX
         2r4zd4QEzkUbidnrb/Kydpg2gSNFFDpMiawUyosfkX7qf8de4fDjtwe1wgU89g7b3/U9
         Q8rMWSxNa9TqLJDtTpq9HQLCvKBIo7oJyz16zes7esLmNVZ73IRvDUQebC9wewB94pht
         I72A==
X-Gm-Message-State: APjAAAVJ37aWBd+U7emBMfliJyWrmrWcpaDQtFxbd8pzq+jM+XcrMT06
        UNT5cy4BmsQgeNWqoqjQ7fFQvw==
X-Google-Smtp-Source: APXvYqwfX6fQMehjbjAlWTQiRg4GFs+GLiVG1ZzRhcoxKk6Ne9JiCv6vZSffC3w363hEcGOoMw+LFQ==
X-Received: by 2002:a17:902:7046:: with SMTP id h6mr16770464plt.231.1579808850673;
        Thu, 23 Jan 2020 11:47:30 -0800 (PST)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id 11sm3540497pfz.25.2020.01.23.11.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 11:47:29 -0800 (PST)
Date:   Thu, 23 Jan 2020 11:47:25 -0800
From:   Benson Leung <bleung@google.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org, Nick Crews <ncrews@chromium.org>,
        Daniel Campello <campello@chromium.org>
Subject: Re: [PATCH] platform/chrome: wilco_ec: Add newlines to printks
Message-ID: <20200123194725.GA39759@google.com>
References: <20200122004032.65008-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <20200122004032.65008-1-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Tue, Jan 21, 2020 at 04:40:32PM -0800, Stephen Boyd wrote:
> printk messages all require newlines, or it looks very odd in the log
> when messages are not on different lines. Add them.
>=20
> Cc: Nick Crews <ncrews@chromium.org>
> Cc: Daniel Campello <campello@chromium.org>
> Cc: Daniel Campello <campello@chromium.org>
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Applied to our for-next. Thanks!

> ---
>  drivers/platform/chrome/wilco_ec/core.c          | 2 +-
>  drivers/platform/chrome/wilco_ec/keyboard_leds.c | 8 ++++----
>  drivers/platform/chrome/wilco_ec/mailbox.c       | 4 ++--
>  drivers/platform/chrome/wilco_ec/telemetry.c     | 6 +++---
>  4 files changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/c=
hrome/wilco_ec/core.c
> index 2d5f027d8770..5b42992bff38 100644
> --- a/drivers/platform/chrome/wilco_ec/core.c
> +++ b/drivers/platform/chrome/wilco_ec/core.c
> @@ -94,7 +94,7 @@ static int wilco_ec_probe(struct platform_device *pdev)
> =20
>  	ret =3D wilco_ec_add_sysfs(ec);
>  	if (ret < 0) {
> -		dev_err(dev, "Failed to create sysfs entries: %d", ret);
> +		dev_err(dev, "Failed to create sysfs entries: %d\n", ret);
>  		goto unregister_rtc;
>  	}
> =20
> diff --git a/drivers/platform/chrome/wilco_ec/keyboard_leds.c b/drivers/p=
latform/chrome/wilco_ec/keyboard_leds.c
> index 5731d1b60e28..6ce9c6782065 100644
> --- a/drivers/platform/chrome/wilco_ec/keyboard_leds.c
> +++ b/drivers/platform/chrome/wilco_ec/keyboard_leds.c
> @@ -69,7 +69,7 @@ static int send_kbbl_msg(struct wilco_ec_device *ec,
>  	ret =3D wilco_ec_mailbox(ec, &msg);
>  	if (ret < 0) {
>  		dev_err(ec->dev,
> -			"Failed sending keyboard LEDs command: %d", ret);
> +			"Failed sending keyboard LEDs command: %d\n", ret);
>  		return ret;
>  	}
> =20
> @@ -94,7 +94,7 @@ static int set_kbbl(struct wilco_ec_device *ec, enum le=
d_brightness brightness)
> =20
>  	if (response.status) {
>  		dev_err(ec->dev,
> -			"EC reported failure sending keyboard LEDs command: %d",
> +			"EC reported failure sending keyboard LEDs command: %d\n",
>  			response.status);
>  		return -EIO;
>  	}
> @@ -147,7 +147,7 @@ static int kbbl_init(struct wilco_ec_device *ec)
> =20
>  	if (response.status) {
>  		dev_err(ec->dev,
> -			"EC reported failure sending keyboard LEDs command: %d",
> +			"EC reported failure sending keyboard LEDs command: %d\n",
>  			response.status);
>  		return -EIO;
>  	}
> @@ -179,7 +179,7 @@ int wilco_keyboard_leds_init(struct wilco_ec_device *=
ec)
>  	ret =3D kbbl_exist(ec, &leds_exist);
>  	if (ret < 0) {
>  		dev_err(ec->dev,
> -			"Failed checking keyboard LEDs support: %d", ret);
> +			"Failed checking keyboard LEDs support: %d\n", ret);
>  		return ret;
>  	}
>  	if (!leds_exist)
> diff --git a/drivers/platform/chrome/wilco_ec/mailbox.c b/drivers/platfor=
m/chrome/wilco_ec/mailbox.c
> index ced1f9f3dcee..0f98358ea824 100644
> --- a/drivers/platform/chrome/wilco_ec/mailbox.c
> +++ b/drivers/platform/chrome/wilco_ec/mailbox.c
> @@ -163,13 +163,13 @@ static int wilco_ec_transfer(struct wilco_ec_device=
 *ec,
>  	}
> =20
>  	if (rs->data_size !=3D EC_MAILBOX_DATA_SIZE) {
> -		dev_dbg(ec->dev, "unexpected packet size (%u !=3D %u)",
> +		dev_dbg(ec->dev, "unexpected packet size (%u !=3D %u)\n",
>  			rs->data_size, EC_MAILBOX_DATA_SIZE);
>  		return -EMSGSIZE;
>  	}
> =20
>  	if (rs->data_size < msg->response_size) {
> -		dev_dbg(ec->dev, "EC didn't return enough data (%u < %zu)",
> +		dev_dbg(ec->dev, "EC didn't return enough data (%u < %zu)\n",
>  			rs->data_size, msg->response_size);
>  		return -EMSGSIZE;
>  	}
> diff --git a/drivers/platform/chrome/wilco_ec/telemetry.c b/drivers/platf=
orm/chrome/wilco_ec/telemetry.c
> index 1176d543191a..e06d96fb9426 100644
> --- a/drivers/platform/chrome/wilco_ec/telemetry.c
> +++ b/drivers/platform/chrome/wilco_ec/telemetry.c
> @@ -367,7 +367,7 @@ static int telem_device_probe(struct platform_device =
*pdev)
>  	minor =3D ida_alloc_max(&telem_ida, TELEM_MAX_DEV-1, GFP_KERNEL);
>  	if (minor < 0) {
>  		error =3D minor;
> -		dev_err(&pdev->dev, "Failed to find minor number: %d", error);
> +		dev_err(&pdev->dev, "Failed to find minor number: %d\n", error);
>  		return error;
>  	}
> =20
> @@ -427,14 +427,14 @@ static int __init telem_module_init(void)
> =20
>  	ret =3D class_register(&telem_class);
>  	if (ret) {
> -		pr_err(DRV_NAME ": Failed registering class: %d", ret);
> +		pr_err(DRV_NAME ": Failed registering class: %d\n", ret);
>  		return ret;
>  	}
> =20
>  	/* Request the kernel for device numbers, starting with minor=3D0 */
>  	ret =3D alloc_chrdev_region(&dev_num, 0, TELEM_MAX_DEV, TELEM_DEV_NAME);
>  	if (ret) {
> -		pr_err(DRV_NAME ": Failed allocating dev numbers: %d", ret);
> +		pr_err(DRV_NAME ": Failed allocating dev numbers: %d\n", ret);
>  		goto destroy_class;
>  	}
>  	telem_major =3D MAJOR(dev_num);
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

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXin4TQAKCRBzbaomhzOw
wlZLAP9EviprqUjgkzJRhaOVTe/HCMjZwA8Z3ThCxDqoqIEc2wD9GeNafWb1X4XG
ghEJFdEcYV4rJH0FPHj4OpouJHUETAo=
=JtNK
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
