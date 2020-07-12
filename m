Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98C7C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 22:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E58E20720
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 22:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tAHHLtnq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbgGLWFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 18:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729020AbgGLWFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 18:05:48 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3E4C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 15:05:48 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id a14so4991110qvq.6
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 15:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jcB+huYj0l0LbQtJUOWS2otYcMgoEC0yYEjN+YAq8sY=;
        b=tAHHLtnqQX5ndIdJi7+GtljunjEdgt3lSN+jOb4LDTJWEffOrfv4M76QeHh0P1Jb3F
         d5kBAPlMe2TPtGcM99r3aXbQPIpTc6Kl6HThztFh2AiEdln92CTaG8eu07nQgSztszwl
         ylbQtCzzlo8S2n2uDj9Q4Z4wokRWWNO6XmUKE7CAKwS/28cVHjoKfJ1manUoBP9NJT9d
         L6/o/ZzXAb/aRcsdfoW9IC5Ma2SYSzLMba7Fmp93cNQXtp8K01Q1aFQ0h5EfsXhLGB/5
         bOm4ru1V8boWXvgHiKuAJ9CnGzZ46MiLRVYwaXg+RXXXn5k/YIXnpZeUQWFdJYljhOPR
         BsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jcB+huYj0l0LbQtJUOWS2otYcMgoEC0yYEjN+YAq8sY=;
        b=ptUOHyEF4LjFyYt/BXmsbcaIIu4o85StIDWpo3T3R037UGRZVYyVdoL6GIfK0o32MV
         UlGCnQSssG9ZEy3NHbLmptuWubqYLVD2KFffquHVYRfVPml/Y17Ih0jolPBGAilAtlL/
         YrRagjxJiqz/YYGFlCom2ItOYa9vss8mhtCIbmm+99RMD2AQCh0HagS2FEj8630UK3QX
         UKoRPVzrmtD26qvaFwTSCszFJwF3P04JNL9izSRFYWSBKrtiDVKt0nMfjKjaBNn6P0uz
         yp+IJS9whZsBZvC8SPUFHNvs0BYXBDv7WyyOU8K9epw2QlmfbKpbf04vE2TqnHN/GB8R
         PqKQ==
X-Gm-Message-State: AOAM532f1IsYAe+TELmBdzrzarAuwUlnkwtQFsIwZSEXoIR7xXKFXHJm
        YJ6hyA3cO9JUwqN/tftC8H0=
X-Google-Smtp-Source: ABdhPJxZboeLYvPQHsIcuJNgOvm11GuHFXfkASS3WF2CvtMIVKQDiD+gcdLk2sbid06pIK9ieYcbqQ==
X-Received: by 2002:a05:6214:969:: with SMTP id do9mr77959625qvb.85.1594591547909;
        Sun, 12 Jul 2020 15:05:47 -0700 (PDT)
Received: from smtp.gmail.com ([2607:fea8:56a0:8440::b10e])
        by smtp.gmail.com with ESMTPSA id b53sm17136505qtc.65.2020.07.12.15.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 15:05:46 -0700 (PDT)
Date:   Sun, 12 Jul 2020 18:05:44 -0400
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Melissa Wen <melissa.srw@gmail.com>
Cc:     Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com, twoerner@gmail.com
Subject: Re: [PATCH] drm/vkms: change the max cursor width/height
Message-ID: <20200712220544.3zmyohuf7cj4y27y@smtp.gmail.com>
References: <20200710160313.xjoz6ereyma5vkc3@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4i736vmv6djksaji"
Content-Disposition: inline
In-Reply-To: <20200710160313.xjoz6ereyma5vkc3@smtp.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4i736vmv6djksaji
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Melissa,

First of all, thanks a lot for your patch! This is a nice change since
it increases the code coverage.

Reviewed-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>

On 07/10, Melissa Wen wrote:
> This change expands the coverage for the IGT kms_cursor_crc test, where
> the size varies between 64 and 512 for a square cursor. With this, in
> addition to the cursor 64x64, this patch enables the test of cursors with
> sizes: 128x128, 256x256, and 512x512.
>=20
> Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
> ---
>  drivers/gpu/drm/vkms/vkms_drv.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_=
drv.c
> index 1e8b2169d834..57a8a397d5e8 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -133,6 +133,8 @@ static int vkms_modeset_init(struct vkms_device *vkms=
dev)
>  	dev->mode_config.min_height =3D YRES_MIN;
>  	dev->mode_config.max_width =3D XRES_MAX;
>  	dev->mode_config.max_height =3D YRES_MAX;
> +	dev->mode_config.cursor_width =3D 512;
> +	dev->mode_config.cursor_height =3D 512;
>  	dev->mode_config.preferred_depth =3D 24;
>  	dev->mode_config.helper_private =3D &vkms_mode_config_helpers;
> =20
> --=20
> 2.27.0
>=20

--=20
Rodrigo Siqueira
https://siqueira.tech

--4i736vmv6djksaji
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl8LiTMACgkQWJzP/com
vP+a4hAAhzqDRriWgEIVgNEePc5SENkHgaesIXCA/hVw4/JfnPSvX4HJZimZwh+g
pGc+V5kX4iQBN9sryivDJvAc5nMoSgUENo+Ql4DYzUb078spWnZJOG3A5fQ73SAc
tYbkxnxJawOub4Cx9gbJBrkRoby3o2xoi+v6KQNC2nR5DWUB0esnIiWKpyA+en5g
IcokeXwVzwoDzfIdmYYtNA+Se4V1rbMfs/1z3GzQGZvP3NjKgt37y3r5uJanaZHH
UZ11weGaODBAnMvYkUc1Si/Z2uMJPCDfCEWds0JAVxIWu0g5HEt/YugttjCOWQfr
4nybiERjJb90aDaCc3Qd2OwV3AJcx1+B5lgnwyRNKddVdEt4ddnesr2Y8U9WoSX6
3eh8xmGG1tPw7AmC/8hlT3OpydH+rqXgM1x7SCLLywUL1khw3g8T3FoAb3O3MQcr
O/ajRY1ruba7qXHrSXXdoZBWaOJkdH//LKSpjU/OYza9viYh1VB5ZtB/5+3oytzT
P0mbC92HJ7mD61qZ0Z50hsIf6CfYi0NKX9ufDZ/0aR8ERTgUb+J36mHzwqrrSPB9
qp1rEIicbV3B6gz8B5ePwThtdSeLY5tdnF/8zMMPoqf8v0HU2693GtOoGc2KiyAj
UO6flDn3BEmYBMP0uFG9YE6S4GhukiIzZBLuAAb4AqzPYFKnti8=
=RSwA
-----END PGP SIGNATURE-----

--4i736vmv6djksaji--
