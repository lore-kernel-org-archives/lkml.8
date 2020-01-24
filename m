Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BA2C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 125AD2081E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392284AbgAXTpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 14:45:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43562 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391381AbgAXTp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 14:45:28 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iv4tP-0000Bu-8i; Fri, 24 Jan 2020 20:45:23 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D62901C1A69;
        Fri, 24 Jan 2020 20:45:22 +0100 (CET)
Date:   Fri, 24 Jan 2020 19:45:22 -0000
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] smp: Use smp_cond_func_t as type for the conditional function
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200117090137.1205765-2-bigeasy@linutronix.de>
References: <20200117090137.1205765-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <157989512266.396.10318209206273887726.tip-bot2@tip-bot2>
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

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     5671d814dbd204b4ecc705045b5f1a647bff6f3b
Gitweb:        https://git.kernel.org/tip/5671d814dbd204b4ecc705045b5f1a647bff6f3b
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 17 Jan 2020 10:01:35 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 24 Jan 2020 20:40:08 +01:00

smp: Use smp_cond_func_t as type for the conditional function

Use a typdef for the conditional function instead defining it each time in
the function prototype.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20200117090137.1205765-2-bigeasy@linutronix.de

---
 include/linux/smp.h | 12 ++++++------
 kernel/smp.c        | 11 +++++------
 kernel/up.c         | 11 +++++------
 3 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index 6fc856c..4734416 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -15,6 +15,7 @@
 #include <linux/llist.h>
 
 typedef void (*smp_call_func_t)(void *info);
+typedef bool (*smp_cond_func_t)(int cpu, void *info);
 struct __call_single_data {
 	struct llist_node llist;
 	smp_call_func_t func;
@@ -49,13 +50,12 @@ void on_each_cpu_mask(const struct cpumask *mask, smp_call_func_t func,
  * cond_func returns a positive value. This may include the local
  * processor.
  */
-void on_each_cpu_cond(bool (*cond_func)(int cpu, void *info),
-		smp_call_func_t func, void *info, bool wait,
-		gfp_t gfp_flags);
+void on_each_cpu_cond(smp_cond_func_t cond_func, smp_call_func_t func,
+		      void *info, bool wait, gfp_t gfp_flags);
 
-void on_each_cpu_cond_mask(bool (*cond_func)(int cpu, void *info),
-		smp_call_func_t func, void *info, bool wait,
-		gfp_t gfp_flags, const struct cpumask *mask);
+void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
+			   void *info, bool wait, gfp_t gfp_flags,
+			   const struct cpumask *mask);
 
 int smp_call_function_single_async(int cpu, call_single_data_t *csd);
 
diff --git a/kernel/smp.c b/kernel/smp.c
index 7dbcb40..c64044d 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -680,9 +680,9 @@ EXPORT_SYMBOL(on_each_cpu_mask);
  * You must not call this function with disabled interrupts or
  * from a hardware interrupt handler or from a bottom half handler.
  */
-void on_each_cpu_cond_mask(bool (*cond_func)(int cpu, void *info),
-			smp_call_func_t func, void *info, bool wait,
-			gfp_t gfp_flags, const struct cpumask *mask)
+void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
+			   void *info, bool wait, gfp_t gfp_flags,
+			   const struct cpumask *mask)
 {
 	cpumask_var_t cpus;
 	int cpu, ret;
@@ -714,9 +714,8 @@ void on_each_cpu_cond_mask(bool (*cond_func)(int cpu, void *info),
 }
 EXPORT_SYMBOL(on_each_cpu_cond_mask);
 
-void on_each_cpu_cond(bool (*cond_func)(int cpu, void *info),
-			smp_call_func_t func, void *info, bool wait,
-			gfp_t gfp_flags)
+void on_each_cpu_cond(smp_cond_func_t cond_func, smp_call_func_t func,
+		      void *info, bool wait, gfp_t gfp_flags)
 {
 	on_each_cpu_cond_mask(cond_func, func, info, wait, gfp_flags,
 				cpu_online_mask);
diff --git a/kernel/up.c b/kernel/up.c
index 862b460..5c0d4f2 100644
--- a/kernel/up.c
+++ b/kernel/up.c
@@ -68,9 +68,9 @@ EXPORT_SYMBOL(on_each_cpu_mask);
  * Preemption is disabled here to make sure the cond_func is called under the
  * same condtions in UP and SMP.
  */
-void on_each_cpu_cond_mask(bool (*cond_func)(int cpu, void *info),
-			   smp_call_func_t func, void *info, bool wait,
-			   gfp_t gfp_flags, const struct cpumask *mask)
+void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
+			   void *info, bool wait, gfp_t gfp_flags,
+			   const struct cpumask *mask)
 {
 	unsigned long flags;
 
@@ -84,9 +84,8 @@ void on_each_cpu_cond_mask(bool (*cond_func)(int cpu, void *info),
 }
 EXPORT_SYMBOL(on_each_cpu_cond_mask);
 
-void on_each_cpu_cond(bool (*cond_func)(int cpu, void *info),
-		      smp_call_func_t func, void *info, bool wait,
-		      gfp_t gfp_flags)
+void on_each_cpu_cond(smp_cond_func_t cond_func, smp_call_func_t func,
+		      void *info, bool wait, gfp_t gfp_flags)
 {
 	on_each_cpu_cond_mask(cond_func, func, info, wait, gfp_flags, NULL);
 }
