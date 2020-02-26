Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D49BC4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D232F20838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2oR2jPe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgBZW4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 17:56:53 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34422 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgBZW4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 17:56:52 -0500
Received: by mail-pl1-f193.google.com with SMTP id j7so304441plt.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 14:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ohmIu4XqdwwoGOhxHZxWRSxu96xnb4vm9jRlxB7Rk4=;
        b=o2oR2jPevA8x/8UCrV1EgrGE3AdJ+mc/EDnisAEwLf1+dC0nr+f6eotTgRm7T+Z7oc
         mkrFlGEqZobJMMQXcKPlFRL8Thl9nqWAo/KaId7bkyLJv+hcxpjxTkE9y09g2taDz3DO
         Y3sJ+9SMdjgEldumApxzkxT8DXFcnq7M6wEiRJK7xpPUANBKP42OMFDYYo3R3RghOT/j
         x0KyWy3ZIqxMqhwGh9MnFYCRPpvkc5wCkmfF5ibJEKDcJnAmbgsodQgo4sTOdpHEGlaT
         ywxGjgh7s8CBSYwBndo8//PKsIDrv0J+hCaTJNrB8QQoJhMOPp5Ye5HCuqwv/xGeJr4n
         +eQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ohmIu4XqdwwoGOhxHZxWRSxu96xnb4vm9jRlxB7Rk4=;
        b=A9sbWWsSbapM0Rb0MwYNdmF3sHx2gnDTY+PDOZka9oG1fv0DmzyrhACFl3Hc5f7FUI
         YfIuGMjnGOAoOAo4Wmit8h3F3kP9cbfeKa7U0WHuPuEJQxBOKcxKcGcg0nK8kTvKlAu/
         Q6lFRRgHL79O4qEE1ujC3/FR3agpMvsaGGbUvDBKK7yKffMzrP/Y8MAFXubGTCiqfu0f
         JHCTO0Fq60ayQy2yNshI1u9ot4ZINs82Po3bAYjqSEihq0NlpoFt6xLasjG2w9xVbuZT
         ic1StQsC0+Z/J573CfUF/aQZ4KvIo1SD0ejX8SIFhcELqVz4hZfmZbSu7FZRzVxrdLWl
         0hbw==
X-Gm-Message-State: APjAAAXZA8/SWWDvo8E1MTG4RiuzQD5FuGhRbf3sX+D4r+QUeEcnuiWf
        DoSSIMKKgOoG1RxlBXHoNWOH1przgG0=
X-Google-Smtp-Source: APXvYqyXIDUoVSh1xIbmqRleT9ipQIwFfAFOCOxSOCNOljpXoL9fKKWk7ldO6qo96r/BqC4LOs4qpg==
X-Received: by 2002:a17:90a:c78b:: with SMTP id gn11mr1471893pjb.97.1582757809594;
        Wed, 26 Feb 2020 14:56:49 -0800 (PST)
Received: from localhost (g183.222-224-185.ppp.wakwak.ne.jp. [222.224.185.183])
        by smtp.gmail.com with ESMTPSA id x190sm4277665pfb.96.2020.02.26.14.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 14:56:49 -0800 (PST)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>
Cc:     Stafford Horne <shorne@gmail.com>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Christian Brauner <christian@brauner.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>
Subject: [PATCH 1/3] openrisc: Convert copy_thread to copy_thread_tls
Date:   Thu, 27 Feb 2020 07:56:23 +0900
Message-Id: <20200226225625.28935-2-shorne@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200226225625.28935-1-shorne@gmail.com>
References: <20200226225625.28935-1-shorne@gmail.com>
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
 arch/openrisc/kernel/process.c | 15 +++++----------
 2 files changed, 6 insertions(+), 10 deletions(-)

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
index b06f84f6676f..6695f167e126 100644
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
+ * @tls: the Thread Local Storate pointer for the new process
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
@@ -180,15 +181,9 @@ copy_thread(unsigned long clone_flags, unsigned long usp,
 
 		/*
 		 * For CLONE_SETTLS set "tp" (r10) to the TLS pointer passed to sys_clone.
-		 *
-		 * The kernel entry is:
-		 *	int clone (long flags, void *child_stack, int *parent_tid,
-		 *		int *child_tid, struct void *tls)
-		 *
-		 * This makes the source r7 in the kernel registers.
 		 */
 		if (clone_flags & CLONE_SETTLS)
-			userregs->gpr[10] = userregs->gpr[7];
+			userregs->gpr[10] = tls;
 
 		userregs->gpr[11] = 0;	/* Result from fork() */
 
-- 
2.21.0

