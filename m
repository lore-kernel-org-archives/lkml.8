Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF82C4BA10
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8546024690
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KmtbFQUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgBZNup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 08:50:45 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:50425 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgBZNuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 08:50:44 -0500
Received: by mail-pl1-f202.google.com with SMTP id g5so1957498plq.17
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 05:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CuP6fInohI0XjjoRoTIDjibvG/tUyVnMSm7MxozwsWo=;
        b=KmtbFQUtxV90c2wPU6WggGYfvHJec4CCdxYfR5x3EfGKE4c9WcM4gDwTwlyy1EZg45
         SAS7hDxrhJ70hSkfYqMl4DRTrO/vM5MtEWZv/OGH2u1VxH0ys7km9sOUuV5XByY1XtnA
         1pQlQzDcYgxRYra2AsAR+0ehMKr+fnRa6nZmJGu0ypnXfXJrA3ufMlCoccr8r0oiJY8q
         hMDrUQuwUndkgbjFh7qn5q6oDppi5FvuY6zttIHgi7cbF63tM6g0qjOmzBpXovLDqRRS
         NnYkwQFleiePiGEt8gPLX+ksIc+vHUJoK6frHlA4yshfm5KJ9UqWzPkEDTvnod0maMQn
         4nKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CuP6fInohI0XjjoRoTIDjibvG/tUyVnMSm7MxozwsWo=;
        b=pSkUleCzlBD0rCpZ0ZcijAE5jS+IsM6Ebxn2Tx/2rDGs86913ZXLVTo+0eKPzn11sE
         RIgl/7xlvvsKyqIxFg1zME5lQ2j8Iwh5vOKnLK8hp6T9pJO44uWJKaKuEnzsEF20h4ms
         m528iOSixwcLhFEgdII+gNcKEsugCkfLEKGzR1O9COIm8Oj/yKi4DEA9j6gkQ/HCyVyN
         z95g2TRJT1dQwbOCGqv3ac8so/ndW7s/XYDXcynlbhxKgA2k0bAFRWjILPzQfz1hiE7K
         ihuh7qVsLTMH95OSb4Xyu3URQDW72x91WHNs/C1yDkBgOO9G655cAV9TRhUB+4Ay8uyb
         Ul5g==
X-Gm-Message-State: APjAAAXbCaEQ6asiF6eDuX6IMwv4mi2ZVKbQDwrT8WaCStkYvxcBqcVs
        dvSX0YKGaRXPZX2g3e9fjWJF/klCod6A190UTXc3/uhrAZlZhIjKTGUgU6WX1iHuXyNAjdBfuRC
        +dGGPjRQfG+AgM0PClP6nj/HG3aLvFiNg4eBC8J1ExoVcqrlPB7yMPkywkvVlwz1Aabhicw==
X-Google-Smtp-Source: APXvYqyEQ1VbhGYj7yROKW/IANhbPjNWyvd0L+93uIlPN/wq8fNB5mT1koNT3bEqB2zLbAfJwyTtsdb4+j0=
X-Received: by 2002:a63:c507:: with SMTP id f7mr3879450pgd.278.1582725042381;
 Wed, 26 Feb 2020 05:50:42 -0800 (PST)
Date:   Wed, 26 Feb 2020 05:50:27 -0800
In-Reply-To: <20200226135027.34538-1-lrizzo@google.com>
Message-Id: <20200226135027.34538-3-lrizzo@google.com>
Mime-Version: 1.0
References: <20200226135027.34538-1-lrizzo@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v3 2/2] kstats: kretprobe and tracepoint support
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

The following code supports runtime monitoring of the execution time of
a block of code (a function, a section between two function entry points
or tracepoints) _and_ the interval between calls to the block.

Use as follows:

  echo "trace S bits B start X end Y" > /sys/kernel/debug/kstats/_control

	creates node /sys/kernel/debug/kstats/S, traces time between X and Y
	with 2^B buckets. Arguments after S are optional, X defaults to S,
	bits defaults to 3, end defaults to empty. X and Y can be function
	names or __tracepoint_T where T is a tracepoint name.

	It also creates a second node /sys/kernel/debug/kstats/GAP-S that
	traces the time end and start of subsequent calls to the function
	on the same CPU.

  echo "remove S" > /sys/kernel/debug/kstats/_control

	removes the two /sys/kernel/debugfs/kstats nodes, S and GAP-S

The code uses 3 different methods to track start and end of the block:

1. if end is not specified, uses kretprobe to collect timestamps around
   calls to function X.

2. if end != start, use kprobe to collect timestaps in the two places.
   Only meaningful when the two functions uniquely identify a code path.

3. if names have the form __tracepoint_XXX, collect timestamps at the
   two tracepoints.

Metric collection through k[ret]probes or tracepoints is very convenient
but much more intrusive and less accurate than manual annotation: this is
because those hooks involve several out of line code and memory accesses,
particularly expensive when not in cache.
On a 2020 server-class x86 CPU, tracing a function with kretprobe adds
~250ns with hot cache, 1500+ns with cold cache; an empty functions reports
a minimum time of ~90ns with hot cache, 500ns with cold cache.

(Hot and cold cache behavior can be easily tested by calling the traced
function at high rates (<20us between calls) and low rates (>1ms))

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 lib/kstats.c | 368 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 366 insertions(+), 2 deletions(-)

diff --git a/lib/kstats.c b/lib/kstats.c
index 885ab448708de..4507f026b2fbc 100644
--- a/lib/kstats.c
+++ b/lib/kstats.c
@@ -21,6 +21,13 @@
  *	slot 12  CPU  243  count        1 avg       12 p 0.000097
  *	slot 12  CPUS 256  count    19977 avg       12 p 0.006153
  *	...
+ *
+ * Besides manual code annotations, the following two commands add and remove
+ * tracing of the execution time of a function or a section of code, see more
+ * details later in this file:
+ *
+ *	echo "trace some_function" > /sys/kernel/debug/kstats/_control
+ *	echo "remove some_function" > /sys/kernel/debug/kstats/_control
  */
 
 #include <linux/kstats.h>
@@ -68,6 +75,11 @@ static void ks_print(struct seq_file *p, int slot, int cpu, u64 sum,
 		   samples, avg, sum == tot ? '1' : '0', frac);
 }
 
+/* Helpers for user-created nodes via _control */
+static int ks_list_nodes(struct seq_file *p);
+static int ks_control_write(char *buf, int ret);
+static bool ks_delete_nodes(const char *name);
+
 /* Read handler */
 static int ks_show_entry(struct seq_file *p, void *v)
 {
@@ -78,7 +90,7 @@ static int ks_show_entry(struct seq_file *p, void *v)
 	const size_t rowsize = ks ? ks->n_slots * sizeof(struct ks_slot) : 0;
 
 	if (!ks)
-		return -ENOENT;
+		return ks_list_nodes(p);
 	if (!rowsize)
 		return 0;
 	/*
@@ -152,7 +164,7 @@ static ssize_t ks_write(struct file *fp, const char __user *user_buffer,
 		buf[count - 1] = '\0';
 
 	if (ks == NULL)
-		return -EINVAL;
+		return ks_control_write(buf, ret);
 
 	if (!strcasecmp(buf, "START")) {
 		ks->active = 1;
@@ -189,11 +201,13 @@ static struct dentry *ks_root;	/* kstats root in debugfs */
 static int __init ks_init(void)
 {
 	ks_root = debugfs_create_dir("kstats", NULL);
+	debugfs_create_file("_control", 0644, ks_root, NULL, &ks_file_ops);
 	return 0;
 }
 
 static void __exit ks_exit(void)
 {
+	ks_delete_nodes(NULL);
 	debugfs_remove_recursive(ks_root);
 }
 
@@ -288,3 +302,353 @@ void kstats_record(struct kstats *ks, u64 val)
 	preempt_enable();
 }
 EXPORT_SYMBOL(kstats_record);
+
+/*
+ * The following code supports runtime monitoring of the execution time of
+ * a block of code (a function, a section between two function entry points
+ * or tracepoints) with the following command:
+ *
+ * echo "trace S bits B start X end Y" > /sys/kernel/debug/kstats/_control
+ *
+ *    creates node /sys/kernel/debug/kstats/S, traces time between X and Y
+ *    with 2^B buckets. Arguments after S are optional, X defaults to S,
+ *    bits defaults to 3, end defaults to empty. X and Y can be function names
+ *    or __tracepoint_T where T is a tracepoint name.
+ *
+ *    It also creates a second node /sys/kernel/debug/kstats/GAP-S that traces
+ *    the time between end and start of subsequent calls to the function on
+ *    the same CPU.
+ *
+ * echo "remove S" > /sys/kernel/debug/kstats/_control
+ *
+ *    removes the two /sys/kernel/debugfs/kstats nodes, S and GAP-S
+ *
+ * The code uses 3 different methods to track start and end of the block:
+ *
+ * 1. if end is not specified, uses kretprobe to collect timestamps around
+ *    calls to function X.
+ *
+ * 2. if end != start, use kprobe to collect timestaps in the two places.
+ *    Only meaningful when the two functions uniquely identify a code path.
+ *
+ * 3. if names have the form __tracepoint_XXX, collect timestamps at the
+ *    two tracepoints.
+ *
+ * Metric collection through k[ret]probes or tracepoints is very convenient
+ * but much more intrusive and less accurate than manual annotation: this is
+ * because those hooks involve several out of line code and memory accesses,
+ * particularly expensive when not in cache.
+ * On a 2020 server-class x86 CPU, tracing a function with kretprobe adds
+ * ~250ns with hot cache, 1500+ns with cold cache; an empty functions reports
+ * a minimum time of ~90ns with hot cache, 500ns with cold cache.
+ */
+
+#include <linux/kprobes.h>
+#include <linux/tracepoint.h>
+
+/* Manually added entries are in a list protected by ks_mutex */
+static LIST_HEAD(ks_user_nodes);
+static DEFINE_MUTEX(ks_mutex);
+
+/* Manually added nodes */
+enum node_type { KSN_NONE = 0, KSN_KPROBE, KSN_RETPROBE, KSN_TRACEPOINT };
+struct ks_node {
+	struct kstats *ks;	/* record time for a call */
+	struct kstats *ks_gap;	/* record gap between calls */
+	struct list_head link;	/* Set for nodes added to the main list */
+	enum node_type type;
+	/* These could do in a union */
+	struct kprobe kp1;
+	struct kprobe kp2;
+	struct kretprobe kret;
+	struct tracepoint *tp1;
+	struct tracepoint *tp2;
+	char name[0];
+};
+
+/* Address of the temporary storage for starting timestamp */
+static u64 *ts_addr(struct kstats *ks)
+{
+	return &((this_cpu_ptr(ks->slots) + ks->n_slots + 1)->sum);
+}
+
+/* Store value in slot if not set already */
+static void ks_ts_start(struct kstats *ks, u64 value)
+{
+	u64 *addr = ts_addr(ks);
+
+	if (!*addr)
+		*addr = value;
+}
+
+/* Record value if previous was non zero */
+static void ks_ts_record(struct kstats *ks, u64 value)
+{
+	u64 *addr = ts_addr(ks);
+
+	if (*addr) {
+		kstats_record(ks, value - *addr);
+		*addr = 0;
+	}
+}
+
+/*
+ * Method 3, tracepoints. The first argument of the tracepoint callback
+ * comes from tracepoint_probe_register, others as defined in the proto.
+ */
+static int ks_tp_start(struct ks_node *cur)
+{
+	u64 now;
+
+	preempt_disable();
+	now = ktime_get_ns();
+	ks_ts_start(cur->ks, now);
+	if (cur->ks_gap)
+		ks_ts_record(cur->ks_gap, now);
+	preempt_enable();
+	return 0;
+}
+
+static int ks_tp_end(struct ks_node *cur)
+{
+	u64 now;
+
+	preempt_disable();
+	now = ktime_get_ns();
+	ks_ts_record(cur->ks, now);
+	if (cur->ks_gap)
+		ks_ts_start(cur->ks_gap, now);
+	preempt_enable();
+	return 0;
+}
+
+/* Method 1: use kretprobe */
+static int ks_kretp_start(struct kretprobe_instance *r, struct pt_regs *regs)
+{
+	return ks_tp_start(container_of(r->rp, struct ks_node, kret));
+}
+
+static int ks_kretp_end(struct kretprobe_instance *r, struct pt_regs *regs)
+{
+	return ks_tp_end(container_of(r->rp, struct ks_node, kret));
+}
+
+/* Method 2, kprobes */
+static int ks_kprobe_start(struct kprobe *f, struct pt_regs *regs)
+{
+	return ks_tp_start(container_of(f, struct ks_node, kp1));
+}
+
+static int ks_kprobe_end(struct kprobe *f, struct pt_regs *regs)
+{
+	return ks_tp_end(container_of(f, struct ks_node, kp2));
+}
+
+/* Destroy a user-defined node */
+static void ks_node_delete(struct ks_node *cur)
+{
+	if (!cur)
+		return;
+#ifdef CONFIG_TRACEPOINTS
+	if (cur->tp2)
+		tracepoint_probe_unregister(cur->tp2, ks_tp_end, cur);
+	if (cur->tp1)
+		tracepoint_probe_unregister(cur->tp1, ks_tp_start, cur);
+	tracepoint_synchronize_unregister();
+#endif
+	unregister_kretprobe(&cur->kret);
+	unregister_kprobe(&cur->kp1);
+	unregister_kprobe(&cur->kp2);
+	kstats_delete(cur->ks);
+	kstats_delete(cur->ks_gap);
+	kfree(cur);
+}
+
+/* Some names cannot be attached to */
+static bool blacklisted(const char *name)
+{
+	static const char * const blacklist[] = {
+		"kstats_record",
+		NULL
+	};
+	int i;
+
+	for (i = 0; name && blacklist[i]; i++) {
+		if (!strcmp(name, blacklist[i])) {
+			pr_info("%s is blacklisted\n", name);
+			return true;
+		}
+	}
+	return false;
+}
+
+static const char gap[] = "GAP-";
+static char *ksn_name(struct ks_node *cur)
+{
+	return cur->name + sizeof(gap) - 1;
+}
+
+/* Create a new user-defined node */
+static struct ks_node *ks_node_new(int n, char *argv[])
+{
+	static const char *tp_prefix = "__tracepoint_";
+	char *name = argv[1], *start = name, *end = NULL;
+	struct ks_node *cur;
+	u64 bits = 3;
+	int i, ret;
+
+	/* 'arg value' pairs may override defaults */
+	for (i = 2; i < n - 1; i += 2) {
+		if (!strcasecmp(argv[i], "bits")) {
+			if (kstrtou64(argv[i + 1], 0, &bits) || bits > 4) {
+				pr_info("invalid bits %d\n", (int)bits);
+				break;
+			}
+		} else if (!strcasecmp(argv[i], "start")) {
+			start = argv[i + 1];
+		} else if (!strcasecmp(argv[i], "end")) {
+			end = argv[i + 1];
+		} else {
+			break;
+		}
+	}
+	if (i != n)
+		return ERR_PTR(-EINVAL);
+
+	cur = kzalloc(sizeof(*cur) + strlen(name) + sizeof(gap), GFP_KERNEL);
+	if (!cur) {
+		pr_info("%s: no memory to add %s\n", __func__, name);
+		return ERR_PTR(-ENOMEM);
+	}
+	strcpy(ksn_name(cur), name);
+	if (blacklisted(start) || blacklisted(end))
+		return ERR_PTR(-EINVAL);
+
+	cur->ks = kstats_new(name, bits);
+	if (!cur->ks)
+		goto fail;
+
+	if (!end || !*end) {
+		/* try to create an entry with the gap between calls */
+		memcpy(cur->name, gap, sizeof(gap) - 1);
+		cur->ks_gap = kstats_new(cur->name, bits);
+
+		cur->kret.entry_handler = ks_kretp_start;
+		cur->kret.handler = ks_kretp_end;
+		cur->kret.data_size = 0;
+		cur->kret.kp.symbol_name = start;
+		ret = register_kretprobe(&cur->kret);
+		if (ret)
+			goto fail;
+	} else if (strncmp(start, tp_prefix, strlen(tp_prefix)) != 0) {
+		pr_info("XXX use kprobe on '%s', '%s'\n", start, end);
+		cur->kp2.symbol_name = end;
+		cur->kp2.pre_handler = ks_kprobe_end;
+		if (register_kprobe(&cur->kp2))
+			goto fail;
+		cur->kp1.symbol_name = start;
+		cur->kp1.pre_handler = ks_kprobe_start;
+		if (register_kprobe(&cur->kp1))
+			goto fail;
+	} else {
+		cur->tp1 = (void *)kallsyms_lookup_name(start);
+		cur->tp2 = (void *)kallsyms_lookup_name(end);
+		if (!cur->tp1 || !cur->tp2)
+			goto fail;
+#ifndef CONFIG_TRACEPOINTS
+		goto fail;
+#else
+		ret = tracepoint_probe_register(cur->tp1, ks_tp_start, cur);
+		if (ret)
+			goto fail;
+		ret = tracepoint_probe_register(cur->tp2, ks_tp_end, cur);
+		if (ret)
+			goto fail;
+#endif
+	}
+	return cur;
+
+fail:
+	ks_node_delete(cur);
+	return ERR_PTR(-EINVAL);
+
+}
+
+static int ks_list_nodes(struct seq_file *p)
+{
+	struct ks_node *cur;
+	const char *sep = "";
+
+	mutex_lock(&ks_mutex);
+	list_for_each_entry(cur, &ks_user_nodes, link) {
+		seq_printf(p, "%s%s", sep, ksn_name(cur));
+		sep = " ";
+	}
+	mutex_unlock(&ks_mutex);
+	seq_printf(p, "\n");
+	return 0;
+}
+
+/* Split a string into words, returns number of words */
+static int ks_split_command(char *s, char *words[], int count)
+{
+	int i = 0, n;
+
+	for (n = 0; n < count; n++) {
+		/* Skip and clear leading whitespace */
+		while (s[i] && strchr(" \t\r\n", s[i]))
+			s[i++] = '\0';
+		words[n] = s + i; /* Tentative offset */
+		/* Find end of word */
+		while (s[i] && s[i] > ' ' && s[i] < 127)
+			i++;
+		if (s + i == words[n])
+			break;
+	}
+	return n;
+}
+
+/* Delete one/all nodes (name == NULL). Returns true if some are deleted */
+static bool ks_delete_nodes(const char *name)
+{
+	struct ks_node *tmp, *cur;
+	bool found = false;
+
+	mutex_lock(&ks_mutex);
+	list_for_each_entry_safe(cur, tmp, &ks_user_nodes, link) {
+		if (name != NULL && strcmp(ksn_name(cur), name))
+			continue; /* no match */
+		found = true;
+		list_del(&cur->link);
+		ks_node_delete(cur);
+	}
+	mutex_unlock(&ks_mutex);
+	return found;
+}
+
+static int ks_control_write(char *buf, int ret)
+{
+	char *args[10];	/* we don't need more than 8 */
+	struct ks_node *cur;
+	int n;
+
+	n = ks_split_command(buf, args, ARRAY_SIZE(args));
+	if (n < 2 || n == ARRAY_SIZE(args))
+		return -EINVAL;
+	if (!strcasecmp(args[0], "remove")) {
+		if (n != 2)
+			return -EINVAL;
+		if (!ks_delete_nodes(args[1]))
+			return -ENOENT;
+	} else if (!strcasecmp(args[0], "trace")) {
+		cur = ks_node_new(n, args);
+		if (IS_ERR_OR_NULL(cur))
+			return PTR_ERR(cur);
+		mutex_lock(&ks_mutex);
+		list_add(&cur->link, &ks_user_nodes);
+		mutex_unlock(&ks_mutex);
+	} else {
+		ret = -EINVAL;
+	}
+	return ret;
+}
-- 
2.25.0.265.gbab2e86ba0-goog

