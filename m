Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3508C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 08:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F98D20738
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 08:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xen.org header.i=@xen.org header.b="M5yzdliQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgEUIKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 04:10:06 -0400
Received: from mail.xenproject.org ([104.130.215.37]:53912 "EHLO
        mail.xenproject.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbgEUIKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 04:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
        s=20200302mail; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LzQcau/CTPhcsq7cGzAcVt098Z2d/I8LKnftpNJpgSo=; b=M5yzdliQtL6ecGvEyiMqU8gcmm
        VZCqgzHHR+lWgFbOO+SHL+yg3mG+eAAvKtIgwwZ4Sp5OsroQvTtvRs3AoSF4Rh9rom3+W0BAxUp4z
        uod9wfTjCWD0T8VM8sHHqldWI8WUDt/bDkzv1Iqct/fHvpGlM6u9pAfLNEoF7eTsDxYw=;
Received: from xenbits.xenproject.org ([104.239.192.120])
        by mail.xenproject.org with esmtp (Exim 4.92)
        (envelope-from <julien@xen.org>)
        id 1jbg8z-0004CT-E1; Thu, 21 May 2020 08:01:33 +0000
Received: from 54-240-197-225.amazon.com ([54.240.197.225] helo=a483e7b01a66.ant.amazon.com)
        by xenbits.xenproject.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <julien@xen.org>)
        id 1jbg8z-0006PQ-6i; Thu, 21 May 2020 08:01:33 +0000
Subject: Re: [PATCH 01/10] swiotlb-xen: use vmalloc_to_page on vmalloc virt
 addresses
To:     Stefano Stabellini <sstabellini@kernel.org>, jgross@suse.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
References: <alpine.DEB.2.21.2005201628330.27502@sstabellini-ThinkPad-T480s>
 <20200520234520.22563-1-sstabellini@kernel.org>
From:   Julien Grall <julien@xen.org>
Message-ID: <23e5b6d8-c5d9-b43f-41cd-9d02d8ec0a7f@xen.org>
Date:   Thu, 21 May 2020 09:01:31 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520234520.22563-1-sstabellini@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21/05/2020 00:45, Stefano Stabellini wrote:
> From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> 
> Don't just assume that virt_to_page works on all virtual addresses.
> Instead add a is_vmalloc_addr check and use vmalloc_to_page on vmalloc
> virt addresses.

Can you provide an example where swiotlb is used with vmalloc()?

> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
> ---
>   drivers/xen/swiotlb-xen.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index b6d27762c6f8..a42129cba36e 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -335,6 +335,7 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
>   	int order = get_order(size);
>   	phys_addr_t phys;
>   	u64 dma_mask = DMA_BIT_MASK(32);
> +	struct page *pg;
>   
>   	if (hwdev && hwdev->coherent_dma_mask)
>   		dma_mask = hwdev->coherent_dma_mask;
> @@ -346,9 +347,11 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
>   	/* Convert the size to actually allocated. */
>   	size = 1UL << (order + XEN_PAGE_SHIFT);
>   
> +	pg = is_vmalloc_addr(vaddr) ? vmalloc_to_page(vaddr) :
> +				      virt_to_page(vaddr);

Common DMA code seems to protect this check with CONFIG_DMA_REMAP. Is it 
something we want to do it here as well? Or is there any other condition 
where vmalloc can happen?

>   	if (!WARN_ON((dev_addr + size - 1 > dma_mask) ||
>   		     range_straddles_page_boundary(phys, size)) &&
> -	    TestClearPageXenRemapped(virt_to_page(vaddr)))
> +	    TestClearPageXenRemapped(pg))
>   		xen_destroy_contiguous_region(phys, order);
>   
>   	xen_free_coherent_pages(hwdev, size, vaddr, (dma_addr_t)phys, attrs);
> 

Cheers,

-- 
Julien Grall
