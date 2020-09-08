Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F1FC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF1932166E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="b6cEBE6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgIHI5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 04:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbgIHI50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:57:26 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABE1C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 01:57:24 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g4so18241268wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 01:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=aLJYrm5bOjZd8IZxBRURG7tcIZly4NiWd1EjKr3Vqfg=;
        b=b6cEBE6njyXvZevcnqFZzEoXBFtDdCvYCkNrDwZNfhuKbJExzPQU7/msU4sYTd9qen
         t7N65xdspMnc5iK2UaZ6awIAJhnUswLYotvlUeI5TKUX2QzHS9UNyOVSGdyB4cwZxZVy
         3sn3/rJhRkWOVW8TWAIcE8fuE9DhfQvgPVt+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=aLJYrm5bOjZd8IZxBRURG7tcIZly4NiWd1EjKr3Vqfg=;
        b=YmsJLQDBR2o1DQMZ6KytI3pNwYbunDxv1eAsYd1iH/q9zalJgd0QT87kiUTKUQIVN0
         8icSljtsmpCo57LuMN3q6euy0Emxi2cO13L+/hsvcDAB/c5smfspwCoX6B969AwRV/Sa
         lV7QHviFSO5R0nLMVhnfjLjHGtBNozOgpNgHfg6C8Isdw2ZSiK0+V8SIAkQCtZYI+Xzy
         eYCeZGKxZckPhemC4CHBRzQzGb4+acvc2M1O7+AJpSpDlYfa5sZegHxvQEmdSl5olKoV
         YQjOVJLQha9HntnYM/6PagNnkeJkxw5yCfWBd3qMBSa38JBKU5MgQfiQnGMLKj+EyT6w
         e3NQ==
X-Gm-Message-State: AOAM531LiyMLVHOfBRMdeTklQ+Mt6HFCRcvLRV7CLPgx1dJppOxwG0/q
        62sTF9evzR9+u5bMm+nzXtMrLg==
X-Google-Smtp-Source: ABdhPJw/Z7glRjkptNRj0qyVEzDSlDhIfCzudDaFL00qxvdRc+SQk3yofJBPi3m6TSbiWuo2ewZk7w==
X-Received: by 2002:a05:6000:83:: with SMTP id m3mr25405078wrx.165.1599555443634;
        Tue, 08 Sep 2020 01:57:23 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id i16sm29552687wrq.73.2020.09.08.01.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 01:57:22 -0700 (PDT)
Date:   Tue, 8 Sep 2020 10:57:21 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/virtio: drop quirks handling
Message-ID: <20200908085721.GJ2352366@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200908064741.1010-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908064741.1010-1-kraxel@redhat.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 08:47:41AM +0200, Gerd Hoffmann wrote:
> These days dma ops can be overridden per device, and the virtio core

"can be overridden" or "are"? The comment above vring_use_dma_api()
suggests that's not yet done. If that's wrong then I think updating the
comment would be really good.
-Daniel

> uses that to handle the dma quirks transparently for the rest of the
> kernel.  So we can drop the virtio_has_dma_quirk() checks, just use
> the dma api unconditionally and depend on the virtio core having setup
> dma_ops as needed.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_object.c | 19 ++++++-------------
>  drivers/gpu/drm/virtio/virtgpu_vq.c     | 16 ++++++----------
>  2 files changed, 12 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index 729f98ad7c02..9c35ce64ff9e 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -141,7 +141,6 @@ static int virtio_gpu_object_shmem_init(struct virtio_gpu_device *vgdev,
>  					struct virtio_gpu_mem_entry **ents,
>  					unsigned int *nents)
>  {
> -	bool use_dma_api = !virtio_has_dma_quirk(vgdev->vdev);
>  	struct virtio_gpu_object_shmem *shmem = to_virtio_gpu_shmem(bo);
>  	struct scatterlist *sg;
>  	int si, ret;
> @@ -162,15 +161,11 @@ static int virtio_gpu_object_shmem_init(struct virtio_gpu_device *vgdev,
>  		return -EINVAL;
>  	}
>  
> -	if (use_dma_api) {
> -		shmem->mapped = dma_map_sg(vgdev->vdev->dev.parent,
> -					   shmem->pages->sgl,
> -					   shmem->pages->nents,
> -					   DMA_TO_DEVICE);
> -		*nents = shmem->mapped;
> -	} else {
> -		*nents = shmem->pages->nents;
> -	}
> +	shmem->mapped = dma_map_sg(vgdev->vdev->dev.parent,
> +				   shmem->pages->sgl,
> +				   shmem->pages->nents,
> +				   DMA_TO_DEVICE);
> +	*nents = shmem->mapped;
>  
>  	*ents = kmalloc_array(*nents, sizeof(struct virtio_gpu_mem_entry),
>  			      GFP_KERNEL);
> @@ -180,9 +175,7 @@ static int virtio_gpu_object_shmem_init(struct virtio_gpu_device *vgdev,
>  	}
>  
>  	for_each_sg(shmem->pages->sgl, sg, *nents, si) {
> -		(*ents)[si].addr = cpu_to_le64(use_dma_api
> -					       ? sg_dma_address(sg)
> -					       : sg_phys(sg));
> +		(*ents)[si].addr = cpu_to_le64(sg_dma_address(sg));
>  		(*ents)[si].length = cpu_to_le32(sg->length);
>  		(*ents)[si].padding = 0;
>  	}
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index c93c2db35aaf..1c1d2834547d 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -599,13 +599,11 @@ void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
>  	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(objs->objs[0]);
>  	struct virtio_gpu_transfer_to_host_2d *cmd_p;
>  	struct virtio_gpu_vbuffer *vbuf;
> -	bool use_dma_api = !virtio_has_dma_quirk(vgdev->vdev);
>  	struct virtio_gpu_object_shmem *shmem = to_virtio_gpu_shmem(bo);
>  
> -	if (use_dma_api)
> -		dma_sync_sg_for_device(vgdev->vdev->dev.parent,
> -				       shmem->pages->sgl, shmem->pages->nents,
> -				       DMA_TO_DEVICE);
> +	dma_sync_sg_for_device(vgdev->vdev->dev.parent,
> +			       shmem->pages->sgl, shmem->pages->nents,
> +			       DMA_TO_DEVICE);
>  
>  	cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
>  	memset(cmd_p, 0, sizeof(*cmd_p));
> @@ -1015,13 +1013,11 @@ void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_gpu_device *vgdev,
>  	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(objs->objs[0]);
>  	struct virtio_gpu_transfer_host_3d *cmd_p;
>  	struct virtio_gpu_vbuffer *vbuf;
> -	bool use_dma_api = !virtio_has_dma_quirk(vgdev->vdev);
>  	struct virtio_gpu_object_shmem *shmem = to_virtio_gpu_shmem(bo);
>  
> -	if (use_dma_api)
> -		dma_sync_sg_for_device(vgdev->vdev->dev.parent,
> -				       shmem->pages->sgl, shmem->pages->nents,
> -				       DMA_TO_DEVICE);
> +	dma_sync_sg_for_device(vgdev->vdev->dev.parent,
> +			       shmem->pages->sgl, shmem->pages->nents,
> +			       DMA_TO_DEVICE);
>  
>  	cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
>  	memset(cmd_p, 0, sizeof(*cmd_p));
> -- 
> 2.27.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
