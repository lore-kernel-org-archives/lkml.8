Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93999C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66D462065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YH3JwG/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgENJbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 05:31:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38380 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgENJbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 05:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589448669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+M/JCln9wzAsGjhD0XvCSZCE5bghanH9yHT8B9Yuz1U=;
        b=YH3JwG/ltTjd1x5c9fbNSlF26ysMBxJr6fcTOqJb68wwU5Arh8rrQ9YMuKpJw3Y+lsfKkS
        6rQXMtHL9+BDJbJJDmBbmGrJ65tKh19YPcG0gLYMtpK+o0Zz/jPpBzG9fcaOofKfFV/rif
        oD1wvovJ2WSjouInFrjeVk18JAdagtg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-MnXRLqu2NOWT4ehJvV96KQ-1; Thu, 14 May 2020 05:31:06 -0400
X-MC-Unique: MnXRLqu2NOWT4ehJvV96KQ-1
Received: by mail-wr1-f72.google.com with SMTP id p13so1292520wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 02:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+M/JCln9wzAsGjhD0XvCSZCE5bghanH9yHT8B9Yuz1U=;
        b=HGkPY9rGwb3MgLFoNhVsnTZBFLJvPhsyPNLi2Dw/rRM2f1odBAwaeik3KcqvK1u8C3
         cATufP2uYzsiifI883t4D5A9YLoL662yGt4mKz5R3054Zem1rUb1X7ZoWIoez/PPihEQ
         ZhBQDMJpsmbcnrrSpLRP8UaZWD77rJ8t9MtcbYT111d/wM/1QDP36GOouX080fArUdxZ
         ridQnkhsWa1RAr8/HHF4iGua9xQ/SlxuoFTLmPEhVXzLMnKrDUJUqU6chtCJJrZp7mTy
         qI6eLHUa+94SKy2r5NQchqvQiAPimg3sEYq2iM6u+yMdx0Z1JNggdiPFO2oG6brwWe5v
         oTAQ==
X-Gm-Message-State: AOAM5313M989edpVYdDNgPKM1jxysD8cE3Nviu8/Ufxn7ODeDSLQdgE4
        EaZh0di9drioY0RgZo3sD1OehmJknH/m7+2E3jly9FzEPwdewWmGWXq30FYtLjRBy2Zdf7SGCP/
        TuaTGywDUhjt+T21A0zSMD41T
X-Received: by 2002:a5d:68c7:: with SMTP id p7mr4685757wrw.29.1589448664628;
        Thu, 14 May 2020 02:31:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycsR0+2Kleb6jHGMFKI+gdToHSPwOeDmcvW6rc5OTqQmi+/V8HolBTWiHvc8/6IWG23MXf2w==
X-Received: by 2002:a5d:68c7:: with SMTP id p7mr4685718wrw.29.1589448664260;
        Thu, 14 May 2020 02:31:04 -0700 (PDT)
Received: from redhat.com (bzq-79-179-68-225.red.bezeqint.net. [79.179.68.225])
        by smtp.gmail.com with ESMTPSA id y70sm41006618wmc.36.2020.05.14.02.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 02:31:03 -0700 (PDT)
Date:   Thu, 14 May 2020 05:31:00 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Bharat Bhushan <bbhushan2@marvell.com>
Cc:     virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, jean-philippe@linaro.org,
        joro@8bytes.org, jasowang@redhat.com, eric.auger.pro@gmail.com,
        eric.auger@redhat.com
Subject: Re: [PATCH v6] iommu/virtio: Use page size bitmap supported by
 endpoint
Message-ID: <20200514043747-mutt-send-email-mst@kernel.org>
References: <20200514075237.3941-1-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514075237.3941-1-bbhushan2@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 01:22:37PM +0530, Bharat Bhushan wrote:
> Different endpoint can support different page size, probe
> endpoint if it supports specific page size otherwise use
> global page sizes.
> 
> Device attached to domain should support a minimum of
> domain supported page sizes. If device supports more
> than domain supported page sizes then device is limited
> to use domain supported page sizes only.

OK so I am just trying to figure it out.
Before the patch, we always use the domain supported page sizes
right? With the patch, we still do, but we also probe and
validate that device supports all domain page sizes,
if it does not then we fail to attach the device.

This seems like a lot of effort for little benefit, can't
hypervisor simply make sure endpoints support the
iommu page sizes for us?



> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
> v5->v6
>  - property length before dereference
>  - Error out on no supported page sizes (page-size-mask is zero)
>  - Allow device to attach to domain even it supports
>    minimum of domain supported page sizes. In that case device
>    will use domain page sizes only.
>  - added format of pgsize_bitmap
> 
> v4->v5:
>  - Rebase to Linux v5.7-rc4
> 
> v3->v4:
>  - Fix whitespace error
> 
> v2->v3:
>  - Fixed error return for incompatible endpoint
>  - __u64 changed to __le64 in header file
> 
>  drivers/iommu/virtio-iommu.c      | 63 ++++++++++++++++++++++++++++---
>  include/uapi/linux/virtio_iommu.h | 14 ++++++-
>  2 files changed, 71 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 4e1d11af23c8..cbac3047a781 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -78,6 +78,7 @@ struct viommu_endpoint {
>  	struct viommu_dev		*viommu;
>  	struct viommu_domain		*vdomain;
>  	struct list_head		resv_regions;
> +	u64				pgsize_bitmap;
>  };
>  
>  struct viommu_request {
> @@ -415,6 +416,23 @@ static int viommu_replay_mappings(struct viommu_domain *vdomain)
>  	return ret;
>  }
>  
> +static int viommu_set_pgsize_bitmap(struct viommu_endpoint *vdev,
> +				    struct virtio_iommu_probe_pgsize_mask *mask,
> +				    size_t len)
> +{
> +	u64 pgsize_bitmap;
> +
> +	if (len < sizeof(*mask))
> +		return -EINVAL;
> +
> +	pgsize_bitmap = le64_to_cpu(mask->pgsize_bitmap);
> +	if (!pgsize_bitmap)
> +		return -EINVAL;
> +
> +	vdev->pgsize_bitmap = pgsize_bitmap;
> +	return 0;
> +}
> +
>  static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
>  			       struct virtio_iommu_probe_resv_mem *mem,
>  			       size_t len)
> @@ -499,6 +517,9 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
>  		case VIRTIO_IOMMU_PROBE_T_RESV_MEM:
>  			ret = viommu_add_resv_mem(vdev, (void *)prop, len);
>  			break;
> +		case VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK:
> +			ret = viommu_set_pgsize_bitmap(vdev, (void *)prop, len);
> +			break;
>  		default:
>  			dev_err(dev, "unknown viommu prop 0x%x\n", type);
>  		}
> @@ -615,7 +636,7 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
>  	struct viommu_dev *viommu = vdev->viommu;
>  	struct viommu_domain *vdomain = to_viommu_domain(domain);
>  
> -	viommu_page_size = 1UL << __ffs(viommu->pgsize_bitmap);
> +	viommu_page_size = 1UL << __ffs(vdev->pgsize_bitmap);
>  	if (viommu_page_size > PAGE_SIZE) {
>  		dev_err(vdev->dev,
>  			"granule 0x%lx larger than system page size 0x%lx\n",


Looks like this is messed up on 32 bit: e.g. 0x100000000 will try to do
1UL << -1, which is undefined behaviour. Which is btw already messed up
wrt viommu->pgsize_bitmap, but that's not a reason to propagate
the error.


> @@ -630,7 +651,7 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
>  
>  	vdomain->id		= (unsigned int)ret;
>  
> -	domain->pgsize_bitmap	= viommu->pgsize_bitmap;
> +	domain->pgsize_bitmap	= vdev->pgsize_bitmap;
>  	domain->geometry	= viommu->geometry;
>  
>  	vdomain->map_flags	= viommu->map_flags;
> @@ -654,6 +675,38 @@ static void viommu_domain_free(struct iommu_domain *domain)
>  	kfree(vdomain);
>  }
>  
> +/*
> + * Check whether the endpoint's capabilities are compatible with other
> + * endpoints in the domain. Report any inconsistency.

This actually has side effects, so _is_ isn't a good name for it.
viommu_endpoint_compatible?

> + */
> +static bool viommu_endpoint_is_compatible(struct viommu_endpoint *vdev,
> +					  struct viommu_domain *vdomain)
> +{
> +	struct device *dev = vdev->dev;
> +	u64 pgsize_bitmap;
> +
> +	if (vdomain->viommu != vdev->viommu) {
> +		dev_err(dev, "cannot attach to foreign vIOMMU\n");
> +		return false;
> +	}
> +
> +	pgsize_bitmap = vdomain->domain.pgsize_bitmap & vdev->pgsize_bitmap;
> +


> +	if (pgsize_bitmap != vdomain->domain.pgsize_bitmap) {

So this triggers when device is not a superset of domain, right?
Maybe add a comment.

> +		dev_err(dev, "incompatible domain bitmap 0x%lx != 0x%llx\n",
> +			vdomain->domain.pgsize_bitmap, vdev->pgsize_bitmap);
> +		return false;
> +	}
> +
> +	/* Domain pagesize bitmap is subset of device pagesize bitmap */
> +	if (pgsize_bitmap != vdev->pgsize_bitmap) {
> +		dev_info(dev, "page size bitmap used %llx, supported %llx\n",
> +			 pgsize_bitmap, vdev->pgsize_bitmap);
> +		vdev->pgsize_bitmap = pgsize_bitmap;
> +	}
> +	return true;
> +}
> +
>  static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  {
>  	int i;
> @@ -670,9 +723,8 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  		 * owns it.
>  		 */
>  		ret = viommu_domain_finalise(vdev, domain);
> -	} else if (vdomain->viommu != vdev->viommu) {
> -		dev_err(dev, "cannot attach to foreign vIOMMU\n");
> -		ret = -EXDEV;
> +	} else if (!viommu_endpoint_is_compatible(vdev, vdomain)) {
> +		ret = -EINVAL;
>  	}
>  	mutex_unlock(&vdomain->mutex);
>  
> @@ -886,6 +938,7 @@ static int viommu_add_device(struct device *dev)
>  
>  	vdev->dev = dev;
>  	vdev->viommu = viommu;
> +	vdev->pgsize_bitmap = viommu->pgsize_bitmap;
>  	INIT_LIST_HEAD(&vdev->resv_regions);
>  	dev_iommu_priv_set(dev, vdev);
>  
> diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
> index 48e3c29223b5..15a8327ffef5 100644
> --- a/include/uapi/linux/virtio_iommu.h
> +++ b/include/uapi/linux/virtio_iommu.h
> @@ -28,7 +28,11 @@ struct virtio_iommu_range_32 {
>  };
>  
>  struct virtio_iommu_config {
> -	/* Supported page sizes */
> +	/*
> +	 * Bitmap of supported page sizes. The least significant bit
> +	 * indicates the smallest granularity and the other bits are
> +	 * hints indicating optimal block sizes.
> +	 */
>  	__u64					page_size_mask;
>  	/* Supported IOVA range */
>  	struct virtio_iommu_range_64		input_range;
> @@ -111,6 +115,7 @@ struct virtio_iommu_req_unmap {
>  
>  #define VIRTIO_IOMMU_PROBE_T_NONE		0
>  #define VIRTIO_IOMMU_PROBE_T_RESV_MEM		1
> +#define VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK	2
>  
>  #define VIRTIO_IOMMU_PROBE_T_MASK		0xfff
>  
> @@ -119,6 +124,13 @@ struct virtio_iommu_probe_property {
>  	__le16					length;
>  };
>  
> +struct virtio_iommu_probe_pgsize_mask {
> +	struct virtio_iommu_probe_property	head;
> +	__u8					reserved[4];
> +	/* Same format as virtio_iommu_config::page_size_mask */

It's actually slightly different in that
this must be a superset of domain page size mask, right?





> +	__le64					pgsize_bitmap;
> +};
> +
>  #define VIRTIO_IOMMU_RESV_MEM_T_RESERVED	0
>  #define VIRTIO_IOMMU_RESV_MEM_T_MSI		1
>  
> -- 
> 2.17.1

