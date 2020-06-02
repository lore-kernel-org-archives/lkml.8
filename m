Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D554C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 04:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19A26206F1
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 04:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+nZcMEm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgFBEMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 00:12:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42985 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726003AbgFBEMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 00:12:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591071169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a9lp4kCk0EoQLJ2l6jfmvjFXr0WGukdLqUGAxnFUiPM=;
        b=X+nZcMEmXSlOxhfYtfgpbdWSJWeEYft0Mu/QAlEl/t/6ILTUyEHUlGiR5xa+Tc1pQ1XCmA
        MvRa0vfs7gxchmtS32mKNo4PpYU+E9qF3X607PS7fKEn0qd9NRsShukiAHiAgYmbCAjvvD
        ZhvMfBtWiMyGZyZcODHAb0AB/HQ430Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-HUdDd-FCOpyejH6QrIHWYQ-1; Tue, 02 Jun 2020 00:12:47 -0400
X-MC-Unique: HUdDd-FCOpyejH6QrIHWYQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D252C100CCC0;
        Tue,  2 Jun 2020 04:12:45 +0000 (UTC)
Received: from x1.home (ovpn-112-195.phx2.redhat.com [10.3.112.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68C9411CC00;
        Tue,  2 Jun 2020 04:12:45 +0000 (UTC)
Date:   Mon, 1 Jun 2020 22:12:44 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Diana Craciun <diana.craciun@oss.nxp.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        laurentiu.tudor@nxp.com, bharatb.linux@gmail.com,
        Bharat Bhushan <Bharat.Bhushan@nxp.com>
Subject: Re: [PATCH v2 5/9] vfio/fsl-mc: Allow userspace to MMAP fsl-mc
 device MMIO regions
Message-ID: <20200601221244.5dadbb26@x1.home>
In-Reply-To: <20200508072039.18146-6-diana.craciun@oss.nxp.com>
References: <20200508072039.18146-1-diana.craciun@oss.nxp.com>
        <20200508072039.18146-6-diana.craciun@oss.nxp.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 May 2020 10:20:35 +0300
Diana Craciun <diana.craciun@oss.nxp.com> wrote:

> Allow userspace to mmap device regions for direct access of
> fsl-mc devices.
> 
> Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
> Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
> ---
>  drivers/vfio/fsl-mc/vfio_fsl_mc.c         | 60 ++++++++++++++++++++++-
>  drivers/vfio/fsl-mc/vfio_fsl_mc_private.h |  2 +
>  2 files changed, 60 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc.c b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
> index c162fa27c02c..a92c6c97c29a 100644
> --- a/drivers/vfio/fsl-mc/vfio_fsl_mc.c
> +++ b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
> @@ -33,7 +33,11 @@ static int vfio_fsl_mc_regions_init(struct vfio_fsl_mc_device *vdev)
>  
>  		vdev->regions[i].addr = res->start;
>  		vdev->regions[i].size = PAGE_ALIGN((resource_size(res)));
> -		vdev->regions[i].flags = 0;
> +		vdev->regions[i].flags = VFIO_REGION_INFO_FLAG_MMAP;
> +		vdev->regions[i].flags |= VFIO_REGION_INFO_FLAG_READ;
> +		if (!(mc_dev->regions[i].flags & IORESOURCE_READONLY))
> +			vdev->regions[i].flags |= VFIO_REGION_INFO_FLAG_WRITE;


I'm a little confused that we advertise read and write here, but it's
only relative to the mmap and even later in the series where we add
read and write callback support, it's only for the dprc and dpmcp
devices.  Doesn't this leave dpaa2 accelerator devices with only mmap
access?  vfio doesn't really have a way to specify that a device only
has mmap access and the read/write interfaces can be quite useful when
debugging or tracing.

> +		vdev->regions[i].type = mc_dev->regions[i].flags & IORESOURCE_BITS;
>  	}
>  
>  	vdev->num_regions = mc_dev->obj_desc.region_count;
> @@ -164,9 +168,61 @@ static ssize_t vfio_fsl_mc_write(void *device_data, const char __user *buf,
>  	return -EINVAL;
>  }
>  
> +static int vfio_fsl_mc_mmap_mmio(struct vfio_fsl_mc_region region,
> +				 struct vm_area_struct *vma)
> +{
> +	u64 size = vma->vm_end - vma->vm_start;
> +	u64 pgoff, base;
> +
> +	pgoff = vma->vm_pgoff &
> +		((1U << (VFIO_FSL_MC_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
> +	base = pgoff << PAGE_SHIFT;
> +
> +	if (region.size < PAGE_SIZE || base + size > region.size)

We've already aligned region.size up to PAGE_SIZE, so that test can't
be true.  Whether it was a good idea to do that alignment, I'm not so
sure.

> +		return -EINVAL;
> +
> +	if (!(region.type & VFIO_DPRC_REGION_CACHEABLE))
> +		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +
> +	vma->vm_pgoff = (region.addr >> PAGE_SHIFT) + pgoff;
> +
> +	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
> +			       size, vma->vm_page_prot);
> +}
> +
>  static int vfio_fsl_mc_mmap(void *device_data, struct vm_area_struct *vma)
>  {
> -	return -EINVAL;
> +	struct vfio_fsl_mc_device *vdev = device_data;
> +	struct fsl_mc_device *mc_dev = vdev->mc_dev;
> +	int index;
> +
> +	index = vma->vm_pgoff >> (VFIO_FSL_MC_OFFSET_SHIFT - PAGE_SHIFT);
> +
> +	if (vma->vm_end < vma->vm_start)
> +		return -EINVAL;
> +	if (vma->vm_start & ~PAGE_MASK)
> +		return -EINVAL;
> +	if (vma->vm_end & ~PAGE_MASK)
> +		return -EINVAL;
> +	if (!(vma->vm_flags & VM_SHARED))
> +		return -EINVAL;
> +	if (index >= vdev->num_regions)
> +		return -EINVAL;
> +
> +	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_MMAP))
> +		return -EINVAL;
> +
> +	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_READ)
> +			&& (vma->vm_flags & VM_READ))
> +		return -EINVAL;
> +
> +	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE)
> +			&& (vma->vm_flags & VM_WRITE))
> +		return -EINVAL;
> +
> +	vma->vm_private_data = mc_dev;
> +
> +	return vfio_fsl_mc_mmap_mmio(vdev->regions[index], vma);
>  }
>  
>  static const struct vfio_device_ops vfio_fsl_mc_ops = {
> diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc_private.h b/drivers/vfio/fsl-mc/vfio_fsl_mc_private.h
> index 818dfd3df4db..89d2e2a602d8 100644
> --- a/drivers/vfio/fsl-mc/vfio_fsl_mc_private.h
> +++ b/drivers/vfio/fsl-mc/vfio_fsl_mc_private.h
> @@ -15,6 +15,8 @@
>  #define VFIO_FSL_MC_INDEX_TO_OFFSET(index)	\
>  	((u64)(index) << VFIO_FSL_MC_OFFSET_SHIFT)
>  
> +#define VFIO_DPRC_REGION_CACHEABLE	0x00000001


There appears to be some sort of magic mapping of this to bus specific
bits in the IORESOURCE_BITS range.  If the bus specific bits get
shifted we'll be subtly broken here.  Can't we use the bus #define so
that we can't get out of sync?  Thanks,

Alex


> +
>  struct vfio_fsl_mc_region {
>  	u32			flags;
>  	u32			type;

