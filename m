Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955B2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72624207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NWj8BaaF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgHJOCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 10:02:39 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60727 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726771AbgHJOCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 10:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597068156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zm9UN2ybwkEfJlU9ZzUNqxOkLJ5miUSnR65cKiA6LKQ=;
        b=NWj8BaaFT2+B0QjS3cfRcfT1g0g3mBFdxLOJ+HFF2qRheU+mny4m4OuMGd8O+Xd9nUG5Mx
        9I+saa/rhzg3RgYbYJRctKhRdMVa3GA3NnwZQ7K876ObSb8/lSqQbppa9eo1s/iEVSFxrb
        bW+OBXVCAH7e8TXZ6c0BmYn0bF+cI00=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-c5dhtUFvOdaoZU-CVEZXpw-1; Mon, 10 Aug 2020 10:02:35 -0400
X-MC-Unique: c5dhtUFvOdaoZU-CVEZXpw-1
Received: by mail-wr1-f71.google.com with SMTP id t12so4281900wrp.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 07:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zm9UN2ybwkEfJlU9ZzUNqxOkLJ5miUSnR65cKiA6LKQ=;
        b=R8jIOtUVB1YTTTPY5/M4gCQos4EKbmRXG3r5ZxKZOHQzBgK01Yu/jtkAo/ubR8jWdl
         KcJW7o2tJ4/oXZ5PnO9crgA4cLnmRTkIFJXBM7IIiv6caugTMiKjKC2ehBcC9cW7lK3q
         dVY12ryuw1580bM/5qhz72b2CcQxssLcsxhShFCcVfofvuWCU0aJesqBy/VQBCBkSrCX
         n6q6M9/Tuf/a24zKdhsDzsczLwanRTciWQ5imU/odnQ8CWWy5hCHeSnkiu8DKM86uj1I
         Mo9z0ZeieXejfySHWNjMrK5RCPxB9z/mxud6E83LML1mK6asOVB60+12nBqvmEbjeJfr
         MscQ==
X-Gm-Message-State: AOAM531I5Tf3SpjbO339qBwscSPYjP3yum3O6xcYUqoiX4VcH5hc/kmZ
        RJs7VLkcVGo0n4kACDB33pMvpwL8NNyw0eUztXZorI3vzLexl8S8+0fiROeb8LZQUlRfh6YLqN0
        batn9ricYuG3J9X9H7YwyX/JU
X-Received: by 2002:a5d:5445:: with SMTP id w5mr26606325wrv.342.1597068154028;
        Mon, 10 Aug 2020 07:02:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZKDjbvxQpugjVT7WWVCyaGFDHI2C6roKb2nSqD1rm2kdDhSV2saxy4uo2FJ6CRvCgIJPxpg==
X-Received: by 2002:a5d:5445:: with SMTP id w5mr26606286wrv.342.1597068153685;
        Mon, 10 Aug 2020 07:02:33 -0700 (PDT)
Received: from redhat.com (bzq-109-67-41-16.red.bezeqint.net. [109.67.41.16])
        by smtp.gmail.com with ESMTPSA id z12sm21145712wrp.20.2020.08.10.07.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 07:02:33 -0700 (PDT)
Date:   Mon, 10 Aug 2020 10:02:30 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, Sebastien Boeuf <sebastien.boeuf@intel.com>,
        kvm@vger.kernel.org
Subject: Re: [PATCH v2 03/20] virtio: Add get_shm_region method
Message-ID: <20200810100208-mutt-send-email-mst@kernel.org>
References: <20200807195526.426056-1-vgoyal@redhat.com>
 <20200807195526.426056-4-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807195526.426056-4-vgoyal@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 03:55:09PM -0400, Vivek Goyal wrote:
> From: Sebastien Boeuf <sebastien.boeuf@intel.com>
> 
> Virtio defines 'shared memory regions' that provide a continuously
> shared region between the host and guest.
> 
> Provide a method to find a particular region on a device.
> 
> Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: kvm@vger.kernel.org
> Cc: "Michael S. Tsirkin" <mst@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  include/linux/virtio_config.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index bb4cc4910750..c859f000a751 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -10,6 +10,11 @@
>  
>  struct irq_affinity;
>  
> +struct virtio_shm_region {
> +       u64 addr;
> +       u64 len;
> +};
> +
>  /**
>   * virtio_config_ops - operations for configuring a virtio device
>   * Note: Do not assume that a transport implements all of the operations
> @@ -65,6 +70,7 @@ struct irq_affinity;
>   *      the caller can then copy.
>   * @set_vq_affinity: set the affinity for a virtqueue (optional).
>   * @get_vq_affinity: get the affinity for a virtqueue (optional).
> + * @get_shm_region: get a shared memory region based on the index.
>   */
>  typedef void vq_callback_t(struct virtqueue *);
>  struct virtio_config_ops {
> @@ -88,6 +94,8 @@ struct virtio_config_ops {
>  			       const struct cpumask *cpu_mask);
>  	const struct cpumask *(*get_vq_affinity)(struct virtio_device *vdev,
>  			int index);
> +	bool (*get_shm_region)(struct virtio_device *vdev,
> +			       struct virtio_shm_region *region, u8 id);
>  };
>  
>  /* If driver didn't advertise the feature, it will never appear. */
> @@ -250,6 +258,15 @@ int virtqueue_set_affinity(struct virtqueue *vq, const struct cpumask *cpu_mask)
>  	return 0;
>  }
>  
> +static inline
> +bool virtio_get_shm_region(struct virtio_device *vdev,
> +                         struct virtio_shm_region *region, u8 id)
> +{
> +	if (!vdev->config->get_shm_region)
> +		return false;
> +	return vdev->config->get_shm_region(vdev, region, id);
> +}
> +
>  static inline bool virtio_is_little_endian(struct virtio_device *vdev)
>  {
>  	return virtio_has_feature(vdev, VIRTIO_F_VERSION_1) ||
> -- 
> 2.25.4
> 

