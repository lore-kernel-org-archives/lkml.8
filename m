Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DA9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D974A20720
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731380AbgFVXqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 19:46:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54800 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731100AbgFVXqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 19:46:12 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jnW8f-0005DO-F7; Mon, 22 Jun 2020 23:46:09 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Brian Cain <bcain@codeaurora.org>,
        linux-hexagon@vger.kernel.org
Subject: [PATCH 11/17] hexagon: switch to copy_thread_tls()
Date:   Tue, 23 Jun 2020 01:43:20 +0200
Message-Id: <20200622234326.906346-12-christian.brauner@ubuntu.com>
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

Cc: Brian Cain <bcain@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 arch/hexagon/Kconfig          | 1 +
 arch/hexagon/kernel/process.c | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 667cfc511cf9..19bc2f2ee331 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -31,6 +31,7 @@ config HEXAGON
 	select GENERIC_CLOCKEVENTS_BROADCAST
 	select MODULES_USE_ELF_RELA
 	select GENERIC_CPU_DEVICES
+	select HAVE_COPY_THREAD_TLS
 	help
 	  Qualcomm Hexagon is a processor architecture designed for high
 	  performance and low power across a wide variety of applications.
diff --git a/arch/hexagon/kernel/process.c b/arch/hexagon/kernel/process.c
index ac07f5f4b76b..d756f9556dd7 100644
--- a/arch/hexagon/kernel/process.c
+++ b/arch/hexagon/kernel/process.c
@@ -50,8 +50,8 @@ void arch_cpu_idle(void)
 /*
  * Copy architecture-specific thread state
  */
-int copy_thread(unsigned long clone_flags, unsigned long usp,
-		unsigned long arg, struct task_struct *p)
+int copy_thread_tls(unsigned long clone_flags, unsigned long usp,
+		    unsigned long arg, struct task_struct *p, unsigned long tls)
 {
 	struct thread_info *ti = task_thread_info(p);
 	struct hexagon_switch_stack *ss;
@@ -100,7 +100,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	 * ugp is used to provide TLS support.
 	 */
 	if (clone_flags & CLONE_SETTLS)
-		childregs->ugp = childregs->r04;
+		childregs->ugp = tls;
 
 	/*
 	 * Parent sees new pid -- not necessary, not even possible at
-- 
2.27.0

