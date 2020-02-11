Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEDBC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB9C20848
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJ6f+xWO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgBKLTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 06:19:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32599 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727264AbgBKLTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 06:19:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581419955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zSGk4DByZIhPCN8YAGetuggpX02PP2LILdI0T2sXvxE=;
        b=hJ6f+xWOvlwvN8pfMdc3qdRGbVOvb3JUcVeO0Jk0ushWhsJcmheurKnDnw9hIDjMiq9dno
        Bwf6L6gw7+2BXkjh1Uq1FC2yjKw17Par6/IUq1sO40Dn8Gt0PFq4cA+z+UdRXDhPgVDLG7
        o+CBGe5orAbHaYewneJ2ihGH/KODl/s=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-LPwzWR38NMSzr0sqKFBBLg-1; Tue, 11 Feb 2020 06:19:14 -0500
X-MC-Unique: LPwzWR38NMSzr0sqKFBBLg-1
Received: by mail-qk1-f200.google.com with SMTP id i135so6832820qke.14
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 03:19:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zSGk4DByZIhPCN8YAGetuggpX02PP2LILdI0T2sXvxE=;
        b=K7tnxq/UDYrnIoPYMVkGLfCwb6ch9uF7c8k5PVuK0c9db6HZMCmH/8/KHiHMA5VlnT
         +Jg5RGVZ5HKgCEyHnpSNHMgZN90kaUMKn961pCW9I0OOCTscoil+/Wlnzk2zK2NIJLXf
         Zbk+FdHnoFsqO/Htrv0nWjopLm65Dfm8yqiRBEYzCmALROnGNuI4HeAG4DCdG6TnO2q6
         Me79ty4Hr9HOpuTDwP/VrZfv5iuilbMs5T+wH0G414V5hDTsHoN4qS1WzJoeCKkzauNv
         JmV10tMVI5ZEwl+2FbepiRejlc9Ae5Kx2lYyEtE8HX5T9Jxio1FkyEchfi3p3FHuR3Tb
         d8lg==
X-Gm-Message-State: APjAAAUb6ww/Qxo4jt+T9RRnr4FMlROYl3dchEXXGhUkSsoSGwRCwUz6
        4brhD7oFzoFD3AaIQc9Az7eSzM2u/ttu3S3mCURK5U94dW47yuKXmqAjpQQCmp8B05ntq20hC/k
        aPduovyqbyqEPgT/pV2k+4ybx
X-Received: by 2002:a05:6214:118d:: with SMTP id t13mr2296517qvv.5.1581419953558;
        Tue, 11 Feb 2020 03:19:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqwYkabWO8BaOzkqEcEDtxnu6+npU98PB75JpNvCUUh3RdtmsBY+hd7Uve9DjDBn8TDJQxQngQ==
X-Received: by 2002:a05:6214:118d:: with SMTP id t13mr2296501qvv.5.1581419953351;
        Tue, 11 Feb 2020 03:19:13 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id 73sm1920892qtg.40.2020.02.11.03.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 03:19:12 -0800 (PST)
Date:   Tue, 11 Feb 2020 06:19:08 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Zha Bin <zhabin@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, jasowang@redhat.com, slp@redhat.com,
        virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
        gerry@linux.alibaba.com, jing2.liu@linux.intel.com,
        chao.p.peng@linux.intel.com
Subject: Re: [PATCH v2 2/5] virtio-mmio: refactor common functionality
Message-ID: <20200211061758-mutt-send-email-mst@kernel.org>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <0268807dc26ecdf5620de9000758d05ca0b21f3f.1581305609.git.zhabin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0268807dc26ecdf5620de9000758d05ca0b21f3f.1581305609.git.zhabin@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 05:05:18PM +0800, Zha Bin wrote:
> From: Liu Jiang <gerry@linux.alibaba.com>
> 
> Common functionality is refactored into virtio_mmio_common.h
> in order to MSI support in later patch set.
> 
> Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
> Co-developed-by: Zha Bin <zhabin@linux.alibaba.com>
> Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
> Co-developed-by: Jing Liu <jing2.liu@linux.intel.com>
> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
> Co-developed-by: Chao Peng <chao.p.peng@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>

What does this proliferation of header files achieve?
common with what?

> ---
>  drivers/virtio/virtio_mmio.c        | 21 +--------------------
>  drivers/virtio/virtio_mmio_common.h | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+), 20 deletions(-)
>  create mode 100644 drivers/virtio/virtio_mmio_common.h
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 1733ab97..41e1c93 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -61,13 +61,12 @@
>  #include <linux/io.h>
>  #include <linux/list.h>
>  #include <linux/module.h>
> -#include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> -#include <linux/virtio.h>
>  #include <linux/virtio_config.h>
>  #include <uapi/linux/virtio_mmio.h>
>  #include <linux/virtio_ring.h>
> +#include "virtio_mmio_common.h"
>  
>  
>  
> @@ -77,24 +76,6 @@
>  
>  
>  
> -#define to_virtio_mmio_device(_plat_dev) \
> -	container_of(_plat_dev, struct virtio_mmio_device, vdev)
> -
> -struct virtio_mmio_device {
> -	struct virtio_device vdev;
> -	struct platform_device *pdev;
> -
> -	void __iomem *base;
> -	unsigned long version;
> -
> -	/* a list of queues so we can dispatch IRQs */
> -	spinlock_t lock;
> -	struct list_head virtqueues;
> -
> -	unsigned short notify_base;
> -	unsigned short notify_multiplier;
> -};
> -
>  struct virtio_mmio_vq_info {
>  	/* the actual virtqueue */
>  	struct virtqueue *vq;
> diff --git a/drivers/virtio/virtio_mmio_common.h b/drivers/virtio/virtio_mmio_common.h
> new file mode 100644
> index 0000000..90cb304
> --- /dev/null
> +++ b/drivers/virtio/virtio_mmio_common.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef _DRIVERS_VIRTIO_VIRTIO_MMIO_COMMON_H
> +#define _DRIVERS_VIRTIO_VIRTIO_MMIO_COMMON_H
> +/*
> + * Virtio MMIO driver - common functionality for all device versions
> + *
> + * This module allows virtio devices to be used over a memory-mapped device.
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/virtio.h>
> +
> +#define to_virtio_mmio_device(_plat_dev) \
> +	container_of(_plat_dev, struct virtio_mmio_device, vdev)
> +
> +struct virtio_mmio_device {
> +	struct virtio_device vdev;
> +	struct platform_device *pdev;
> +
> +	void __iomem *base;
> +	unsigned long version;
> +
> +	/* a list of queues so we can dispatch IRQs */
> +	spinlock_t lock;
> +	struct list_head virtqueues;
> +
> +	unsigned short notify_base;
> +	unsigned short notify_multiplier;
> +};
> +
> +#endif
> -- 
> 1.8.3.1

