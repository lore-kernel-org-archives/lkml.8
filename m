Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3B6C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 14:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B25820739
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 14:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593958514;
	bh=zNnCIpEumQvRRF67btqkikC48THjPev/mPim2NMvzSs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=doanMgwiEhOVryqOoaNsIsUP9x0258nFC699uECmXICvXs/IxxPpADAXdrDQ0T+kp
	 Neub2V1EabhG9M2SSIn712GnDjutkzwmdVBUAeKQTN5ZFhYpO+0UjlscUnSlfmBvtw
	 ds/eT6+/Y/axwTxd9SL9sHXcfl4FvOQCxAW0Rgik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgGEOPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 10:15:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbgGEOPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 10:15:10 -0400
Received: from localhost.localdomain (unknown [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA3BC20724;
        Sun,  5 Jul 2020 14:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593958509;
        bh=zNnCIpEumQvRRF67btqkikC48THjPev/mPim2NMvzSs=;
        h=From:To:Cc:Subject:Date:From;
        b=h6k1WaQYt6l4lzPM4ByGzaWTADkxgSPSiqQaUlU6QPUTlvVVWvRdPWWN713XTEuJM
         oZVzeKncNXDEBkdSjnL93PNQkrpqynSiSQeJr+vAlP4n5qUT6NjglOdw2o7LJ9w4Hq
         gOPaD1zQ88oGl/m87zZnrCjWStbrBFJBnLbkEixc=
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Kees Cook <keescook@chromium.org>
Subject: [RFC PATCH] riscv: enable per-task stack canaries
Date:   Sun,  5 Jul 2020 14:13:17 +0000
Message-Id: <1593958397-62466-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

After compare arm64 and x86 implementations, seems arm64's is more
flexible and readable. The key point is how gcc get the offset of
stack_canary from gs/el0_sp.

x86: Use a fix offset from gs, not flexible.

struct fixed_percpu_data {
        /*
         * GCC hardcodes the stack canary as %gs:40.  Since the
         * irq_stack is the object at %gs:0, we reserve the bottom
         * 48 bytes of the irq stack for the canary.
         */
        char            gs_base[40]; // :(
        unsigned long   stack_canary;
};

arm64: Use -mstack-protector-guard-offset & guard-reg

ifeq ($(CONFIG_STACKPROTECTOR_PER_TASK),y)
prepare: stack_protector_prepare
stack_protector_prepare: prepare0
       $(eval KBUILD_CFLAGS += -mstack-protector-guard=sysreg            \
                               -mstack-protector-guard-reg=sp_el0        \
                               -mstack-protector-guard-offset=$(shell    \
                       awk '{if ($$2 == "TSK_STACK_CANARY") print $$3;}' \
                                       include/generated/asm-offsets.h))
endif

I prefer arm64, but x86 percpu_data design needs to be considered ?

After the discussion, let's continue the work for riscv gcc
stack-protector.

Here is arm64 gcc's work [1].

[1] https://github.com/gcc-mirror/gcc/commit/cd0b2d361df82c848dc7e1c3078651bb0624c3c6

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Kees Cook <keescook@chromium.org>
---
 arch/riscv/Kconfig                      |  7 +++++++
 arch/riscv/Makefile                     | 10 ++++++++++
 arch/riscv/include/asm/stackprotector.h |  3 ++-
 arch/riscv/kernel/asm-offsets.c         |  3 +++
 arch/riscv/kernel/process.c             |  2 +-
 5 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 4b0e308..4b4e833 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -394,6 +394,13 @@ config CMDLINE_FORCE
 
 endchoice
 
+config CC_HAVE_STACKPROTECTOR_SYSREG
+	def_bool $(cc-option,-mstack-protector-guard=gpr -mstack-protector-guard-reg=tp -mstack-protector-guard-offset=0)
+
+config STACKPROTECTOR_PER_TASK
+	def_bool y
+	depends on STACKPROTECTOR && CC_HAVE_STACKPROTECTOR_SYSREG
+
 endmenu
 
 config BUILTIN_DTB
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index fb6e37d..880a288 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -47,6 +47,16 @@ KBUILD_AFLAGS += -march=$(riscv-march-y)
 KBUILD_CFLAGS += -mno-save-restore
 KBUILD_CFLAGS += -DCONFIG_PAGE_OFFSET=$(CONFIG_PAGE_OFFSET)
 
+ifeq ($(CONFIG_STACKPROTECTOR_PER_TASK),y)
+prepare: stack_protector_prepare
+stack_protector_prepare: prepare0
+	$(eval KBUILD_CFLAGS += -mstack-protector-guard=gpr		  \
+				-mstack-protector-guard-reg=tp		  \
+				-mstack-protector-guard-offset=$(shell	  \
+			awk '{if ($$2 == "TSK_STACK_CANARY") print $$3;}' \
+					include/generated/asm-offsets.h))
+endif
+
 ifeq ($(CONFIG_CMODEL_MEDLOW),y)
 	KBUILD_CFLAGS += -mcmodel=medlow
 endif
diff --git a/arch/riscv/include/asm/stackprotector.h b/arch/riscv/include/asm/stackprotector.h
index 5962f88..09093af 100644
--- a/arch/riscv/include/asm/stackprotector.h
+++ b/arch/riscv/include/asm/stackprotector.h
@@ -24,6 +24,7 @@ static __always_inline void boot_init_stack_canary(void)
 	canary &= CANARY_MASK;
 
 	current->stack_canary = canary;
-	__stack_chk_guard = current->stack_canary;
+	if (!IS_ENABLED(CONFIG_STACKPROTECTOR_PER_TASK))
+		__stack_chk_guard = current->stack_canary;
 }
 #endif /* _ASM_RISCV_STACKPROTECTOR_H */
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index 07cb9c1..999b465 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -29,6 +29,9 @@ void asm_offsets(void)
 	OFFSET(TASK_THREAD_S11, task_struct, thread.s[11]);
 	OFFSET(TASK_THREAD_SP, task_struct, thread.sp);
 	OFFSET(TASK_STACK, task_struct, stack);
+#ifdef CONFIG_STACKPROTECTOR
+	OFFSET(TSK_STACK_CANARY, task_struct, stack_canary);
+#endif
 	OFFSET(TASK_TI, task_struct, thread_info);
 	OFFSET(TASK_TI_FLAGS, task_struct, thread_info.flags);
 	OFFSET(TASK_TI_PREEMPT_COUNT, task_struct, thread_info.preempt_count);
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 6548929..cb4ac65 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -24,7 +24,7 @@
 
 register unsigned long gp_in_global __asm__("gp");
 
-#ifdef CONFIG_STACKPROTECTOR
+#if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_PER_TASK)
 #include <linux/stackprotector.h>
 unsigned long __stack_chk_guard __read_mostly;
 EXPORT_SYMBOL(__stack_chk_guard);
-- 
2.7.4

