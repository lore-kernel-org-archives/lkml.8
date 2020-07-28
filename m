Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0F0C433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26EE02065E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbgG1UW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:22:58 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56844 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbgG1UWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 16:22:55 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 207DC291A2E
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de
Cc:     keescook@chromium.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 3/6] arch: x86: Wrap TIF_X32 checks
Date:   Tue, 28 Jul 2020 16:22:26 -0400
Message-Id: <20200728202229.1195682-4-krisman@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200728202229.1195682-1-krisman@collabora.com>
References: <20200728202229.1195682-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove TIF_X32, add a wrapper that checks the process
is using the X32 ABI without using the flag directly.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 arch/x86/entry/vdso/vma.c          | 2 +-
 arch/x86/include/asm/elf.h         | 2 +-
 arch/x86/include/asm/thread_info.h | 1 +
 arch/x86/kernel/process_64.c       | 3 +--
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index ea7c1f0b79df..0f54a5feeced 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -417,7 +417,7 @@ int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
 				       int uses_interp)
 {
 #ifdef CONFIG_X86_X32_ABI
-	if (test_thread_flag(TIF_X32)) {
+	if (TASK_X32(current)) {
 		if (!vdso64_enabled)
 			return 0;
 		return map_vdso_randomized(&vdso_image_x32);
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 452beed7892b..a5c8f10d5180 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -363,7 +363,7 @@ do {									\
 #define AT_SYSINFO		32
 
 #define COMPAT_ARCH_DLINFO						\
-if (test_thread_flag(TIF_X32))						\
+if (TASK_X32(current))							\
 	ARCH_DLINFO_X32;						\
 else									\
 	ARCH_DLINFO_IA32
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index a3859595847c..6d55a9c0dda2 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -244,5 +244,6 @@ extern void arch_setup_new_exec(void);
 #endif	/* !__ASSEMBLY__ */
 
 #define TASK_IA32(tsk) test_tsk_thread_flag(tsk, TIF_IA32)
+#define TASK_X32(tsk) test_tsk_thread_flag(tsk, TIF_X32)
 
 #endif /* _ASM_X86_THREAD_INFO_H */
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 4452a35402f9..f20a365017b8 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -406,8 +406,7 @@ EXPORT_SYMBOL_GPL(start_thread);
 void compat_start_thread(struct pt_regs *regs, u32 new_ip, u32 new_sp)
 {
 	start_thread_common(regs, new_ip, new_sp,
-			    test_thread_flag(TIF_X32)
-			    ? __USER_CS : __USER32_CS,
+			    TASK_X32(current) ? __USER_CS : __USER32_CS,
 			    __USER_DS, __USER_DS);
 }
 #endif
-- 
2.27.0

