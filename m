Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8FEC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 09:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11BCA2166E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 09:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lo3rwbgE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgBDJe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 04:34:59 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59702 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgBDJe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 04:34:59 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0149YbZM070502;
        Tue, 4 Feb 2020 03:34:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580808877;
        bh=0YLT5G2KDDkaXYmv/lijgenq70L6rJ93LRjbmt0OMok=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=lo3rwbgEe/PjhcxYvDiI14ysBcjXhMf+d211fVU0G0lHMuWdy4vM8sFKX21HJF4rA
         vIGJAK+1evNgkugBYeW0Fi8gNJ9A+zNLHUBoc2TAnS7WS17WyCMP0y3huK1ehAQFTV
         ylfU80fWWkvf5MXpzHIZIT+VOQlZxxG+WTcb9wa8=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0149YbJL077913
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Feb 2020 03:34:37 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 4 Feb
 2020 03:34:37 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 4 Feb 2020 03:34:37 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0149YZ1A087824;
        Tue, 4 Feb 2020 03:34:35 -0600
Subject: Re: [PATCH] dma-direct: relax addressability checks in
 dma_direct_supported
To:     Christoph Hellwig <hch@lst.de>, <iommu@lists.linux-foundation.org>
CC:     <robin.murphy@arm.com>, <m.szyprowski@samsung.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200203171601.539254-1-hch@lst.de>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <1011c272-9527-9e61-4954-c7e27cd1fcb6@ti.com>
Date:   Tue, 4 Feb 2020 11:34:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200203171601.539254-1-hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 03/02/2020 19.16, Christoph Hellwig wrote:
> dma_direct_supported tries to find the minimum addressable bitmask
> based on the end pfn and optional magic that architectures can use
> to communicate the size of the magic ZONE_DMA that can be used
> for bounce buffering.  But between the DMA offsets that can change
> per device (or sometimes even region), the fact the ZONE_DMA isn't
> even guaranteed to be the lowest addresses and failure of having
> proper interfaces to the MM code this fails at least for one
> arm subarchitecture.
> 
> As all the legacy DMA implementations have supported 32-bit DMA
> masks, and 32-bit masks are guranteed to always work by the API
> contract (using bounce buffers if needed), we can short cut the
> complicated check and always return true without breaking existing
> assumptions.  Hopefully we can properly clean up the interaction
> with the arch defined zones and the bootmem allocator eventually.
> 
> Fixes: ad3c7b18c5b3 ("arm: use swiotlb for bounce buffering on LPAE configs")
> Reported-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Thank you for the proper patch, I can reaffirm my Tested-by.
We have also tested remoteproc on k2, which got broken as well.

Thanks again,
- Péter

> ---
>  kernel/dma/direct.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 04f308a47fc3..efab894c1679 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -464,28 +464,26 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
>  }
>  #endif /* CONFIG_MMU */
>  
> -/*
> - * Because 32-bit DMA masks are so common we expect every architecture to be
> - * able to satisfy them - either by not supporting more physical memory, or by
> - * providing a ZONE_DMA32.  If neither is the case, the architecture needs to
> - * use an IOMMU instead of the direct mapping.
> - */
>  int dma_direct_supported(struct device *dev, u64 mask)
>  {
> -	u64 min_mask;
> -
> -	if (IS_ENABLED(CONFIG_ZONE_DMA))
> -		min_mask = DMA_BIT_MASK(zone_dma_bits);
> -	else
> -		min_mask = DMA_BIT_MASK(32);
> +	u64 min_mask = (max_pfn - 1) << PAGE_SHIFT;
>  
> -	min_mask = min_t(u64, min_mask, (max_pfn - 1) << PAGE_SHIFT);
> +	/*
> +	 * Because 32-bit DMA masks are so common we expect every architecture
> +	 * to be able to satisfy them - either by not supporting more physical
> +	 * memory, or by providing a ZONE_DMA32.  If neither is the case, the
> +	 * architecture needs to use an IOMMU instead of the direct mapping.
> +	 */
> +	if (mask >= DMA_BIT_MASK(32))
> +		return 1;
>  
>  	/*
>  	 * This check needs to be against the actual bit mask value, so
>  	 * use __phys_to_dma() here so that the SME encryption mask isn't
>  	 * part of the check.
>  	 */
> +	if (IS_ENABLED(CONFIG_ZONE_DMA))
> +		min_mask = min_t(u64, min_mask, DMA_BIT_MASK(zone_dma_bits));
>  	return mask >= __phys_to_dma(dev, min_mask);
>  }
>  
> 

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
