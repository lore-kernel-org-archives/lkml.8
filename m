Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7D9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 08:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 537E320759
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 08:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xen.org header.i=@xen.org header.b="GUZo9Faz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgEUISj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 04:18:39 -0400
Received: from mail.xenproject.org ([104.130.215.37]:53938 "EHLO
        mail.xenproject.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728473AbgEUISj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 04:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
        s=20200302mail; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eaQg7A9nmVi1QmaGDxLtL8MFACOo/B2TJw/SJawKC+A=; b=GUZo9FazFxZSxKd+FOJykkk6iR
        ft986fw1d+t4MM0L17Mc3bMzOa6eTJEFNAZXMNnsRs5LyxArZp9tRwrtrfc6YDYkjko+A+ixiieRj
        fDJWdmUATQn+Lyi1010A53/Hl1nCmPSj/bPn4V/xMvMXabBtglTgOwrqCOA5ZHynXwFU=;
Received: from xenbits.xenproject.org ([104.239.192.120])
        by mail.xenproject.org with esmtp (Exim 4.92)
        (envelope-from <julien@xen.org>)
        id 1jbgPV-0004ZD-Vs; Thu, 21 May 2020 08:18:37 +0000
Received: from 54-240-197-225.amazon.com ([54.240.197.225] helo=a483e7b01a66.ant.amazon.com)
        by xenbits.xenproject.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <julien@xen.org>)
        id 1jbgPV-0007G4-OR; Thu, 21 May 2020 08:18:37 +0000
Subject: Re: [PATCH 09/10] xen/arm: introduce phys/dma translations in
 xen_dma_sync_for_*
To:     Stefano Stabellini <sstabellini@kernel.org>, jgross@suse.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
References: <alpine.DEB.2.21.2005201628330.27502@sstabellini-ThinkPad-T480s>
 <20200520234520.22563-9-sstabellini@kernel.org>
From:   Julien Grall <julien@xen.org>
Message-ID: <83c1120f-fe63-dc54-7b82-15a91c748de8@xen.org>
Date:   Thu, 21 May 2020 09:18:35 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520234520.22563-9-sstabellini@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21/05/2020 00:45, Stefano Stabellini wrote:
> From: Stefano Stabellini <stefano.stabellini@xilinx.com>
> 
> Add phys_to_dma/dma_to_phys calls to
> xen_dma_sync_for_cpu, xen_dma_sync_for_device, and
> xen_arch_need_swiotlb.
> 
> In xen_arch_need_swiotlb, take the opportunity to switch to the simpler
> pfn_valid check we use everywhere else.
> 
> dma_cache_maint is fixed by the next patch.

Like patch #8, this explains what the code is doing not why this is 
necessary.

> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
> ---
>   arch/arm/xen/mm.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
> index f2414ea40a79..7639251bcc79 100644
> --- a/arch/arm/xen/mm.c
> +++ b/arch/arm/xen/mm.c
> @@ -1,5 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   #include <linux/cpu.h>
> +#include <linux/dma-direct.h>
>   #include <linux/dma-noncoherent.h>
>   #include <linux/gfp.h>
>   #include <linux/highmem.h>
> @@ -75,7 +76,7 @@ void xen_dma_sync_for_cpu(struct device *dev, dma_addr_t handle,
>   			  phys_addr_t paddr, size_t size,
>   			  enum dma_data_direction dir)
>   {
> -	if (pfn_valid(PFN_DOWN(handle)))
> +	if (pfn_valid(PFN_DOWN(dma_to_phys(dev, handle))))
>   		arch_sync_dma_for_cpu(paddr, size, dir);
>   	else if (dir != DMA_TO_DEVICE)
>   		dma_cache_maint(handle, size, GNTTAB_CACHE_INVAL);
> @@ -85,7 +86,7 @@ void xen_dma_sync_for_device(struct device *dev, dma_addr_t handle,
>   			     phys_addr_t paddr, size_t size,
>   			     enum dma_data_direction dir)
>   {
> -	if (pfn_valid(PFN_DOWN(handle)))
> +	if (pfn_valid(PFN_DOWN(dma_to_phys(dev, handle))))
>   		arch_sync_dma_for_device(paddr, size, dir);
>   	else if (dir == DMA_FROM_DEVICE)
>   		dma_cache_maint(handle, size, GNTTAB_CACHE_INVAL);
> @@ -97,8 +98,7 @@ bool xen_arch_need_swiotlb(struct device *dev,
>   			   phys_addr_t phys,
>   			   dma_addr_t dev_addr)
>   {
> -	unsigned int xen_pfn = XEN_PFN_DOWN(phys);
> -	unsigned int bfn = XEN_PFN_DOWN(dev_addr);
> +	unsigned int bfn = XEN_PFN_DOWN(dma_to_phys(dev, dev_addr));
>   
>   	/*
>   	 * The swiotlb buffer should be used if
> @@ -115,7 +115,7 @@ bool xen_arch_need_swiotlb(struct device *dev,
>   	 * require a bounce buffer because the device doesn't support coherent
>   	 * memory and we are not able to flush the cache.
>   	 */
> -	return (!hypercall_cflush && (xen_pfn != bfn) &&
> +	return (!hypercall_cflush && !pfn_valid(bfn) &&

I believe this change is incorrect. The bfn is a frame based on Xen page 
granularity (always 4K) while pfn_valid() is expecting a frame based on 
the Kernel page granularity.

>   		!dev_is_dma_coherent(dev));
>   }
>   
> 

Cheers,

-- 
Julien Grall
