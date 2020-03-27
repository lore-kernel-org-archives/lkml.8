Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2832AC2D0E7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC02A20717
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585296148;
	bh=wnp7jPxjmJBn3SKzGPUy6YmNkx6Sr+wQbxRDvV9qUoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wGOzpHZsc5+geTWb9m1hPp5dln8NxoFxGN1/C9BdyCawCvyKx9iUJnbYYFJ7pmzhl
	 kdANu6llMIO9LMSbYB16BVGBJOwF+zG6HLuE7ejVF5dZ/+tf8vWMja6Z/hS7553ywo
	 aiW/z6DMfkIzvo3TxTaYttlKhx2b1aXUbWZqDsls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgC0IC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 04:02:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35764 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgC0IC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 04:02:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id d5so10301648wrn.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 01:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qNi6DBuz/5fVyKdsS5z1ZHYPFocm39eGEeE2BDQ4Kac=;
        b=JF/2UlnGfpvMn5blFViDtT8g8TDINHT4/hncpRN5osfPKnilxWNxkRz1vGhLl/8I91
         t9TpthjldI0icp2GxxZFO90Tx3dkHPhVRErIo7GJ9YMly92h2ZSgnKwxURq8x6tsHC3t
         +HIFzvl0pCtgzyaVPlps4IDdI38vYeJH649D96LKQKgnXOc7eOER70tr7yHUuCLw8bWQ
         l5UaYKgX9lsYepuyOoND7EXI6bVoSZPKBeruXZM7o5s/KM6c/X4sU6KBvRZNtzJOsUeT
         NQIuTiwJV1e6Q9xFBiWXuUZtcvpoIAktwBRKOjlEm5rYELuFyWQm/Zr0QSNFxnXv+zCE
         PzAw==
X-Gm-Message-State: ANhLgQ2C40wnyQaB3MDv8X3gCTBLY4Zr7/7KIWzUiyRS/zzQN94zGEj/
        j9a9yJdGjohUklZOQJKBr9pj+yLw
X-Google-Smtp-Source: ADFU+vv/cS4b8SJE5C5vGk/D1S3kOAvAYR68RVq/mnQcLkE6OsElgwwqdgCk2ELfEYhl/kVUBJUjag==
X-Received: by 2002:a5d:550c:: with SMTP id b12mr2678662wrv.304.1585296143146;
        Fri, 27 Mar 2020 01:02:23 -0700 (PDT)
Received: from localhost (ip-37-188-135-150.eurotel.cz. [37.188.135.150])
        by smtp.gmail.com with ESMTPSA id j188sm7280440wmj.36.2020.03.27.01.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 01:02:22 -0700 (PDT)
Date:   Fri, 27 Mar 2020 09:02:13 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Aslan Bakirov <aslan@fb.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com, riel@surriel.com,
        guro@fb.com, hannes@cmpxchg.org
Subject: Re: [PATCH 1/2] mm: cma: NUMA node interface
Message-ID: <20200327080213.GU27965@dhcp22.suse.cz>
References: <20200326212718.3798742-1-aslan@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326212718.3798742-1-aslan@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26-03-20 14:27:17, Aslan Bakirov wrote:
> I've noticed that there is no interfaces exposed by CMA which would let me
> to declare contigous memory on particular NUMA node.
> 
> This patchset adds the ability to try to allocate contiguous memory on
> specific node.
> 
> Implement a new method for declaring contigous memory on particular node
> and keep cma_declare_contiguous() as a wrapper.

I am not an expert on CMA but this looks very reasonable to me.

> Signed-off-by: Aslan Bakirov <aslan@fb.com>
> ---
>  include/linux/cma.h      | 14 ++++++++++++--
>  include/linux/memblock.h |  3 +++
>  mm/cma.c                 | 15 ++++++++-------
>  mm/memblock.c            |  2 +-
>  4 files changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/cma.h b/include/linux/cma.h
> index 190184b5ff32..9512229744e0 100644
> --- a/include/linux/cma.h
> +++ b/include/linux/cma.h
> @@ -24,10 +24,20 @@ extern phys_addr_t cma_get_base(const struct cma *cma);
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
> +			{
> +				return cma_declare_contiguous_nid(base, size,
> +						limit, alignment, order_per_bit,
> +						fixed, name, res_cma, NUMA_NO_NODE);
> +			}
>  extern int cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
>  					unsigned int order_per_bit,
>  					const char *name,
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 079d17d96410..f5878ed25e6e 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -348,6 +348,9 @@ static inline int memblock_get_region_node(const struct memblock_region *r)
>  
>  phys_addr_t memblock_phys_alloc_range(phys_addr_t size, phys_addr_t align,
>  				      phys_addr_t start, phys_addr_t end);
> +phys_addr_t memblock_alloc_range_nid(phys_addr_t size,
> +					  phys_addr_t align, phys_addr_t start,
> +					  phys_addr_t end, int nid, bool exact_nid);
>  phys_addr_t memblock_phys_alloc_try_nid(phys_addr_t size, phys_addr_t align, int nid);
>  
>  static inline phys_addr_t memblock_phys_alloc(phys_addr_t size,
> diff --git a/mm/cma.c b/mm/cma.c
> index be55d1988c67..2300669b4253 100644
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
> @@ -336,14 +337,14 @@ int __init cma_declare_contiguous(phys_addr_t base,
>  		 * memory in case of failure.
>  		 */
>  		if (base < highmem_start && limit > highmem_start) {
> -			addr = memblock_phys_alloc_range(size, alignment,
> -							 highmem_start, limit);
> +			addr = memblock_alloc_range_nid(size, alignment,
> +							 highmem_start, limit, nid, false);
>  			limit = highmem_start;
>  		}
>  
>  		if (!addr) {
> -			addr = memblock_phys_alloc_range(size, alignment, base,
> -							 limit);
> +			addr = memblock_alloc_range_nid(size, alignment, base,
> +							 limit, nid, false);
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
> 2.17.1

-- 
Michal Hocko
SUSE Labs
