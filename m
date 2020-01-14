Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CE0C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D682467C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbgANNE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 08:04:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43103 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgANNCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 08:02:19 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1irLpn-0004bD-57; Tue, 14 Jan 2020 14:02:15 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BD93F1C07EC;
        Tue, 14 Jan 2020 14:02:14 +0100 (CET)
Date:   Tue, 14 Jan 2020 13:02:14 -0000
From:   "tip-bot2 for Andrei Vagin" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] fs/proc: Introduce /proc/pid/timens_offsets
Cc:     Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191112012724.250792-28-dima@arista.com>
References: <20191112012724.250792-28-dima@arista.com>
MIME-Version: 1.0
Message-ID: <157900693455.396.18061088292922754668.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     04a8682a71becdb639ec9c0d82b315a2baef7a5d
Gitweb:        https://git.kernel.org/tip/04a8682a71becdb639ec9c0d82b315a2baef7a5d
Author:        Andrei Vagin <avagin@gmail.com>
AuthorDate:    Tue, 12 Nov 2019 01:27:16 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 14 Jan 2020 12:20:59 +01:00

fs/proc: Introduce /proc/pid/timens_offsets

API to set time namespace offsets for children processes, i.e.:
echo "$clockid $offset_sec $offset_nsec" > /proc/self/timens_offsets

Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20191112012724.250792-28-dima@arista.com


---
 fs/proc/base.c                 |  94 ++++++++++++++++++++++++++++++-
 include/linux/time_namespace.h |  10 +++-
 kernel/time/namespace.c        | 101 ++++++++++++++++++++++++++++++++-
 3 files changed, 205 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index ebea950..5adc639 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -94,6 +94,7 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/stat.h>
 #include <linux/posix-timers.h>
+#include <linux/time_namespace.h>
 #include <trace/events/oom.h>
 #include "internal.h"
 #include "fd.h"
@@ -1533,6 +1534,96 @@ static const struct file_operations proc_pid_sched_autogroup_operations = {
 
 #endif /* CONFIG_SCHED_AUTOGROUP */
 
+#ifdef CONFIG_TIME_NS
+static int timens_offsets_show(struct seq_file *m, void *v)
+{
+	struct task_struct *p;
+
+	p = get_proc_task(file_inode(m->file));
+	if (!p)
+		return -ESRCH;
+	proc_timens_show_offsets(p, m);
+
+	put_task_struct(p);
+
+	return 0;
+}
+
+static ssize_t timens_offsets_write(struct file *file, const char __user *buf,
+				    size_t count, loff_t *ppos)
+{
+	struct inode *inode = file_inode(file);
+	struct proc_timens_offset offsets[2];
+	char *kbuf = NULL, *pos, *next_line;
+	struct task_struct *p;
+	int ret, noffsets;
+
+	/* Only allow < page size writes at the beginning of the file */
+	if ((*ppos != 0) || (count >= PAGE_SIZE))
+		return -EINVAL;
+
+	/* Slurp in the user data */
+	kbuf = memdup_user_nul(buf, count);
+	if (IS_ERR(kbuf))
+		return PTR_ERR(kbuf);
+
+	/* Parse the user data */
+	ret = -EINVAL;
+	noffsets = 0;
+	for (pos = kbuf; pos; pos = next_line) {
+		struct proc_timens_offset *off = &offsets[noffsets];
+		int err;
+
+		/* Find the end of line and ensure we don't look past it */
+		next_line = strchr(pos, '\n');
+		if (next_line) {
+			*next_line = '\0';
+			next_line++;
+			if (*next_line == '\0')
+				next_line = NULL;
+		}
+
+		err = sscanf(pos, "%u %lld %lu", &off->clockid,
+				&off->val.tv_sec, &off->val.tv_nsec);
+		if (err != 3 || off->val.tv_nsec >= NSEC_PER_SEC)
+			goto out;
+		noffsets++;
+		if (noffsets == ARRAY_SIZE(offsets)) {
+			if (next_line)
+				count = next_line - kbuf;
+			break;
+		}
+	}
+
+	ret = -ESRCH;
+	p = get_proc_task(inode);
+	if (!p)
+		goto out;
+	ret = proc_timens_set_offset(file, p, offsets, noffsets);
+	put_task_struct(p);
+	if (ret)
+		goto out;
+
+	ret = count;
+out:
+	kfree(kbuf);
+	return ret;
+}
+
+static int timens_offsets_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, timens_offsets_show, inode);
+}
+
+static const struct file_operations proc_timens_offsets_operations = {
+	.open		= timens_offsets_open,
+	.read		= seq_read,
+	.write		= timens_offsets_write,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+#endif /* CONFIG_TIME_NS */
+
 static ssize_t comm_write(struct file *file, const char __user *buf,
 				size_t count, loff_t *offset)
 {
@@ -3016,6 +3107,9 @@ static const struct pid_entry tgid_base_stuff[] = {
 #ifdef CONFIG_SCHED_AUTOGROUP
 	REG("autogroup",  S_IRUGO|S_IWUSR, proc_pid_sched_autogroup_operations),
 #endif
+#ifdef CONFIG_TIME_NS
+	REG("timens_offsets",  S_IRUGO|S_IWUSR, proc_timens_offsets_operations),
+#endif
 	REG("comm",      S_IRUGO|S_IWUSR, proc_pid_set_comm_operations),
 #ifdef CONFIG_HAVE_ARCH_TRACEHOOK
 	ONE("syscall",    S_IRUSR, proc_pid_syscall),
diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 04a2ba8..824d54e 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -52,6 +52,16 @@ static inline void put_time_ns(struct time_namespace *ns)
 	kref_put(&ns->kref, free_time_ns);
 }
 
+void proc_timens_show_offsets(struct task_struct *p, struct seq_file *m);
+
+struct proc_timens_offset {
+	int			clockid;
+	struct timespec64	val;
+};
+
+int proc_timens_set_offset(struct file *file, struct task_struct *p,
+			   struct proc_timens_offset *offsets, int n);
+
 static inline void timens_add_monotonic(struct timespec64 *ts)
 {
 	struct timens_offsets *ns_offsets = &current->nsproxy->time_ns->offsets;
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 0732964..1285850 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -8,6 +8,7 @@
 #include <linux/user_namespace.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/task.h>
+#include <linux/seq_file.h>
 #include <linux/proc_ns.h>
 #include <linux/export.h>
 #include <linux/time.h>
@@ -334,6 +335,106 @@ static struct user_namespace *timens_owner(struct ns_common *ns)
 	return to_time_ns(ns)->user_ns;
 }
 
+static void show_offset(struct seq_file *m, int clockid, struct timespec64 *ts)
+{
+	seq_printf(m, "%d %lld %ld\n", clockid, ts->tv_sec, ts->tv_nsec);
+}
+
+void proc_timens_show_offsets(struct task_struct *p, struct seq_file *m)
+{
+	struct ns_common *ns;
+	struct time_namespace *time_ns;
+
+	ns = timens_for_children_get(p);
+	if (!ns)
+		return;
+	time_ns = to_time_ns(ns);
+
+	show_offset(m, CLOCK_MONOTONIC, &time_ns->offsets.monotonic);
+	show_offset(m, CLOCK_BOOTTIME, &time_ns->offsets.boottime);
+	put_time_ns(time_ns);
+}
+
+int proc_timens_set_offset(struct file *file, struct task_struct *p,
+			   struct proc_timens_offset *offsets, int noffsets)
+{
+	struct ns_common *ns;
+	struct time_namespace *time_ns;
+	struct timespec64 tp;
+	int i, err;
+
+	ns = timens_for_children_get(p);
+	if (!ns)
+		return -ESRCH;
+	time_ns = to_time_ns(ns);
+
+	if (!file_ns_capable(file, time_ns->user_ns, CAP_SYS_TIME)) {
+		put_time_ns(time_ns);
+		return -EPERM;
+	}
+
+	for (i = 0; i < noffsets; i++) {
+		struct proc_timens_offset *off = &offsets[i];
+
+		switch (off->clockid) {
+		case CLOCK_MONOTONIC:
+			ktime_get_ts64(&tp);
+			break;
+		case CLOCK_BOOTTIME:
+			ktime_get_boottime_ts64(&tp);
+			break;
+		default:
+			err = -EINVAL;
+			goto out;
+		}
+
+		err = -ERANGE;
+
+		if (off->val.tv_sec > KTIME_SEC_MAX ||
+		    off->val.tv_sec < -KTIME_SEC_MAX)
+			goto out;
+
+		tp = timespec64_add(tp, off->val);
+		/*
+		 * KTIME_SEC_MAX is divided by 2 to be sure that KTIME_MAX is
+		 * still unreachable.
+		 */
+		if (tp.tv_sec < 0 || tp.tv_sec > KTIME_SEC_MAX / 2)
+			goto out;
+	}
+
+	mutex_lock(&offset_lock);
+	if (time_ns->frozen_offsets) {
+		err = -EACCES;
+		goto out_unlock;
+	}
+
+	err = 0;
+	/* Don't report errors after this line */
+	for (i = 0; i < noffsets; i++) {
+		struct proc_timens_offset *off = &offsets[i];
+		struct timespec64 *offset = NULL;
+
+		switch (off->clockid) {
+		case CLOCK_MONOTONIC:
+			offset = &time_ns->offsets.monotonic;
+			break;
+		case CLOCK_BOOTTIME:
+			offset = &time_ns->offsets.boottime;
+			break;
+		}
+
+		*offset = off->val;
+	}
+
+out_unlock:
+	mutex_unlock(&offset_lock);
+out:
+	put_time_ns(time_ns);
+
+	return err;
+}
+
 const struct proc_ns_operations timens_operations = {
 	.name		= "time",
 	.type		= CLONE_NEWTIME,
