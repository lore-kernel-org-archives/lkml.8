Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07257C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5702084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbgCFOnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:43:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53852 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbgCFOmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:42:23 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAEB7-0006Oo-Ft; Fri, 06 Mar 2020 15:42:17 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C94C01C21D6;
        Fri,  6 Mar 2020 15:42:10 +0100 (CET)
Date:   Fri, 06 Mar 2020 14:42:10 -0000
From:   "tip-bot2 for Thara Gopinath" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] drivers/base/arch_topology: Add infrastructure to
 store and update instantaneous thermal pressure
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200222005213.3873-4-thara.gopinath@linaro.org>
References: <20200222005213.3873-4-thara.gopinath@linaro.org>
MIME-Version: 1.0
Message-ID: <158350573056.28353.8289359977043719899.tip-bot2@tip-bot2>
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

Commit-ID:     ad58cc5cc50ca8423cf630778594bd38252a0a58
Gitweb:        https://git.kernel.org/tip/ad58cc5cc50ca8423cf630778594bd38252a0a58
Author:        Thara Gopinath <thara.gopinath@linaro.org>
AuthorDate:    Fri, 21 Feb 2020 19:52:07 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Mar 2020 12:57:18 +01:00

drivers/base/arch_topology: Add infrastructure to store and update instantaneous thermal pressure

Add architecture specific APIs to update and track thermal pressure on a
per CPU basis. A per CPU variable thermal_pressure is introduced to keep
track of instantaneous per CPU thermal pressure. Thermal pressure is the
delta between maximum capacity and capped capacity due to a thermal event.

topology_get_thermal_pressure can be hooked into the scheduler specified
arch_scale_thermal_pressure to retrieve instantaneous thermal pressure of
a CPU.

arch_set_thermal_pressure can be used to update the thermal pressure.

Considering topology_get_thermal_pressure reads thermal_pressure and
arch_set_thermal_pressure writes into thermal_pressure, one can argue for
some sort of locking mechanism to avoid a stale value.  But considering
topology_get_thermal_pressure can be called from a system critical path
like scheduler tick function, a locking mechanism is not ideal. This means
that it is possible the thermal_pressure value used to calculate average
thermal pressure for a CPU can be stale for up to 1 tick period.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200222005213.3873-4-thara.gopinath@linaro.org
---
 drivers/base/arch_topology.c  | 11 +++++++++++
 include/linux/arch_topology.h | 10 ++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 6119e11..68dfa49 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -42,6 +42,17 @@ void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
 	per_cpu(cpu_scale, cpu) = capacity;
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
 static ssize_t cpu_capacity_show(struct device *dev,
 				 struct device_attribute *attr,
 				 char *buf)
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 3015ecb..88a115e 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -33,6 +33,16 @@ unsigned long topology_get_freq_scale(int cpu)
 	return per_cpu(freq_scale, cpu);
 }
 
+DECLARE_PER_CPU(unsigned long, thermal_pressure);
+
+static inline unsigned long topology_get_thermal_pressure(int cpu)
+{
+	return per_cpu(thermal_pressure, cpu);
+}
+
+void arch_set_thermal_pressure(struct cpumask *cpus,
+			       unsigned long th_pressure);
+
 struct cpu_topology {
 	int thread_id;
 	int core_id;
