Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19076C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E514721741
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598000484;
	bh=PGxw16Sb15h4INR8rVD1HKJzCXHduThJtSaBTgYEwQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HihtO2TaUBl5UdPHYSZ4HOm6Rbk7+HNLz28wiVtf2a5HOkUG6ZpnmtJ08Ba04TQw8
	 tUTHfv4LIsahbHW0qz7dhxZ13VyUhkBXhB4GSoqO9DDoIB/omz8toFM813q55GOC1J
	 j0KyyDNJ/Ta2imAP77SGmJpVBhr93W+0UhC89E1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgHUJBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 05:01:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:42122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgHUJBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 05:01:22 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DF6C20578;
        Fri, 21 Aug 2020 09:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598000481;
        bh=PGxw16Sb15h4INR8rVD1HKJzCXHduThJtSaBTgYEwQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f798jvHppuLjWlvS5plc4g84ly/Jkcfa4C7HL9B7ytEenJk95uzyKx44D5wL25KH0
         9W9yuKvfjYApvHGKh9Vjwqn+0d/ea93GtAdK8xnzlLdVQdGpI+tNFC4besQOJtfaFE
         TEYT+mr5RWQw3VXjZXrYoE6sm2dLC+MlCIiPSdxk=
Date:   Fri, 21 Aug 2020 10:01:16 +0100
From:   Will Deacon <will@kernel.org>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        ganapatrao.kulkarni@cavium.com, catalin.marinas@arm.com,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        huangdaode@huawei.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Steve Capper <steve.capper@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v6 2/2] arm64: mm: reserve per-numa CMA to localize
 coherent dma buffers
Message-ID: <20200821090116.GB20255@willie-the-truck>
References: <20200821022615.28596-1-song.bao.hua@hisilicon.com>
 <20200821022615.28596-3-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821022615.28596-3-song.bao.hua@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 02:26:15PM +1200, Barry Song wrote:
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
>  -v6: rebase on top of 5.9-rc1
> 
>  arch/arm64/mm/init.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 481d22c32a2e..f1c75957ff3c 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -429,6 +429,8 @@ void __init bootmem_init(void)
>  	arm64_hugetlb_cma_reserve();
>  #endif
>  
> +	dma_pernuma_cma_reserve();

I think will have to do for now, but I still wish that more of this was
driven from the core code so that we don't have to worry about
initialisation order and whether things are early/late enough on a per-arch
basis.

Acked-by: Will Deacon <will@kernel.org>

Will
