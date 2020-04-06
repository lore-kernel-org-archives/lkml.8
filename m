Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A1DC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E9B23341
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgDFNsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:48:17 -0400
Received: from foss.arm.com ([217.140.110.172]:45954 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728087AbgDFNsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 09:48:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E289106F;
        Mon,  6 Apr 2020 06:48:16 -0700 (PDT)
Received: from [10.57.55.221] (unknown [10.57.55.221])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 309FB3F73D;
        Mon,  6 Apr 2020 06:48:15 -0700 (PDT)
Subject: Re: [RFC/RFT][PATCH] dma-mapping: set default segment_boundary_mask
 to ULONG_MAX
To:     Nicolin Chen <nicoleotsuka@gmail.com>, m.szyprowski@samsung.com,
        hch@lst.de
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
References: <20200405005157.1318-1-nicoleotsuka@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <c984d2ea-6036-a8ae-97df-b5178a2a9ab9@arm.com>
Date:   Mon, 6 Apr 2020 14:48:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200405005157.1318-1-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-05 1:51 am, Nicolin Chen wrote:
> The default segment_boundary_mask was set to DMA_BIT_MAKS(32)
> a decade ago by referencing SCSI/block subsystem, as a 32-bit
> mask was good enough for most of the devices.
> 
> Now more and more drivers set dma_masks above DMA_BIT_MAKS(32)
> while only a handful of them call dma_set_seg_boundary(). This
> means that most drivers have a 4GB segmention boundary because
> DMA API returns a 32-bit default value, though they might not
> really have such a limit.
> 
> The default segment_boundary_mask should mean "no limit" since
> the device doesn't explicitly set the mask. But a 32-bit mask
> certainly limits those devices capable of 32+ bits addressing.
> 
> And this 32-bit boundary mask might result in a situation that
> when dma-iommu maps a DMA buffer (size > 4GB), iommu_map_sg()
> cuts the IOVA region into discontiguous pieces, and creates a
> faulty IOVA mapping that overlaps some physical memory outside
> the scatter list, which might lead to some random kernel panic
> after DMA overwrites that faulty IOVA space.

Once again, get rid of this paragraph - it doesn't have much to do with 
the *default* value since it describes a behaviour general to any 
boundary mask. Plus it effectively says "if a driver uses a DMA-mapped 
scatterlist incorrectly, this change can help paper over the bug", which 
is rather the opposite of a good justification.

(for example most SATA devices end up with a 64KB boundary mask, such 
that padding the IOVAs to provide the appropriate alignment happens very 
frequently, and they've been working just fine for years now)

Robin.

> So this patch sets default segment_boundary_mask to ULONG_MAX.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>   include/linux/dma-mapping.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 330ad58fbf4d..ff8cefe85f30 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -736,7 +736,7 @@ static inline unsigned long dma_get_seg_boundary(struct device *dev)
>   {
>   	if (dev->dma_parms && dev->dma_parms->segment_boundary_mask)
>   		return dev->dma_parms->segment_boundary_mask;
> -	return DMA_BIT_MASK(32);
> +	return ULONG_MAX;
>   }
>   
>   static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
> 
