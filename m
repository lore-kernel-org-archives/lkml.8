Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URI_WP_DIRINDEX,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F207C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 12:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45A9F2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 12:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X9UnxWVH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgGTMW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 08:22:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57521 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728651AbgGTMW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 08:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595247776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PFM1Qo8fTP4agFAqoUXIx/sYoR1DNoACJDTPmZRrdKQ=;
        b=X9UnxWVHL5izrQ1RjvfYVnafId/SXmYNzyprQPtI5R6ZxsSay9d2uOQmgdZf90HbRBzyEj
        +6Owrq30ujNmJnHT3pZnrEsyU5jiltmNCxocMYqahQJ/O/RwFg/867nROTP9sDi41Mcbl6
        cJozVcMOBsJaeYmzcpVzhR65koJCfwE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514--fmzgAVpM3WTrqd1e3leqw-1; Mon, 20 Jul 2020 08:22:30 -0400
X-MC-Unique: -fmzgAVpM3WTrqd1e3leqw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28EFC800597;
        Mon, 20 Jul 2020 12:22:28 +0000 (UTC)
Received: from [10.36.115.54] (ovpn-115-54.ams2.redhat.com [10.36.115.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B80272B6E2;
        Mon, 20 Jul 2020 12:22:18 +0000 (UTC)
Subject: Re: [PATCH v5 12/15] vfio/type1: Add vSVA support for IOMMU-backed
 mdevs
To:     Liu Yi L <yi.l.liu@intel.com>, alex.williamson@redhat.com,
        baolu.lu@linux.intel.com, joro@8bytes.org
Cc:     kevin.tian@intel.com, jacob.jun.pan@linux.intel.com,
        ashok.raj@intel.com, jun.j.tian@intel.com, yi.y.sun@intel.com,
        jean-philippe@linaro.org, peterx@redhat.com, hao.wu@intel.com,
        stefanha@gmail.com, iommu@lists.linux-foundation.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1594552870-55687-1-git-send-email-yi.l.liu@intel.com>
 <1594552870-55687-13-git-send-email-yi.l.liu@intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <5921bffc-9daa-99be-9a12-6d94ce1950d2@redhat.com>
Date:   Mon, 20 Jul 2020 14:22:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1594552870-55687-13-git-send-email-yi.l.liu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yi,

On 7/12/20 1:21 PM, Liu Yi L wrote:
> Recent years, mediated device pass-through framework (e.g. vfio-mdev)
> is used to achieve flexible device sharing across domains (e.g. VMs).
> Also there are hardware assisted mediated pass-through solutions from
> platform vendors. e.g. Intel VT-d scalable mode which supports Intel
> Scalable I/O Virtualization technology. Such mdevs are called IOMMU-
> backed mdevs as there are IOMMU enforced DMA isolation for such mdevs.
there is IOMMU enforced DMA isolation
> In kernel, IOMMU-backed mdevs are exposed to IOMMU layer by aux-domain
> concept, which means mdevs are protected by an iommu domain which is
> auxiliary to the domain that the kernel driver primarily uses for DMA
> API. Details can be found in the KVM presentation as below:
> 
> https://events19.linuxfoundation.org/wp-content/uploads/2017/12/\
> Hardware-Assisted-Mediated-Pass-Through-with-VFIO-Kevin-Tian-Intel.pdf
> 
> This patch extends NESTING_IOMMU ops to IOMMU-backed mdev devices. The
> main requirement is to use the auxiliary domain associated with mdev.

So as a result vSVM becomes functional for scalable mode mediated
devices, right?
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> CC: Jun Tian <jun.j.tian@intel.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
> v1 -> v2:
> *) check the iommu_device to ensure the handling mdev is IOMMU-backed
> ---
>  drivers/vfio/vfio_iommu_type1.c | 39 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 960cc59..f1f1ae2 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2373,20 +2373,41 @@ static int vfio_iommu_resv_refresh(struct vfio_iommu *iommu,
>  	return ret;
>  }
>  
> +static struct device *vfio_get_iommu_device(struct vfio_group *group,
> +					    struct device *dev)
> +{
> +	if (group->mdev_group)
> +		return vfio_mdev_get_iommu_device(dev);
> +	else
> +		return dev;
> +}
> +
>  static int vfio_dev_bind_gpasid_fn(struct device *dev, void *data)
>  {
>  	struct domain_capsule *dc = (struct domain_capsule *)data;
>  	unsigned long arg = *(unsigned long *)dc->data;
> +	struct device *iommu_device;
> +
> +	iommu_device = vfio_get_iommu_device(dc->group, dev);
> +	if (!iommu_device)
> +		return -EINVAL;
>  
> -	return iommu_sva_bind_gpasid(dc->domain, dev, (void __user *)arg);
> +	return iommu_sva_bind_gpasid(dc->domain, iommu_device,
> +				     (void __user *)arg);
>  }
>  
>  static int vfio_dev_unbind_gpasid_fn(struct device *dev, void *data)
>  {
>  	struct domain_capsule *dc = (struct domain_capsule *)data;
>  	unsigned long arg = *(unsigned long *)dc->data;
> +	struct device *iommu_device;
>  
> -	iommu_sva_unbind_gpasid(dc->domain, dev, (void __user *)arg);
> +	iommu_device = vfio_get_iommu_device(dc->group, dev);
> +	if (!iommu_device)
> +		return -EINVAL;
> +
> +	iommu_sva_unbind_gpasid(dc->domain, iommu_device,
> +				(void __user *)arg);
>  	return 0;
>  }
>  
> @@ -2395,8 +2416,13 @@ static int __vfio_dev_unbind_gpasid_fn(struct device *dev, void *data)
>  	struct domain_capsule *dc = (struct domain_capsule *)data;
>  	struct iommu_gpasid_bind_data *unbind_data =
>  				(struct iommu_gpasid_bind_data *)dc->data;
> +	struct device *iommu_device;
> +
> +	iommu_device = vfio_get_iommu_device(dc->group, dev);
> +	if (!iommu_device)
> +		return -EINVAL;
>  
> -	__iommu_sva_unbind_gpasid(dc->domain, dev, unbind_data);
> +	__iommu_sva_unbind_gpasid(dc->domain, iommu_device, unbind_data);
>  	return 0;
>  }
>  
> @@ -3077,8 +3103,13 @@ static int vfio_dev_cache_invalidate_fn(struct device *dev, void *data)
>  {
>  	struct domain_capsule *dc = (struct domain_capsule *)data;
>  	unsigned long arg = *(unsigned long *)dc->data;
> +	struct device *iommu_device;
> +
> +	iommu_device = vfio_get_iommu_device(dc->group, dev);
> +	if (!iommu_device)
> +		return -EINVAL;
>  
> -	iommu_cache_invalidate(dc->domain, dev, (void __user *)arg);
> +	iommu_cache_invalidate(dc->domain, iommu_device, (void __user *)arg);
>  	return 0;
>  }
>  
> 
Besides,

Looks grood to me

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

