Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A88C2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF50F20705
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 13:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732593AbgDANAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 09:00:17 -0400
Received: from foss.arm.com ([217.140.110.172]:51222 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732252AbgDANAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 09:00:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5BCE30E;
        Wed,  1 Apr 2020 06:00:16 -0700 (PDT)
Received: from [10.57.60.204] (unknown [10.57.60.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6DF53F71E;
        Wed,  1 Apr 2020 06:00:14 -0700 (PDT)
Subject: Re: [RFC PATCH v2] iommu/virtio: Use page size bitmap supported by
 endpoint
To:     Bharat Bhushan <bbhushan2@marvell.com>, jean-philippe@linaro.org,
        joro@8bytes.org, mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        eric.auger.pro@gmail.com, eric.auger@redhat.com
References: <20200401113804.21616-1-bbhushan2@marvell.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <b75beb74-89ce-fd6a-6207-3c0d7f479215@arm.com>
Date:   Wed, 1 Apr 2020 14:00:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200401113804.21616-1-bbhushan2@marvell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-01 12:38 pm, Bharat Bhushan wrote:
> Different endpoint can support different page size, probe
> endpoint if it supports specific page size otherwise use
> global page sizes.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
>   drivers/iommu/virtio-iommu.c      | 33 +++++++++++++++++++++++++++----
>   include/uapi/linux/virtio_iommu.h |  7 +++++++
>   2 files changed, 36 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index cce329d71fba..c794cb5b7b3e 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -78,6 +78,7 @@ struct viommu_endpoint {
>   	struct viommu_dev		*viommu;
>   	struct viommu_domain		*vdomain;
>   	struct list_head		resv_regions;
> +	u64				pgsize_bitmap;
>   };
>   
>   struct viommu_request {
> @@ -415,6 +416,20 @@ static int viommu_replay_mappings(struct viommu_domain *vdomain)
>   	return ret;
>   }
>   
> +static int viommu_set_pgsize_bitmap(struct viommu_endpoint *vdev,
> +				    struct virtio_iommu_probe_pgsize_mask *mask,
> +				    size_t len)
> +
> +{
> +	u64 pgsize_bitmap = le64_to_cpu(mask->pgsize_bitmap);
> +
> +	if (len < sizeof(*mask))
> +		return -EINVAL;
> +
> +	vdev->pgsize_bitmap = pgsize_bitmap;
> +	return 0;
> +}
> +
>   static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
>   			       struct virtio_iommu_probe_resv_mem *mem,
>   			       size_t len)
> @@ -494,11 +509,13 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
>   	while (type != VIRTIO_IOMMU_PROBE_T_NONE &&
>   	       cur < viommu->probe_size) {
>   		len = le16_to_cpu(prop->length) + sizeof(*prop);
> -
>   		switch (type) {
>   		case VIRTIO_IOMMU_PROBE_T_RESV_MEM:
>   			ret = viommu_add_resv_mem(vdev, (void *)prop, len);
>   			break;
> +		case VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK:
> +			ret = viommu_set_pgsize_bitmap(vdev, (void *)prop, len);
> +			break;
>   		default:
>   			dev_err(dev, "unknown viommu prop 0x%x\n", type);
>   		}
> @@ -607,16 +624,23 @@ static struct iommu_domain *viommu_domain_alloc(unsigned type)
>   	return &vdomain->domain;
>   }
>   
> -static int viommu_domain_finalise(struct viommu_dev *viommu,
> +static int viommu_domain_finalise(struct viommu_endpoint *vdev,
>   				  struct iommu_domain *domain)
>   {
>   	int ret;
>   	struct viommu_domain *vdomain = to_viommu_domain(domain);
> +	struct viommu_dev *viommu = vdev->viommu;
>   
>   	vdomain->viommu		= viommu;
>   	vdomain->map_flags	= viommu->map_flags;
>   
> -	domain->pgsize_bitmap	= viommu->pgsize_bitmap;
> +	/* Devices in same domain must support same size pages */

AFAICS what the code appears to do is enforce that the first endpoint 
attached to any domain has the same pgsize_bitmap as the most recently 
probed viommu_dev instance, then ignore any subsequent endpoints 
attached to the same domain. Thus I'm not sure that comment is accurate.

Robin.

> +	if ((domain->pgsize_bitmap != viommu->pgsize_bitmap) &&
> +	    (domain->pgsize_bitmap != vdev->pgsize_bitmap))
> +		return -EINVAL;
> +
> +	domain->pgsize_bitmap = vdev->pgsize_bitmap;
> +
>   	domain->geometry	= viommu->geometry;
>   
>   	ret = ida_alloc_range(&viommu->domain_ids, viommu->first_domain,
> @@ -657,7 +681,7 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
>   		 * Properly initialize the domain now that we know which viommu
>   		 * owns it.
>   		 */
> -		ret = viommu_domain_finalise(vdev->viommu, domain);
> +		ret = viommu_domain_finalise(vdev, domain);
>   	} else if (vdomain->viommu != vdev->viommu) {
>   		dev_err(dev, "cannot attach to foreign vIOMMU\n");
>   		ret = -EXDEV;
> @@ -875,6 +899,7 @@ static int viommu_add_device(struct device *dev)
>   
>   	vdev->dev = dev;
>   	vdev->viommu = viommu;
> +	vdev->pgsize_bitmap = viommu->pgsize_bitmap;
>   	INIT_LIST_HEAD(&vdev->resv_regions);
>   	fwspec->iommu_priv = vdev;
>   
> diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
> index 237e36a280cb..dc9d3f40bcd8 100644
> --- a/include/uapi/linux/virtio_iommu.h
> +++ b/include/uapi/linux/virtio_iommu.h
> @@ -111,6 +111,7 @@ struct virtio_iommu_req_unmap {
>   
>   #define VIRTIO_IOMMU_PROBE_T_NONE		0
>   #define VIRTIO_IOMMU_PROBE_T_RESV_MEM		1
> +#define VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK	2
>   
>   #define VIRTIO_IOMMU_PROBE_T_MASK		0xfff
>   
> @@ -119,6 +120,12 @@ struct virtio_iommu_probe_property {
>   	__le16					length;
>   };
>   
> +struct virtio_iommu_probe_pgsize_mask {
> +	struct virtio_iommu_probe_property	head;
> +	__u8					reserved[4];
> +	__u64					pgsize_bitmap;
> +};
> +
>   #define VIRTIO_IOMMU_RESV_MEM_T_RESERVED	0
>   #define VIRTIO_IOMMU_RESV_MEM_T_MSI		1
>   
> 
