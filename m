Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21525C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5E820675
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGAcS8aC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgBKLLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 06:11:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45659 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727653AbgBKLL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 06:11:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581419487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JqF8Ppmv4SVYCOraksqiLD9VNLkvELB1UHG3uXGTGKU=;
        b=CGAcS8aCbfubly5euiZq+JFoGcfJvCDmmphNkz5wyvQMC89C7eY6cyZaC6k3uG+s9pQpfe
        SWXUlhagIHEHHHjKCtBvCc069v6pWa6ZAT5h4moPB9HcQCY9WDDzi6mHXcEiCtacBFFTvy
        Qcrk3oKbI+3ffCnTaaL1Ymti8q3N/6Y=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-R3MrhJn-On-impC71fmwbw-1; Tue, 11 Feb 2020 06:11:24 -0500
X-MC-Unique: R3MrhJn-On-impC71fmwbw-1
Received: by mail-qt1-f197.google.com with SMTP id g26so6329538qts.16
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 03:11:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JqF8Ppmv4SVYCOraksqiLD9VNLkvELB1UHG3uXGTGKU=;
        b=fgyWgxl1sC9IEyJ5054WI3BNRohoZ3QRS+OIaVxP49lnM0KHdau2WGWSsDmqQDd8q/
         wyP++FG1mxrgrLRmUvH2suV9v7Rm18ZN70fTeQC7bpMlDJNAYuLaDKCX7p9YGBdZXOZ/
         3FPvIHdIlDtYL7u8Dy/IMwIcnOIJzltXZDHq1l48ytfTPm/RDFsT0U/L/9ZqXiHR/Udv
         bzOaV8jI4Nd8vOC/Mz/gA4438H2R2JbXU+GbXdF6ieMFdJ/aLmwN3c6LZut5StgV26KU
         +eW8CERHnVCUiK9M1pX99Avjce/2+B47ag0Gn8iMtcbcJXQTQoQEBfOL4WhImm5xL5tW
         uvYA==
X-Gm-Message-State: APjAAAVS2v/ALe3Ks8OiVBQvlX/vFYf5mR6g5qrTF4oD/UPkmpB0ovfC
        ohJUdb1LHxy5t05Hd0fN7OfQyC0XKxRx5LgOjnhAPpbjGWcqnfj5SlJlsyXLtfKXQ7Ad/fGzQ0s
        uViNYbxh7t4upSXwNQ9WmZz1w
X-Received: by 2002:ae9:e702:: with SMTP id m2mr5493552qka.208.1581419483353;
        Tue, 11 Feb 2020 03:11:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqxjoTFzWOJ2JSmppraBVja2HHkB1Q5H2SJChCkqmlvXq0eUhFFK1JiTc64fbhF2zSlvA1cAEg==
X-Received: by 2002:ae9:e702:: with SMTP id m2mr5493493qka.208.1581419482696;
        Tue, 11 Feb 2020 03:11:22 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id y21sm1888758qto.15.2020.02.11.03.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 03:11:21 -0800 (PST)
Date:   Tue, 11 Feb 2020 06:11:16 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Zha Bin <zhabin@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, jasowang@redhat.com, slp@redhat.com,
        virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
        gerry@linux.alibaba.com, jing2.liu@linux.intel.com,
        chao.p.peng@linux.intel.com
Subject: Re: [PATCH v2 4/5] virtio-mmio: add MSI interrupt feature support
Message-ID: <20200211055738-mutt-send-email-mst@kernel.org>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <4c3d13be5a391b1fc50416838de57d903cbf8038.1581305609.git.zhabin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c3d13be5a391b1fc50416838de57d903cbf8038.1581305609.git.zhabin@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 05:05:20PM +0800, Zha Bin wrote:
> From: Liu Jiang <gerry@linux.alibaba.com>
> 
> Userspace VMMs (e.g. Qemu microvm, Firecracker) take advantage of using
> virtio over mmio devices as a lightweight machine model for modern
> cloud. The standard virtio over MMIO transport layer only supports one
> legacy interrupt, which is much heavier than virtio over PCI transport
> layer using MSI. Legacy interrupt has long work path and causes specific
> VMExits in following cases, which would considerably slow down the
> performance:
> 
> 1) read interrupt status register
> 2) update interrupt status register
> 3) write IOAPIC EOI register
> 
> We proposed to add MSI support for virtio over MMIO via new feature
> bit VIRTIO_F_MMIO_MSI[1] which increases the interrupt performance.
> 
> With the VIRTIO_F_MMIO_MSI feature bit supported, the virtio-mmio MSI
> uses msi_sharing[1] to indicate the event and vector mapping.
> Bit 1 is 0: device uses non-sharing and fixed vector per event mapping.
> Bit 1 is 1: device uses sharing mode and dynamic mapping.
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
> ---
>  drivers/virtio/virtio_mmio.c        | 299 ++++++++++++++++++++++++++++++++++--
>  drivers/virtio/virtio_mmio_common.h |   8 +
>  drivers/virtio/virtio_mmio_msi.h    |  82 ++++++++++
>  include/uapi/linux/virtio_config.h  |   7 +-
>  include/uapi/linux/virtio_mmio.h    |  31 ++++
>  5 files changed, 411 insertions(+), 16 deletions(-)

So that's > 100 exatra lines in headers that you for some reason
don't count when comparing code size :).


I think an effort can be made to reduce the complexity here.
Otherwise you will end up with a clone of PCI
sooner than you think. In fact, disabling all legacy:

$ wc -l drivers/virtio/virtio_pci_modern.c
734 drivers/virtio/virtio_pci_modern.c
$ wc -l drivers/virtio/virtio_pci_common.c
635 drivers/virtio/virtio_pci_common.c

So you have almost matched that with your patch.


> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 41e1c93..b24ce21 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -67,8 +67,7 @@
>  #include <uapi/linux/virtio_mmio.h>
>  #include <linux/virtio_ring.h>
>  #include "virtio_mmio_common.h"
> -
> -
> +#include "virtio_mmio_msi.h"
>  
>  /* The alignment to use between consumer and producer parts of vring.
>   * Currently hardcoded to the page size. */
> @@ -85,9 +84,13 @@ struct virtio_mmio_vq_info {
>  
>  	/* Notify Address*/
>  	unsigned int notify_addr;
> -};
>  
> +	/* MSI vector (or none) */
> +	unsigned int msi_vector;
> +};
>  
> +static void vm_free_msi_irqs(struct virtio_device *vdev);
> +static int vm_request_msi_vectors(struct virtio_device *vdev, int nirqs);
>  
>  /* Configuration interface */
>  
> @@ -110,6 +113,9 @@ static void vm_transport_features(struct virtio_device *vdev, u64 features)
>  {
>  	if (features & BIT_ULL(VIRTIO_F_MMIO_NOTIFICATION))
>  		__virtio_set_bit(vdev, VIRTIO_F_MMIO_NOTIFICATION);
> +
> +	if (features & BIT_ULL(VIRTIO_F_MMIO_MSI))
> +		__virtio_set_bit(vdev, VIRTIO_F_MMIO_MSI);
>  }
>  
>  static int vm_finalize_features(struct virtio_device *vdev)
> @@ -307,7 +313,33 @@ static irqreturn_t vm_interrupt(int irq, void *opaque)
>  	return ret;
>  }
>  
> +static irqreturn_t vm_vring_interrupt(int irq, void *opaque)
> +{
> +	struct virtio_mmio_device *vm_dev = opaque;
> +	struct virtio_mmio_vq_info *info;
> +	irqreturn_t ret = IRQ_NONE;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&vm_dev->lock, flags);
> +	list_for_each_entry(info, &vm_dev->virtqueues, node) {
> +		if (vring_interrupt(irq, info->vq) == IRQ_HANDLED)
> +			ret = IRQ_HANDLED;
> +	}
> +	spin_unlock_irqrestore(&vm_dev->lock, flags);
> +
> +	return ret;
> +}
> +
> +
> +/* Handle a configuration change */
> +static irqreturn_t vm_config_changed(int irq, void *opaque)
> +{
> +	struct virtio_mmio_device *vm_dev = opaque;
> +
> +	virtio_config_changed(&vm_dev->vdev);
>  
> +	return IRQ_HANDLED;
> +}
>  
>  static void vm_del_vq(struct virtqueue *vq)
>  {
> @@ -316,6 +348,15 @@ static void vm_del_vq(struct virtqueue *vq)
>  	unsigned long flags;
>  	unsigned int index = vq->index;
>  
> +	if (vm_dev->msi_enabled && !vm_dev->msi_share) {
> +		if (info->msi_vector != VIRTIO_MMIO_MSI_NO_VECTOR) {
> +			int irq = mmio_msi_irq_vector(&vq->vdev->dev,
> +					info->msi_vector);
> +
> +			free_irq(irq, vq);
> +		}
> +	}
> +
>  	spin_lock_irqsave(&vm_dev->lock, flags);
>  	list_del(&info->node);
>  	spin_unlock_irqrestore(&vm_dev->lock, flags);
> @@ -334,20 +375,56 @@ static void vm_del_vq(struct virtqueue *vq)
>  	kfree(info);
>  }
>  
> -static void vm_del_vqs(struct virtio_device *vdev)
> +static void vm_free_irqs(struct virtio_device *vdev)
>  {
>  	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> +
> +	if (vm_dev->msi_enabled)
> +		vm_free_msi_irqs(vdev);
> +	else
> +		free_irq(platform_get_irq(vm_dev->pdev, 0), vm_dev);
> +}
> +
> +static void vm_del_vqs(struct virtio_device *vdev)
> +{
>  	struct virtqueue *vq, *n;
>  
>  	list_for_each_entry_safe(vq, n, &vdev->vqs, list)
>  		vm_del_vq(vq);
>  
> -	free_irq(platform_get_irq(vm_dev->pdev, 0), vm_dev);
> +	vm_free_irqs(vdev);
> +}
> +
> +static inline void mmio_msi_set_enable(struct virtio_mmio_device *vm_dev,
> +					int enable)
> +{
> +	u32 state;
> +
> +	state = readl(vm_dev->base + VIRTIO_MMIO_MSI_STATE);
> +	if (enable && (state & VIRTIO_MMIO_MSI_ENABLED_MASK))
> +		return;
> +
> +	writel(VIRTIO_MMIO_MSI_CMD_ENABLE,
> +		vm_dev->base + VIRTIO_MMIO_MSI_COMMAND);
> +}
> +
> +static void mmio_msi_config_vector(struct virtio_mmio_device *vm_dev, u32 vec)
> +{
> +	writel(vec, vm_dev->base + VIRTIO_MMIO_MSI_VEC_SEL);
> +	writel(VIRTIO_MMIO_MSI_CMD_MAP_CONFIG, vm_dev->base +
> +			VIRTIO_MMIO_MSI_COMMAND);
> +}
> +
> +static void mmio_msi_queue_vector(struct virtio_mmio_device *vm_dev, u32 vec)
> +{
> +	writel(vec, vm_dev->base + VIRTIO_MMIO_MSI_VEC_SEL);
> +	writel(VIRTIO_MMIO_MSI_CMD_MAP_QUEUE, vm_dev->base +
> +			VIRTIO_MMIO_MSI_COMMAND);
>  }
>  
>  static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
>  				  void (*callback)(struct virtqueue *vq),
> -				  const char *name, bool ctx)
> +				  const char *name, bool ctx, u32 msi_vector)
>  {
>  	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
>  	struct virtio_mmio_vq_info *info;
> @@ -440,6 +517,11 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
>  	else
>  		info->notify_addr = VIRTIO_MMIO_QUEUE_NOTIFY;
>  
> +	info->msi_vector = msi_vector;
> +	/* Set queue event and vector mapping for MSI share mode. */
> +	if (vm_dev->msi_share && msi_vector != VIRTIO_MMIO_MSI_NO_VECTOR)
> +		mmio_msi_queue_vector(vm_dev, msi_vector);
> +
>  	spin_lock_irqsave(&vm_dev->lock, flags);
>  	list_add(&info->node, &vm_dev->virtqueues);
>  	spin_unlock_irqrestore(&vm_dev->lock, flags);
> @@ -461,12 +543,11 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
>  	return ERR_PTR(err);
>  }
>  
> -static int vm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
> -		       struct virtqueue *vqs[],
> -		       vq_callback_t *callbacks[],
> -		       const char * const names[],
> -		       const bool *ctx,
> -		       struct irq_affinity *desc)
> +static int vm_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
> +			struct virtqueue *vqs[],
> +			vq_callback_t *callbacks[],
> +			const char * const names[],
> +			const bool *ctx)
>  {
>  	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
>  	int irq = platform_get_irq(vm_dev->pdev, 0);
> @@ -487,8 +568,6 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>  
>  	err = request_irq(irq, vm_interrupt, IRQF_SHARED,
>  			dev_name(&vdev->dev), vm_dev);
> -	if (err)
> -		return err;
>  
>  	for (i = 0; i < nvqs; ++i) {
>  		if (!names[i]) {
> @@ -497,14 +576,202 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>  		}
>  
>  		vqs[i] = vm_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
> -				     ctx ? ctx[i] : false);
> +				     ctx ? ctx[i] : false,
> +				     VIRTIO_MMIO_MSI_NO_VECTOR);
>  		if (IS_ERR(vqs[i])) {
>  			vm_del_vqs(vdev);
>  			return PTR_ERR(vqs[i]);
>  		}
>  	}
>  
> +	return err;
> +}
> +
> +static int vm_find_vqs_msi(struct virtio_device *vdev, unsigned int nvqs,
> +			struct virtqueue *vqs[], vq_callback_t *callbacks[],
> +			const char * const names[], bool per_vq_vectors,
> +			const bool *ctx, struct irq_affinity *desc)
> +{
> +	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> +	int i, err, allocated_vectors, nvectors;
> +	u32 msi_vec;
> +	u32 max_vec_num = readl(vm_dev->base + VIRTIO_MMIO_MSI_VEC_NUM);
> +
> +	/* For MSI non-sharing, the max vector number MUST greater than nvqs.
> +	 * Otherwise, go back to legacy interrupt.
> +	 */
> +	if (per_vq_vectors && max_vec_num < (nvqs + 1))
> +		return -EINVAL;
> +
> +	if (per_vq_vectors) {
> +		nvectors = 1;
> +		for (i = 0; i < nvqs; ++i)
> +			if (callbacks[i])
> +				++nvectors;
> +	} else {
> +		nvectors = 2;
> +	}
> +
> +	vm_dev->msi_share = !per_vq_vectors;
> +
> +	/* Allocate nvqs irqs for queues and one irq for configuration */
> +	err = vm_request_msi_vectors(vdev, nvectors);
> +	if (err != 0)
> +		return err;
> +
> +	allocated_vectors = vm_dev->msi_used_vectors;
> +	for (i = 0; i < nvqs; i++) {
> +		if (!names[i]) {
> +			vqs[i] = NULL;
> +			continue;
> +		}
> +		if (!callbacks[i])
> +			msi_vec = VIRTIO_MMIO_MSI_NO_VECTOR;
> +		else if (per_vq_vectors)
> +			msi_vec = allocated_vectors++;
> +		else
> +			msi_vec = 1;
> +		vqs[i] = vm_setup_vq(vdev, i, callbacks[i], names[i],
> +				ctx ? ctx[i] : false, msi_vec);
> +		if (IS_ERR(vqs[i])) {
> +			err = PTR_ERR(vqs[i]);
> +			goto error_find;
> +		}
> +
> +		if (!per_vq_vectors ||
> +				msi_vec == VIRTIO_MMIO_MSI_NO_VECTOR)
> +			continue;
> +
> +		/* allocate per-vq irq if available and necessary */
> +		snprintf(vm_dev->vm_vq_names[msi_vec],
> +			sizeof(*vm_dev->vm_vq_names),
> +			"%s-%s",
> +			dev_name(&vm_dev->vdev.dev), names[i]);
> +		err = request_irq(mmio_msi_irq_vector(&vqs[i]->vdev->dev,
> +					msi_vec),
> +				vring_interrupt, 0,
> +				vm_dev->vm_vq_names[msi_vec], vqs[i]);
> +
> +		if (err)
> +			goto error_find;
> +	}
> +
>  	return 0;
> +
> +error_find:
> +	vm_del_vqs(vdev);
> +	return err;
> +}
> +
> +static int vm_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
> +		       struct virtqueue *vqs[],
> +		       vq_callback_t *callbacks[],
> +		       const char * const names[],
> +		       const bool *ctx,
> +		       struct irq_affinity *desc)
> +{
> +	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> +	int err;
> +
> +	if (__virtio_test_bit(vdev, VIRTIO_F_MMIO_NOTIFICATION)) {
> +		unsigned int notify = readl(vm_dev->base +
> +				VIRTIO_MMIO_QUEUE_NOTIFY);
> +
> +		vm_dev->notify_base = notify & 0xffff;
> +		vm_dev->notify_multiplier = (notify >> 16) & 0xffff;
> +	}
> +
> +	if (__virtio_test_bit(vdev, VIRTIO_F_MMIO_MSI)) {
> +		bool dyn_mapping = !!(readl(vm_dev->base +
> +					VIRTIO_MMIO_MSI_STATE) &
> +				VIRTIO_MMIO_MSI_SHARING_MASK);
> +		if (!dyn_mapping)
> +			err = vm_find_vqs_msi(vdev, nvqs, vqs, callbacks,
> +				names, true, ctx, desc);
> +		else
> +			err = vm_find_vqs_msi(vdev, nvqs, vqs, callbacks,
> +				names, false, ctx, desc);
> +		if (!err)
> +			return 0;
> +	}
> +
> +	return vm_find_vqs_intx(vdev, nvqs, vqs, callbacks, names, ctx);
> +}
> +
> +static int vm_request_msi_vectors(struct virtio_device *vdev, int nirqs)
> +{
> +	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> +	unsigned int v;
> +	int irq, err;
> +
> +	if (vm_dev->msi_enabled)
> +		return -EINVAL;
> +
> +	vm_dev->vm_vq_names = kmalloc_array(nirqs, sizeof(*vm_dev->vm_vq_names),
> +					GFP_KERNEL);
> +	if (!vm_dev->vm_vq_names)
> +		return -ENOMEM;
> +
> +	mmio_get_msi_domain(vdev);
> +	err = mmio_msi_domain_alloc_irqs(&vdev->dev, nirqs);
> +	if (err) {
> +		kfree(vm_dev->vm_vq_names);
> +		vm_dev->vm_vq_names = NULL;
> +		return err;
> +	}
> +
> +	mmio_msi_set_enable(vm_dev, 1);
> +	vm_dev->msi_enabled = true;
> +
> +	v = vm_dev->msi_used_vectors;
> +	/* The first MSI vector is used for configuration change event. */
> +	snprintf(vm_dev->vm_vq_names[v], sizeof(*vm_dev->vm_vq_names),
> +			"%s-config", dev_name(&vdev->dev));
> +	irq = mmio_msi_irq_vector(&vdev->dev, v);
> +	err = request_irq(irq, vm_config_changed, 0, vm_dev->vm_vq_names[v],
> +			vm_dev);
> +	if (err)
> +		goto error_request_irq;
> +
> +	/* Set the configuration event mapping. */
> +	if (vm_dev->msi_share)
> +		mmio_msi_config_vector(vm_dev, v);
> +
> +	++vm_dev->msi_used_vectors;
> +
> +	if (vm_dev->msi_share) {
> +		v = vm_dev->msi_used_vectors;
> +		snprintf(vm_dev->vm_vq_names[v], sizeof(*vm_dev->vm_vq_names),
> +			 "%s-virtqueues", dev_name(&vm_dev->vdev.dev));
> +		err = request_irq(mmio_msi_irq_vector(&vdev->dev, v),
> +				  vm_vring_interrupt, 0, vm_dev->vm_vq_names[v],
> +				  vm_dev);
> +		if (err)
> +			goto error_request_irq;
> +		++vm_dev->msi_used_vectors;
> +	}
> +
> +	return 0;
> +
> +error_request_irq:
> +	vm_free_msi_irqs(vdev);
> +
> +	return err;
> +}
> +
> +static void vm_free_msi_irqs(struct virtio_device *vdev)
> +{
> +	int i;
> +	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> +
> +	mmio_msi_set_enable(vm_dev, 0);
> +	for (i = 0; i < vm_dev->msi_used_vectors; i++)
> +		free_irq(mmio_msi_irq_vector(&vdev->dev, i), vm_dev);
> +	mmio_msi_domain_free_irqs(&vdev->dev);
> +	kfree(vm_dev->vm_vq_names);
> +	vm_dev->vm_vq_names = NULL;
> +	vm_dev->msi_enabled = false;
> +	vm_dev->msi_used_vectors = 0;
>  }
>  
>  static const char *vm_bus_name(struct virtio_device *vdev)
> @@ -609,6 +876,8 @@ static int virtio_mmio_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, vm_dev);
>  
> +	mmio_msi_create_irq_domain();
> +
>  	rc = register_virtio_device(&vm_dev->vdev);
>  	if (rc)
>  		put_device(&vm_dev->vdev.dev);
> diff --git a/drivers/virtio/virtio_mmio_common.h b/drivers/virtio/virtio_mmio_common.h
> index 90cb304..ccf6320 100644
> --- a/drivers/virtio/virtio_mmio_common.h
> +++ b/drivers/virtio/virtio_mmio_common.h
> @@ -26,6 +26,14 @@ struct virtio_mmio_device {
>  
>  	unsigned short notify_base;
>  	unsigned short notify_multiplier;
> +
> +	/* Name strings for interrupts. This size should be enough. */
> +	char (*vm_vq_names)[256];
> +
> +	/* used vectors */
> +	unsigned int msi_used_vectors;
> +	bool msi_share;
> +	bool msi_enabled;
>  };
>  
>  #endif
> diff --git a/drivers/virtio/virtio_mmio_msi.h b/drivers/virtio/virtio_mmio_msi.h
> index 27cb2af..10038cb 100644
> --- a/drivers/virtio/virtio_mmio_msi.h
> +++ b/drivers/virtio/virtio_mmio_msi.h
> @@ -8,6 +8,7 @@
>  #include <linux/irq.h>
>  #include <linux/irqdomain.h>
>  #include <linux/platform_device.h>
> +#include "virtio_mmio_common.h"
>  
>  static irq_hw_number_t mmio_msi_hwirq;
>  static struct irq_domain *mmio_msi_domain;
> @@ -21,12 +22,41 @@ void __weak irq_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
>  {
>  }
>  
> +static void __iomem *vm_dev_base(struct msi_desc *desc)
> +{
> +	if (desc) {
> +		struct device *dev = desc->dev;
> +		struct virtio_device *vdev = dev_to_virtio(dev);
> +		struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> +
> +		return vm_dev->base;
> +	}
> +
> +	return NULL;
> +}
> +
> +static void mmio_msi_set_mask_bit(struct irq_data *data, u32 flag)
> +{
> +	struct msi_desc *desc = irq_data_get_msi_desc(data);
> +	void __iomem *base = vm_dev_base(desc);
> +	unsigned int offset = data->irq - desc->irq;
> +
> +	if (base) {
> +		u32 op = flag ? VIRTIO_MMIO_MSI_CMD_MASK :
> +			VIRTIO_MMIO_MSI_CMD_UNMASK;
> +		writel(offset, base + VIRTIO_MMIO_MSI_VEC_SEL);
> +		writel(op, base + VIRTIO_MMIO_MSI_COMMAND);
> +	}
> +}
> +
>  static void mmio_msi_mask_irq(struct irq_data *data)
>  {
> +	mmio_msi_set_mask_bit(data, 1);
>  }
>  
>  static void mmio_msi_unmask_irq(struct irq_data *data)
>  {
> +	mmio_msi_set_mask_bit(data, 0);
>  }
>  
>  static struct irq_chip mmio_msi_controller = {
> @@ -86,8 +116,60 @@ static inline void mmio_msi_create_irq_domain(void)
>  		irq_domain_free_fwnode(fn);
>  	}
>  }
> +
> +static void mmio_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> +{
> +	void __iomem *base = vm_dev_base(desc);
> +
> +	if (base) {
> +		writel(desc->platform.msi_index, base +
> +				VIRTIO_MMIO_MSI_VEC_SEL);
> +		writel(msg->address_lo, base + VIRTIO_MMIO_MSI_ADDRESS_LOW);
> +		writel(msg->address_hi, base + VIRTIO_MMIO_MSI_ADDRESS_HIGH);
> +		writel(msg->data, base + VIRTIO_MMIO_MSI_DATA);
> +		writel(VIRTIO_MMIO_MSI_CMD_CONFIGURE,
> +			base + VIRTIO_MMIO_MSI_COMMAND);
> +	}
> +}
> +
> +static inline int mmio_msi_domain_alloc_irqs(struct device *dev,
> +				unsigned int nvec)
> +{
> +	return platform_msi_domain_alloc_irqs(dev, nvec,
> +			mmio_write_msi_msg);
> +}
> +
> +static inline void mmio_msi_domain_free_irqs(struct device *dev)
> +{
> +	return platform_msi_domain_free_irqs(dev);
> +}
> +
> +static inline void mmio_get_msi_domain(struct virtio_device *vdev)
> +{
> +	if (!vdev->dev.msi_domain)
> +		vdev->dev.msi_domain = mmio_msi_domain;
> +}
> +
> +static inline int mmio_msi_irq_vector(struct device *dev, unsigned int nr)
> +{
> +	struct msi_desc *entry = first_msi_entry(dev);
> +
> +	return entry->irq + nr;
> +}
> +
>  #else
>  static inline void mmio_msi_create_irq_domain(void) {}
> +static inline int mmio_msi_irq_vector(struct device *dev, unsigned int nr)
> +{
> +	return -EINVAL;
> +}
> +static inline void mmio_get_msi_domain(struct virtio_device *vdev) {}
> +static inline int mmio_msi_domain_alloc_irqs(struct device *dev,
> +				unsigned int nvec)
> +{
> +	return -EINVAL;
> +}
> +static inline void mmio_msi_domain_free_irqs(struct device *dev) {}
>  #endif
>  
>  #endif
> diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
> index 5d93c01..5eb3900 100644
> --- a/include/uapi/linux/virtio_config.h
> +++ b/include/uapi/linux/virtio_config.h
> @@ -52,7 +52,7 @@
>   * rest are per-device feature bits.
>   */
>  #define VIRTIO_TRANSPORT_F_START	28
> -#define VIRTIO_TRANSPORT_F_END		40
> +#define VIRTIO_TRANSPORT_F_END		41
>  
>  #ifndef VIRTIO_CONFIG_NO_LEGACY
>  /* Do we get callbacks when the ring is completely used, even if we've
> @@ -94,4 +94,9 @@
>   * layer.
>   */
>  #define VIRTIO_F_MMIO_NOTIFICATION	39
> +
> +/*
> + * This feature indicates the MSI support on MMIO layer.
> + */
> +#define VIRTIO_F_MMIO_MSI		40
>  #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */
> diff --git a/include/uapi/linux/virtio_mmio.h b/include/uapi/linux/virtio_mmio.h
> index c4b0968..777cb0e 100644
> --- a/include/uapi/linux/virtio_mmio.h
> +++ b/include/uapi/linux/virtio_mmio.h
> @@ -122,6 +122,21 @@
>  #define VIRTIO_MMIO_QUEUE_USED_LOW	0x0a0
>  #define VIRTIO_MMIO_QUEUE_USED_HIGH	0x0a4
>  
> +/* MSI max vector number that device supports - Read Only */
> +#define VIRTIO_MMIO_MSI_VEC_NUM		0x0c0
> +/* MSI state register  - Read Only */
> +#define VIRTIO_MMIO_MSI_STATE		0x0c4
> +/* MSI command register - Write Only */
> +#define VIRTIO_MMIO_MSI_COMMAND		0x0c8
> +/* MSI vector selector  - Write Only */
> +#define VIRTIO_MMIO_MSI_VEC_SEL		0x0d0
> +/* MSI low 32 bit address, 64 bits in two halves */
> +#define VIRTIO_MMIO_MSI_ADDRESS_LOW	0x0d4
> +/* MSI high 32 bit address, 64 bits in two halves */
> +#define VIRTIO_MMIO_MSI_ADDRESS_HIGH	0x0d8
> +/* MSI 32 bit data */
> +#define VIRTIO_MMIO_MSI_DATA		0x0dc
> +
>  /* Configuration atomicity value */
>  #define VIRTIO_MMIO_CONFIG_GENERATION	0x0fc
>  
> @@ -130,6 +145,22 @@
>  #define VIRTIO_MMIO_CONFIG		0x100
>  
>  
> +/* MSI commands */
> +#define VIRTIO_MMIO_MSI_CMD_ENABLE	0x1
> +#define VIRTIO_MMIO_MSI_CMD_DISABLE	0x2
> +#define VIRTIO_MMIO_MSI_CMD_CONFIGURE	0x3
> +#define VIRTIO_MMIO_MSI_CMD_MASK	0x4
> +#define VIRTIO_MMIO_MSI_CMD_UNMASK	0x5
> +#define VIRTIO_MMIO_MSI_CMD_MAP_CONFIG	0x6
> +#define VIRTIO_MMIO_MSI_CMD_MAP_QUEUE	0x7
> +
> +/* MSI NO_VECTOR */
> +#define VIRTIO_MMIO_MSI_NO_VECTOR	0xffffffff
> +
> +/* MSI state enabled state mask */
> +#define VIRTIO_MMIO_MSI_ENABLED_MASK	(1 << 31)
> +/* MSI state MSI sharing mask */
> +#define VIRTIO_MMIO_MSI_SHARING_MASK	(1 << 30)
>  

You should be able to drop MAP commands,
replace vector number with vq number.

I also don't really see a burning need for separate
enable/disable/configure/mask/unmask commands.
Just two registers mask and enable should be enough?
Will remove need for NO_VECTOR hack too.

what is sharing that hypervisor needs to worry about it?
just make all interrupts shared, or all unshared.
does it matter for performance?

>  /*
>   * Interrupt flags (re: interrupt status & acknowledge registers)
> -- 
> 1.8.3.1

