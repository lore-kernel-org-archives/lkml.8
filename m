Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159C9C4BA13
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C763D2467B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ROfyhfQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgBZQXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 11:23:01 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:40706 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbgBZQXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:23:01 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01QFxPB3164302;
        Wed, 26 Feb 2020 16:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=YwDt6B5mD4mD2ogqtBzcQnrNMcuDgJ1FsZQ3bx7YZSU=;
 b=ROfyhfQ6aw4BQAL0SQQbr0v6ONxL++yGQI09rhxum3gN6zSCBKaEbDqzg6DBEApF2j8d
 XoJy39ZgMg4tc+MUn9hYB25mq0Dhhp+mLqsTpm+a4+ODVBXTjLv2y74I+WKU2BeZot2A
 s89oPoH3X2r+7U4li0Kt1hoF5iLwJlljqWt0mUPFECQsISL3OParEOjHIMmBzJwkBHNJ
 Rm33bdT3PzLEimIurNa1RM3+8xvWpPX4NH0zhVl9/ho6MSgpUdasLvOeOk8C+yV6pZsS
 SWraD8x5Jjp2+rqGkDqEyBhQ/grfRIw54wFA2drAr5VXUzsBUqpJVb8UTwpg9c7r6dda qg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2ydcsncrfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Feb 2020 16:22:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01QGClhG003533;
        Wed, 26 Feb 2020 16:22:24 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2ydcsa5hxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Feb 2020 16:22:24 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01QGMMLb006940;
        Wed, 26 Feb 2020 16:22:22 GMT
Received: from achartre-desktop.us.oracle.com (/10.39.232.60)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Feb 2020 08:22:22 -0800
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
Subject: [RFC PATCH v3 4/7] mm/asi: Interrupt ASI on interrupt/exception/NMI
Date:   Wed, 26 Feb 2020 17:21:57 +0100
Message-Id: <1582734120-26757-5-git-send-email-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1582734120-26757-1-git-send-email-alexandre.chartre@oracle.com>
References: <1582734120-26757-1-git-send-email-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002260111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002260111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an interrupt/exception/NMI is triggered while using ASI then
ASI is interrupted and the system switches back to the (kernel)
page-table used before entering ASI.

When the interrupt/exception/NMI handler returns then ASI is
resumed by switching back to the ASI page-table.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/entry/calling.h           |   26 +++++++-
 arch/x86/entry/entry_64.S          |   22 +++++++
 arch/x86/include/asm/asi.h         |  122 ++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/asi_session.h |    7 ++
 arch/x86/include/asm/mmu_context.h |    3 +-
 arch/x86/kernel/asm-offsets.c      |    5 ++
 arch/x86/mm/asi.c                  |   67 +++++++++++++++++---
 7 files changed, 242 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 0789e13..ca23b79 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -6,6 +6,7 @@
 #include <asm/percpu.h>
 #include <asm/asm-offsets.h>
 #include <asm/processor-flags.h>
+#include <asm/asi.h>
 
 /*
 
@@ -172,7 +173,30 @@
 	.endif
 .endm
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#if defined(CONFIG_ADDRESS_SPACE_ISOLATION)
+
+/*
+ * For now, ASI is not compatible with PTI.
+ */
+
+.macro SWITCH_TO_KERNEL_CR3 scratch_reg:req
+.endm
+
+.macro SWITCH_TO_USER_CR3_NOSTACK scratch_reg:req scratch_reg2:req
+.endm
+
+.macro SWITCH_TO_USER_CR3_STACK	scratch_reg:req
+.endm
+
+.macro SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg:req save_reg:req
+	ASI_INTERRUPT_AND_SAVE_CR3 \scratch_reg \save_reg
+.endm
+
+.macro RESTORE_CR3 scratch_reg:req save_reg:req
+	ASI_RESUME_AND_RESTORE_CR3 \save_reg
+.endm
+
+#elif defined(CONFIG_PAGE_TABLE_ISOLATION)
 
 /*
  * PAGE_TABLE_ISOLATION PGDs are 8k.  Flip bit 12 to switch between the two
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 76942cb..fddb820 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -573,7 +573,15 @@ SYM_CODE_START(interrupt_entry)
 
 	CALL_enter_from_user_mode
 
+#ifdef CONFIG_ADDRESS_SPACE_ISOLATION
+	jmp	2f
+#endif
 1:
+#ifdef CONFIG_ADDRESS_SPACE_ISOLATION
+	/* Interrupt address space isolation if it is active */
+	ASI_INTERRUPT scratch_reg=%rdi
+2:
+#endif
 	ENTER_IRQ_STACK old_rsp=%rdi save_ret=1
 	/* We entered an interrupt context - irqs are off: */
 	TRACE_IRQS_OFF
@@ -674,6 +682,10 @@ retint_kernel:
 	call	preempt_schedule_irq
 1:
 #endif
+#ifdef CONFIG_ADDRESS_SPACE_ISOLATION
+	ASI_PREPARE_RESUME
+	ASI_RESUME scratch_reg=%rdi
+#endif
 	/*
 	 * The iretq could re-enable interrupts:
 	 */
@@ -1238,6 +1250,9 @@ SYM_CODE_START_LOCAL(paranoid_entry)
 	 * This is also why CS (stashed in the "iret frame" by the
 	 * hardware at entry) can not be used: this may be a return
 	 * to kernel code, but with a user CR3 value.
+	 *
+	 * If ASI is enabled, this also handles the case where we are
+	 * using an ASI CR3 value.
 	 */
 	SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg=%rax save_reg=%r14
 
@@ -1313,6 +1328,13 @@ SYM_CODE_START_LOCAL(error_entry)
 
 .Lerror_entry_done_lfence:
 	FENCE_SWAPGS_KERNEL_ENTRY
+#ifdef CONFIG_ADDRESS_SPACE_ISOLATION
+	/*
+	 * Interrupt address space isolation if it is active. This will restore
+	 * the original kernel CR3.
+	 */
+	ASI_INTERRUPT scratch_reg=%rdi
+#endif
 .Lerror_entry_done:
 	ret
 
diff --git a/arch/x86/include/asm/asi.h b/arch/x86/include/asm/asi.h
index bcfb68e..d240954 100644
--- a/arch/x86/include/asm/asi.h
+++ b/arch/x86/include/asm/asi.h
@@ -108,6 +108,128 @@ struct asi {
 extern int asi_enter(struct asi *asi);
 extern void asi_exit(struct asi *asi);
 
+#else  /* __ASSEMBLY__ */
+
+#include <asm/alternative-asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/cpufeatures.h>
+#include <asm/percpu.h>
+#include <asm/processor-flags.h>
+
+#define THIS_ASI_SESSION_asi		\
+	PER_CPU_VAR(cpu_tlbstate + TLB_STATE_asi)
+#define THIS_ASI_SESSION_isolation_cr3	\
+	PER_CPU_VAR(cpu_tlbstate + TLB_STATE_asi_isolation_cr3)
+#define THIS_ASI_SESSION_original_cr3	\
+	PER_CPU_VAR(cpu_tlbstate + TLB_STATE_asi_original_cr3)
+#define THIS_ASI_SESSION_idepth	\
+	PER_CPU_VAR(cpu_tlbstate + TLB_STATE_asi_idepth)
+
+.macro SET_NOFLUSH_BIT	reg:req
+	bts	$X86_CR3_PCID_NOFLUSH_BIT, \reg
+.endm
+
+/*
+ * Switch CR3 to the original kernel CR3 value. This is used when exiting
+ * interrupting ASI.
+ */
+.macro ASI_SWITCH_TO_KERNEL_CR3 scratch_reg:req
+	/*
+	 * KERNEL pages can always resume with NOFLUSH as we do
+	 * explicit flushes.
+	 */
+	movq	THIS_ASI_SESSION_original_cr3, \scratch_reg
+	ALTERNATIVE "", "SET_NOFLUSH_BIT \scratch_reg", X86_FEATURE_PCID
+	movq	\scratch_reg, %cr3
+.endm
+
+/*
+ * Interrupt ASI, when there's an interrupt or exception while we
+ * were running with ASI.
+ */
+.macro ASI_INTERRUPT scratch_reg:req
+	movq	THIS_ASI_SESSION_asi, \scratch_reg
+	testq	\scratch_reg, \scratch_reg
+	jz	.Lasi_interrupt_done_\@
+	incl	THIS_ASI_SESSION_idepth
+	cmp	$1, THIS_ASI_SESSION_idepth
+	jne	.Lasi_interrupt_done_\@
+	ASI_SWITCH_TO_KERNEL_CR3 \scratch_reg
+.Lasi_interrupt_done_\@:
+.endm
+
+.macro ASI_PREPARE_RESUME
+	call	asi_prepare_resume
+.endm
+
+/*
+ * Resume ASI, after it was interrupted by an interrupt or an exception.
+ */
+.macro ASI_RESUME scratch_reg:req
+	movq	THIS_ASI_SESSION_asi, \scratch_reg
+	testq	\scratch_reg, \scratch_reg
+	jz	.Lasi_resume_done_\@
+	decl	THIS_ASI_SESSION_idepth
+	jnz	.Lasi_resume_done_\@
+	movq	THIS_ASI_SESSION_isolation_cr3, \scratch_reg
+	mov	\scratch_reg, %cr3
+.Lasi_resume_done_\@:
+.endm
+
+/*
+ * Interrupt ASI, special processing when ASI is interrupted by a NMI
+ * or a paranoid interrupt/exception.
+ */
+.macro ASI_INTERRUPT_AND_SAVE_CR3 scratch_reg:req save_reg:req
+	movq	%cr3, \save_reg
+	/*
+	 * Test the ASI PCID bits. If set, then an ASI page table
+	 * is active. If clear, CR3 already has the kernel page table
+	 * active.
+	 */
+	bt	$ASI_PGTABLE_BIT, \save_reg
+	jnc	.Ldone_\@
+	incl	THIS_ASI_SESSION_idepth
+	ASI_SWITCH_TO_KERNEL_CR3 \scratch_reg
+.Ldone_\@:
+.endm
+
+/*
+ * Resume ASI, special processing when ASI is resumed from a NMI
+ * or a paranoid interrupt/exception.
+ */
+.macro ASI_RESUME_AND_RESTORE_CR3 save_reg:req
+
+	ALTERNATIVE "jmp .Lwrite_cr3_\@", "", X86_FEATURE_PCID
+
+	bt	$ASI_PGTABLE_BIT, \save_reg
+	jnc	.Lrestore_kernel_cr3_\@
+
+	/*
+	 * Restore ASI CR3. We need to update TLB flushing
+	 * information.
+	 */
+	movq	THIS_ASI_SESSION_asi, %rdi
+	movq	\save_reg, %rsi
+	call	asi_update_flush
+	movq	%rax, THIS_ASI_SESSION_isolation_cr3
+	decl	THIS_ASI_SESSION_idepth
+	movq	%rax, %cr3
+	jmp	.Ldone_\@
+
+.Lrestore_kernel_cr3_\@:
+	/*
+	 * Restore kernel CR3. KERNEL pages can always resume
+	 * with NOFLUSH as we do explicit flushes.
+	 */
+	SET_NOFLUSH_BIT \save_reg
+
+.Lwrite_cr3_\@:
+	movq	\save_reg, %cr3
+
+.Ldone_\@:
+.endm
+
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* CONFIG_ADDRESS_SPACE_ISOLATION */
diff --git a/arch/x86/include/asm/asi_session.h b/arch/x86/include/asm/asi_session.h
index 9d39c93..85968f7 100644
--- a/arch/x86/include/asm/asi_session.h
+++ b/arch/x86/include/asm/asi_session.h
@@ -10,6 +10,13 @@ struct asi_session {
 	struct asi		*asi;		/* ASI for this session */
 	unsigned long		isolation_cr3;	/* cr3 when ASI is active */
 	unsigned long		original_cr3;	/* cr3 before entering ASI */
+	/*
+	 * The interrupt depth (idepth) tracks interrupt (actually
+	 * interrupt/exception/NMI) nesting. ASI is interrupted on
+	 * the first interrupt, and it is resumed when that interrupt
+	 * handler returns.
+	 */
+	unsigned int		idepth;		/* interrupt depth */
 };
 
 #endif	/* CONFIG_ADDRESS_SPACE_ISOLATION */
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 2d65443..b29e866 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -358,7 +358,8 @@ static inline unsigned long __get_current_cr3_fast(void)
 	 * field of the ASI session.
 	 */
 	if (IS_ENABLED(CONFIG_ADDRESS_SPACE_ISOLATION) &&
-	    this_cpu_read(cpu_asi_session.asi)) {
+	    this_cpu_read(cpu_asi_session.asi) &&
+	    !this_cpu_read(cpu_asi_session.idepth)) {
 		cr3 = this_cpu_read(cpu_asi_session.isolation_cr3);
 		/* CR3 read never returns with the NOFLUSH bit */
 		cr3 &= ~X86_CR3_PCID_NOFLUSH;
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 5c7ee3d..a4316aa 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -95,6 +95,11 @@ static void __used common(void)
 
 	/* TLB state for the entry code */
 	OFFSET(TLB_STATE_user_pcid_flush_mask, tlb_state, user_pcid_flush_mask);
+	OFFSET(TLB_STATE_asi, tlb_state, asi_session.asi);
+	OFFSET(TLB_STATE_asi_isolation_cr3, tlb_state,
+	       asi_session.isolation_cr3);
+	OFFSET(TLB_STATE_asi_original_cr3, tlb_state, asi_session.original_cr3);
+	OFFSET(TLB_STATE_asi_idepth, tlb_state, asi_session.idepth);
 
 	/* Layout info for cpu_entry_area */
 	OFFSET(CPU_ENTRY_AREA_entry_stack, cpu_entry_area, entry_stack_page);
diff --git a/arch/x86/mm/asi.c b/arch/x86/mm/asi.c
index cf0d122..c91ba82 100644
--- a/arch/x86/mm/asi.c
+++ b/arch/x86/mm/asi.c
@@ -68,7 +68,7 @@ void asi_set_pagetable(struct asi *asi, pgd_t *pagetable)
  * Return an updated ASI CR3 value which specified if TLB needs to
  * be flushed or not.
  */
-static unsigned long asi_update_flush(struct asi *asi, unsigned long asi_cr3)
+unsigned long asi_update_flush(struct asi *asi, unsigned long asi_cr3)
 {
 	struct asi_tlb_pgtable *tlb_pgtable;
 	struct asi_tlb_state *tlb_state;
@@ -90,7 +90,24 @@ static unsigned long asi_update_flush(struct asi *asi, unsigned long asi_cr3)
 	return asi_cr3;
 }
 
-static void asi_switch_to_asi_cr3(struct asi *asi)
+
+/*
+ * Switch to the ASI pagetable.
+ *
+ * If schedule is ASI_SWITCH_NOW, then immediately switch to the ASI
+ * pagetable by updating the CR3 register with the ASI CR3 value.
+ * Otherwise, if schedule is ASI_SWITCH_ON_RESUME, prepare everything
+ * for switching to ASI pagetable but do not update the CR3 register
+ * yet. This will be done by the next ASI_RESUME call.
+ */
+
+enum asi_switch_schedule {
+	ASI_SWITCH_NOW,
+	ASI_SWITCH_ON_RESUME,
+};
+
+static void asi_switch_to_asi_cr3(struct asi *asi,
+				  enum asi_switch_schedule schedule)
 {
 	unsigned long original_cr3, asi_cr3;
 	struct asi_session *asi_session;
@@ -114,8 +131,16 @@ static void asi_switch_to_asi_cr3(struct asi *asi)
 	asi_session->original_cr3 = original_cr3;
 	asi_session->isolation_cr3 = asi_cr3;
 
-	/* Update CR3 to immediately enter ASI */
-	native_write_cr3(asi_cr3);
+	if (schedule == ASI_SWITCH_ON_RESUME) {
+		/*
+		 * Defer the CR3 update the next ASI resume by setting
+		 * the interrupt depth to 1.
+		 */
+		asi_session->idepth = 1;
+	} else {
+		/* Update CR3 to immediately enter ASI */
+		native_write_cr3(asi_cr3);
+	}
 }
 
 static void asi_switch_to_kernel_cr3(struct asi *asi)
@@ -132,6 +157,7 @@ static void asi_switch_to_kernel_cr3(struct asi *asi)
 
 	asi_session = &get_cpu_var(cpu_asi_session);
 	asi_session->asi = NULL;
+	asi_session->idepth = 0;
 }
 
 int asi_enter(struct asi *asi)
@@ -153,7 +179,7 @@ int asi_enter(struct asi *asi)
 	}
 
 	local_irq_save(flags);
-	asi_switch_to_asi_cr3(asi);
+	asi_switch_to_asi_cr3(asi, ASI_SWITCH_NOW);
 	local_irq_restore(flags);
 
 	return 0;
@@ -162,8 +188,10 @@ int asi_enter(struct asi *asi)
 
 void asi_exit(struct asi *asi)
 {
+	struct asi_session *asi_session;
 	struct asi *current_asi;
 	unsigned long flags;
+	int idepth;
 
 	current_asi = this_cpu_read(cpu_asi_session.asi);
 	if (!current_asi) {
@@ -173,8 +201,31 @@ void asi_exit(struct asi *asi)
 
 	WARN_ON(current_asi != asi);
 
-	local_irq_save(flags);
-	asi_switch_to_kernel_cr3(asi);
-	local_irq_restore(flags);
+	idepth = this_cpu_read(cpu_asi_session.idepth);
+	if (!idepth) {
+		local_irq_save(flags);
+		asi_switch_to_kernel_cr3(asi);
+		local_irq_restore(flags);
+	} else {
+		/*
+		 * ASI was interrupted so we already switched back
+		 * to the back to the kernel page table and we just
+		 * need to clear the ASI session.
+		 */
+		asi_session = &get_cpu_var(cpu_asi_session);
+		asi_session->asi = NULL;
+		asi_session->idepth = 0;
+	}
 }
 EXPORT_SYMBOL(asi_exit);
+
+void asi_prepare_resume(void)
+{
+	struct asi_session *asi_session;
+
+	asi_session = &get_cpu_var(cpu_asi_session);
+	if (!asi_session->asi || asi_session->idepth > 1)
+		return;
+
+	asi_switch_to_asi_cr3(asi_session->asi, ASI_SWITCH_ON_RESUME);
+}
-- 
1.7.1

