Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975F5C3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72370206CC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuFXWeFq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgBMSye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:54:34 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:40379 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbgBMSye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 13:54:34 -0500
Received: by mail-il1-f195.google.com with SMTP id i7so5894783ilr.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 10:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bRoElX6JuGSJIj1nzDEkGjFX2yatSmfvyb68/4mK0og=;
        b=KuFXWeFq0mYsucnXtEil4E8uJ/Xi9I8NFtS2D8Nq96ybHLSqVX3cFY/M54teo+zphX
         8Q+vqenQIgFsq8dmQMXw3ZmpsdTUAwPivpn+7DoDNxs33VG0bt4EL4MZs0CaLxuCCLQC
         BvDCnlVtrNTMZosO8DIxQVYaG1bHk04W/CfOjWw0T26357uN55rpZ+etDHcZAOfWgF3y
         PkKoBqpCWGE4usla6USJnXEklQP99luo5rprwn5EvvXoKO6HURlR+gMQJlQ/HNas5q7g
         iuefhdaHNMK9XZkv7BVrGXJNMutQvtTgtkimqb5M0PlEZbHRmiy9DPXnQohL6Qkm4NYw
         B8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bRoElX6JuGSJIj1nzDEkGjFX2yatSmfvyb68/4mK0og=;
        b=qLupRZJPPTw6pQT8cJWZ8DyfXqc7Ier+qxxnFO8fYKoD0jJlJISwLviby5qEvLaZTI
         SlHQ9JUfkjOkJCemSaeh6Kt8Jk/IKuNxZmwVIcHIT3fHn9IH60kHHRcRVmBzSuzn2vEd
         n9Q/dbGDCzCCh+/l2XcdcpVYGOIQBVYjomKXroLceTSsi7idV7/dO59n9WXhYZiovSI1
         /nvFA7c90GKjgWl7ximtPEEMWWjOtQWREc9KTj3HSouKqGaLnHxfekUEcfUn2DFeg3Nf
         FqDt88RaH4E5VokylSCdl31wzlDWkkK7HlVQKTVxf8Q1JGl4JqCUG079j6gx7p+ftArL
         jJkQ==
X-Gm-Message-State: APjAAAWR4PekDkaENofEWox94J58uyn3iwgnSoGN0gsBkxMK3Gzi9nKC
        97JN8uoJE0jkerDaHxfTHseS31M1pNF7OV3xe4s=
X-Google-Smtp-Source: APXvYqx18+9TYWouF+4cCT1KAMj8Zzdhy8YqKGILwwfJrRQPAlQk3MAbpmKQbgGXEpXBEPCMFAe+q5YqXY1DKL8W66k=
X-Received: by 2002:a92:9ac5:: with SMTP id c66mr18208254ill.232.1581620072485;
 Thu, 13 Feb 2020 10:54:32 -0800 (PST)
MIME-Version: 1.0
References: <20200213132203.23441-1-kraxel@redhat.com> <20200213132203.23441-4-kraxel@redhat.com>
In-Reply-To: <20200213132203.23441-4-kraxel@redhat.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Thu, 13 Feb 2020 10:54:21 -0800
Message-ID: <CAPaKu7TgvBtgPuJaeesCUP4zxDOO=xxtun48P=bT0VBF4-dNFg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] drm/virtio: batch resource creation
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

On Thu, Feb 13, 2020 at 5:22 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Move virtio_gpu_notify() to higher-level functions for
> virtio_gpu_cmd_create_resource(), virtio_gpu_cmd_resource_create_3d()
> and virtio_gpu_cmd_resource_attach_backing().
>
> virtio_gpu_object_create() will batch commands and notify only once when
> creating a resource.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_object.c | 1 +
>  drivers/gpu/drm/virtio/virtgpu_vq.c     | 3 ---
>  2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index 8870ee23ff2b..65d6834d3c74 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -224,6 +224,7 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
>                 return ret;
The virtqueue might become full without ever being notified on errors.
We should notify on errors, or better yet, virtio_gpu_queue_ctrl_sgs
should notify before waiting.


>         }
>
> +       virtio_gpu_notify(vgdev);
>         *bo_ptr = bo;
>         return 0;
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 9d4ca0fafa5f..778b7acf2f7f 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -514,7 +514,6 @@ void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
>         cmd_p->height = cpu_to_le32(params->height);
>
>         virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, fence);
> -       virtio_gpu_notify(vgdev);
>         bo->created = true;
>  }
>
> @@ -643,7 +642,6 @@ virtio_gpu_cmd_resource_attach_backing(struct virtio_gpu_device *vgdev,
>         vbuf->data_size = sizeof(*ents) * nents;
>
>         virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, fence);
> -       virtio_gpu_notify(vgdev);
>  }
>
>  static void virtio_gpu_cmd_get_display_info_cb(struct virtio_gpu_device *vgdev,
> @@ -1010,7 +1008,6 @@ virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_device *vgdev,
>         cmd_p->flags = cpu_to_le32(params->flags);
>
>         virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, fence);
> -       virtio_gpu_notify(vgdev);
>
>         bo->created = true;
>  }
> --
> 2.18.2
>
