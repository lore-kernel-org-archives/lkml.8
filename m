Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910D4C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7062C20735
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgCWNva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:51:30 -0400
Received: from foss.arm.com ([217.140.110.172]:49456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728423AbgCWNv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 09:51:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDC941FB;
        Mon, 23 Mar 2020 06:51:28 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6EFA53F52E;
        Mon, 23 Mar 2020 06:51:26 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Eiichi Tsukata <devel@etsukata.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Nadav Amit <namit@vmware.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org
Subject: [PATCH v4 02/17] smp: Create a new function to shutdown nonboot cpus
Date:   Mon, 23 Mar 2020 13:50:55 +0000
Message-Id: <20200323135110.30522-3-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200323135110.30522-1-qais.yousef@arm.com>
References: <20200323135110.30522-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function will be used later in machine_shutdown() for some archs.

disable_nonboot_cpus() is not safe to use when doing machine_down(),
because it relies on freeze_secondary_cpus() which in turn is
a suspend/resume related freeze and could abort if the logic detects any
pending activities that can prevent finishing the offlining process.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Josh Poimboeuf <jpoimboe@redhat.com>
CC: "Peter Zijlstra (Intel)" <peterz@infradead.org>
CC: Jiri Kosina <jkosina@suse.cz>
CC: Nicholas Piggin <npiggin@gmail.com>
CC: Daniel Lezcano <daniel.lezcano@linaro.org>
CC: Ingo Molnar <mingo@kernel.org>
CC: Eiichi Tsukata <devel@etsukata.com>
CC: Zhenzhong Duan <zhenzhong.duan@oracle.com>
CC: Nadav Amit <namit@vmware.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
CC: Tony Luck <tony.luck@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>
CC: Russell King <linux@armlinux.org.uk>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will@kernel.org>
CC: linux-arm-kernel@lists.infradead.org
CC: linux-ia64@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 include/linux/cpu.h |  2 ++
 kernel/cpu.c        | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index cf8cf38dca43..64a246e9c8db 100644
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
index 069802f7010f..03c727195b65 100644
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
-- 
2.17.1

