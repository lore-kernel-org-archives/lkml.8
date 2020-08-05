Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FE4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 12:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E33221744
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 12:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="wJESEINa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgHEMxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 08:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728378AbgHEMfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 08:35:43 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81BEC034614
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 05:29:41 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w14so17616828ljj.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 05:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m/HjrwgANJ8PQYoygV3h9t78fC88XwgOTu6N21/7jsU=;
        b=wJESEINa50YXFAOvvT+ZjoFcwfezYCjc+aFZwKvaqZgKzJkvDJ3dDvDHgb3d+YlpiV
         Zu/xKxVk8HXXbc6bqS+9Xsi9wdRtSo3zfueJOQxOu2zJDRI8ov8UCP1NOYhlSllRZbxK
         uAZprp4t2CmB87pxUcIjU0Tw+SIoG4ekrPels87nZiMVu70rlMszzl3etxDyL4fjSR5G
         H/63ayB5Cfr1wqSu8BTvktM8UNczdcnydn7WGwiqLp4JKcheq3r+mIt0SSVw6aBtCf0p
         2Ov0/7UIjc4+H5QI5bHF9zVVu5Sp4UTrjs/HZJgS2Ch/lzcEn3mPZZts37p41CgdXNn8
         m3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m/HjrwgANJ8PQYoygV3h9t78fC88XwgOTu6N21/7jsU=;
        b=hoxRC54LQCSROn8j9s6cZ2lA7KimWy0m2eRbl+L/0eIPSZeWCh7kHl/f4Ddl2Mx+JP
         O+jZyI2sHHskQ6At/elHVpt3eRL3lMLmdsDLHXLPd1NXpVw4MlF+C5dy9s3MtWQgPxWF
         7FxElDxqVpeRkbPifeVrEiUmmAN9qq2xXq1ib/ah35y2co80oOs5JrZnIAthpgnAfCka
         VzT0zH8J/HPrQAlOYvfvrt7J2yCNsfkur/IOX/hOLbOU90dfCEDSHkXJJztnipczZ7cy
         APGLQaeMOMGxS46NSQveIRzk8vbM6uwUAisSI7QMGIpFEllwuQkBX3co3doFP4ZQWZDi
         BvBQ==
X-Gm-Message-State: AOAM532qpWHYagwdiA58C4VUg7hLbXmUgqi/OTr86vQx5fTs146fbuuD
        a4+qbaoA6S6akAr8nCUGXtd9ozmxwkm+aud0k4ALvDfcmriKYw==
X-Google-Smtp-Source: ABdhPJyOjEZP47sZuldKNYJEYhNasYStQC+Fa3ES/mPukklZJ0Ni87yn1PSduKSm1D8JMHN41/q6VU9WiSOspSt7ifk=
X-Received: by 2002:a2e:844a:: with SMTP id u10mr1402186ljh.213.1596630579936;
 Wed, 05 Aug 2020 05:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200722051851.72662-1-hexin.op@bytedance.com>
In-Reply-To: <20200722051851.72662-1-hexin.op@bytedance.com>
From:   =?UTF-8?B?5L2V6ZGr?= <hexin.op@bytedance.com>
Date:   Wed, 5 Aug 2020 20:29:29 +0800
Message-ID: <CACKzwjntROYA0WjdVewmozrXnzb=YX2dvqHgEpj4POOy0-QXOw@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: fix memory leak in virtio_gpu_cleanup_object()
To:     airlied@linux.ie, kraxel@redhat.com,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Qi Liu <liuqi.16@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xin He <hexin.op@bytedance.com> =E4=BA=8E2020=E5=B9=B47=E6=9C=8822=E6=97=A5=
=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=881:19=E5=86=99=E9=81=93=EF=BC=9A
>
> Before setting shmem->pages to NULL, kfree() should
> be called.
>
> Signed-off-by: Xin He <hexin.op@bytedance.com>
> Reviewed-by: Qi Liu <liuqi.16@bytedance.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_object.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/vi=
rtio/virtgpu_object.c
> index 6ccbd01cd888..703b5cd51751 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -79,6 +79,7 @@ void virtio_gpu_cleanup_object(struct virtio_gpu_object=
 *bo)
>                         }
>
>                         sg_free_table(shmem->pages);
> +                       kfree(shmem->pages);
>                         shmem->pages =3D NULL;
>                         drm_gem_shmem_unpin(&bo->base.base);
>                 }
> --
> 2.21.1 (Apple Git-122.3)
>

Ping guys. Any comments or suggestions=EF=BC=9F

--
Xin He
