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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE70C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B007921D7D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hgjxNjVH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgAWTr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 14:47:57 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46074 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgAWTr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 14:47:57 -0500
Received: by mail-pf1-f196.google.com with SMTP id 2so2007296pfg.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 11:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jsKm7uQ/M3fV/Hl98TUo3mBldRH6sHUcLr0Q3KHcuUc=;
        b=hgjxNjVHdxkbRC3d9M/g3zvdD98/R3Dqh97INNFYrnLQYKs4CKggTQmcY4jV2QOzMl
         IAoace4kQ9z95TJtWo1/MMCWAUqYE1jZCpwx1VJ+tKo7btY44JdjiSEh3L/uIevNSPl3
         B30A6t1hI73zDw1QstziR7ksGe7IuGdtav0Kz4RhBIItKs3l71nIDuTySKxqbkwZMEeJ
         U84q4X6Y0e/Vs5USJEz40cMEvW/qmf3ZCeu7w7OibrDQ+pMJowNjIJtKnFp7qx9REZb/
         fozpuNztsVOnW8jyc8NHNSx0sKqJ1q3VEFdMsTLDsAYYwu7BV8DEHJjPXz0SAZaPZibW
         HTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jsKm7uQ/M3fV/Hl98TUo3mBldRH6sHUcLr0Q3KHcuUc=;
        b=A6x/pJTJHdtCWiZxJ5dTKoelojMUTszb5y7XaE/+QYjQPgZMYJ53FvAnHbyJ1Mkkwc
         1ewb7Frv5ax3PmnMwZGS9ExAcgA6qlPTADFtpB6j87xbH69Rc/q8irrlflpEFRd/QYuR
         g2ajbBPlbvmZXU/jrS6FN9ngTG2uNSdQBLaVFBXUSYAjv6wHgMFVmQaBbQ0lwUsFYhr9
         neCOLHdaVJfMBJ/hIUABBFGpvPGOHG1tKzHWFRI92M3MiNBIS+34AwKhbpkNTU+0xojV
         tq+J8ZOA63LQx50bxICH8yANEzJINHvGCZOMprRF9/1H1dlXUPu818DZVHFCALMzh8pn
         osrQ==
X-Gm-Message-State: APjAAAV3qS9I8Aro54fwbCjCItyjjdD1nxHXv15zwL9eJbvQC2glevZU
        H56TFmp6cv6+l3cjaHDAIB1Gew==
X-Google-Smtp-Source: APXvYqwp+nLRUdK7ctX15I3ApM4YOaeFfVe7duH0amva3HImbwJmRccPwOw4UfnZw9MWBHrBfQ+TIw==
X-Received: by 2002:a63:4641:: with SMTP id v1mr390016pgk.389.1579808876514;
        Thu, 23 Jan 2020 11:47:56 -0800 (PST)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id j125sm3335643pfg.160.2020.01.23.11.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 11:47:55 -0800 (PST)
Date:   Thu, 23 Jan 2020 11:47:51 -0800
From:   Benson Leung <bleung@google.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: cros_ec: Drop unaligned.h include
Message-ID: <20200123194751.GB39759@google.com>
References: <20200122004958.71836-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Content-Disposition: inline
In-Reply-To: <20200122004958.71836-1-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Tue, Jan 21, 2020 at 04:49:58PM -0800, Stephen Boyd wrote:
> This include isn't used. Remove it.
>=20
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Applied to our for-next. Thanks!

> ---
>  drivers/platform/chrome/cros_ec.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/=
cros_ec.c
> index 6d6ce86a1408..81054de0dd81 100644
> --- a/drivers/platform/chrome/cros_ec.c
> +++ b/drivers/platform/chrome/cros_ec.c
> @@ -16,7 +16,6 @@
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_ec_proto.h>
>  #include <linux/suspend.h>
> -#include <asm/unaligned.h>
> =20
>  #define CROS_EC_DEV_EC_INDEX 0
>  #define CROS_EC_DEV_PD_INDEX 1
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

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXin4ZwAKCRBzbaomhzOw
wiC4AP4h4GvT7x/ofq3XFpRFURRd7ByZjhnpr+esUIEJ65MFYAEAhebF3/NVro9E
gte6VrhJy/jBvAFgdfDknOvJ/WfEmgQ=
=EFpK
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
