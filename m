Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CABC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 330DF20882
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbgAUJwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 04:52:17 -0500
Received: from foss.arm.com ([217.140.110.172]:40292 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727220AbgAUJwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:52:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4599B1FB;
        Tue, 21 Jan 2020 01:52:16 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C9023F6C4;
        Tue, 21 Jan 2020 01:52:15 -0800 (PST)
Subject: Re: [Patch v3 2/3] iommu: optimize iova_magazine_free_pfns()
To:     Cong Wang <xiyou.wangcong@gmail.com>,
        iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, joro@8bytes.org,
        John Garry <john.garry@huawei.com>
References: <20191218043951.10534-1-xiyou.wangcong@gmail.com>
 <20191218043951.10534-3-xiyou.wangcong@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8ce2f5b6-74e1-9a74-fd80-9ad688beb9b2@arm.com>
Date:   Tue, 21 Jan 2020 09:52:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191218043951.10534-3-xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/12/2019 4:39 am, Cong Wang wrote:
> If the magazine is empty, iova_magazine_free_pfns() should
> be a nop, however it misses the case of mag->size==0. So we
> should just call iova_magazine_empty().
> 
> This should reduce the contention on iovad->iova_rbtree_lock
> a little bit, not much at all.

Have you measured that in any way? AFAICS the only time this can get 
called with a non-full magazine is in the CPU hotplug callback, where 
the impact of taking the rbtree lock and immediately releasing it seems 
unlikely to be significant on top of everything else involved in that 
operation.

Robin.

> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: John Garry <john.garry@huawei.com>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> ---
>   drivers/iommu/iova.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index cb473ddce4cf..184d4c0e20b5 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -797,13 +797,23 @@ static void iova_magazine_free(struct iova_magazine *mag)
>   	kfree(mag);
>   }
>   
> +static bool iova_magazine_full(struct iova_magazine *mag)
> +{
> +	return (mag && mag->size == IOVA_MAG_SIZE);
> +}
> +
> +static bool iova_magazine_empty(struct iova_magazine *mag)
> +{
> +	return (!mag || mag->size == 0);
> +}
> +
>   static void
>   iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
>   {
>   	unsigned long flags;
>   	int i;
>   
> -	if (!mag)
> +	if (iova_magazine_empty(mag))
>   		return;
>   
>   	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
> @@ -820,16 +830,6 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
>   	mag->size = 0;
>   }
>   
> -static bool iova_magazine_full(struct iova_magazine *mag)
> -{
> -	return (mag && mag->size == IOVA_MAG_SIZE);
> -}
> -
> -static bool iova_magazine_empty(struct iova_magazine *mag)
> -{
> -	return (!mag || mag->size == 0);
> -}
> -
>   static unsigned long iova_magazine_pop(struct iova_magazine *mag,
>   				       unsigned long limit_pfn)
>   {
> 
