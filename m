Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA75C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4443920775
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p9vwGiUu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgDVA5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 20:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726012AbgDVA5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 20:57:07 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBF1C0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 17:57:06 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id p25so184054pfn.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 17:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gXQ0ZKU9rPACm1NpC5IpEEgnJ67XgjPS3brhHlbPLjM=;
        b=p9vwGiUuSpsVhM1Y+a097TYl/ukBeFkhuEwwf+3Jq0gA4gZv4VS0+xejL+med599lx
         bxrZ209gl+eKh4FVuewcX7Iw7bALgT9IIOTFdrQcxUh2NFHDH2pKAQjRzIaWanFbGZo9
         HI73+YSyNwZZ09iUztxdn5ZTNrxPd0KYxIqMD0po6YcoC5IMSiZGduiMA8T8E2cWH3xH
         endqfwJ7clFJVmmeAca75o9whMufeY/FgpaswFHamUKg6sNH6u2nbMvObXZMbbezI87f
         o9Z8wLbkXxqFlqhyQ0Oj1ZT11k8xdKaAmhv2oVOm2mOc2DeKjzshAyO3XI7/436lEIe5
         NgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gXQ0ZKU9rPACm1NpC5IpEEgnJ67XgjPS3brhHlbPLjM=;
        b=K7FVSdBi0dOjXe3o+2CUGoGnvQIZvVejhTqngRdaRAWlSYaLuBITafD5IbiOe3f84E
         2/+Zo0OzpxZT0+8Y0TYiiSYkfBgThwHFU6P9i0k8x3nBQY7ZbKmh1/t8H+k6tXEXIbiC
         xh2s5icnSFGb7lQPznQrCVZ/LLlZpA3aWEjXItXBmLQgn7JBx6GvqRAdOi3iSQj8Ppbb
         s/iL0Itrs/bDU1brz0WYlYe/V0VO8keMfPPiVfVk9Ql32t0sKzt3sFTHAmhyD1pfmFI7
         MryHWvskvKKIpGxLlSyp5S+LlujoYgRVEOv7sW0cW3ycsr7/PMV1oBjTMKSyVZQZh5Iv
         d6Cg==
X-Gm-Message-State: AGi0PuYtmHsFPFw0J3rifjnH+5lguwzHYd3KQcnin/WVtg9rjcQZAjAZ
        2WVx2ieYqdW5Rj/6cBhcDJUEGA==
X-Google-Smtp-Source: APiQypLVZE7gp3NghRmYgGoZzrOFnRuX6zY8nsorx9deNubq9GtAB4XwaMmp1KjuurtkClIknMsMjQ==
X-Received: by 2002:a62:5209:: with SMTP id g9mr18641149pfb.220.1587517025116;
        Tue, 21 Apr 2020 17:57:05 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id x23sm3330352pgf.32.2020.04.21.17.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 17:57:04 -0700 (PDT)
Date:   Tue, 21 Apr 2020 17:56:58 -0700
From:   Benson Leung <bleung@google.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH] platform/chrome: typec: Fix ret value check error
Message-ID: <20200422005658.GA208993@google.com>
References: <20200422004151.116323-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <20200422004151.116323-1-pmalani@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Prashant,

On Tue, Apr 21, 2020 at 05:41:51PM -0700, Prashant Malani wrote:
> cros_typec_add_partner() returns 0 on success, so check for "ret"
> instead of "!ret" as an error.
>=20
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> Fixes: 9d33ea331032 ("platform/chrome: cros_ec_typec: Register port partn=
er")

Thanks. Applied for 5.8.

origin/for-kernelci updated.

Thanks,
Benson

> ---
>  drivers/platform/chrome/cros_ec_typec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/c=
hrome/cros_ec_typec.c
> index eda57db26f8d..66b8d21092af 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -263,7 +263,7 @@ static void cros_typec_set_port_params_v1(struct cros=
_typec_data *typec,
> =20
>  		pd_en =3D resp->enabled & PD_CTRL_RESP_ENABLED_PD_CAPABLE;
>  		ret =3D cros_typec_add_partner(typec, port_num, pd_en);
> -		if (!ret)
> +		if (ret)
>  			dev_warn(typec->dev,
>  				 "Failed to register partner on port: %d\n",
>  				 port_num);
> --=20
> 2.26.1.301.g55bc3eb7cb9-goog
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXp+WWgAKCRBzbaomhzOw
whqjAP9vj3ehlrgYTfe7GbbIZvZJPN5fPnDJFqIiF6HgovzcPQD6As22716OzrWi
bIJXqW53SM3cskd9BB2jF1cO//7LaAM=
=ptXK
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
