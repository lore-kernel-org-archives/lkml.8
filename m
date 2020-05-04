Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20A8C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 14:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A46F8206D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 14:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XZKYWr18"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbgEDOv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 10:51:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56564 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbgEDOvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 10:51:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044ElhN0024557;
        Mon, 4 May 2020 14:51:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=TS1kNnb45s8+qP1Fov+EsfUHmkKg6QnEgbUAWnEhWdk=;
 b=XZKYWr18cq07husTSVI30bZnqXq1iiifkdxU4bl9wU3VrxI3y+JqPcNY0A8rpkUJNBhD
 F4m1z/cud070WfMZ1dR/pF+Y/cXgjHMKrN1DH3g/4c3xJKL3Y6U3pGPuF+9Ba6Jhlr/u
 I/Bl3l6WKoRzOQULvyOq9Utc7rRBQVsJGNWbUOe2yFdPU1aiyVSxy/u2p19/xpQZtOXS
 wd4uvZZUS8hHzj+4PFg/lRCjMCt7Sp6sV3ayLr4tCkVCk4AHT4xvdiFr2NS3uqyAmbjj
 rB15/NW34SOpmhqQ5Y7PFnP2XOrfD887MG6ME7PxXtpyPD6mq2a8ffNpKx3t4XEqtuJv jA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 30s1gmy6m7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 14:51:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044ElLdk033746;
        Mon, 4 May 2020 14:51:29 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 30sjnav447-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 14:51:29 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 044EpR0r022638;
        Mon, 4 May 2020 14:51:27 GMT
Received: from linux-1.home.com (/10.175.9.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 07:51:26 -0700
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
Subject: [RFC v4][PATCH part-1 6/7] mm/asi: ASI fault handler
Date:   Mon,  4 May 2020 16:49:38 +0200
Message-Id: <20200504144939.11318-7-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200504144939.11318-1-alexandre.chartre@oracle.com>
References: <20200504144939.11318-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an ASI fault handler and options to define the handler behavior.
Depending on the ASI, the ASI fault handler can either abort the
isolation and retry the faulty instruction with the full kernel
page-table, or preserve the isolation and process the fault like
any regular fault. If isolation is aborted then the location and
address of the fault can be logged and optionally include a stack
trace.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/include/asm/asi.h | 42 ++++++++++++++++-
 arch/x86/mm/asi.c          | 95 ++++++++++++++++++++++++++++++++++++++
 arch/x86/mm/fault.c        | 20 ++++++++
 3 files changed, 156 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/asi.h b/arch/x86/include/asm/asi.h
index a0733f1e4a67..b8d7b936cd19 100644
--- a/arch/x86/include/asm/asi.h
+++ b/arch/x86/include/asm/asi.h
@@ -66,6 +66,7 @@ struct asi_type {
 	int			pcid_prefix;	/* PCID prefix */
 	struct asi_tlb_state	*tlb_state;	/* percpu ASI TLB state */
 	atomic64_t		last_pgtable_id; /* last id for this type */
+	bool			fault_abort;	/* abort ASI on fault? */
 };
 
 /*
@@ -75,12 +76,13 @@ struct asi_type {
  * (asi_create_<typename>()) to easily create an ASI of the
  * specified type.
  */
-#define DEFINE_ASI_TYPE(name, pcid_prefix)			\
+#define DEFINE_ASI_TYPE(name, pcid_prefix, fault_abort)		\
 	DEFINE_PER_CPU(struct asi_tlb_state, asi_tlb_ ## name);	\
 	struct asi_type asi_type_ ## name = {			\
 		pcid_prefix,					\
 		&asi_tlb_ ## name,				\
 		ATOMIC64_INIT(1),				\
+		fault_abort					\
 	};							\
 	EXPORT_SYMBOL(asi_type_ ## name)
 
@@ -94,16 +96,49 @@ static inline struct asi *asi_create_ ## name(void)	\
 	return asi_create(&asi_type_ ## name);		\
 }
 
+/* ASI fault log size */
+#define ASI_FAULT_LOG_SIZE      128
+
+/*
+ * Options to specify the fault log policy when a fault occurs
+ * while using ASI.
+ *
+ * When set, ASI_FAULT_LOG_KERNEL|USER log the address and location
+ * of the fault. In addition, if ASI_FAULT_LOG_STACK is set, the stack
+ * trace where the fault occurred is also logged.
+ *
+ * Faults are logged only for ASIs with a type which aborts ASI on an
+ * ASI fault (see fault_abort in struct asi_type).
+ */
+#define ASI_FAULT_LOG_KERNEL	0x01	/* log kernel faults */
+#define ASI_FAULT_LOG_USER	0x02	/* log user faults */
+#define ASI_FAULT_LOG_STACK	0x04	/* log stack trace */
+
+enum asi_fault_origin {
+	ASI_FAULT_KERNEL = ASI_FAULT_LOG_KERNEL,
+	ASI_FAULT_USER = ASI_FAULT_LOG_USER,
+};
+
+struct asi_fault_log {
+	unsigned long		address;	/* fault address */
+	unsigned long		count;		/* fault count */
+};
+
 struct asi {
 	struct asi_type		*type;		/* ASI type */
 	pgd_t			*pagetable;	/* ASI pagetable */
 	u64			pgtable_id;	/* ASI pagetable ID */
 	atomic64_t		pgtable_gen;	/* ASI pagetable generation */
 	unsigned long		base_cr3;	/* base ASI CR3 */
+	spinlock_t		fault_lock;	/* protect fault_log_* */
+	struct asi_fault_log	fault_log[ASI_FAULT_LOG_SIZE];
+	int			fault_log_policy; /* fault log policy */
 };
 
 void asi_schedule_out(struct task_struct *task);
 void asi_schedule_in(struct task_struct *task);
+bool asi_fault(struct pt_regs *regs, unsigned long error_code,
+	       unsigned long address, enum asi_fault_origin fault_origin);
 
 extern struct asi *asi_create(struct asi_type *type);
 extern void asi_destroy(struct asi *asi);
@@ -111,6 +146,11 @@ extern void asi_set_pagetable(struct asi *asi, pgd_t *pagetable);
 extern int asi_enter(struct asi *asi);
 extern void asi_exit(struct asi *asi);
 
+static inline void asi_set_log_policy(struct asi *asi, int policy)
+{
+	asi->fault_log_policy = policy;
+}
+
 #else  /* __ASSEMBLY__ */
 
 #include <asm/alternative-asm.h>
diff --git a/arch/x86/mm/asi.c b/arch/x86/mm/asi.c
index 3795582c66d8..a4a5d35fb779 100644
--- a/arch/x86/mm/asi.c
+++ b/arch/x86/mm/asi.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/mm.h>
+#include <linux/sched/debug.h>
 #include <linux/slab.h>
 
 #include <asm/asi.h>
@@ -13,6 +14,97 @@
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
 
+static void asi_log_fault(struct asi *asi, struct pt_regs *regs,
+			   unsigned long error_code, unsigned long address,
+			   enum asi_fault_origin fault_origin)
+{
+	int i;
+
+	/*
+	 * Log information about the fault only if this is a fault
+	 * we don't know about yet (and the fault log is not full).
+	 */
+	spin_lock(&asi->fault_lock);
+	if (!(asi->fault_log_policy & fault_origin)) {
+		spin_unlock(&asi->fault_lock);
+		return;
+	}
+	for (i = 0; i < ASI_FAULT_LOG_SIZE; i++) {
+		if (asi->fault_log[i].address == regs->ip) {
+			asi->fault_log[i].count++;
+			spin_unlock(&asi->fault_lock);
+			return;
+		}
+		if (!asi->fault_log[i].address) {
+			asi->fault_log[i].address = regs->ip;
+			asi->fault_log[i].count = 1;
+			break;
+		}
+	}
+
+	if (i >= ASI_FAULT_LOG_SIZE) {
+		pr_warn("ASI %p: fault log buffer is full [%d]\n",
+			asi, i);
+	}
+
+	pr_info("ASI %p: PF#%d (%ld) at %pS on %px\n", asi, i,
+		error_code, (void *)regs->ip, (void *)address);
+
+	if (asi->fault_log_policy & ASI_FAULT_LOG_STACK)
+		show_stack(NULL, (unsigned long *)regs->sp);
+
+	spin_unlock(&asi->fault_lock);
+}
+
+bool asi_fault(struct pt_regs *regs, unsigned long error_code,
+	       unsigned long address, enum asi_fault_origin fault_origin)
+{
+	struct asi_session *asi_session;
+
+	/*
+	 * If address space isolation was active when the fault occurred
+	 * then the page fault handler has interrupted the isolation
+	 * (exception handlers interrupt isolation very early) and switched
+	 * CR3 back to its original kernel value. So we can safely retrieved
+	 * the CPU ASI session.
+	 */
+	asi_session = &get_cpu_var(cpu_asi_session);
+
+	/*
+	 * If address space isolation is not active, or we have a fault
+	 * after isolation was aborted then this was not a fault while
+	 * using ASI and we don't handle it.
+	 */
+	if (!asi_session->asi || asi_session->idepth > 1)
+		return false;
+
+	/*
+	 * We have a fault while the CPU is using address space isolation.
+	 * Depending on the ASI fault policy, either:
+	 *
+	 * - Abort the isolation. The ASI used when the fault occurred is
+	 *   aborted, and the faulty instruction is immediately retried.
+	 *   The fault is not processed by the system fault handler. The
+	 *   fault handler will return immediately, the system will not
+	 *   restore the ASI pagetable and will continue to run with the
+	 *   full kernel pagetable.
+	 *
+	 * - Or preserve the isolation. The system fault handler will
+	 *   process the fault like any regular fault. The ASI pagetable
+	 *   be restored after the fault has been handled and the system
+	 *   fault handler returns.
+	 */
+	if (asi_session->asi->type->fault_abort) {
+		asi_log_fault(asi_session->asi, regs, error_code,
+			      address, fault_origin);
+		asi_session->asi = NULL;
+		asi_session->idepth = 0;
+		return true;
+	}
+
+	return false;
+}
+
 struct asi *asi_create(struct asi_type *type)
 {
 	struct asi *asi;
@@ -27,6 +119,9 @@ struct asi *asi_create(struct asi_type *type)
 	asi->type = type;
 	asi->pgtable_id = atomic64_inc_return(&type->last_pgtable_id);
 	atomic64_set(&asi->pgtable_gen, 0);
+	spin_lock_init(&asi->fault_lock);
+	/* by default, log ASI kernel faults */
+	asi->fault_log_policy = ASI_FAULT_LOG_KERNEL;
 
 	return asi;
 }
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index a51df516b87b..fa278030df65 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -30,6 +30,7 @@
 #include <asm/desc.h>			/* store_idt(), ...		*/
 #include <asm/cpu_entry_area.h>		/* exception stack		*/
 #include <asm/pgtable_areas.h>		/* VMALLOC_START, ...		*/
+#include <asm/asi.h>			/* asi_fault()			*/
 
 #define CREATE_TRACE_POINTS
 #include <asm/trace/exceptions.h>
@@ -1257,6 +1258,15 @@ do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
 	 */
 	WARN_ON_ONCE(hw_error_code & X86_PF_PK);
 
+	/*
+	 * Check if the fault occurs with ASI and if the ASI handler
+	 * handles it.
+	 */
+	if (IS_ENABLED(CONFIG_ADDRESS_SPACE_ISOLATION) &&
+	    asi_fault(regs, hw_error_code, address, ASI_FAULT_KERNEL)) {
+		return;
+	}
+
 	/*
 	 * We can fault-in kernel-space virtual memory on-demand. The
 	 * 'reference' page table is init_mm.pgd.
@@ -1312,6 +1322,16 @@ void do_user_addr_fault(struct pt_regs *regs,
 	vm_fault_t fault, major = 0;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
 
+
+	/*
+	 * Check if the fault occurs with ASI and if the ASI handler
+	 * handles it.
+	 */
+	if (IS_ENABLED(CONFIG_ADDRESS_SPACE_ISOLATION) &&
+	    asi_fault(regs, hw_error_code, address, ASI_FAULT_USER)) {
+		return;
+	}
+
 	tsk = current;
 	mm = tsk->mm;
 
-- 
2.18.2

