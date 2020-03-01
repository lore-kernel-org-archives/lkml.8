Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94C8C3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 21:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC46C24672
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 21:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Baez6k8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgCAVjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 16:39:07 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:50740 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgCAVjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 16:39:06 -0500
Received: by mail-pj1-f65.google.com with SMTP id nm14so802913pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 13:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f3Ble6iA1rj1SewO8T/W6hk1dFYEXHz8p6afe2PQVOE=;
        b=Baez6k8SMiky2op1OrkEDatdJ9BJ67VWqxNDvvyam6izr4oVEPVeweJobVzNKt9vFV
         NRsm2mbD0VbFq/6HHKD4HBjezKw5v2P7jeLaXvxzeKq5gilbjSNsbVieTSdaufgMKUyx
         8eysv542D7sS+p0HdXc1okTh6NsxnnqWzXtD6JGokHEAOaI9skC+kq1roejWDOti7Bd6
         qYJJj416nolw6ELpxw08iwZa0SVh8zyDPh2a2glGp1fn8AVgmuTfD/NEKFmPNlOzCVCW
         W/HHXQmQxuUNR9KcW8RYzFZgoPPFAU3jQAMji0ZcnbnLGtW/K6FBk2zHKRxNtQR9Aokm
         no4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f3Ble6iA1rj1SewO8T/W6hk1dFYEXHz8p6afe2PQVOE=;
        b=ALrzrWNN6u9YatXOwcuSWFlE2iIqGYfgL4C2wuaxOLJlq1qZosaEo/BscANKc/1n3/
         Mq0JaVSHWOUPchHknLXrnU8NJ6xN2+iM2GoMcsULarr0UbZwt1Cal4jBcHUxzCPl9VeA
         fpVTymy2wVkebIi5dfmr3qQ9jr0Z99nbOn7fCwypJXgAp73zp6fiGOqBvQJXKmbYzEIQ
         5AT9019u14GwoZfqtwbfKz24Wbg92QXOqHZT09UjnJJTD/LSZsuWACGvXJpsNg+CAGaP
         AKIbBBRtkACjk97eQwbTvyK7WzIsbBo/idck0/I8M+vZ1yJf5ujN7lwOLUM+ybg+nxEq
         BXvw==
X-Gm-Message-State: APjAAAXJguGm9SMZt8KxuBVCZER6cKuX9gJkVUOY3M5NUTDk3NRi7FHC
        SQfZc3DohRsiLIWinFAoWytWKtIr
X-Google-Smtp-Source: APXvYqwGTAkEpETbgLz3hnEVmINerLlAPbtLLmIFzAh3x5V/WWjI5zyFwqlVUrTFz2LUk4dnCBPkXw==
X-Received: by 2002:a17:902:b611:: with SMTP id b17mr14793523pls.23.1583098745201;
        Sun, 01 Mar 2020 13:39:05 -0800 (PST)
Received: from localhost (g183.222-224-185.ppp.wakwak.ne.jp. [222.224.185.183])
        by smtp.gmail.com with ESMTPSA id b18sm18628378pfd.63.2020.03.01.13.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 13:39:04 -0800 (PST)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Christian Brauner <christian@brauner.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 1/3] openrisc: Convert copy_thread to copy_thread_tls
Date:   Mon,  2 Mar 2020 06:38:49 +0900
Message-Id: <20200301213851.8096-2-shorne@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200301213851.8096-1-shorne@gmail.com>
References: <20200301213851.8096-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is required for clone3 which passes the TLS value through a
struct rather than a register.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/Kconfig          |  1 +
 arch/openrisc/kernel/process.c | 17 ++++++-----------
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 1928e061ff96..5debdbe6fc35 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -14,6 +14,7 @@ config OPENRISC
 	select HANDLE_DOMAIN_IRQ
 	select GPIOLIB
 	select HAVE_ARCH_TRACEHOOK
+	select HAVE_COPY_THREAD_TLS
 	select SPARSE_IRQ
 	select GENERIC_IRQ_CHIP
 	select GENERIC_IRQ_PROBE
diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index b06f84f6676f..5caa47f7de4f 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -117,12 +117,13 @@ void release_thread(struct task_struct *dead_task)
 extern asmlinkage void ret_from_fork(void);
 
 /*
- * copy_thread
+ * copy_thread_tls
  * @clone_flags: flags
  * @usp: user stack pointer or fn for kernel thread
  * @arg: arg to fn for kernel thread; always NULL for userspace thread
  * @p: the newly created task
  * @regs: CPU context to copy for userspace thread; always NULL for kthread
+ * @tls: the Thread Local Storage pointer for the new process
  *
  * At the top of a newly initialized kernel stack are two stacked pt_reg
  * structures.  The first (topmost) is the userspace context of the thread.
@@ -148,8 +149,8 @@ extern asmlinkage void ret_from_fork(void);
  */
 
 int
-copy_thread(unsigned long clone_flags, unsigned long usp,
-	    unsigned long arg, struct task_struct *p)
+copy_thread_tls(unsigned long clone_flags, unsigned long usp,
+		unsigned long arg, struct task_struct *p, unsigned long tls)
 {
 	struct pt_regs *userregs;
 	struct pt_regs *kregs;
@@ -179,16 +180,10 @@ copy_thread(unsigned long clone_flags, unsigned long usp,
 			userregs->sp = usp;
 
 		/*
-		 * For CLONE_SETTLS set "tp" (r10) to the TLS pointer passed to sys_clone.
-		 *
-		 * The kernel entry is:
-		 *	int clone (long flags, void *child_stack, int *parent_tid,
-		 *		int *child_tid, struct void *tls)
-		 *
-		 * This makes the source r7 in the kernel registers.
+		 * For CLONE_SETTLS set "tp" (r10) to the TLS pointer.
 		 */
 		if (clone_flags & CLONE_SETTLS)
-			userregs->gpr[10] = userregs->gpr[7];
+			userregs->gpr[10] = tls;
 
 		userregs->gpr[11] = 0;	/* Result from fork() */
 
-- 
2.21.0

