Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40E9C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73A4E206A5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NQtJyatM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgEDU71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 16:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgEDU71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 16:59:27 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CBEC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 13:59:26 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id j21so376439pgb.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 13:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3JdpcqZqr6ZatadV2aPp9eCHAtmx/v+LJihHu1z34FU=;
        b=NQtJyatMdd8k/F1zW2IziCX4yYZd10UKuva0fmtRfMOs1TYAafM82iyX+DCilH0v+N
         cGz/qlWnAiLFPfVScx+56TbEHQoD2cOqdc9JmYxTQXub2BAWjLqG7t4hluV8LNszcNeG
         jm0TiZu3/QPREfLV5mimyFVaiB4jEIOG2afc27Ekx02wwYCGzRvCAXhKxq7LcYjJsZyn
         RXqipCb38hztZccLR8Kf9qanYtUoPlC1k6nmfZ2KLbqV5s/xQMZexmI/oZYtLRrqa62P
         31sOM6N+K6ca38feeaniCBgMdqvEq9ASlX/sBXUij5NPOpk9EGw4JWlS1PtDEOCIhrYm
         zqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3JdpcqZqr6ZatadV2aPp9eCHAtmx/v+LJihHu1z34FU=;
        b=HlAWLro01BXntPp1QiKL+AH7WlKdVA54JaZVuk+s20EN5WlONZrhQukP9itN3ut614
         ap5oz8woSQNyx58V6MB7UWJbxvCwAzcaVprkN8UGw+KP/HJYtXe57En1Fn9xVF5urnfA
         afFYifU8AJT7uVgR75q5PDoSkd1yvr7XL+Wq3CFyCz6cdV/uV1Ua5Sp7rNoI1RQyHzvd
         lK1oWeL0mlXTCoLpC2W6DnY9H9hb0WBJTzm3j5ZdVbVMxvvHG8hrCIGqmQtECyd7vi5s
         r9cLSvJGiZQmAFwk0NAen1Qnhu00OXRHWWSzyB3d9c/2jggTyJm//pr8yoL8tKDDIjln
         vSXg==
X-Gm-Message-State: AGi0PuYbwBCvpDuhs9ZY3aowGE1wSu3Kv0yq+keZyl4SPtJoT4UzIJq+
        UG0xqfbwyN4fmrlpEv9hd60Taw==
X-Google-Smtp-Source: APiQypIL5AAzAErF/FQjRhdrfinFezUf6DdcYLUKz5nTxOneMTMXJks+LKP3kJ+O62ex7uM2ycglrg==
X-Received: by 2002:a63:e547:: with SMTP id z7mr94099pgj.177.1588625965915;
        Mon, 04 May 2020 13:59:25 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id d184sm9490866pfc.130.2020.05.04.13.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 13:59:24 -0700 (PDT)
Date:   Mon, 4 May 2020 13:59:20 -0700
From:   Benson Leung <bleung@google.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        groeck@chromium.org, bleung@chromium.org, dtor@chromium.org,
        gwendal@chromium.org
Subject: Re: [PATCH] platform/chrome: cros_ec_i2c: Appease the kernel-doc
 deity
Message-ID: <20200504205920.GA102727@google.com>
References: <20200414201313.1507146-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <20200414201313.1507146-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Enric,

On Tue, Apr 14, 2020 at 10:13:13PM +0200, Enric Balletbo i Serra wrote:
> Replace a comment starting with /** by simply /* to avoid having
> it interpreted as a kernel-doc comment.
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Applied for chrome-platform-5.8. You'll find it in the for-kernelci branch
very shortly.

Thanks,
Benson

> ---
>=20
>  drivers/platform/chrome/cros_ec_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/chrome/cros_ec_i2c.c b/drivers/platform/chr=
ome/cros_ec_i2c.c
> index 6119eccd8a18..30c8938c27d5 100644
> --- a/drivers/platform/chrome/cros_ec_i2c.c
> +++ b/drivers/platform/chrome/cros_ec_i2c.c
> @@ -16,7 +16,7 @@
> =20
>  #include "cros_ec.h"
> =20
> -/**
> +/*
>   * Request format for protocol v3
>   * byte 0	0xda (EC_COMMAND_PROTOCOL_3)
>   * byte 1-8	struct ec_host_request
> --=20
> 2.25.1
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXrCCKAAKCRBzbaomhzOw
wmezAP4oxIeHK6RIJ11Y6Th7zyLUPJ4EFHzhoIPvho+NcTR7/QD+KG7b/3OxsYRp
XQttAOBgRJMxTjIrXlWAFPkNypBatQY=
=Sk8M
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
