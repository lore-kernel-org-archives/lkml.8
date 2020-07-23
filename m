Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6720C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 00:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C1C620888
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 00:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733285AbgGWAfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 20:35:02 -0400
Received: from mga03.intel.com ([134.134.136.65]:22138 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729198AbgGWAfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 20:35:02 -0400
IronPort-SDR: 2Npd3pLB2nlZAVZMs9G2rsfCF3Goadu1dGCd43nNhYC2Tp+PUlrS0Wr9ai18YzN4J6WzUhKTJW
 85FUKDcHpTkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="150430717"
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="150430717"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 17:35:01 -0700
IronPort-SDR: 5vXl87XkKg3yA6y0MCZeRK9JBL9vu4lNnWF29JJqkbvRh7kcDYVJxckXeBUvOAqChJ0FG3u+Gy
 LdtLVeVbMuQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="392842096"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by fmsmga001.fm.intel.com with ESMTP; 22 Jul 2020 17:34:59 -0700
Cc:     baolu.lu@linux.intel.com, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v5 3/7] iommu/vt-d: Fix PASID devTLB invalidation
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <1595445987-40095-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1595445987-40095-4-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <21f0c923-0e74-68d8-1fb3-67279b3fbd29@linux.intel.com>
Date:   Thu, 23 Jul 2020 08:30:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595445987-40095-4-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/20 3:26 AM, Jacob Pan wrote:
> DevTLB flush can be used for both DMA request with and without PASIDs.
> The former uses PASID#0 (RID2PASID), latter uses non-zero PASID for SVA
> usage.
> 
> This patch adds a check for PASID value such that devTLB flush with
> PASID is used for SVA case. This is more efficient in that multiple
> PASIDs can be used by a single device, when tearing down a PASID entry
> we shall flush only the devTLB specific to a PASID.
> 
> Fixes: 6f7db75e1c46 ("iommu/vt-d: Add second level page table")
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel/pasid.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index c81f0f17c6ba..fa0154cce537 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -486,7 +486,16 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
>   	qdep = info->ats_qdep;
>   	pfsid = info->pfsid;
>   
> -	qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64 - VTD_PAGE_SHIFT);
> +	/*
> +	 * When PASID 0 is used, it indicates RID2PASID(DMA request w/o PASID),
> +	 * devTLB flush w/o PASID should be used. For non-zero PASID under
> +	 * SVA usage, device could do DMA with multiple PASIDs. It is more
> +	 * efficient to flush devTLB specific to the PASID.
> +	 */
> +	if (pasid == PASID_RID2PASID)
> +		qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64 - VTD_PAGE_SHIFT);
> +	else
> +		qi_flush_dev_iotlb_pasid(iommu, sid, pfsid, pasid, qdep, 0, 64 - VTD_PAGE_SHIFT);
>   }
>   
>   void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
> 
