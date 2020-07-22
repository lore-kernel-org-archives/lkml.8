Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B53C433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46F1220729
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vnh57tWg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lm8y/PJY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731375AbgGVJMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:12:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46924 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730142AbgGVJM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:12:28 -0400
Date:   Wed, 22 Jul 2020 09:12:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595409145;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XVQwDcSePUGqdkFK4ivv4pVpe7VrBDD+pGmQdZPAL0Y=;
        b=Vnh57tWgeBWWZLIyPVjWxrcc1tD3BLiMlAZckeq6sxYm9H3SFJFl7qt3Uti9uL5U8+otYH
        xcy8xIfDi8bQMCj6tNo1eNWxUjXlrwhj6KAZ0S+5f5b53pFJ4kkijEcKwpQdeeU/ud8tB/
        Zv5YqUnt2+vp4IjES9V2OtAtwH1tNZMoysFaM5l7+py3hhpm8neZ46Wi6hoATAI3EXfJl7
        gVQCa820s+ARz0QFWNYUIgOURvc8Dp15O34QWNdBuJ5u+kMNGbWo44jF34SKyNy52dwLKn
        U1NAR1yxDdM21DyfcjDjkWpi3mvIb0blVPL2nFhGpa/n3mZfC1e/prQa3Y5Hqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595409145;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XVQwDcSePUGqdkFK4ivv4pVpe7VrBDD+pGmQdZPAL0Y=;
        b=lm8y/PJYHz1QT3NXWLfl/0lhbQKZSt7cuokLiEDVUotfuQAaFr3boxXrOaqVPDIFKDc1jS
        lmAPS8NbIzzUMdAQ==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] arch_topology, sched/core: Cleanup thermal pressure
 definition
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200712165917.9168-2-valentin.schneider@arm.com>
References: <20200712165917.9168-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <159540914474.4006.8827205336223266532.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     25980c7a79af42f2daa73e2f475ebf4cbac8253e
Gitweb:        https://git.kernel.org/tip/25980c7a79af42f2daa73e2f475ebf4cbac8253e
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Sun, 12 Jul 2020 17:59:15 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Jul 2020 10:22:05 +02:00

arch_topology, sched/core: Cleanup thermal pressure definition

The following commit:

  14533a16c46d ("thermal/cpu-cooling, sched/core: Move the arch_set_thermal_pressure() API to generic scheduler code")

moved the definition of arch_set_thermal_pressure() to sched/core.c, but
kept its declaration in linux/arch_topology.h. When building e.g. an x86
kernel with CONFIG_SCHED_THERMAL_PRESSURE=y, cpufreq_cooling.c ends up
getting the declaration of arch_set_thermal_pressure() from
include/linux/arch_topology.h, which is somewhat awkward.

On top of this, sched/core.c unconditionally defines
o The thermal_pressure percpu variable
o arch_set_thermal_pressure()

while arch_scale_thermal_pressure() does nothing unless redefined by the
architecture.

arch_*() functions are meant to be defined by architectures, so revert the
aforementioned commit and re-implement it in a way that keeps
arch_set_thermal_pressure() architecture-definable, and doesn't define the
thermal pressure percpu variable for kernels that don't need
it (CONFIG_SCHED_THERMAL_PRESSURE=n).

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200712165917.9168-2-valentin.schneider@arm.com
---
 arch/arm/include/asm/topology.h   |  3 ++-
 arch/arm64/include/asm/topology.h |  3 ++-
 drivers/base/arch_topology.c      | 11 +++++++++++
 include/linux/arch_topology.h     |  4 ++--
 include/linux/sched/topology.h    |  7 +++++++
 kernel/sched/core.c               | 11 -----------
 6 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
index 435aba2..e0593cf 100644
--- a/arch/arm/include/asm/topology.h
+++ b/arch/arm/include/asm/topology.h
@@ -16,8 +16,9 @@
 /* Enable topology flag updates */
 #define arch_update_cpu_topology topology_update_cpu_topology
 
-/* Replace task scheduler's default thermal pressure retrieve API */
+/* Replace task scheduler's default thermal pressure API */
 #define arch_scale_thermal_pressure topology_get_thermal_pressure
+#define arch_set_thermal_pressure   topology_set_thermal_pressure
 
 #else
 
diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index 0cc835d..e042f65 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -34,8 +34,9 @@ void topology_scale_freq_tick(void);
 /* Enable topology flag updates */
 #define arch_update_cpu_topology topology_update_cpu_topology
 
-/* Replace task scheduler's default thermal pressure retrieve API */
+/* Replace task scheduler's default thermal pressure API */
 #define arch_scale_thermal_pressure topology_get_thermal_pressure
+#define arch_set_thermal_pressure   topology_set_thermal_pressure
 
 #include <asm-generic/topology.h>
 
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 4d0a003..75f72d6 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -54,6 +54,17 @@ void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
 	per_cpu(cpu_scale, cpu) = capacity;
 }
 
+DEFINE_PER_CPU(unsigned long, thermal_pressure);
+
+void topology_set_thermal_pressure(const struct cpumask *cpus,
+			       unsigned long th_pressure)
+{
+	int cpu;
+
+	for_each_cpu(cpu, cpus)
+		WRITE_ONCE(per_cpu(thermal_pressure, cpu), th_pressure);
+}
+
 static ssize_t cpu_capacity_show(struct device *dev,
 				 struct device_attribute *attr,
 				 char *buf)
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 0566cb3..69b1dab 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -39,8 +39,8 @@ static inline unsigned long topology_get_thermal_pressure(int cpu)
 	return per_cpu(thermal_pressure, cpu);
 }
 
-void arch_set_thermal_pressure(struct cpumask *cpus,
-			       unsigned long th_pressure);
+void topology_set_thermal_pressure(const struct cpumask *cpus,
+				   unsigned long th_pressure);
 
 struct cpu_topology {
 	int thread_id;
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index fb11091..764222d 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -232,6 +232,13 @@ unsigned long arch_scale_thermal_pressure(int cpu)
 }
 #endif
 
+#ifndef arch_set_thermal_pressure
+static __always_inline
+void arch_set_thermal_pressure(const struct cpumask *cpus,
+			       unsigned long th_pressure)
+{ }
+#endif
+
 static inline int task_node(const struct task_struct *p)
 {
 	return cpu_to_node(task_cpu(p));
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 12db8fb..bd8e521 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3869,17 +3869,6 @@ unsigned long long task_sched_runtime(struct task_struct *p)
 	return ns;
 }
 
-DEFINE_PER_CPU(unsigned long, thermal_pressure);
-
-void arch_set_thermal_pressure(struct cpumask *cpus,
-			       unsigned long th_pressure)
-{
-	int cpu;
-
-	for_each_cpu(cpu, cpus)
-		WRITE_ONCE(per_cpu(thermal_pressure, cpu), th_pressure);
-}
-
 /*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
