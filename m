Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CACC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3AD220771
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgGABPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 21:15:47 -0400
Received: from mga04.intel.com ([192.55.52.120]:19808 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgGABPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 21:15:47 -0400
IronPort-SDR: oRSmAB1V229w/3rnZKq9LVU2lptwI0jNWdQF86vAafN+uXt1TPvYysHmP6VdoVbrKuf+X7EP4l
 w1u7MOy9ir5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="143910688"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="143910688"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 18:15:46 -0700
IronPort-SDR: jKC/Hn5BimEOZ6Ayycsj9rZYm80pvLTQqu42LjGivkQ+jKKyaR09TIOytjBhaBh4hmISnMwCGB
 Sba31zwjPdZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="265263758"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jun 2020 18:15:44 -0700
Cc:     baolu.lu@linux.intel.com, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v2 5/7] iommu/vt-d: Fix devTLB flush for vSVA
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <1593551258-39854-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1593551258-39854-6-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <4449393d-f631-52f9-e98a-eb056a22b870@linux.intel.com>
Date:   Wed, 1 Jul 2020 09:11:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1593551258-39854-6-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/20 5:07 AM, Jacob Pan wrote:
> From: Liu Yi L <yi.l.liu@intel.com>
> 
> For guest SVA usage, in order to optimize for less VMEXIT, guest request
> of IOTLB flush also includes device TLB.
> 
> On the host side, IOMMU driver performs IOTLB and implicit devTLB
> invalidation. When PASID-selective granularity is requested by the guest
> we need to derive the equivalent address range for devTLB instead of
> using the address information in the UAPI data. The reason for that is, unlike
> IOTLB flush, devTLB flush does not support PASID-selective granularity.
> This is to say, we need to set the following in the PASID based devTLB
> invalidation descriptor:
> - entire 64 bit range in address ~(0x1 << 63)
> - S bit = 1 (VT-d CH 6.5.2.6).
> 
> Without this fix, device TLB flush range is not set properly for PASID
> selective granularity. This patch also merged devTLB flush code for both
> implicit and explicit cases.
> 
> Fixes: 6ee1b77ba3ac ("iommu/vt-d: Add svm/sva invalidate function")
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel/iommu.c | 28 ++++++++++++++++++----------
>   1 file changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 96340da57075..6a0c62c7395c 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5408,7 +5408,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
>   	sid = PCI_DEVID(bus, devfn);
>   
>   	/* Size is only valid in address selective invalidation */
> -	if (inv_info->granularity != IOMMU_INV_GRANU_PASID)
> +	if (inv_info->granularity == IOMMU_INV_GRANU_ADDR)
>   		size = to_vtd_size(inv_info->addr_info.granule_size,
>   				   inv_info->addr_info.nb_granules);
>   
> @@ -5417,6 +5417,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
>   			 IOMMU_CACHE_INV_TYPE_NR) {
>   		int granu = 0;
>   		u64 pasid = 0;
> +		u64 addr = 0;
>   
>   		granu = to_vtd_granularity(cache_type, inv_info->granularity);
>   		if (granu == -EINVAL) {
> @@ -5456,24 +5457,31 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
>   					(granu == QI_GRAN_NONG_PASID) ? -1 : 1 << size,
>   					inv_info->addr_info.flags & IOMMU_INV_ADDR_FLAGS_LEAF);
>   
> +			if (!info->ats_enabled)
> +				break;
>   			/*
>   			 * Always flush device IOTLB if ATS is enabled. vIOMMU
>   			 * in the guest may assume IOTLB flush is inclusive,
>   			 * which is more efficient.
>   			 */
> -			if (info->ats_enabled)
> -				qi_flush_dev_iotlb_pasid(iommu, sid,
> -						info->pfsid, pasid,
> -						info->ats_qdep,
> -						inv_info->addr_info.addr,
> -						size);
> -			break;
> +			fallthrough;
>   		case IOMMU_CACHE_INV_TYPE_DEV_IOTLB:
> +			/*
> +			 * There is no PASID selective flush for device TLB, so
> +			 * the equivalent of that is we set the size to be the
> +			 * entire range of 64 bit. User only provides PASID info
> +			 * without address info. So we set addr to 0.
> +			 */
> +			if (inv_info->granularity == IOMMU_INV_GRANU_PASID) {
> +				size = 64 - VTD_PAGE_SHIFT;
> +				addr = 0;
> +			} else if (inv_info->granularity == IOMMU_INV_GRANU_ADDR)
> +				addr = inv_info->addr_info.addr;
> +
>   			if (info->ats_enabled)
>   				qi_flush_dev_iotlb_pasid(iommu, sid,
>   						info->pfsid, pasid,
> -						info->ats_qdep,
> -						inv_info->addr_info.addr,
> +						info->ats_qdep, addr,
>   						size);
>   			else
>   				pr_warn_ratelimited("Passdown device IOTLB flush w/o ATS!\n");
> 
