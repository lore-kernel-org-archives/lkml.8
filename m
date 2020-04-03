Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB82C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 05:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB0A20787
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 05:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731717AbgDCFCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 01:02:06 -0400
Received: from mga17.intel.com ([192.55.52.151]:20691 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbgDCFCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 01:02:06 -0400
IronPort-SDR: O8xLMeYf14TD73piVKGB74kFRYvCe1XdnMOcuTBiv6WpEASzC5mv7yXixWoNA0AE1v0UypAXex
 fxDgZU+v623g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 22:02:06 -0700
IronPort-SDR: wVAj0boRKaVvcWLHDA4SgZCYPyph4x+R+IwzFUvvlnx8Uj1b8K3Kg47nH1vixyzDxtaRijOYks
 w2up/a9C6qdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,338,1580803200"; 
   d="scan'208";a="451177733"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga006.fm.intel.com with ESMTP; 02 Apr 2020 22:02:05 -0700
Date:   Thu, 2 Apr 2020 22:02:05 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Aslan Bakirov <aslan@fb.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com, riel@surriel.com,
        guro@fb.com, mhocko@kernel.org, hannes@cmpxchg.org
Subject: Re: [PATCH v3] mm: cma: NUMA node interface
Message-ID: <20200403050205.GI3952565@iweiny-DESK2.sc.intel.com>
References: <20200403021254.2842224-1-aslan@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403021254.2842224-1-aslan@fb.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 07:12:56PM -0700, Aslan Bakirov wrote:
> I've noticed that there is no interfaces exposed by CMA which would let me
> to declare contigous memory on particular NUMA node.
> 
> This patchset adds the ability to try to allocate contiguous memory on
> specific node. It will fallback to other nodes if the specified one
> doesn't work.
> 
> Implement a new method for declaring contigous memory on particular node
> and keep cma_declare_contiguous() as a wrapper.

Is there an additional patch which uses this new interface?

Generally the patch seems reasonable but we should have a user.

Ira

> 
> Signed-off-by: Aslan Bakirov <aslan@fb.com>
> ---
>  include/linux/cma.h      | 13 +++++++++++--
>  include/linux/memblock.h |  3 +++
>  mm/cma.c                 | 16 +++++++++-------
>  mm/memblock.c            |  2 +-
>  4 files changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/cma.h b/include/linux/cma.h
> index 190184b5ff32..eae834c2162f 100644
> --- a/include/linux/cma.h
> +++ b/include/linux/cma.h
> @@ -24,10 +24,19 @@ extern phys_addr_t cma_get_base(const struct cma *cma);
>  extern unsigned long cma_get_size(const struct cma *cma);
>  extern const char *cma_get_name(const struct cma *cma);
>  
> -extern int __init cma_declare_contiguous(phys_addr_t base,
> +extern int __init cma_declare_contiguous_nid(phys_addr_t base,
>  			phys_addr_t size, phys_addr_t limit,
>  			phys_addr_t alignment, unsigned int order_per_bit,
> -			bool fixed, const char *name, struct cma **res_cma);
> +			bool fixed, const char *name, struct cma **res_cma,
> +			int nid);
> +static inline int __init cma_declare_contiguous(phys_addr_t base,
> +			phys_addr_t size, phys_addr_t limit,
> +			phys_addr_t alignment, unsigned int order_per_bit,
> +			bool fixed, const char *name, struct cma **res_cma)
> +{
> +	return cma_declare_contiguous_nid(base, size, limit, alignment,
> +			order_per_bit, fixed, name, res_cma, NUMA_NO_NODE);
> +}
>  extern int cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
>  					unsigned int order_per_bit,
>  					const char *name,
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 079d17d96410..6bc37a731d27 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -348,6 +348,9 @@ static inline int memblock_get_region_node(const struct memblock_region *r)
>  
>  phys_addr_t memblock_phys_alloc_range(phys_addr_t size, phys_addr_t align,
>  				      phys_addr_t start, phys_addr_t end);
> +phys_addr_t memblock_alloc_range_nid(phys_addr_t size,
> +				      phys_addr_t align, phys_addr_t start,
> +				      phys_addr_t end, int nid, bool exact_nid);
>  phys_addr_t memblock_phys_alloc_try_nid(phys_addr_t size, phys_addr_t align, int nid);
>  
>  static inline phys_addr_t memblock_phys_alloc(phys_addr_t size,
> diff --git a/mm/cma.c b/mm/cma.c
> index be55d1988c67..6405af3dc118 100644
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
>   *
>   * This function reserves memory from early allocator. It should be
>   * called by arch specific code once the early allocator (memblock or bootmem)
> @@ -238,10 +239,11 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
>   * If @fixed is true, reserve contiguous area at exactly @base.  If false,
>   * reserve in range from @base to @limit.
>   */
> -int __init cma_declare_contiguous(phys_addr_t base,
> +int __init cma_declare_contiguous_nid(phys_addr_t base,
>  			phys_addr_t size, phys_addr_t limit,
>  			phys_addr_t alignment, unsigned int order_per_bit,
> -			bool fixed, const char *name, struct cma **res_cma)
> +			bool fixed, const char *name, struct cma **res_cma,
> +			int nid)
>  {
>  	phys_addr_t memblock_end = memblock_end_of_DRAM();
>  	phys_addr_t highmem_start;
> @@ -336,14 +338,14 @@ int __init cma_declare_contiguous(phys_addr_t base,
>  		 * memory in case of failure.
>  		 */
>  		if (base < highmem_start && limit > highmem_start) {
> -			addr = memblock_phys_alloc_range(size, alignment,
> -							 highmem_start, limit);
> +			addr = memblock_alloc_range_nid(size, alignment,
> +					highmem_start, limit, nid, false);
>  			limit = highmem_start;
>  		}
>  
>  		if (!addr) {
> -			addr = memblock_phys_alloc_range(size, alignment, base,
> -							 limit);
> +			addr = memblock_alloc_range_nid(size, alignment, base,
> +					alimit, nid, false);
>  			if (!addr) {
>  				ret = -ENOMEM;
>  				goto err;
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 4d06bbaded0f..c79ba6f9920c 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1349,7 +1349,7 @@ __next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
>   * Return:
>   * Physical address of allocated memory block on success, %0 on failure.
>   */
> -static phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
> +phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>  					phys_addr_t align, phys_addr_t start,
>  					phys_addr_t end, int nid,
>  					bool exact_nid)
> -- 
> 2.24.1
> 
> 
