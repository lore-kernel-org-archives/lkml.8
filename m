Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A587FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 03:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6805A20706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 03:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBdDG+jr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgHYDPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 23:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbgHYDPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 23:15:09 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA3EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 20:15:08 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id c12so8052769qtn.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 20:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SvW0vlaUXlhWFbm4GXWlUoLrbQbUVmWGmeetFSuThhE=;
        b=lBdDG+jr+clUeV0eZJNh0HDFKzUBl3kRTE4wstKazWuV5tSm0WZL5CH4NcESSYmzwC
         sP4WG8N++5UqDSc3i3VIMNJ0jvo8sUZYtbg6/s2Hh/U63UpgMYGr2OgHf5cwuWZvOr76
         tmOZwzIAeSNJVqYyxCy0FQ1+N/2UUUOWWnInumaZmoOyep+CVW6y5F0dUJ+0+amyzmSh
         s+PTEw1UPrFB36N8Kx/VnENvAlsIhownfXWtitpvHR2u91jdmB+afg4z4yi1l7dceg4g
         X9ZWX+J6qgvDHUDyoWq/TUyWcZyD/OfUDexLvjw804QiXxRYV2LJyzlUVkp53xobKQCb
         VUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SvW0vlaUXlhWFbm4GXWlUoLrbQbUVmWGmeetFSuThhE=;
        b=bkn7OWblJfrS1F7KQUZ02ApsErR3o7Tx5JDzgwe5/VkrusSn7ju252WLaEnL3BuKiq
         /vBdOmwBN9hZvpMEaa+Gh+AXo4uVdYNTNZTCTQtiVT6zo6rkpvKfBz3UTBXm28lsvfSF
         4+NjGs1fLLfL0puxcQT5xN/2sR6FYFZd2nNhe8keXzXB6IBXpAQh7A7mCMeWD1NKKn/w
         +lKgcicJrRyCHob5WVj+dD1bIx+qNW5xHurfGVhBmJDwwt4hjHH9sVc1wogkobRgHK8H
         3iYXo/oxyhJxNBsT5bvq3nclXyxtsbsWcGT2n7r88cFyFIyWEcEm1eHFHJxLQgqu6H2/
         bozg==
X-Gm-Message-State: AOAM533Ao+VEyNZv2QafrkmXvLHEgkEkuxlelzoGu87XdqNzvAMjv2BZ
        hn6uHIEpyTzwrZKtCoWtOkI=
X-Google-Smtp-Source: ABdhPJxNJ48MdYSl7r2xKefnshL60K4Lxd4UGz3J+2l5UciwcxMPHBZ0Y1xQjLCZd+sM07lOCMSRhA==
X-Received: by 2002:aed:3ead:: with SMTP id n42mr7978240qtf.5.1598325307956;
        Mon, 24 Aug 2020 20:15:07 -0700 (PDT)
Received: from smtp.gmail.com ([2607:fea8:56e0:6d60::2db6])
        by smtp.gmail.com with ESMTPSA id d26sm13283713qtc.51.2020.08.24.20.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 20:15:07 -0700 (PDT)
Date:   Mon, 24 Aug 2020 23:15:01 -0400
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH] drm/vkms: Use alpha value to blend values.
Message-ID: <20200825031501.y3knhdwph5a6knld@smtp.gmail.com>
References: <20200818160215.19550-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hw63tmig6dcz7gis"
Content-Disposition: inline
In-Reply-To: <20200818160215.19550-1-realwakka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hw63tmig6dcz7gis
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sidong,

Thanks a lot for your patch and effort to improve VKMS.

On 08/18, Sidong Yang wrote:
> I wrote this patch for TODO list in vkms documentation.
>=20
> Use alpha value to blend source value and destination value Instead of
> just overwrite with source value.
>=20
> Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
>=20
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
>  drivers/gpu/drm/vkms/vkms_composer.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/=
vkms_composer.c
> index 4f3b07a32b60..e3230e2a99af 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -77,6 +77,9 @@ static void blend(void *vaddr_dst, void *vaddr_src,
> =20
>  	for (i =3D y_src, i_dst =3D y_dst; i < y_limit; ++i) {
>  		for (j =3D x_src, j_dst =3D x_dst; j < x_limit; ++j) {
> +			u8 *src, *dst;
> +			u32 alpha, inv_alpha;
> +
>  			offset_dst =3D dest_composer->offset
>  				     + (i_dst * dest_composer->pitch)
>  				     + (j_dst++ * dest_composer->cpp);
> @@ -84,8 +87,15 @@ static void blend(void *vaddr_dst, void *vaddr_src,
>  				     + (i * src_composer->pitch)
>  				     + (j * src_composer->cpp);
> =20
> -			memcpy(vaddr_dst + offset_dst,
> -			       vaddr_src + offset_src, sizeof(u32));
> +			src =3D vaddr_src + offset_src;
> +			dst =3D vaddr_dst + offset_dst;
> +			alpha =3D src[3] + 1;
> +			inv_alpha =3D 256 - src[3];
> +			dst[0] =3D (alpha * src[0] + inv_alpha * dst[0]) >> 8;
> +			dst[1] =3D (alpha * src[1] + inv_alpha * dst[1]) >> 8;
> +			dst[2] =3D (alpha * src[2] + inv_alpha * dst[2]) >> 8;

Did you test your change with IGT? Maybe I missed something but looks
like that you're applying the alpha value but the value that we get is
already pre-multiplied.

Btw, It looks like that you and Melissa are working in the same feature,
maybe you two could try to sync for avoiding overlapping.

Finally, do you have plans to send your fix for
vkms_get_vblank_timestamp() function? That patch was really good and
removes a lot of warning generated during the IGT test.

Best Regards

> +			dst[3] =3D 0xff;
> +
>  		}
>  		i_dst++;
>  	}
> --=20
> 2.17.1
>=20

--=20
Rodrigo Siqueira
https://siqueira.tech

--hw63tmig6dcz7gis
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl9EgjAACgkQWJzP/com
vP+QwRAAn9k/9RskirKfJGva/5Qzhykbkj2nANsnwZo+hY6t2TNNuj4jx/INI0XA
l8eswurDyaB8yN/IUKs8HQ4LZEnrz4bKnYP8vpsJBxjPu6r+hTJ1vCEchISwaPHO
gQENSqrjAjgwkfVwHBJ4ltt3mwuvxJ01xgR+pztsIQ+H7U15TnZVhv7wVmt3jbhx
Rdgy9DM6mT5XVDcOJpriHlMQVCdfumRgbnQZxCSvyp++Bkb/HnvvV0YZnWpA1e0z
azxOW5jDeiQkg3VTJMO7tgnbXF6nX/Gucfuc1eN9yuiYJrWEyzjEjYGucbCvsbRV
U0l3XF3/lFGFLQOKe6MV+/TXVQ6rVmSAkNtSRdum8qHh8ukzHbIqdSFhdU6ThNlm
rexe62XyN1+f09f+kb/7FLxt5ov/7zdEjd2Vx9HQ8PLGhnWXJTxEvEaw12YQk5HB
Z5yvsD0V8nbUFCuCShvgDdQqSAAURMmoBxo0T8WYPnKIgfN100vL4WFu5Ru+MCFt
bbLzX+z+CyHg0oND2jg2umTDf0F6Cr2tOlxCTb7N+oqo15rsC1wpB9HqySai/oi5
3sADXinocJuSnwO08TvSpDtsQzLMvSm19V4hx33UCcheBH3Fk9nbtFmc70q/EY7f
avYZXPn+CZKPFpGv7dgqsoYe5f2sTmKQUdzC/DsQb26OHQ7zilQ=
=qLnU
-----END PGP SIGNATURE-----

--hw63tmig6dcz7gis--
