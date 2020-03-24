Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14C3C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 809172080C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbgCXJLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:11:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43733 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgCXJLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:11:01 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfaL-0007UH-EL; Tue, 24 Mar 2020 10:10:57 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 255451C0470;
        Tue, 24 Mar 2020 10:10:56 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:10:55 -0000
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] kcsan: Expose core configuration parameters as
 module params
Cc:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Qian Cai <cai@lca.pw>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504105584.28353.8955768768073810246.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/kcsan branch of tip:

Commit-ID:     80d4c4775216602ccdc9e761ce251c8451d0c6ca
Gitweb:        https://git.kernel.org/tip/80d4c4775216602ccdc9e761ce251c8451d0c6ca
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 07 Feb 2020 19:59:10 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 21 Mar 2020 09:43:35 +01:00

kcsan: Expose core configuration parameters as module params

This adds early_boot, udelay_{task,interrupt}, and skip_watch as module
params. The latter parameters are useful to modify at runtime to tune
KCSAN's performance on new systems. This will also permit auto-tuning
these parameters to maximize overall system performance and KCSAN's race
detection ability.

None of the parameters are used in the fast-path and referring to them
via static variables instead of CONFIG constants will not affect
performance.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Qian Cai <cai@lca.pw>
---
 kernel/kcsan/core.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 87ef01e..498b1eb 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -6,6 +6,7 @@
 #include <linux/export.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/moduleparam.h>
 #include <linux/percpu.h>
 #include <linux/preempt.h>
 #include <linux/random.h>
@@ -16,6 +17,20 @@
 #include "encoding.h"
 #include "kcsan.h"
 
+static bool kcsan_early_enable = IS_ENABLED(CONFIG_KCSAN_EARLY_ENABLE);
+static unsigned int kcsan_udelay_task = CONFIG_KCSAN_UDELAY_TASK;
+static unsigned int kcsan_udelay_interrupt = CONFIG_KCSAN_UDELAY_INTERRUPT;
+static long kcsan_skip_watch = CONFIG_KCSAN_SKIP_WATCH;
+
+#ifdef MODULE_PARAM_PREFIX
+#undef MODULE_PARAM_PREFIX
+#endif
+#define MODULE_PARAM_PREFIX "kcsan."
+module_param_named(early_enable, kcsan_early_enable, bool, 0);
+module_param_named(udelay_task, kcsan_udelay_task, uint, 0644);
+module_param_named(udelay_interrupt, kcsan_udelay_interrupt, uint, 0644);
+module_param_named(skip_watch, kcsan_skip_watch, long, 0644);
+
 bool kcsan_enabled;
 
 /* Per-CPU kcsan_ctx for interrupts */
@@ -239,9 +254,9 @@ should_watch(const volatile void *ptr, size_t size, int type)
 
 static inline void reset_kcsan_skip(void)
 {
-	long skip_count = CONFIG_KCSAN_SKIP_WATCH -
+	long skip_count = kcsan_skip_watch -
 			  (IS_ENABLED(CONFIG_KCSAN_SKIP_WATCH_RANDOMIZE) ?
-				   prandom_u32_max(CONFIG_KCSAN_SKIP_WATCH) :
+				   prandom_u32_max(kcsan_skip_watch) :
 				   0);
 	this_cpu_write(kcsan_skip, skip_count);
 }
@@ -253,8 +268,7 @@ static __always_inline bool kcsan_is_enabled(void)
 
 static inline unsigned int get_delay(void)
 {
-	unsigned int delay = in_task() ? CONFIG_KCSAN_UDELAY_TASK :
-					 CONFIG_KCSAN_UDELAY_INTERRUPT;
+	unsigned int delay = in_task() ? kcsan_udelay_task : kcsan_udelay_interrupt;
 	return delay - (IS_ENABLED(CONFIG_KCSAN_DELAY_RANDOMIZE) ?
 				prandom_u32_max(delay) :
 				0);
@@ -527,7 +541,7 @@ void __init kcsan_init(void)
 	 * We are in the init task, and no other tasks should be running;
 	 * WRITE_ONCE without memory barrier is sufficient.
 	 */
-	if (IS_ENABLED(CONFIG_KCSAN_EARLY_ENABLE))
+	if (kcsan_early_enable)
 		WRITE_ONCE(kcsan_enabled, true);
 }
 
