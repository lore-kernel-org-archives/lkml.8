Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD7BC2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 04:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5755720CC7
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 04:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585888931;
	bh=+hjelEMbsQ+7/09u0Y/RXm/5wQltYl8nC0lJdj+WssE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZXf2IUCTn5C75PBmPDMBBSsc5hzW8txppD/X0AZYCwF9p3q322nnvInR0NGwkYTsE
	 CZroiSybaAo+Go7ahsU6BcOvbrD4+L8g7KtHoE3oLcNQ9rTM7GB+UuPv7y1wKc+7w8
	 I7UVoy8I4sk3vkOOnQaElSzti7issI3vWseFM4sQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732379AbgDCEmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 00:42:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbgDCEmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 00:42:09 -0400
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D56D206F8;
        Fri,  3 Apr 2020 04:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585888928;
        bh=+hjelEMbsQ+7/09u0Y/RXm/5wQltYl8nC0lJdj+WssE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EHG4l5cVYxmkAy5dTldt2Rilg2j3BhaZ1nvEdpyhFG+ESzLdR4Sq1Etio/+pbia+q
         BAQy1GLW7xd5p8FaWn2oFz/9grGNe0P/6Vup8RQuwhehS82zSKJn9o08ceHncjojpo
         TZ/2W/n4FouYbYIBbyGvTsTRCR2bDKnIYnMgJnHU=
From:   guoren@kernel.org
To:     arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <ren_guo@c-sky.com>, Patrick Staehlin <me@packi.ch>,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 02/11] csky: Implement ptrace regs and stack API
Date:   Fri,  3 Apr 2020 12:41:41 +0800
Message-Id: <20200403044150.20562-2-guoren@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20200403044150.20562-1-guoren@kernel.org>
References: <20200403044150.20562-1-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Needed for kprobes support. Copied and adapted from Patrick's patch,
but it has been modified for csky's pt_regs.

ref:
https://lore.kernel.org/linux-riscv/1572919114-3886-2-git-send-email-vincent.chen@sifive.com/raw

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Patrick Staehlin <me@packi.ch>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/Kconfig              |   1 +
 arch/csky/include/asm/ptrace.h |  41 +++++++++++++
 arch/csky/kernel/ptrace.c      | 103 +++++++++++++++++++++++++++++++++
 3 files changed, 145 insertions(+)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 047427f71d83..2dfd3fb07db9 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -48,6 +48,7 @@ config CSKY
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_DMA_CONTIGUOUS
+	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select MAY_HAVE_SPARSE_IRQ
diff --git a/arch/csky/include/asm/ptrace.h b/arch/csky/include/asm/ptrace.h
index d0aba7b32417..f16ca256e007 100644
--- a/arch/csky/include/asm/ptrace.h
+++ b/arch/csky/include/asm/ptrace.h
@@ -7,6 +7,7 @@
 #include <uapi/asm/ptrace.h>
 #include <asm/traps.h>
 #include <linux/types.h>
+#include <linux/compiler.h>
 
 #ifndef __ASSEMBLY__
 
@@ -22,6 +23,18 @@
 #define instruction_pointer(regs) ((regs)->pc)
 #define profile_pc(regs) instruction_pointer(regs)
 
+static inline void instruction_pointer_set(struct pt_regs *regs,
+					   unsigned long val)
+{
+	regs->pc = val;
+}
+
+#if defined(__CSKYABIV2__)
+#define MAX_REG_OFFSET offsetof(struct pt_regs, dcsr)
+#else
+#define MAX_REG_OFFSET offsetof(struct pt_regs, regs[9])
+#endif
+
 static inline bool in_syscall(struct pt_regs const *regs)
 {
 	return ((regs->sr >> 16) & 0xff) == VEC_TRAP0;
@@ -37,5 +50,33 @@ static inline unsigned long regs_return_value(struct pt_regs *regs)
 	return regs->a0;
 }
 
+/* Valid only for Kernel mode traps. */
+static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
+{
+	return regs->usp;
+}
+
+extern int regs_query_register_offset(const char *name);
+extern unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs,
+						unsigned int n);
+
+/*
+ * regs_get_register() - get register value from its offset
+ * @regs:      pt_regs from which register value is gotten
+ * @offset:    offset of the register.
+ *
+ * regs_get_register returns the value of a register whose offset from @regs.
+ * The @offset is the offset of the register in struct pt_regs.
+ * If @offset is bigger than MAX_REG_OFFSET, this returns 0.
+ */
+static inline unsigned long regs_get_register(struct pt_regs *regs,
+						unsigned int offset)
+{
+	if (unlikely(offset > MAX_REG_OFFSET))
+		return 0;
+
+	return *(unsigned long *)((unsigned long)regs + offset);
+}
+
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_CSKY_PTRACE_H */
diff --git a/arch/csky/kernel/ptrace.c b/arch/csky/kernel/ptrace.c
index 313623a19ecb..21ac2608f205 100644
--- a/arch/csky/kernel/ptrace.c
+++ b/arch/csky/kernel/ptrace.c
@@ -193,6 +193,109 @@ const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 	return &user_csky_view;
 }
 
+struct pt_regs_offset {
+	const char *name;
+	int offset;
+};
+
+#define REG_OFFSET_NAME(r) {.name = #r, .offset = offsetof(struct pt_regs, r)}
+#define REG_OFFSET_END {.name = NULL, .offset = 0}
+
+static const struct pt_regs_offset regoffset_table[] = {
+	REG_OFFSET_NAME(tls),
+	REG_OFFSET_NAME(lr),
+	REG_OFFSET_NAME(pc),
+	REG_OFFSET_NAME(sr),
+	REG_OFFSET_NAME(usp),
+	REG_OFFSET_NAME(orig_a0),
+	REG_OFFSET_NAME(a0),
+	REG_OFFSET_NAME(a1),
+	REG_OFFSET_NAME(a2),
+	REG_OFFSET_NAME(a3),
+	REG_OFFSET_NAME(regs[0]),
+	REG_OFFSET_NAME(regs[1]),
+	REG_OFFSET_NAME(regs[2]),
+	REG_OFFSET_NAME(regs[3]),
+	REG_OFFSET_NAME(regs[4]),
+	REG_OFFSET_NAME(regs[5]),
+	REG_OFFSET_NAME(regs[6]),
+	REG_OFFSET_NAME(regs[7]),
+	REG_OFFSET_NAME(regs[8]),
+	REG_OFFSET_NAME(regs[9]),
+#if defined(__CSKYABIV2__)
+	REG_OFFSET_NAME(exregs[0]),
+	REG_OFFSET_NAME(exregs[1]),
+	REG_OFFSET_NAME(exregs[2]),
+	REG_OFFSET_NAME(exregs[3]),
+	REG_OFFSET_NAME(exregs[4]),
+	REG_OFFSET_NAME(exregs[5]),
+	REG_OFFSET_NAME(exregs[6]),
+	REG_OFFSET_NAME(exregs[7]),
+	REG_OFFSET_NAME(exregs[8]),
+	REG_OFFSET_NAME(exregs[9]),
+	REG_OFFSET_NAME(exregs[10]),
+	REG_OFFSET_NAME(exregs[11]),
+	REG_OFFSET_NAME(exregs[12]),
+	REG_OFFSET_NAME(exregs[13]),
+	REG_OFFSET_NAME(exregs[14]),
+	REG_OFFSET_NAME(rhi),
+	REG_OFFSET_NAME(rlo),
+	REG_OFFSET_NAME(dcsr),
+#endif
+	REG_OFFSET_END,
+};
+
+/**
+ * regs_query_register_offset() - query register offset from its name
+ * @name:	the name of a register
+ *
+ * regs_query_register_offset() returns the offset of a register in struct
+ * pt_regs from its name. If the name is invalid, this returns -EINVAL;
+ */
+int regs_query_register_offset(const char *name)
+{
+	const struct pt_regs_offset *roff;
+
+	for (roff = regoffset_table; roff->name != NULL; roff++)
+		if (!strcmp(roff->name, name))
+			return roff->offset;
+	return -EINVAL;
+}
+
+/**
+ * regs_within_kernel_stack() - check the address in the stack
+ * @regs:      pt_regs which contains kernel stack pointer.
+ * @addr:      address which is checked.
+ *
+ * regs_within_kernel_stack() checks @addr is within the kernel stack page(s).
+ * If @addr is within the kernel stack, it returns true. If not, returns false.
+ */
+static bool regs_within_kernel_stack(struct pt_regs *regs, unsigned long addr)
+{
+	return (addr & ~(THREAD_SIZE - 1))  ==
+		(kernel_stack_pointer(regs) & ~(THREAD_SIZE - 1));
+}
+
+/**
+ * regs_get_kernel_stack_nth() - get Nth entry of the stack
+ * @regs:	pt_regs which contains kernel stack pointer.
+ * @n:		stack entry number.
+ *
+ * regs_get_kernel_stack_nth() returns @n th entry of the kernel stack which
+ * is specified by @regs. If the @n th entry is NOT in the kernel stack,
+ * this returns 0.
+ */
+unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs, unsigned int n)
+{
+	unsigned long *addr = (unsigned long *)kernel_stack_pointer(regs);
+
+	addr += n;
+	if (regs_within_kernel_stack(regs, (unsigned long)addr))
+		return *addr;
+	else
+		return 0;
+}
+
 void ptrace_disable(struct task_struct *child)
 {
 	singlestep_disable(child);
-- 
2.17.0

