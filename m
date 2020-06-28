Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60B9C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 06:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B193020775
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 06:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDnJywNS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgF1GVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 02:21:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46082 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725936AbgF1GVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 02:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593325308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ydPGKU0wBmZmxp53ZfzQQ4RSolY15yJxARcJFXOo5Tg=;
        b=WDnJywNSnb51g8rP0+UmUw9JZtjVi5JT3SPFz3YL3X33bM0tUcS0v2zMvEGfixWAPOYunY
        w7zvpS8MPxkWl0m/CegUfMr8yE1tjjq6/oqffllF9Y4ceaFtqJaY6vstkw1Z1Hzknm+BOY
        f8y2gjd10fNsk8vgLMndsDWhKeNrhsc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-jrplHYykOrKSTXxU9WOO0w-1; Sun, 28 Jun 2020 02:21:41 -0400
X-MC-Unique: jrplHYykOrKSTXxU9WOO0w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0F378015F5;
        Sun, 28 Jun 2020 06:21:40 +0000 (UTC)
Received: from [10.72.13.164] (ovpn-13-164.pek2.redhat.com [10.72.13.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 286C0121B12;
        Sun, 28 Jun 2020 06:21:20 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] virtio: virtio_has_iommu_quirk ->
 virtio_has_dma_quirk
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
References: <20200624232035.704217-1-mst@redhat.com>
 <20200624232035.704217-3-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <95941961-1c75-e2a5-d49b-7d7e204b7a41@redhat.com>
Date:   Sun, 28 Jun 2020 14:21:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624232035.704217-3-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/6/25 上午7:21, Michael S. Tsirkin wrote:
> Now that the corresponding feature bit has been renamed,
> rename the quirk too - it's about special ways to
> do DMA, not necessarily about the IOMMU.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   drivers/gpu/drm/virtio/virtgpu_object.c | 2 +-
>   drivers/gpu/drm/virtio/virtgpu_vq.c     | 4 ++--
>   drivers/virtio/virtio_ring.c            | 2 +-
>   include/linux/virtio_config.h           | 4 ++--
>   tools/virtio/linux/virtio_config.h      | 4 ++--
>   5 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index 6ccbd01cd888..e8799ab0c753 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -141,7 +141,7 @@ static int virtio_gpu_object_shmem_init(struct virtio_gpu_device *vgdev,
>   					struct virtio_gpu_mem_entry **ents,
>   					unsigned int *nents)
>   {
> -	bool use_dma_api = !virtio_has_iommu_quirk(vgdev->vdev);
> +	bool use_dma_api = !virtio_has_dma_quirk(vgdev->vdev);
>   	struct virtio_gpu_object_shmem *shmem = to_virtio_gpu_shmem(bo);
>   	struct scatterlist *sg;
>   	int si, ret;
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 9e663a5d9952..53af60d484a4 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -599,7 +599,7 @@ void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
>   	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(objs->objs[0]);
>   	struct virtio_gpu_transfer_to_host_2d *cmd_p;
>   	struct virtio_gpu_vbuffer *vbuf;
> -	bool use_dma_api = !virtio_has_iommu_quirk(vgdev->vdev);
> +	bool use_dma_api = !virtio_has_dma_quirk(vgdev->vdev);
>   	struct virtio_gpu_object_shmem *shmem = to_virtio_gpu_shmem(bo);
>   
>   	if (use_dma_api)
> @@ -1015,7 +1015,7 @@ void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_gpu_device *vgdev,
>   	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(objs->objs[0]);
>   	struct virtio_gpu_transfer_host_3d *cmd_p;
>   	struct virtio_gpu_vbuffer *vbuf;
> -	bool use_dma_api = !virtio_has_iommu_quirk(vgdev->vdev);
> +	bool use_dma_api = !virtio_has_dma_quirk(vgdev->vdev);
>   	struct virtio_gpu_object_shmem *shmem = to_virtio_gpu_shmem(bo);
>   
>   	if (use_dma_api)
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index a1a5c2a91426..34253cb69cb8 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -240,7 +240,7 @@ static inline bool virtqueue_use_indirect(struct virtqueue *_vq,
>   
>   static bool vring_use_dma_api(struct virtio_device *vdev)
>   {
> -	if (!virtio_has_iommu_quirk(vdev))
> +	if (!virtio_has_dma_quirk(vdev))
>   		return true;
>   
>   	/* Otherwise, we are left to guess. */
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index f2cc2a0df174..3b4eae5ac5e3 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -162,10 +162,10 @@ static inline bool virtio_has_feature(const struct virtio_device *vdev,
>   }
>   
>   /**
> - * virtio_has_iommu_quirk - determine whether this device has the iommu quirk
> + * virtio_has_dma_quirk - determine whether this device has the DMA quirk
>    * @vdev: the device
>    */
> -static inline bool virtio_has_iommu_quirk(const struct virtio_device *vdev)
> +static inline bool virtio_has_dma_quirk(const struct virtio_device *vdev)
>   {
>   	/*
>   	 * Note the reverse polarity of the quirk feature (compared to most
> diff --git a/tools/virtio/linux/virtio_config.h b/tools/virtio/linux/virtio_config.h
> index f99ae42668e0..f2640e505c4e 100644
> --- a/tools/virtio/linux/virtio_config.h
> +++ b/tools/virtio/linux/virtio_config.h
> @@ -42,10 +42,10 @@ static inline void __virtio_clear_bit(struct virtio_device *vdev,
>   	(__virtio_test_bit((dev), feature))
>   
>   /**
> - * virtio_has_iommu_quirk - determine whether this device has the iommu quirk
> + * virtio_has_dma_quirk - determine whether this device has the DMA quirk
>    * @vdev: the device
>    */
> -static inline bool virtio_has_iommu_quirk(const struct virtio_device *vdev)
> +static inline bool virtio_has_dma_quirk(const struct virtio_device *vdev)
>   {
>   	/*
>   	 * Note the reverse polarity of the quirk feature (compared to most


Acked-by: Jason Wang <jasowang@redhat.com>


