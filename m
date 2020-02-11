Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43937C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC81206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHYdZUbG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgBKKvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 05:51:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54810 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727805AbgBKKvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 05:51:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581418259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/iLP8nxdeVUUa3yiebMO4DQs1+XlpJFvaeRCJgzXnAQ=;
        b=SHYdZUbGfL/7TjFkzK5yuBjG8hlAosGBGIdphE+hW2oYZUA3lDLyzazY3h134tDaHSKZzH
        Fadj91bzdyYEir4Ta4831aocv21RX1pJ+tS8zggctAD8Q9eaPhTvslYPC8a2C8+RgbcbUQ
        1RdUOJzuFg9R79F0UhczCRMyQMYX1wg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-dwxbOlnCPnWMO7_h27WNpg-1; Tue, 11 Feb 2020 05:50:54 -0500
X-MC-Unique: dwxbOlnCPnWMO7_h27WNpg-1
Received: by mail-qt1-f200.google.com with SMTP id o24so6296872qtr.17
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 02:50:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/iLP8nxdeVUUa3yiebMO4DQs1+XlpJFvaeRCJgzXnAQ=;
        b=k79AO/cv6X55iTWKtVzBaUmEXh/Bj4dfX6s1x/fMBMTJThGQtOMuN2fSmyjiPBYxcp
         2bN0lPuqdaieJUSMh7GrA2mAuit9Aw9aJaIAnxmuR1+dZK/hSPOamtBx1Og0O131Bee3
         Z5O2wi38eklNxNzF/4C94X0u4yagirtL3QtVbgI0763LyMMPN8hi/82rcjpcmppQrj8Y
         1NcvVK/d9Vmu8m+LhjtQfEcHnsxqot5gPz9qmrHvnvrdIvE4fymvkmCowTmQ10xcdIYP
         5lidx8uthBwZoBAce2lEqD3rPzEOG8PnEkn6EPzLPoVTV0i3cMUT0irm/j0c5u4bm7JV
         u2Lw==
X-Gm-Message-State: APjAAAXEfVtLnOizjwimMPsFUW13e4rcxxrZumKNkKwQttoRtD4MjR1f
        rTZndzOAZzePgpiemcVmFwFj66xA4YRkc2/quvGZoDgWGvZcCIeMWgPfJFmlSDiO/6J0PMfKPWB
        QSJufRd5Y46fR34Ex9QWsQSMB
X-Received: by 2002:ac8:550a:: with SMTP id j10mr1819794qtq.354.1581418253802;
        Tue, 11 Feb 2020 02:50:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqwkgcXnwef+vhl2XRhORS0wKZ4ojU5xtH4JsCht8mQ+VoGfbP5I4GLMangUp9jnNLyc+Yf1hw==
X-Received: by 2002:ac8:550a:: with SMTP id j10mr1819774qtq.354.1581418253474;
        Tue, 11 Feb 2020 02:50:53 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id r1sm1921438qtu.83.2020.02.11.02.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 02:50:52 -0800 (PST)
Date:   Tue, 11 Feb 2020 05:50:48 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Zha Bin <zhabin@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, jasowang@redhat.com, slp@redhat.com,
        virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
        gerry@linux.alibaba.com, jing2.liu@linux.intel.com,
        chao.p.peng@linux.intel.com
Subject: Re: [PATCH v2 1/5] virtio-mmio: add notify feature for per-queue
Message-ID: <20200211055005-mutt-send-email-mst@kernel.org>
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

So this is for pass-through for nested virt?
OK but let's split this out please, and benchmark separately.


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
> +
> +		vm_dev->notify_base = notify & 0xffff;
> +		vm_dev->notify_multiplier = (notify >> 16) & 0xffff;
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
> + */
> +#define VIRTIO_F_MMIO_NOTIFICATION	39
>  #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */
> -- 
> 1.8.3.1

