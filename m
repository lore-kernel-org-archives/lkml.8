Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20F1C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 00:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B6102177B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 00:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbgIIAvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 20:51:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:22693 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728363AbgIIAvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 20:51:21 -0400
IronPort-SDR: UEjRTOMSJrxi11+hsedHtycIAkrH73nr6OVMXYFrz8xjSBz0OoHSO9+RS3ShJ+CjE4DRGzShO7
 Q0Gt6GjDDvLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="157525453"
X-IronPort-AV: E=Sophos;i="5.76,407,1592895600"; 
   d="scan'208";a="157525453"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 17:51:21 -0700
IronPort-SDR: neuHOgq9l1gHuCN25qtE8sAqX/QJU8vSfuki6yo9jisO826Aixw7SHAUEIC0MEaTOWf29qdjUq
 ydr8xTMMTFVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,407,1592895600"; 
   d="scan'208";a="407307247"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by fmsmga001.fm.intel.com with ESMTP; 08 Sep 2020 17:51:19 -0700
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/5] iommu: Add iommu_dma_free_cpu_cached_iovas
 function
To:     Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org
References: <20200903201839.7327-1-murphyt7@tcd.ie>
 <20200903201839.7327-3-murphyt7@tcd.ie>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <b30be538-a4dd-987e-78df-ff23b703bbe3@linux.intel.com>
Date:   Wed, 9 Sep 2020 08:45:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903201839.7327-3-murphyt7@tcd.ie>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/20 4:18 AM, Tom Murphy wrote:
> to dma-iommu ops
> 
> Add a iommu_dma_free_cpu_cached_iovas function to allow drivers which
> use the dma-iommu ops to free cached cpu iovas.
> 
> Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
> ---
>   drivers/iommu/dma-iommu.c | 9 +++++++++
>   include/linux/dma-iommu.h | 3 +++
>   2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index f69dc9467d71..33f3f4f5edc5 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -50,6 +50,15 @@ struct iommu_dma_cookie {
>   	struct iommu_domain		*fq_domain;
>   };
>   
> +void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
> +		struct iommu_domain *domain)
> +{
> +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> +	struct iova_domain *iovad = &cookie->iovad;
> +
> +	free_cpu_cached_iovas(cpu, iovad);
> +}
> +
>   static void iommu_dma_entry_dtor(unsigned long data)
>   {
>   	struct page *freelist = (struct page *)data;
> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> index 2112f21f73d8..316d22a4a860 100644
> --- a/include/linux/dma-iommu.h
> +++ b/include/linux/dma-iommu.h
> @@ -37,6 +37,9 @@ void iommu_dma_compose_msi_msg(struct msi_desc *desc,
>   
>   void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
>   
> +void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
> +		struct iommu_domain *domain);
> +
>   #else /* CONFIG_IOMMU_DMA */
>   
>   struct iommu_domain;
> 

I will add below in the next version:

diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 37df037788f0..ab4bffea3aaa 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -81,5 +81,10 @@ static inline void iommu_dma_get_resv_regions(struct 
device *dev, struct list_he
  {
  }

+static inline void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
+                                                  struct iommu_domain 
*domain)
+{
+}
+
  #endif /* CONFIG_IOMMU_DMA */
  #endif /* __DMA_IOMMU_H */

Others looks good to me.

Best regards,
baolu
