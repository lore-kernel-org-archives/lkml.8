Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD395C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D7020757
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389525AbgDBPsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:48:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:40392 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388677AbgDBPsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:48:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B3A6DAEAF;
        Thu,  2 Apr 2020 15:48:02 +0000 (UTC)
Subject: Re: [PATCH 1/2] mm: cma: NUMA node interface
To:     Aslan Bakirov <aslan@fb.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@fb.com, riel@surriel.com, guro@fb.com,
        mhocko@kernel.org, hannes@cmpxchg.org
References: <20200326212718.3798742-1-aslan@fb.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <65164fdb-38b0-e239-84cc-ab22b92214c5@suse.cz>
Date:   Thu, 2 Apr 2020 17:48:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200326212718.3798742-1-aslan@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/20 10:27 PM, Aslan Bakirov wrote:
> I've noticed that there is no interfaces exposed by CMA which would let me
> to declare contigous memory on particular NUMA node.
> 
> This patchset adds the ability to try to allocate contiguous memory on
> specific node.

I would say more explicitly that 'try' here means it will fallback to other
nodes if the specific one doesn't work. At least AFAICS that's what it does by
calling memblock_alloc_range_nid() with exact_nid=false.

> Implement a new method for declaring contigous memory on particular node
> and keep cma_declare_contiguous() as a wrapper.

Should there be also support for using this node spcification in the cma=X boot
param?

> Signed-off-by: Aslan Bakirov <aslan@fb.com>

...

> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -220,7 +220,7 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
>  }
>  
>  /**
> - * cma_declare_contiguous() - reserve custom contiguous area
> + * cma_declare_contiguous_nid() - reserve custom contiguous area
>   * @base: Base address of the reserved area optional, use 0 for any
>   * @size: Size of the reserved area (in bytes),
>   * @limit: End address of the reserved memory (optional, 0 for any).
> @@ -229,6 +229,7 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
>   * @fixed: hint about where to place the reserved area
>   * @name: The name of the area. See function cma_init_reserved_mem()
>   * @res_cma: Pointer to store the created cma region.
> + * @nid: nid of the free area to find, %NUMA_NO_NODE for any node

The bit about fallback should be also specified here.

>   *
>   * This function reserves memory from early allocator. It should be
>   * called by arch specific code once the early allocator (memblock or bootmem)
> @@ -238,10 +239,10 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
>   * If @fixed is true, reserve contiguous area at exactly @base.  If false,
>   * reserve in range from @base to @limit.
>   */
> -int __init cma_declare_contiguous(phys_addr_t base,
> +int __init cma_declare_contiguous_nid(phys_addr_t base,
>  			phys_addr_t size, phys_addr_t limit,
>  			phys_addr_t alignment, unsigned int order_per_bit,
> -			bool fixed, const char *name, struct cma **res_cma)
> +			bool fixed, const char *name, struct cma **res_cma, int nid)
>  {
>  	phys_addr_t memblock_end = memblock_end_of_DRAM();
>  	phys_addr_t highmem_start;
