Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47D7C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 12:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3CDF2076D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 12:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598705392;
	bh=k3j6O2PJb0vk0vB1utniG9jS/JNcBt1nSQmcyDZTxCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZyhetjrNrnr9AF+li9pLg+HM/SZNKVWkwpQNg5GiUktSv8MalgGTh0Lucm5Vu2xo3
	 2DPYdrH8p7NNTWjMAgjhz9fUCBllvt/LU1YHvHwz+SRuodqFg2mxtduVgVVqhWNJht
	 zZ0I/04ywleceoxwfj2WZf6gV1PInHmeDZS3IiqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgH2Mtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 08:49:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:44968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbgH2Mtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 08:49:45 -0400
Received: from kernel.org (unknown [87.70.91.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81F632076D;
        Sat, 29 Aug 2020 12:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598705384;
        bh=k3j6O2PJb0vk0vB1utniG9jS/JNcBt1nSQmcyDZTxCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fp5ElYe3V0tNNYpfnbellfFzvYFhu/hM6TDdL6MLzB7lB6xJFfBdT3twyM3Ik9KF4
         qW/L9lOfjkxhTAp1ClFSWecSw7q3I6BPL7fNizx6Zk7MjanQ8xOIcpJ0n/rBAULZUf
         Wnzl/OyhxuFFh4scxt16q5UFwEoufAwPOrAl+okE=
Date:   Sat, 29 Aug 2020 15:49:37 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH] arc: fix memory initialization for systems with two
 memory banks
Message-ID: <20200829124937.GH69706@kernel.org>
References: <20200828163902.4548-1-rppt@kernel.org>
 <5595f585-810d-c84d-3562-34398eccce10@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5595f585-810d-c84d-3562-34398eccce10@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 10:17:28PM +0000, Vineet Gupta wrote:
> Hi Mike,
> 
> On 8/28/20 9:39 AM, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> >
> > Rework if memory map initialization broke initialization of ARC systems
> > with two memory banks. Before these changes, memblock was not aware of
> > nodes configuration and the memory map was always allocated from the
> > "lowmem" bank. After the addition of node information to memblock, the core
> > mm attempts to allocate the memory map for the "highmem" bank from its
> > node. The access to this memory using __va() fails because it can be only
> > accessed using kmap.
> >
> > Anther problem that was uncovered is that {min,max}_high_pfn are calculated
> > from u64 high_mem_start variable which prevents truncation to 32-bit
> > physical address and the PFN values are above the node and zone boundaries.
> 
> Not sure if I quite follow this part. We should not be relying on truncation: the
> pfn should be derived off of zone addresses ?

Before the refactoring of the memmap initialization, we used

	free_area_init_node(1, zones_size, min_high_pfn, zones_holes);

With min_high_pfn being u64, min_node_pfn would be 0x80000 (presuming 8k
page and haps_hs.dts). But since we explicitly passed the min_node_pfn,
it will be eventually used at zone->zone_start_pfn, so HIGHMEM zone
would span from 0x80000.

After the refactoring, we use memblock information and architectural
limits for zone extents to detect actual zone span. Memblock uses
phys_addr_t to represent memory banks and if we still calculate
min_high_pfn using u64 there is a mismatch between pfn (0x80000) and
physicall address (0x0).

> > Use phys_addr_t type for high_mem_start and high_mem_size to ensure
> > correspondence between PFNs and highmem zone boundaries and reserve the
> > entire highmem bank until mem_init() to avoid accesses to it before highmem
> > is enabled.
> >
> > Fixes: 51930df5801e ("mm: free_area_init: allow defining max_zone_pfn in descend ing order")
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> 
> Thx for the fix. I verified that a 2 mem bank system with HIGHMEM enabled now
> works again.
> And I've also added a couple of lines to changelog to describe how to test such a
> config.
> 
> |    To test this:
> |    1. Enable HIGHMEM in ARC config
> |    2. Enable 2 memory banks in haps_hs.dts (uncomment the 2nd bank)

The second bank already enabled in the dts ;-)

I think its worthwhile adding this to the wiki [1] since it's not likely
people could dig this from the kernel log.

[1] https://github.com/foss-for-synopsys-dwc-arc-processors/linux/wiki/How-to-run-ARC-Linux-kernel-and-debug-(with-MetaWare-Debugger)

> > ---
> >  arch/arc/mm/init.c | 27 ++++++++++++++++-----------
> >  1 file changed, 16 insertions(+), 11 deletions(-)
> >
> > diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
> > index f886ac69d8ad..3a35b82a718e 100644
> > --- a/arch/arc/mm/init.c
> > +++ b/arch/arc/mm/init.c
> > @@ -26,8 +26,8 @@ static unsigned long low_mem_sz;
> >  
> >  #ifdef CONFIG_HIGHMEM
> >  static unsigned long min_high_pfn, max_high_pfn;
> > -static u64 high_mem_start;
> > -static u64 high_mem_sz;
> > +static phys_addr_t high_mem_start;
> > +static phys_addr_t high_mem_sz;
> >  #endif
> >  
> >  #ifdef CONFIG_DISCONTIGMEM
> > @@ -69,6 +69,7 @@ void __init early_init_dt_add_memory_arch(u64 base, u64 size)
> >  		high_mem_sz = size;
> >  		in_use = 1;
> >  		memblock_add_node(base, size, 1);
> > +		memblock_reserve(base, size);
> >  #endif
> >  	}
> >  
> > @@ -157,7 +158,7 @@ void __init setup_arch_memory(void)
> >  	min_high_pfn = PFN_DOWN(high_mem_start);
> >  	max_high_pfn = PFN_DOWN(high_mem_start + high_mem_sz);
> >  
> > -	max_zone_pfn[ZONE_HIGHMEM] = max_high_pfn;
> > +	max_zone_pfn[ZONE_HIGHMEM] = min_low_pfn;
> >  
> >  	high_memory = (void *)(min_high_pfn << PAGE_SHIFT);
> >  	kmap_init();
> > @@ -166,22 +167,26 @@ void __init setup_arch_memory(void)
> >  	free_area_init(max_zone_pfn);
> >  }
> >  
> > -/*
> > - * mem_init - initializes memory
> > - *
> > - * Frees up bootmem
> > - * Calculates and displays memory available/used
> > - */
> > -void __init mem_init(void)
> > +static void __init highmem_init(void)
> >  {
> >  #ifdef CONFIG_HIGHMEM
> >  	unsigned long tmp;
> >  
> > -	reset_all_zones_managed_pages();
> > +	memblock_free(high_mem_start, high_mem_sz);
> >  	for (tmp = min_high_pfn; tmp < max_high_pfn; tmp++)
> >  		free_highmem_page(pfn_to_page(tmp));
> >  #endif
> > +}
> >  
> > +/*
> > + * mem_init - initializes memory
> > + *
> > + * Frees up bootmem
> > + * Calculates and displays memory available/used
> > + */
> > +void __init mem_init(void)
> > +{
> >  	memblock_free_all();
> > +	highmem_init();
> >  	mem_init_print_info(NULL);
> >  }
> 

-- 
Sincerely yours,
Mike.
