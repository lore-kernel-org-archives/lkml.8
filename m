Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4340C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5CF520775
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbgCYMGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:06:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47761 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbgCYMGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:06:14 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jH4nQ-0000mc-Tw; Wed, 25 Mar 2020 13:06:09 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4CF3D1C0493;
        Wed, 25 Mar 2020 13:06:07 +0100 (CET)
Date:   Wed, 25 Mar 2020 12:06:06 -0000
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu/hotplug: Create a new function to shutdown nonboot cpus
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200323135110.30522-3-qais.yousef@arm.com>
References: <20200323135110.30522-3-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <158513796687.28353.802984004704044880.tip-bot2@tip-bot2>
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

Commit-ID:     0441a5597c5d02ed7abed1d989eaaa1595dedac5
Gitweb:        https://git.kernel.org/tip/0441a5597c5d02ed7abed1d989eaaa1595dedac5
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Mon, 23 Mar 2020 13:50:55 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 25 Mar 2020 12:59:31 +01:00

cpu/hotplug: Create a new function to shutdown nonboot cpus

This function will be used later in machine_shutdown() for some
architectures.

disable_nonboot_cpus() is not safe to use when doing machine_down(),
because it relies on freeze_secondary_cpus() which in turn is a
suspend/resume related freeze and could abort if the logic detects any
pending activities that can prevent finishing the offlining process.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200323135110.30522-3-qais.yousef@arm.com

---
 include/linux/cpu.h |  2 ++
 kernel/cpu.c        | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index cf8cf38..64a246e 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -120,6 +120,7 @@ extern void cpu_hotplug_enable(void);
 void clear_tasks_mm_cpumask(int cpu);
 int cpu_down(unsigned int cpu);
 int remove_cpu(unsigned int cpu);
+extern void smp_shutdown_nonboot_cpus(unsigned int primary_cpu);
 
 #else /* CONFIG_HOTPLUG_CPU */
 
@@ -131,6 +132,7 @@ static inline int  cpus_read_trylock(void) { return true; }
 static inline void lockdep_assert_cpus_held(void) { }
 static inline void cpu_hotplug_disable(void) { }
 static inline void cpu_hotplug_enable(void) { }
+static inline void smp_shutdown_nonboot_cpus(unsigned int primary_cpu) { }
 #endif	/* !CONFIG_HOTPLUG_CPU */
 
 /* Wrappers which go away once all code is converted */
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 069802f..03c7271 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1069,6 +1069,48 @@ int remove_cpu(unsigned int cpu)
 }
 EXPORT_SYMBOL_GPL(remove_cpu);
 
+void smp_shutdown_nonboot_cpus(unsigned int primary_cpu)
+{
+	unsigned int cpu;
+	int error;
+
+	cpu_maps_update_begin();
+
+	/*
+	 * Make certain the cpu I'm about to reboot on is online.
+	 *
+	 * This is inline to what migrate_to_reboot_cpu() already do.
+	 */
+	if (!cpu_online(primary_cpu))
+		primary_cpu = cpumask_first(cpu_online_mask);
+
+	for_each_online_cpu(cpu) {
+		if (cpu == primary_cpu)
+			continue;
+
+		error = cpu_down_maps_locked(cpu, CPUHP_OFFLINE);
+		if (error) {
+			pr_err("Failed to offline CPU%d - error=%d",
+				cpu, error);
+			break;
+		}
+	}
+
+	/*
+	 * Ensure all but the reboot CPU are offline.
+	 */
+	BUG_ON(num_online_cpus() > 1);
+
+	/*
+	 * Make sure the CPUs won't be enabled by someone else after this
+	 * point. Kexec will reboot to a new kernel shortly resetting
+	 * everything along the way.
+	 */
+	cpu_hotplug_disabled++;
+
+	cpu_maps_update_done();
+}
+
 #else
 #define takedown_cpu		NULL
 #endif /*CONFIG_HOTPLUG_CPU*/
