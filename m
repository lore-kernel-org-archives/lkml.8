Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB00DC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2F0214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbgAQJBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 04:01:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55035 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbgAQJBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 04:01:47 -0500
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1isNVf-0003eT-Vw; Fri, 17 Jan 2020 10:01:44 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/3] smp: Use smp_cond_func_t as type for the conditional function
Date:   Fri, 17 Jan 2020 10:01:35 +0100
Message-Id: <20200117090137.1205765-2-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200117090137.1205765-1-bigeasy@linutronix.de>
References: <20200117090137.1205765-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a typdef for the conditional function instead defining it each time in
the function prototype.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/smp.h | 12 ++++++------
 kernel/smp.c        | 11 +++++------
 kernel/up.c         | 11 +++++------
 3 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index 6fc856c9eda58..4734416855aad 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -15,6 +15,7 @@
 #include <linux/llist.h>
=20
 typedef void (*smp_call_func_t)(void *info);
+typedef bool (*smp_cond_func_t)(int cpu, void *info);
 struct __call_single_data {
 	struct llist_node llist;
 	smp_call_func_t func;
@@ -49,13 +50,12 @@ void on_each_cpu_mask(const struct cpumask *mask, smp_c=
all_func_t func,
  * cond_func returns a positive value. This may include the local
  * processor.
  */
-void on_each_cpu_cond(bool (*cond_func)(int cpu, void *info),
-		smp_call_func_t func, void *info, bool wait,
-		gfp_t gfp_flags);
+void on_each_cpu_cond(smp_cond_func_t cond_func, smp_call_func_t func,
+		      void *info, bool wait, gfp_t gfp_flags);
=20
-void on_each_cpu_cond_mask(bool (*cond_func)(int cpu, void *info),
-		smp_call_func_t func, void *info, bool wait,
-		gfp_t gfp_flags, const struct cpumask *mask);
+void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
+			   void *info, bool wait, gfp_t gfp_flags,
+			   const struct cpumask *mask);
=20
 int smp_call_function_single_async(int cpu, call_single_data_t *csd);
=20
diff --git a/kernel/smp.c b/kernel/smp.c
index 7dbcb402c2fc0..c64044d68bc62 100644
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
@@ -714,9 +714,8 @@ void on_each_cpu_cond_mask(bool (*cond_func)(int cpu, v=
oid *info),
 }
 EXPORT_SYMBOL(on_each_cpu_cond_mask);
=20
-void on_each_cpu_cond(bool (*cond_func)(int cpu, void *info),
-			smp_call_func_t func, void *info, bool wait,
-			gfp_t gfp_flags)
+void on_each_cpu_cond(smp_cond_func_t cond_func, smp_call_func_t func,
+		      void *info, bool wait, gfp_t gfp_flags)
 {
 	on_each_cpu_cond_mask(cond_func, func, info, wait, gfp_flags,
 				cpu_online_mask);
diff --git a/kernel/up.c b/kernel/up.c
index 862b460ab97a8..5c0d4f2bece22 100644
--- a/kernel/up.c
+++ b/kernel/up.c
@@ -68,9 +68,9 @@ EXPORT_SYMBOL(on_each_cpu_mask);
  * Preemption is disabled here to make sure the cond_func is called under =
the
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
=20
@@ -84,9 +84,8 @@ void on_each_cpu_cond_mask(bool (*cond_func)(int cpu, voi=
d *info),
 }
 EXPORT_SYMBOL(on_each_cpu_cond_mask);
=20
-void on_each_cpu_cond(bool (*cond_func)(int cpu, void *info),
-		      smp_call_func_t func, void *info, bool wait,
-		      gfp_t gfp_flags)
+void on_each_cpu_cond(smp_cond_func_t cond_func, smp_call_func_t func,
+		      void *info, bool wait, gfp_t gfp_flags)
 {
 	on_each_cpu_cond_mask(cond_func, func, info, wait, gfp_flags, NULL);
 }
--=20
2.25.0

