Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C6CC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45E96206E7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731875AbgIHR4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:56:24 -0400
Received: from mga09.intel.com ([134.134.136.24]:59820 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731621AbgIHRzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 13:55:52 -0400
IronPort-SDR: UVMW7qX+mHkLV2BHKJyP3pyH8pa+ICN525ynVITkTJtWOHsJXD05Nj+cNJsYiS7OMoKEPH7BYJ
 Q9E8pFOrtWRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="159163307"
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; 
   d="scan'208";a="159163307"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 10:55:28 -0700
IronPort-SDR: n/h2poLfSYmLXFBuD7PdArSoBhgho/SyETP9dAg62ftynggz5cnuwzKR++ZVQ/hteIoOrGI2i0
 VsKMyY5aeqTw==
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; 
   d="scan'208";a="480125776"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 10:55:28 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        Youquan Song <youquan.song@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] x86/mce: Decode a kernel instruction to determine if it is copying from user
Date:   Tue,  8 Sep 2020 10:55:19 -0700
Message-Id: <20200908175519.14223-9-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200908175519.14223-1-tony.luck@intel.com>
References: <20200908175519.14223-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All instructions copying data between kernel and user memory are tagged
with either _ASM_EXTABLE_UA or _ASM_EXTABLE_CPY entries in the exception
table. ex_fault_handler_type() returns HANDLER_UACCESS for both of these.

Recovery is only possible when the machine check was triggered on a read
from user memory. In this case the same strategy for recovery applies as
if the user had made the access in ring3. If the fault was in kernel
memory while copying to user we do not currently have a recovery plan.

Decoding the instruction that was executing when the fault occurred
mostly provides enough information to determine direction of the data
copy. In the case of "REP MOVS*" instructions it is necessary to also
check the value in the %rsi register.

Co-developed-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c     | 10 +++++++---
 arch/x86/kernel/cpu/mce/severity.c | 32 +++++++++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 2a3c42329c3f..cf18d09767cc 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1190,13 +1190,17 @@ static void kill_me_maybe(struct callback_head *cb)
 	if (!p->mce_ripv)
 		flags |= MF_MUST_KILL;
 
-	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags)) {
+	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags) && !p->mce_vaddr) {
 		set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
 		return;
 	}
 
-	pr_err("Memory error not recovered");
-	kill_me_now(cb);
+	if (p->mce_vaddr != (void __user *)~0ul) {
+		force_sig_mceerr(BUS_MCEERR_AR, p->mce_vaddr, PAGE_SHIFT);
+	} else {
+		pr_err("Memory error not recovered");
+		kill_me_now(cb);
+	}
 }
 
 /*
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 1419b3c217f2..16f17cdebf65 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -10,6 +10,8 @@
 #include <linux/init.h>
 #include <linux/debugfs.h>
 #include <asm/mce.h>
+#include <asm/traps.h>
+#include <asm/insn.h>
 #include <linux/uaccess.h>
 
 #include "internal.h"
@@ -198,6 +200,27 @@ static struct severity {
 #define mc_recoverable(mcg) (((mcg) & (MCG_STATUS_RIPV|MCG_STATUS_EIPV)) == \
 				(MCG_STATUS_RIPV|MCG_STATUS_EIPV))
 
+static bool is_copy_from_user(struct pt_regs *regs)
+{
+	u8 insn_buf[MAX_INSN_SIZE];
+	struct insn insn;
+
+	if (copy_from_kernel_nofault(insn_buf, (void *)regs->ip, MAX_INSN_SIZE))
+		return false;
+	kernel_insn_init(&insn, insn_buf, MAX_INSN_SIZE);
+	insn_get_length(&insn);
+
+	switch (insn.opcode.value) {
+	case 0x8A: case 0x8B:		/* MOV */
+	case 0xB60F: case 0xB70F:	/* MOVZ */
+		return true;
+	case 0xA4: case 0xA5:		/* MOVS */
+		return !fault_in_kernel_space(regs->si);
+	}
+
+	return false;
+}
+
 /*
  * If mcgstatus indicated that ip/cs on the stack were
  * no good, then "m->cs" will be zero and we will have
@@ -215,10 +238,17 @@ static int error_context(struct mce *m, struct pt_regs *regs)
 
 	if ((m->cs & 3) == 3)
 		return IN_USER;
+	if (!mc_recoverable(m->mcgstatus))
+		return IN_KERNEL;
 
 	t = ex_fault_handler_type(m->ip);
-	if (mc_recoverable(m->mcgstatus) && t == HANDLER_FAULT) {
+	if (t == HANDLER_FAULT) {
+		m->kflags |= MCE_IN_KERNEL_RECOV;
+		return IN_KERNEL_RECOV;
+	}
+	if (t == HANDLER_UACCESS && regs && is_copy_from_user(regs)) {
 		m->kflags |= MCE_IN_KERNEL_RECOV;
+		m->kflags |= MCE_IN_KERNEL_COPYIN;
 		return IN_KERNEL_RECOV;
 	}
 
-- 
2.21.1

