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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21C3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 03:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8248C206EB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 03:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vp6RyI0P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgHYDEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 23:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbgHYDEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 23:04:12 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5632BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 20:04:12 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id t23so8071607qto.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 20:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WMp6rKseSIGCKZ7smcMX9FYuG3pJNq2bUd+Xjt7quUY=;
        b=Vp6RyI0Pj27U1iJPgEEP125p75R8nINpr4UpTse2ul+aJcuC1d4FkqsSuTSTYbCCxF
         jckdzONaRBfqOij1ebyT1/VTrJUDNcg5KhHzfIYlUJIfjWgAXz3rae4cT6jomc8zZfzJ
         jq0buk3DfwwvXCCsXQbvSp9Xx9bGPT7Issz/WrDzHcu3Jw9/9Ao4UAcd2rsdIvMHfVKn
         peR9OXBlLi0BE8+zwlB4v0mU1pybvMSI74VqTnTlRw9Mx/8NpTmu4TvARPLouz1ZJk+y
         /RRTFo6wulAsF579TLrA0icYMPYvCnPTv10PYxQBrRrDsaHkNntPb3GTIGR8WGsapsSX
         HjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WMp6rKseSIGCKZ7smcMX9FYuG3pJNq2bUd+Xjt7quUY=;
        b=P3aNlA0Qf3gahBlBfyWorIXRA9enCiZrrVFeoRO3swCJ2jZwZTXe4TVvExp3eSKdpI
         QDedZOtpeT46c6y9TRTB/+pbJ+O6yjNRtONT81MVncTRdFNFubItnWccDk3Ow2nZzaPX
         Da8aYBEY7AFhELsZYuka53Qf/cJ7B62q2ilNNH1FyP2ShW9/6nT78gyneFs1epNGnVE8
         Wc8xMBx3lHYcS6VqcXqXBYwgqb8H98GPBfaEluSPNKVaPyGy1ZSftfVSaGloT9YzrYk6
         Kd7nHFIh5nh8Cjf9zfpGpGo2QowH2hTRFHogtmKW/K0QFCgNEThCDBmOmkpYd7XXp35i
         GsaA==
X-Gm-Message-State: AOAM533ABKs+TafRx78EBGeLrBaW8EiyoXuYVgxHFDeqUEiYQd2XDSe+
        lgK0NOD/tKTdqYZ07J7QjQw=
X-Google-Smtp-Source: ABdhPJxch/RRT5dyLLc9QsWE0sRTr5+2WAEaQpazftlMpwy9NcxE2V1piaR6GpZp5uy9YENNdtM4Yg==
X-Received: by 2002:ac8:5218:: with SMTP id r24mr7877876qtn.300.1598324651593;
        Mon, 24 Aug 2020 20:04:11 -0700 (PDT)
Received: from smtp.gmail.com ([2607:fea8:56e0:6d60::2db6])
        by smtp.gmail.com with ESMTPSA id c40sm1644073qtb.72.2020.08.24.20.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 20:04:10 -0700 (PDT)
Date:   Mon, 24 Aug 2020 23:04:04 -0400
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Melissa Wen <melissa.srw@gmail.com>
Cc:     Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com, twoerner@gmail.com
Subject: Re: [PATCH] drm/vkms: add alpha-premultiplied color blending
Message-ID: <20200825030404.htitgoy27nyhlezz@smtp.gmail.com>
References: <20200819205336.fce24lioz34vbcd2@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pqakxti56v5wopbe"
Content-Disposition: inline
In-Reply-To: <20200819205336.fce24lioz34vbcd2@smtp.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pqakxti56v5wopbe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Melissa,

First of all, thanks a lot for your patch!

Follows my inline comments.

On 08/19, Melissa Wen wrote:
> The current VKMS blend function ignores alpha channel and just overwrites
> vaddr_src with vaddr_dst. This XRGB approach triggers a warning when
> running the kms_cursor_crc/cursor-alpha-transparent test case. In IGT
> tests, cairo_format_argb32 uses premultiplied alpha (according to
> documentation), so this patch considers premultiplied alpha colors to
> compose vaddr_src with vaddr_dst.
>=20
> This change removes the following cursor-alpha-transparent warning:
> Suspicious CRC: All values are 0.
>=20
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
>=20
> Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
> ---
>  drivers/gpu/drm/vkms/vkms_composer.c | 43 +++++++++++++++++++++-------
>  1 file changed, 33 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/=
vkms_composer.c
> index 4f3b07a32b60..6aac962d3e2e 100644
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
> @@ -42,6 +40,32 @@ static uint32_t compute_crc(void *vaddr_out, struct vk=
ms_composer *composer)
>  	return crc;
>  }
> =20
> +u8 blend_channel(u8 c_src, u8 c_dst, u8 a_src)

Use static here.

Also, replace c_src to src, c_dst to dst, and a_src to alpha.

> +{
> +	u32 pre_blend;
> +	u8 new_color;
> +
> +	/* Premultiplied alpha blending - IGT + cairo context */

You can drop the part that says "IGT + cairo context", this explanation
better suit the commit message.

> +	pre_blend =3D (c_src * 255 + c_dst * (255 - a_src));
> +
> +	/* Faster div by 255 */
> +	new_color =3D ((pre_blend + ((pre_blend + 257) >> 8)) >> 8);
> +
> +	return new_color;
> +}
> +
> +void alpha_blending(u8 *argb_src, u8 *argb_dst)

Use static.

Looks like that argb_src is a read-only variable, in this sense add
const.

> +{
> +	u8 a_src;
> +
> +	a_src =3D argb_src[3];

change a_src to alpha.

> +	argb_dst[0] =3D blend_channel(argb_src[0], argb_dst[0], a_src);
> +	argb_dst[1] =3D blend_channel(argb_src[1], argb_dst[1], a_src);
> +	argb_dst[2] =3D blend_channel(argb_src[2], argb_dst[2], a_src);
> +	/* Opaque primary */
> +	argb_dst[3] =3D 0xFF;
> +}
> +
>  /**
>   * blend - blend value at vaddr_src with value at vaddr_dst
>   * @vaddr_dst: destination address
> @@ -50,12 +74,9 @@ static uint32_t compute_crc(void *vaddr_out, struct vk=
ms_composer *composer)
>   * @src_composer: source framebuffer's metadata
>   *
>   * Blend value at vaddr_src with value at vaddr_dst.
> - * Currently, this function write value of vaddr_src on value
> - * at vaddr_dst using buffer's metadata to locate the new values
> - * from vaddr_src and their destination at vaddr_dst.
> - *
> - * TODO: Use the alpha value to blend vaddr_src with vaddr_dst
> - *	 instead of overwriting it.
> + * Currently, this function considers premultiplied alpha for blending, =
as used
> + * by Cairo. It uses buffer's metadata to locate the new composite value=
s at
> + * vaddr_dst.
>   */
>  static void blend(void *vaddr_dst, void *vaddr_src,
>  		  struct vkms_composer *dest_composer,
> @@ -63,6 +84,7 @@ static void blend(void *vaddr_dst, void *vaddr_src,
>  {
>  	int i, j, j_dst, i_dst;
>  	int offset_src, offset_dst;
> +	u8 *p_dst, *p_src;

I suppose that p stands for "pixel", right? In this case how about use
pixel?

Best Regards
Rodrigo Siqueira

> =20
>  	int x_src =3D src_composer->src.x1 >> 16;
>  	int y_src =3D src_composer->src.y1 >> 16;
> @@ -84,8 +106,9 @@ static void blend(void *vaddr_dst, void *vaddr_src,
>  				     + (i * src_composer->pitch)
>  				     + (j * src_composer->cpp);
> =20
> -			memcpy(vaddr_dst + offset_dst,
> -			       vaddr_src + offset_src, sizeof(u32));
> +			p_src =3D (u8 *)(vaddr_src + offset_src);
> +			p_dst =3D (u8 *)(vaddr_dst + offset_dst);
> +			alpha_blending(p_src, p_dst);
>  		}
>  		i_dst++;
>  	}
> --=20
> 2.28.0
>=20

--=20
Rodrigo Siqueira
https://siqueira.tech

--pqakxti56v5wopbe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl9Ef58ACgkQWJzP/com
vP/jgRAAvAg8MOEHx2JYnEfBIGYV8151bxm6ay3YEq/28WkLuvmHGrwAK75ugmEf
AEV+t2BvZqZTdOAApeI/SGo21khJru9c+eedt8OmMiseOmhXLV8GrlKHei2ONJlh
Vt+jvfYYxvRj15jm/juvoiw+nkd2gmTu6aZJ822Oh/6d8c2zzxzI4IYEZ/nafX3S
vChd30Sb4KdPdcItRTVTnK9I6v2vwc1gKikOQJ7InmloLH/MjS1Wb35PgXbRRsZh
+1sgJEuDfjTOy6qTQ2fd/LkaSOje8TiQvwo1w1S317j3kKbsDjPFMyhAzLSUpxF4
4G03o22aUcYXinkewpW+Fr9JLiKj+1+x+TlUxkwMmD4fqdiLHFF4jS3fKYyVsg23
NoZPfHHjg/e+XQ3IKS+rR9m3L9ozd/r/DyS0REvRZqlkgJp780Wtq18LBvU3N6/r
l31mshDgmFCAA8xT0u9UfEnJkL2aZE0T+voYZipxL0QQmUTyf47uK1LrYVdGh89V
F1O9+LThNO3qZ/MuUjKcSalACto7oFIRgDsIVGPEx8u4Zk/SMcQb7lGSTcGAgqSq
9NyRKgFsgQFFMjpDEk4JjRBflavT6cUm0j4ThUKAKNJJuopW2anrG7vN1kshqQh1
J5rca+g+BUr1GJH0KWg/BDEhu9bwokeYjCHt8te6akI3bOJNDQ4=
=EBgw
-----END PGP SIGNATURE-----

--pqakxti56v5wopbe--
