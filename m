Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93F9C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 09:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2256207EA
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 09:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgEQJEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 05:04:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:34674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727031AbgEQJEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 05:04:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9952DAC4A;
        Sun, 17 May 2020 09:04:14 +0000 (UTC)
Date:   Sun, 17 May 2020 11:04:04 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v5.7-rc6
Message-ID: <20200517090404.GA26679@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

as promised, please pull a single fix for kernels built with gcc10 and
stack protector enabled.

Thx.

---
The following changes since commit 2ef96a5bb12be62ef75b5828c0aab838ebb29cb8:

  Linux 5.7-rc5 (2020-05-10 15:16:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.7-rc7

for you to fetch changes up to a9a3ed1eff3601b63aea4fb462d8b3b92c7c1e7e:

  x86: Fix early boot crash on gcc-10, third try (2020-05-15 11:48:01 +0200)

----------------------------------------------------------------
A single fix for early boot crashes of kernels built with gcc10 and
stack protector enabled.

----------------------------------------------------------------
Borislav Petkov (1):
      x86: Fix early boot crash on gcc-10, third try

 arch/x86/include/asm/stackprotector.h | 7 ++++++-
 arch/x86/kernel/smpboot.c             | 8 ++++++++
 arch/x86/xen/smp_pv.c                 | 1 +
 include/linux/compiler.h              | 6 ++++++
 init/main.c                           | 2 ++
 5 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm/stackprotector.h
index 91e29b6a86a5..9804a7957f4e 100644
--- a/arch/x86/include/asm/stackprotector.h
+++ b/arch/x86/include/asm/stackprotector.h
@@ -55,8 +55,13 @@
 /*
  * Initialize the stackprotector canary value.
  *
- * NOTE: this must only be called from functions that never return,
+ * NOTE: this must only be called from functions that never return
  * and it must always be inlined.
+ *
+ * In addition, it should be called from a compilation unit for which
+ * stack protector is disabled. Alternatively, the caller should not end
+ * with a function call which gets tail-call optimized as that would
+ * lead to checking a modified canary value.
  */
 static __always_inline void boot_init_stack_canary(void)
 {
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 8c89e4d9ad28..2f24c334a938 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -266,6 +266,14 @@ static void notrace start_secondary(void *unused)
 
 	wmb();
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
+
+	/*
+	 * Prevent tail call to cpu_startup_entry() because the stack protector
+	 * guard has been changed a couple of function calls up, in
+	 * boot_init_stack_canary() and must not be checked before tail calling
+	 * another function.
+	 */
+	prevent_tail_call_optimization();
 }
 
 /**
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 8fb8a50a28b4..f2adb63b2d7c 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -93,6 +93,7 @@ asmlinkage __visible void cpu_bringup_and_idle(void)
 	cpu_bringup();
 	boot_init_stack_canary();
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
+	prevent_tail_call_optimization();
 }
 
 void xen_smp_intr_free_pv(unsigned int cpu)
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 034b0a644efc..448c91bf543b 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -356,4 +356,10 @@ static inline void *offset_to_ptr(const int *off)
 /* &a[0] degrades to a pointer: a different type from an array */
 #define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
 
+/*
+ * This is needed in functions which generate the stack canary, see
+ * arch/x86/kernel/smpboot.c::start_secondary() for an example.
+ */
+#define prevent_tail_call_optimization()	mb()
+
 #endif /* __LINUX_COMPILER_H */
diff --git a/init/main.c b/init/main.c
index 1a5da2c2660c..ad3812b5ae65 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1036,6 +1036,8 @@ asmlinkage __visible void __init start_kernel(void)
 
 	/* Do the rest non-__init'ed, we're now alive */
 	arch_call_rest_init();
+
+	prevent_tail_call_optimization();
 }
 
 /* Call all constructor functions linked into the kernel. */

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
