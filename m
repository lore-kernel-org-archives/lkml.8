Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B1FC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 22:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 877FB20672
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 22:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoEmDd5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgGLWLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 18:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbgGLWLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 18:11:43 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4C7C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 15:11:43 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id r22so10488217qke.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 15:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6GIa+L4BMOnigUNxnfxqvTRE/iHNXj+4A+Wyg9Hp5YY=;
        b=GoEmDd5o3b7KKq9FLx3p1mEyzfk18JtXgmbxh1wBT+AuBSsIPdJCIQhdEq+xkQOwtb
         +nJOQNF2aBcaPNp6HiFzy6Uv7PmCrXRu2fGbM9p8ZW7KJoSIovm5fqYat6OA8DXJ0Xj7
         YHsrweiGWpA7B/+Sf8sp6jyR+Wq/+kIA/Lv0wI2zKoEngjzw/1D7MMoGLHM19K8/xaMX
         i41XlNTMfLcGTCNkHfvRbH+pM7zIusMBiAyLr8L46g1raBbK2v6b25u+3S/d8IBNmOp8
         oxsPsWEVaWLP8V4p85xBUTkCv5anvAuQy3snh4I91yE37E42tssXhpqgI1LJJKdLZqJ6
         vceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6GIa+L4BMOnigUNxnfxqvTRE/iHNXj+4A+Wyg9Hp5YY=;
        b=K2UJdWD3gBjyaU/Ir5YZDA2/AYp1kS9Fo0Uz7/PqT4MoP/42C0TFrZGPTt/+GVruuP
         ewZF433opY9czKApw64dTZjeqzMpnhKBohruzkVLhuJZU0CJdaNmavUTf5O4GmvpQVqc
         ll2Fd7mix3if19Rz6jg7AbBk1pfqi8HMyiIF0N64IqGSZmEBEu6jNGzVbpmWylcNqIfm
         eRik15OlEwqvGQDj2UB5EZV3iJ6tY6t0hGMTTE/83pM1ofLY+zhBhnGGl0p9lH3/GBoe
         xI0Av/ZtCky8hJpZxP6ole1P3WdCxCdtjvWmGRdMu8lfD0vp/dcmTQFR7NUM0fV54cyD
         S8Xw==
X-Gm-Message-State: AOAM531rg36DWtxPZm4Vh1JYeLQG7H2uISof1/GQ15SSOYStXtUmH289
        VbIzbhKI3GsfTxZYwWeXalw=
X-Google-Smtp-Source: ABdhPJzQaaKRGivrc3/T8gulu3MyNqVAw7FrC2GLeaTrxt1shNYOgKH4DEdhaHFhrnaOBmww4rEHow==
X-Received: by 2002:a37:bcb:: with SMTP id 194mr80843531qkl.103.1594591902504;
        Sun, 12 Jul 2020 15:11:42 -0700 (PDT)
Received: from smtp.gmail.com ([2607:fea8:56a0:8440::b10e])
        by smtp.gmail.com with ESMTPSA id z4sm16309498qkb.66.2020.07.12.15.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 15:11:41 -0700 (PDT)
Date:   Sun, 12 Jul 2020 18:11:40 -0400
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Melissa Wen <melissa.srw@gmail.com>
Cc:     Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com, twoerner@gmail.com
Subject: Re: [PATCH] drm/vkms: change the max cursor width/height
Message-ID: <20200712221140.7vzjh4nwtszpffa2@smtp.gmail.com>
References: <20200710160313.xjoz6ereyma5vkc3@smtp.gmail.com>
 <20200712220544.3zmyohuf7cj4y27y@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3p6wpas7gy73fiat"
Content-Disposition: inline
In-Reply-To: <20200712220544.3zmyohuf7cj4y27y@smtp.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3p6wpas7gy73fiat
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Applied to drm-misc-next.

Thanks

On 07/12, Rodrigo Siqueira wrote:
> Hi Melissa,
>=20
> First of all, thanks a lot for your patch! This is a nice change since
> it increases the code coverage.
>=20
> Reviewed-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
>=20
> On 07/10, Melissa Wen wrote:
> > This change expands the coverage for the IGT kms_cursor_crc test, where
> > the size varies between 64 and 512 for a square cursor. With this, in
> > addition to the cursor 64x64, this patch enables the test of cursors wi=
th
> > sizes: 128x128, 256x256, and 512x512.
> >=20
> > Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
> > ---
> >  drivers/gpu/drm/vkms/vkms_drv.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkm=
s_drv.c
> > index 1e8b2169d834..57a8a397d5e8 100644
> > --- a/drivers/gpu/drm/vkms/vkms_drv.c
> > +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> > @@ -133,6 +133,8 @@ static int vkms_modeset_init(struct vkms_device *vk=
msdev)
> >  	dev->mode_config.min_height =3D YRES_MIN;
> >  	dev->mode_config.max_width =3D XRES_MAX;
> >  	dev->mode_config.max_height =3D YRES_MAX;
> > +	dev->mode_config.cursor_width =3D 512;
> > +	dev->mode_config.cursor_height =3D 512;
> >  	dev->mode_config.preferred_depth =3D 24;
> >  	dev->mode_config.helper_private =3D &vkms_mode_config_helpers;
> > =20
> > --=20
> > 2.27.0
> >=20
>=20
> --=20
> Rodrigo Siqueira
> https://siqueira.tech



--=20
Rodrigo Siqueira
https://siqueira.tech

--3p6wpas7gy73fiat
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl8LipsACgkQWJzP/com
vP/WiA//Svh6voj1NWikmjHgoMHl5xOM2QcqXLBhpDs8XufEaKX1ZxXqiDIE10d7
43Tted37/PEygaVkJglz8EDxteoV2eupe5y73fLAt0Lbg37HswCw65fTnEJFpooq
wiauUTQPOH3JxJbxb2KaIDw2rHLUWiX7SY+ZFg7jSHUZhuatHq9V7SJahttl7JE/
vM/uj73pLVs54fQpjj+i+VkKg52Cbe0hji2igXzgnnJEDynqO/2wGn5WY+lWERb6
Rwk3V+W/fS+Y/7G9KSpSzcpGDeXMzZN4fEUpDTozpIcI3QiGM1of2Vgck8hmLQ2m
COEIYUMRkdJYiUWmq0TFic1QL1DGu7OiQzsGcTYE6qXJVKNnr7nKkb3Ydz56U6Ji
8k3DQhirnE4zozrsX4e4Q4TWOG2V+wDB69c6vwLwE8s5GEH56h5bHka2mKZjV2CN
jWafM7IXVd6JuxXewzNfvackxq95Jq0gRXxCQx/sF8paLkfRf8Z+mgVoICbSBxJp
Jh0nkaoZgPv+uaIQf7aDqbtq51opYaa8JG+wQbHVuAXeb5fYp73Lks3EFpAwA+kz
b+z7rFSl8IBbZl718/xwzKTgpxEyIgPILjQqx/nVCvHi1yPcXwCxqhxjBoSId7vP
39x1a5OSoeKz3lj0piZwMAoMCB4rzV0vP9EDemfe53rR1OXTsNw=
=tCmt
-----END PGP SIGNATURE-----

--3p6wpas7gy73fiat--
