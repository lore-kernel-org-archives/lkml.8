Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA81C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F0FF20786
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JV49eTT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgICPR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:17:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31208 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728677AbgICPRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 11:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599146215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zx4zxZT1IFDExYGCZepdGMzfnDZmvsPqxDqjEpWMEwc=;
        b=JV49eTT7v4ALQ+TVb8bgNzTQpDB/6SVdIEREofOlwCJ/8JKewXbbYCVy4Mq1Fo74Ca/bu9
        pXllGeIG3E6QC6wsAsvfWROp+0BPpV2qPOqB7bAS1AICSf8B94Lql2mpF1uY/O7oB/uvVV
        bNUc+PKgVpfhyi6YC/pJAqZswJ7svaI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-I3zVEtRhPVC4OQAYEq4TAA-1; Thu, 03 Sep 2020 11:16:48 -0400
X-MC-Unique: I3zVEtRhPVC4OQAYEq4TAA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9213257243;
        Thu,  3 Sep 2020 15:16:46 +0000 (UTC)
Received: from [10.36.112.51] (ovpn-112-51.ams2.redhat.com [10.36.112.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0843A7C0B3;
        Thu,  3 Sep 2020 15:16:41 +0000 (UTC)
Subject: Re: [PATCH v4 04/10] vfio/fsl-mc: Implement
 VFIO_DEVICE_GET_REGION_INFO ioctl call
To:     Diana Craciun <diana.craciun@oss.nxp.com>,
        alex.williamson@redhat.com, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bharatb.linux@gmail.com,
        laurentiu.tudor@nxp.com, Bharat Bhushan <Bharat.Bhushan@nxp.com>
References: <20200826093315.5279-1-diana.craciun@oss.nxp.com>
 <20200826093315.5279-5-diana.craciun@oss.nxp.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <d17469ad-9041-9b1c-64e4-f406888262b7@redhat.com>
Date:   Thu, 3 Sep 2020 17:16:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200826093315.5279-5-diana.craciun@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Diana,

On 8/26/20 11:33 AM, Diana Craciun wrote:
> Expose to userspace information about the memory regions.
> 
> Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
> Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
> ---
>  drivers/vfio/fsl-mc/vfio_fsl_mc.c         | 79 ++++++++++++++++++++++-
>  drivers/vfio/fsl-mc/vfio_fsl_mc_private.h | 19 ++++++
>  2 files changed, 97 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc.c b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
> index 5a5460d01f00..093b8d68496c 100644
> --- a/drivers/vfio/fsl-mc/vfio_fsl_mc.c
> +++ b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
> @@ -17,16 +17,72 @@
>  
>  static struct fsl_mc_driver vfio_fsl_mc_driver;
>  
> +static int vfio_fsl_mc_regions_init(struct vfio_fsl_mc_device *vdev)
> +{
> +	struct fsl_mc_device *mc_dev = vdev->mc_dev;
> +	int count = mc_dev->obj_desc.region_count;
> +	int i;
> +
> +	vdev->regions = kcalloc(count, sizeof(struct vfio_fsl_mc_region),
> +				GFP_KERNEL);
> +	if (!vdev->regions)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < count; i++) {
> +		struct resource *res = &mc_dev->regions[i];
> +
> +		vdev->regions[i].addr = res->start;
> +		vdev->regions[i].size = resource_size(res);
> +		vdev->regions[i].flags = 0;
why 0? I see in
> +	}
> +
> +	vdev->num_regions = mc_dev->obj_desc.region_count;
nit: you can use count directly fsl-mc-bus.c that flags can take
meaningful values
> +	return 0;
> +}
> +
> +static void vfio_fsl_mc_regions_cleanup(struct vfio_fsl_mc_device *vdev)
> +{
> +	vdev->num_regions = 0;
> +	kfree(vdev->regions);
> +}
> +
>  static int vfio_fsl_mc_open(void *device_data)
>  {
> +	struct vfio_fsl_mc_device *vdev = device_data;
> +	int ret;
> +
>  	if (!try_module_get(THIS_MODULE))
>  		return -ENODEV;
>  
> +	mutex_lock(&vdev->driver_lock);
> +	if (!vdev->refcnt) {
> +		ret = vfio_fsl_mc_regions_init(vdev);
> +		if (ret)
> +			goto err_reg_init;
> +	}
> +	vdev->refcnt++;
> +
> +	mutex_unlock(&vdev->driver_lock);
> +
>  	return 0;
> +
> +err_reg_init:
> +	mutex_unlock(&vdev->driver_lock);
> +	module_put(THIS_MODULE);
> +	return ret;
>  }
>  
>  static void vfio_fsl_mc_release(void *device_data)
>  {
> +	struct vfio_fsl_mc_device *vdev = device_data;
> +
> +	mutex_lock(&vdev->driver_lock);
> +
> +	if (!(--vdev->refcnt))
> +		vfio_fsl_mc_regions_cleanup(vdev);
> +
> +	mutex_unlock(&vdev->driver_lock);
> +
>  	module_put(THIS_MODULE);
>  }
>  
> @@ -59,7 +115,25 @@ static long vfio_fsl_mc_ioctl(void *device_data, unsigned int cmd,
>  	}
>  	case VFIO_DEVICE_GET_REGION_INFO:
>  	{
> -		return -ENOTTY;
> +		struct vfio_region_info info;
> +
> +		minsz = offsetofend(struct vfio_region_info, offset);
> +
> +		if (copy_from_user(&info, (void __user *)arg, minsz))
> +			return -EFAULT;
> +
> +		if (info.argsz < minsz)
> +			return -EINVAL;
> +
> +		if (info.index >= vdev->num_regions)
> +			return -EINVAL;
> +
> +		/* map offset to the physical address  */
> +		info.offset = VFIO_FSL_MC_INDEX_TO_OFFSET(info.index);
> +		info.size = vdev->regions[info.index].size;
> +		info.flags = vdev->regions[info.index].flags;
> +
> +		return copy_to_user((void __user *)arg, &info, minsz);
>  	}
>  	case VFIO_DEVICE_GET_IRQ_INFO:
>  	{
> @@ -204,6 +278,7 @@ static int vfio_fsl_mc_probe(struct fsl_mc_device *mc_dev)
>  		vfio_iommu_group_put(group, dev);
>  		return ret;
>  	}
> +	mutex_init(&vdev->driver_lock);
>  
>  	return ret;
>  }
> @@ -227,6 +302,8 @@ static int vfio_fsl_mc_remove(struct fsl_mc_device *mc_dev)
>  
>  	mc_dev->mc_io = NULL;
>  
> +	mutex_destroy(&vdev->driver_lock);
> +
>  	vfio_iommu_group_put(mc_dev->dev.iommu_group, dev);
>  
>  	return 0;
> diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc_private.h b/drivers/vfio/fsl-mc/vfio_fsl_mc_private.h
> index 37d61eaa58c8..818dfd3df4db 100644
> --- a/drivers/vfio/fsl-mc/vfio_fsl_mc_private.h
> +++ b/drivers/vfio/fsl-mc/vfio_fsl_mc_private.h
> @@ -7,9 +7,28 @@
>  #ifndef VFIO_FSL_MC_PRIVATE_H
>  #define VFIO_FSL_MC_PRIVATE_H
>  
> +#define VFIO_FSL_MC_OFFSET_SHIFT    40
> +#define VFIO_FSL_MC_OFFSET_MASK (((u64)(1) << VFIO_FSL_MC_OFFSET_SHIFT) - 1)
> +
> +#define VFIO_FSL_MC_OFFSET_TO_INDEX(off) ((off) >> VFIO_FSL_MC_OFFSET_SHIFT)
> +
> +#define VFIO_FSL_MC_INDEX_TO_OFFSET(index)	\
> +	((u64)(index) << VFIO_FSL_MC_OFFSET_SHIFT)
> +
> +struct vfio_fsl_mc_region {
> +	u32			flags;
> +	u32			type;
> +	u64			addr;
> +	resource_size_t		size;
> +};
> +
>  struct vfio_fsl_mc_device {
>  	struct fsl_mc_device		*mc_dev;
>  	struct notifier_block        nb;
> +	int				refcnt;
> +	u32				num_regions;
> +	struct vfio_fsl_mc_region	*regions;
> +	struct mutex driver_lock;
>  };
>  
>  #endif /* VFIO_FSL_MC_PRIVATE_H */
> 
Otherwise looks good to me

Thanks

Eric

