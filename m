Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83046C54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B1D20772
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbgCYMGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:06:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47713 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgCYMGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:06:06 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jH4nI-0000ho-Rj; Wed, 25 Mar 2020 13:06:01 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 63F641C0450;
        Wed, 25 Mar 2020 13:06:00 +0100 (CET)
Date:   Wed, 25 Mar 2020 12:05:59 -0000
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu/hotplug: Hide cpu_up/down()
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200323135110.30522-18-qais.yousef@arm.com>
References: <20200323135110.30522-18-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <158513795997.28353.5521691179310825679.tip-bot2@tip-bot2>
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

Commit-ID:     33c3736ec88811b9b6f6ce2cc8967f6b97c3db5e
Gitweb:        https://git.kernel.org/tip/33c3736ec88811b9b6f6ce2cc8967f6b97c3db5e
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Mon, 23 Mar 2020 13:51:10 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 25 Mar 2020 12:59:38 +01:00

cpu/hotplug: Hide cpu_up/down()

Use separate functions for the device core to bring a CPU up and down.

Users outside the device core must use add/remove_cpu() which will take
care of extra housekeeping work like keeping sysfs in sync.

Make cpu_up/down() static and replace the extra layer of indirection.

[ tglx: Removed the extra wrapper functions and adjusted function names ]

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200323135110.30522-18-qais.yousef@arm.com
---
 drivers/base/cpu.c  |  4 ++--
 include/linux/cpu.h |  4 ++--
 kernel/cpu.c        | 42 ++++++++++++++++++++++++++++--------------
 3 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 6265871..b93a8f8 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -55,7 +55,7 @@ static int cpu_subsys_online(struct device *dev)
 	if (from_nid == NUMA_NO_NODE)
 		return -ENODEV;
 
-	ret = cpu_up(cpuid);
+	ret = cpu_device_up(dev);
 	/*
 	 * When hot adding memory to memoryless node and enabling a cpu
 	 * on the node, node number of the cpu may internally change.
@@ -69,7 +69,7 @@ static int cpu_subsys_online(struct device *dev)
 
 static int cpu_subsys_offline(struct device *dev)
 {
-	return cpu_down(dev->id);
+	return cpu_device_down(dev);
 }
 
 void unregister_cpu(struct cpu *cpu)
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 8b295f7..9ead281 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -88,8 +88,8 @@ extern ssize_t arch_cpu_release(const char *, size_t);
 
 #ifdef CONFIG_SMP
 extern bool cpuhp_tasks_frozen;
-int cpu_up(unsigned int cpu);
 int add_cpu(unsigned int cpu);
+int cpu_device_up(struct device *dev);
 void notify_cpu_starting(unsigned int cpu);
 extern void cpu_maps_update_begin(void);
 extern void cpu_maps_update_done(void);
@@ -120,8 +120,8 @@ extern void lockdep_assert_cpus_held(void);
 extern void cpu_hotplug_disable(void);
 extern void cpu_hotplug_enable(void);
 void clear_tasks_mm_cpumask(int cpu);
-int cpu_down(unsigned int cpu);
 int remove_cpu(unsigned int cpu);
+int cpu_device_down(struct device *dev);
 extern void smp_shutdown_nonboot_cpus(unsigned int primary_cpu);
 
 #else /* CONFIG_HOTPLUG_CPU */
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 4783d81..3084849 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1041,7 +1041,7 @@ static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
 	return _cpu_down(cpu, 0, target);
 }
 
-static int do_cpu_down(unsigned int cpu, enum cpuhp_state target)
+static int cpu_down(unsigned int cpu, enum cpuhp_state target)
 {
 	int err;
 
@@ -1051,11 +1051,18 @@ static int do_cpu_down(unsigned int cpu, enum cpuhp_state target)
 	return err;
 }
 
-int cpu_down(unsigned int cpu)
+/**
+ * cpu_device_down - Bring down a cpu device
+ * @dev: Pointer to the cpu device to offline
+ *
+ * This function is meant to be used by device core cpu subsystem only.
+ *
+ * Other subsystems should use remove_cpu() instead.
+ */
+int cpu_device_down(struct device *dev)
 {
-	return do_cpu_down(cpu, CPUHP_OFFLINE);
+	return cpu_down(dev->id, CPUHP_OFFLINE);
 }
-EXPORT_SYMBOL(cpu_down);
 
 int remove_cpu(unsigned int cpu)
 {
@@ -1178,8 +1185,8 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
 	}
 
 	/*
-	 * The caller of do_cpu_up might have raced with another
-	 * caller. Ignore it for now.
+	 * The caller of cpu_up() might have raced with another
+	 * caller. Nothing to do.
 	 */
 	if (st->state >= target)
 		goto out;
@@ -1223,7 +1230,7 @@ out:
 	return ret;
 }
 
-static int do_cpu_up(unsigned int cpu, enum cpuhp_state target)
+static int cpu_up(unsigned int cpu, enum cpuhp_state target)
 {
 	int err = 0;
 
@@ -1257,11 +1264,18 @@ out:
 	return err;
 }
 
-int cpu_up(unsigned int cpu)
+/**
+ * cpu_device_up - Bring up a cpu device
+ * @dev: Pointer to the cpu device to online
+ *
+ * This function is meant to be used by device core cpu subsystem only.
+ *
+ * Other subsystems should use add_cpu() instead.
+ */
+int cpu_device_up(struct device *dev)
 {
-	return do_cpu_up(cpu, CPUHP_ONLINE);
+	return cpu_up(dev->id, CPUHP_ONLINE);
 }
-EXPORT_SYMBOL_GPL(cpu_up);
 
 int add_cpu(unsigned int cpu)
 {
@@ -1289,7 +1303,7 @@ int bringup_hibernate_cpu(unsigned int sleep_cpu)
 
 	if (!cpu_online(sleep_cpu)) {
 		pr_info("Hibernated on a CPU that is offline! Bringing CPU up.\n");
-		ret = cpu_up(sleep_cpu);
+		ret = cpu_up(sleep_cpu, CPUHP_ONLINE);
 		if (ret) {
 			pr_err("Failed to bring hibernate-CPU up!\n");
 			return ret;
@@ -1306,7 +1320,7 @@ void bringup_nonboot_cpus(unsigned int setup_max_cpus)
 		if (num_online_cpus() >= setup_max_cpus)
 			break;
 		if (!cpu_online(cpu))
-			cpu_up(cpu);
+			cpu_up(cpu, CPUHP_ONLINE);
 	}
 }
 
@@ -2129,9 +2143,9 @@ static ssize_t write_cpuhp_target(struct device *dev,
 		goto out;
 
 	if (st->state < target)
-		ret = do_cpu_up(dev->id, target);
+		ret = cpu_up(dev->id, target);
 	else
-		ret = do_cpu_down(dev->id, target);
+		ret = cpu_down(dev->id, target);
 out:
 	unlock_device_hotplug();
 	return ret ? ret : count;
