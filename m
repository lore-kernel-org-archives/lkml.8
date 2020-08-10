Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0981C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 13:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADCA220734
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 13:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YOGtzwql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgHJNr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 09:47:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53318 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726787AbgHJNr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 09:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597067245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z8HxGZRX0ri3hL7o0UjLbQAuAiwO1V2HqhDwK8CAsEc=;
        b=YOGtzwql9/JEeQTWaIAccOw8hGGl3H1irTthi05Huy53MXwYFb9GdbE5+umbtyAgLBcbC3
        hfDZKFCUmArA2ISRQGBGD0KPFawmwOn1MBUpl9IrZPn+nUlUo9E+yk0q/fc80FnUVwwZiY
        SWKaDGHoMDT9Nismap6kGtN1YMVF/lA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-U2SUuevaPh2fWETLxU7K4w-1; Mon, 10 Aug 2020 09:47:21 -0400
X-MC-Unique: U2SUuevaPh2fWETLxU7K4w-1
Received: by mail-wm1-f69.google.com with SMTP id p23so2809525wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 06:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z8HxGZRX0ri3hL7o0UjLbQAuAiwO1V2HqhDwK8CAsEc=;
        b=Cyhjo9fZsXVSSPcVjZuuJJIKW915T5V73Z/NTis0lLH3SUi1WoyDdab4HnZxbsQ8Ag
         6sefen+suxT+mHQO+de8FWddnCHXg/8bX1IsgnUXY/fUS0d2BT2IqgFLLq9jWsuJtjC2
         sfA5PDAhyKNmduh+xaZlcB3CHEyKJdmdyrVaj4o4htD+cDpHqtmSr7oAjoIVFM4sTLLn
         DpJUiM2us8I/mlxw7gSB8j5oT8P5fwJYsPQqveVyjd1Pc0ToVC8yrwnl14T4bcwS80xy
         rbOIye68nvHkwC8Dz+a7fr3L6vczEuYSCozO+0YWjkWR+Gqvl3wK2QJjMqdegSwd+TBa
         w9wA==
X-Gm-Message-State: AOAM530QDFIKPyU5GBf6YL0gW1klcsrHW2cA7qx/A2KxzqwUas417k7L
        y/DaA4NHeqKekN/dcZ2Oin5pg/l+jiAZnMlgNuNcUi/bzrREM3Fs4Pzvs00LfNo2mMFEfuSsK1i
        7bKpeh8ZV8qzQmYs5B9gMCk6r
X-Received: by 2002:a1c:1b93:: with SMTP id b141mr25773828wmb.150.1597067239974;
        Mon, 10 Aug 2020 06:47:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiKr4k+daNBgpJsJdAPnBhBio+aWOVADeV99EvpK7df75SgAQYK1b8ZOE3OtN5IXqUpVc1HA==
X-Received: by 2002:a1c:1b93:: with SMTP id b141mr25773815wmb.150.1597067239779;
        Mon, 10 Aug 2020 06:47:19 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
        by smtp.gmail.com with ESMTPSA id g188sm24329476wma.5.2020.08.10.06.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 06:47:18 -0700 (PDT)
Date:   Mon, 10 Aug 2020 09:47:15 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, Sebastien Boeuf <sebastien.boeuf@intel.com>,
        kvm@vger.kernel.org
Subject: Re: [PATCH v2 03/20] virtio: Add get_shm_region method
Message-ID: <20200810094548-mutt-send-email-mst@kernel.org>
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

I'm not sure why doesn't b4 pick up reset of this
patchset. where can I find it?


IIUC all this is 5.10 material, right?


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

