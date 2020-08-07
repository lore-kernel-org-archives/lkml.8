Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35C0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 03:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98B4020855
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 03:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="Gm31v+4c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgHGDAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 23:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgHGDAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 23:00:24 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA31C061575
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 20:00:24 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z14so628281ljm.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 20:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wTsG01+FAeINX7tJPCyhTMiFIIvHpHWzQDxM2xhAlu0=;
        b=Gm31v+4cDz5MOdOXgxbVeFLOkDmj2PWmhCK9B44JcVcB9EGVqb2EHJ0glPrQdedeoE
         +dPxtK2Xc4SGtVJ0QTwcIjnwhBQLRJ6/jUNKjdOiYs3niZ53XsOdbdI5ttB999I6uP+H
         iWK3PQQX3DLEjizrqFQvsKsZmACpiG1RLlyK+tME069oyyEudHRoRjWP8AHYf4ryErIi
         35fufUI9RK1j7dKbgGkydHUIbns0c81ybZVZ9dmrf+hcULwDmTTdzQCxgNcwlUDuMqrn
         BFJUbsGedZMnaLb7fdruesQNZV88xD2p2V5MlqR6ObkfvHqhb7BvgMQ1rGKCa4veKuCZ
         W4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wTsG01+FAeINX7tJPCyhTMiFIIvHpHWzQDxM2xhAlu0=;
        b=uCFJMHKZAHOXDd+Tjl4SsRLOjJfYi2C/UclFLR16v+z/bTLmBTs0pnd2sQW0z3RoTI
         YCpS7glQqEHiY/gioeIbOYuV0inMaema0lbnbP+QB8hsRCjtO87ul/FBBivICUkjhvP8
         KXocWUZMC2euSoHoVQx0tsYO2AdNLaTNfS4ZF6NUFr/V4y9C44gbiQkRCLww3hkvm/Lx
         y+fh0f43hkEXWTVQTkkI+ns52qKYuHDKcCpeiMNern2iMP8cpe9NmCBTFp2CUV4rs7Eq
         3bnj6ZVECZyyumOwSI1Rf0fD4l/04zDgUaL7fjnhkVwNHqBR2VgrKyHWP6xJffEhDtOP
         AgtQ==
X-Gm-Message-State: AOAM530xCJ8+eGnZwnDRvmv3XLiov6qJtHvD535vADPryARKfr+3RDlc
        cfj0uAv/O7TKYNl6COrgCuKQvT+lb2axjbCYu7t2oQ==
X-Google-Smtp-Source: ABdhPJyksl15UPkEtHxTCd6XOj4wYFTTaeSdOFSPR45CICDOdBMwsjVD+2gtHPnL9heaHDSkTdbmmnz6Q2VSG4Gis7Q=
X-Received: by 2002:a2e:87c4:: with SMTP id v4mr5180563ljj.8.1596769222640;
 Thu, 06 Aug 2020 20:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200721101647.42653-1-hexin.op@bytedance.com>
In-Reply-To: <20200721101647.42653-1-hexin.op@bytedance.com>
From:   =?UTF-8?B?5L2V6ZGr?= <hexin.op@bytedance.com>
Date:   Fri, 7 Aug 2020 11:00:11 +0800
Message-ID: <CACKzwj=obkJPmMb1cGKDwBdgkxa92kpPTP9c2SzFWbbzcD6Luw@mail.gmail.com>
Subject: Re: [PATCH v3] drm/virtio: fix missing dma_fence_put() in virtio_gpu_execbuffer_ioctl()
To:     Daniel Vetter <daniel@ffwll.ch>, airlied@linux.ie,
        kraxel@redhat.com, Sumit Semwal <sumit.semwal@linaro.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-media@vger.kernel.org, Qi Liu <liuqi.16@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>,
        gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xin He <hexin.op@bytedance.com> =E4=BA=8E2020=E5=B9=B47=E6=9C=8821=E6=97=A5=
=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=886:17=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Qi Liu <liuqi.16@bytedance.com>
>
> We should put the reference count of the fence after calling
> virtio_gpu_cmd_submit(). So add the missing dma_fence_put().
>
> Fixes: 2cd7b6f08bc4 ("drm/virtio: add in/out fence support for explicit s=
ynchronization")
> Co-developed-by: Xin He <hexin.op@bytedance.com>
> Signed-off-by: Xin He <hexin.op@bytedance.com>
> Signed-off-by: Qi Liu <liuqi.16@bytedance.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> ---
>
> changelog in v3:
> 1) Change the subject from "drm/virtio: fixed memory leak in virtio_gpu_e=
xecbuffer_ioctl()" to
>    "drm/virtio: fix missing dma_fence_put() in virtio_gpu_execbuffer_ioct=
l()"
> 2) Rework the commit log
>
> changelog in v2:
> 1) Add a change description
>
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/vir=
tio/virtgpu_ioctl.c
> index 5df722072ba0..19c5bc01eb79 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -179,6 +179,7 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_dev=
ice *dev, void *data,
>
>         virtio_gpu_cmd_submit(vgdev, buf, exbuf->size,
>                               vfpriv->ctx_id, buflist, out_fence);
> +       dma_fence_put(&out_fence->f);
>         virtio_gpu_notify(vgdev);
>         return 0;
>
> --
> 2.21.1 (Apple Git-122.3)
>

cc Greg

--
Xin He
