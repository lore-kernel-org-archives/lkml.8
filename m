Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A27C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 12:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD85F20823
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 12:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590323588;
	bh=Pqx9P6HjG6WFuIBnHWGOjP+Wlz1i83fF/SAnmmhXF7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AtCBNqHtdcBHK86BTEx/U1LT6mInwEAuQbZne1HxrMI1IRZkZ1Q3o/PAxFLV7g/bN
	 G0C3m+ab1jqfbjDsfq9V8ZQnjzIJxCVWLW34ptHOiQkbPWRaEGcm48rOVQh/WreHiw
	 /4VCTy2JfW7h9bksG0VzzZJUWdqSYby7hCxbQ1pk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgEXMdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 08:33:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbgEXMdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 08:33:04 -0400
Received: from kernel.org (unknown [87.71.47.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31ED020787;
        Sun, 24 May 2020 12:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590323583;
        bh=Pqx9P6HjG6WFuIBnHWGOjP+Wlz1i83fF/SAnmmhXF7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KXMnVizuTkEzi44W2rd+q/g98yMGiEZdSEpsYa6xLcj1E5EBrdISpTN6vV8zwzAXB
         Wt9eF+DngDayRfvOkdKJ0fxj4fvZhrCfTEZY+k+aWQlbSePpOVpgtNs3YBS5BlQRpR
         Vp70FFs5rDiyDhxjSgjZY86ObTSn/UcRCDgL6IQE=
Date:   Sun, 24 May 2020 15:32:56 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        elver@google.com, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, peterz@infradead.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v5 04/18] sparc32: mm: Reduce allocation size for PMD and
 PTE tables
Message-ID: <20200524123256.GN1118872@kernel.org>
References: <20200511204150.27858-1-will@kernel.org>
 <20200511204150.27858-5-will@kernel.org>
 <20200517000050.GA87467@roeck-us.net>
 <20200517000750.GA157503@roeck-us.net>
 <20200518083715.GA31383@willie-the-truck>
 <20200520170306.GG1118872@kernel.org>
 <6034a1b5-d4f6-c836-142c-9b3b06db3246@roeck-us.net>
 <20200520195110.GH1118872@kernel.org>
 <c80c04a4-75d0-6a47-3813-dea9325b6623@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c80c04a4-75d0-6a47-3813-dea9325b6623@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 04:02:11PM -0700, Guenter Roeck wrote:
> On 5/20/20 12:51 PM, Mike Rapoport wrote:
> > On Wed, May 20, 2020 at 12:03:31PM -0700, Guenter Roeck wrote:
> >> On 5/20/20 10:03 AM, Mike Rapoport wrote:
> >>> On Mon, May 18, 2020 at 09:37:15AM +0100, Will Deacon wrote:
> >>>> On Sat, May 16, 2020 at 05:07:50PM -0700, Guenter Roeck wrote:
> >>>>> On Sat, May 16, 2020 at 05:00:50PM -0700, Guenter Roeck wrote:
> >>>>>> On Mon, May 11, 2020 at 09:41:36PM +0100, Will Deacon wrote:
> >>>>>>> Now that the page table allocator can free page table allocations
> >>>>>>> smaller than PAGE_SIZE, reduce the size of the PMD and PTE allocations
> >>>>>>> to avoid needlessly wasting memory.
> >>>>>>>
> >>>>>>> Cc: "David S. Miller" <davem@davemloft.net>
> >>>>>>> Cc: Peter Zijlstra <peterz@infradead.org>
> >>>>>>> Signed-off-by: Will Deacon <will@kernel.org>
> >>>>>>
> >>>>>> Something in the sparc32 patches in linux-next causes all my sparc32 emulations
> >>>>>> to crash. bisect points to this patch, but reverting it doesn't help, and neither
> >>>>>> does reverting the rest of the series.
> >>>>>>
> >>>>> Actually, turns out I see the same pattern (lots of scheduling while atomic
> >>>>> followed by 'killing interrupt handler' in cryptomgr_test) with several
> >>>>> powerpc boot tests.  I am currently bisecting those crashes. I'll report
> >>>>> the results here as well as soon as I have it.
> >>>>
> >>>> FWIW, I retested my sparc32 patches with PREEMPT=y and I don't see any
> >>>> issues. However, linux-next is a different story, where I don't get very far
> >>>> at all:
> >>>>
> >>>> BUG: Bad page state in process swapper  pfn:005b4
> >>
> >> With above patch applied on top of Ira's patch, I get:
> >>
> >> BUG: spinlock recursion on CPU#0, S01syslogd/139
> >>  lock: 0xf5448350, .magic: dead4ead, .owner: S01syslogd/139, .owner_cpu: 0
> >> CPU: 0 PID: 139 Comm: S01syslogd Not tainted 5.7.0-rc6-next-20200518-00002-gb178d2d56f29-dirty #1
> >> [f0067a64 :
> >> do_raw_spin_lock+0xa8/0xd8 ]
> >> [f00d5034 :
> >> copy_page_range+0x328/0x804 ]
> >> [f0025be4 :
> >> dup_mm+0x334/0x434 ]
> >> [f0027124 :
> >> copy_process+0x1224/0x12b0 ]
> >> [f0027344 :
> >> _do_fork+0x54/0x30c ]
> >> [f0027670 :
> >> do_fork+0x5c/0x6c ]
> >> [f000de44 :
> >> sparc_do_fork+0x18/0x38 ]
> >> [f000b7f4 :
> >> do_syscall+0x34/0x40 ]
> >> [5010cd4c :
> >> 0x5010cd4c ]
> >>
> >> Looks like yet another problem.
> > 
> > I've checked the patch above on top of the mmots which already has Ira's
> > patches and it booted fine. I've used sparc32_defconfig to build the
> > kernel and qemu-system-sparc with default machine and CPU. 
> > 
> 
> Try sparc32_defconfig+SMP.
 
I see a differernt problem, but this could be related:

INIT: version 2.86 booting
rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
	(detected by 0, t=5252 jiffies, g=-935, q=3)
rcu: All QSes seen, last rcu_sched kthread activity 5252 (-68674--73926), jiffies_till_next_fqs=1, root ->qsmask 0x0
rcu: rcu_sched kthread starved for 5252 jiffies! g-935 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_sched kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
rcu_sched       R  running task        0    10      2 0x00000000

I'm running a bit old debian [1] with qemu-img-sparc.

My bisect pointed at commit 8c8f3156dd40 ("sparc32: mm: Reduce
allocation size for PMD and PTE tables"). The commit ID is valid for
next-20200522.

If I revert this commit and fixup the page table initialization [2] I've
broken, the build with CONFIG_SMP=n works fine, but the build with
CONFIG_SMP=y does not work even if I add nosmp to the kernel command
line. 

[1] https://people.debian.org/~aurel32/qemu/sparc/debian_etch_sparc_small.qcow2
[2] sparc32 meminit fixup:

diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index e45160839f79..eb2946b1df8a 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -192,6 +192,7 @@ unsigned long __init bootmem_init(unsigned long *pages_avail)
 	/* Reserve the kernel text/data/bss. */
 	size = (start_pfn << PAGE_SHIFT) - phys_base;
 	memblock_reserve(phys_base, size);
+	memblock_add(phys_base, size);
 
 	size = memblock_phys_mem_size() - memblock_reserved_size();
 	*pages_avail = (size >> PAGE_SHIFT) - high_pages;
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 75b56bdd38ef..6cb1ea2d2b5c 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -304,7 +304,7 @@ static void __init srmmu_nocache_init(void)
 		pgd = pgd_offset_k(vaddr);
 		p4d = p4d_offset(__nocache_fix(pgd), vaddr);
 		pud = pud_offset(__nocache_fix(p4d), vaddr);
-		pmd = pmd_offset(__nocache_fix(pud), vaddr);
+		pmd = pmd_offset(__nocache_fix(pgd), vaddr);
 		pte = pte_offset_kernel(__nocache_fix(pmd), vaddr);
 
 		pteval = ((paddr >> 4) | SRMMU_ET_PTE | SRMMU_PRIV);

> Guenter

-- 
Sincerely yours,
Mike.
