Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A335C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 495CE20720
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731398AbgFVXqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 19:46:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54840 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731162AbgFVXqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 19:46:15 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jnW8h-0005DO-9d; Mon, 22 Jun 2020 23:46:11 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Guan Xuetao <gxt@pku.edu.cn>
Subject: [PATCH 15/17] unicore: switch to copy_thread_tls()
Date:   Tue, 23 Jun 2020 01:43:24 +0200
Message-Id: <20200622234326.906346-16-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200622234326.906346-1-christian.brauner@ubuntu.com>
References: <20200622234326.906346-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the copy_thread_tls() calling convention which passes tls through a
register. This is required so we can remove the copy_thread{_tls}() split
and remove the HAVE_COPY_THREAD_TLS macro.

Cc: Guan Xuetao <gxt@pku.edu.cn>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 arch/unicore32/Kconfig          | 1 +
 arch/unicore32/kernel/process.c | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index 11ba1839d198..01451cf500d2 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -22,6 +22,7 @@ config UNICORE32
 	select MODULES_USE_ELF_REL
 	select NEED_DMA_MAP_STATE
 	select MMU_GATHER_NO_RANGE if MMU
+	select HAVE_COPY_THREAD_TLS
 	help
 	  UniCore-32 is 32-bit Instruction Set Architecture,
 	  including a series of low-power-consumption RISC chip
diff --git a/arch/unicore32/kernel/process.c b/arch/unicore32/kernel/process.c
index b4fd3a604a18..49a305565a53 100644
--- a/arch/unicore32/kernel/process.c
+++ b/arch/unicore32/kernel/process.c
@@ -219,9 +219,9 @@ void release_thread(struct task_struct *dead_task)
 asmlinkage void ret_from_fork(void) __asm__("ret_from_fork");
 asmlinkage void ret_from_kernel_thread(void) __asm__("ret_from_kernel_thread");
 
-int
-copy_thread(unsigned long clone_flags, unsigned long stack_start,
-	    unsigned long stk_sz, struct task_struct *p)
+int copy_thread_tls(unsigned long clone_flags, unsigned long stack_start,
+		    unsigned long stk_sz, struct task_struct *p,
+		    unsigned long tls)
 {
 	struct thread_info *thread = task_thread_info(p);
 	struct pt_regs *childregs = task_pt_regs(p);
@@ -241,7 +241,7 @@ copy_thread(unsigned long clone_flags, unsigned long stack_start,
 			childregs->UCreg_sp = stack_start;
 
 		if (clone_flags & CLONE_SETTLS)
-			childregs->UCreg_16 = childregs->UCreg_03;
+			childregs->UCreg_16 = tls;
 	}
 	return 0;
 }
-- 
2.27.0

