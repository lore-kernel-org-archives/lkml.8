Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF6BC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CBC520722
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgCTNpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:45:31 -0400
Received: from mga07.intel.com ([134.134.136.100]:55352 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbgCTNpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:45:30 -0400
IronPort-SDR: hUZ8VycuTPqQm9rjkXI3yxRF82TF768XR3aaKmiJyuVsA3vT3QI0NhVM7L3W0JtrZwdqAw/xij
 qK312uKEyNKg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 06:45:30 -0700
IronPort-SDR: XWCIulE6yp6+th/bs8uRmyMAA5ISs6gfuFSfB8z5/OVeQIRotVXpkmp9N/LI2idKxn7gzysC3Y
 cJ1GhGhTDDbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,284,1580803200"; 
   d="scan'208";a="237234057"
Received: from che5-mobl.ccr.corp.intel.com (HELO [10.254.213.15]) ([10.254.213.15])
  by fmsmga007.fm.intel.com with ESMTP; 20 Mar 2020 06:45:27 -0700
Cc:     baolu.lu@linux.intel.com, Raj Ashok <ashok.raj@intel.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 1/3] iommu/vt-d: Remove redundant IOTLB flush
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <1584678751-43169-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1584678751-43169-2-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <26ab1917-f087-aafa-e861-6a2478000a6f@linux.intel.com>
Date:   Fri, 20 Mar 2020 21:45:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1584678751-43169-2-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/20 12:32, Jacob Pan wrote:
> IOTLB flush already included in the PASID tear down process. There
> is no need to flush again.

It seems that intel_pasid_tear_down_entry() doesn't flush the pasid
based device TLB?

Best regards,
baolu

> 
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   drivers/iommu/intel-svm.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 8f42d717d8d7..1483f1845762 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -268,10 +268,9 @@ static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
>   	 * *has* to handle gracefully without affecting other processes.
>   	 */
>   	rcu_read_lock();
> -	list_for_each_entry_rcu(sdev, &svm->devs, list) {
> +	list_for_each_entry_rcu(sdev, &svm->devs, list)
>   		intel_pasid_tear_down_entry(svm->iommu, sdev->dev, svm->pasid);
> -		intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
> -	}
> +
>   	rcu_read_unlock();
>   
>   }
> @@ -731,7 +730,6 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
>   			 * large and has to be physically contiguous. So it's
>   			 * hard to be as defensive as we might like. */
>   			intel_pasid_tear_down_entry(iommu, dev, svm->pasid);
> -			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
>   			kfree_rcu(sdev, rcu);
>   
>   			if (list_empty(&svm->devs)) {
> 
