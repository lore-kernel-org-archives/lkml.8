Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D81BC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13EC72073A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Q59R7YOT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgEGO7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:59:13 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:58021 "EHLO
        fanzine.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgEGO7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:59:12 -0400
X-Greylist: delayed 1466 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 May 2020 10:59:10 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; s=20170329;
        h=MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID; bh=naj0keJ9OA5+ZkME3r47DK1IAppAUaF9jwiVH91fafY=;
        b=Q59R7YOTpic9UXJ4FFqiIfOba9Cf2rZtyzNjuiCEs6cI6bpWijPi2XcIBA43e12s/u3tXII1N9IBxfxJUpQgAU+LbcJOn7y1T+YEnowuWqJIxpelV6bBu/5PPMw6JymwAkCXoQrWu4cQF5jgsVwfsGsM5hRlItql6kM4wF53LwJ/XFavVuoUq6FXRscPWmgGCX0C1CckiYLvU9TBf0FSy2FncbYg3GfWyiNLHaiOU9g56ofyo1G9NPgQECv1faRVCKJoXEcAVR322mEaYZF9++/NPmFGLpcwKrbN5AqGSL8qWc8Z6udrc3hyneNpdV262VqSbdd4TKCJsK1UYtCjFg==;
Received: from 53.red-88-15-141.dynamicip.rima-tde.net ([88.15.141.53] helo=maxwell)
        by fanzine.igalia.com with esmtpsa 
        (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
        id 1jWhbM-0008Mj-Or; Thu, 07 May 2020 16:34:16 +0200
Message-ID: <eaaa54dbe413bf3f13f08c267e6c31c497afb509.camel@igalia.com>
Subject: Re: [PATCH -next] ipack: tpci200: fix error return code in
 tpci200_register()
From:   Samuel Iglesias =?ISO-8859-1?Q?Gons=E1lvez?= 
        <siglesias@igalia.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     industrypack-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Date:   Thu, 07 May 2020 16:34:06 +0200
In-Reply-To: <20200507094237.13599-1-weiyongjun1@huawei.com>
References: <20200507094237.13599-1-weiyongjun1@huawei.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-6OhG+JRPe3bIgyHL09ni"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6OhG+JRPe3bIgyHL09ni
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Wei,

Thanks for the patch!

Patch is,

Acked-by: Samuel Iglesias Gonsalvez <siglesias@igalia.com>

Greg, Would you mind picking this patch series through your char-misc
tree?

Thanks!

Sam

On Thu, 2020-05-07 at 09:42 +0000, Wei Yongjun wrote:
> Fix to return negative error code -ENOMEM from the ioremap() error
> handling
> case instead of 0, as done elsewhere in this function.
>=20
> Fixes: 43986798fd50 ("ipack: add error handling for ioremap_nocache")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/ipack/carriers/tpci200.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/ipack/carriers/tpci200.c
> b/drivers/ipack/carriers/tpci200.c
> index 8a9c169..b5eec18 100644
> --- a/drivers/ipack/carriers/tpci200.c
> +++ b/drivers/ipack/carriers/tpci200.c
> @@ -309,6 +309,7 @@ static int tpci200_register(struct tpci200_board
> *tpci200)
>  			"(bn 0x%X, sn 0x%X) failed to map driver user
> space!",
>  			tpci200->info->pdev->bus->number,
>  			tpci200->info->pdev->devfn);
> +		res =3D -ENOMEM;
>  		goto out_release_mem8_space;
>  	}
>=20
>=20
>=20
>=20

--=-6OhG+JRPe3bIgyHL09ni
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEQP+ZAvaXWkfuKXiEf/S6MvF9w0MFAl60HF4ACgkQf/S6MvF9
w0NaghAAysFj+kKNNuNU7yebV5ggXMJd2UwHJkYMm3U9YUGYnzW/GFy9MA2UuQjZ
yUqjneHFo3yA5F9Ef+ZCFGXHxuEQbGTeW0v2mFrDb5JlyMWKHDqBkCDu1h1Y6TJ8
ty4whqUPQpgPOB6DurAur8todoKlxwAXyTpLcX63LF4zXGoojKLczsuVXoFJXVIJ
6s1JlITIaLNDf0kFX6ql5HTsL6Lg+WRl6wmls37YlPzq04C2EA9gPeN5xCTw6hlp
7t4qTLnY8sh7ZvEA2TsAPkHBICfW3uN2CsuMs9h4fDlD5qijrGElw6NntzctxjZf
EfCvVlpMY9Ac2FHTpfYb6ipUI+bqOd0winx1pE0ilnoc/K8lPYaTSpy43fhlUi8X
EPIlcWEvEwtDm2UDnoassPJzUDuKUHpYkfCvbsZPd576AagoF/F1XvcnIIAiwLkC
dxr04EsVpIaCdvdXRHM4zFfff2g9OEgEGQ4yrGcW6iYD9xrWmv2XsEBuBcwM1EEc
uxpovOBUUbyYHsqvB1wJ7Le3v0sfnqRw1xDpxNNOl52RaGL/2ElL7NZFOmryRYbi
LV8YxTfTstEZS7s7LFwsAAQXzUjqSkSuaQFCYWveCk1+PvoRu0coKq/NB0W5O1TG
dT6dacdPb19LFVL/KayLG+14LRlmKW/6PcbL1HKbNWyr5ok6QBs=
=0aD1
-----END PGP SIGNATURE-----

--=-6OhG+JRPe3bIgyHL09ni--

