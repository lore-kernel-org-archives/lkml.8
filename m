Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363F6C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 22:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E477A217BA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 22:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oD20NaGR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbgBGWXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 17:23:22 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35660 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbgBGWXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 17:23:21 -0500
Received: by mail-io1-f65.google.com with SMTP id h8so1264439iob.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 14:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sA6Js53ORlW0uVroiulnh1uXWYTp9YqkDTc5J8Q3Y80=;
        b=oD20NaGRXCxfmOO29KILik0LnyWvEfMe/oRPWp0S6BaoKHejPstu0OI/TEU1rSZerg
         C1f0Uz6yB2KNiqQEYyxxQRNSayvchb37akVJzk+0wjiON8gzLtgJ83al1Fc4dD8Pyg7t
         OXvXDaWF4S1tiVPDy/hlfBS9qomdERcRNQapPZy/ykuolviQ1ehXkSDKp8ThaZNE4uDC
         0ZIj+7Y8Y6VEFDezL7gRufAiOivY6hCEGI0gpmWTC9/bGgmyiaTXlgAsKkLnzRbznECt
         3+nG9MYhdVAu4t7PqWm6W6GnnmaJ91v1O+SAWKOwdGccOf1G2+R0dAdbJgqWie7YYc1S
         Evpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sA6Js53ORlW0uVroiulnh1uXWYTp9YqkDTc5J8Q3Y80=;
        b=LZX422JHVqcqGRxcYar8mR1nBrrAEEHc3TG5hVIPIXIY1RgsrWAaJCQ1Zgqj5tub9t
         uFbdlfVCYwaPvj0ZhcoWvPDLkXdU47F0ExxBdoxlIRAPiu7sXd1FKYw9qrfHY8rd/fVt
         cpZXb2KFJeXSXIK5QevWrlbCQOuuuziI519Tmne1c0XgYCRzNbx6K+UcIFIHhAQLkxzB
         696iW8aMK3dVZGulqPPq/W2/0SGGK8AmO8I72SqsIFGWC12tQc6/TGWVK9//Oinye2H1
         qQmdD1+PAfxWXxZ6XTUFalp1YsX1YwgLH1vxYkmtR2/FRGRjzyQF+MV8DGS43RyedwAC
         r8ow==
X-Gm-Message-State: APjAAAVTp2Anpp1eTMNl4XUkYeoHBTSI5uS4/Lr7hVqou/9guLy74JHO
        qKPJPaPDFlE1KSaxG+MJ8XCWWJSfMW23iwNwx+M=
X-Google-Smtp-Source: APXvYqxxbxrtQDsGUBf6HkL2+KQF/kay9kSPxnWdpBBCcbtstKDMp5KcBfja3QQqwXsG9bfbXU+jRTEQmSMx8DgT1yE=
X-Received: by 2002:a5d:8146:: with SMTP id f6mr595935ioo.93.1581114200829;
 Fri, 07 Feb 2020 14:23:20 -0800 (PST)
MIME-Version: 1.0
References: <20200207074638.26386-1-kraxel@redhat.com> <20200207074638.26386-5-kraxel@redhat.com>
In-Reply-To: <20200207074638.26386-5-kraxel@redhat.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Fri, 7 Feb 2020 14:23:09 -0800
Message-ID: <CAPaKu7Rc2jerNzDL7P4B1A2_a9z99B8LTHDi3OZnYxdw7+sLcg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/virtio: move virtio_gpu_mem_entry
 initialization to new function
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 6, 2020 at 11:46 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Introduce new virtio_gpu_object_shmem_init() helper function which will
> create the virtio_gpu_mem_entry array, containing the backing storage
> information for the host.  For the most path this just moves code from
> virtio_gpu_object_attach().
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h    |  4 +-
>  drivers/gpu/drm/virtio/virtgpu_object.c | 55 ++++++++++++++++++++++++-
>  drivers/gpu/drm/virtio/virtgpu_vq.c     | 51 ++---------------------
>  3 files changed, 60 insertions(+), 50 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index d37ddd7644f6..6c78c77a2afc 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -71,6 +71,7 @@ struct virtio_gpu_object {
>
>         struct sg_table *pages;
>         uint32_t mapped;
> +
>         bool dumb;
>         bool created;
>  };
> @@ -280,7 +281,8 @@ void virtio_gpu_cmd_set_scanout(struct virtio_gpu_device *vgdev,
>                                 uint32_t x, uint32_t y);
>  int virtio_gpu_object_attach(struct virtio_gpu_device *vgdev,
>                              struct virtio_gpu_object *obj,
> -                            struct virtio_gpu_fence *fence);
> +                            struct virtio_gpu_mem_entry *ents,
> +                            unsigned int nents);
>  int virtio_gpu_attach_status_page(struct virtio_gpu_device *vgdev);
>  int virtio_gpu_detach_status_page(struct virtio_gpu_device *vgdev);
>  void virtio_gpu_cursor_ping(struct virtio_gpu_device *vgdev,
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index bce2b3d843fe..8870ee23ff2b 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -121,6 +121,51 @@ struct drm_gem_object *virtio_gpu_create_object(struct drm_device *dev,
>         return &bo->base.base;
>  }
>
> +static int virtio_gpu_object_shmem_init(struct virtio_gpu_device *vgdev,
> +                                       struct virtio_gpu_object *bo,
> +                                       struct virtio_gpu_mem_entry **ents,
> +                                       unsigned int *nents)
> +{
> +       bool use_dma_api = !virtio_has_iommu_quirk(vgdev->vdev);
> +       struct scatterlist *sg;
> +       int si, ret;
> +
> +       ret = drm_gem_shmem_pin(&bo->base.base);
> +       if (ret < 0)
> +               return -EINVAL;
> +
> +       bo->pages = drm_gem_shmem_get_sg_table(&bo->base.base);
> +       if (!bo->pages) {
> +               drm_gem_shmem_unpin(&bo->base.base);
> +               return -EINVAL;
> +       }
> +
> +       if (use_dma_api) {
> +               bo->mapped = dma_map_sg(vgdev->vdev->dev.parent,
> +                                       bo->pages->sgl, bo->pages->nents,
> +                                       DMA_TO_DEVICE);
> +               *nents = bo->mapped;
> +       } else {
> +               *nents = bo->pages->nents;
> +       }
> +
> +       *ents = kmalloc_array(*nents, sizeof(struct virtio_gpu_mem_entry),
> +                             GFP_KERNEL);
> +       if (!(*ents)) {
> +               DRM_ERROR("failed to allocate ent list\n");
> +               return -ENOMEM;
> +       }
> +
> +       for_each_sg(bo->pages->sgl, sg, *nents, si) {
> +               (*ents)[si].addr = cpu_to_le64(use_dma_api
> +                                              ? sg_dma_address(sg)
> +                                              : sg_phys(sg));
> +               (*ents)[si].length = cpu_to_le32(sg->length);
> +               (*ents)[si].padding = 0;
> +       }
> +       return 0;
> +}
> +
>  int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
>                              struct virtio_gpu_object_params *params,
>                              struct virtio_gpu_object **bo_ptr,
> @@ -129,6 +174,8 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
>         struct virtio_gpu_object_array *objs = NULL;
>         struct drm_gem_shmem_object *shmem_obj;
>         struct virtio_gpu_object *bo;
> +       struct virtio_gpu_mem_entry *ents;
> +       unsigned int nents;
>         int ret;
>
>         *bo_ptr = NULL;
> @@ -165,7 +212,13 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
>                                                objs, fence);
>         }
>
> -       ret = virtio_gpu_object_attach(vgdev, bo, NULL);
> +       ret = virtio_gpu_object_shmem_init(vgdev, bo, &ents, &nents);
> +       if (ret != 0) {
> +               virtio_gpu_free_object(&shmem_obj->base);
> +               return ret;
> +       }
> +
> +       ret = virtio_gpu_object_attach(vgdev, bo, ents, nents);
>         if (ret != 0) {
>                 virtio_gpu_free_object(&shmem_obj->base);
>                 return ret;
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 87c439156151..8360f7338209 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -1086,56 +1086,11 @@ void virtio_gpu_cmd_submit(struct virtio_gpu_device *vgdev,
>
>  int virtio_gpu_object_attach(struct virtio_gpu_device *vgdev,
nit: why do we keep this wrapper function?

Series is

  Reviewed-by: Chia-I Wu <olvaffe@gmail.com>

>                              struct virtio_gpu_object *obj,
> -                            struct virtio_gpu_fence *fence)
> +                            struct virtio_gpu_mem_entry *ents,
> +                            unsigned int nents)
>  {
> -       bool use_dma_api = !virtio_has_iommu_quirk(vgdev->vdev);
> -       struct virtio_gpu_mem_entry *ents;
> -       struct scatterlist *sg;
> -       int si, nents, ret;
> -
> -       if (WARN_ON_ONCE(!obj->created))
> -               return -EINVAL;
> -       if (WARN_ON_ONCE(obj->pages))
> -               return -EINVAL;
> -
> -       ret = drm_gem_shmem_pin(&obj->base.base);
> -       if (ret < 0)
> -               return -EINVAL;
> -
> -       obj->pages = drm_gem_shmem_get_sg_table(&obj->base.base);
> -       if (obj->pages == NULL) {
> -               drm_gem_shmem_unpin(&obj->base.base);
> -               return -EINVAL;
> -       }
> -
> -       if (use_dma_api) {
> -               obj->mapped = dma_map_sg(vgdev->vdev->dev.parent,
> -                                        obj->pages->sgl, obj->pages->nents,
> -                                        DMA_TO_DEVICE);
> -               nents = obj->mapped;
> -       } else {
> -               nents = obj->pages->nents;
> -       }
> -
> -       /* gets freed when the ring has consumed it */
> -       ents = kmalloc_array(nents, sizeof(struct virtio_gpu_mem_entry),
> -                            GFP_KERNEL);
> -       if (!ents) {
> -               DRM_ERROR("failed to allocate ent list\n");
> -               return -ENOMEM;
> -       }
> -
> -       for_each_sg(obj->pages->sgl, sg, nents, si) {
> -               ents[si].addr = cpu_to_le64(use_dma_api
> -                                           ? sg_dma_address(sg)
> -                                           : sg_phys(sg));
> -               ents[si].length = cpu_to_le32(sg->length);
> -               ents[si].padding = 0;
> -       }
> -
>         virtio_gpu_cmd_resource_attach_backing(vgdev, obj->hw_res_handle,
> -                                              ents, nents,
> -                                              fence);
> +                                              ents, nents, NULL);
>         return 0;
>  }
>
> --
> 2.18.1
>
