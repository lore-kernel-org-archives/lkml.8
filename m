Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CCAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 05:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33EC42089D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 05:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590642315;
	bh=NDC24e39Iao1s0J6oxpl6QrqSQ/FN9yD5O8bl+XbuW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JD5Y8D0ITxjEB7yM9IgSV3BuaJjBUTPO66fB9TRxzU9xswERyj3UC2EChAWBDTjVf
	 yM7NyrQGJDTzNqu3N5sf1s16UPhSTXlLdNFhP6+jyGNm2zRoYfd46t8Ww3NeqPCH78
	 Lro7DbTVf1/hgDQmiX3zTR/xdKtNUqDwHlt7X9FA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgE1FFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 01:05:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727016AbgE1FFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 01:05:12 -0400
Received: from kernel.org (unknown [87.71.78.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C20EE2084C;
        Thu, 28 May 2020 05:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590642311;
        bh=NDC24e39Iao1s0J6oxpl6QrqSQ/FN9yD5O8bl+XbuW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HBBn9BXczLkH33zORKEbOys0PDe0i4iZez9bsYJ24D87n/mCI9onGbTfxk6pBZmgO
         u1CThBkweL+W+opoTXfssFQwyEADsZ792kBGprZqlImMvXpvQyKkXCUZvnXQN3jdhG
         7kBpSZYMeenCReBOEku6BK9gKo5rqyVC9OIvY99M=
Date:   Thu, 28 May 2020 08:05:04 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: drop deprecated DISCONTIGMEM support for 32-bit
Message-ID: <20200528050504.GI48741@kernel.org>
References: <20200223094322.15206-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223094322.15206-1-rppt@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping...

On Sun, Feb 23, 2020 at 11:43:22AM +0200, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The DISCONTIGMEM support was marked as deprecated in v5.2 and since there
> were no complaints about it for almost 5 releases it can be completely
> removed.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/x86/Kconfig                  |  9 -------
>  arch/x86/include/asm/mmzone_32.h  | 39 -------------------------------
>  arch/x86/include/asm/pgtable_32.h |  3 +--
>  arch/x86/mm/numa_32.c             | 34 ---------------------------
>  4 files changed, 1 insertion(+), 84 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index beea77046f9b..e3fc3aa80f97 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1613,19 +1613,10 @@ config NODES_SHIFT
>  	  Specify the maximum number of NUMA Nodes available on the target
>  	  system.  Increases memory reserved to accommodate various tables.
>  
> -config ARCH_HAVE_MEMORY_PRESENT
> -	def_bool y
> -	depends on X86_32 && DISCONTIGMEM
> -
>  config ARCH_FLATMEM_ENABLE
>  	def_bool y
>  	depends on X86_32 && !NUMA
>  
> -config ARCH_DISCONTIGMEM_ENABLE
> -	def_bool n
> -	depends on NUMA && X86_32
> -	depends on BROKEN
> -
>  config ARCH_SPARSEMEM_ENABLE
>  	def_bool y
>  	depends on X86_64 || NUMA || X86_32 || X86_32_NON_STANDARD
> diff --git a/arch/x86/include/asm/mmzone_32.h b/arch/x86/include/asm/mmzone_32.h
> index 73d8dd14dda2..2d4515e8b7df 100644
> --- a/arch/x86/include/asm/mmzone_32.h
> +++ b/arch/x86/include/asm/mmzone_32.h
> @@ -14,43 +14,4 @@ extern struct pglist_data *node_data[];
>  #define NODE_DATA(nid)	(node_data[nid])
>  #endif /* CONFIG_NUMA */
>  
> -#ifdef CONFIG_DISCONTIGMEM
> -
> -/*
> - * generic node memory support, the following assumptions apply:
> - *
> - * 1) memory comes in 64Mb contiguous chunks which are either present or not
> - * 2) we will not have more than 64Gb in total
> - *
> - * for now assume that 64Gb is max amount of RAM for whole system
> - *    64Gb / 4096bytes/page = 16777216 pages
> - */
> -#define MAX_NR_PAGES 16777216
> -#define MAX_SECTIONS 1024
> -#define PAGES_PER_SECTION (MAX_NR_PAGES/MAX_SECTIONS)
> -
> -extern s8 physnode_map[];
> -
> -static inline int pfn_to_nid(unsigned long pfn)
> -{
> -#ifdef CONFIG_NUMA
> -	return((int) physnode_map[(pfn) / PAGES_PER_SECTION]);
> -#else
> -	return 0;
> -#endif
> -}
> -
> -static inline int pfn_valid(int pfn)
> -{
> -	int nid = pfn_to_nid(pfn);
> -
> -	if (nid >= 0)
> -		return (pfn < node_end_pfn(nid));
> -	return 0;
> -}
> -
> -#define early_pfn_valid(pfn)	pfn_valid((pfn))
> -
> -#endif /* CONFIG_DISCONTIGMEM */
> -
>  #endif /* _ASM_X86_MMZONE_32_H */
> diff --git a/arch/x86/include/asm/pgtable_32.h b/arch/x86/include/asm/pgtable_32.h
> index 0dca7f7aeff2..be7b19646897 100644
> --- a/arch/x86/include/asm/pgtable_32.h
> +++ b/arch/x86/include/asm/pgtable_32.h
> @@ -66,8 +66,7 @@ do {						\
>  #endif /* !__ASSEMBLY__ */
>  
>  /*
> - * kern_addr_valid() is (1) for FLATMEM and (0) for
> - * SPARSEMEM and DISCONTIGMEM
> + * kern_addr_valid() is (1) for FLATMEM and (0) for SPARSEMEM
>   */
>  #ifdef CONFIG_FLATMEM
>  #define kern_addr_valid(addr)	(1)
> diff --git a/arch/x86/mm/numa_32.c b/arch/x86/mm/numa_32.c
> index f2bd3d61e16b..104544359d69 100644
> --- a/arch/x86/mm/numa_32.c
> +++ b/arch/x86/mm/numa_32.c
> @@ -27,40 +27,6 @@
>  
>  #include "numa_internal.h"
>  
> -#ifdef CONFIG_DISCONTIGMEM
> -/*
> - * 4) physnode_map     - the mapping between a pfn and owning node
> - * physnode_map keeps track of the physical memory layout of a generic
> - * numa node on a 64Mb break (each element of the array will
> - * represent 64Mb of memory and will be marked by the node id.  so,
> - * if the first gig is on node 0, and the second gig is on node 1
> - * physnode_map will contain:
> - *
> - *     physnode_map[0-15] = 0;
> - *     physnode_map[16-31] = 1;
> - *     physnode_map[32- ] = -1;
> - */
> -s8 physnode_map[MAX_SECTIONS] __read_mostly = { [0 ... (MAX_SECTIONS - 1)] = -1};
> -EXPORT_SYMBOL(physnode_map);
> -
> -void memory_present(int nid, unsigned long start, unsigned long end)
> -{
> -	unsigned long pfn;
> -
> -	printk(KERN_INFO "Node: %d, start_pfn: %lx, end_pfn: %lx\n",
> -			nid, start, end);
> -	printk(KERN_DEBUG "  Setting physnode_map array to node %d for pfns:\n", nid);
> -	printk(KERN_DEBUG "  ");
> -	start = round_down(start, PAGES_PER_SECTION);
> -	end = round_up(end, PAGES_PER_SECTION);
> -	for (pfn = start; pfn < end; pfn += PAGES_PER_SECTION) {
> -		physnode_map[pfn / PAGES_PER_SECTION] = nid;
> -		printk(KERN_CONT "%lx ", pfn);
> -	}
> -	printk(KERN_CONT "\n");
> -}
> -#endif
> -
>  extern unsigned long highend_pfn, highstart_pfn;
>  
>  void __init initmem_init(void)
> -- 
> 2.24.0
> 

-- 
Sincerely yours,
Mike.
