Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53C7C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 09:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75D93206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 09:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="erTO9IV+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgF1J7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 05:59:08 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51565 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725928AbgF1J7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 05:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593338344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VmSihHJRj6X8vfWMwTG8/icIb3ExyfDOJEc1XTXVyYA=;
        b=erTO9IV+fF8kBcqhliFfERL9LHKY8UvWLqR3TrMcv8HNPnLT/I35jjiWNAaOXYlG7eTzUs
        cntyRfXVgJZN0zKTYFqsJP21gO6/L3VbVaG+2JzyHlQVct5/ACKYwWVxQmIVp9KST+0hte
        SjXpS+oJURQZ2TJUBj37DerkqB6sRkU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-b77BTOqfO6Ge68v2gG8nZg-1; Sun, 28 Jun 2020 05:58:28 -0400
X-MC-Unique: b77BTOqfO6Ge68v2gG8nZg-1
Received: by mail-wm1-f69.google.com with SMTP id g187so16085009wme.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 02:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VmSihHJRj6X8vfWMwTG8/icIb3ExyfDOJEc1XTXVyYA=;
        b=QyfcdoArFbQdUPmHcOTn88rNP9TFTppppJMe4V1EVgwjG69TaawW+82gzmcBNEw15H
         07blzYFIZ5YZ1baSbv2/0a8vvLGLPaDZ8CcH+UWnPVJFK3CDrFV1xrvsfbjOG9CeGwn5
         b65gnw7Xh4EwGi6taW0fk+V+M0rL/84IBW55fem9ytGlAXhwjJ+TZ2hsfmASp2VA3g5E
         XBxdXyEjDW2boCa8dGoQ/gKDKWul3hEZH/uWCYtPc+7sK4Hh39EmckS1OqUj6duGzQCM
         /yOzZCmzUi4GfgQTbig5cNT+FDvRY8ZeY1g3Se2S26y6GCnBCgVYwMiK4VP8KknYitl9
         9CEQ==
X-Gm-Message-State: AOAM532DhtzHBPOqfnT4J+MBQizgS33eGeUBDvuVRCjv2+anrb62H73e
        Moo21+1L1cQNlKzmWi48x5AvM2yb2xoVUqtqjgSXJbL8zG5upDI8TvEk2OsoiqUFN8BrXy8V2WX
        yxUNU9AC2HQpNUP+bO8H6ipuf
X-Received: by 2002:adf:ecce:: with SMTP id s14mr12293771wro.154.1593338306924;
        Sun, 28 Jun 2020 02:58:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9zm7MNbBULJ/q06u6nf6JrJYcvmC9jXJrOUZHqizqHorPmWVxe68u5oIzlPaBHTjmt4L6Kw==
X-Received: by 2002:adf:ecce:: with SMTP id s14mr12293754wro.154.1593338306643;
        Sun, 28 Jun 2020 02:58:26 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
        by smtp.gmail.com with ESMTPSA id f2sm23259420wmj.39.2020.06.28.02.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 02:58:25 -0700 (PDT)
Date:   Sun, 28 Jun 2020 05:58:22 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, rob.miller@broadcom.com,
        lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com,
        shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com,
        gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com
Subject: Re: [PATCH RFC 4/5] vhost-vdpa: support IOTLB batching hints
Message-ID: <20200628054940-mutt-send-email-mst@kernel.org>
References: <20200618055626.25660-1-jasowang@redhat.com>
 <20200618055626.25660-5-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618055626.25660-5-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 01:56:25PM +0800, Jason Wang wrote:
> This patches extend the vhost IOTLB API to accept batch updating hints
> form userspace. When userspace wants update the device IOTLB in a
> batch, it may do:
> 
> 1) Write vhost_iotlb_msg with VHOST_IOTLB_BATCH_BEGIN flag
> 2) Perform a batch of IOTLB updating via VHOST_IOTLB_UPDATE/INVALIDATE
> 3) Write vhost_iotlb_msg with VHOST_IOTLB_BATCH_END flag

As long as we are extending the interface,
is there some way we could cut down the number of system calls needed
here?


> 
> Vhost-vdpa may decide to batch the IOMMU/IOTLB updating in step 3 when
> vDPA device support set_map() ops. This is useful for the vDPA device
> that want to know all the mappings to tweak their own DMA translation
> logic.
> 
> For vDPA device that doesn't require set_map(), no behavior changes.
> 
> This capability is advertised via VHOST_BACKEND_F_IOTLB_BATCH capability.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vhost/vdpa.c             | 30 +++++++++++++++++++++++-------
>  include/uapi/linux/vhost.h       |  2 ++
>  include/uapi/linux/vhost_types.h |  7 +++++++
>  3 files changed, 32 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 453057421f80..8f624bbafee7 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -56,7 +56,9 @@ enum {
>  };
>  
>  enum {
> -	VHOST_VDPA_BACKEND_FEATURES = (1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2)
> +	VHOST_VDPA_BACKEND_FEATURES =
> +	(1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2) |
> +	(1ULL << VHOST_BACKEND_F_IOTLB_BATCH),
>  };
>  
>  /* Currently, only network backend w/o multiqueue is supported. */
> @@ -77,6 +79,7 @@ struct vhost_vdpa {
>  	int virtio_id;
>  	int minor;
>  	struct eventfd_ctx *config_ctx;
> +	int in_batch;
>  };
>  
>  static DEFINE_IDA(vhost_vdpa_ida);
> @@ -125,6 +128,7 @@ static void vhost_vdpa_reset(struct vhost_vdpa *v)
>  	const struct vdpa_config_ops *ops = vdpa->config;
>  
>  	ops->set_status(vdpa, 0);
> +	v->in_batch = 0;
>  }
>  
>  static long vhost_vdpa_get_device_id(struct vhost_vdpa *v, u8 __user *argp)
> @@ -540,9 +544,10 @@ static int vhost_vdpa_map(struct vhost_vdpa *v,
>  
>  	if (ops->dma_map)
>  		r = ops->dma_map(vdpa, iova, size, pa, perm);
> -	else if (ops->set_map)
> -		r = ops->set_map(vdpa, dev->iotlb);
> -	else
> +	else if (ops->set_map) {
> +		if (!v->in_batch)
> +			r = ops->set_map(vdpa, dev->iotlb);
> +	} else
>  		r = iommu_map(v->domain, iova, pa, size,
>  			      perm_to_iommu_flags(perm));
>  
> @@ -559,9 +564,10 @@ static void vhost_vdpa_unmap(struct vhost_vdpa *v, u64 iova, u64 size)
>  
>  	if (ops->dma_map)
>  		ops->dma_unmap(vdpa, iova, size);
> -	else if (ops->set_map)
> -		ops->set_map(vdpa, dev->iotlb);
> -	else
> +	else if (ops->set_map) {
> +		if (!v->in_batch)
> +			ops->set_map(vdpa, dev->iotlb);
> +	} else
>  		iommu_unmap(v->domain, iova, size);
>  }
>  
> @@ -655,6 +661,8 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev,
>  					struct vhost_iotlb_msg *msg)
>  {
>  	struct vhost_vdpa *v = container_of(dev, struct vhost_vdpa, vdev);
> +	struct vdpa_device *vdpa = v->vdpa;
> +	const struct vdpa_config_ops *ops = vdpa->config;
>  	int r = 0;
>  
>  	r = vhost_dev_check_owner(dev);
> @@ -668,6 +676,14 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev,
>  	case VHOST_IOTLB_INVALIDATE:
>  		vhost_vdpa_unmap(v, msg->iova, msg->size);
>  		break;
> +	case VHOST_IOTLB_BATCH_BEGIN:
> +		v->in_batch = true;
> +		break;
> +	case VHOST_IOTLB_BATCH_END:
> +		if (v->in_batch && ops->set_map)
> +			ops->set_map(vdpa, dev->iotlb);
> +		v->in_batch = false;
> +		break;
>  	default:
>  		r = -EINVAL;
>  		break;
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index 0c2349612e77..565da96f55d5 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -91,6 +91,8 @@
>  
>  /* Use message type V2 */
>  #define VHOST_BACKEND_F_IOTLB_MSG_V2 0x1
> +/* IOTLB can accpet batching hints */

typo

> +#define VHOST_BACKEND_F_IOTLB_BATCH  0x2
>  
>  #define VHOST_SET_BACKEND_FEATURES _IOW(VHOST_VIRTIO, 0x25, __u64)
>  #define VHOST_GET_BACKEND_FEATURES _IOR(VHOST_VIRTIO, 0x26, __u64)
> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
> index 669457ce5c48..5c12faffdde9 100644
> --- a/include/uapi/linux/vhost_types.h
> +++ b/include/uapi/linux/vhost_types.h
> @@ -60,6 +60,13 @@ struct vhost_iotlb_msg {
>  #define VHOST_IOTLB_UPDATE         2
>  #define VHOST_IOTLB_INVALIDATE     3
>  #define VHOST_IOTLB_ACCESS_FAIL    4
> +/* VHOST_IOTLB_BATCH_BEGIN is a hint that userspace will update
> + * several mappings afterwards. VHOST_IOTLB_BATCH_END is a hint that
> + * userspace had finished the mapping updating.


Well not just hints - in fact updates do not take place
until _END.

How about:

/* VHOST_IOTLB_BATCH_BEGIN and VHOST_IOTLB_BATCH_END allow modifying
 * multiple mappings in one go: beginning with
 * VHOST_IOTLB_BATCH_BEGIN, followed by any number of
   VHOST_IOTLB_UPDATE messages, and ending with VHOST_IOTLB_BATCH_END.
 */


> When those two flags
> + * were set, kernel will ignore the rest fileds of the IOTLB message.

how about:

when one of these two values is used as the message type, the
rest of the fields in the message are ignored.

> + */
> +#define VHOST_IOTLB_BATCH_BEGIN    5
> +#define VHOST_IOTLB_BATCH_END      6
>  	__u8 type;
>  };
>  
> -- 
> 2.20.1

