Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D227C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A82420882
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgAUJ4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 04:56:11 -0500
Received: from foss.arm.com ([217.140.110.172]:40396 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728797AbgAUJ4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:56:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB75E1FB;
        Tue, 21 Jan 2020 01:56:10 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C87D3F6C4;
        Tue, 21 Jan 2020 01:56:07 -0800 (PST)
Subject: Re: [Patch v3 3/3] iommu: avoid taking iova_rbtree_lock twice
To:     Cong Wang <xiyou.wangcong@gmail.com>,
        iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, joro@8bytes.org,
        John Garry <john.garry@huawei.com>
References: <20191218043951.10534-1-xiyou.wangcong@gmail.com>
 <20191218043951.10534-4-xiyou.wangcong@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <2ff1002c-28b3-a863-49d2-3eab5b5ea778@arm.com>
Date:   Tue, 21 Jan 2020 09:56:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191218043951.10534-4-xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/12/2019 4:39 am, Cong Wang wrote:
> Both find_iova() and __free_iova() take iova_rbtree_lock,
> there is no reason to take and release it twice inside
> free_iova().
> 
> Fold them into one critical section by calling the unlock
> versions instead.

Makes sense to me.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: John Garry <john.garry@huawei.com>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> ---
>   drivers/iommu/iova.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 184d4c0e20b5..f46f8f794678 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -390,10 +390,14 @@ EXPORT_SYMBOL_GPL(__free_iova);
>   void
>   free_iova(struct iova_domain *iovad, unsigned long pfn)
>   {
> -	struct iova *iova = find_iova(iovad, pfn);
> +	unsigned long flags;
> +	struct iova *iova;
>   
> +	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
> +	iova = private_find_iova(iovad, pfn);
>   	if (iova)
> -		__free_iova(iovad, iova);
> +		private_free_iova(iovad, iova);
> +	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
>   
>   }
>   EXPORT_SYMBOL_GPL(free_iova);
> 
