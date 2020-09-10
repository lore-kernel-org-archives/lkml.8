Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1E7C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F17620C09
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pmk0wK5G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fDLfw5cb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbgIJJcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730493AbgIJJYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:24:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4132CC0617A3;
        Thu, 10 Sep 2020 02:22:18 -0700 (PDT)
Date:   Thu, 10 Sep 2020 09:22:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729734;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CZJz1Y6M5PqMAlDrDRPUbV+0BJlWMteh6oW10ZkxtQU=;
        b=Pmk0wK5G5jmddpwn+jiidAe8oeEG/m9TuaFM4Swq+HFJV3MkA9BQ6Iy2l6kxSIiE0Gpd/N
        B3Q4LYMSE/S0r1nM2pY/0k385fAMPnivqQIOh9S4ZN4NMkq/b4q+4jZ0I3bC53xBQ3N7zt
        pU04obwYpGAa0K+vQZ1S6UnXpK4iwvT1Fq86bLkTTNZa2XMb1bv6bUOhBXw0jl1hqrXtxa
        5GbuOBWara/N8vJqG5zXUaE6s8VByO8OuPaZ8R/yPOPsA4zDocTy6+/0q/Ik2ukKJRfCDq
        UJ25gglMFElvxeenXJVkAzbR/WTy3XD3HBQKyTRsWMaiLUPIjXcvHKlUkebF9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729734;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CZJz1Y6M5PqMAlDrDRPUbV+0BJlWMteh6oW10ZkxtQU=;
        b=fDLfw5cbNAptVG3SqigErv4AtCppFrEcepLzSKKEWrkmV8MZQrDedjqLazhLsktFNQkB7M
        eezy87JVeqYKdsCA==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/dumpstack/64: Add noinstr version of get_stack_info()
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-45-joro@8bytes.org>
References: <20200907131613.12703-45-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972973395.20229.434586447788491195.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     6b27edd74a5e9669120f7bd0ae1f475d124c1042
Gitweb:        https://git.kernel.org/tip/6b27edd74a5e9669120f7bd0ae1f475d124c1042
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:15:45 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 09 Sep 2020 11:33:19 +02:00

x86/dumpstack/64: Add noinstr version of get_stack_info()

The get_stack_info() functionality is needed in the entry code for the
#VC exception handler. Provide a version of it in the .text.noinstr
section which can be called safely from there.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-45-joro@8bytes.org
---
 arch/x86/include/asm/stacktrace.h |  2 ++-
 arch/x86/kernel/dumpstack.c       |  7 +++---
 arch/x86/kernel/dumpstack_64.c    | 38 +++++++++++++++++-------------
 arch/x86/mm/cpu_entry_area.c      |  3 +-
 4 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/stacktrace.h b/arch/x86/include/asm/stacktrace.h
index 5ae5a68..4960064 100644
--- a/arch/x86/include/asm/stacktrace.h
+++ b/arch/x86/include/asm/stacktrace.h
@@ -35,6 +35,8 @@ bool in_entry_stack(unsigned long *stack, struct stack_info *info);
 
 int get_stack_info(unsigned long *stack, struct task_struct *task,
 		   struct stack_info *info, unsigned long *visit_mask);
+bool get_stack_info_noinstr(unsigned long *stack, struct task_struct *task,
+			    struct stack_info *info);
 
 const char *stack_type_name(enum stack_type type);
 
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 48ce445..74147f7 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -29,8 +29,8 @@ static int die_counter;
 
 static struct pt_regs exec_summary_regs;
 
-bool in_task_stack(unsigned long *stack, struct task_struct *task,
-		   struct stack_info *info)
+bool noinstr in_task_stack(unsigned long *stack, struct task_struct *task,
+			   struct stack_info *info)
 {
 	unsigned long *begin = task_stack_page(task);
 	unsigned long *end   = task_stack_page(task) + THREAD_SIZE;
@@ -46,7 +46,8 @@ bool in_task_stack(unsigned long *stack, struct task_struct *task,
 	return true;
 }
 
-bool in_entry_stack(unsigned long *stack, struct stack_info *info)
+/* Called from get_stack_info_noinstr - so must be noinstr too */
+bool noinstr in_entry_stack(unsigned long *stack, struct stack_info *info)
 {
 	struct entry_stack *ss = cpu_entry_stack(smp_processor_id());
 
diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index c49cf59..1dd8513 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -85,7 +85,7 @@ struct estack_pages estack_pages[CEA_ESTACK_PAGES] ____cacheline_aligned = {
 	EPAGERANGE(VC2),
 };
 
-static bool in_exception_stack(unsigned long *stack, struct stack_info *info)
+static __always_inline bool in_exception_stack(unsigned long *stack, struct stack_info *info)
 {
 	unsigned long begin, end, stk = (unsigned long)stack;
 	const struct estack_pages *ep;
@@ -126,7 +126,7 @@ static bool in_exception_stack(unsigned long *stack, struct stack_info *info)
 	return true;
 }
 
-static bool in_irq_stack(unsigned long *stack, struct stack_info *info)
+static __always_inline bool in_irq_stack(unsigned long *stack, struct stack_info *info)
 {
 	unsigned long *end   = (unsigned long *)this_cpu_read(hardirq_stack_ptr);
 	unsigned long *begin = end - (IRQ_STACK_SIZE / sizeof(long));
@@ -151,32 +151,38 @@ static bool in_irq_stack(unsigned long *stack, struct stack_info *info)
 	return true;
 }
 
-int get_stack_info(unsigned long *stack, struct task_struct *task,
-		   struct stack_info *info, unsigned long *visit_mask)
+bool noinstr get_stack_info_noinstr(unsigned long *stack, struct task_struct *task,
+				    struct stack_info *info)
 {
-	if (!stack)
-		goto unknown;
-
-	task = task ? : current;
-
 	if (in_task_stack(stack, task, info))
-		goto recursion_check;
+		return true;
 
 	if (task != current)
-		goto unknown;
+		return false;
 
 	if (in_exception_stack(stack, info))
-		goto recursion_check;
+		return true;
 
 	if (in_irq_stack(stack, info))
-		goto recursion_check;
+		return true;
 
 	if (in_entry_stack(stack, info))
-		goto recursion_check;
+		return true;
+
+	return false;
+}
+
+int get_stack_info(unsigned long *stack, struct task_struct *task,
+		   struct stack_info *info, unsigned long *visit_mask)
+{
+	task = task ? : current;
 
-	goto unknown;
+	if (!stack)
+		goto unknown;
+
+	if (!get_stack_info_noinstr(stack, task, info))
+		goto unknown;
 
-recursion_check:
 	/*
 	 * Make sure we don't iterate through any given stack more than once.
 	 * If it comes up a second time then there's something wrong going on:
diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index 770b613..f5e1e60 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -21,7 +21,8 @@ DEFINE_PER_CPU(struct cea_exception_stacks*, cea_exception_stacks);
 DECLARE_PER_CPU_PAGE_ALIGNED(struct doublefault_stack, doublefault_stack);
 #endif
 
-struct cpu_entry_area *get_cpu_entry_area(int cpu)
+/* Is called from entry code, so must be noinstr */
+noinstr struct cpu_entry_area *get_cpu_entry_area(int cpu)
 {
 	unsigned long va = CPU_ENTRY_AREA_PER_CPU + cpu * CPU_ENTRY_AREA_SIZE;
 	BUILD_BUG_ON(sizeof(struct cpu_entry_area) % PAGE_SIZE != 0);
