Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6C9C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EB4B207DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594279760;
	bh=V9g8SE10fROyxVg2xxAPC4nQBmidhZEFaboABYn9Htk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=A6CJjOiMxKw6gOVlQ0NWDY9WHR6y1th1ccSxSP2lJCr96RyadrN2M0YGrweKR31K/
	 B7QgLeLuZrdcI9t2NfJJHxnM7XuF6VXpYYEcjHWpIbLwcsiE/wQVF4nTMlm7KYmQ2C
	 Z4H0gdCyMnSngb2O26p7VZlLy5CsCXI47YjOwJ3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgGIH3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 03:29:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgGIH3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 03:29:13 -0400
Received: from localhost.localdomain (unknown [42.120.72.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80B5D2074A;
        Thu,  9 Jul 2020 07:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594279751;
        bh=V9g8SE10fROyxVg2xxAPC4nQBmidhZEFaboABYn9Htk=;
        h=From:To:Cc:Subject:Date:From;
        b=HYqakm73YTt3Ru7/XNbqXC5fUrM78k3XcqblzC/fAdEF44bKcaRgRlmPOV2aOHWWO
         Cmkf4rz4O4mQEIfAWxR4F+dSbPFtRAwbOe/iY6flTAMG8yybHCFYmb5ivXMEPpzk/Q
         3TtUAZKz3srf2utcx6F2AfdVcUdgAhfOE+i/oGfo=
From:   guoren@kernel.org
To:     palmerdabbelt@google.com, paul.walmsley@sifive.com,
        anup@brainfault.org, greentime.hu@sifive.com, zong.li@sifive.com,
        me@packi.ch, bjorn.topel@gmail.com, atish.patra@wdc.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, guoren@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v2 1/2] riscv: Add STACKPROTECTOR supported
Date:   Thu,  9 Jul 2020 07:28:16 +0000
Message-Id: <1594279697-72511-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The -fstack-protector & -fstack-protector-strong features are from
gcc. The patch only add basic kernel support to stack-protector
feature and some arch could have its own solution such as
ARM64_PTR_AUTH.

After enabling STACKPROTECTOR and STACKPROTECTOR_STRONG, the .text
size is expanded from  0x7de066 to 0x81fb32 (only 5%) to add canary
checking code.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Björn Töpel <bjorn.topel@gmail.com>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/Kconfig                      |  1 +
 arch/riscv/include/asm/stackprotector.h | 33 +++++++++++++++++++++++++++++++++
 arch/riscv/kernel/process.c             |  6 ++++++
 3 files changed, 40 insertions(+)
 create mode 100644 arch/riscv/include/asm/stackprotector.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index f927a91..4b0e308 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -63,6 +63,7 @@ config RISCV
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
+	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select IRQ_DOMAIN
 	select MODULES_USE_ELF_RELA if MODULES
diff --git a/arch/riscv/include/asm/stackprotector.h b/arch/riscv/include/asm/stackprotector.h
new file mode 100644
index 00000000..8e1ef2c
--- /dev/null
+++ b/arch/riscv/include/asm/stackprotector.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_RISCV_STACKPROTECTOR_H
+#define _ASM_RISCV_STACKPROTECTOR_H
+
+#include <linux/random.h>
+#include <linux/version.h>
+#include <asm/timex.h>
+
+extern unsigned long __stack_chk_guard;
+
+/*
+ * Initialize the stackprotector canary value.
+ *
+ * NOTE: this must only be called from functions that never return,
+ * and it must always be inlined.
+ */
+static __always_inline void boot_init_stack_canary(void)
+{
+	unsigned long canary;
+	unsigned long tsc;
+
+	/* Try to get a semi random initial value. */
+	get_random_bytes(&canary, sizeof(canary));
+	tsc = get_cycles();
+	canary += tsc + (tsc << 32UL);
+	canary ^= LINUX_VERSION_CODE;
+	canary &= CANARY_MASK;
+
+	current->stack_canary = canary;
+	__stack_chk_guard = current->stack_canary;
+}
+#endif /* _ASM_RISCV_STACKPROTECTOR_H */
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 824d117..6548929 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -24,6 +24,12 @@
 
 register unsigned long gp_in_global __asm__("gp");
 
+#ifdef CONFIG_STACKPROTECTOR
+#include <linux/stackprotector.h>
+unsigned long __stack_chk_guard __read_mostly;
+EXPORT_SYMBOL(__stack_chk_guard);
+#endif
+
 extern asmlinkage void ret_from_fork(void);
 extern asmlinkage void ret_from_kernel_thread(void);
 
-- 
2.7.4

