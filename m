Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9B7C433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B44DF2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yKQYnbUo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/a2VRuWx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgGXULt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:11:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40240 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbgGXULr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 16:11:47 -0400
Date:   Fri, 24 Jul 2020 20:11:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595621505;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IP0/hed2W78uX1TRwJb5Lnp2g6mc4UkZeLsEU+jkebc=;
        b=yKQYnbUoy8I/9rrqjnpR+URyIJcRI9TxiR2OTu59Sd9QdfVU3WZsbLDXbX6UyhqJ8+80GN
        tWTDV/Kap2XB3Vt4gL0urXYZAP9ee6zihXjLYQY5T+WlOXQ6u4ggO2Jj8+ECDjRCPel6A0
        IaL6OHDZerd2ti/VdPzuOv6iiFhI8UIDQr6Q2vLyYZW27xaj7uRQVVXUYhbjjDLnJ4GlhT
        rv8w2v6N3sXzt3a99sNPxXWwaCCTuAK/GmcSfet9TdCitRJuvx/ZBihnP+3poK9vmu1X4j
        V8QR5vrTGVgvZzVUsw21TMjEEbHRynC0SuXn+mLKH/tsJBmQcXPH0qpG5hPBtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595621505;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IP0/hed2W78uX1TRwJb5Lnp2g6mc4UkZeLsEU+jkebc=;
        b=/a2VRuWxAkukiu/a8BVMEbiOnsQAC6mSFLHmSOAa6OcyQ3pzywENO9sM5cfSiKpBR1SDNc
        kcNrSL03YhEp3RBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Cleanup idtentry_entry/exit_user
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200722220520.602603691@linutronix.de>
References: <20200722220520.602603691@linutronix.de>
MIME-Version: 1.0
Message-ID: <159562149954.4006.17009643242712200704.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     517e499227bed34acc69166691e2db5df3dc859a
Gitweb:        https://git.kernel.org/tip/517e499227bed34acc69166691e2db5df3dc859a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 23 Jul 2020 00:00:06 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 24 Jul 2020 15:05:00 +02:00

x86/entry: Cleanup idtentry_entry/exit_user

Cleanup the temporary defines and use irqentry_ instead of idtentry_.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20200722220520.602603691@linutronix.de


---
 arch/x86/include/asm/idtentry.h |  4 ----
 arch/x86/kernel/cpu/mce/core.c  |  4 ++--
 arch/x86/kernel/traps.c         | 18 +++++++++---------
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index f7d48ea..bf59f72 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -11,10 +11,6 @@
 
 #include <asm/irq_stack.h>
 
-/* Temporary define */
-#define idtentry_enter_user	irqentry_enter_from_user_mode
-#define idtentry_exit_user	irqentry_exit_to_user_mode
-
 typedef struct idtentry_state {
 	bool exit_rcu;
 } idtentry_state_t;
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 6d7aa56..97ff831 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1927,11 +1927,11 @@ static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 
 static __always_inline void exc_machine_check_user(struct pt_regs *regs)
 {
-	idtentry_enter_user(regs);
+	irqentry_enter_from_user_mode(regs);
 	instrumentation_begin();
 	machine_check_vector(regs);
 	instrumentation_end();
-	idtentry_exit_user(regs);
+	irqentry_exit_to_user_mode(regs);
 }
 
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index ab6828e..59c7f54 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -638,18 +638,18 @@ DEFINE_IDTENTRY_RAW(exc_int3)
 		return;
 
 	/*
-	 * idtentry_enter_user() uses static_branch_{,un}likely() and therefore
-	 * can trigger INT3, hence poke_int3_handler() must be done
-	 * before. If the entry came from kernel mode, then use nmi_enter()
-	 * because the INT3 could have been hit in any context including
-	 * NMI.
+	 * irqentry_enter_from_user_mode() uses static_branch_{,un}likely()
+	 * and therefore can trigger INT3, hence poke_int3_handler() must
+	 * be done before. If the entry came from kernel mode, then use
+	 * nmi_enter() because the INT3 could have been hit in any context
+	 * including NMI.
 	 */
 	if (user_mode(regs)) {
-		idtentry_enter_user(regs);
+		irqentry_enter_from_user_mode(regs);
 		instrumentation_begin();
 		do_int3_user(regs);
 		instrumentation_end();
-		idtentry_exit_user(regs);
+		irqentry_exit_to_user_mode(regs);
 	} else {
 		nmi_enter();
 		instrumentation_begin();
@@ -901,12 +901,12 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
 	 */
 	WARN_ON_ONCE(!user_mode(regs));
 
-	idtentry_enter_user(regs);
+	irqentry_enter_from_user_mode(regs);
 	instrumentation_begin();
 
 	handle_debug(regs, dr6, true);
 	instrumentation_end();
-	idtentry_exit_user(regs);
+	irqentry_exit_to_user_mode(regs);
 }
 
 #ifdef CONFIG_X86_64
