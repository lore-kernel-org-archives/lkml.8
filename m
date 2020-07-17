Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-25.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F111C433FB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 112DF207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AYM85whJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgGQLFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 07:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgGQLFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 07:05:46 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D296C061755
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 04:05:46 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id g6so6017590qtr.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 04:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=A0A4NOvPoZRmlJEFnc9Ybsj+p4yV6Jy4v9LTBO5E+eA=;
        b=AYM85whJTz6inY0KMcuRYAS7KXI60FYmIz276Wvi+SMe86jSA2Rq15NzgwJa97wtjw
         1HH2IWCSOow2frQmivVi+WzLT2si+Nca7QC8gmdE401YvfeCDVVsJPf5CInDWznKLiSR
         wNwMnKTXQ7Ody26ZhkedbBFk1/aFvyvB5yHNO62kKAKJAerk+czHfwNUjs7jHMil5kOh
         EfMuzjS9eQ3WmvKyjBEj1Bep+mtevIaNaR4J/9BLx39BU/3fpcvlGLgIIamy4lzsqwLP
         KqDMn/0IH25Wgm4qCBnT1E+TxQQBGrIErvwItzQXGQbgQvtoiXRupFDxs8JyT4FvAGLv
         fvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=A0A4NOvPoZRmlJEFnc9Ybsj+p4yV6Jy4v9LTBO5E+eA=;
        b=X4CkK1BWnQ/7ApQnt92Oux00GTqJfpFpeu90Ioth2VArglhRzcStn22HdUAWLcuKqc
         Os0pfQdtqaa8wsImH5AF7759fhEZWR8WeyiFVbl8xn8GyenTtlsXwlliKwIZpH2j70wj
         Pb+foaeX1PLlJsSQUkHoYh0CdlZIodie2Lkqck3QvKqOcWZtbBE+GusttACLfW2JJQ44
         zfo+ptNdnO15uqIsymMqx0kORFhcLkRGhj7sig/GbIx+O93T8xKkQ8h/IhBCRmEW8J3I
         BqN+l4ubUhypL8zXJQhNXbkDVKuvIlGCdZy2JY/EHmcioJit7WCRuw+GDnwq/1CjevU4
         iqzQ==
X-Gm-Message-State: AOAM533W3fEHwLew9P+d3IF1i4CKDzq6ytWymm7Fi7ple6yPYLpv3bXC
        M8GETIAvSgNZ2jE34VgnbstfGAPIFrlyyMMio3FIVqwuEGcubtwhuKnX/rnLHa38rjy2R0RnCYw
        gOQFctas+p7uZk1fFr3OeAHKHPHBRVfg1iqkGT7iLzpCcOjrSXTZqfiB/PW5I5xGDdHagY/1ZUc
        AlgfkWVZQD
X-Google-Smtp-Source: ABdhPJzky/K/NrL9enQBz4tcUEjea0J/dph+N8T35L2N/epdExcIsfm6JYZH6vbTbPFKIwkzqMspMvKNaX4mJSt/AMk=
X-Received: by 2002:a0c:9e4e:: with SMTP id z14mr8499045qve.71.1594983945511;
 Fri, 17 Jul 2020 04:05:45 -0700 (PDT)
Date:   Fri, 17 Jul 2020 04:05:32 -0700
Message-Id: <20200717110532.238533-1-asteinhauser@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH] PR_SPEC_DISABLE_NOEXEC support for arm64.
From:   Anthony Steinhauser <asteinhauser@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     will@kernel.org, catalin.marinas@arm.com,
        Anthony Steinhauser <asteinhauser@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For x64 it was already implemented in:
https://github.com/torvalds/linux/commit/71368af

The rationale is the same as for the x64 implementation.

Signed-off-by: Anthony Steinhauser <asteinhauser@google.com>
---

It's actively attempted by OpenJDK on arm64 CentOS and Fedora:
https://git.centos.org/rpms/java-11-openjdk/blob/c8s/f/SOURCES/rh1566890-CVE_2018_3639-speculative_store_bypass.patch

 arch/arm64/include/asm/ssbd.h | 28 ++++++++++++++++++++++++++++
 arch/arm64/kernel/process.c   | 13 +++++++++++++
 arch/arm64/kernel/ssbd.c      | 34 +++++++++++++++++-----------------
 3 files changed, 58 insertions(+), 17 deletions(-)
 create mode 100644 arch/arm64/include/asm/ssbd.h

diff --git a/arch/arm64/include/asm/ssbd.h b/arch/arm64/include/asm/ssbd.h
new file mode 100644
index 000000000000..68c716dc5811
--- /dev/null
+++ b/arch/arm64/include/asm/ssbd.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020 Google LLC.
+ */
+#ifndef __ASM_SSBD_H
+#define __ASM_SSBD_H
+
+#include <linux/compat.h>
+#include <linux/sched/task_stack.h>
+#include <linux/thread_info.h>
+
+static inline void ssbd_ssbs_enable(struct task_struct *task)
+{
+	u64 val = is_compat_thread(task_thread_info(task)) ?
+		PSR_AA32_SSBS_BIT : PSR_SSBS_BIT;
+
+	task_pt_regs(task)->pstate |= val;
+}
+
+static inline void ssbd_ssbs_disable(struct task_struct *task)
+{
+	u64 val = is_compat_thread(task_thread_info(task)) ?
+		PSR_AA32_SSBS_BIT : PSR_SSBS_BIT;
+
+	task_pt_regs(task)->pstate &= ~val;
+}
+
+#endif	/* __ASM_SSBD_H */
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 6089638c7d43..ad3c67c86c4c 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -54,6 +54,7 @@
 #include <asm/mmu_context.h>
 #include <asm/processor.h>
 #include <asm/pointer_auth.h>
+#include <asm/ssbd.h>
 #include <asm/stacktrace.h>
 
 #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_PER_TASK)
@@ -588,6 +589,18 @@ void arch_setup_new_exec(void)
 	current->mm->context.flags = is_compat_task() ? MMCF_AARCH32 : 0;
 
 	ptrauth_thread_init_user(current);
+
+	/*
+	 * Don't inherit TIF_SSBD across exec boundary when
+	 * PR_SPEC_DISABLE_NOEXEC is used.
+	 */
+	if (test_thread_flag(TIF_SSBD) &&
+	    task_spec_ssb_noexec(current)) {
+		clear_thread_flag(TIF_SSBD);
+		task_clear_spec_ssb_disable(current);
+		task_clear_spec_ssb_noexec(current);
+		ssbd_ssbs_enable(current);
+	}
 }
 
 #ifdef CONFIG_ARM64_TAGGED_ADDR_ABI
diff --git a/arch/arm64/kernel/ssbd.c b/arch/arm64/kernel/ssbd.c
index b26955f56750..e936b7ee700b 100644
--- a/arch/arm64/kernel/ssbd.c
+++ b/arch/arm64/kernel/ssbd.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018 ARM Ltd, All Rights Reserved.
  */
 
-#include <linux/compat.h>
 #include <linux/errno.h>
 #include <linux/prctl.h>
 #include <linux/sched.h>
@@ -11,22 +10,7 @@
 #include <linux/thread_info.h>
 
 #include <asm/cpufeature.h>
-
-static void ssbd_ssbs_enable(struct task_struct *task)
-{
-	u64 val = is_compat_thread(task_thread_info(task)) ?
-		  PSR_AA32_SSBS_BIT : PSR_SSBS_BIT;
-
-	task_pt_regs(task)->pstate |= val;
-}
-
-static void ssbd_ssbs_disable(struct task_struct *task)
-{
-	u64 val = is_compat_thread(task_thread_info(task)) ?
-		  PSR_AA32_SSBS_BIT : PSR_SSBS_BIT;
-
-	task_pt_regs(task)->pstate &= ~val;
-}
+#include <asm/ssbd.h>
 
 /*
  * prctl interface for SSBD
@@ -43,6 +27,7 @@ static int ssbd_prctl_set(struct task_struct *task, unsigned long ctrl)
 	if (state == ARM64_SSBD_MITIGATED) {
 		switch (ctrl) {
 		case PR_SPEC_ENABLE:
+		case PR_SPEC_DISABLE_NOEXEC:
 			return -EPERM;
 		case PR_SPEC_DISABLE:
 		case PR_SPEC_FORCE_DISABLE:
@@ -62,6 +47,7 @@ static int ssbd_prctl_set(struct task_struct *task, unsigned long ctrl)
 		    task_spec_ssb_force_disable(task))
 			return -EPERM;
 		task_clear_spec_ssb_disable(task);
+		task_clear_spec_ssb_noexec(task);
 		clear_tsk_thread_flag(task, TIF_SSBD);
 		ssbd_ssbs_enable(task);
 		break;
@@ -69,6 +55,7 @@ static int ssbd_prctl_set(struct task_struct *task, unsigned long ctrl)
 		if (state == ARM64_SSBD_FORCE_DISABLE)
 			return -EPERM;
 		task_set_spec_ssb_disable(task);
+		task_clear_spec_ssb_noexec(task);
 		set_tsk_thread_flag(task, TIF_SSBD);
 		ssbd_ssbs_disable(task);
 		break;
@@ -76,10 +63,21 @@ static int ssbd_prctl_set(struct task_struct *task, unsigned long ctrl)
 		if (state == ARM64_SSBD_FORCE_DISABLE)
 			return -EPERM;
 		task_set_spec_ssb_disable(task);
+		task_clear_spec_ssb_noexec(task);
 		task_set_spec_ssb_force_disable(task);
 		set_tsk_thread_flag(task, TIF_SSBD);
 		ssbd_ssbs_disable(task);
 		break;
+	case PR_SPEC_DISABLE_NOEXEC:
+		if (state == ARM64_SSBD_FORCE_ENABLE ||
+		    state == ARM64_SSBD_FORCE_DISABLE ||
+		    task_spec_ssb_force_disable(task))
+			return -EPERM;
+		task_set_spec_ssb_disable(task);
+		task_set_spec_ssb_noexec(task);
+		set_tsk_thread_flag(task, TIF_SSBD);
+		ssbd_ssbs_disable(task);
+		break;
 	default:
 		return -ERANGE;
 	}
@@ -108,6 +106,8 @@ static int ssbd_prctl_get(struct task_struct *task)
 	case ARM64_SSBD_KERNEL:
 		if (task_spec_ssb_force_disable(task))
 			return PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE;
+		if (task_spec_ssb_noexec(task))
+			return PR_SPEC_PRCTL | PR_SPEC_DISABLE_NOEXEC;
 		if (task_spec_ssb_disable(task))
 			return PR_SPEC_PRCTL | PR_SPEC_DISABLE;
 		return PR_SPEC_PRCTL | PR_SPEC_ENABLE;
-- 
2.18.4

