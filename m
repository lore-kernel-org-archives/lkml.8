Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D12C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 15:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5254D2078E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 15:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbgIIPuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 11:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730533AbgIIPrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:47:42 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4EEC061375
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 07:18:45 -0700 (PDT)
Received: from kevin (unknown [IPv6:2607:fea8:55f:a950::68f4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alyssa)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C3EE929AF39;
        Wed,  9 Sep 2020 15:13:33 +0100 (BST)
Date:   Wed, 9 Sep 2020 10:13:28 -0400
From:   Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Marty E. Plummer" <hanetzer@startmail.com>,
        Eric Anholt <eric@anholt.net>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH] drm/panfrost: Ensure GPU quirks are always initialised
Message-ID: <20200909141328.GA1853@kevin>
References: <20200909122957.51667-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <20200909122957.51667-1-steven.price@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>

> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/pa=
nfrost/panfrost_gpu.c
> index e0f190e43813..6d17d3cbd1df 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> @@ -305,6 +305,8 @@ void panfrost_gpu_power_on(struct panfrost_device *pf=
dev)
>  	int ret;
>  	u32 val;
> =20
> +	panfrost_gpu_init_quirks(pfdev);
> +
>  	/* Just turn on everything for now */
>  	gpu_write(pfdev, L2_PWRON_LO, pfdev->features.l2_present);
>  	ret =3D readl_relaxed_poll_timeout(pfdev->iomem + L2_READY_LO,
> @@ -356,7 +358,6 @@ int panfrost_gpu_init(struct panfrost_device *pfdev)
>  		return err;
>  	}
> =20
> -	panfrost_gpu_init_quirks(pfdev);
>  	panfrost_gpu_power_on(pfdev);
> =20
>  	return 0;
> --=20
> 2.20.1
>=20

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ17gm7CvANAdqvY4/v5QWgr1WA0FAl9Y4wIACgkQ/v5QWgr1
WA1OOQ//bzBrqIhh/+djm4twwCWb3xS/NeuDiMnFzp4N0y8zm9yu9XY7IaQ5lZwB
pcpSLKMBrHjg2yKcmYwssGdAZROMn9+veiCmk9LC/DsZOo5RMpGXskM76l9xwDDW
u/gng9rp0917VhpE2G+1gb4oRxBWmEgyHIM6Loe5PI+QG2796mB/LcCabKzU2jSr
E6NRQcKu6CwATbQpN4uA8BLdS8RYFsCbDVkZTNEr7GcufF6iQZI7QhYil4EHHzYH
pm1X3nfpWM53iZ87Qr01gQEhYQdJD+sssdgaSaiUiWthkKmC+/CW3WFKi2g7IP7X
feaawkjOjJO6/5JpKSrJaa78JFR2g/rnRwHHFUtltp8k7cvh5KFY7tFFVbmv24Ga
xy9ZCro2MCUrjbwEX1QO0IY3oVrTn5iWuWGcGzklDHubZOi3Etsokr4eKKuAtzeY
AtHFfXYL/iAUUAVnC1tOdOU9IsFjubTnNxfJn8Lu4iExoeHBpSNjvlBb4byCjUzc
+z38V69Db60/SYn1ieK+odf4DgEdyiD5tNKqyYWmaYnnkQn0tj49Ilkw5MR2/W0C
rLov5bUObCEs0mGEsOKrnEmBaLWI3PvAc/gRO01YiRkQQSQkZpQAiTX2sHNZJMx4
B+7ATfTeersP+ELtmrRRYgOqs233S8p7FnpAgvctyFlywPlIcvU=
=xiuj
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
