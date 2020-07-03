Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADE2C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08A2B20870
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593795792;
	bh=SfszQdFlwgIl5YnSYxbpqXbdU9F4IbKjUsx0yCBOSgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ASTqC8SgqEClCUOEz9BS80iaKCWZFiJ35gxGnSlUzNr1qgvI2MvKhX3x8B82AwMyT
	 baccS+ppVXUg8P34VO2ew6BzB7Zo0oqTMuIy9VvWaXacMkHTn0UlY58GZnWLhBdYp4
	 Ifmc/oJrzpZOGBjQHOvORNwdI2QG1QWUaiKwZIHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgGCRDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:03:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbgGCRDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:03:05 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50C952100A;
        Fri,  3 Jul 2020 17:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593795784;
        bh=SfszQdFlwgIl5YnSYxbpqXbdU9F4IbKjUsx0yCBOSgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZrRRcb68Q/MtXYb8Xa5cBiEkW8x9eqW4Wzwy7bDGMwtASMHNqF9RB4vuW//AI/3wP
         Q4yNLGThF0KAY9DeUeWWuQ+9jIv6izEst4isa/vTbGjEZD4v7nRhSRYnyancnB6UiB
         dDplEVt+Di6xZZE92spDJ0Wxcrn8PSrZ7NtfhMwA=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH entry v2 4/6] x86/entry/32: Fix #MC and #DB wiring on x86_32
Date:   Fri,  3 Jul 2020 10:02:56 -0700
Message-Id: <9e90a7ee8e72fd757db6d92e1e5ff16339c1ecf9.1593795633.git.luto@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1593795633.git.luto@kernel.org>
References: <cover.1593795633.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DEFINE_IDTENTRY_MCE and DEFINE_IDTENTRY_DEBUG were wired up as non-RAW
on x86_32, but the code expected them to be RAW.

Get rid of all the macro indirection for them on 32-bit and just use
DECLARE_IDTENTRY_RAW and DEFINE_IDTENTRY_RAW directly.

Also add a warning to make sure that we only hit the _kernel paths
in kernel mode.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/include/asm/idtentry.h | 23 +++++++++++++----------
 arch/x86/kernel/cpu/mce/core.c  |  4 +++-
 arch/x86/kernel/traps.c         |  2 +-
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 94333ac3092b..eeac6dc2adaa 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -353,10 +353,6 @@ static __always_inline void __##func(struct pt_regs *regs)
 
 #else	/* CONFIG_X86_64 */
 
-/* Maps to a regular IDTENTRY on 32bit for now */
-# define DECLARE_IDTENTRY_IST		DECLARE_IDTENTRY
-# define DEFINE_IDTENTRY_IST		DEFINE_IDTENTRY
-
 /**
  * DECLARE_IDTENTRY_DF - Declare functions for double fault 32bit variant
  * @vector:	Vector number (ignored for C)
@@ -387,16 +383,18 @@ __visible noinstr void func(struct pt_regs *regs,			\
 #endif	/* !CONFIG_X86_64 */
 
 /* C-Code mapping */
+#define DECLARE_IDTENTRY_NMI		DECLARE_IDTENTRY_RAW
+#define DEFINE_IDTENTRY_NMI		DEFINE_IDTENTRY_RAW
+
+#ifdef CONFIG_X86_64
 #define DECLARE_IDTENTRY_MCE		DECLARE_IDTENTRY_IST
 #define DEFINE_IDTENTRY_MCE		DEFINE_IDTENTRY_IST
 #define DEFINE_IDTENTRY_MCE_USER	DEFINE_IDTENTRY_NOIST
 
-#define DECLARE_IDTENTRY_NMI		DECLARE_IDTENTRY_RAW
-#define DEFINE_IDTENTRY_NMI		DEFINE_IDTENTRY_RAW
-
 #define DECLARE_IDTENTRY_DEBUG		DECLARE_IDTENTRY_IST
 #define DEFINE_IDTENTRY_DEBUG		DEFINE_IDTENTRY_IST
 #define DEFINE_IDTENTRY_DEBUG_USER	DEFINE_IDTENTRY_NOIST
+#endif
 
 #else /* !__ASSEMBLY__ */
 
@@ -443,9 +441,6 @@ __visible noinstr void func(struct pt_regs *regs,			\
 # define DECLARE_IDTENTRY_MCE(vector, func)				\
 	DECLARE_IDTENTRY(vector, func)
 
-# define DECLARE_IDTENTRY_DEBUG(vector, func)				\
-	DECLARE_IDTENTRY(vector, func)
-
 /* No ASM emitted for DF as this goes through a C shim */
 # define DECLARE_IDTENTRY_DF(vector, func)
 
@@ -549,7 +544,11 @@ DECLARE_IDTENTRY_RAW(X86_TRAP_BP,		exc_int3);
 DECLARE_IDTENTRY_RAW_ERRORCODE(X86_TRAP_PF,	exc_page_fault);
 
 #ifdef CONFIG_X86_MCE
+#ifdef CONFIG_X86_64
 DECLARE_IDTENTRY_MCE(X86_TRAP_MC,	exc_machine_check);
+#else
+DECLARE_IDTENTRY_RAW(X86_TRAP_MC,	exc_machine_check);
+#endif
 #endif
 
 /* NMI */
@@ -559,7 +558,11 @@ DECLARE_IDTENTRY_RAW(X86_TRAP_NMI,	xenpv_exc_nmi);
 #endif
 
 /* #DB */
+#ifdef CONFIG_X86_64
 DECLARE_IDTENTRY_DEBUG(X86_TRAP_DB,	exc_debug);
+#else
+DECLARE_IDTENTRY_RAW(X86_TRAP_DB,	exc_debug);
+#endif
 #ifdef CONFIG_XEN_PV
 DECLARE_IDTENTRY_RAW(X86_TRAP_DB,	xenpv_exc_debug);
 #endif
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index ce9120c4f740..a6a90b5d7c83 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1901,6 +1901,8 @@ void (*machine_check_vector)(struct pt_regs *) = unexpected_machine_check;
 
 static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 {
+	WARN_ON_ONCE(user_mode(regs));
+
 	/*
 	 * Only required when from kernel mode. See
 	 * mce_check_crashing_cpu() for details.
@@ -1954,7 +1956,7 @@ DEFINE_IDTENTRY_MCE_USER(exc_machine_check)
 }
 #else
 /* 32bit unified entry point */
-DEFINE_IDTENTRY_MCE(exc_machine_check)
+DEFINE_IDTENTRY_RAW(exc_machine_check)
 {
 	unsigned long dr7;
 
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c17f9b57171f..6ed8cc5fbe8f 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -925,7 +925,7 @@ DEFINE_IDTENTRY_DEBUG_USER(exc_debug)
 }
 #else
 /* 32 bit does not have separate entry points. */
-DEFINE_IDTENTRY_DEBUG(exc_debug)
+DEFINE_IDTENTRY_RAW(exc_debug)
 {
 	unsigned long dr6, dr7;
 
-- 
2.25.4

