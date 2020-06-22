Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD6AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 666A920720
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731245AbgFVXqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 19:46:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54809 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731110AbgFVXqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 19:46:12 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jnW8g-0005DO-Er; Mon, 22 Jun 2020 23:46:10 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Greentime Hu <green.hu@gmail.com>,
        Nick Hu <nickhu@andestech.com>,
        Vincent Chen <deanbo422@gmail.com>
Subject: [PATCH 13/17] nds32: switch to copy_thread_tls()
Date:   Tue, 23 Jun 2020 01:43:22 +0200
Message-Id: <20200622234326.906346-14-christian.brauner@ubuntu.com>
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

Cc: Greentime Hu <green.hu@gmail.com>
Cc: Nick Hu <nickhu@andestech.com>
Cc: Vincent Chen <deanbo422@gmail.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 arch/nds32/Kconfig          | 1 +
 arch/nds32/kernel/process.c | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index e30298e99e1b..7b6eaca81cce 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -48,6 +48,7 @@ config NDS32
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_DYNAMIC_FTRACE
+	select HAVE_COPY_THREAD_TLS
 	help
 	  Andes(nds32) Linux support.
 
diff --git a/arch/nds32/kernel/process.c b/arch/nds32/kernel/process.c
index 9712fd474f2c..7dbb1bf64165 100644
--- a/arch/nds32/kernel/process.c
+++ b/arch/nds32/kernel/process.c
@@ -149,8 +149,9 @@ void flush_thread(void)
 DEFINE_PER_CPU(struct task_struct *, __entry_task);
 
 asmlinkage void ret_from_fork(void) __asm__("ret_from_fork");
-int copy_thread(unsigned long clone_flags, unsigned long stack_start,
-		unsigned long stk_sz, struct task_struct *p)
+int copy_thread_tls(unsigned long clone_flags, unsigned long stack_start,
+		    unsigned long stk_sz, struct task_struct *p,
+		    unsigned long tls)
 {
 	struct pt_regs *childregs = task_pt_regs(p);
 
@@ -170,7 +171,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 		childregs->uregs[0] = 0;
 		childregs->osp = 0;
 		if (clone_flags & CLONE_SETTLS)
-			childregs->uregs[25] = childregs->uregs[3];
+			childregs->uregs[25] = tls;
 	}
 	/* cpu context switching  */
 	p->thread.cpu_context.pc = (unsigned long)ret_from_fork;
-- 
2.27.0

