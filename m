Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56D7C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A462620809
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oMjPiiAK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yW6Czo4J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgG2Odu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbgG2Odl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:33:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074AFC0619D2;
        Wed, 29 Jul 2020 07:33:41 -0700 (PDT)
Date:   Wed, 29 Jul 2020 14:33:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596033219;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sk02ac1kUEoOR/0yIxmnkbHaSkRJBENdZDrwuKFyrzg=;
        b=oMjPiiAKp1/Hiju/Pg7t+AdeMq4HBBjgrThMSM1iRpXmppG8rd/T/Fg7XCgRsc1KNs89wY
        WnJ7nYsrYSjFTwmKgHqB+sYkpHiyMU/wU0aVfPQAJficnnmlK4M2gPadrEUpl+aa4lxh3/
        ikTPI+B5JIyvc9btxqtKOuHLnNR++Bxqm0CyixJYyEQaEUwHRshQkqa/LCjGuQaLwNbNKN
        gIqpxf9lhF2XbdZtbiio0BHKR9aRJfzQtX8nNKdKloQLiDCIqjawQqApZEAqNvhOUy14q7
        Mf2MdlUVDMT8lZwEmBnW2tcM/xLzPxMaAt3zWHcGfoxfZ7Id09zVgB+TF0Y6ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596033219;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sk02ac1kUEoOR/0yIxmnkbHaSkRJBENdZDrwuKFyrzg=;
        b=yW6Czo4J/dxyow0aztIY30e4gCm8Yvh9v+jrB9s1y06gCqb0o/cDWaFpK6HK8AQpVua7AC
        zft4UYBRy/H4jVCg==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Add preemption enabled/disabled assertion APIs
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200720155530.1173732-8-a.darwish@linutronix.de>
References: <20200720155530.1173732-8-a.darwish@linutronix.de>
MIME-Version: 1.0
Message-ID: <159603321858.4006.1242799063290395518.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     8fd8ad5c5dfcb09cf62abadd4043eaf1afbbd0ce
Gitweb:        https://git.kernel.org/tip/8fd8ad5c5dfcb09cf62abadd4043eaf1afbbd0ce
Author:        Ahmed S. Darwish <a.darwish@linutronix.de>
AuthorDate:    Mon, 20 Jul 2020 17:55:13 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Jul 2020 16:14:24 +02:00

lockdep: Add preemption enabled/disabled assertion APIs

Asserting that preemption is enabled or disabled is a critical sanity
check.  Developers are usually reluctant to add such a check in a
fastpath as reading the preemption count can be costly.

Extend the lockdep API with macros asserting that preemption is disabled
or enabled. If lockdep is disabled, or if the underlying architecture
does not support kernel preemption, this assert has no runtime overhead.

References: f54bb2ec02c8 ("locking/lockdep: Add IRQs disabled/enabled assertion APIs: ...")
Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200720155530.1173732-8-a.darwish@linutronix.de
---
 include/linux/lockdep.h | 19 +++++++++++++++++++
 lib/Kconfig.debug       |  1 +
 2 files changed, 20 insertions(+)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 7aafba0..39a3569 100644
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
index 9ad9210..5379931 100644
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
