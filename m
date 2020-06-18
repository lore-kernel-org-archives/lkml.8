Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD88C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 07:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5431820899
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 07:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgFRH7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 03:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728206AbgFRH7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 03:59:46 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7BCC061755
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 00:59:45 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed20:b57b:2191:a081:571d])
        by andre.telenet-ops.be with bizsmtp
        id sXzh2200J1Jlgh201XzhWx; Thu, 18 Jun 2020 09:59:41 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jlpSX-0001Ts-5F; Thu, 18 Jun 2020 09:59:41 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jlpSX-0004H8-3A; Thu, 18 Jun 2020 09:59:41 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] sh: stacktrace: Remove stacktrace_ops.stack()
Date:   Thu, 18 Jun 2020 09:59:37 +0200
Message-Id: <20200618075937.16391-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SH implementation never called stacktrace_ops.stack().
Presumably this was copied from the x86 implementation.

Hence remove the method, and all implementations (most of them are
dummies).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/include/asm/stacktrace.h | 2 --
 arch/sh/kernel/dumpstack.c       | 7 -------
 arch/sh/kernel/perf_callchain.c  | 6 ------
 arch/sh/kernel/stacktrace.c      | 7 -------
 arch/sh/oprofile/backtrace.c     | 7 -------
 5 files changed, 29 deletions(-)

diff --git a/arch/sh/include/asm/stacktrace.h b/arch/sh/include/asm/stacktrace.h
index 50c173c0b9f56f69..4f98cdc64ec59b1c 100644
--- a/arch/sh/include/asm/stacktrace.h
+++ b/arch/sh/include/asm/stacktrace.h
@@ -12,8 +12,6 @@
 
 struct stacktrace_ops {
 	void (*address)(void *data, unsigned long address, int reliable);
-	/* On negative return stop dumping */
-	int (*stack)(void *data, char *name);
 };
 
 void dump_trace(struct task_struct *tsk, struct pt_regs *regs,
diff --git a/arch/sh/kernel/dumpstack.c b/arch/sh/kernel/dumpstack.c
index 0a69588e343f7b98..758a6c89e911bc15 100644
--- a/arch/sh/kernel/dumpstack.c
+++ b/arch/sh/kernel/dumpstack.c
@@ -107,12 +107,6 @@ stack_reader_dump(struct task_struct *task, struct pt_regs *regs,
 	}
 }
 
-static int print_trace_stack(void *data, char *name)
-{
-	printk("%s <%s> ", (char *)data, name);
-	return 0;
-}
-
 /*
  * Print one address/symbol entries per line.
  */
@@ -123,7 +117,6 @@ static void print_trace_address(void *data, unsigned long addr, int reliable)
 }
 
 static const struct stacktrace_ops print_trace_ops = {
-	.stack = print_trace_stack,
 	.address = print_trace_address,
 };
 
diff --git a/arch/sh/kernel/perf_callchain.c b/arch/sh/kernel/perf_callchain.c
index 6281f2fdf9cac906..c9d3aa18732d1d49 100644
--- a/arch/sh/kernel/perf_callchain.c
+++ b/arch/sh/kernel/perf_callchain.c
@@ -11,11 +11,6 @@
 #include <asm/unwinder.h>
 #include <asm/ptrace.h>
 
-static int callchain_stack(void *data, char *name)
-{
-	return 0;
-}
-
 static void callchain_address(void *data, unsigned long addr, int reliable)
 {
 	struct perf_callchain_entry_ctx *entry = data;
@@ -25,7 +20,6 @@ static void callchain_address(void *data, unsigned long addr, int reliable)
 }
 
 static const struct stacktrace_ops callchain_ops = {
-	.stack		= callchain_stack,
 	.address	= callchain_address,
 };
 
diff --git a/arch/sh/kernel/stacktrace.c b/arch/sh/kernel/stacktrace.c
index 2950b19ad0772081..daf0b53ee066fa6d 100644
--- a/arch/sh/kernel/stacktrace.c
+++ b/arch/sh/kernel/stacktrace.c
@@ -15,11 +15,6 @@
 #include <asm/ptrace.h>
 #include <asm/stacktrace.h>
 
-static int save_stack_stack(void *data, char *name)
-{
-	return 0;
-}
-
 /*
  * Save stack-backtrace addresses into a stack_trace buffer.
  */
@@ -40,7 +35,6 @@ static void save_stack_address(void *data, unsigned long addr, int reliable)
 }
 
 static const struct stacktrace_ops save_stack_ops = {
-	.stack = save_stack_stack,
 	.address = save_stack_address,
 };
 
@@ -73,7 +67,6 @@ save_stack_address_nosched(void *data, unsigned long addr, int reliable)
 }
 
 static const struct stacktrace_ops save_stack_ops_nosched = {
-	.stack = save_stack_stack,
 	.address = save_stack_address_nosched,
 };
 
diff --git a/arch/sh/oprofile/backtrace.c b/arch/sh/oprofile/backtrace.c
index f1205f92631df3b9..cc16cf86cd92fabe 100644
--- a/arch/sh/oprofile/backtrace.c
+++ b/arch/sh/oprofile/backtrace.c
@@ -19,12 +19,6 @@
 #include <asm/sections.h>
 #include <asm/stacktrace.h>
 
-static int backtrace_stack(void *data, char *name)
-{
-	/* Yes, we want all stacks */
-	return 0;
-}
-
 static void backtrace_address(void *data, unsigned long addr, int reliable)
 {
 	unsigned int *depth = data;
@@ -34,7 +28,6 @@ static void backtrace_address(void *data, unsigned long addr, int reliable)
 }
 
 static struct stacktrace_ops backtrace_ops = {
-	.stack = backtrace_stack,
 	.address = backtrace_address,
 };
 
-- 
2.17.1

