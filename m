Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F6BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 277C0206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731762AbgGAPG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:06:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2178 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731750AbgGAPG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:06:56 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 061F1TNA009042;
        Wed, 1 Jul 2020 11:06:52 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 320s228nf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jul 2020 11:06:51 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 061F1sVx011191;
        Wed, 1 Jul 2020 11:06:51 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 320s228ne6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jul 2020 11:06:51 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 061F6nZX028548;
        Wed, 1 Jul 2020 15:06:49 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 31wwcgtbxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jul 2020 15:06:49 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 061F6kju63963548
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Jul 2020 15:06:46 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8C0042047;
        Wed,  1 Jul 2020 15:06:46 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C34D242042;
        Wed,  1 Jul 2020 15:06:45 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.203.198])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  1 Jul 2020 15:06:45 +0000 (GMT)
Date:   Wed, 1 Jul 2020 18:06:43 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/2] mm/memblock: expose only miminal interface to
 add/walk physmem
Message-ID: <20200701150643.GA2999146@linux.ibm.com>
References: <20200701141830.18749-1-david@redhat.com>
 <20200701141830.18749-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701141830.18749-2-david@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_08:2020-07-01,2020-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 suspectscore=7 adultscore=0 lowpriorityscore=0
 cotscore=-2147483648 spamscore=0 mlxscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007010104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Wed, Jul 01, 2020 at 04:18:29PM +0200, David Hildenbrand wrote:
> "physmem" in the memblock allocator is somewhat weird: it's not actually
> used for allocation, it's simply information collected during boot, which
> describes the unmodified physical memory map at boot time, without any
> standby/hotplugged memory. It's only used on s390x and is currently the
> only reason s390x keeps using CONFIG_ARCH_KEEP_MEMBLOCK.
> 
> Physmem isn't numa aware and current users don't specify any flags. Let's
> hide it from the user, exposing only for_each_physmem(), and simplify. The
> interface for physmem is now really minimalistic:
> - memblock_physmem_add() to add ranges
> - for_each_physmem() / __next_physmem_range() to walk physmem ranges
> 
> Don't place it into an __init section and don't discard it without
> CONFIG_ARCH_KEEP_MEMBLOCK. As we're reusing __next_mem_range(), remove
> the __meminit notifier to avoid section mismatch warnings once
> CONFIG_ARCH_KEEP_MEMBLOCK is no longer used with
> CONFIG_HAVE_MEMBLOCK_PHYS_MAP.
> 
> While fixing up the documentation, sneak in some related cleanups. We can
> stop setting CONFIG_HAVE_MEMBLOCK_PHYS_MAP for s390x next.

As you noted in the previous version it should have been
CONFIG_ARCH_KEEP_MEMBLOCK ;-)

> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  arch/s390/kernel/crash_dump.c |  6 ++--
>  include/linux/memblock.h      | 28 ++++++++++++++---
>  mm/memblock.c                 | 57 ++++++++++++++++++-----------------
>  3 files changed, 55 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
> index f96a5857bbfde..c42ce348103cc 100644
> --- a/arch/s390/kernel/crash_dump.c
> +++ b/arch/s390/kernel/crash_dump.c
> @@ -549,8 +549,7 @@ static int get_mem_chunk_cnt(void)
>  	int cnt = 0;
>  	u64 idx;
>  
> -	for_each_mem_range(idx, &memblock.physmem, &oldmem_type, NUMA_NO_NODE,
> -			   MEMBLOCK_NONE, NULL, NULL, NULL)
> +	for_each_physmem_range(idx, &oldmem_type, NULL, NULL)
>  		cnt++;
>  	return cnt;
>  }
> @@ -563,8 +562,7 @@ static void loads_init(Elf64_Phdr *phdr, u64 loads_offset)
>  	phys_addr_t start, end;
>  	u64 idx;
>  
> -	for_each_mem_range(idx, &memblock.physmem, &oldmem_type, NUMA_NO_NODE,
> -			   MEMBLOCK_NONE, &start, &end, NULL) {
> +	for_each_physmem_range(idx, &oldmem_type, &start, &end) {
>  		phdr->p_filesz = end - start;
>  		phdr->p_type = PT_LOAD;
>  		phdr->p_offset = start;
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 017fae833d4ae..9d925db0d3550 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -77,16 +77,12 @@ struct memblock_type {
>   * @current_limit: physical address of the current allocation limit
>   * @memory: usable memory regions
>   * @reserved: reserved memory regions
> - * @physmem: all physical memory
>   */
>  struct memblock {
>  	bool bottom_up;  /* is bottom up direction? */
>  	phys_addr_t current_limit;
>  	struct memblock_type memory;
>  	struct memblock_type reserved;
> -#ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
> -	struct memblock_type physmem;
> -#endif
>  };
>  
>  extern struct memblock memblock;
> @@ -145,6 +141,30 @@ void __next_reserved_mem_region(u64 *idx, phys_addr_t *out_start,
>  
>  void __memblock_free_late(phys_addr_t base, phys_addr_t size);
>  
> +#ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
> +static inline void __next_physmem_range(u64 *idx, struct memblock_type *type,
> +					phys_addr_t *out_start,
> +					phys_addr_t *out_end)
> +{
> +	extern struct memblock_type physmem;
> +
> +	__next_mem_range(idx, NUMA_NO_NODE, MEMBLOCK_NONE, &physmem, type,
> +			 out_start, out_end, NULL);
> +}
> +
> +/**
> + * for_each_physmem_range - iterate through physmem areas not included in type.
> + * @i: u64 used as loop variable
> + * @type: ptr to memblock_type which excludes from the iteration, can be %NULL
> + * @p_start: ptr to phys_addr_t for start address of the range, can be %NULL
> + * @p_end: ptr to phys_addr_t for end address of the range, can be %NULL
> + */
> +#define for_each_physmem_range(i, type, p_start, p_end)			\
> +	for (i = 0, __next_physmem_range(&i, type, p_start, p_end);	\
> +	     i != (u64)ULLONG_MAX;					\
> +	     __next_physmem_range(&i, type, p_start, p_end))
> +#endif /* CONFIG_HAVE_MEMBLOCK_PHYS_MAP */
> +
>  /**
>   * for_each_mem_range - iterate through memblock areas from type_a and not
>   * included in type_b. Or just type_a if type_b is NULL.
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 39aceafc57f66..45f198750be92 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -44,19 +44,20 @@
>   *   in the system, for instance when the memory is restricted with
>   *   ``mem=`` command line parameter
>   * * ``reserved`` - describes the regions that were allocated
> - * * ``physmap`` - describes the actual physical memory regardless of
> - *   the possible restrictions; the ``physmap`` type is only available
> - *   on some architectures.
> + * * ``physmem`` - describes the actual physical memory available during
> + *   boot regardless of the possible restrictions and memory hot(un)plug;
> + *   the ``physmem`` type is only available on some architectures.
>   *
>   * Each region is represented by :c:type:`struct memblock_region` that
>   * defines the region extents, its attributes and NUMA node id on NUMA
>   * systems. Every memory type is described by the :c:type:`struct
>   * memblock_type` which contains an array of memory regions along with
> - * the allocator metadata. The memory types are nicely wrapped with
> - * :c:type:`struct memblock`. This structure is statically initialzed
> - * at build time. The region arrays for the "memory" and "reserved"
> - * types are initially sized to %INIT_MEMBLOCK_REGIONS and for the
> - * "physmap" type to %INIT_PHYSMEM_REGIONS.
> + * the allocator metadata. The "memory" and "reserved" types are nicely
> + * wrapped with :c:type:`struct memblock`. This structure is statically
> + * initialized at build time. The region arrays are initially sized to
> + * %INIT_MEMBLOCK_REGIONS for "memory" and %INIT_MEMBLOCK_RESERVED_REGIONS
> + * for "reserved". The region array for "physmem" is initially sized to
> + * %INIT_PHYSMEM_REGIONS.
>   * The memblock_allow_resize() enables automatic resizing of the region
>   * arrays during addition of new regions. This feature should be used
>   * with care so that memory allocated for the region array will not
> @@ -87,8 +88,8 @@
>   * function frees all the memory to the buddy page allocator.
>   *
>   * Unless an architecture enables %CONFIG_ARCH_KEEP_MEMBLOCK, the
> - * memblock data structures will be discarded after the system
> - * initialization completes.
> + * memblock data structures (except "physmem") will be discarded after the
> + * system initialization completes.
>   */
>  
>  #ifndef CONFIG_NEED_MULTIPLE_NODES
> @@ -104,7 +105,7 @@ unsigned long long max_possible_pfn;
>  static struct memblock_region memblock_memory_init_regions[INIT_MEMBLOCK_REGIONS] __initdata_memblock;
>  static struct memblock_region memblock_reserved_init_regions[INIT_MEMBLOCK_RESERVED_REGIONS] __initdata_memblock;
>  #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
> -static struct memblock_region memblock_physmem_init_regions[INIT_PHYSMEM_REGIONS] __initdata_memblock;
> +static struct memblock_region memblock_physmem_init_regions[INIT_PHYSMEM_REGIONS];
>  #endif
>  
>  struct memblock memblock __initdata_memblock = {
> @@ -118,17 +119,19 @@ struct memblock memblock __initdata_memblock = {
>  	.reserved.max		= INIT_MEMBLOCK_RESERVED_REGIONS,
>  	.reserved.name		= "reserved",
>  
> -#ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
> -	.physmem.regions	= memblock_physmem_init_regions,
> -	.physmem.cnt		= 1,	/* empty dummy entry */
> -	.physmem.max		= INIT_PHYSMEM_REGIONS,
> -	.physmem.name		= "physmem",
> -#endif
> -
>  	.bottom_up		= false,
>  	.current_limit		= MEMBLOCK_ALLOC_ANYWHERE,
>  };
>  
> +#ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
> +struct memblock_type physmem = {
> +	.regions		= memblock_physmem_init_regions,
> +	.cnt			= 1,	/* empty dummy entry */
> +	.max			= INIT_PHYSMEM_REGIONS,
> +	.name			= "physmem",
> +};
> +#endif
> +
>  int memblock_debug __initdata_memblock;
>  static bool system_has_some_mirror __initdata_memblock = false;
>  static int memblock_can_resize __initdata_memblock;
> @@ -838,7 +841,7 @@ int __init_memblock memblock_physmem_add(phys_addr_t base, phys_addr_t size)
>  	memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
>  		     &base, &end, (void *)_RET_IP_);
>  
> -	return memblock_add_range(&memblock.physmem, base, size, MAX_NUMNODES, 0);
> +	return memblock_add_range(&physmem, base, size, MAX_NUMNODES, 0);
>  }
>  #endif
>  
> @@ -1019,12 +1022,10 @@ static bool should_skip_region(struct memblock_region *m, int nid, int flags)
>   * As both region arrays are sorted, the function advances the two indices
>   * in lockstep and returns each intersection.
>   */
> -void __init_memblock __next_mem_range(u64 *idx, int nid,
> -				      enum memblock_flags flags,
> -				      struct memblock_type *type_a,
> -				      struct memblock_type *type_b,
> -				      phys_addr_t *out_start,
> -				      phys_addr_t *out_end, int *out_nid)
> +void __next_mem_range(u64 *idx, int nid, enum memblock_flags flags,
> +		      struct memblock_type *type_a,
> +		      struct memblock_type *type_b, phys_addr_t *out_start,
> +		      phys_addr_t *out_end, int *out_nid)
>  {
>  	int idx_a = *idx & 0xffffffff;
>  	int idx_b = *idx >> 32;
> @@ -1924,7 +1925,7 @@ void __init_memblock __memblock_dump_all(void)
>  	memblock_dump(&memblock.memory);
>  	memblock_dump(&memblock.reserved);
>  #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
> -	memblock_dump(&memblock.physmem);
> +	memblock_dump(&physmem);
>  #endif
>  }
>  
> @@ -2064,8 +2065,8 @@ static int __init memblock_init_debugfs(void)
>  	debugfs_create_file("reserved", 0444, root,
>  			    &memblock.reserved, &memblock_debug_fops);
>  #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
> -	debugfs_create_file("physmem", 0444, root,
> -			    &memblock.physmem, &memblock_debug_fops);
> +	debugfs_create_file("physmem", 0444, root, &physmem,
> +			    &memblock_debug_fops);
>  #endif
>  
>  	return 0;
> -- 
> 2.26.2
> 

-- 
Sincerely yours,
Mike.
