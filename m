Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C66C433EA
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DBFF2065E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgG1UXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728437AbgG1UXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 16:23:01 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70245C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 13:23:01 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 303C628EA02
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de
Cc:     keescook@chromium.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 5/6] arch: x86: Reclaim TIF_IA32 flag
Date:   Tue, 28 Jul 2020 16:22:28 -0400
Message-Id: <20200728202229.1195682-6-krisman@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200728202229.1195682-1-krisman@collabora.com>
References: <20200728202229.1195682-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dropping this as a TIF flag is interesting given the pressure over x86
remaining x86 flags, plus considering the current common entry code,
reducing arch-specific flags is a good thing.

Notice that no path really relies on TIF_IA32 as part of a critical
path, therefore the cost of checking another field in thread_info
shouldn't be a problem.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 arch/x86/include/asm/thread_info.h | 4 +---
 arch/x86/kernel/process_64.c       | 3 ---
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 698feefd5f5f..aa7d27054a8a 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -99,7 +99,6 @@ struct thread_info {
 #define TIF_NEED_FPU_LOAD	14	/* load FPU on return to userspace */
 #define TIF_NOCPUID		15	/* CPUID is not accessible in userland */
 #define TIF_NOTSC		16	/* TSC is not accessible in userland */
-#define TIF_IA32		17	/* IA32 compatibility process */
 #define TIF_SLD			18	/* Restore split lock detection on context switch */
 #define TIF_MEMDIE		20	/* is terminating due to OOM killer */
 #define TIF_POLLING_NRFLAG	21	/* idle is polling for TIF_NEED_RESCHED */
@@ -129,7 +128,6 @@ struct thread_info {
 #define _TIF_NEED_FPU_LOAD	(1 << TIF_NEED_FPU_LOAD)
 #define _TIF_NOCPUID		(1 << TIF_NOCPUID)
 #define _TIF_NOTSC		(1 << TIF_NOTSC)
-#define _TIF_IA32		(1 << TIF_IA32)
 #define _TIF_SLD		(1 << TIF_SLD)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_IO_BITMAP		(1 << TIF_IO_BITMAP)
@@ -245,7 +243,7 @@ extern void arch_setup_new_exec(void);
 #define arch_setup_new_exec arch_setup_new_exec
 #endif	/* !__ASSEMBLY__ */
 
-#define TASK_IA32(tsk) test_tsk_thread_flag(tsk, TIF_IA32)
+#define TASK_IA32(tsk) (task_thread_info(tsk)->psabi == PSABI_IA32)
 #define TASK_X32(tsk) test_tsk_thread_flag(tsk, TIF_X32)
 
 #endif /* _ASM_X86_THREAD_INFO_H */
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index aea2c03e8a5d..75059c9de829 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -533,7 +533,6 @@ void set_personality_64bit(void)
 
 	/* Make sure to be in 64bit mode */
 	current_thread_info()->psabi = PSABI_IA64;
-	clear_thread_flag(TIF_IA32);
 	clear_thread_flag(TIF_ADDR32);
 	clear_thread_flag(TIF_X32);
 	/* Pretend that this comes from a 64bit execve */
@@ -555,7 +554,6 @@ static void __set_personality_x32(void)
 {
 #ifdef CONFIG_X86_X32
 	current_thread_info()->psabi = PSABI_X32;
-	clear_thread_flag(TIF_IA32);
 	set_thread_flag(TIF_X32);
 	if (current->mm)
 		current->mm->context.ia32_compat = PSABI_X32;
@@ -577,7 +575,6 @@ static void __set_personality_ia32(void)
 {
 #ifdef CONFIG_IA32_EMULATION
 	current_thread_info()->psabi = PSABI_IA32;
-	set_thread_flag(TIF_IA32);
 	clear_thread_flag(TIF_X32);
 	if (current->mm)
 		current->mm->context.ia32_compat = PSABI_IA32;
-- 
2.27.0

