Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E703BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 07:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7F0720720
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 07:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390147AbgFYHRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 03:17:24 -0400
Received: from mga02.intel.com ([134.134.136.20]:7090 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgFYHRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 03:17:24 -0400
IronPort-SDR: ELC4xTYZNdFfJ3L7hzIt+sbNoPUnXnkskCLcVAwmrKobFSn4Hg4IDwKPJQm6Wup/VJhH7epeC9
 5sk0b+JsWq9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="133215695"
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; 
   d="scan'208";a="133215695"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 00:17:23 -0700
IronPort-SDR: 9SU8WSOXjOb5cGfblHCGaq4sbltWg3ZPoCkOiUtleR9YbF5N4YmR0x/cq0Jpk7BHB9Lcgk/TVU
 36t/6pIx+png==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; 
   d="scan'208";a="263857069"
Received: from yijiangw-mobl1.ccr.corp.intel.com (HELO [10.255.28.52]) ([10.255.28.52])
  by fmsmga007.fm.intel.com with ESMTP; 25 Jun 2020 00:17:20 -0700
Cc:     baolu.lu@linux.intel.com, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 2/7] iommu/vt-d: Remove global page support in devTLB
 flush
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <1592926996-47914-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1592926996-47914-3-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <cfbddc34-b70b-1ee6-9a9f-fa76e484de70@linux.intel.com>
Date:   Thu, 25 Jun 2020 15:17:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1592926996-47914-3-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/6/23 23:43, Jacob Pan wrote:
> Global pages support is removed from VT-d spec 3.0 for dev TLB
> invalidation. This patch is to remove the bits for vSVA. Similar change
> already made for the native SVA. See the link below.
> 

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> Link: https://lkml.org/lkml/2019/8/26/651
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   drivers/iommu/intel/dmar.c  | 4 +---
>   drivers/iommu/intel/iommu.c | 4 ++--
>   include/linux/intel-iommu.h | 3 +--
>   3 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index cc46dff98fa0..d9f973fa1190 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1437,8 +1437,7 @@ void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
>   
>   /* PASID-based device IOTLB Invalidate */
>   void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
> -			      u32 pasid,  u16 qdep, u64 addr,
> -			      unsigned int size_order, u64 granu)
> +			      u32 pasid,  u16 qdep, u64 addr, unsigned int size_order)
>   {
>   	unsigned long mask = 1UL << (VTD_PAGE_SHIFT + size_order - 1);
>   	struct qi_desc desc = {.qw1 = 0, .qw2 = 0, .qw3 = 0};
> @@ -1446,7 +1445,6 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
>   	desc.qw0 = QI_DEV_EIOTLB_PASID(pasid) | QI_DEV_EIOTLB_SID(sid) |
>   		QI_DEV_EIOTLB_QDEP(qdep) | QI_DEIOTLB_TYPE |
>   		QI_DEV_IOTLB_PFSID(pfsid);
> -	desc.qw1 = QI_DEV_EIOTLB_GLOB(granu);
>   
>   	/*
>   	 * If S bit is 0, we only flush a single page. If S bit is set,
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 9129663a7406..96340da57075 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5466,7 +5466,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
>   						info->pfsid, pasid,
>   						info->ats_qdep,
>   						inv_info->addr_info.addr,
> -						size, granu);
> +						size);
>   			break;
>   		case IOMMU_CACHE_INV_TYPE_DEV_IOTLB:
>   			if (info->ats_enabled)
> @@ -5474,7 +5474,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
>   						info->pfsid, pasid,
>   						info->ats_qdep,
>   						inv_info->addr_info.addr,
> -						size, granu);
> +						size);
>   			else
>   				pr_warn_ratelimited("Passdown device IOTLB flush w/o ATS!\n");
>   			break;
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 729386ca8122..9a6614880773 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -380,7 +380,6 @@ enum {
>   
>   #define QI_DEV_EIOTLB_ADDR(a)	((u64)(a) & VTD_PAGE_MASK)
>   #define QI_DEV_EIOTLB_SIZE	(((u64)1) << 11)
> -#define QI_DEV_EIOTLB_GLOB(g)	((u64)(g) & 0x1)
>   #define QI_DEV_EIOTLB_PASID(p)	((u64)((p) & 0xfffff) << 32)
>   #define QI_DEV_EIOTLB_SID(sid)	((u64)((sid) & 0xffff) << 16)
>   #define QI_DEV_EIOTLB_QDEP(qd)	((u64)((qd) & 0x1f) << 4)
> @@ -704,7 +703,7 @@ void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
>   
>   void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
>   			      u32 pasid, u16 qdep, u64 addr,
> -			      unsigned int size_order, u64 granu);
> +			      unsigned int size_order);
>   void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64 granu,
>   			  int pasid);
>   
> 
