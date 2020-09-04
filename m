Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A53AC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C0B02074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3UJoB2R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgIDQGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 12:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgIDQF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:05:59 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E053BC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 09:05:58 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id j3so3241694qvi.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 09:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2k+RMtQ7FVvTOkg2KVamAhOp4172u29BwvuLUNGieoE=;
        b=E3UJoB2RPcPyiVe1/U8HdULwx64HkjynNKAmKPmm069PXep9Rp7QzmrXwxuuHVt6sK
         wLL2wy1GsS6UOmrd9H2rrz/bCDFyICm2iqiR3cXx+4pcQwPbf+KiWs1kRM3krqfD7ayL
         9bNc2K9CqhrufC905POoGFJRZ4fFrgwEt2zHk+BhWZWhkZapkyZDdMCtCm0xiamtrUDT
         Mcy5pEKbnSQSHDU/MnmasTIb6T+9pdzTi4qE31g186uyfDS7OJQaClPC7ErvLgsq5muo
         Q3AAxAtUa5wsUGYPElGUal65nG+y5RmDrL0N4/jCYkORNsRPejnpBnFVYc4zGX2lS6ED
         CqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2k+RMtQ7FVvTOkg2KVamAhOp4172u29BwvuLUNGieoE=;
        b=fMgReMgmHkAl0U6Q7htdK5b0AA4b/SKkEEuIi8kiCx8A3h0ox4mb6fHLuPT2x9Djhi
         sxH0mhlzjXMGO908/9LFEZW5aAbBunDHvpUw+zJLraZIfln9vKaCvE+s7AdQ3y0sXZk8
         J/ygQ2vlaq1/y6nmEuHkU2gZMKmn5+T0+xWyqKh7GQ0Vk3PEgUF+B6G6rJmVeqlFxPuA
         t8NC+yHkehSj867j4JVLFJVTlf6rzIbB6ceafmBa9W/5L27VrnuzMoZmlcdJZt0w72dW
         Fnl8Fhv2e/BQt3tDPGz2TWiO1ZtMAp24Hr209FLLH6izchzndqdd4xc+RVXb1w371Dxk
         ezaw==
X-Gm-Message-State: AOAM532hTVLR/65+D83z6eqVodrIrbnQA8V+hP6PG53Ky0gCCR6U9Sgn
        pFoAzVHf3U2ZKYQwGGE07pc=
X-Google-Smtp-Source: ABdhPJzq14od5HRnlJY5OJFH0Zl73OpWrOWApVh1vD7AQrfE7+xYmoR82ZrPSllUV12xFQddQi/PSw==
X-Received: by 2002:a0c:b2d4:: with SMTP id d20mr7559760qvf.1.1599235557522;
        Fri, 04 Sep 2020 09:05:57 -0700 (PDT)
Received: from smtp.gmail.com ([2607:fea8:56e0:6d60::10ec])
        by smtp.gmail.com with ESMTPSA id c13sm4841611qtq.5.2020.09.04.09.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 09:05:56 -0700 (PDT)
Date:   Fri, 4 Sep 2020 12:05:42 -0400
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Melissa Wen <melissa.srw@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        twoerner@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add entry for VKMS
Message-ID: <20200904160542.3nxdioebafgt352x@smtp.gmail.com>
References: <20200904130605.vs5tnfhgnemnz6pt@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nrdcccm2bvsn7by3"
Content-Disposition: inline
In-Reply-To: <20200904130605.vs5tnfhgnemnz6pt@smtp.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nrdcccm2bvsn7by3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09/04, Melissa Wen wrote:
> Add myself as maintainer of VKMS driver
>=20
> Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 01fb9ee6b951..d4277824a01c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5640,6 +5640,7 @@ F:	drivers/gpu/drm/udl/
> =20
>  DRM DRIVER FOR VIRTUAL KERNEL MODESETTING (VKMS)
>  M:	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> +M:	Melissa Wen <melissa.srw@gmail.com>
>  R:	Haneen Mohammed <hamohammed.sa@gmail.com>
>  R:	Daniel Vetter <daniel@ffwll.ch>
>  L:	dri-devel@lists.freedesktop.org
> --=20
> 2.28.0
>=20

Acked-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>

--=20
Rodrigo Siqueira
https://siqueira.tech

--nrdcccm2bvsn7by3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl9SZdAACgkQWJzP/com
vP81KxAAnOH/Da0fUQ5YNF1s4/rdaiUCgFJc50DsODod4nSCblcPGhZ11XqLBrbl
MbnhslELK6lIVMl2JD9wXR02nFif/fCzktt7f4jjzx4edrs01kSx9M7ndmQD2cyp
P6bHw8itjc6e62Jb9ZZFH/l3w8d9BSxdaAoxtz44+lGG4PJfYlsgS+EpFfljQtmN
v8oK+jXTZygo1BGzXt2dIgz/UC8KNHNHbT9/ExT71Qb61YcdeJN3fINLA5HAcKX6
+VIibp9W++7dM2/t6EUWfhRY2oM4RFyVp+mygpR1talPpDN9jn4ff9eotHW+mBHK
2ZfeNxIGrNAkvPkoL5jJxioq8cvJ1MCgvuS9vfZEHXbARaeX9WzCNcylgtJrPsmh
nJ9gO5G6JaESkYyaT+yoYmhXfTUTzTkXHNOQnuhjtaWoPZCbVYS2Jorq/VUh4TIM
7sS0bYSzE3634iyCZKT0gQmDqORcWiPTxakVa6ofmBMot8e4e6wElb20wvRibNSd
T437J+JdC84ftD7vPXkQx1dFRrSgngEuM6k0odU6VmCEzKvsfoOPXD4r+Jx4sFEx
DTebG+leukKTHXY5sHNj2r4VrpLMHNhIwFc37bvsmkMgEY4uQHC6ZMd3xqW8Ag4t
UVE4AWvax7idObwfFKJHVFmy2gi+rXW+wksuH5TEDT3DacyYfYs=
=oaui
-----END PGP SIGNATURE-----

--nrdcccm2bvsn7by3--
