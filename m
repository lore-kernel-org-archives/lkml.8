Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB641C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB29D20825
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgG1UWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbgG1UWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 16:22:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD821C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 13:22:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 86B68297E76
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de
Cc:     keescook@chromium.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 1/6] arch: x86: Don't use TIF flags for mm context
Date:   Tue, 28 Jul 2020 16:22:24 -0400
Message-Id: <20200728202229.1195682-2-krisman@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200728202229.1195682-1-krisman@collabora.com>
References: <20200728202229.1195682-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TIF_IA32 and TIF_X32 are going away.  Create a dedicated enum for the
MM context.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 arch/x86/include/asm/mmu_context.h | 2 +-
 arch/x86/include/asm/thread_info.h | 6 ++++++
 arch/x86/kernel/process_64.c       | 4 ++--
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 47562147e70b..055ee5d66b41 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -178,7 +178,7 @@ static inline void arch_exit_mmap(struct mm_struct *mm)
 static inline bool is_64bit_mm(struct mm_struct *mm)
 {
 	return	!IS_ENABLED(CONFIG_IA32_EMULATION) ||
-		!(mm->context.ia32_compat == TIF_IA32);
+		!(mm->context.ia32_compat == PSABI_IA32);
 }
 #else
 static inline bool is_64bit_mm(struct mm_struct *mm)
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 267701ae3d86..934aa15b20f2 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -53,6 +53,12 @@ struct task_struct;
 #include <asm/cpufeature.h>
 #include <linux/atomic.h>
 
+enum {
+	PSABI_IA64 = 0,
+	PSABI_IA32 = 1,
+	PSABI_X32  = 2
+};
+
 struct thread_info {
 	unsigned long		flags;		/* low level flags */
 	u32			status;		/* thread synchronous flags */
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 9a97415b2139..4452a35402f9 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -557,7 +557,7 @@ static void __set_personality_x32(void)
 	clear_thread_flag(TIF_IA32);
 	set_thread_flag(TIF_X32);
 	if (current->mm)
-		current->mm->context.ia32_compat = TIF_X32;
+		current->mm->context.ia32_compat = PSABI_X32;
 	current->personality &= ~READ_IMPLIES_EXEC;
 	/*
 	 * in_32bit_syscall() uses the presence of the x32 syscall bit
@@ -578,7 +578,7 @@ static void __set_personality_ia32(void)
 	set_thread_flag(TIF_IA32);
 	clear_thread_flag(TIF_X32);
 	if (current->mm)
-		current->mm->context.ia32_compat = TIF_IA32;
+		current->mm->context.ia32_compat = PSABI_IA32;
 	current->personality |= force_personality32;
 	/* Prepare the first "return" to user space */
 	task_pt_regs(current)->orig_ax = __NR_ia32_execve;
-- 
2.27.0

