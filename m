Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4043DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12B7D2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590506490;
	bh=QAByh4OSefUf5iKj8VcvuLLXIsSRwRrH1mymUqjFuHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=btwhGNHrdCAS9B6PqF3kI83jGbDuBxXSXvduxzQd3na1fkTjQ7JgFPkfwNJruNDho
	 fltzfmw6SYObl1PH3R0QHaBq8AziaY3VqXkPO1wqgY0aSPSlImo1/EbZcSj22wMTIb
	 0dTNVGFItvYiJQYfmdb0kMfw4Tz6WBifr2B7UINQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbgEZPV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 11:21:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729088AbgEZPV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 11:21:27 -0400
Received: from kernel.org (unknown [87.70.212.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B772F20723;
        Tue, 26 May 2020 15:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590506487;
        bh=QAByh4OSefUf5iKj8VcvuLLXIsSRwRrH1mymUqjFuHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oBgbUVXKZ39t92u4Ni9pif2r5OeduNYeI/oWf67NOIQfbbWDx1Q9ZTg2lLKGtHidQ
         FDQgfjrwiLr3QI/AsQYrxSGIYKTzytZLEmoH8wxWAS6Wo3/fSspFMN9GTpENlzWvmO
         N2c5NrlBL2WfnTeUUG0bqgsnsyly3ZK677wvpsp8=
Date:   Tue, 26 May 2020 18:21:20 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        elver@google.com, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, peterz@infradead.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v5 04/18] sparc32: mm: Reduce allocation size for PMD and
 PTE tables
Message-ID: <20200526152120.GD48741@kernel.org>
References: <20200517000050.GA87467@roeck-us.net>
 <20200517000750.GA157503@roeck-us.net>
 <20200518083715.GA31383@willie-the-truck>
 <20200520170306.GG1118872@kernel.org>
 <6034a1b5-d4f6-c836-142c-9b3b06db3246@roeck-us.net>
 <20200520195110.GH1118872@kernel.org>
 <c80c04a4-75d0-6a47-3813-dea9325b6623@roeck-us.net>
 <20200524123256.GN1118872@kernel.org>
 <20200526132634.GC27166@willie-the-truck>
 <20200526140126.GD27166@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526140126.GD27166@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 03:01:27PM +0100, Will Deacon wrote:
> On Tue, May 26, 2020 at 02:26:35PM +0100, Will Deacon wrote:
> > On Sun, May 24, 2020 at 03:32:56PM +0300, Mike Rapoport wrote:
> > > On Thu, May 21, 2020 at 04:02:11PM -0700, Guenter Roeck wrote:
> > > > On 5/20/20 12:51 PM, Mike Rapoport wrote:
> > > > > On Wed, May 20, 2020 at 12:03:31PM -0700, Guenter Roeck wrote:
> > > > >> With above patch applied on top of Ira's patch, I get:
> > > > >>
> > > > >> BUG: spinlock recursion on CPU#0, S01syslogd/139
> > > > >>  lock: 0xf5448350, .magic: dead4ead, .owner: S01syslogd/139, .owner_cpu: 0
> > > > >> CPU: 0 PID: 139 Comm: S01syslogd Not tainted 5.7.0-rc6-next-20200518-00002-gb178d2d56f29-dirty #1
> > > > >> [f0067a64 :
> > > > >> do_raw_spin_lock+0xa8/0xd8 ]
> > > > >> [f00d5034 :
> > > > >> copy_page_range+0x328/0x804 ]
> > > > >> [f0025be4 :
> > > > >> dup_mm+0x334/0x434 ]
> > > > >> [f0027124 :
> > > > >> copy_process+0x1224/0x12b0 ]
> > > > >> [f0027344 :
> > > > >> _do_fork+0x54/0x30c ]
> > > > >> [f0027670 :
> > > > >> do_fork+0x5c/0x6c ]
> > > > >> [f000de44 :
> > > > >> sparc_do_fork+0x18/0x38 ]
> > > > >> [f000b7f4 :
> > > > >> do_syscall+0x34/0x40 ]
> > > > >> [5010cd4c :
> > > > >> 0x5010cd4c ]
> > > > >>
> > > > >> Looks like yet another problem.
> > > > > 
> > > > > I've checked the patch above on top of the mmots which already has Ira's
> > > > > patches and it booted fine. I've used sparc32_defconfig to build the
> > > > > kernel and qemu-system-sparc with default machine and CPU. 
> > > > > 
> > > > 
> > > > Try sparc32_defconfig+SMP.
> > >  
> > > I see a differernt problem, but this could be related:
> > > 
> > > INIT: version 2.86 booting
> > > rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> > > 	(detected by 0, t=5252 jiffies, g=-935, q=3)
> > > rcu: All QSes seen, last rcu_sched kthread activity 5252 (-68674--73926), jiffies_till_next_fqs=1, root ->qsmask 0x0
> > > rcu: rcu_sched kthread starved for 5252 jiffies! g-935 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
> > > rcu: 	Unless rcu_sched kthread gets sufficient CPU time, OOM is now expected behavior.
> > > rcu: RCU grace-period kthread stack dump:
> > > rcu_sched       R  running task        0    10      2 0x00000000
> > > 
> > > I'm running a bit old debian [1] with qemu-img-sparc.
> > > 
> > > My bisect pointed at commit 8c8f3156dd40 ("sparc32: mm: Reduce
> > > allocation size for PMD and PTE tables"). The commit ID is valid for
> > > next-20200522.
> > 
> > Can you try the diff below please?
> 
> Actually, that's racy. New version below!

Well, both versions worked for me with sparc32_defconfig+SMP build when
I ran qemu-system-sparc with default machine (SS-5) that does not allow
SMP.

I could not check with actial SMP because
qemu-system-sparc -M SS-10 -smp 2 and qemu-system-sparc -M SS-20 -smp 2
fail early with an exception even in v5.7-rc7...

> Will
> 
> --->8
> 
> diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
> index c861c0f0df73..068029471aa4 100644
> --- a/arch/sparc/mm/srmmu.c
> +++ b/arch/sparc/mm/srmmu.c
> @@ -363,11 +363,16 @@ pgtable_t pte_alloc_one(struct mm_struct *mm)
>  
>  	if ((ptep = pte_alloc_one_kernel(mm)) == 0)
>  		return NULL;
> +
>  	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
> -	if (!pgtable_pte_page_ctor(page)) {
> -		__free_page(page);
> -		return NULL;
> +
> +	spin_lock(&mm->page_table_lock);
> +	if (page_ref_inc_return(page) == 2 && !pgtable_pte_page_ctor(page)) {
> +		page_ref_dec(page);
> +		ptep = NULL;
>  	}
> +	spin_unlock(&mm->page_table_lock);
> +
>  	return ptep;
>  }
>  
> @@ -376,7 +381,12 @@ void pte_free(struct mm_struct *mm, pgtable_t ptep)
>  	struct page *page;
>  
>  	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
> -	pgtable_pte_page_dtor(page);
> +
> +	spin_lock(&mm->page_table_lock);
> +	if (page_ref_dec_return(page) == 1)
> +		pgtable_pte_page_dtor(page);
> +	spin_unlock(&mm->page_table_lock);
> +
>  	srmmu_free_nocache(ptep, SRMMU_PTE_TABLE_SIZE);
>  }
>  
> diff --git a/mm/Kconfig b/mm/Kconfig
> index c1acc34c1c35..97458119cce8 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -192,6 +192,9 @@ config MEMORY_HOTREMOVE
>  # Default to 4 for wider testing, though 8 might be more appropriate.
>  # ARM's adjust_pte (unused if VIPT) depends on mm-wide page_table_lock.
>  # PA-RISC 7xxx's spinlock_t would enlarge struct page from 32 to 44 bytes.
> +# SPARC32 allocates multiple pte tables within a single page, and therefore
> +# a per-page lock leads to problems when multiple tables need to be locked
> +# at the same time (e.g. copy_page_range()).
>  # DEBUG_SPINLOCK and DEBUG_LOCK_ALLOC spinlock_t also enlarge struct page.
>  #
>  config SPLIT_PTLOCK_CPUS
> @@ -199,6 +202,7 @@ config SPLIT_PTLOCK_CPUS
>  	default "999999" if !MMU
>  	default "999999" if ARM && !CPU_CACHE_VIPT
>  	default "999999" if PARISC && !PA20
> +	default "999999" if SPARC32
>  	default "4"
>  
>  config ARCH_ENABLE_SPLIT_PMD_PTLOCK

-- 
Sincerely yours,
Mike.
