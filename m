Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE36CC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A316E22D2C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZecZm1YU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ohg76ZgG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731308AbgGTP4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:56:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58762 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730307AbgGTP4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:56:07 -0400
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595260565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fuyy0zLiX9oqGaNGjgjh+XXT41N87KSvgPNDfMsD0N4=;
        b=ZecZm1YU70HSXnGpMlZe9VTWjCaEHdsnteUyILUtdbVSezQ/LavSa+TajTUy5KRZ9C3onc
        hMDNuKBipOpId9Jil8SHeSTr0qElVmULMjmmkQ+IjmE3pn5Dg0j/K9VTlhchhm9Wl4tXCd
        v22Txi3y+7yNBG9ASOHc4xJ9TR6SJ5agxXBdTEaSlYx8/FynKdBS2KWsOE7Om748qruIak
        py3DwiZwK/fl3WhWeLdLtiYdOyWFDg9kA0cc55hVYMTeKHm7ZxgZrvxddzWIa3XcKbNa3P
        p33KscI4xTzQEmdZKq757dpfWdo8Sc9YHbHYEsdq04rEDZOpYfdnWqRc/iXoxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595260565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fuyy0zLiX9oqGaNGjgjh+XXT41N87KSvgPNDfMsD0N4=;
        b=ohg76ZgGDwrBYFBW0kVzECDbTJf5R9GJy9xLHaOPNpUmMnY4vYlkCahnBj5+50STdHp1Va
        q3TWG4k4jOMYpECQ==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH v4 07/24] lockdep: Add preemption enabled/disabled assertion APIs
Date:   Mon, 20 Jul 2020 17:55:13 +0200
Message-Id: <20200720155530.1173732-8-a.darwish@linutronix.de>
In-Reply-To: <20200720155530.1173732-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200720155530.1173732-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Asserting that preemption is enabled or disabled is a critical sanity
check.  Developers are usually reluctant to add such a check in a
fastpath as reading the preemption count can be costly.

Extend the lockdep API with macros asserting that preemption is disabled
or enabled. If lockdep is disabled, or if the underlying architecture
does not support kernel preemption, this assert has no runtime overhead.

References: f54bb2ec02c8 ("locking/lockdep: Add IRQs disabled/enabled assertion APIs: ...")
Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 include/linux/lockdep.h | 19 +++++++++++++++++++
 lib/Kconfig.debug       |  1 +
 2 files changed, 20 insertions(+)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 7aafba0ddcf9..39a35699d0d6 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -549,6 +549,22 @@ do {									\
 	WARN_ON_ONCE(debug_locks && !this_cpu_read(hardirq_context));	\
 } while (0)
 
+#define lockdep_assert_preemption_enabled()				\
+do {									\
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
+		     debug_locks			&&		\
+		     (preempt_count() != 0		||		\
+		      !this_cpu_read(hardirqs_enabled)));		\
+} while (0)
+
+#define lockdep_assert_preemption_disabled()				\
+do {									\
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
+		     debug_locks			&&		\
+		     (preempt_count() == 0		&&		\
+		      this_cpu_read(hardirqs_enabled)));		\
+} while (0)
+
 #else
 # define might_lock(lock) do { } while (0)
 # define might_lock_read(lock) do { } while (0)
@@ -557,6 +573,9 @@ do {									\
 # define lockdep_assert_irqs_enabled() do { } while (0)
 # define lockdep_assert_irqs_disabled() do { } while (0)
 # define lockdep_assert_in_irq() do { } while (0)
+
+# define lockdep_assert_preemption_enabled() do { } while (0)
+# define lockdep_assert_preemption_disabled() do { } while (0)
 #endif
 
 #ifdef CONFIG_PROVE_RAW_LOCK_NESTING
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 9ad9210d70a1..5379931ba3b5 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1117,6 +1117,7 @@ config PROVE_LOCKING
 	select DEBUG_RWSEMS
 	select DEBUG_WW_MUTEX_SLOWPATH
 	select DEBUG_LOCK_ALLOC
+	select PREEMPT_COUNT if !ARCH_NO_PREEMPT
 	select TRACE_IRQFLAGS
 	default n
 	help
-- 
2.20.1

