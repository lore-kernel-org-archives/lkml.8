Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3356CC4BA10
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF1D24688
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sr4BnJG6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgBZNqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 08:46:51 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:45602 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgBZNqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 08:46:50 -0500
Received: by mail-pf1-f202.google.com with SMTP id x21so2171700pfp.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 05:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AS5mKsB74t+7E/sEujl6poShEsL7bE+ufxNcf4D8z8o=;
        b=Sr4BnJG6UjEdN+CtM2LMS0vS1AocQmGPZ1O6ZYw9+LrEx6L2UDe2/6zJzZUSghixZL
         QlLqIM0clhQGI0eNhfE9CWp+2jfrYd8Hsg9/Fr2hk3SUtO4XhnPfIY8PcPbgfwf1hv8D
         ncIlyCypAHPaGykHUjrtCrGVF1MR7LPRrsoFjKAGQzsYgxdHs5v+bsJ58vrwkzRLOFbR
         b3yEGIn56/itRIDsSP8XK4rS/f8B9j3LHqW9XEaArBLPnUrsHqVwGFWXdiSHI0gx7dP9
         7VpVmFXRjlYHeH+2ZCTUQmkWux69cPEafnDC0V/yzkAZckLozpXYIIdvxsyMqJ7/NeG5
         wx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AS5mKsB74t+7E/sEujl6poShEsL7bE+ufxNcf4D8z8o=;
        b=PtLS6cNLryxLl3edOiDuxPXq/OfG1smh6R5WxxjtktlGhtNVffb579fe/7t0XqxJJa
         DHuwFOQgZTrlY473EMQJq6cPdbO7ya17vc8VrWOmal9YS4broPb2lB/167nN32b3qC0U
         th+gGHbtHaC0OLDkSLwk98gCqGxcwqfYPfEJTr6Pn5hSPX1LhMHifDquhOceCgmXKNXo
         wobQPiIK7kNi93t35/roN54vkIqgXG7vGHfftto3Ql6FjSVF3zJEpEbXyem1jS7xtPSF
         YhvZG6Jz7Zl5er7tTYuwvwePTqFtvrmzZhu2j24GRCndXX1LoDFpDvR6MKE/O7dSp3Wx
         PsSw==
X-Gm-Message-State: APjAAAU4YkIpcfwYtSPyiDDL+zOlunaSdNVVCN8MjeVEYjUyD0UGrduO
        dAGO52TDLmoQJqZGEILwEBwQTjP6S6nhU5YHj5+ak0QGCWqMSdS5SLu8ExxZJ/WoRYyO40jMLwu
        iMYKHU23sJ3GsKOzjK04hQuLG9XCT7NK8C+deUnp3i6jEkrKC0izdUvh8VbMOicNftVGMlg==
X-Google-Smtp-Source: APXvYqzmmOjR5e3Anegl0SbaYFaKSp42ZzEXbEmIn5tlKW5/i71GgYvQGHrySeagwrPUhidBXqHQNiaSpYM=
X-Received: by 2002:a63:1e4f:: with SMTP id p15mr453549pgm.28.1582724808495;
 Wed, 26 Feb 2020 05:46:48 -0800 (PST)
Date:   Wed, 26 Feb 2020 05:46:36 -0800
In-Reply-To: <20200226134637.31670-1-lrizzo@google.com>
Message-Id: <20200226134637.31670-2-lrizzo@google.com>
Mime-Version: 1.0
References: <20200226134637.31670-1-lrizzo@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v2 1/2] kstats: kernel metric collector
From:   Luigi Rizzo <lrizzo@google.com>
To:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        naveen.n.rao@linux.ibm.com, ardb@kernel.org, rizzo@iet.unipi.it,
        pabeni@redhat.com, giuseppe.lettieri@unipi.it, toke@redhat.com,
        hawk@kernel.org, mingo@redhat.com, acme@kernel.org,
        rostedt@goodmis.org, peterz@infradead.org
Cc:     Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kstats is a helper to accumulate in-kernel metrics (timestamps, sizes,
etc.) and show distributions through debugfs.
Set CONFIG_KSTATS=m or y to enable it.

Creating a metric takes one line of code (and one to destroy it):

  struct kstats *key = kstats_new("foo", 3 /* frac_bits */);
  ...
  kstats_delete(key);

The following line records a u64 sample:

  kstats_record(key, value);

kstats_record() is cheap (5ns hot cache, 250ns cold cache). Samples are
accumulated in a per-cpu array with 2^frac_bits slots for each power
of 2. Using frac_bits = 3 gives about 30 slots per decade.

Each metric has an entry in /sys/kernel/debug/kstats which can be used
to read and control data collection:

- writing start/stop/reset starts and stops sample collection,
  or resets the counters, e.g.

  echo reset > /sys/kernel/debug/kstats/foo

- reading from the node produces a detailed output that can be
  processed with external tools for improved presentation:

  cat /sys/kernel/debug/kstats/foo
  ...
  slot 55  CPU  0    count      589 avg      480 p 0.027613
  slot 55  CPU  1    count       18 avg      480 p 0.002572
  slot 55  CPU  2    count       25 avg      480 p 0.003325
  ...
  slot 55  CPUS 16   count      814 avg      480 p 0.002474
  ...
  slot 97  CPU  8    count     1150 avg    20130 p 0.447442
  slot 97  CPU  12   count       26 avg    20294 p 0.275555
  slot 97  CPUS 16   count   152585 avg    19809 p 0.651747
  slot 98  CPU  0    count       38 avg    21360 p 0.954691
  slot 98  CPU  1    count      456 avg    21412 p 0.872619
  ...
  slot 144 CPUS 16   count       12 avg  1061896 p 0.999999
  slot 146 CPU  4    count        1 avg  1313664 p 1.000000
  slot 146 CPUS 16   count        1 avg  1313664 p 1.000000

Postprocessing examples:
look at statistics for a single CPU (note double space)
        cd /sys/kernel/kstats/
        echo reset > foo; watch grep "'CPU  12 '" foo

Use gnuplot to plot distribution and cdf in a terminal from a remote host
  gnuplot
  set terminal dumb size 200 80
  set logscale x
  plot "<ssh root@myhost grep CPUS /sys/kernel/debug/kstats/foo" u 8:6 w l title "distribution"
  plot "<ssh root@myhost grep CPUS /sys/kernel/debug/kstats/foo" u 8:10 w l title "cdf"

Change-Id: I4f506607cef3c8f85a08e10fdbecdaf631d8d0e6
Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 include/linux/kstats.h |  62 +++++++++
 lib/Kconfig.debug      |   7 +
 lib/Makefile           |   1 +
 lib/kstats.c           | 290 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 360 insertions(+)
 create mode 100644 include/linux/kstats.h
 create mode 100644 lib/kstats.c

diff --git a/include/linux/kstats.h b/include/linux/kstats.h
new file mode 100644
index 0000000000000..636cc007fa138
--- /dev/null
+++ b/include/linux/kstats.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_KSTATS_H
+#define _LINUX_KSTATS_H
+
+#include <linux/types.h>
+
+/*
+ * Helper to collect and report kernel metrics. Use as follows:
+ *
+ * - creates a new debugfs entry in /sys/kernel/debug/kstats/foo
+ *   to collect the metric, accumulating samples in 2^frac_bits slots
+ *   per power of 2
+ *
+ *	struct kstats *key = kstats_new("foo", frac_bits);
+ *
+ * - add instrumentation around code:
+ *
+ *	u64 dt = ktime_get_ns();	// about 20ns
+ *	<section of code to measure>
+ *	dt = ktime_get_ns() - dt;	// about 20ns
+ *	kstats_record(key, dt);		// 5ns hot cache, 300ns cold
+ *
+ * - read values from debugfs
+ *	cat /sys/kernel/debug/kstats/foo
+ *	...
+ *	slot 55  CPU  0    count      589 avg      480 p 0.027613
+ *	slot 55  CPU  1    count       18 avg      480 p 0.002572
+ *	slot 55  CPU  2    count       25 avg      480 p 0.003325
+ *	...
+ *	slot 55  CPUS 28   count      814 avg      480 p 0.002474
+ *	...
+ *	slot 97  CPU  13   count     1150 avg    20130 p 0.447442
+ *	slot 97  CPUS 28   count   152585 avg    19809 p 0.651747
+ *	...
+ *
+ * - write to the file STOP, START, RESET executes the corresponding action
+ *
+ *	echo RESET > /sys/kernel/debug/kstats/foo
+ */
+
+struct kstats;
+
+#if defined(CONFIG_KSTATS) || defined(CONFIG_KSTATS_MODULE)
+/* Add an entry to debugfs. */
+struct kstats *kstats_new(const char *name, u8 frac_bits);
+
+/* Record a sample */
+void kstats_record(struct kstats *key, u64 value);
+
+/* Remove an entry and frees memory */
+void kstats_delete(struct kstats *key);
+#else
+static inline struct kstats *kstats_new(const char *name, u8 frac_bits)
+{
+	return NULL;
+}
+
+static inline void kstats_record(struct kstats *key, u64 value) {}
+static inline void kstats_delete(struct kstats *key) {}
+#endif
+
+#endif /* _LINUX_KSTATS_H */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 69def4a9df009..7d7fae57bfde5 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1452,6 +1452,13 @@ config LATENCYTOP
 	  Enable this option if you want to use the LatencyTOP tool
 	  to find out which userspace is blocking on what kernel operations.
 
+config KSTATS
+	tristate "collect percpu metrics and export distributions through debugfs"
+	depends on DEBUG_FS
+	help
+	  Helper library to collect percpu kernel metrics, exporting
+	  distributions through debugfs. See lib/kstats.c
+
 source "kernel/trace/Kconfig"
 
 config PROVIDE_OHCI1394_DMA_INIT
diff --git a/lib/Makefile b/lib/Makefile
index 611872c069269..3f8578007db4e 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -236,6 +236,7 @@ obj-$(CONFIG_RBTREE_TEST) += rbtree_test.o
 obj-$(CONFIG_INTERVAL_TREE_TEST) += interval_tree_test.o
 
 obj-$(CONFIG_PERCPU_TEST) += percpu_test.o
+obj-$(CONFIG_KSTATS) += kstats.o
 
 obj-$(CONFIG_ASN1) += asn1_decoder.o
 
diff --git a/lib/kstats.c b/lib/kstats.c
new file mode 100644
index 0000000000000..885ab448708de
--- /dev/null
+++ b/lib/kstats.c
@@ -0,0 +1,290 @@
+/*
+ * kstats, collect samples and export distributions through debugfs
+ *
+ * CREATE OBJECT:
+ *	struct kstats *key = kstats_new("some_name", 3);
+ *
+ * ADD A SAMPLE:
+ *	u64 dt = ktime_get_ns();	// about 20ns
+ *	<code to instrument>
+ *	dt = ktime_get_ns() - t;	// about 20ns
+ *	kstats_record(key, dt);		// 5ns hot cache, 250ns cold
+ *
+ * SHOW DATA:
+ *	cat /sys/kernel/debug/kstats/some_name
+ *
+ *	...
+ *	slot 12  CPU  0    count      764 avg       12 p 0.011339
+ *	slot 12  CPU  1    count      849 avg       12 p 0.011496
+ *	slot 12  CPU  2    count      712 avg       12 p 0.009705
+ *	...
+ *	slot 12  CPU  243  count        1 avg       12 p 0.000097
+ *	slot 12  CPUS 256  count    19977 avg       12 p 0.006153
+ *	...
+ */
+
+#include <linux/kstats.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/percpu.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/debugfs.h>
+
+/*
+ * Values are 64 bit unsigned and are accumulated per cpu, in one bucket for
+ * each power of 2. Each bucket is further subdivided in 2^frac_bits slots.
+ * The range for each slot is 2^-frac_bits of the base value for the bucket.
+ */
+#define BUCKETS	64	/* Total powers of 2 */
+
+/* For large values, sum is scaled to reduce the chance of overflow */
+#define SUM_SCALE 20
+
+/* Internal names start with ks_, external ones with kstats_ */
+
+struct ks_slot {
+	u64 samples;
+	u64 sum;
+};
+
+struct kstats {
+	u16 n_slots;		/* typically BUCKETS * 2^frac_bits + 2 */
+	u8 frac_bits;
+	u8 frac_mask;		/* 2^frac_bits - 1 */
+	bool active;		/* recording status */
+	struct ks_slot __percpu *slots;
+	struct dentry *entry;	/* debugfs entry */
+};
+
+static void ks_print(struct seq_file *p, int slot, int cpu, u64 sum,
+		     u64 tot, unsigned long samples, unsigned long avg)
+{
+	unsigned long frac = (tot == 0) ? 0 : ((sum % tot) * 1000000) / tot;
+
+	seq_printf(p,
+		   "slot %-3d CPU%c %-4d count %8lu avg %8lu p %c.%06lu\n",
+		   slot, cpu == nr_cpu_ids ? 'S' : ' ', cpu,
+		   samples, avg, sum == tot ? '1' : '0', frac);
+}
+
+/* Read handler */
+static int ks_show_entry(struct seq_file *p, void *v)
+{
+	u32 slot, cpu;
+	struct ks_slot *slots, *cur;
+	struct kstats *ks = p->private;
+	u64 *partials, *totals, grand_total = 0;
+	const size_t rowsize = ks ? ks->n_slots * sizeof(struct ks_slot) : 0;
+
+	if (!ks)
+		return -ENOENT;
+	if (!rowsize)
+		return 0;
+	/*
+	 * Counters are updated while we read them, so make a copy first.
+	 * kvzalloc'ed memory contains three areas:
+	 *
+	 *   slots:	[ nr_cpu_ids ][ ks->n_slots ](struct ks_slot)
+	 *   partials:	[ nr_cpu_ids ](u64)
+	 *   totals:	[ nr_cpu_ids ](u64)
+	 */
+	slots = kvzalloc(nr_cpu_ids * (rowsize + 2 * sizeof(u64)), GFP_KERNEL);
+	if (!slots)
+		return -ENOMEM;
+	partials = (u64 *)(slots + ks->n_slots * nr_cpu_ids);
+	totals = partials + nr_cpu_ids;
+	/* Copy data and compute counts totals (per-cpu and grand_total).
+	 * These values are needed to compute percentiles.
+	 */
+	for_each_possible_cpu(cpu) {
+		cur = slots + ks->n_slots * cpu;
+		memcpy(cur, per_cpu_ptr(ks->slots, cpu), rowsize);
+		for (slot = 0; slot < ks->n_slots; slot++)
+			totals[cpu] += cur[slot].samples;
+		grand_total += totals[cpu];
+	}
+
+	/* Second pass, produce individual lines */
+	for (slot = 0; slot < ks->n_slots; slot++) {
+		u64 n, samples = 0, sum = 0, samples_cumulative = 0;
+		u32 bucket = slot >> ks->frac_bits;
+		u32 sum_shift = bucket < SUM_SCALE ? 0 : bucket - SUM_SCALE;
+
+		for_each_possible_cpu(cpu) {
+			cur = slots + ks->n_slots * cpu;
+			sum += cur[slot].sum;
+			n = cur[slot].samples;
+			samples += n;
+			partials[cpu] += n;
+			samples_cumulative += partials[cpu];
+			if (n == 0)
+				continue;
+			ks_print(p, slot, cpu, partials[cpu], totals[cpu], n,
+				 (cur[slot].sum / n) << sum_shift);
+		}
+		if (samples == 0)
+			continue;
+		ks_print(p, slot, nr_cpu_ids, samples_cumulative, grand_total,
+			 samples, (sum / samples) << sum_shift);
+	}
+	kvfree(slots);
+	return 0;
+}
+
+static ssize_t ks_write(struct file *fp, const char __user *user_buffer,
+			size_t count, loff_t *position)
+{
+	struct inode *ino = fp->f_inode;
+	struct kstats *ks = ino ? ino->i_private : NULL;
+	char buf[256] = {};
+	ssize_t ret;
+	u32 cpu;
+
+	if (count >= sizeof(buf) - 1)
+		return -EINVAL;
+	ret = simple_write_to_buffer(buf, sizeof(buf),
+				     position, user_buffer, count);
+	if (ret < 0)
+		return ret;
+	/* Trim final newline if any */
+	if (count > 0 && buf[count - 1] == '\n')
+		buf[count - 1] = '\0';
+
+	if (ks == NULL)
+		return -EINVAL;
+
+	if (!strcasecmp(buf, "START")) {
+		ks->active = 1;
+	} else if (!strcasecmp(buf, "STOP")) {
+		ks->active = 0;
+	} else if (!strcasecmp(buf, "RESET")) {
+		for_each_possible_cpu(cpu) {
+			memset(per_cpu_ptr(ks->slots, cpu), 0,
+			       ks->n_slots * sizeof(struct ks_slot));
+		}
+	} else {
+		ret = -EINVAL;
+	}
+	/* TODO: add another command to turn off and deallocate memory. */
+	return ret;
+}
+
+static int ks_open(struct inode *inode, struct file *f)
+{
+	return single_open(f, ks_show_entry, inode->i_private);
+}
+
+static const struct file_operations ks_file_ops = {
+	.owner = THIS_MODULE,
+	.open = ks_open,
+	.release = single_release,
+	.read = seq_read,
+	.write = ks_write,
+	.llseek = seq_lseek,
+};
+
+static struct dentry *ks_root;	/* kstats root in debugfs */
+
+static int __init ks_init(void)
+{
+	ks_root = debugfs_create_dir("kstats", NULL);
+	return 0;
+}
+
+static void __exit ks_exit(void)
+{
+	debugfs_remove_recursive(ks_root);
+}
+
+/* Run as soon as possible, but after debugfs, which is in core_initcall */
+postcore_initcall(ks_init);
+module_exit(ks_exit);
+MODULE_LICENSE("GPL");
+
+/* User API: kstats_new(), kstats_delete(), kstats_record() */
+
+struct kstats *kstats_new(const char *name, u8 frac_bits)
+{
+	struct kstats *ks = NULL;
+	const char *errmsg = "";
+
+	if (IS_ERR_OR_NULL(ks_root)) {
+		errmsg = "ks_root not set yet";
+		goto error;
+	}
+
+	if (frac_bits > 5) {
+		pr_info("fractional bits %d too large, using 3\n", frac_bits);
+		frac_bits = 3;
+	}
+	ks = kzalloc(sizeof(*ks), GFP_KERNEL);
+	if (!ks)
+		return NULL;
+	ks->active = 1;
+	ks->frac_bits = frac_bits;
+	ks->frac_mask = (1 << frac_bits) - 1;
+	ks->n_slots = ((BUCKETS - frac_bits + 1) << frac_bits) + 1;
+
+	/* Add one extra bucket for user timestamps */
+	ks->slots = __alloc_percpu((1 + ks->n_slots) * sizeof(struct ks_slot),
+				   sizeof(u64));
+	if (!ks->slots) {
+		errmsg = "failed to allocate pcpu";
+		goto error;
+	}
+
+	/* 'ks' is saved in the inode (entry->d_inode->i_private). */
+	ks->entry = debugfs_create_file(name, 0444, ks_root, ks, &ks_file_ops);
+	__module_get(THIS_MODULE);
+	return ks;
+
+error:
+	pr_info("kstats: '%s' error %s\n", name, errmsg);
+	kstats_delete(ks);
+	return NULL;
+}
+EXPORT_SYMBOL(kstats_new);
+
+void kstats_delete(struct kstats *ks)
+{
+	if (!ks)
+		return;
+	debugfs_remove(ks->entry);
+	if (ks->slots)
+		free_percpu(ks->slots);
+	*ks = (struct kstats){};
+	kfree(ks);
+	module_put(THIS_MODULE);
+}
+EXPORT_SYMBOL(kstats_delete);
+
+void kstats_record(struct kstats *ks, u64 val)
+{
+	u32 bucket, slot;
+
+	if (!ks || !ks->active)
+		return;
+	/* The leftmost 1 selects the bucket, subsequent frac_bits select
+	 * the slot within the bucket. fls returns 0 when the argument is 0.
+	 */
+	bucket = fls64(val >> ks->frac_bits);
+	slot = bucket == 0 ? val :
+		((bucket << ks->frac_bits) |
+		 ((val >> (bucket - 1)) & ks->frac_mask));
+
+	/* Use the last slot on overflow if BUCKETS < 64 */
+	if (slot > ks->n_slots - 2)
+		slot = ks->n_slots - 1;
+
+	/* preempt_disable makes sure samples and sum modify the same slot.
+	 * this_cpu_add() uses a non-interruptible add to protect against
+	 * hardware interrupts which may call kstats_record.
+	 */
+	preempt_disable();
+	this_cpu_add(ks->slots[slot].samples, 1);
+	this_cpu_add(ks->slots[slot].sum,
+		     bucket < SUM_SCALE ? val : (val >> (bucket - SUM_SCALE)));
+	preempt_enable();
+}
+EXPORT_SYMBOL(kstats_record);
-- 
2.25.0.265.gbab2e86ba0-goog

