Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A695AC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 14:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70B3D22261
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 14:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbgIIMf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 08:35:59 -0400
Received: from foss.arm.com ([217.140.110.172]:42528 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730166AbgIIMae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 08:30:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86F7C31B;
        Wed,  9 Sep 2020 05:05:54 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A4743F68F;
        Wed,  9 Sep 2020 05:05:52 -0700 (PDT)
Subject: Re: [PATCH] iommu/dma: Fix IOVA reserve dma ranges
To:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, poza@codeaurora.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20200909053234.17027-1-srinath.mannam@broadcom.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <1996b772-774c-3475-05cc-77ae87176c3f@arm.com>
Date:   Wed, 9 Sep 2020 13:05:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200909053234.17027-1-srinath.mannam@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-09 06:32, Srinath Mannam wrote:
> Fix IOVA reserve failure for memory regions listed in dma-ranges in the
> following cases.
> 
> - start address of memory region is 0x0.

That's fair enough, and in fact generalises to the case of zero-sized 
gaps between regions, which is indeed an oversight.

> - end address of a memory region is equal to start address of next memory
>    region.

This part doesn't make much sense, however - if the regions described in 
bridge->dma_ranges overlap, that's a bug in whoever created a malformed 
list to begin with. Possibly it's just poor wording, and you're using 
"memory regions" to refer to any or all of the dma_ranges, the reserved 
IOVA ranges, and what "start" and "end" in this function represent which 
isn't quite either of those.

> Fixes: aadad097cd46f ("iommu/dma: Reserve IOVA for PCIe inaccessible DMA address")
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> ---
>   drivers/iommu/dma-iommu.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 5141d49a046b..0a3f67a4f9ae 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -213,14 +213,21 @@ static int iova_reserve_pci_windows(struct pci_dev *dev,
>   	resource_list_for_each_entry(window, &bridge->dma_ranges) {
>   		end = window->res->start - window->offset;
>   resv_iova:
> +		if (end < start) {
> +			/* dma_ranges list should be sorted */
> +			dev_err(&dev->dev, "Failed to reserve IOVA\n");
> +			return -EINVAL;
> +		}
> +		/*
> +		 * Skip the cases when start address of first memory region is
> +		 * 0x0 and end address of one memory region and start address
> +		 * of next memory region are equal. Reserve IOVA for rest of
> +		 * addresses fall in between given memory ranges.
> +		 */
>   		if (end > start) {
>   			lo = iova_pfn(iovad, start);
>   			hi = iova_pfn(iovad, end);
>   			reserve_iova(iovad, lo, hi);
> -		} else {

Surely this only needs to be a one-liner?

-		} else {
+		} else if (end < start) {

(or possibly "end != start"; I can't quite decide which expresses the 
semantic intent better)

The rest just looks like unnecessary churn - I don't think it needs 
commenting that a sorted list may simply not have gaps between entries, 
and as above I think the wording of that comment is actively misleading.

Robin.

> -			/* dma_ranges list should be sorted */
> -			dev_err(&dev->dev, "Failed to reserve IOVA\n");
> -			return -EINVAL;
>   		}
>   
>   		start = window->res->end - window->offset + 1;
> 
