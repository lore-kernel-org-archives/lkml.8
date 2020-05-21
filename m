Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D56C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 08:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E75C2070A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 08:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xen.org header.i=@xen.org header.b="dgiAhbOi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbgEUI0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 04:26:01 -0400
Received: from mail.xenproject.org ([104.130.215.37]:53968 "EHLO
        mail.xenproject.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728481AbgEUI0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 04:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
        s=20200302mail; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hXHVUCa/FWiIinv37wJMJKlq+4q06rxlpbzT5I9rDrE=; b=dgiAhbOin/mrdQK1tmYjd7ud82
        lc7lhmM+8uyQKk7hTF/rU7sIE1Xhhve5VCs8P2pGzLw9ZorI1DRN8EFZGtxH/8jbwk5j43SfvZeh7
        bSGiG1z6ZsxO3vHAhqC0tkGl5CHnhfA94ecvzTrAjWTliiIhdjonP+Rl4AyCDxER7Bvo=;
Received: from xenbits.xenproject.org ([104.239.192.120])
        by mail.xenproject.org with esmtp (Exim 4.92)
        (envelope-from <julien@xen.org>)
        id 1jbgWd-0004iC-Jl; Thu, 21 May 2020 08:25:59 +0000
Received: from 54-240-197-225.amazon.com ([54.240.197.225] helo=a483e7b01a66.ant.amazon.com)
        by xenbits.xenproject.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <julien@xen.org>)
        id 1jbgWd-0007d5-Bc; Thu, 21 May 2020 08:25:59 +0000
Subject: Re: [PATCH 10/10] xen/arm: call dma_to_phys on the dma_addr_t
 parameter of dma_cache_maint
To:     Stefano Stabellini <sstabellini@kernel.org>, jgross@suse.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
References: <alpine.DEB.2.21.2005201628330.27502@sstabellini-ThinkPad-T480s>
 <20200520234520.22563-10-sstabellini@kernel.org>
From:   Julien Grall <julien@xen.org>
Message-ID: <c8f54c6b-d59e-2e67-1647-32c730b0a124@xen.org>
Date:   Thu, 21 May 2020 09:25:57 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520234520.22563-10-sstabellini@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/05/2020 00:45, Stefano Stabellini wrote:
> From: Stefano Stabellini <stefano.stabellini@xilinx.com>
> 
> Add a struct device* parameter to dma_cache_maint.
> 
> Translate the dma_addr_t parameter of dma_cache_maint by calling
> dma_to_phys. Do it for the first page and all the following pages, in
> case of multipage handling.

The term 'page' is confusing here. Are we referring to Xen page or Linux 
page?

Also, same as patch #8 and #9 regarding the commit message.

> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
> ---
>   arch/arm/xen/mm.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
> index 7639251bcc79..6ddf3b3c1ab5 100644
> --- a/arch/arm/xen/mm.c
> +++ b/arch/arm/xen/mm.c
> @@ -43,15 +43,18 @@ unsigned long xen_get_swiotlb_free_pages(unsigned int order)
>   static bool hypercall_cflush = false;
>   
>   /* buffers in highmem or foreign pages cannot cross page boundaries */
> -static void dma_cache_maint(dma_addr_t handle, size_t size, u32 op)
> +static void dma_cache_maint(struct device *dev, dma_addr_t handle,
> +			    size_t size, u32 op)
>   {
>   	struct gnttab_cache_flush cflush;
>   
> -	cflush.a.dev_bus_addr = handle & XEN_PAGE_MASK;
>   	cflush.offset = xen_offset_in_page(handle);
>   	cflush.op = op;
> +	handle &= XEN_PAGE_MASK;
>   
>   	do {
> +		cflush.a.dev_bus_addr = dma_to_phys(dev, handle);
> +
>   		if (size + cflush.offset > XEN_PAGE_SIZE)
>   			cflush.length = XEN_PAGE_SIZE - cflush.offset;
>   		else
> @@ -60,7 +63,7 @@ static void dma_cache_maint(dma_addr_t handle, size_t size, u32 op)
>   		HYPERVISOR_grant_table_op(GNTTABOP_cache_flush, &cflush, 1);
>   
>   		cflush.offset = 0;
> -		cflush.a.dev_bus_addr += cflush.length;
> +		handle += cflush.length;
>   		size -= cflush.length;
>   	} while (size);
>   }
> @@ -79,7 +82,7 @@ void xen_dma_sync_for_cpu(struct device *dev, dma_addr_t handle,
>   	if (pfn_valid(PFN_DOWN(dma_to_phys(dev, handle))))
>   		arch_sync_dma_for_cpu(paddr, size, dir);
>   	else if (dir != DMA_TO_DEVICE)
> -		dma_cache_maint(handle, size, GNTTAB_CACHE_INVAL);
> +		dma_cache_maint(dev, handle, size, GNTTAB_CACHE_INVAL);
>   }
>   
>   void xen_dma_sync_for_device(struct device *dev, dma_addr_t handle,
> @@ -89,9 +92,9 @@ void xen_dma_sync_for_device(struct device *dev, dma_addr_t handle,
>   	if (pfn_valid(PFN_DOWN(dma_to_phys(dev, handle))))
>   		arch_sync_dma_for_device(paddr, size, dir);
>   	else if (dir == DMA_FROM_DEVICE)
> -		dma_cache_maint(handle, size, GNTTAB_CACHE_INVAL);
> +		dma_cache_maint(dev, handle, size, GNTTAB_CACHE_INVAL);
>   	else
> -		dma_cache_maint(handle, size, GNTTAB_CACHE_CLEAN);
> +		dma_cache_maint(dev, handle, size, GNTTAB_CACHE_CLEAN);
>   }
>   
>   bool xen_arch_need_swiotlb(struct device *dev,
> 

Cheers,

-- 
Julien Grall
