Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87B4C433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 09:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 822C820709
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 09:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gdJD32nw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N7Mf58JI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgICJxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 05:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgICJxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 05:53:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1B3C061244;
        Thu,  3 Sep 2020 02:53:09 -0700 (PDT)
Date:   Thu, 03 Sep 2020 09:53:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599126787;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sR04Y4IpiX64/MhLdtGb3m3Fr95dmhVOP7w/M40vkn8=;
        b=gdJD32nwrWxw3DNG3jc9zm4gbZqu3IMlV5qYawA+sOpuKjCKASWFevs/0JOURAGVyUIDxz
        C3jjk77m6VqM3N2qD/GZrvK/LUvYSF6BZCBslIxn6D+aVlLWR2A1Qwxp2ciCR9cc2m2091
        U0P0/K7GUs5hkhicAmp+9Xvh4VN406BY27/B//yhuUWZy6xoQtqvW7x9WjDleFeX/2SFvh
        Zikpdm5d3YoBeOEw42pnBAslJib6NK7Xi5ezwTOftE38CjXzr0r4IpuIo84584Tl6p0yI5
        qLuzHpnkkLJDwepT5eeO3+yDVqi8pVErn3+VQ7NPgn+KacNqM6JN3G/JrY22iA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599126787;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sR04Y4IpiX64/MhLdtGb3m3Fr95dmhVOP7w/M40vkn8=;
        b=N7Mf58JITBVRGT0yK4VqcfW5gdeaPuJkTdpLcH/GKWsR1RWdoYmECmq0bRE6rpPfNxB1vm
        CrCcr0tER5eZCDBw==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm/32: Bring back vmalloc faulting on x86_32
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200902155904.17544-1-joro@8bytes.org>
References: <20200902155904.17544-1-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159912678646.20229.14512202252477216460.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     4819e15f740ec884a50bdc431d7f1e7638b6f7d9
Gitweb:        https://git.kernel.org/tip/4819e15f740ec884a50bdc431d7f1e7638b6f7d9
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Wed, 02 Sep 2020 17:59:04 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 03 Sep 2020 11:23:35 +02:00

x86/mm/32: Bring back vmalloc faulting on x86_32

One can not simply remove vmalloc faulting on x86-32. Upstream

	commit: 7f0a002b5a21 ("x86/mm: remove vmalloc faulting")

removed it on x86 alltogether because previously the
arch_sync_kernel_mappings() interface was introduced. This interface
added synchronization of vmalloc/ioremap page-table updates to all
page-tables in the system at creation time and was thought to make
vmalloc faulting obsolete.

But that assumption was incredibly naive.

It turned out that there is a race window between the time the vmalloc
or ioremap code establishes a mapping and the time it synchronizes
this change to other page-tables in the system.

During this race window another CPU or thread can establish a vmalloc
mapping which uses the same intermediate page-table entries (e.g. PMD
or PUD) and does no synchronization in the end, because it found all
necessary mappings already present in the kernel reference page-table.

But when these intermediate page-table entries are not yet
synchronized, the other CPU or thread will continue with a vmalloc
address that is not yet mapped in the page-table it currently uses,
causing an unhandled page fault and oops like below:

	BUG: unable to handle page fault for address: fe80c000
	#PF: supervisor write access in kernel mode
	#PF: error_code(0x0002) - not-present page
	*pde = 33183067 *pte = a8648163
	Oops: 0002 [#1] SMP
	CPU: 1 PID: 13514 Comm: cve-2017-17053 Tainted: G
	...
	Call Trace:
	 ldt_dup_context+0x66/0x80
	 dup_mm+0x2b3/0x480
	 copy_process+0x133b/0x15c0
	 _do_fork+0x94/0x3e0
	 __ia32_sys_clone+0x67/0x80
	 __do_fast_syscall_32+0x3f/0x70
	 do_fast_syscall_32+0x29/0x60
	 do_SYSENTER_32+0x15/0x20
	 entry_SYSENTER_32+0x9f/0xf2
	EIP: 0xb7eef549

So the arch_sync_kernel_mappings() interface is racy, but removing it
would mean to re-introduce the vmalloc_sync_all() interface, which is
even more awful. Keep arch_sync_kernel_mappings() in place and catch
the race condition in the page-fault handler instead.

Do a partial revert of above commit to get vmalloc faulting on x86-32
back in place.

Fixes: 7f0a002b5a21 ("x86/mm: remove vmalloc faulting")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200902155904.17544-1-joro@8bytes.org
---
 arch/x86/mm/fault.c | 78 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 35f1498..6e3e8a1 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -190,6 +190,53 @@ static inline pmd_t *vmalloc_sync_one(pgd_t *pgd, unsigned long address)
 	return pmd_k;
 }
 
+/*
+ *   Handle a fault on the vmalloc or module mapping area
+ *
+ *   This is needed because there is a race condition between the time
+ *   when the vmalloc mapping code updates the PMD to the point in time
+ *   where it synchronizes this update with the other page-tables in the
+ *   system.
+ *
+ *   In this race window another thread/CPU can map an area on the same
+ *   PMD, finds it already present and does not synchronize it with the
+ *   rest of the system yet. As a result v[mz]alloc might return areas
+ *   which are not mapped in every page-table in the system, causing an
+ *   unhandled page-fault when they are accessed.
+ */
+static noinline int vmalloc_fault(unsigned long address)
+{
+	unsigned long pgd_paddr;
+	pmd_t *pmd_k;
+	pte_t *pte_k;
+
+	/* Make sure we are in vmalloc area: */
+	if (!(address >= VMALLOC_START && address < VMALLOC_END))
+		return -1;
+
+	/*
+	 * Synchronize this task's top level page-table
+	 * with the 'reference' page table.
+	 *
+	 * Do _not_ use "current" here. We might be inside
+	 * an interrupt in the middle of a task switch..
+	 */
+	pgd_paddr = read_cr3_pa();
+	pmd_k = vmalloc_sync_one(__va(pgd_paddr), address);
+	if (!pmd_k)
+		return -1;
+
+	if (pmd_large(*pmd_k))
+		return 0;
+
+	pte_k = pte_offset_kernel(pmd_k, address);
+	if (!pte_present(*pte_k))
+		return -1;
+
+	return 0;
+}
+NOKPROBE_SYMBOL(vmalloc_fault);
+
 void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
 {
 	unsigned long addr;
@@ -1110,6 +1157,37 @@ do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
 	 */
 	WARN_ON_ONCE(hw_error_code & X86_PF_PK);
 
+#ifdef CONFIG_X86_32
+	/*
+	 * We can fault-in kernel-space virtual memory on-demand. The
+	 * 'reference' page table is init_mm.pgd.
+	 *
+	 * NOTE! We MUST NOT take any locks for this case. We may
+	 * be in an interrupt or a critical region, and should
+	 * only copy the information from the master page table,
+	 * nothing more.
+	 *
+	 * Before doing this on-demand faulting, ensure that the
+	 * fault is not any of the following:
+	 * 1. A fault on a PTE with a reserved bit set.
+	 * 2. A fault caused by a user-mode access.  (Do not demand-
+	 *    fault kernel memory due to user-mode accesses).
+	 * 3. A fault caused by a page-level protection violation.
+	 *    (A demand fault would be on a non-present page which
+	 *     would have X86_PF_PROT==0).
+	 *
+	 * This is only needed to close a race condition on x86-32 in
+	 * the vmalloc mapping/unmapping code. See the comment above
+	 * vmalloc_fault() for details. On x86-64 the race does not
+	 * exist as the vmalloc mappings don't need to be synchronized
+	 * there.
+	 */
+	if (!(hw_error_code & (X86_PF_RSVD | X86_PF_USER | X86_PF_PROT))) {
+		if (vmalloc_fault(address) >= 0)
+			return;
+	}
+#endif
+
 	/* Was the fault spurious, caused by lazy TLB invalidation? */
 	if (spurious_kernel_fault(hw_error_code, address))
 		return;
