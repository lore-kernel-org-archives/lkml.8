Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDA9C4BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F1E2468E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ajzQaEs0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgBZQXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 11:23:03 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:49804 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbgBZQXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:23:02 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01QFvg7Y033916;
        Wed, 26 Feb 2020 16:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=wcR73i51xZFpjh/dpqq+xxHpso4HXMae9pYAfRpesjM=;
 b=ajzQaEs036Fttjn6ealO6ng6AW2j8JJzN1l97faLvt3ILHyVqpbmygCm/pbyBiThm2u5
 j8L1daZOMwpuq/N5PogrpKazZ52aYkAmsVLzeTCYoam+g2vIwJv1Ko91znOQAYRbc4Dg
 xH9eNJSaVtIg+7TfTq2Uy+X1y5AkguS/wbmFXqvMmwmAfs1/ApzjNjUMeIAgIaDejblh
 2qIDoV6e0auZ1SHL4XlwWc0wdIaEa/ObARlZAKfwnlZxNNASWf8pSpwNEghrVF4zLjfu
 KNETGqhLYJbAa1YvmQVcCUlrJYPM4FM9PX7VlKHmOpHPbLC6p++ziHSm6IABSdA/r7Vf 0A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2ydcsrmrrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Feb 2020 16:22:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01QGMGaE166612;
        Wed, 26 Feb 2020 16:22:33 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2ydcs2g5tc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Feb 2020 16:22:33 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01QGMWU5000833;
        Wed, 26 Feb 2020 16:22:32 GMT
Received: from achartre-desktop.us.oracle.com (/10.39.232.60)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Feb 2020 08:22:31 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com,
        alexandre.chartre@oracle.com
Subject: [RFC PATCH v3 7/7] mm/asi: Implement PTI with ASI
Date:   Wed, 26 Feb 2020 17:22:00 +0100
Message-Id: <1582734120-26757-8-git-send-email-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1582734120-26757-1-git-send-email-alexandre.chartre@oracle.com>
References: <1582734120-26757-1-git-send-email-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=2 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002260112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 suspectscore=2
 bulkscore=0 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002260111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASI supersedes PTI. If both CONFIG_ADDRESS_SPACE_ISOLATION and
CONFIG_PAGE_TABLE_ISOLATION are set then PTI is implemented using
ASI. For each user process, a "user" ASI is then defined with the
PTI pagetable. The user ASI is used when running userland code, and
it is exited when entering a syscall. The user ASI is re-entered
when the syscall returns to userland.

As with any ASI, interrupts/exceptions/NMIs will interrupt the
ASI, the ASI will resume when the interrupt/exception/NMI has
completed. Faults won't abort the user ASI as user faults are
handled by the kernel before returning to userland.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/entry/calling.h        |    7 ++++++-
 arch/x86/entry/common.c         |   29 ++++++++++++++++++++++++-----
 arch/x86/entry/entry_64.S       |    6 ++++++
 arch/x86/include/asm/asi.h      |    9 +++++++++
 arch/x86/include/asm/tlbflush.h |   11 +++++++++--
 arch/x86/mm/asi.c               |    9 +++++++++
 arch/x86/mm/pti.c               |   28 ++++++++++++++++++++--------
 include/linux/mm_types.h        |    5 +++++
 kernel/fork.c                   |   17 +++++++++++++++++
 9 files changed, 105 insertions(+), 16 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index ca23b79..ce0fccd 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -176,16 +176,21 @@
 #if defined(CONFIG_ADDRESS_SPACE_ISOLATION)
 
 /*
- * For now, ASI is not compatible with PTI.
+ * ASI supersedes the entry points used by PTI. If both
+ * CONFIG_ADDRESS_SPACE_ISOLATION and CONFIG_PAGE_TABLE_ISOLATION are
+ * set then PTI is implemented using ASI.
  */
 
 .macro SWITCH_TO_KERNEL_CR3 scratch_reg:req
+	ASI_INTERRUPT \scratch_reg
 .endm
 
 .macro SWITCH_TO_USER_CR3_NOSTACK scratch_reg:req scratch_reg2:req
+	ASI_RESUME \scratch_reg
 .endm
 
 .macro SWITCH_TO_USER_CR3_STACK	scratch_reg:req
+	ASI_RESUME \scratch_reg
 .endm
 
 .macro SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg:req save_reg:req
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 9747876..a437de3 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -34,6 +34,7 @@
 #include <asm/fpu/api.h>
 #include <asm/nospec-branch.h>
 #include <asm/io_bitmap.h>
+#include <asm/asi.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
@@ -49,6 +50,13 @@ __visible inline void enter_from_user_mode(void)
 static inline void enter_from_user_mode(void) {}
 #endif
 
+static inline void syscall_enter(void)
+{
+	/* syscall enter has interrupted ASI, now exit ASI */
+	asi_exit(current->mm->user_asi);
+	enter_from_user_mode();
+}
+
 static void do_audit_syscall_entry(struct pt_regs *regs, u32 arch)
 {
 #ifdef CONFIG_X86_64
@@ -224,6 +232,17 @@ __visible inline void prepare_exit_to_usermode(struct pt_regs *regs)
 	mds_user_clear_cpu_buffers();
 }
 
+static inline void prepare_syscall_return(struct pt_regs *regs)
+{
+	prepare_exit_to_usermode(regs);
+
+	/*
+	 * Syscall return will resume ASI, prepare resume to enter
+	 * user ASI.
+	 */
+	asi_deferred_enter(current->mm->user_asi);
+}
+
 #define SYSCALL_EXIT_WORK_FLAGS				\
 	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT |	\
 	 _TIF_SINGLESTEP | _TIF_SYSCALL_TRACEPOINT)
@@ -275,7 +294,7 @@ __visible inline void syscall_return_slowpath(struct pt_regs *regs)
 		syscall_slow_exit_work(regs, cached_flags);
 
 	local_irq_disable();
-	prepare_exit_to_usermode(regs);
+	prepare_syscall_return(regs);
 }
 
 #ifdef CONFIG_X86_64
@@ -283,7 +302,7 @@ __visible void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 {
 	struct thread_info *ti;
 
-	enter_from_user_mode();
+	syscall_enter();
 	local_irq_enable();
 	ti = current_thread_info();
 	if (READ_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY)
@@ -355,7 +374,7 @@ static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs)
 /* Handles int $0x80 */
 __visible void do_int80_syscall_32(struct pt_regs *regs)
 {
-	enter_from_user_mode();
+	syscall_enter();
 	local_irq_enable();
 	do_syscall_32_irqs_on(regs);
 }
@@ -378,7 +397,7 @@ __visible long do_fast_syscall_32(struct pt_regs *regs)
 	 */
 	regs->ip = landing_pad;
 
-	enter_from_user_mode();
+	syscall_enter();
 
 	local_irq_enable();
 
@@ -400,7 +419,7 @@ __visible long do_fast_syscall_32(struct pt_regs *regs)
 		/* User code screwed up. */
 		local_irq_disable();
 		regs->ax = -EFAULT;
-		prepare_exit_to_usermode(regs);
+		prepare_syscall_return(regs);
 		return 0;	/* Keep it simple: use IRET. */
 	}
 
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index fddb820..9042ba1 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -627,6 +627,9 @@ ret_from_intr:
 .Lretint_user:
 	mov	%rsp,%rdi
 	call	prepare_exit_to_usermode
+#ifdef CONFIG_ADDRESS_SPACE_ISOLATION
+	ASI_PREPARE_RESUME
+#endif
 	TRACE_IRQS_IRETQ
 
 SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
@@ -1491,6 +1494,9 @@ SYM_CODE_START(nmi)
 	movq	%rsp, %rdi
 	movq	$-1, %rsi
 	call	do_nmi
+#ifdef CONFIG_ADDRESS_SPACE_ISOLATION
+	ASI_PREPARE_RESUME
+#endif
 
 	/*
 	 * Return back to user mode.  We must *not* do the normal exit
diff --git a/arch/x86/include/asm/asi.h b/arch/x86/include/asm/asi.h
index b8d7b93..ac0594d 100644
--- a/arch/x86/include/asm/asi.h
+++ b/arch/x86/include/asm/asi.h
@@ -62,6 +62,10 @@ struct asi_tlb_state {
 	struct asi_tlb_pgtable	tlb_pgtables[ASI_TLB_NR_DYN_ASIDS];
 };
 
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#define ASI_PCID_PREFIX_USER		0x80	/* user ASI */
+#endif
+
 struct asi_type {
 	int			pcid_prefix;	/* PCID prefix */
 	struct asi_tlb_state	*tlb_state;	/* percpu ASI TLB state */
@@ -139,6 +143,7 @@ struct asi {
 void asi_schedule_in(struct task_struct *task);
 bool asi_fault(struct pt_regs *regs, unsigned long error_code,
 	       unsigned long address, enum asi_fault_origin fault_origin);
+void asi_deferred_enter(struct asi *asi);
 
 extern struct asi *asi_create(struct asi_type *type);
 extern void asi_destroy(struct asi *asi);
@@ -146,6 +151,10 @@ bool asi_fault(struct pt_regs *regs, unsigned long error_code,
 extern int asi_enter(struct asi *asi);
 extern void asi_exit(struct asi *asi);
 
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+DECLARE_ASI_TYPE(user);
+#endif
+
 static inline void asi_set_log_policy(struct asi *asi, int policy)
 {
 	asi->fault_log_policy = policy;
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 241058f..db114de 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -390,6 +390,8 @@ static inline void cr4_set_bits_and_update_boot(unsigned long mask)
  */
 static inline void invalidate_user_asid(u16 asid)
 {
+	struct asi_tlb_state *tlb_state;
+
 	/* There is no user ASID if address space separation is off */
 	if (!IS_ENABLED(CONFIG_PAGE_TABLE_ISOLATION))
 		return;
@@ -404,8 +406,13 @@ static inline void invalidate_user_asid(u16 asid)
 	if (!static_cpu_has(X86_FEATURE_PTI))
 		return;
 
-	__set_bit(kern_pcid(asid),
-		  (unsigned long *)this_cpu_ptr(&cpu_tlbstate.user_pcid_flush_mask));
+	if (IS_ENABLED(CONFIG_ADDRESS_SPACE_ISOLATION)) {
+		tlb_state = get_cpu_ptr(asi_type_user.tlb_state);
+		tlb_state->tlb_pgtables[asid].id = 0;
+	} else {
+		__set_bit(kern_pcid(asid),
+		    (unsigned long *)this_cpu_ptr(&cpu_tlbstate.user_pcid_flush_mask));
+	}
 }
 
 /*
diff --git a/arch/x86/mm/asi.c b/arch/x86/mm/asi.c
index 6c94d29..3448413 100644
--- a/arch/x86/mm/asi.c
+++ b/arch/x86/mm/asi.c
@@ -14,6 +14,10 @@
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
 
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+DEFINE_ASI_TYPE(user, ASI_PCID_PREFIX_USER, false);
+#endif
+
 static void asi_log_fault(struct asi *asi, struct pt_regs *regs,
 			   unsigned long error_code, unsigned long address,
 			   enum asi_fault_origin fault_origin)
@@ -314,6 +318,11 @@ void asi_exit(struct asi *asi)
 }
 EXPORT_SYMBOL(asi_exit);
 
+void asi_deferred_enter(struct asi *asi)
+{
+	asi_switch_to_asi_cr3(asi, ASI_SWITCH_ON_RESUME);
+}
+
 void asi_prepare_resume(void)
 {
 	struct asi_session *asi_session;
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 44a9f06..9f91a93 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -429,6 +429,18 @@ static void __init pti_clone_p4d(unsigned long addr)
 	*user_p4d = *kernel_p4d;
 }
 
+static void __init pti_map_va(unsigned long va)
+{
+	phys_addr_t pa = per_cpu_ptr_to_phys((void *)va);
+	pte_t *target_pte;
+
+	target_pte = pti_user_pagetable_walk_pte(va);
+	if (WARN_ON(!target_pte))
+		return;
+
+	*target_pte = pfn_pte(pa >> PAGE_SHIFT, PAGE_KERNEL);
+}
+
 /*
  * Clone the CPU_ENTRY_AREA and associated data into the user space visible
  * page table.
@@ -456,15 +468,15 @@ static void __init pti_clone_user_shared(void)
 		 * is set up.
 		 */
 
-		unsigned long va = (unsigned long)&per_cpu(cpu_tss_rw, cpu);
-		phys_addr_t pa = per_cpu_ptr_to_phys((void *)va);
-		pte_t *target_pte;
-
-		target_pte = pti_user_pagetable_walk_pte(va);
-		if (WARN_ON(!target_pte))
-			return;
+		pti_map_va((unsigned long)&per_cpu(cpu_tss_rw, cpu));
 
-		*target_pte = pfn_pte(pa >> PAGE_SHIFT, PAGE_KERNEL);
+		if (IS_ENABLED(CONFIG_ADDRESS_SPACE_ISOLATION)) {
+			/*
+			 * Map the ASI session. We need to always be able
+			 * to access the ASI session.
+			 */
+			pti_map_va((unsigned long)&per_cpu(cpu_tlbstate, cpu));
+		}
 	}
 }
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 270aa8f..0152f73 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -25,6 +25,7 @@
 
 struct address_space;
 struct mem_cgroup;
+struct asi;
 
 /*
  * Each physical page in the system has a struct page associated with
@@ -524,6 +525,10 @@ struct mm_struct {
 		atomic_long_t hugetlb_usage;
 #endif
 		struct work_struct async_put_work;
+#if defined(CONFIG_ADDRESS_SPACE_ISOLATION) && defined(CONFIG_PAGE_TABLE_ISOLATION)
+		/* ASI used for user address space */
+		struct asi *user_asi;
+#endif
 	} __randomize_layout;
 
 	/*
diff --git a/kernel/fork.c b/kernel/fork.c
index 0808095..d245cc0 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -101,6 +101,7 @@
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
+#include <asm/asi.h>
 
 #include <trace/events/sched.h>
 
@@ -695,6 +696,10 @@ void __mmdrop(struct mm_struct *mm)
 	mmu_notifier_mm_destroy(mm);
 	check_mm(mm);
 	put_user_ns(mm->user_ns);
+	if (IS_ENABLED(CONFIG_ADDRESS_SPACE_ISOLATION) &&
+	    IS_ENABLED(CONFIG_PAGE_TABLE_ISOLATION)) {
+		asi_destroy(mm->user_asi);
+	}
 	free_mm(mm);
 }
 EXPORT_SYMBOL_GPL(__mmdrop);
@@ -1046,6 +1051,18 @@ static void mm_init_uprobes_state(struct mm_struct *mm)
 	if (init_new_context(p, mm))
 		goto fail_nocontext;
 
+	if (IS_ENABLED(CONFIG_ADDRESS_SPACE_ISOLATION) &&
+	    IS_ENABLED(CONFIG_PAGE_TABLE_ISOLATION)) {
+		/*
+		 * If we have PTI and ASI then use ASI to switch between
+		 * user and kernel spaces, so create an ASI for this mm.
+		 */
+		mm->user_asi = asi_create_user();
+		if (!mm->user_asi)
+			goto fail_nocontext;
+		asi_set_pagetable(mm->user_asi, kernel_to_user_pgdp(mm->pgd));
+	}
+
 	mm->user_ns = get_user_ns(user_ns);
 	return mm;
 
-- 
1.7.1

