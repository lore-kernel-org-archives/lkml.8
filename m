Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAE2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4652E20874
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2nUJEQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgGBHQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 03:16:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35268 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726442AbgGBHQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 03:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593674191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bvsmvkL7tmceMF7IZ7LucZBij/7Kj7ZJorNPb9CASXo=;
        b=d2nUJEQXwN3nJe+VeBJf0/Kbb8ubiRNIjiFvQrfmoL1so9FxkLv8lVMOog6OWnrmHqJ0YS
        KcNKSEm9ylEsu6dFuW40sfD0mJUoLHAVHdCa8fUAnf/tnbGGoTB1E9OGgkMTATlbOY+8LB
        HfFuEU2NlrusjwTbYWkRSXOttB4k56Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-3NzaXPX4OrKhDY5xuiXYjQ-1; Thu, 02 Jul 2020 03:16:27 -0400
X-MC-Unique: 3NzaXPX4OrKhDY5xuiXYjQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3AE7107ACCA;
        Thu,  2 Jul 2020 07:16:25 +0000 (UTC)
Received: from [10.36.112.70] (ovpn-112-70.ams2.redhat.com [10.36.112.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D434A4FA3F;
        Thu,  2 Jul 2020 07:16:23 +0000 (UTC)
Subject: Re: [PATCH v3 2/7] iommu/vt-d: Remove global page support in devTLB
 flush
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>
References: <1593617636-79385-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1593617636-79385-3-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <e4b05249-bf1b-4d27-f76b-90a80f8586b2@redhat.com>
Date:   Thu, 2 Jul 2020 09:16:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1593617636-79385-3-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 7/1/20 5:33 PM, Jacob Pan wrote:
> Global pages support is removed from VT-d spec 3.0 for dev TLB
> invalidation. This patch is to remove the bits for vSVA. Similar change
> already made for the native SVA. See the link below.
> 
> Link: https://lkml.org/lkml/2019/8/26/651
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/intel/dmar.c  | 4 +---
>  drivers/iommu/intel/iommu.c | 4 ++--
>  include/linux/intel-iommu.h | 3 +--
>  3 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index cc46dff98fa0..d9f973fa1190 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1437,8 +1437,7 @@ void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
>  
>  /* PASID-based device IOTLB Invalidate */
>  void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
> -			      u32 pasid,  u16 qdep, u64 addr,
> -			      unsigned int size_order, u64 granu)
> +			      u32 pasid,  u16 qdep, u64 addr, unsigned int size_order)
>  {
>  	unsigned long mask = 1UL << (VTD_PAGE_SHIFT + size_order - 1);
>  	struct qi_desc desc = {.qw1 = 0, .qw2 = 0, .qw3 = 0};
> @@ -1446,7 +1445,6 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
>  	desc.qw0 = QI_DEV_EIOTLB_PASID(pasid) | QI_DEV_EIOTLB_SID(sid) |
>  		QI_DEV_EIOTLB_QDEP(qdep) | QI_DEIOTLB_TYPE |
>  		QI_DEV_IOTLB_PFSID(pfsid);
> -	desc.qw1 = QI_DEV_EIOTLB_GLOB(granu);
nit:

you may simplify the init of .qw1 to
.qw1 = addr & ~mask

as you have
desc.qw1 |= addr & ~mask;

Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

>  
>  	/*
>  	 * If S bit is 0, we only flush a single page. If S bit is set,
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 9129663a7406..96340da57075 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5466,7 +5466,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
>  						info->pfsid, pasid,
>  						info->ats_qdep,
>  						inv_info->addr_info.addr,
> -						size, granu);
> +						size);
>  			break;
>  		case IOMMU_CACHE_INV_TYPE_DEV_IOTLB:
>  			if (info->ats_enabled)
> @@ -5474,7 +5474,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
>  						info->pfsid, pasid,
>  						info->ats_qdep,
>  						inv_info->addr_info.addr,
> -						size, granu);
> +						size);
>  			else
>  				pr_warn_ratelimited("Passdown device IOTLB flush w/o ATS!\n");
>  			break;
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 729386ca8122..9a6614880773 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -380,7 +380,6 @@ enum {
>  
>  #define QI_DEV_EIOTLB_ADDR(a)	((u64)(a) & VTD_PAGE_MASK)
>  #define QI_DEV_EIOTLB_SIZE	(((u64)1) << 11)
> -#define QI_DEV_EIOTLB_GLOB(g)	((u64)(g) & 0x1)
>  #define QI_DEV_EIOTLB_PASID(p)	((u64)((p) & 0xfffff) << 32)
>  #define QI_DEV_EIOTLB_SID(sid)	((u64)((sid) & 0xffff) << 16)
>  #define QI_DEV_EIOTLB_QDEP(qd)	((u64)((qd) & 0x1f) << 4)
> @@ -704,7 +703,7 @@ void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
>  
>  void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
>  			      u32 pasid, u16 qdep, u64 addr,
> -			      unsigned int size_order, u64 granu);
> +			      unsigned int size_order);
>  void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64 granu,
>  			  int pasid);
>  
> 

