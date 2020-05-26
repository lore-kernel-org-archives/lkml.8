Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397CAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 13:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13317207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 13:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590499603;
	bh=c/hwaIJ3jULBWKpbPewxAzzORpKKARjEp6ut7/RBFkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XPBdssI0QH4IWvUWeEwlNg9Q1btREPRnuqVtzbLeAPXZe5ACHmvypJWM2MnnKB76f
	 h+2LlETsjjmbJ9Y+UpiM41/T7c6wmPF29uC3QtdYMi8ZeDptP6MGtN6s5CoirhjSkK
	 QMMeyDEKxsxjmX/G5k//phrRu6B8adqxC7OzfEwM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgEZN0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 09:26:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:60510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgEZN0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 09:26:41 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 486E2207CB;
        Tue, 26 May 2020 13:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590499600;
        bh=c/hwaIJ3jULBWKpbPewxAzzORpKKARjEp6ut7/RBFkc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1HyOGGehaqsDXAQJ/xX5lXJPvdlWoPv0FHQJP/TltczfOXS6ZDLQ+35tiL4jEKoUt
         TEs8AYbuCFK9bC9sdCWPsmurPGeLcd22LB4SP0XvlPjMfMpH1rC9xqOfd64HZdbsHx
         FsIP7ZcofF4/7GjUe4ZkVHo1rKDwrejr/Lxo+8og=
Date:   Tue, 26 May 2020 14:26:35 +0100
From:   Will Deacon <will@kernel.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        elver@google.com, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, peterz@infradead.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v5 04/18] sparc32: mm: Reduce allocation size for PMD and
 PTE tables
Message-ID: <20200526132634.GC27166@willie-the-truck>
References: <20200511204150.27858-1-will@kernel.org>
 <20200511204150.27858-5-will@kernel.org>
 <20200517000050.GA87467@roeck-us.net>
 <20200517000750.GA157503@roeck-us.net>
 <20200518083715.GA31383@willie-the-truck>
 <20200520170306.GG1118872@kernel.org>
 <6034a1b5-d4f6-c836-142c-9b3b06db3246@roeck-us.net>
 <20200520195110.GH1118872@kernel.org>
 <c80c04a4-75d0-6a47-3813-dea9325b6623@roeck-us.net>
 <20200524123256.GN1118872@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524123256.GN1118872@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 03:32:56PM +0300, Mike Rapoport wrote:
> On Thu, May 21, 2020 at 04:02:11PM -0700, Guenter Roeck wrote:
> > On 5/20/20 12:51 PM, Mike Rapoport wrote:
> > > On Wed, May 20, 2020 at 12:03:31PM -0700, Guenter Roeck wrote:
> > >> On 5/20/20 10:03 AM, Mike Rapoport wrote:
> > >>> On Mon, May 18, 2020 at 09:37:15AM +0100, Will Deacon wrote:
> > >>>> On Sat, May 16, 2020 at 05:07:50PM -0700, Guenter Roeck wrote:
> > >>>>> On Sat, May 16, 2020 at 05:00:50PM -0700, Guenter Roeck wrote:
> > >>>>>> On Mon, May 11, 2020 at 09:41:36PM +0100, Will Deacon wrote:
> > >>>>>>> Now that the page table allocator can free page table allocations
> > >>>>>>> smaller than PAGE_SIZE, reduce the size of the PMD and PTE allocations
> > >>>>>>> to avoid needlessly wasting memory.
> > >>>>>>>
> > >>>>>>> Cc: "David S. Miller" <davem@davemloft.net>
> > >>>>>>> Cc: Peter Zijlstra <peterz@infradead.org>
> > >>>>>>> Signed-off-by: Will Deacon <will@kernel.org>
> > >>>>>>
> > >>>>>> Something in the sparc32 patches in linux-next causes all my sparc32 emulations
> > >>>>>> to crash. bisect points to this patch, but reverting it doesn't help, and neither
> > >>>>>> does reverting the rest of the series.
> > >>>>>>
> > >>>>> Actually, turns out I see the same pattern (lots of scheduling while atomic
> > >>>>> followed by 'killing interrupt handler' in cryptomgr_test) with several
> > >>>>> powerpc boot tests.  I am currently bisecting those crashes. I'll report
> > >>>>> the results here as well as soon as I have it.
> > >>>>
> > >>>> FWIW, I retested my sparc32 patches with PREEMPT=y and I don't see any
> > >>>> issues. However, linux-next is a different story, where I don't get very far
> > >>>> at all:
> > >>>>
> > >>>> BUG: Bad page state in process swapper  pfn:005b4
> > >>
> > >> With above patch applied on top of Ira's patch, I get:
> > >>
> > >> BUG: spinlock recursion on CPU#0, S01syslogd/139
> > >>  lock: 0xf5448350, .magic: dead4ead, .owner: S01syslogd/139, .owner_cpu: 0
> > >> CPU: 0 PID: 139 Comm: S01syslogd Not tainted 5.7.0-rc6-next-20200518-00002-gb178d2d56f29-dirty #1
> > >> [f0067a64 :
> > >> do_raw_spin_lock+0xa8/0xd8 ]
> > >> [f00d5034 :
> > >> copy_page_range+0x328/0x804 ]
> > >> [f0025be4 :
> > >> dup_mm+0x334/0x434 ]
> > >> [f0027124 :
> > >> copy_process+0x1224/0x12b0 ]
> > >> [f0027344 :
> > >> _do_fork+0x54/0x30c ]
> > >> [f0027670 :
> > >> do_fork+0x5c/0x6c ]
> > >> [f000de44 :
> > >> sparc_do_fork+0x18/0x38 ]
> > >> [f000b7f4 :
> > >> do_syscall+0x34/0x40 ]
> > >> [5010cd4c :
> > >> 0x5010cd4c ]
> > >>
> > >> Looks like yet another problem.
> > > 
> > > I've checked the patch above on top of the mmots which already has Ira's
> > > patches and it booted fine. I've used sparc32_defconfig to build the
> > > kernel and qemu-system-sparc with default machine and CPU. 
> > > 
> > 
> > Try sparc32_defconfig+SMP.
>  
> I see a differernt problem, but this could be related:
> 
> INIT: version 2.86 booting
> rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> 	(detected by 0, t=5252 jiffies, g=-935, q=3)
> rcu: All QSes seen, last rcu_sched kthread activity 5252 (-68674--73926), jiffies_till_next_fqs=1, root ->qsmask 0x0
> rcu: rcu_sched kthread starved for 5252 jiffies! g-935 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
> rcu: 	Unless rcu_sched kthread gets sufficient CPU time, OOM is now expected behavior.
> rcu: RCU grace-period kthread stack dump:
> rcu_sched       R  running task        0    10      2 0x00000000
> 
> I'm running a bit old debian [1] with qemu-img-sparc.
> 
> My bisect pointed at commit 8c8f3156dd40 ("sparc32: mm: Reduce
> allocation size for PMD and PTE tables"). The commit ID is valid for
> next-20200522.

Can you try the diff below please?

Will

--->8

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index c861c0f0df73..7c05c0dea511 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -363,20 +363,16 @@ pgtable_t pte_alloc_one(struct mm_struct *mm)
 
 	if ((ptep = pte_alloc_one_kernel(mm)) == 0)
 		return NULL;
+
 	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
-	if (!pgtable_pte_page_ctor(page)) {
-		__free_page(page);
+	if (!PageTable(page) && !pgtable_pte_page_ctor(page))
 		return NULL;
-	}
+
 	return ptep;
 }
 
 void pte_free(struct mm_struct *mm, pgtable_t ptep)
 {
-	struct page *page;
-
-	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
-	pgtable_pte_page_dtor(page);
 	srmmu_free_nocache(ptep, SRMMU_PTE_TABLE_SIZE);
 }
 
diff --git a/mm/Kconfig b/mm/Kconfig
index c1acc34c1c35..97458119cce8 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -192,6 +192,9 @@ config MEMORY_HOTREMOVE
 # Default to 4 for wider testing, though 8 might be more appropriate.
 # ARM's adjust_pte (unused if VIPT) depends on mm-wide page_table_lock.
 # PA-RISC 7xxx's spinlock_t would enlarge struct page from 32 to 44 bytes.
+# SPARC32 allocates multiple pte tables within a single page, and therefore
+# a per-page lock leads to problems when multiple tables need to be locked
+# at the same time (e.g. copy_page_range()).
 # DEBUG_SPINLOCK and DEBUG_LOCK_ALLOC spinlock_t also enlarge struct page.
 #
 config SPLIT_PTLOCK_CPUS
@@ -199,6 +202,7 @@ config SPLIT_PTLOCK_CPUS
 	default "999999" if !MMU
 	default "999999" if ARM && !CPU_CACHE_VIPT
 	default "999999" if PARISC && !PA20
+	default "999999" if SPARC32
 	default "4"
 
 config ARCH_ENABLE_SPLIT_PMD_PTLOCK
