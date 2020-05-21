Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3293C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FC04207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgEUUQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 16:16:33 -0400
Received: from foss.arm.com ([217.140.110.172]:52854 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgEUUQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:16:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99CC130E;
        Thu, 21 May 2020 13:16:32 -0700 (PDT)
Received: from [10.57.0.164] (unknown [10.57.0.164])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 880AF3F305;
        Thu, 21 May 2020 13:16:31 -0700 (PDT)
Subject: Re: [PATCH] iommu/dma: limit iova free size to unmmaped iova
To:     Prakash Gupta <guptap@codeaurora.org>, akpm@linux-foundation.org,
        mhocko@suse.com, joro@8bytes.org
Cc:     linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20200521113004.12438-1-guptap@codeaurora.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <7aaa8dcc-6a47-f256-431d-2a1b034b4076@arm.com>
Date:   Thu, 21 May 2020 21:16:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521113004.12438-1-guptap@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-21 12:30, Prakash Gupta wrote:
> Limit the iova size while freeing based on unmapped size. In absence of
> this even with unmap failure, invalid iova is pushed to iova rcache and
> subsequently can cause panic while rcache magazine is freed.

Can you elaborate on that panic?

> Signed-off-by: Prakash Gupta <guptap@codeaurora.org>
> 
> :100644 100644 4959f5df21bd 098f7d377e04 M	drivers/iommu/dma-iommu.c
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 4959f5df21bd..098f7d377e04 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -472,7 +472,8 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
>   
>   	if (!cookie->fq_domain)
>   		iommu_tlb_sync(domain, &iotlb_gather);
> -	iommu_dma_free_iova(cookie, dma_addr, size);
> +	if (unmapped)
> +		iommu_dma_free_iova(cookie, dma_addr, unmapped);

Frankly, if any part of the unmap fails then things have gone 
catastrophically wrong already, but either way this isn't right. The 
IOVA API doesn't support partial freeing - an IOVA *must* be freed with 
its original size, or not freed at all, otherwise it will corrupt the 
state of the rcaches and risk a cascade of further misbehaviour for 
future callers.

TBH my gut feeling here is that you're really just trying to treat a 
symptom of another bug elsewhere, namely some driver calling dma_unmap_* 
or dma_free_* with the wrong address or size in the first place.

Robin.

>   }
>   
>   static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
> 
