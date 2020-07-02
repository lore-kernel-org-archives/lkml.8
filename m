Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6166CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 00:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FAC8207F5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 00:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgGBA7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 20:59:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:36580 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbgGBA7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 20:59:38 -0400
IronPort-SDR: E39jGFPxKgcQR13ZbuAHIdV5uR3poGiAjRuL0VO9y88aiSPNS2Cy5oXUclwdyfTsgfeWgJ247H
 0tfwQIiFWA5w==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="134215309"
X-IronPort-AV: E=Sophos;i="5.75,302,1589266800"; 
   d="scan'208";a="134215309"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 17:59:37 -0700
IronPort-SDR: k5ecF3Q6zcI3nWdx6Qxil4zw34HSk4hd+mydaYVi7w6tm8PQg46p6c+8WxquLmwqn9ztPbCacq
 Z4wN3zre0KZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,302,1589266800"; 
   d="scan'208";a="304061442"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by fmsmga004.fm.intel.com with ESMTP; 01 Jul 2020 17:59:34 -0700
Cc:     baolu.lu@linux.intel.com, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v3 6/7] iommu/vt-d: Warn on out-of-range invalidation
 address
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <1593617636-79385-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1593617636-79385-7-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <a960a831-e763-6ee6-e012-64f8acb365b6@linux.intel.com>
Date:   Thu, 2 Jul 2020 08:55:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1593617636-79385-7-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/20 11:33 PM, Jacob Pan wrote:
> For guest requested IOTLB invalidation, address and mask are provided as
> part of the invalidation data. VT-d HW silently ignores any address bits
> below the mask. SW shall also allow such case but give warning if
> address does not align with the mask. This patch relax the fault
> handling from error to warning and proceed with invalidation request
> with the given mask.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Fixes: 6ee1b77ba3ac0 ("iommu/vt-d: Add svm/sva invalidate function")
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel/iommu.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 6a0c62c7395c..2e1b53ade784 100644
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
> +				pr_err_ratelimited("User address not aligned, 0x%llx, size order %llu\n",
> +					  inv_info->addr_info.addr, size);
>   			}
>   
>   			/*
> 
