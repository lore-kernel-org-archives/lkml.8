Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC32C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E4B206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N3PtefWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgBKLdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 06:33:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27292 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727692AbgBKLdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 06:33:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581420796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D/lzFb6M5bvE9Bs68snP5XHFoC0F0qfAXGRaFYDuNRc=;
        b=N3PtefWPqWtzgC4wcJqvnzhAao2SlS2C54ySjaU6EFRb6J10Lgh6b3L3saXUJDGNIXMmwb
        uOOkM8XkPdANChtWOx8bqoTBxojZP4W3gpagLXQguwLRlVAH0jtJbtSpVhZdACff4P3Ggy
        4ewMC8lXqhxMNs5ba6HWASBHVEKchdg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-1SDjI5SlPAKNqKsHWOTjxw-1; Tue, 11 Feb 2020 06:33:12 -0500
X-MC-Unique: 1SDjI5SlPAKNqKsHWOTjxw-1
Received: by mail-qt1-f199.google.com with SMTP id z11so6435837qts.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 03:33:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D/lzFb6M5bvE9Bs68snP5XHFoC0F0qfAXGRaFYDuNRc=;
        b=LaoizuUQMHU9QJ30/FWXYQUDw2vcVdHa7R0v8ymqzEO5AfwOLMzvepmXCX4DMQTLNY
         pFcJxyQlIUBcKZrLLzoDlszuw32az41tlbs/mCHKFtn0TeMcGFITQ2PvXipMB6iWzPPG
         ZaPdFiBGGe6keX4wVIFpibefZR/jospgT2QZAVKkA6gb8Yo2CFU630yTMxAMv0EWDacT
         bHSTQB88Hcf4KXYJU/tHj6oNZaKGX2VKqLnWd24jkhSdxVXWchVXPwt+Nu7YsrbQvhFE
         UUCVd8+tgCLwEywtsDt+o2/aIFeAYwnieGdkaxcZthqnPDs6VatIO5RriCWSHvS5F3Me
         K/dw==
X-Gm-Message-State: APjAAAU8lcY8IECnl9hALK8qFLYN6gvhABJQCA6QcsFN8fP5pYOd7+o6
        Scn2lTGY5fxTGkxZOodpZfMO7qEXz+LB6Gcbfa90d2gAk2iddpaYZLUxZG5MBvRsWbQkZzTqJzp
        h1nL/OYejz9AkNw1eLWT0QMI+
X-Received: by 2002:ac8:6054:: with SMTP id k20mr1904685qtm.92.1581420791674;
        Tue, 11 Feb 2020 03:33:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqxnbFJLLegfw8YZVCiF3owsNTQHkwgJ4Q/16zX34tV8mdbYlVZwK65AzReMqRXo0mAJsdIpIQ==
X-Received: by 2002:ac8:6054:: with SMTP id k20mr1904661qtm.92.1581420791343;
        Tue, 11 Feb 2020 03:33:11 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id 17sm656443qkh.29.2020.02.11.03.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 03:33:10 -0800 (PST)
Date:   Tue, 11 Feb 2020 06:33:05 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Zha Bin <zhabin@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, jasowang@redhat.com, slp@redhat.com,
        virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
        gerry@linux.alibaba.com, jing2.liu@linux.intel.com,
        chao.p.peng@linux.intel.com
Subject: Re: [PATCH v2 1/5] virtio-mmio: add notify feature for per-queue
Message-ID: <20200211062205-mutt-send-email-mst@kernel.org>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <8a4ea95d6d77a2814aaf6897b5517353289a098e.1581305609.git.zhabin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a4ea95d6d77a2814aaf6897b5517353289a098e.1581305609.git.zhabin@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 05:05:17PM +0800, Zha Bin wrote:
> From: Liu Jiang <gerry@linux.alibaba.com>
> 
> The standard virtio-mmio devices use notification register to signal
> backend. This will cause vmexits and slow down the performance when we
> passthrough the virtio-mmio devices to guest virtual machines.
> We proposed to update virtio over MMIO spec to add the per-queue
> notify feature VIRTIO_F_MMIO_NOTIFICATION[1]. It can allow the VMM to
> configure notify location for each queue.
> 
> [1] https://lkml.org/lkml/2020/1/21/31
> 
> Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
> Co-developed-by: Zha Bin <zhabin@linux.alibaba.com>
> Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
> Co-developed-by: Jing Liu <jing2.liu@linux.intel.com>
> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
> Co-developed-by: Chao Peng <chao.p.peng@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>


Hmm. Any way to make this static so we don't need
base and multiplier?

> ---
>  drivers/virtio/virtio_mmio.c       | 37 +++++++++++++++++++++++++++++++++++--
>  include/uapi/linux/virtio_config.h |  8 +++++++-
>  2 files changed, 42 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 97d5725..1733ab97 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -90,6 +90,9 @@ struct virtio_mmio_device {
>  	/* a list of queues so we can dispatch IRQs */
>  	spinlock_t lock;
>  	struct list_head virtqueues;
> +
> +	unsigned short notify_base;
> +	unsigned short notify_multiplier;
>  };
>  
>  struct virtio_mmio_vq_info {
> @@ -98,6 +101,9 @@ struct virtio_mmio_vq_info {
>  
>  	/* the list node for the virtqueues list */
>  	struct list_head node;
> +
> +	/* Notify Address*/
> +	unsigned int notify_addr;
>  };
>  
>  
> @@ -119,13 +125,23 @@ static u64 vm_get_features(struct virtio_device *vdev)
>  	return features;
>  }
>  
> +static void vm_transport_features(struct virtio_device *vdev, u64 features)
> +{
> +	if (features & BIT_ULL(VIRTIO_F_MMIO_NOTIFICATION))
> +		__virtio_set_bit(vdev, VIRTIO_F_MMIO_NOTIFICATION);
> +}
> +
>  static int vm_finalize_features(struct virtio_device *vdev)
>  {
>  	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> +	u64 features = vdev->features;
>  
>  	/* Give virtio_ring a chance to accept features. */
>  	vring_transport_features(vdev);
>  
> +	/* Give virtio_mmio a chance to accept features. */
> +	vm_transport_features(vdev, features);
> +
>  	/* Make sure there is are no mixed devices */
>  	if (vm_dev->version == 2 &&
>  			!__virtio_test_bit(vdev, VIRTIO_F_VERSION_1)) {
> @@ -272,10 +288,13 @@ static void vm_reset(struct virtio_device *vdev)
>  static bool vm_notify(struct virtqueue *vq)
>  {
>  	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vq->vdev);
> +	struct virtio_mmio_vq_info *info = vq->priv;
>  
> -	/* We write the queue's selector into the notification register to
> +	/* We write the queue's selector into the Notify Address to
>  	 * signal the other end */
> -	writel(vq->index, vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
> +	if (info)
> +		writel(vq->index, vm_dev->base + info->notify_addr);
> +
>  	return true;
>  }
>  
> @@ -434,6 +453,12 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
>  	vq->priv = info;
>  	info->vq = vq;
>  
> +	if (__virtio_test_bit(vdev, VIRTIO_F_MMIO_NOTIFICATION))
> +		info->notify_addr = vm_dev->notify_base +
> +				vm_dev->notify_multiplier * vq->index;
> +	else
> +		info->notify_addr = VIRTIO_MMIO_QUEUE_NOTIFY;
> +
>  	spin_lock_irqsave(&vm_dev->lock, flags);
>  	list_add(&info->node, &vm_dev->virtqueues);
>  	spin_unlock_irqrestore(&vm_dev->lock, flags);
> @@ -471,6 +496,14 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>  		return irq;
>  	}
>  
> +	if (__virtio_test_bit(vdev, VIRTIO_F_MMIO_NOTIFICATION)) {
> +		unsigned int notify = readl(vm_dev->base +
> +				VIRTIO_MMIO_QUEUE_NOTIFY);


that register is documented as:

/* Queue notifier - Write Only */
#define VIRTIO_MMIO_QUEUE_NOTIFY        0x050

so at least you need to update the doc.

> +
> +		vm_dev->notify_base = notify & 0xffff;
> +		vm_dev->notify_multiplier = (notify >> 16) & 0xffff;

are 16 bit base/limit always enough?
In fact won't we be short on 16 bit address space
in a rather short order if queues use up a page
of space at a time?


> +	}
> +
>  	err = request_irq(irq, vm_interrupt, IRQF_SHARED,
>  			dev_name(&vdev->dev), vm_dev);
>  	if (err)
> diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> index ff8e7dc..5d93c01 100644
> --- a/include/uapi/linux/virtio_config.h
> +++ b/include/uapi/linux/virtio_config.h
> @@ -52,7 +52,7 @@
>   * rest are per-device feature bits.
>   */
>  #define VIRTIO_TRANSPORT_F_START	28
> -#define VIRTIO_TRANSPORT_F_END		38
> +#define VIRTIO_TRANSPORT_F_END		40
>  
>  #ifndef VIRTIO_CONFIG_NO_LEGACY
>  /* Do we get callbacks when the ring is completely used, even if we've
> @@ -88,4 +88,10 @@
>   * Does the device support Single Root I/O Virtualization?
>   */
>  #define VIRTIO_F_SR_IOV			37
> +
> +/*
> + * This feature indicates the enhanced notification support on MMIO transport
> + * layer.

Let's replace this with an actual description of the enhancement please
otherwise it will not make sense in a couple of months.

e.g. "Per queue notification address"?


> + */
> +#define VIRTIO_F_MMIO_NOTIFICATION	39
>  #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */
> -- 
> 1.8.3.1

