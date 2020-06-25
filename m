Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516ABC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24448206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404220AbgFYLP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 07:15:56 -0400
Received: from foss.arm.com ([217.140.110.172]:34206 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404169AbgFYLP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 07:15:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 680B21FB;
        Thu, 25 Jun 2020 04:15:55 -0700 (PDT)
Received: from [10.57.13.97] (unknown [10.57.13.97])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 571643F73C;
        Thu, 25 Jun 2020 04:15:53 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] arm64: mm: reserve per-numa CMA after numa_init
To:     Barry Song <song.bao.hua@hisilicon.com>, hch@lst.de,
        m.szyprowski@samsung.com, will@kernel.org,
        ganapatrao.kulkarni@cavium.com, catalin.marinas@arm.com
Cc:     iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Steve Capper <steve.capper@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20200625074330.13668-1-song.bao.hua@hisilicon.com>
 <20200625074330.13668-3-song.bao.hua@hisilicon.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <53b97598-6c83-1cb2-5763-4ded441403c5@arm.com>
Date:   Thu, 25 Jun 2020 12:15:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625074330.13668-3-song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-25 08:43, Barry Song wrote:
> Right now, smmu is using dma_alloc_coherent() to get memory to save queues
> and tables. Typically, on ARM64 server, there is a default CMA located at
> node0, which could be far away from node2, node3 etc.
> with this patch, smmu will get memory from local numa node to save command
> queues and page tables. that means dma_unmap latency will be shrunk much.
> Meanwhile, when iommu.passthrough is on, device drivers which call dma_
> alloc_coherent() will also get local memory and avoid the travel between
> numa nodes.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Cc: Steve Capper <steve.capper@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>   arch/arm64/mm/init.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 1e93cfc7c47a..07d4d1fe7983 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -420,6 +420,8 @@ void __init bootmem_init(void)
>   
>   	arm64_numa_init();
>   
> +	dma_pernuma_cma_reserve();
> +

It might be worth putting this after the hugetlb_cma_reserve() call for 
clarity, since the comment below applies equally to this call too.

Robin.

>   	/*
>   	 * must be done after arm64_numa_init() which calls numa_init() to
>   	 * initialize node_online_map that gets used in hugetlb_cma_reserve()
> 
