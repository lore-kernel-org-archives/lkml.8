Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A9EC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 486B52074B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731683AbgIHRz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:55:59 -0400
Received: from mga09.intel.com ([134.134.136.24]:59820 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731594AbgIHRze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 13:55:34 -0400
IronPort-SDR: 5TdbSyh/AVzbipXZtO7+RxEnjf9TugGaADiW0YE/mB7ZzcQRztJdWicvoHwjbcWJfxWFLagV9t
 DklPNcIosSog==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="159163304"
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; 
   d="scan'208";a="159163304"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 10:55:28 -0700
IronPort-SDR: ZV+rcHAmmT8P33/+J8muJJWhHw/AsHt1CEK4zN1HNsG91xnutwg9BW+9Z9axzCqjmQi9SKSq2v
 Fx6ZF98jKujg==
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; 
   d="scan'208";a="480125773"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 10:55:28 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Youquan Song <youquan.song@intel.com>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] x86/mce: Recover from poison found while copying from user space
Date:   Tue,  8 Sep 2020 10:55:18 -0700
Message-Id: <20200908175519.14223-8-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200908175519.14223-1-tony.luck@intel.com>
References: <20200908175519.14223-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Youquan Song <youquan.song@intel.com>

Existing kernel code can only recover from a machine check on code that
tagged in the exception table with a fault handling recovery path.

New field in the task structure mce_vaddr is initialized to the
user virtual address of the fault. This is so that kill_me_maybe()
can provide that information to the user SIGBUS handler.

Add code to recover from a machine check while copying data from user
space to the kernel. Action for this case is the same as if the user
touched the poison directly; unmap the page and send a SIGBUS to the task.

Signed-off-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c | 51 ++++++++++++++++++++++++++++++++++
 include/linux/sched.h          |  1 +
 2 files changed, 52 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 5512318a07ae..2a3c42329c3f 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -53,6 +53,8 @@
 #include <asm/mce.h>
 #include <asm/msr.h>
 #include <asm/reboot.h>
+#include <asm/insn.h>
+#include <asm/insn-eval.h>
 
 #include "internal.h"
 
@@ -1197,6 +1199,32 @@ static void kill_me_maybe(struct callback_head *cb)
 	kill_me_now(cb);
 }
 
+/*
+ * Decode a kernel instruction that faulted while reading from a user
+ * address and return the linear address that was being read.
+ */
+static void __user *get_virtual_address(struct pt_regs *regs)
+{
+	u8 insn_buf[MAX_INSN_SIZE];
+	struct insn insn;
+
+	if (copy_from_kernel_nofault(insn_buf, (void *)regs->ip, MAX_INSN_SIZE))
+		return (void __user *)~0ul;
+
+	kernel_insn_init(&insn, insn_buf, MAX_INSN_SIZE);
+	insn_get_length(&insn);
+	insn_get_modrm(&insn);
+	insn_get_sib(&insn);
+
+	/*
+	 * For MOVS[BWLQ] the source address is in %rsi
+	 */
+	if (insn.opcode.value == 0xa4 || insn.opcode.value == 0xa5)
+		return (void __user *)regs->si;
+	else
+		return insn_get_addr_ref(&insn, regs);
+}
+
 /*
  * The actual machine check handler. This only handles real
  * exceptions when something got corrupted coming in through int 18.
@@ -1342,6 +1370,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		/* If this triggers there is no way to recover. Die hard. */
 		BUG_ON(!on_thread_stack() || !user_mode(regs));
 
+		current->mce_vaddr = NULL;
 		current->mce_addr = m.addr;
 		current->mce_ripv = !!(m.mcgstatus & MCG_STATUS_RIPV);
 		current->mce_whole_page = whole_page(&m);
@@ -1350,6 +1379,13 @@ noinstr void do_machine_check(struct pt_regs *regs)
 			current->mce_kill_me.func = kill_me_now;
 		task_work_add(current, &current->mce_kill_me, true);
 	} else {
+		/*
+		 * Before fixing the exception IP, find the user address
+		 * in the MCE_IN_KERNEL_COPYIN case
+		 */
+		if (m.kflags & MCE_IN_KERNEL_COPYIN)
+			current->mce_vaddr = get_virtual_address(regs);
+
 		/*
 		 * Handle an MCE which has happened in kernel space but from
 		 * which the kernel can recover: ex_has_fault_handler() has
@@ -1363,6 +1399,21 @@ noinstr void do_machine_check(struct pt_regs *regs)
 			if (!fixup_exception(regs, X86_TRAP_MC, 0, 0))
 				mce_panic("Failed kernel mode recovery", &m, msg);
 		}
+
+		/*
+		 * MCE on user data while copying to kernel. Action here is
+		 * very similar to the user hitting the poison themself.
+		 * Poison page will be unmapped and signal sent to process.
+		 */
+		if (m.kflags & MCE_IN_KERNEL_COPYIN) {
+			current->mce_addr = m.addr;
+			current->mce_ripv = !!(m.mcgstatus & MCG_STATUS_RIPV);
+			current->mce_whole_page = whole_page(&m);
+			current->mce_kill_me.func = kill_me_maybe;
+			if (kill_it)
+				current->mce_kill_me.func = kill_me_now;
+			task_work_add(current, &current->mce_kill_me, true);
+		}
 	}
 }
 EXPORT_SYMBOL_GPL(do_machine_check);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index afe01e232935..fe384c097ce3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1308,6 +1308,7 @@ struct task_struct {
 #endif
 
 #ifdef CONFIG_X86_MCE
+	void __user			*mce_vaddr;
 	u64				mce_addr;
 	__u64				mce_ripv : 1,
 					mce_whole_page : 1,
-- 
2.21.1

