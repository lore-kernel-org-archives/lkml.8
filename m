Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52547C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 13:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B0E7206FA
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 13:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2g57aw5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgH3NQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 09:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbgH3NQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 09:16:19 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969FCC061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 06:16:15 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id o12so3841027qki.13
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 06:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R+xrprhnSqcxoI/jTYsOtmdDih6WbDe5B/EhNR1YTcw=;
        b=m2g57aw5V5KZ/1sRXktYzDuPyokfSSd1mOn6wjNlHxbXwSjdXvGIbN1Hl/z3GIfn1P
         98TKjKnpDuZwlBeGNveb+wR0k/X1+QEsmWSGlZglEaRdXspSbbPe5sgHQJHPDEHTNgkI
         4brML/tStrfBU8C0T6WaD4q1trhVrOSKUrFXAxN0FfVXlWlA0S+F+Oh3iAbg78tX3W+X
         HoXInnaFwHtdG10YaaBe/WExE+m8VDbEC7gPCvdryXfNvA2WEkrZf3BjHLKOWwIzcwG2
         622xIEq3QFEyD0ZaYIjfPgDZ35YEgR5255yX4yeH0oMhuiIVsrmHVJOhDZiqnTX6Kh5b
         ChvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R+xrprhnSqcxoI/jTYsOtmdDih6WbDe5B/EhNR1YTcw=;
        b=aT4fx3Uws3XraR3BMGVkk7MIo0+Ofa793y7DJxf0JmLYJ/+n10yLwwCiaAUroUK29M
         akElMZ8scV/PrvCptxndyGpquEpaWqhZMQfyRrpmFlli015NSEUpxu1NNt6Yiztee7d1
         m8ksQ5uckS8HtKJioErLiKM37uz/je6dWdoCt7hBai2an4ZGS5EyNW+vXNdS9Acb0XIp
         EObSgWY9hhMeyQuQOJqFCCpSSrNj6ExdODfzsJL3tFjYQXrwAgTa0e5Kck/dZn9YesVA
         azDA2nVAkuDoLRW9JRFs4eiaBYUocY5tKtqJKT9/OjReem4rxuFkf1gyMr3jtkXBSKEn
         5TwA==
X-Gm-Message-State: AOAM530hTF+D4bkQMix71/mWz2iAxsjLQAVOWKCiNFfEQ6elPg/+zMP4
        LVogbh1yVGKGDgGPc5S2lPs=
X-Google-Smtp-Source: ABdhPJzxq6wdo72tOuuhZFg7y8HmoeH0aRohP4iH+EIX2gwl/BB5tVeMHNzqxAHbtAz8wlKSLveb2g==
X-Received: by 2002:a37:409:: with SMTP id 9mr6667382qke.374.1598793374788;
        Sun, 30 Aug 2020 06:16:14 -0700 (PDT)
Received: from smtp.gmail.com ([2607:fea8:56e0:6d60::2db6])
        by smtp.gmail.com with ESMTPSA id a203sm5871749qkg.30.2020.08.30.06.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 06:16:13 -0700 (PDT)
Date:   Sun, 30 Aug 2020 09:16:05 -0400
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Melissa Wen <melissa.srw@gmail.com>
Cc:     Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        twoerner@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v2] drm/vkms: add alpha-premultiplied color blending
Message-ID: <20200830131605.bkleteqg4anaadk3@smtp.gmail.com>
References: <20200825114532.abzdooluny2ekzvm@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="73x4qapiqn2sxoen"
Content-Disposition: inline
In-Reply-To: <20200825114532.abzdooluny2ekzvm@smtp.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--73x4qapiqn2sxoen
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>

On 08/25, Melissa Wen wrote:
> The VKMS blend function was ignoring the alpha channel and just
> overwriting vaddr_src with vaddr_dst. This XRGB approach triggers a
> warning when running the kms_cursor_crc/cursor-alpha-transparent test
> case. In IGT, cairo_format_argb32 uses premultiplied alpha (according to
> documentation). Also current DRM assumption is that alpha is
> premultiplied. Therefore, this patch considers premultiplied alpha
> blending eq to compose vaddr_src with vaddr_dst.
>=20
> This change removes the following cursor-alpha-transparent warning:
> "Suspicious CRC: All values are 0."
>=20
> --
>=20
> v2:
> - static for local functions
> - const for the read-only variable argb_src
> - replaces variable names
> - drops unnecessary comment
>=20
> --
>=20
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
>=20
> Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
> ---
>  drivers/gpu/drm/vkms/vkms_composer.c | 55 ++++++++++++++++++++--------
>  1 file changed, 39 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/=
vkms_composer.c
> index 4f3b07a32b60..eaecc5a6c5db 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -32,8 +32,6 @@ static uint32_t compute_crc(void *vaddr_out, struct vkm=
s_composer *composer)
>  			src_offset =3D composer->offset
>  				     + (i * composer->pitch)
>  				     + (j * composer->cpp);
> -			/* XRGB format ignores Alpha channel */
> -			bitmap_clear(vaddr_out + src_offset, 24, 8);
>  			crc =3D crc32_le(crc, vaddr_out + src_offset,
>  				       sizeof(u32));
>  		}
> @@ -42,27 +40,51 @@ static uint32_t compute_crc(void *vaddr_out, struct v=
kms_composer *composer)
>  	return crc;
>  }
> =20
> +static u8 blend_channel(u8 src, u8 dst, u8 alpha)
> +{
> +	u32 pre_blend;
> +	u8 new_color;
> +
> +	pre_blend =3D (src * 255 + dst * (255 - alpha));
> +
> +	/* Faster div by 255 */
> +	new_color =3D ((pre_blend + ((pre_blend + 257) >> 8)) >> 8);
> +
> +	return new_color;
> +}
> +
> +static void alpha_blending(const u8 *argb_src, u8 *argb_dst)
> +{
> +	u8 alpha;
> +
> +	alpha =3D argb_src[3];
> +	argb_dst[0] =3D blend_channel(argb_src[0], argb_dst[0], alpha);
> +	argb_dst[1] =3D blend_channel(argb_src[1], argb_dst[1], alpha);
> +	argb_dst[2] =3D blend_channel(argb_src[2], argb_dst[2], alpha);
> +	/* Opaque primary */
> +	argb_dst[3] =3D 0xFF;
> +}
> +
>  /**
>   * blend - blend value at vaddr_src with value at vaddr_dst
>   * @vaddr_dst: destination address
>   * @vaddr_src: source address
> - * @dest_composer: destination framebuffer's metadata
> + * @dst_composer: destination framebuffer's metadata
>   * @src_composer: source framebuffer's metadata
>   *
> - * Blend value at vaddr_src with value at vaddr_dst.
> - * Currently, this function write value of vaddr_src on value
> - * at vaddr_dst using buffer's metadata to locate the new values
> - * from vaddr_src and their destination at vaddr_dst.
> - *
> - * TODO: Use the alpha value to blend vaddr_src with vaddr_dst
> - *	 instead of overwriting it.
> + * Blend the vaddr_src value with the vaddr_dst value using the pre-mult=
iplied
> + * alpha blending equation, since DRM currently assumes that the pixel c=
olor
> + * values have already been pre-multiplied with the alpha channel values=
=2E See
> + * more drm_plane_create_blend_mode_property(). This function uses buffe=
r's
> + * metadata to locate the new composite values at vaddr_dst.
>   */
>  static void blend(void *vaddr_dst, void *vaddr_src,
> -		  struct vkms_composer *dest_composer,
> +		  struct vkms_composer *dst_composer,
>  		  struct vkms_composer *src_composer)
>  {
>  	int i, j, j_dst, i_dst;
>  	int offset_src, offset_dst;
> +	u8 *pixel_dst, *pixel_src;
> =20
>  	int x_src =3D src_composer->src.x1 >> 16;
>  	int y_src =3D src_composer->src.y1 >> 16;
> @@ -77,15 +99,16 @@ static void blend(void *vaddr_dst, void *vaddr_src,
> =20
>  	for (i =3D y_src, i_dst =3D y_dst; i < y_limit; ++i) {
>  		for (j =3D x_src, j_dst =3D x_dst; j < x_limit; ++j) {
> -			offset_dst =3D dest_composer->offset
> -				     + (i_dst * dest_composer->pitch)
> -				     + (j_dst++ * dest_composer->cpp);
> +			offset_dst =3D dst_composer->offset
> +				     + (i_dst * dst_composer->pitch)
> +				     + (j_dst++ * dst_composer->cpp);
>  			offset_src =3D src_composer->offset
>  				     + (i * src_composer->pitch)
>  				     + (j * src_composer->cpp);
> =20
> -			memcpy(vaddr_dst + offset_dst,
> -			       vaddr_src + offset_src, sizeof(u32));
> +			pixel_src =3D (u8 *)(vaddr_src + offset_src);
> +			pixel_dst =3D (u8 *)(vaddr_dst + offset_dst);
> +			alpha_blending(pixel_src, pixel_dst);
>  		}
>  		i_dst++;
>  	}
> --=20
> 2.28.0
>=20

--=20
Rodrigo Siqueira
https://siqueira.tech

--73x4qapiqn2sxoen
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl9LpoAACgkQWJzP/com
vP+WfA//Z4CWATy5xMPEIanqu2+DYeYQfVcUE+6QSLeRw8vS8DM+RxuKQwNkR9uY
KDyfrF2dAAWth4Dv0CrohM3WMLmqAqLFxs0CnEMeXaNbjCs7DV5lNtyZQoC2w013
I6fZcte81pyGErlWMWAgZvPHanWtsCSXH+XukFQOnOXi6X2vhEeRrJ2UO530CEba
gnvlczpeLqa2WJ10VsUOJnqRuS00YWHHCeWxAoYdaSVvgAagwKahR6Ky1+rthi8F
XdEDAjVrhnbEsQbrMqz/Go+k0ueO+LsTwyJAJV4GJMHkB72Vv5o/cSyZsW67ZJ0H
G0UFvDoelqXyMDRUfannk+lFEpNrGWgOvxI3+6QcnUE7EYzW3MQ4q/XYdOqWXwpj
j8SlXyU4YuGzeGGW+rzD4Djh4fjPIgcGd9TqYvAQY2flLXqMnUeewQZctvcb2+AC
NwvDJcVRYCcL8s+tmtHIt8DqlqHMmUA4zKj0HVqG5XeoErR/6lHtuN9gUzvfGetO
EkDB7mgslmkCLAGR5qpxFw5yDG+UJeREBT44dxwhXJtRbWneFJdZLWpMHyrpZOfG
Nd9LND5vMGmwLbn0fFLFIhaMeGnlzdef8EgIVYIE4f+woPwdWIkcwXpUln2ZzJmL
mAft6TFQLjKMOfn9zGzN9hWyOTWYQFiqdNaWA2BPzpJSpzNdu+M=
=WY7g
-----END PGP SIGNATURE-----

--73x4qapiqn2sxoen--
