Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E59C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 17:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F4E02070B
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 17:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OJQvG2FY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q5mfyl5I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgGDRtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 13:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgGDRtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 13:49:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A84BC061794;
        Sat,  4 Jul 2020 10:49:12 -0700 (PDT)
Date:   Sat, 04 Jul 2020 17:49:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593884950;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=//RojqTwiSgmeKHD3EOtUWV61Y/AD1KW+xSNsDKYw/Q=;
        b=OJQvG2FYXf+V0pYwa70fYkOfJMfTdnW5+8eA/5CUHsrDAMbjL/GGAnZq7xyTrlAUwIogm5
        EX1f/fBiTtEd6WykCDsU96KB9RzDTF7aUyaA94zlIBecndyylUheCLrnPfuuxkim8aspfP
        mk+JFOpOabK2ESstabr/bTQpohcjEbyRLWAf71/UPkEPr9DinpsLO9yWa9E99asxvOK8BP
        R5U+ZPY0KE8g0n1bC73xZxlNFhTvwv68QmTFM4gBRtIsLHUbQVrFW1+1IauznZx49VJXj/
        8w5SKFaKPAVk2bbxuwERuZ2gA0OcHTaVsF/Hy9zUYbYRjbssRg+AY2u74raXlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593884950;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=//RojqTwiSgmeKHD3EOtUWV61Y/AD1KW+xSNsDKYw/Q=;
        b=q5mfyl5I2/I1gutf3lcN7p366xyGsc5k4uc9HCgB5yXd/mwGcC7E2IW+OQdZCIoNPE/iiB
        6ZviztEacrLRZ7Bg==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/entry/32: Fix #MC and #DB wiring on x86_32
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <9e90a7ee8e72fd757db6d92e1e5ff16339c1ecf9.1593795633.git.luto@kernel.org>
References: <9e90a7ee8e72fd757db6d92e1e5ff16339c1ecf9.1593795633.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <159388494913.4006.14717567384455629762.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     13cbc0cd4a30c815984ad88e3a2e5976493516a3
Gitweb:        https://git.kernel.org/tip/13cbc0cd4a30c815984ad88e3a2e5976493516a3
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Fri, 03 Jul 2020 10:02:56 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 04 Jul 2020 19:47:26 +02:00

x86/entry/32: Fix #MC and #DB wiring on x86_32

DEFINE_IDTENTRY_MCE and DEFINE_IDTENTRY_DEBUG were wired up as non-RAW
on x86_32, but the code expected them to be RAW.

Get rid of all the macro indirection for them on 32-bit and just use
DECLARE_IDTENTRY_RAW and DEFINE_IDTENTRY_RAW directly.

Also add a warning to make sure that we only hit the _kernel paths
in kernel mode.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/9e90a7ee8e72fd757db6d92e1e5ff16339c1ecf9.1593795633.git.luto@kernel.org

---
 arch/x86/include/asm/idtentry.h | 23 +++++++++++++----------
 arch/x86/kernel/cpu/mce/core.c  |  4 +++-
 arch/x86/kernel/traps.c         |  2 +-
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 94333ac..eeac6dc 100644
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
index ce9120c..a6a90b5 100644
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
index c17f9b5..6ed8cc5 100644
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
 
