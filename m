Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21515C433E8
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 22:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F245120825
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 22:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1br0YKtD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q9ANMDWE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733014AbgGVWNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 18:13:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52622 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733151AbgGVWLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 18:11:39 -0400
Message-Id: <20200722220520.602603691@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595455897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dpd5kE6X7ooQe+KkC0bCvi5URXpk00wABkVQ73gC3+4=;
        b=1br0YKtD2Sp3U7zfgd88amj6WFeWgLayanbPtixSRo2GGTdo+j0Sq2nhR5uWIKyS03UX8M
        BSKZPH2BNauMpQ41CzOTidzXTFxxUff0NJzEjv115UO6DIqeKlipMccLWR/T5UOuYsKOv1
        P5IB2vs2SqQNmL3WaKnexda5f9zUm5Mf9Isk5fqHgvk3u9pk9XvIfwb3sjiNr6Sh2uJU2j
        7AQY5AnjEpcSw8sX8nFUO7nRmSHuCYHQakcihoXaHaf+8Jspmw0Z6qZQvqQx0QfZ07xlZq
        KA3aNIHUALHCBewH1ei9eh89F1z7RTTzkzFymrGvCLZUFyPoF5j4TQ0b4xkwpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595455897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dpd5kE6X7ooQe+KkC0bCvi5URXpk00wABkVQ73gC3+4=;
        b=Q9ANMDWECU8OzCefhOOxOCJBQJ5ier57qprIpw8sex0TFcZnB6uQHJyNjZjiHbqy/EUv1j
        eTLG6Qfx2SuVvVDw==
Date:   Thu, 23 Jul 2020 00:00:06 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [patch V5 12/15] x86/entry: Cleanup idtentry_entry/exit_user
References: <20200722215954.464281930@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Cleanup the temporary defines and use irqentry_ instead of idtentry_.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>

---
 arch/x86/include/asm/idtentry.h |    4 ----
 arch/x86/kernel/cpu/mce/core.c  |    4 ++--
 arch/x86/kernel/traps.c         |   18 +++++++++---------
 3 files changed, 11 insertions(+), 15 deletions(-)

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
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1927,11 +1927,11 @@ static __always_inline void exc_machine_
 
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
@@ -901,12 +901,12 @@ static __always_inline void exc_debug_us
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



