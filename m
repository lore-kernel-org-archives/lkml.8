Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689E9C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4933920753
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbgEFSJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 14:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729882AbgEFSIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 14:08:34 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C86C061A0F;
        Wed,  6 May 2020 11:08:34 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jWOT8-0001G8-4m; Wed, 06 May 2020 20:08:30 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B53A41C0092;
        Wed,  6 May 2020 20:08:29 +0200 (CEST)
Date:   Wed, 06 May 2020 18:08:29 -0000
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Rename asm/resctrl_sched.h to asm/resctrl.h
Cc:     Borislav Petkov <bp@suse.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: =?utf-8?q?=3C6914e0ef880b539a82a6d889f9423496d471ad1d=2E15887?=
 =?utf-8?q?15690=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C6914e0ef880b539a82a6d889f9423496d471ad1d=2E158871?=
 =?utf-8?q?5690=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <158878850970.8414.4772744677162806934.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     8dd97c65185c5a63c668e5bd8a861c04f47a35ed
Gitweb:        https://git.kernel.org/tip/8dd97c65185c5a63c668e5bd8a861c04f47a35ed
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Tue, 05 May 2020 15:36:12 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 06 May 2020 17:45:22 +02:00

x86/resctrl: Rename asm/resctrl_sched.h to asm/resctrl.h

asm/resctrl_sched.h is dedicated to the code used for configuration
of the CPU resource control state when a task is scheduled.

Rename resctrl_sched.h to resctrl.h in preparation of additions that
will no longer make this file dedicated to work done during scheduling.

No functional change.

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/6914e0ef880b539a82a6d889f9423496d471ad1d.1588715690.git.reinette.chatre@intel.com
---
 MAINTAINERS                               |  2 +-
 arch/x86/include/asm/resctrl.h            | 93 ++++++++++++++++++++++-
 arch/x86/include/asm/resctrl_sched.h      | 93 +----------------------
 arch/x86/kernel/cpu/resctrl/core.c        |  2 +-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  2 +-
 arch/x86/kernel/process_32.c              |  2 +-
 arch/x86/kernel/process_64.c              |  2 +-
 8 files changed, 99 insertions(+), 99 deletions(-)
 create mode 100644 arch/x86/include/asm/resctrl.h
 delete mode 100644 arch/x86/include/asm/resctrl_sched.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 2926327..ecfb07a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14227,7 +14227,7 @@ M:	Reinette Chatre <reinette.chatre@intel.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	Documentation/x86/resctrl*
-F:	arch/x86/include/asm/resctrl_sched.h
+F:	arch/x86/include/asm/resctrl.h
 F:	arch/x86/kernel/cpu/resctrl/
 F:	tools/testing/selftests/resctrl/
 
diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
new file mode 100644
index 0000000..99b5728
--- /dev/null
+++ b/arch/x86/include/asm/resctrl.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_RESCTRL_H
+#define _ASM_X86_RESCTRL_H
+
+#ifdef CONFIG_X86_CPU_RESCTRL
+
+#include <linux/sched.h>
+#include <linux/jump_label.h>
+
+#define IA32_PQR_ASSOC	0x0c8f
+
+/**
+ * struct resctrl_pqr_state - State cache for the PQR MSR
+ * @cur_rmid:		The cached Resource Monitoring ID
+ * @cur_closid:	The cached Class Of Service ID
+ * @default_rmid:	The user assigned Resource Monitoring ID
+ * @default_closid:	The user assigned cached Class Of Service ID
+ *
+ * The upper 32 bits of IA32_PQR_ASSOC contain closid and the
+ * lower 10 bits rmid. The update to IA32_PQR_ASSOC always
+ * contains both parts, so we need to cache them. This also
+ * stores the user configured per cpu CLOSID and RMID.
+ *
+ * The cache also helps to avoid pointless updates if the value does
+ * not change.
+ */
+struct resctrl_pqr_state {
+	u32			cur_rmid;
+	u32			cur_closid;
+	u32			default_rmid;
+	u32			default_closid;
+};
+
+DECLARE_PER_CPU(struct resctrl_pqr_state, pqr_state);
+
+DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
+DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
+DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
+
+/*
+ * __resctrl_sched_in() - Writes the task's CLOSid/RMID to IA32_PQR_MSR
+ *
+ * Following considerations are made so that this has minimal impact
+ * on scheduler hot path:
+ * - This will stay as no-op unless we are running on an Intel SKU
+ *   which supports resource control or monitoring and we enable by
+ *   mounting the resctrl file system.
+ * - Caches the per cpu CLOSid/RMID values and does the MSR write only
+ *   when a task with a different CLOSid/RMID is scheduled in.
+ * - We allocate RMIDs/CLOSids globally in order to keep this as
+ *   simple as possible.
+ * Must be called with preemption disabled.
+ */
+static void __resctrl_sched_in(void)
+{
+	struct resctrl_pqr_state *state = this_cpu_ptr(&pqr_state);
+	u32 closid = state->default_closid;
+	u32 rmid = state->default_rmid;
+
+	/*
+	 * If this task has a closid/rmid assigned, use it.
+	 * Else use the closid/rmid assigned to this cpu.
+	 */
+	if (static_branch_likely(&rdt_alloc_enable_key)) {
+		if (current->closid)
+			closid = current->closid;
+	}
+
+	if (static_branch_likely(&rdt_mon_enable_key)) {
+		if (current->rmid)
+			rmid = current->rmid;
+	}
+
+	if (closid != state->cur_closid || rmid != state->cur_rmid) {
+		state->cur_closid = closid;
+		state->cur_rmid = rmid;
+		wrmsr(IA32_PQR_ASSOC, rmid, closid);
+	}
+}
+
+static inline void resctrl_sched_in(void)
+{
+	if (static_branch_likely(&rdt_enable_key))
+		__resctrl_sched_in();
+}
+
+#else
+
+static inline void resctrl_sched_in(void) {}
+
+#endif /* CONFIG_X86_CPU_RESCTRL */
+
+#endif /* _ASM_X86_RESCTRL_H */
diff --git a/arch/x86/include/asm/resctrl_sched.h b/arch/x86/include/asm/resctrl_sched.h
deleted file mode 100644
index f6b7fe2..0000000
--- a/arch/x86/include/asm/resctrl_sched.h
+++ /dev/null
@@ -1,93 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_RESCTRL_SCHED_H
-#define _ASM_X86_RESCTRL_SCHED_H
-
-#ifdef CONFIG_X86_CPU_RESCTRL
-
-#include <linux/sched.h>
-#include <linux/jump_label.h>
-
-#define IA32_PQR_ASSOC	0x0c8f
-
-/**
- * struct resctrl_pqr_state - State cache for the PQR MSR
- * @cur_rmid:		The cached Resource Monitoring ID
- * @cur_closid:	The cached Class Of Service ID
- * @default_rmid:	The user assigned Resource Monitoring ID
- * @default_closid:	The user assigned cached Class Of Service ID
- *
- * The upper 32 bits of IA32_PQR_ASSOC contain closid and the
- * lower 10 bits rmid. The update to IA32_PQR_ASSOC always
- * contains both parts, so we need to cache them. This also
- * stores the user configured per cpu CLOSID and RMID.
- *
- * The cache also helps to avoid pointless updates if the value does
- * not change.
- */
-struct resctrl_pqr_state {
-	u32			cur_rmid;
-	u32			cur_closid;
-	u32			default_rmid;
-	u32			default_closid;
-};
-
-DECLARE_PER_CPU(struct resctrl_pqr_state, pqr_state);
-
-DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
-DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
-DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
-
-/*
- * __resctrl_sched_in() - Writes the task's CLOSid/RMID to IA32_PQR_MSR
- *
- * Following considerations are made so that this has minimal impact
- * on scheduler hot path:
- * - This will stay as no-op unless we are running on an Intel SKU
- *   which supports resource control or monitoring and we enable by
- *   mounting the resctrl file system.
- * - Caches the per cpu CLOSid/RMID values and does the MSR write only
- *   when a task with a different CLOSid/RMID is scheduled in.
- * - We allocate RMIDs/CLOSids globally in order to keep this as
- *   simple as possible.
- * Must be called with preemption disabled.
- */
-static void __resctrl_sched_in(void)
-{
-	struct resctrl_pqr_state *state = this_cpu_ptr(&pqr_state);
-	u32 closid = state->default_closid;
-	u32 rmid = state->default_rmid;
-
-	/*
-	 * If this task has a closid/rmid assigned, use it.
-	 * Else use the closid/rmid assigned to this cpu.
-	 */
-	if (static_branch_likely(&rdt_alloc_enable_key)) {
-		if (current->closid)
-			closid = current->closid;
-	}
-
-	if (static_branch_likely(&rdt_mon_enable_key)) {
-		if (current->rmid)
-			rmid = current->rmid;
-	}
-
-	if (closid != state->cur_closid || rmid != state->cur_rmid) {
-		state->cur_closid = closid;
-		state->cur_rmid = rmid;
-		wrmsr(IA32_PQR_ASSOC, rmid, closid);
-	}
-}
-
-static inline void resctrl_sched_in(void)
-{
-	if (static_branch_likely(&rdt_enable_key))
-		__resctrl_sched_in();
-}
-
-#else
-
-static inline void resctrl_sched_in(void) {}
-
-#endif /* CONFIG_X86_CPU_RESCTRL */
-
-#endif /* _ASM_X86_RESCTRL_SCHED_H */
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index d8cc522..6f38c88 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -22,7 +22,7 @@
 #include <linux/cpuhotplug.h>
 
 #include <asm/intel-family.h>
-#include <asm/resctrl_sched.h>
+#include <asm/resctrl.h>
 #include "internal.h"
 
 /* Mutex to protect rdtgroup access. */
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index d7623e1..4bd28b3 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -24,7 +24,7 @@
 
 #include <asm/cacheflush.h>
 #include <asm/intel-family.h>
-#include <asm/resctrl_sched.h>
+#include <asm/resctrl.h>
 #include <asm/perf_event.h>
 
 #include "../../events/perf_event.h" /* For X86_CONFIG() */
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 5a359d9..6276ae0 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -29,7 +29,7 @@
 
 #include <uapi/linux/magic.h>
 
-#include <asm/resctrl_sched.h>
+#include <asm/resctrl.h>
 #include "internal.h"
 
 DEFINE_STATIC_KEY_FALSE(rdt_enable_key);
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 954b013..538d4e8 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -52,7 +52,7 @@
 #include <asm/debugreg.h>
 #include <asm/switch_to.h>
 #include <asm/vm86.h>
-#include <asm/resctrl_sched.h>
+#include <asm/resctrl.h>
 #include <asm/proto.h>
 
 #include "process.h"
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 5ef9d8f..0c169a5 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -52,7 +52,7 @@
 #include <asm/switch_to.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/vdso.h>
-#include <asm/resctrl_sched.h>
+#include <asm/resctrl.h>
 #include <asm/unistd.h>
 #include <asm/fsgsbase.h>
 #ifdef CONFIG_IA32_EMULATION
