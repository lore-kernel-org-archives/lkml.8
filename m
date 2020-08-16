Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DCAC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 11:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 755DC20708
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 11:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jwq6tJHI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbgHPLjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 07:39:17 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58078 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729104AbgHPLfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 07:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597577738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u0CIsDKHWA2a1/usJei4d0Ky9e1Z44qr16Jyec3I+3w=;
        b=Jwq6tJHI0sh0/xj7cipeKfK4lzZUYT/MZYkb047lfy54iBtnm3sL/ZmFTXrFFxs9kiJ2Ks
        iS5h7DOsC6i2HXx6u5VTys5Ba/W/z44ccm9pxYcouZPw6Ovqvqi4vKMMavMwH9LNbSfHZ3
        AAcFY49UEgHpnzuFCl2TCAjyOlBnTSM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-dK8FjGpzMYCRG_a2-SYHrQ-1; Sun, 16 Aug 2020 07:35:36 -0400
X-MC-Unique: dK8FjGpzMYCRG_a2-SYHrQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBB9F802B47;
        Sun, 16 Aug 2020 11:35:34 +0000 (UTC)
Received: from [10.36.113.93] (ovpn-113-93.ams2.redhat.com [10.36.113.93])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D219A74E36;
        Sun, 16 Aug 2020 11:35:24 +0000 (UTC)
Subject: Re: [PATCH v6 11/15] vfio/type1: Allow invalidating first-level/stage
 IOMMU cache
To:     Liu Yi L <yi.l.liu@intel.com>, alex.williamson@redhat.com,
        baolu.lu@linux.intel.com, joro@8bytes.org
Cc:     kevin.tian@intel.com, jacob.jun.pan@linux.intel.com,
        ashok.raj@intel.com, jun.j.tian@intel.com, yi.y.sun@intel.com,
        jean-philippe@linaro.org, peterx@redhat.com, hao.wu@intel.com,
        stefanha@gmail.com, iommu@lists.linux-foundation.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1595917664-33276-1-git-send-email-yi.l.liu@intel.com>
 <1595917664-33276-12-git-send-email-yi.l.liu@intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <f0c7cfc1-ee6b-c98e-77bd-1af3dbaf2a6f@redhat.com>
Date:   Sun, 16 Aug 2020 13:35:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1595917664-33276-12-git-send-email-yi.l.liu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yi,

On 7/28/20 8:27 AM, Liu Yi L wrote:
> This patch provides an interface allowing the userspace to invalidate
> IOMMU cache for first-level page table. It is required when the first
> level IOMMU page table is not managed by the host kernel in the nested
> translation setup.
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
> v1 -> v2:
> *) rename from "vfio/type1: Flush stage-1 IOMMU cache for nesting type"
> *) rename vfio_cache_inv_fn() to vfio_dev_cache_invalidate_fn()
> *) vfio_dev_cache_inv_fn() always successful
> *) remove VFIO_IOMMU_CACHE_INVALIDATE, and reuse VFIO_IOMMU_NESTING_OP
> ---
>  drivers/vfio/vfio_iommu_type1.c | 42 +++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h       |  3 +++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 245436e..bf95a0f 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -3056,6 +3056,45 @@ static long vfio_iommu_handle_pgtbl_op(struct vfio_iommu *iommu,
>  	return ret;
>  }
>  
> +static int vfio_dev_cache_invalidate_fn(struct device *dev, void *data)
> +{
> +	struct domain_capsule *dc = (struct domain_capsule *)data;
> +	unsigned long arg = *(unsigned long *)dc->data;
> +
> +	iommu_uapi_cache_invalidate(dc->domain, dev, (void __user *)arg);
> +	return 0;
> +}
> +
> +static long vfio_iommu_invalidate_cache(struct vfio_iommu *iommu,
> +					unsigned long arg)
> +{
> +	struct domain_capsule dc = { .data = &arg };
> +	struct iommu_nesting_info *info;
> +	int ret;
> +
> +	mutex_lock(&iommu->lock);
> +	/*
> +	 * Cache invalidation is required for any nesting IOMMU,
So why do we expose the IOMMU_NESTING_FEAT_CACHE_INVLD capability? :-)
> +	 * so no need to check system-wide PASID support.
> +	 */
> +	info = iommu->nesting_info;
> +	if (!info || !(info->features & IOMMU_NESTING_FEAT_CACHE_INVLD)) {
> +		ret = -EOPNOTSUPP;
> +		goto out_unlock;
> +	}
> +
> +	ret = vfio_get_nesting_domain_capsule(iommu, &dc);
> +	if (ret)
> +		goto out_unlock;
> +
> +	iommu_group_for_each_dev(dc.group->iommu_group, &dc,
> +				 vfio_dev_cache_invalidate_fn);
> +
> +out_unlock:
> +	mutex_unlock(&iommu->lock);
> +	return ret;
> +}
> +
>  static long vfio_iommu_type1_nesting_op(struct vfio_iommu *iommu,
>  					unsigned long arg)
>  {
> @@ -3078,6 +3117,9 @@ static long vfio_iommu_type1_nesting_op(struct vfio_iommu *iommu,
>  	case VFIO_IOMMU_NESTING_OP_UNBIND_PGTBL:
>  		ret = vfio_iommu_handle_pgtbl_op(iommu, false, arg + minsz);
>  		break;
> +	case VFIO_IOMMU_NESTING_OP_CACHE_INVLD:
> +		ret = vfio_iommu_invalidate_cache(iommu, arg + minsz);
> +		break;
>  	default:
>  		ret = -EINVAL;
>  	}
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 9501cfb..48e2fb5 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1225,6 +1225,8 @@ struct vfio_iommu_type1_pasid_request {
>   * +-----------------+-----------------------------------------------+
>   * | UNBIND_PGTBL    |      struct iommu_gpasid_bind_data            |
>   * +-----------------+-----------------------------------------------+
> + * | CACHE_INVLD     |      struct iommu_cache_invalidate_info       |
> + * +-----------------+-----------------------------------------------+
>   *
>   * returns: 0 on success, -errno on failure.
>   */
> @@ -1237,6 +1239,7 @@ struct vfio_iommu_type1_nesting_op {
>  
>  #define VFIO_IOMMU_NESTING_OP_BIND_PGTBL	(0)
>  #define VFIO_IOMMU_NESTING_OP_UNBIND_PGTBL	(1)
> +#define VFIO_IOMMU_NESTING_OP_CACHE_INVLD	(2)
According to my previous comment, you may refine VFIO_NESTING_OP_MASK too

Thanks

Eric
>  
>  #define VFIO_IOMMU_NESTING_OP		_IO(VFIO_TYPE, VFIO_BASE + 19)
>  
> 

