Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5E8C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 15:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B6E217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 15:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgATPpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 10:45:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33536 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATPpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 10:45:30 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1itZEw-0002oL-Oo; Mon, 20 Jan 2020 16:45:22 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4E65D1C1A41;
        Mon, 20 Jan 2020 16:45:22 +0100 (CET)
Date:   Mon, 20 Jan 2020 15:45:22 -0000
From:   "tip-bot2 for Chen Yu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Add task resctrl information display
Cc:     Chen Yu <yu.c.chen@intel.com>, Borislav Petkov <bp@suse.de>,
        Jinshi Chen <jinshi.chen@intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200115092851.14761-1-yu.c.chen@intel.com>
References: <20200115092851.14761-1-yu.c.chen@intel.com>
MIME-Version: 1.0
Message-ID: <157953512208.396.13320405659867936498.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     e79f15a4598c1f3f3f7f3319ca308c63c91fdaf2
Gitweb:        https://git.kernel.org/tip/e79f15a4598c1f3f3f7f3319ca308c63c91fdaf2
Author:        Chen Yu <yu.c.chen@intel.com>
AuthorDate:    Wed, 15 Jan 2020 17:28:51 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 20 Jan 2020 16:19:10 +01:00

x86/resctrl: Add task resctrl information display

Monitoring tools that want to find out which resctrl control and monitor
groups a task belongs to must currently read the "tasks" file in every
group until they locate the process ID.

Add an additional file /proc/{pid}/cpu_resctrl_groups to provide this
information:

1)   res:
     mon:

resctrl is not available.

2)   res:/
     mon:

Task is part of the root resctrl control group, and it is not associated
to any monitor group.

3)  res:/
    mon:mon0

Task is part of the root resctrl control group and monitor group mon0.

4)  res:group0
    mon:

Task is part of resctrl control group group0, and it is not associated
to any monitor group.

5) res:group0
   mon:mon1

Task is part of resctrl control group group0 and monitor group mon1.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Jinshi Chen <jinshi.chen@intel.com>
Link: https://lkml.kernel.org/r/20200115092851.14761-1-yu.c.chen@intel.com
---
 arch/x86/Kconfig                       |  1 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 86 +++++++++++++++++++++++++-
 fs/proc/Kconfig                        |  4 +-
 fs/proc/base.c                         |  7 ++-
 include/linux/resctrl.h                | 14 ++++-
 5 files changed, 112 insertions(+)
 create mode 100644 include/linux/resctrl.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5e89499..6e17a68 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -456,6 +456,7 @@ config X86_CPU_RESCTRL
 	bool "x86 CPU resource control support"
 	depends on X86 && (CPU_SUP_INTEL || CPU_SUP_AMD)
 	select KERNFS
+	select PROC_CPU_RESCTRL		if PROC_FS
 	help
 	  Enable x86 CPU resource control support.
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 205925d..5b3ba83 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -729,6 +729,92 @@ static int rdtgroup_tasks_show(struct kernfs_open_file *of,
 	return ret;
 }
 
+#ifdef CONFIG_PROC_CPU_RESCTRL
+
+/*
+ * A task can only be part of one resctrl control group and of one monitor
+ * group which is associated to that control group.
+ *
+ * 1)   res:
+ *      mon:
+ *
+ *    resctrl is not available.
+ *
+ * 2)   res:/
+ *      mon:
+ *
+ *    Task is part of the root resctrl control group, and it is not associated
+ *    to any monitor group.
+ *
+ * 3)  res:/
+ *     mon:mon0
+ *
+ *    Task is part of the root resctrl control group and monitor group mon0.
+ *
+ * 4)  res:group0
+ *     mon:
+ *
+ *    Task is part of resctrl control group group0, and it is not associated
+ *    to any monitor group.
+ *
+ * 5) res:group0
+ *    mon:mon1
+ *
+ *    Task is part of resctrl control group group0 and monitor group mon1.
+ */
+int proc_resctrl_show(struct seq_file *s, struct pid_namespace *ns,
+		      struct pid *pid, struct task_struct *tsk)
+{
+	struct rdtgroup *rdtg;
+	int ret = 0;
+
+	mutex_lock(&rdtgroup_mutex);
+
+	/* Return empty if resctrl has not been mounted. */
+	if (!static_branch_unlikely(&rdt_enable_key)) {
+		seq_puts(s, "res:\nmon:\n");
+		goto unlock;
+	}
+
+	list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
+		struct rdtgroup *crg;
+
+		/*
+		 * Task information is only relevant for shareable
+		 * and exclusive groups.
+		 */
+		if (rdtg->mode != RDT_MODE_SHAREABLE &&
+		    rdtg->mode != RDT_MODE_EXCLUSIVE)
+			continue;
+
+		if (rdtg->closid != tsk->closid)
+			continue;
+
+		seq_printf(s, "res:%s%s\n", (rdtg == &rdtgroup_default) ? "/" : "",
+			   rdtg->kn->name);
+		seq_puts(s, "mon:");
+		list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
+				    mon.crdtgrp_list) {
+			if (tsk->rmid != crg->mon.rmid)
+				continue;
+			seq_printf(s, "%s", crg->kn->name);
+			break;
+		}
+		seq_putc(s, '\n');
+		goto unlock;
+	}
+	/*
+	 * The above search should succeed. Otherwise return
+	 * with an error.
+	 */
+	ret = -ENOENT;
+unlock:
+	mutex_unlock(&rdtgroup_mutex);
+
+	return ret;
+}
+#endif
+
 static int rdt_last_cmd_status_show(struct kernfs_open_file *of,
 				    struct seq_file *seq, void *v)
 {
diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
index 733881a..27ef84d 100644
--- a/fs/proc/Kconfig
+++ b/fs/proc/Kconfig
@@ -103,3 +103,7 @@ config PROC_CHILDREN
 config PROC_PID_ARCH_STATUS
 	def_bool n
 	depends on PROC_FS
+
+config PROC_CPU_RESCTRL
+	def_bool n
+	depends on PROC_FS
diff --git a/fs/proc/base.c b/fs/proc/base.c
index ebea950..bbffd65 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -94,6 +94,7 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/stat.h>
 #include <linux/posix-timers.h>
+#include <linux/resctrl.h>
 #include <trace/events/oom.h>
 #include "internal.h"
 #include "fd.h"
@@ -3061,6 +3062,9 @@ static const struct pid_entry tgid_base_stuff[] = {
 #ifdef CONFIG_CGROUPS
 	ONE("cgroup",  S_IRUGO, proc_cgroup_show),
 #endif
+#ifdef CONFIG_PROC_CPU_RESCTRL
+	ONE("cpu_resctrl_groups", S_IRUGO, proc_resctrl_show),
+#endif
 	ONE("oom_score",  S_IRUGO, proc_oom_score),
 	REG("oom_adj",    S_IRUGO|S_IWUSR, proc_oom_adj_operations),
 	REG("oom_score_adj", S_IRUGO|S_IWUSR, proc_oom_score_adj_operations),
@@ -3461,6 +3465,9 @@ static const struct pid_entry tid_base_stuff[] = {
 #ifdef CONFIG_CGROUPS
 	ONE("cgroup",  S_IRUGO, proc_cgroup_show),
 #endif
+#ifdef CONFIG_PROC_CPU_RESCTRL
+	ONE("cpu_resctrl_groups", S_IRUGO, proc_resctrl_show),
+#endif
 	ONE("oom_score", S_IRUGO, proc_oom_score),
 	REG("oom_adj",   S_IRUGO|S_IWUSR, proc_oom_adj_operations),
 	REG("oom_score_adj", S_IRUGO|S_IWUSR, proc_oom_score_adj_operations),
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
new file mode 100644
index 0000000..daf5cf6
--- /dev/null
+++ b/include/linux/resctrl.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _RESCTRL_H
+#define _RESCTRL_H
+
+#ifdef CONFIG_PROC_CPU_RESCTRL
+
+int proc_resctrl_show(struct seq_file *m,
+		      struct pid_namespace *ns,
+		      struct pid *pid,
+		      struct task_struct *tsk);
+
+#endif
+
+#endif /* _RESCTRL_H */
