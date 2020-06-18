Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29B1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7A7F207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbgFRNvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 09:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730564AbgFRNvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 09:51:06 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51464C06174E;
        Thu, 18 Jun 2020 06:51:06 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jluwZ-0002lz-43; Thu, 18 Jun 2020 15:51:03 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AE0401C032F;
        Thu, 18 Jun 2020 15:50:58 +0200 (CEST)
Date:   Thu, 18 Jun 2020 13:50:58 -0000
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fsgsbase] x86/fsgsbase/64: Enable FSGSBASE instructions in
 helper functions
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1557309753-24073-7-git-send-email-chang.seok.bae@intel.com>
References: <1557309753-24073-7-git-send-email-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <159248825847.16989.12376221390897516192.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/fsgsbase branch of tip:

Commit-ID:     58edfd2e0a93c9adc2f29902a0335af0584041a0
Gitweb:        https://git.kernel.org/tip/58edfd2e0a93c9adc2f29902a0335af0584041a0
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Thu, 28 May 2020 16:13:50 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 18 Jun 2020 15:47:00 +02:00

x86/fsgsbase/64: Enable FSGSBASE instructions in helper functions

Add cpu feature conditional FSGSBASE access to the relevant helper
functions. That allows to accelerate certain FS/GS base operations in
subsequent changes.

Note, that while possible, the user space entry/exit GSBASE operations are
not going to use the new FSGSBASE instructions. The reason is that it would
require additional storage for the user space value which adds more
complexity to the low level code and experiments have shown marginal
benefit. This may be revisited later but for now the SWAPGS based handling
in the entry code is preserved except for the paranoid entry/exit code.

To preserve the SWAPGS entry mechanism introduce __[rd|wr]gsbase_inactive()
helpers. Note, for Xen PV, paravirt hooks can be added later as they might
allow a very efficient but different implementation.

[ tglx: Massaged changelog, convert it to noinstr and force inline
  	native_swapgs() ]

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1557309753-24073-7-git-send-email-chang.seok.bae@intel.com
Link: https://lkml.kernel.org/r/20200528201402.1708239-5-sashal@kernel.org


---
 arch/x86/include/asm/fsgsbase.h  | 27 +++++-------
 arch/x86/include/asm/processor.h |  2 +-
 arch/x86/kernel/process_64.c     | 68 +++++++++++++++++++++++++++++++-
 3 files changed, 81 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
index fdd1177..aefd537 100644
--- a/arch/x86/include/asm/fsgsbase.h
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -49,35 +49,32 @@ static __always_inline void wrgsbase(unsigned long gsbase)
 	asm volatile("wrgsbase %0" :: "r" (gsbase) : "memory");
 }
 
+#include <asm/cpufeature.h>
+
 /* Helper functions for reading/writing FS/GS base */
 
 static inline unsigned long x86_fsbase_read_cpu(void)
 {
 	unsigned long fsbase;
 
-	rdmsrl(MSR_FS_BASE, fsbase);
+	if (static_cpu_has(X86_FEATURE_FSGSBASE))
+		fsbase = rdfsbase();
+	else
+		rdmsrl(MSR_FS_BASE, fsbase);
 
 	return fsbase;
 }
 
-static inline unsigned long x86_gsbase_read_cpu_inactive(void)
-{
-	unsigned long gsbase;
-
-	rdmsrl(MSR_KERNEL_GS_BASE, gsbase);
-
-	return gsbase;
-}
-
 static inline void x86_fsbase_write_cpu(unsigned long fsbase)
 {
-	wrmsrl(MSR_FS_BASE, fsbase);
+	if (static_cpu_has(X86_FEATURE_FSGSBASE))
+		wrfsbase(fsbase);
+	else
+		wrmsrl(MSR_FS_BASE, fsbase);
 }
 
-static inline void x86_gsbase_write_cpu_inactive(unsigned long gsbase)
-{
-	wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
-}
+extern unsigned long x86_gsbase_read_cpu_inactive(void);
+extern void x86_gsbase_write_cpu_inactive(unsigned long gsbase);
 
 #endif /* CONFIG_X86_64 */
 
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 42cd333..f66202d 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -575,7 +575,7 @@ native_load_sp0(unsigned long sp0)
 	this_cpu_write(cpu_tss_rw.x86_tss.sp0, sp0);
 }
 
-static inline void native_swapgs(void)
+static __always_inline void native_swapgs(void)
 {
 #ifdef CONFIG_X86_64
 	asm volatile("swapgs" ::: "memory");
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 9a97415..c41e0aa 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -150,6 +150,44 @@ enum which_selector {
 };
 
 /*
+ * Out of line to be protected from kprobes and tracing. If this would be
+ * traced or probed than any access to a per CPU variable happens with
+ * the wrong GS.
+ *
+ * It is not used on Xen paravirt. When paravirt support is needed, it
+ * needs to be renamed with native_ prefix.
+ */
+static noinstr unsigned long __rdgsbase_inactive(void)
+{
+	unsigned long gsbase;
+
+	lockdep_assert_irqs_disabled();
+
+	native_swapgs();
+	gsbase = rdgsbase();
+	native_swapgs();
+
+	return gsbase;
+}
+
+/*
+ * Out of line to be protected from kprobes and tracing. If this would be
+ * traced or probed than any access to a per CPU variable happens with
+ * the wrong GS.
+ *
+ * It is not used on Xen paravirt. When paravirt support is needed, it
+ * needs to be renamed with native_ prefix.
+ */
+static noinstr void __wrgsbase_inactive(unsigned long gsbase)
+{
+	lockdep_assert_irqs_disabled();
+
+	native_swapgs();
+	wrgsbase(gsbase);
+	native_swapgs();
+}
+
+/*
  * Saves the FS or GS base for an outgoing thread if FSGSBASE extensions are
  * not available.  The goal is to be reasonably fast on non-FSGSBASE systems.
  * It's forcibly inlined because it'll generate better code and this function
@@ -327,6 +365,36 @@ static unsigned long x86_fsgsbase_read_task(struct task_struct *task,
 	return base;
 }
 
+unsigned long x86_gsbase_read_cpu_inactive(void)
+{
+	unsigned long gsbase;
+
+	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+		unsigned long flags;
+
+		local_irq_save(flags);
+		gsbase = __rdgsbase_inactive();
+		local_irq_restore(flags);
+	} else {
+		rdmsrl(MSR_KERNEL_GS_BASE, gsbase);
+	}
+
+	return gsbase;
+}
+
+void x86_gsbase_write_cpu_inactive(unsigned long gsbase)
+{
+	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+		unsigned long flags;
+
+		local_irq_save(flags);
+		__wrgsbase_inactive(gsbase);
+		local_irq_restore(flags);
+	} else {
+		wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
+	}
+}
+
 unsigned long x86_fsbase_read_task(struct task_struct *task)
 {
 	unsigned long fsbase;
