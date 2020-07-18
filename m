Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172CDC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 15:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E082D20656
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 15:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElM6SAhY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgGRPAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 11:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgGRPAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 11:00:09 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1F7C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 08:00:08 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p3so8143054pgh.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 08:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cf6AfotbVkwzxN0B6pKu5bQKdF9RombD7DTsXfr+Acw=;
        b=ElM6SAhYs+4ZLeDO2OEdG0YLwMWK2k7jie8ZkbEaWSF7hkvCnfO+JN0znCBdn2j16q
         p0WNpEBZt0v2WH/ADIy6CfXwsx39LFBl3Bxws8+C/83bglgUMQdJUkRQKy/J1cs7/NcO
         p7QrPJQmA0DohjliAnqyNTfBB2dVhE78dy6hUY4JplRzF4eU75ZAmQpqBjro6N+tCO1/
         NI0FLKuQl3ivIGCheJkzg1/wcgc2xhmlr4p93YBve9wCyQcwpTE198ZswNjd2bwzbvjJ
         1YSo097ExJfLwEIuUSNC1DcD3jvGjcdnu6XbfmO47mK2JDAIwESNTOwmIV5uFLU2P+55
         s6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cf6AfotbVkwzxN0B6pKu5bQKdF9RombD7DTsXfr+Acw=;
        b=sWD8RAZxRz1PmJygNKJ6JHahJ1C9RQb7CjppOHZTpcK36Afte+QIDv05Qc5khmj4Sl
         rZuP31yF1GkNdkxyRPj7oLmozGMzMjCdkRdwNjfewASKqFE8q0dH9+QLD/MyNeNzA0VS
         Iau254XZJpm0SQUJJCVP4mOVQ3UoDV5BPqPnMtrpFaA8tDcUe4+QV2R8rKo/11FCV+YY
         aO0hqoXs8SeE1e47pqBjv97eE8BZs4QP32Xka/j+bQGrnjFBJeWTyBnKtiiHbEl/xJk+
         CRqpYQ2sOaITYIgIKzsQNBZJkRVc41PYD5h40+kwwXEr+fHZ3xwKqwtWkTficM6LHFYC
         JVeA==
X-Gm-Message-State: AOAM532DZSGKn1GV9cX6sPFB815XIHcKIXHuZoRRJ+pvhpB8Xze+A7U1
        UZUQnlWdbNX1EaiNrE/eNOfmV/RcVxAAFw==
X-Google-Smtp-Source: ABdhPJyNAWSg9ciN8AiIDjczi1ipDz2d+sNN9ZsrYMmAi+PJWub8ninbi4Re6Zzn1nItteOxKdjZEg==
X-Received: by 2002:a63:e045:: with SMTP id n5mr6561058pgj.274.1595084408410;
        Sat, 18 Jul 2020 08:00:08 -0700 (PDT)
Received: from blackclown ([103.88.82.25])
        by smtp.gmail.com with ESMTPSA id nl11sm6828513pjb.0.2020.07.18.08.00.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Jul 2020 08:00:07 -0700 (PDT)
Date:   Sat, 18 Jul 2020 20:30:01 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        sam@ravnborg.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: core: Convert device logging to drm_* functions.
Message-ID: <20200718150001.GD26780@blackclown>
References: <20200718145531.GA21897@blackclown>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Content-Disposition: inline
In-Reply-To: <20200718145531.GA21897@blackclown>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 18, 2020 at 08:25:31PM +0530, Suraj Upadhyay wrote:
> Convert device logging with dev_* functions into drm_* functions.
>=20
> The patch has been generated with the coccinelle script below.
> The script focuses on instances of dev_* functions where the drm device
> context is clearly visible in its arguments.
>=20
> @@expression E1; expression list E2; @@
> -dev_warn(E1->dev, E2)
> +drm_warn(E1, E2)
>=20
> @@expression E1; expression list E2; @@
> -dev_info(E1->dev, E2)
> +drm_info(E1, E2)
>=20
> @@expression E1; expression list E2; @@
> -dev_err(E1->dev, E2)
> +drm_err(E1, E2)
>=20
> @@expression E1; expression list E2; @@
> -dev_info_once(E1->dev, E2)
> +drm_info_once(E1, E2)
>=20
> @@expression E1; expression list E2; @@
> -dev_notice_once(E1->dev, E2)
> +drm_notice_once(E1, E2)
>=20
> @@expression E1; expression list E2; @@
> -dev_warn_once(E1->dev, E2)
> +drm_warn_once(E1, E2)
>=20
> @@expression E1; expression list E2; @@
> -dev_err_once(E1->dev, E2)
> +drm_err_once(E1, E2)
>=20
> @@expression E1; expression list E2; @@
> -dev_err_ratelimited(E1->dev, E2)
> +drm_err_ratelimited(E1, E2)
>=20
> @@expression E1; expression list E2; @@
> -dev_dbg(E1->dev, E2)
> +drm_dbg_(E1, E2)

I just spotted this error.

> Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
> ---
>  drivers/gpu/drm/drm_edid.c           | 6 ++----
>  drivers/gpu/drm/drm_gem_cma_helper.c | 4 ++--
>  drivers/gpu/drm/drm_mipi_dbi.c       | 7 +++----
>  3 files changed, 7 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 52b357e75c3d..6840f0530a38 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -1844,9 +1844,7 @@ static void connector_bad_edid(struct drm_connector=
 *connector,
>  	if (connector->bad_edid_counter++ && !drm_debug_enabled(DRM_UT_KMS))
>  		return;
> =20
> -	dev_warn(connector->dev->dev,
> -		 "%s: EDID is invalid:\n",
> -		 connector->name);
> +	drm_warn(connector->dev, "%s: EDID is invalid:\n", connector->name);
>  	for (i =3D 0; i < num_blocks; i++) {
>  		u8 *block =3D edid + i * EDID_LENGTH;
>  		char prefix[20];
> @@ -5298,7 +5296,7 @@ int drm_add_edid_modes(struct drm_connector *connec=
tor, struct edid *edid)
>  	}
>  	if (!drm_edid_is_valid(edid)) {
>  		clear_eld(connector);
> -		dev_warn(connector->dev->dev, "%s: EDID invalid.\n",
> +		drm_warn(connector->dev, "%s: EDID invalid.\n",
>  			 connector->name);
>  		return 0;
>  	}
> diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c b/drivers/gpu/drm/drm_g=
em_cma_helper.c
> index 06a5b9ee1fe0..8d7408a78aee 100644
> --- a/drivers/gpu/drm/drm_gem_cma_helper.c
> +++ b/drivers/gpu/drm/drm_gem_cma_helper.c
> @@ -105,8 +105,8 @@ struct drm_gem_cma_object *drm_gem_cma_create(struct =
drm_device *drm,
>  	cma_obj->vaddr =3D dma_alloc_wc(drm->dev, size, &cma_obj->paddr,
>  				      GFP_KERNEL | __GFP_NOWARN);
>  	if (!cma_obj->vaddr) {
> -		dev_dbg(drm->dev, "failed to allocate buffer with size %zu\n",
> -			size);
> +		drm_dbg_(drm, "failed to allocate buffer with size %zu\n",
> +			 size);

This is an error here.
drm_dbg_ isn't any function.

Resending this patch.

Thanks,

Suraj Upadhyay.

>  		ret =3D -ENOMEM;
>  		goto error;
>  	}
> diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_db=
i.c
> index 0e55d8716e3d..a7a611894243 100644
> --- a/drivers/gpu/drm/drm_mipi_dbi.c
> +++ b/drivers/gpu/drm/drm_mipi_dbi.c
> @@ -225,9 +225,8 @@ int mipi_dbi_buf_copy(void *dst, struct drm_framebuff=
er *fb,
>  		drm_fb_xrgb8888_to_rgb565(dst, src, fb, clip, swap);
>  		break;
>  	default:
> -		dev_err_once(fb->dev->dev, "Format is not supported: %s\n",
> -			     drm_get_format_name(fb->format->format,
> -						 &format_name));
> +		drm_err_once(fb->dev, "Format is not supported: %s\n",
> +			     drm_get_format_name(fb->format->format, &format_name));
>  		return -EINVAL;
>  	}
> =20
> @@ -295,7 +294,7 @@ static void mipi_dbi_fb_dirty(struct drm_framebuffer =
*fb, struct drm_rect *rect)
>  				   width * height * 2);
>  err_msg:
>  	if (ret)
> -		dev_err_once(fb->dev->dev, "Failed to update display %d\n", ret);
> +		drm_err_once(fb->dev, "Failed to update display %d\n", ret);
> =20
>  	drm_dev_exit(idx);
>  }
> --=20
> 2.17.1
>=20



--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE7AbCa0kOsMJ4cx0j+gRsbIfe744FAl8TDnEACgkQ+gRsbIfe
746+iA//X0nutFIQlWhxV33Mu+oimHEdT3SP45dmIGtH1EsXErZYdAlu+VPxg5FJ
+BLnkFEGw9MKumRua3Ko2EOmvE8DqNgEvvSs6E5AcoSpNiZd4kmKaxz7crN3GYCH
GXqn8sMte5SOq51KdKqArDsXb5rkOPLDjwCn2Mp/xTe4URBGu0fnfH3g0tbUov6c
d2wyfP1RoAvTFQdY7szM7Z7u263XyRbO4DCI/HofMS4s+CXpAULU/b4BI7UqIJpW
D97k/hVUaqDRqho92TtmtgFMa7EXEYyNfb++QQvbPv4/XuJtDPqrnptjX5Z8V/HK
okJNAI2NWjbCk5ChapOHPuM7Ush368oIclIQcpR1BePLrqiFyX+KjROBjDASBN2U
4PpglkBgIkdYGLwVx1682iIsDeOvLDu6COtDoF5Gy8iZODl+V1BAjE2ep1lcQhub
fDn9ghegB9qVRLq7u2Wtrgf8/2FdgkwvjLhyKlgboQv7EUCCKYP40z577WJm3BhG
YsKvgFnJ3ZjchRxBNB5aYLAYvCTzEJGD8NkrCaQb5C7/hAcwxoXP489awMuvXhWd
jy78r79C+dl5GMaEWUxZQsG3YVTuKLTCIB0wH7gafdSFOsWr4FtA2e6rv+3lLdEd
IJ4Kr/DfKw5sj4KGOwUhFQ4Dwe6PQMsSWqEkLT3JMmZLwLbFW6c=
=7J5X
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--
