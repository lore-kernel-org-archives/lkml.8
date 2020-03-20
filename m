Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE87C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871FF20739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbgCTNtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:49:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:61578 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727145AbgCTNtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:49:21 -0400
IronPort-SDR: 0H5ZmHhu5ZMmrCuxWlDy9P48iO8L2+0Z2IBEcyfV9Fqfw2oENczXLcNLEZ8Lg5DlrmKgqkP1uI
 Fh0ZigJKKuVQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 06:49:20 -0700
IronPort-SDR: sx8ITNZSnTwMSq0Hf11ksubXWWL+gSxYwn3+ZlxE2Xk3nIRX2yipZAer6kDd320RKO3JbYmLJG
 XLeN3VLsdtBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,284,1580803200"; 
   d="scan'208";a="237234433"
Received: from che5-mobl.ccr.corp.intel.com (HELO [10.254.213.15]) ([10.254.213.15])
  by fmsmga007.fm.intel.com with ESMTP; 20 Mar 2020 06:49:18 -0700
Cc:     baolu.lu@linux.intel.com, Raj Ashok <ashok.raj@intel.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 2/3] iommu/vt-d: Fix mm reference leak
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <1584678751-43169-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1584678751-43169-3-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <75592c19-309f-2626-68c9-1e74232be28e@linux.intel.com>
Date:   Fri, 20 Mar 2020 21:49:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1584678751-43169-3-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/20 12:32, Jacob Pan wrote:
> Move canonical address check before mmget_not_zero() to avoid mm
> reference leak.
> 
> Fixes: 9d8c3af31607 ("iommu/vt-d: IOMMU Page Request needs to check if
> address is canonical.")
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel-svm.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 1483f1845762..56253c59ca10 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -861,14 +861,15 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>   		 * any faults on kernel addresses. */
>   		if (!svm->mm)
>   			goto bad_req;
> -		/* If the mm is already defunct, don't handle faults. */
> -		if (!mmget_not_zero(svm->mm))
> -			goto bad_req;
>   
>   		/* If address is not canonical, return invalid response */
>   		if (!is_canonical_address(address))
>   			goto bad_req;
>   
> +		/* If the mm is already defunct, don't handle faults. */
> +		if (!mmget_not_zero(svm->mm))
> +			goto bad_req;
> +
>   		down_read(&svm->mm->mmap_sem);
>   		vma = find_extend_vma(svm->mm, address);
>   		if (!vma || address < vma->vm_start)
> 
