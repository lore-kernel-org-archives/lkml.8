Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CAAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C63B2076E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731455AbgFVXq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 19:46:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54784 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730632AbgFVXqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 19:46:10 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jnW8e-0005DO-Lz; Mon, 22 Jun 2020 23:46:08 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-alpha@vger.kernel.org
Subject: [PATCH 09/17] alpha: switch to copy_thread_tls()
Date:   Tue, 23 Jun 2020 01:43:18 +0200
Message-Id: <20200622234326.906346-10-christian.brauner@ubuntu.com>
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

Cc: linux-alpha@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 arch/alpha/Kconfig          | 1 +
 arch/alpha/kernel/process.c | 9 ++++-----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 10862c5a8c76..b01515c6b2ed 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -38,6 +38,7 @@ config ALPHA
 	select OLD_SIGSUSPEND
 	select CPU_NO_EFFICIENT_FFS if !ALPHA_EV67
 	select MMU_GATHER_NO_RANGE
+	select HAVE_COPY_THREAD_TLS
 	help
 	  The Alpha is a 64-bit general-purpose processor designed and
 	  marketed by the Digital Equipment Corporation of blessed memory,
diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index b45f0b0d6511..dfdb6b6ba61c 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -233,10 +233,9 @@ release_thread(struct task_struct *dead_task)
 /*
  * Copy architecture-specific thread state
  */
-int
-copy_thread(unsigned long clone_flags, unsigned long usp,
-	    unsigned long kthread_arg,
-	    struct task_struct *p)
+int copy_thread_tls(unsigned long clone_flags, unsigned long usp,
+		    unsigned long kthread_arg, struct task_struct *p,
+		    unsigned long tls)
 {
 	extern void ret_from_fork(void);
 	extern void ret_from_kernel_thread(void);
@@ -267,7 +266,7 @@ copy_thread(unsigned long clone_flags, unsigned long usp,
 	   required for proper operation in the case of a threaded
 	   application calling fork.  */
 	if (clone_flags & CLONE_SETTLS)
-		childti->pcb.unique = regs->r20;
+		childti->pcb.unique = tls;
 	else
 		regs->r20 = 0;	/* OSF/1 has some strange fork() semantics.  */
 	childti->pcb.usp = usp ?: rdusp();
-- 
2.27.0

