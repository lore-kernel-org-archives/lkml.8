Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D240DC433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 01:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B29532087C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 01:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596244527;
	bh=MUYYsjVLZjL1Qk+QIXZcQKJuxWzAUxEkD82wW9h8xn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NJ5ebcWX/f1mqMH4DpbeghzwvlSLC/ClA10rSn+zdzGfRnl1tIKKQ5k7lzJNSiRJ6
	 3V41d5SloGXVesO3wwGikr7NwYO6zXvmQEBl8yCA3MmwHSk9o8zd+PvGBVEZJMNlHD
	 K9asV5Vtf4lhqTqT76XRu06T+ItfGMGWKC43zMOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgHABOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 21:14:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728234AbgHABOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 21:14:49 -0400
Received: from localhost.localdomain (unknown [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6C0E2087C;
        Sat,  1 Aug 2020 01:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596244489;
        bh=MUYYsjVLZjL1Qk+QIXZcQKJuxWzAUxEkD82wW9h8xn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I8FH0fYzvGADIKv75R6NAIxVi47gThyjDwuut5CcPwEFtiB2xLblJJg4odqweGzg5
         iwDE8OesDTjcI0tDRdThEgLDHr1St0qXRh0B1bnTE0WdaU6s6soaVQbarryQLGGf33
         yUYifMaLLlJYmk5Xj4gzxHB3ekNgjxFU1thUMAaQ=
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 06/13] csky: Add support for function error injection
Date:   Sat,  1 Aug 2020 01:14:06 +0000
Message-Id: <1596244453-98575-7-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596244453-98575-1-git-send-email-guoren@kernel.org>
References: <1596244453-98575-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Inspired by the commit 42d038c4fb00 ("arm64: Add support for function
error injection"), this patch supports function error injection for
csky.

This patch mainly support two functions: one is regs_set_return_value()
which is used to overwrite the return value; the another function is
override_function_with_return() which is to override the probed
function returning and jump to its caller.

Test log:

 cd /sys/kernel/debug/fail_function/
 echo sys_clone > inject
 echo 100 > probability
 echo 1 > interval
 ls /
[  108.644163] FAULT_INJECTION: forcing a failure.
[  108.644163] name fail_function, interval 1, probability 100, space 0, times 1
[  108.647799] CPU: 0 PID: 104 Comm: sh Not tainted 5.8.0-rc5+ #46
[  108.648384] Call Trace:
[  108.649339] [<8005eed4>] walk_stackframe+0x0/0xf0
[  108.649679] [<8005f16a>] show_stack+0x32/0x5c
[  108.649927] [<8040f9d2>] dump_stack+0x6e/0x9c
[  108.650271] [<80406f7e>] should_fail+0x15e/0x1ac
[  108.650720] [<80118ba8>] fei_kprobe_handler+0x28/0x5c
[  108.651519] [<80754110>] kprobe_breakpoint_handler+0x144/0x1cc
[  108.652289] [<8005d6da>] trap_c+0x8e/0x110
[  108.652816] [<8005ce8c>] csky_trap+0x5c/0x70
-sh: can't fork: Invalid argument

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/Kconfig              |  1 +
 arch/csky/include/asm/ptrace.h |  6 ++++++
 arch/csky/lib/Makefile         |  1 +
 arch/csky/lib/error-inject.c   | 10 ++++++++++
 4 files changed, 18 insertions(+)
 create mode 100644 arch/csky/lib/error-inject.c

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 822362d..c51f64c 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -45,6 +45,7 @@ config CSKY
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
+	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZO
diff --git a/arch/csky/include/asm/ptrace.h b/arch/csky/include/asm/ptrace.h
index bcfb707..82da5e0 100644
--- a/arch/csky/include/asm/ptrace.h
+++ b/arch/csky/include/asm/ptrace.h
@@ -52,6 +52,12 @@ static inline unsigned long regs_return_value(struct pt_regs *regs)
 	return regs->a0;
 }
 
+static inline void regs_set_return_value(struct pt_regs *regs,
+					 unsigned long val)
+{
+	regs->a0 = val;
+}
+
 /* Valid only for Kernel mode traps. */
 static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
 {
diff --git a/arch/csky/lib/Makefile b/arch/csky/lib/Makefile
index 078e2d5..7fbdbb2 100644
--- a/arch/csky/lib/Makefile
+++ b/arch/csky/lib/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 lib-y  := usercopy.o delay.o
+obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
diff --git a/arch/csky/lib/error-inject.c b/arch/csky/lib/error-inject.c
new file mode 100644
index 00000000..c15fb36
--- /dev/null
+++ b/arch/csky/lib/error-inject.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/error-injection.h>
+#include <linux/kprobes.h>
+
+void override_function_with_return(struct pt_regs *regs)
+{
+	instruction_pointer_set(regs, regs->lr);
+}
+NOKPROBE_SYMBOL(override_function_with_return);
-- 
2.7.4

