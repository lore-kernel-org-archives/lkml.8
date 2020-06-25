Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FBEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 10:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 695462070A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 10:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390586AbgFYKKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 06:10:53 -0400
Received: from mga02.intel.com ([134.134.136.20]:21359 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389568AbgFYKKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 06:10:52 -0400
IronPort-SDR: yyu7GAGruH533Zwx5UfwGE6sAo8mZDJmMjQGok03sm18umpc84El3bCwUi+MNfnx/K5yk5xHyW
 pxM5sMCmGRfg==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="133259340"
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; 
   d="scan'208";a="133259340"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 03:10:46 -0700
IronPort-SDR: PFsp/SsCVenUnNedV0CEWxdvXRhWP/c8o1xR0H0gXdq1qb/ZBGwr3ItsyEJ1n7PfCmRbKEA+iJ
 IyvEJVEHi9AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,278,1589266800"; 
   d="scan'208";a="263887183"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.255.28.52]) ([10.255.28.52])
  by fmsmga007.fm.intel.com with ESMTP; 25 Jun 2020 03:10:43 -0700
Cc:     baolu.lu@linux.intel.com, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 6/7] iommu/vt-d: Warn on out-of-range invalidation address
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <1592926996-47914-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1592926996-47914-7-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <d87d15fd-71d5-6735-74df-583024826ab0@linux.intel.com>
Date:   Thu, 25 Jun 2020 18:10:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1592926996-47914-7-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2020/6/23 23:43, Jacob Pan wrote:
> For guest requested IOTLB invalidation, address and mask are provided as
> part of the invalidation data. VT-d HW silently ignores any address bits
> below the mask. SW shall also allow such case but give warning if
> address does not align with the mask. This patch relax the fault
> handling from error to warning and proceed with invalidation request
> with the given mask.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 5ea5732d5ec4..50fc62413a35 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5439,13 +5439,12 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
>   
>   		switch (BIT(cache_type)) {
>   		case IOMMU_CACHE_INV_TYPE_IOTLB:
> +			/* HW will ignore LSB bits based on address mask */
>   			if (inv_info->granularity == IOMMU_INV_GRANU_ADDR &&
>   			    size &&
>   			    (inv_info->addr_info.addr & ((BIT(VTD_PAGE_SHIFT + size)) - 1))) {
> -				pr_err_ratelimited("Address out of range, 0x%llx, size order %llu\n",
> -						   inv_info->addr_info.addr, size);
> -				ret = -ERANGE;
> -				goto out_unlock;
> +				WARN_ONCE(1, "Address out of range, 0x%llx, size order %llu\n",
> +					  inv_info->addr_info.addr, size);

I don't think WARN_ONCE() is suitable here. It makes users think it's a
kernel bug. How about pr_warn_ratelimited()?

Best regards,
baolu

>   			}
>   
>   			/*
> 
