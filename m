Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A33C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 09:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6A620784
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 09:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJ4dU1KA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732157AbgDAJlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 05:41:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37954 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726063AbgDAJlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 05:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585734090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ljSBuTDshyjfWDIFiCj71fILGTvbhkgJDDa/MPsZiCk=;
        b=DJ4dU1KA/YyoDji7Gcv3BnSl66wJw9UXOkQWDsPbtMNy4TlDiOLSAVSwN+PKoRjBaCJkR7
        v0C9XYIBvJp9t7eRqG1d6peUUg3xqBk4TBXeQzYWqfCJoiZMeOtjfM7+hHEHC9M6pz3oW2
        asT/g+5hbEijRaf7MBzbRU6yXl+txOc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-Jxw7ZyuKNJKiFRnZIQ0tPQ-1; Wed, 01 Apr 2020 05:41:26 -0400
X-MC-Unique: Jxw7ZyuKNJKiFRnZIQ0tPQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E97F9107B118;
        Wed,  1 Apr 2020 09:41:21 +0000 (UTC)
Received: from [10.36.112.58] (ovpn-112-58.ams2.redhat.com [10.36.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 318D4118F20;
        Wed,  1 Apr 2020 09:41:11 +0000 (UTC)
Subject: Re: [PATCH v1 3/8] vfio/type1: Report PASID alloc/free support to
 userspace
To:     "Liu, Yi L" <yi.l.liu@intel.com>, alex.williamson@redhat.com
Cc:     kevin.tian@intel.com, jacob.jun.pan@linux.intel.com,
        joro@8bytes.org, ashok.raj@intel.com, jun.j.tian@intel.com,
        yi.y.sun@intel.com, jean-philippe@linaro.org, peterx@redhat.com,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, hao.wu@intel.com
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-4-git-send-email-yi.l.liu@intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <1b720777-8334-936e-5edb-802b3dae7b05@redhat.com>
Date:   Wed, 1 Apr 2020 11:41:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1584880325-10561-4-git-send-email-yi.l.liu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yi,
On 3/22/20 1:32 PM, Liu, Yi L wrote:
> From: Liu Yi L <yi.l.liu@intel.com>
> 
> This patch reports PASID alloc/free availability to userspace (e.g. QEMU)
> thus userspace could do a pre-check before utilizing this feature.
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 28 ++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h       |  8 ++++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index e40afc0..ddd1ffe 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2234,6 +2234,30 @@ static int vfio_iommu_type1_pasid_free(struct vfio_iommu *iommu,
>  	return ret;
>  }
>  
> +static int vfio_iommu_info_add_nesting_cap(struct vfio_iommu *iommu,
> +					 struct vfio_info_cap *caps)
> +{
> +	struct vfio_info_cap_header *header;
> +	struct vfio_iommu_type1_info_cap_nesting *nesting_cap;
> +
> +	header = vfio_info_cap_add(caps, sizeof(*nesting_cap),
> +				   VFIO_IOMMU_TYPE1_INFO_CAP_NESTING, 1);
> +	if (IS_ERR(header))
> +		return PTR_ERR(header);
> +
> +	nesting_cap = container_of(header,
> +				struct vfio_iommu_type1_info_cap_nesting,
> +				header);
> +
> +	nesting_cap->nesting_capabilities = 0;
> +	if (iommu->nesting) {
> +		/* nesting iommu type supports PASID requests (alloc/free) */
> +		nesting_cap->nesting_capabilities |= VFIO_IOMMU_PASID_REQS;
Supporting nesting does not necessarily mean supporting PASID.
> +	}
> +
> +	return 0;
> +}
> +
>  static long vfio_iommu_type1_ioctl(void *iommu_data,
>  				   unsigned int cmd, unsigned long arg)
>  {
> @@ -2283,6 +2307,10 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
>  		if (ret)
>  			return ret;
>  
> +		ret = vfio_iommu_info_add_nesting_cap(iommu, &caps);
> +		if (ret)
> +			return ret;
> +
>  		if (caps.size) {
>  			info.flags |= VFIO_IOMMU_INFO_CAPS;
>  
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 298ac80..8837219 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -748,6 +748,14 @@ struct vfio_iommu_type1_info_cap_iova_range {
>  	struct	vfio_iova_range iova_ranges[];
>  };
>  
> +#define VFIO_IOMMU_TYPE1_INFO_CAP_NESTING  2
> +
> +struct vfio_iommu_type1_info_cap_nesting {
> +	struct	vfio_info_cap_header header;
> +#define VFIO_IOMMU_PASID_REQS	(1 << 0)
PASID_REQS sounds a bit far from the claimed host managed alloc/free
capability.
VFIO_IOMMU_SYSTEM_WIDE_PASID?
> +	__u32	nesting_capabilities;
> +};
> +
>  #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
>  
>  /**
> 
Thanks

Eric

