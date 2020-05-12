Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E750CA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 17:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72706205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 17:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbgELRPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 13:15:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43906 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728941AbgELRPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 13:15:41 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jYYVE-0002Ci-Ob; Tue, 12 May 2020 17:15:36 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 3/3] sparc: unconditionally enable HAVE_COPY_THREAD_TLS
Date:   Tue, 12 May 2020 19:15:27 +0200
Message-Id: <20200512171527.570109-4-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512171527.570109-1-christian.brauner@ubuntu.com>
References: <20200512171527.570109-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that both sparc and sparc64 support copy_thread_tls() and don't rely
on do_fork() anymore, turn on HAVE_COPY_THREAD_TLS unconditionally. Once
all architectures are switched over this macro will be removed and
the old do_fork() calling convention fully abandoned in favor of the
cleaner struct kernel_clone_args one.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Guo Ren <guoren@kernel.org>
Cc: linux-csky@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 arch/sparc/Kconfig             | 2 +-
 arch/sparc/kernel/process_32.c | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 423f6bc41de2..9f44afe1f73d 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -48,6 +48,7 @@ config SPARC
 	select LOCKDEP_SMALL if LOCKDEP
 	select NEED_DMA_MAP_STATE
 	select NEED_SG_DMA_LENGTH
+	select HAVE_COPY_THREAD_TLS
 
 config SPARC32
 	def_bool !64BIT
@@ -95,7 +96,6 @@ config SPARC64
 	select ARCH_HAS_PTE_SPECIAL
 	select PCI_DOMAINS if PCI
 	select ARCH_HAS_GIGANTIC_PAGE
-	select HAVE_COPY_THREAD_TLS
 
 config ARCH_PROC_KCORE_TEXT
 	def_bool y
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index 9c510e6625aa..575bfbda7373 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -274,8 +274,9 @@ clone_stackframe(struct sparc_stackf __user *dst,
 extern void ret_from_fork(void);
 extern void ret_from_kernel_thread(void);
 
-int copy_thread(unsigned long clone_flags, unsigned long sp,
-		unsigned long arg, struct task_struct *p)
+int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
+		    unsigned long arg, struct task_struct *p,
+		    unsigned long tls)
 {
 	struct thread_info *ti = task_thread_info(p);
 	struct pt_regs *childregs, *regs = current_pt_regs();
@@ -377,7 +378,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp,
 	regs->u_regs[UREG_I1] = 0;
 
 	if (clone_flags & CLONE_SETTLS)
-		childregs->u_regs[UREG_G7] = regs->u_regs[UREG_I3];
+		childregs->u_regs[UREG_G7] = tls;
 
 	return 0;
 }
-- 
2.26.2

