Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5ECC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23DB820792
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="05iOnWjC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V2Q40SMX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbgG1KuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728509AbgG1KuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:50:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBECC061794;
        Tue, 28 Jul 2020 03:50:12 -0700 (PDT)
Date:   Tue, 28 Jul 2020 10:50:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595933411;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0tYhVoC7epx/fRI2pLLsHuaQMB3FPLG3V0ApogBQZWU=;
        b=05iOnWjCA13O7wHHMKemiKKMSpqaGsCGyFTnttjQt54zS/mgh4d2LB2hXVVe05vDz0pyKP
        34FARe3WQgw2gR5oIJwddHzzrLVj1owdS2rVVWE0XHpO87eMC6cpFin7uIU7olC0R/bOWk
        Ii7m7BipO+vZDytdFasVX95L21VnMaodlje3K6Ws4qr3idLbZqvMracT9v6wn6E4sMptRu
        IefELCPOh9ZVPoNnpRfVknSACeYeK0YA7m5eAy3tE5QBSsRU7PyPPlRrWFGPUJhtfB5Ph2
        qMPkzmL4X5E52Cmn7Pig7lH6Chuq+yoL8Sh56KDMRFaLxxD6M55LXa+ACJowuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595933411;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0tYhVoC7epx/fRI2pLLsHuaQMB3FPLG3V0ApogBQZWU=;
        b=V2Q40SMXvRZ1IvQcvlPMbDCopTUwySy8I668C8TTGFqCl+M+PkEfvNk0R15srLGuoI8ZDD
        0WFot4y1BBAXjmAA==
From:   "tip-bot2 for peterz@infradead.org" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/nmi] locking/lockdep: Fix TRACE_IRQFLAGS vs. NMIs
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200727124852.GK119549@hirez.programming.kicks-ass.net>
References: <20200727124852.GK119549@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <159593340996.4006.11350923667085911342.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/nmi branch of tip:

Commit-ID:     ed00495333ccc80fc8fb86fb43773c3c2a499466
Gitweb:        https://git.kernel.org/tip/ed00495333ccc80fc8fb86fb43773c3c2a499466
Author:        peterz@infradead.org <peterz@infradead.org>
AuthorDate:    Mon, 27 Jul 2020 14:48:52 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 27 Jul 2020 15:13:29 +02:00

locking/lockdep: Fix TRACE_IRQFLAGS vs. NMIs

Prior to commit:

  859d069ee1dd ("lockdep: Prepare for NMI IRQ state tracking")

IRQ state tracking was disabled in NMIs due to nmi_enter()
doing lockdep_off() -- with the obvious requirement that NMI entry
call nmi_enter() before trace_hardirqs_off().

[ AFAICT, PowerPC and SH violate this order on their NMI entry ]

However, that commit explicitly changed lockdep_hardirqs_*() to ignore
lockdep_off() and breaks every architecture that has irq-tracing in
it's NMI entry that hasn't been fixed up (x86 being the only fixed one
at this point).

The reason for this change is that by ignoring lockdep_off() we can:

  - get rid of 'current->lockdep_recursion' in lockdep_assert_irqs*()
    which was going to to give header-recursion issues with the
    seqlock rework.

  - allow these lockdep_assert_*() macros to function in NMI context.

Restore the previous state of things and allow an architecture to
opt-in to the NMI IRQ tracking support, however instead of relying on
lockdep_off(), rely on in_nmi(), both are part of nmi_enter() and so
over-all entry ordering doesn't need to change.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200727124852.GK119549@hirez.programming.kicks-ass.net
---
 arch/x86/Kconfig.debug   | 3 +++
 kernel/locking/lockdep.c | 8 +++++++-
 lib/Kconfig.debug        | 6 ++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 0dd319e..ee1d3c5 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -3,6 +3,9 @@
 config TRACE_IRQFLAGS_SUPPORT
 	def_bool y
 
+config TRACE_IRQFLAGS_NMI_SUPPORT
+	def_bool y
+
 config EARLY_PRINTK_USB
 	bool
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index d595623..8b0b28b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3712,6 +3712,9 @@ void noinstr lockdep_hardirqs_on(unsigned long ip)
 	 * and not rely on hardware state like normal interrupts.
 	 */
 	if (unlikely(in_nmi())) {
+		if (!IS_ENABLED(CONFIG_TRACE_IRQFLAGS_NMI))
+			return;
+
 		/*
 		 * Skip:
 		 *  - recursion check, because NMI can hit lockdep;
@@ -3773,7 +3776,10 @@ void noinstr lockdep_hardirqs_off(unsigned long ip)
 	 * they will restore the software state. This ensures the software
 	 * state is consistent inside NMIs as well.
 	 */
-	if (unlikely(!in_nmi() && (current->lockdep_recursion & LOCKDEP_RECURSION_MASK)))
+	if (in_nmi()) {
+		if (!IS_ENABLED(CONFIG_TRACE_IRQFLAGS_NMI))
+			return;
+	} else if (current->lockdep_recursion & LOCKDEP_RECURSION_MASK)
 		return;
 
 	/*
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 9ad9210..fa964b5 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1325,11 +1325,17 @@ config WW_MUTEX_SELFTEST
 endmenu # lock debugging
 
 config TRACE_IRQFLAGS
+	depends on TRACE_IRQFLAGS_SUPPORT
 	bool
 	help
 	  Enables hooks to interrupt enabling and disabling for
 	  either tracing or lock debugging.
 
+config TRACE_IRQFLAGS_NMI
+	def_bool y
+	depends on TRACE_IRQFLAGS
+	depends on TRACE_IRQFLAGS_NMI_SUPPORT
+
 config STACKTRACE
 	bool "Stack backtrace support"
 	depends on STACKTRACE_SUPPORT
