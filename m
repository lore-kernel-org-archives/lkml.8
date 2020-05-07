Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9D2C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EE39208D6
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgEGN03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 09:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725914AbgEGN01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 09:26:27 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABD2C05BD43;
        Thu,  7 May 2020 06:26:27 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jWgXc-0001F8-T0; Thu, 07 May 2020 15:26:21 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4A6001C03AB;
        Thu,  7 May 2020 15:26:20 +0200 (CEST)
Date:   Thu, 07 May 2020 13:26:20 -0000
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu/hotplug: Remove disable_nonboot_cpus()
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200430114004.17477-1-qais.yousef@arm.com>
References: <20200430114004.17477-1-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <158885798024.8414.2694279565085131213.tip-bot2@tip-bot2>
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

Commit-ID:     565558558985b1d7cd43b21f18c1ad6b232788d0
Gitweb:        https://git.kernel.org/tip/565558558985b1d7cd43b21f18c1ad6b232788d0
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Thu, 30 Apr 2020 12:40:03 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 May 2020 15:18:40 +02:00

cpu/hotplug: Remove disable_nonboot_cpus()

The single user could have called freeze_secondary_cpus() directly.

Since this function was a source of confusion, remove it as it's
just a pointless wrapper.

While at it, rename enable_nonboot_cpus() to thaw_secondary_cpus() to
preserve the naming symmetry.

Done automatically via:

	git grep -l enable_nonboot_cpus | xargs sed -i 's/enable_nonboot_cpus/thaw_secondary_cpus/g'

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Link: https://lkml.kernel.org/r/20200430114004.17477-1-qais.yousef@arm.com

---
 Documentation/power/suspend-and-cpuhotplug.rst            |  6 +--
 arch/x86/kernel/smpboot.c                                 |  4 +-
 arch/x86/power/cpu.c                                      |  2 +-
 include/linux/cpu.h                                       | 12 +-----
 include/linux/smp.h                                       |  4 +-
 kernel/cpu.c                                              | 14 +++----
 tools/power/pm-graph/config/custom-timeline-functions.cfg |  2 +-
 tools/power/pm-graph/sleepgraph.py                        |  2 +-
 8 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/Documentation/power/suspend-and-cpuhotplug.rst b/Documentation/power/suspend-and-cpuhotplug.rst
index 572d968..ebedb6c 100644
--- a/Documentation/power/suspend-and-cpuhotplug.rst
+++ b/Documentation/power/suspend-and-cpuhotplug.rst
@@ -48,7 +48,7 @@ More details follow::
                                         |
                                         |
                                         v
-                              disable_nonboot_cpus()
+                              freeze_secondary_cpus()
                                    /* start */
                                         |
                                         v
@@ -83,7 +83,7 @@ More details follow::
                             Release cpu_add_remove_lock
                                         |
                                         v
-                       /* disable_nonboot_cpus() complete */
+                       /* freeze_secondary_cpus() complete */
                                         |
                                         v
                                    Do suspend
@@ -93,7 +93,7 @@ More details follow::
 Resuming back is likewise, with the counterparts being (in the order of
 execution during resume):
 
-* enable_nonboot_cpus() which involves::
+* thaw_secondary_cpus() which involves::
 
    |  Acquire cpu_add_remove_lock
    |  Decrease cpu_hotplug_disabled, thereby enabling regular cpu hotplug
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index fe3ab96..997b66c 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1376,12 +1376,12 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 	speculative_store_bypass_ht_init();
 }
 
-void arch_enable_nonboot_cpus_begin(void)
+void arch_thaw_secondary_cpus_begin(void)
 {
 	set_mtrr_aps_delayed_init();
 }
 
-void arch_enable_nonboot_cpus_end(void)
+void arch_thaw_secondary_cpus_end(void)
 {
 	mtrr_aps_init();
 }
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index aaff9ed..fc3b757 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -307,7 +307,7 @@ int hibernate_resume_nonboot_cpu_disable(void)
 	if (ret)
 		return ret;
 	smp_ops.play_dead = resume_play_dead;
-	ret = disable_nonboot_cpus();
+	ret = freeze_secondary_cpus(0);
 	smp_ops.play_dead = play_dead;
 	return ret;
 }
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index beaed2d..9d34dc3 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -150,12 +150,7 @@ static inline int freeze_secondary_cpus(int primary)
 	return __freeze_secondary_cpus(primary, true);
 }
 
-static inline int disable_nonboot_cpus(void)
-{
-	return __freeze_secondary_cpus(0, false);
-}
-
-void enable_nonboot_cpus(void);
+extern void thaw_secondary_cpus(void);
 
 static inline int suspend_disable_secondary_cpus(void)
 {
@@ -168,12 +163,11 @@ static inline int suspend_disable_secondary_cpus(void)
 }
 static inline void suspend_enable_secondary_cpus(void)
 {
-	return enable_nonboot_cpus();
+	return thaw_secondary_cpus();
 }
 
 #else /* !CONFIG_PM_SLEEP_SMP */
-static inline int disable_nonboot_cpus(void) { return 0; }
-static inline void enable_nonboot_cpus(void) {}
+static inline void thaw_secondary_cpus(void) {}
 static inline int suspend_disable_secondary_cpus(void) { return 0; }
 static inline void suspend_enable_secondary_cpus(void) { }
 #endif /* !CONFIG_PM_SLEEP_SMP */
diff --git a/include/linux/smp.h b/include/linux/smp.h
index cbc9162..0401987 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -227,8 +227,8 @@ static inline int get_boot_cpu_id(void)
  */
 extern void arch_disable_smp_support(void);
 
-extern void arch_enable_nonboot_cpus_begin(void);
-extern void arch_enable_nonboot_cpus_end(void);
+extern void arch_thaw_secondary_cpus_begin(void);
+extern void arch_thaw_secondary_cpus_end(void);
 
 void smp_setup_processor_id(void);
 
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6a02d44..d766929 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1376,8 +1376,8 @@ int __freeze_secondary_cpus(int primary, bool suspend)
 
 	/*
 	 * Make sure the CPUs won't be enabled by someone else. We need to do
-	 * this even in case of failure as all disable_nonboot_cpus() users are
-	 * supposed to do enable_nonboot_cpus() on the failure path.
+	 * this even in case of failure as all freeze_secondary_cpus() users are
+	 * supposed to do thaw_secondary_cpus() on the failure path.
 	 */
 	cpu_hotplug_disabled++;
 
@@ -1385,15 +1385,15 @@ int __freeze_secondary_cpus(int primary, bool suspend)
 	return error;
 }
 
-void __weak arch_enable_nonboot_cpus_begin(void)
+void __weak arch_thaw_secondary_cpus_begin(void)
 {
 }
 
-void __weak arch_enable_nonboot_cpus_end(void)
+void __weak arch_thaw_secondary_cpus_end(void)
 {
 }
 
-void enable_nonboot_cpus(void)
+void thaw_secondary_cpus(void)
 {
 	int cpu, error;
 
@@ -1405,7 +1405,7 @@ void enable_nonboot_cpus(void)
 
 	pr_info("Enabling non-boot CPUs ...\n");
 
-	arch_enable_nonboot_cpus_begin();
+	arch_thaw_secondary_cpus_begin();
 
 	for_each_cpu(cpu, frozen_cpus) {
 		trace_suspend_resume(TPS("CPU_ON"), cpu, true);
@@ -1418,7 +1418,7 @@ void enable_nonboot_cpus(void)
 		pr_warn("Error taking CPU%d up: %d\n", cpu, error);
 	}
 
-	arch_enable_nonboot_cpus_end();
+	arch_thaw_secondary_cpus_end();
 
 	cpumask_clear(frozen_cpus);
 out:
diff --git a/tools/power/pm-graph/config/custom-timeline-functions.cfg b/tools/power/pm-graph/config/custom-timeline-functions.cfg
index 4f80ad7..962e576 100644
--- a/tools/power/pm-graph/config/custom-timeline-functions.cfg
+++ b/tools/power/pm-graph/config/custom-timeline-functions.cfg
@@ -125,7 +125,7 @@ acpi_suspend_begin:
 suspend_console:
 acpi_pm_prepare:
 syscore_suspend:
-arch_enable_nonboot_cpus_end:
+arch_thaw_secondary_cpus_end:
 syscore_resume:
 acpi_pm_finish:
 resume_console:
diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sleepgraph.py
index f7d1c1f..530a9f6 100755
--- a/tools/power/pm-graph/sleepgraph.py
+++ b/tools/power/pm-graph/sleepgraph.py
@@ -192,7 +192,7 @@ class SystemValues:
 		'suspend_console': {},
 		'acpi_pm_prepare': {},
 		'syscore_suspend': {},
-		'arch_enable_nonboot_cpus_end': {},
+		'arch_thaw_secondary_cpus_end': {},
 		'syscore_resume': {},
 		'acpi_pm_finish': {},
 		'resume_console': {},
