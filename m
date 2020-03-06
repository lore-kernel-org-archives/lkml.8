Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E717DC10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7CB420848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgCFOmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:42:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53735 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgCFOmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:42:08 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAEAu-0006HH-3R; Fri, 06 Mar 2020 15:42:04 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BBCC91C21D3;
        Fri,  6 Mar 2020 15:42:03 +0100 (CET)
Date:   Fri, 06 Mar 2020 14:42:03 -0000
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] thermal/cpu-cooling, sched/core: Move the
 arch_set_thermal_pressure() API to generic scheduler code
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158350572343.28353.7289666129109152780.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     14533a16c46db70b8a75eda8fa633c25ac446d81
Gitweb:        https://git.kernel.org/tip/14533a16c46db70b8a75eda8fa633c25ac446d81
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 06 Mar 2020 14:26:31 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Mar 2020 14:26:31 +01:00

thermal/cpu-cooling, sched/core: Move the arch_set_thermal_pressure() API to generic scheduler code

drivers/base/arch_topology.c is only built if CONFIG_GENERIC_ARCH_TOPOLOGY=y,
resulting in such build failures:

  cpufreq_cooling.c:(.text+0x1e7): undefined reference to `arch_set_thermal_pressure'

Move it to sched/core.c instead, and keep it enabled on x86 despite
us not having a arch_scale_thermal_pressure() facility there, to
build-test this thing.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/base/arch_topology.c | 11 -----------
 kernel/sched/core.c          | 11 +++++++++++
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 68dfa49..6119e11 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -42,17 +42,6 @@ void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
 	per_cpu(cpu_scale, cpu) = capacity;
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
 static ssize_t cpu_capacity_show(struct device *dev,
 				 struct device_attribute *attr,
 				 char *buf)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4d76df3..978bf6f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3576,6 +3576,17 @@ unsigned long long task_sched_runtime(struct task_struct *p)
 	return ns;
 }
 
+DEFINE_PER_CPU(unsigned long, thermal_pressure);
+
+void arch_set_thermal_pressure(struct cpumask *cpus,
+			       unsigned long th_pressure)
+{
+	int cpu;
+
+	for_each_cpu(cpu, cpus)
+		WRITE_ONCE(per_cpu(thermal_pressure, cpu), th_pressure);
+}
+
 /*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
