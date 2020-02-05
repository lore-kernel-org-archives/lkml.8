Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2E1C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 19:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22A8214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 19:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkchdjsZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgBETCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 14:02:32 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:33068 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgBETCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 14:02:31 -0500
Received: by mail-il1-f195.google.com with SMTP id s18so2829027iln.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 11:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NFFmVcVESEfwSn2A/244mgSc36NuR/2W0Tkvm0b+8y8=;
        b=OkchdjsZNX5fOzLnoUuy87cUuoKByubZ2zqOERnwR9hKX8hukkCmV8HCsiT0Arwhqh
         O3u9tIDy2LybmWCTmCT2t6gZkyGkqHAe44Iz/NgWrgghuk72FiEkhGsKXBwAe7MREQnP
         9O3smUse0EtCi7RJE2RRNhWI3fQMJwh3UhJhHutolJpbCE+w4TSFfGqPpxdb7kG51xYS
         W2ZpdBe8R0FeOw5HfCQLhmkt6rPo1ibCRSBEg6/O4W7XUwE6nvpNca5Whcb6Cy40v5ip
         34/JEifRWbqP0vThcUQFmYe7iD4JZsM8IbEXOmS2lfT02z3oNYd4U3NS9p3e9u99LbDr
         yI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NFFmVcVESEfwSn2A/244mgSc36NuR/2W0Tkvm0b+8y8=;
        b=UoHlxt0YAv8lO+7vveC8fS2Dk1ZBEz1gbwac9xvkgkwWhAmXJaAws7f18BdZvSslEW
         /Fd6j7cos5/Nq9sJu3BOTkXsajNss9+KAYyGhpR96I3ETjxHcfQgJQ7wY9Ft611Gdi4w
         RLb3hQWaw3691UTizCCiLtaLHhwG2tJle2b4mtNxaNL0w7k2JowN/gUeLQh2S5g0nofo
         y+iZYRGBOOAa3n5Kr4XDZ8xmYqB4FJbmIGK6fmf3Z3AJp1J8FBZL7USCpAPkypYJpKBS
         Y/f3m5T0axCbu2fdmZijMND1myWDcvHzti/qkyO7XljCvz91Iie/QDzOC9NWzL3fM+au
         v/3Q==
X-Gm-Message-State: APjAAAWPfeYoJ+PHQj6ih7mAry9rN9sjja/s/Fsyato7f4A36HeRqd/r
        dgzIaApRJyFck0vjf1OKlFRcko3LkdblfRX9oIg=
X-Google-Smtp-Source: APXvYqyp9wuSn6/5IMsbRVub/R5YxR28vshgim22WfgXtRPHIQYjj4RUu6bWJWFTvDN/70errdbBVIhzy+NuDtuJv0s=
X-Received: by 2002:a92:9ac5:: with SMTP id c66mr35877612ill.232.1580929350686;
 Wed, 05 Feb 2020 11:02:30 -0800 (PST)
MIME-Version: 1.0
References: <20200205105955.28143-1-kraxel@redhat.com> <20200205105955.28143-3-kraxel@redhat.com>
In-Reply-To: <20200205105955.28143-3-kraxel@redhat.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Wed, 5 Feb 2020 11:02:19 -0800
Message-ID: <CAPaKu7SCk_3yeTtzFTTU_y-tyo8EDS7vR8i+mk829=0D-UjLQA@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/virtio: resource teardown tweaks
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

On Wed, Feb 5, 2020 at 3:00 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Add new virtio_gpu_cleanup_object() helper function for object cleanup.
> Wire up callback function for resource unref, do cleanup from callback
> when we know the host stopped using the resource.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h    |  3 ++-
>  drivers/gpu/drm/virtio/virtgpu_object.c | 19 ++++++++++----
>  drivers/gpu/drm/virtio/virtgpu_vq.c     | 35 ++++++++++++++++++++++---
>  3 files changed, 48 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 7e69c06e168e..372dd248cf02 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -262,7 +262,7 @@ void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
>                                     struct virtio_gpu_object_array *objs,
>                                     struct virtio_gpu_fence *fence);
>  void virtio_gpu_cmd_unref_resource(struct virtio_gpu_device *vgdev,
> -                                  uint32_t resource_id);
> +                                  struct virtio_gpu_object *bo);
>  void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
>                                         uint64_t offset,
>                                         uint32_t width, uint32_t height,
> @@ -355,6 +355,7 @@ void virtio_gpu_fence_event_process(struct virtio_gpu_device *vdev,
>                                     u64 last_seq);
>
>  /* virtio_gpu_object */
> +void virtio_gpu_cleanup_object(struct virtio_gpu_object *bo);
>  struct drm_gem_object *virtio_gpu_create_object(struct drm_device *dev,
>                                                 size_t size);
>  int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index 017a9e0fc3bb..28a161af7503 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -61,6 +61,14 @@ static void virtio_gpu_resource_id_put(struct virtio_gpu_device *vgdev, uint32_t
>         }
>  }
>
> +void virtio_gpu_cleanup_object(struct virtio_gpu_object *bo)
> +{
> +       struct virtio_gpu_device *vgdev = bo->base.base.dev->dev_private;
> +
> +       virtio_gpu_resource_id_put(vgdev, bo->hw_res_handle);
> +       drm_gem_shmem_free_object(&bo->base.base);
> +}
> +
>  static void virtio_gpu_free_object(struct drm_gem_object *obj)
>  {
>         struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
> @@ -68,11 +76,12 @@ static void virtio_gpu_free_object(struct drm_gem_object *obj)
>
>         if (bo->pages)
>                 virtio_gpu_object_detach(vgdev, bo);
> -       if (bo->created)
> -               virtio_gpu_cmd_unref_resource(vgdev, bo->hw_res_handle);
> -       virtio_gpu_resource_id_put(vgdev, bo->hw_res_handle);
> -
> -       drm_gem_shmem_free_object(obj);
> +       if (bo->created) {
> +               virtio_gpu_cmd_unref_resource(vgdev, bo);
> +               /* completion handler calls virtio_gpu_cleanup_object() */
nitpick: we don't need this comment when virtio_gpu_cmd_unref_cb is
defined by this file and passed to virtio_gpu_cmd_unref_resource.

I happen to be looking at our error handling paths.  I think we want
virtio_gpu_queue_fenced_ctrl_buffer to call vbuf->resp_cb on errors.


> +               return;
> +       }
> +       virtio_gpu_cleanup_object(bo);
>  }
>
>  static const struct drm_gem_object_funcs virtio_gpu_gem_funcs = {
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 6d6d55dc384e..6e8097e4c214 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -152,6 +152,15 @@ static void *virtio_gpu_alloc_cmd(struct virtio_gpu_device *vgdev,
>                                          sizeof(struct virtio_gpu_ctrl_hdr), NULL);
>  }
>
> +static void *virtio_gpu_alloc_cmd_cb(struct virtio_gpu_device *vgdev,
> +                                    struct virtio_gpu_vbuffer **vbuffer_p,
> +                                    int size,
> +                                    virtio_gpu_resp_cb cb)
> +{
> +       return virtio_gpu_alloc_cmd_resp(vgdev, cb, vbuffer_p, size,
> +                                        sizeof(struct virtio_gpu_ctrl_hdr), NULL);
> +}
> +
>  static void free_vbuf(struct virtio_gpu_device *vgdev,
>                       struct virtio_gpu_vbuffer *vbuf)
>  {
> @@ -494,17 +503,37 @@ void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
>         bo->created = true;
>  }
>
> +static void virtio_gpu_cmd_unref_cb(struct virtio_gpu_device *vgdev,
> +                                   struct virtio_gpu_vbuffer *vbuf)
> +{
> +       struct virtio_gpu_object *bo;
> +
> +       bo = gem_to_virtio_gpu_obj(vbuf->objs->objs[0]);
> +       kfree(vbuf->objs);
> +       vbuf->objs = NULL;
> +
> +       virtio_gpu_cleanup_object(bo);
> +}
> +
>  void virtio_gpu_cmd_unref_resource(struct virtio_gpu_device *vgdev,
> -                                  uint32_t resource_id)
> +                                  struct virtio_gpu_object *bo)
>  {
>         struct virtio_gpu_resource_unref *cmd_p;
>         struct virtio_gpu_vbuffer *vbuf;
>
> -       cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
> +       cmd_p = virtio_gpu_alloc_cmd_cb(vgdev, &vbuf, sizeof(*cmd_p),
> +                                       virtio_gpu_cmd_unref_cb);
>         memset(cmd_p, 0, sizeof(*cmd_p));
>
>         cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_UNREF);
> -       cmd_p->resource_id = cpu_to_le32(resource_id);
> +       cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
> +
> +       /*
> +        * We are in the release callback and do NOT want refcount
> +        * bo, so do NOT use virtio_gpu_array_add_obj().
> +        */
> +       vbuf->objs = virtio_gpu_array_alloc(1);
> +       vbuf->objs->objs[0] = &bo->base.base
This is an abuse of obj array.  Add "void *private_data;" to
virtio_gpu_vbuffer and use that maybe?

Otherwise, simply

  // abuse objs field to pass our private data; must reset in the resp_cb
  vbuf->objs = (virtio_gpu_object_array *) bo;

makes it easier to see what is going on.


>
>         virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
>  }
> --
> 2.18.1
>
