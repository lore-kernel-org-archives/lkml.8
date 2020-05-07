Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387B6C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1069720A8B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgEGSd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:33:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:34302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgEGSdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:33:55 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A216E2082E;
        Thu,  7 May 2020 18:33:54 +0000 (UTC)
Date:   Thu, 7 May 2020 14:33:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [GIT PULL] tracing: Fixes for v5.7
Message-ID: <20200507143353.3f92a389@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

This includes the following tracing fixes:

 - Fix bootconfig causing kernels to fail with CONFIG_BLK_DEV_RAM enabled
 - Fix allocation leaks in bootconfig tool
 - Fix a double initialization of a variable
 - Fix API bootconfig usage from kprobe boot time events
 - Reject NULL location for kprobes
 - Fix crash caused by preempt delay module not cleaning up kthread
   correctly
 - Add vmalloc_sync_mappings() to prevent x86_64 page faults from
   recursively faulting from tracing page faults
 - Fix comment in gpu/trace kerneldoc header
 - Fix documentation of how to create a trace event class
 - Make the local tracing_snapshot_instance_cond() function static


Please pull the latest trace-v5.7-rc3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.7-rc3

Tag SHA1: e3d5e831583d2024b49104aa791e699974ccfe09
Head SHA1: 8842604446d1f005abcbf8c63c12eabdb5695094


Masami Hiramatsu (4):
      bootconfig: Fix to remove bootconfig data from initrd while boot
      tracing/kprobes: Fix a double initialization typo
      tracing/boottime: Fix kprobe event API usage
      tracing/kprobes: Reject new event if loc is NULL

Steven Rostedt (VMware) (2):
      tracing: Wait for preempt irq delay thread to finish
      tracing: Add a vmalloc_sync_mappings() for safe measure

Wei Yang (1):
      tracing: Fix doc mistakes in trace sample

Yiwei Zhang (1):
      gpu/trace: Minor comment updates for gpu_mem_total tracepoint

Yunfeng Ye (1):
      tools/bootconfig: Fix resource leak in apply_xbc()

Zou Wei (1):
      tracing: Make tracing_snapshot_instance_cond() static

----
 include/trace/events/gpu_mem.h             |  2 +-
 init/main.c                                | 69 ++++++++++++++++++++++--------
 kernel/trace/preemptirq_delay_test.c       | 30 ++++++++++---
 kernel/trace/trace.c                       | 16 ++++++-
 kernel/trace/trace_boot.c                  | 20 ++++-----
 kernel/trace/trace_kprobe.c                |  8 +++-
 samples/trace_events/trace-events-sample.h |  2 +-
 tools/bootconfig/main.c                    |  9 ++--
 8 files changed, 114 insertions(+), 42 deletions(-)
---------------------------
diff --git a/include/trace/events/gpu_mem.h b/include/trace/events/gpu_mem.h
index 1897822a9150..26d871f96e94 100644
--- a/include/trace/events/gpu_mem.h
+++ b/include/trace/events/gpu_mem.h
@@ -24,7 +24,7 @@
  *
  * @pid: Put 0 for global total, while positive pid for process total.
  *
- * @size: Virtual size of the allocation in bytes.
+ * @size: Size of the allocation in bytes.
  *
  */
 TRACE_EVENT(gpu_mem_total,
diff --git a/init/main.c b/init/main.c
index a48617f2e5e5..1a5da2c2660c 100644
--- a/init/main.c
+++ b/init/main.c
@@ -257,6 +257,47 @@ static int __init loglevel(char *str)
 
 early_param("loglevel", loglevel);
 
+#ifdef CONFIG_BLK_DEV_INITRD
+static void * __init get_boot_config_from_initrd(u32 *_size, u32 *_csum)
+{
+	u32 size, csum;
+	char *data;
+	u32 *hdr;
+
+	if (!initrd_end)
+		return NULL;
+
+	data = (char *)initrd_end - BOOTCONFIG_MAGIC_LEN;
+	if (memcmp(data, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN))
+		return NULL;
+
+	hdr = (u32 *)(data - 8);
+	size = hdr[0];
+	csum = hdr[1];
+
+	data = ((void *)hdr) - size;
+	if ((unsigned long)data < initrd_start) {
+		pr_err("bootconfig size %d is greater than initrd size %ld\n",
+			size, initrd_end - initrd_start);
+		return NULL;
+	}
+
+	/* Remove bootconfig from initramfs/initrd */
+	initrd_end = (unsigned long)data;
+	if (_size)
+		*_size = size;
+	if (_csum)
+		*_csum = csum;
+
+	return data;
+}
+#else
+static void * __init get_boot_config_from_initrd(u32 *_size, u32 *_csum)
+{
+	return NULL;
+}
+#endif
+
 #ifdef CONFIG_BOOT_CONFIG
 
 char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
@@ -357,9 +398,12 @@ static void __init setup_boot_config(const char *cmdline)
 	int pos;
 	u32 size, csum;
 	char *data, *copy;
-	u32 *hdr;
 	int ret;
 
+	data = get_boot_config_from_initrd(&size, &csum);
+	if (!data)
+		goto not_found;
+
 	strlcpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
 	parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
 		   bootconfig_params);
@@ -367,27 +411,12 @@ static void __init setup_boot_config(const char *cmdline)
 	if (!bootconfig_found)
 		return;
 
-	if (!initrd_end)
-		goto not_found;
-
-	data = (char *)initrd_end - BOOTCONFIG_MAGIC_LEN;
-	if (memcmp(data, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN))
-		goto not_found;
-
-	hdr = (u32 *)(data - 8);
-	size = hdr[0];
-	csum = hdr[1];
-
 	if (size >= XBC_DATA_MAX) {
 		pr_err("bootconfig size %d greater than max size %d\n",
 			size, XBC_DATA_MAX);
 		return;
 	}
 
-	data = ((void *)hdr) - size;
-	if ((unsigned long)data < initrd_start)
-		goto not_found;
-
 	if (boot_config_checksum((unsigned char *)data, size) != csum) {
 		pr_err("bootconfig checksum failed\n");
 		return;
@@ -420,8 +449,14 @@ static void __init setup_boot_config(const char *cmdline)
 not_found:
 	pr_err("'bootconfig' found on command line, but no bootconfig found\n");
 }
+
 #else
-#define setup_boot_config(cmdline)	do { } while (0)
+
+static void __init setup_boot_config(const char *cmdline)
+{
+	/* Remove bootconfig data from initrd */
+	get_boot_config_from_initrd(NULL, NULL);
+}
 
 static int __init warn_bootconfig(char *str)
 {
diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
index 31c0fad4cb9e..c4c86de63cf9 100644
--- a/kernel/trace/preemptirq_delay_test.c
+++ b/kernel/trace/preemptirq_delay_test.c
@@ -113,22 +113,42 @@ static int preemptirq_delay_run(void *data)
 
 	for (i = 0; i < s; i++)
 		(testfuncs[i])(i);
+
+	set_current_state(TASK_INTERRUPTIBLE);
+	while (!kthread_should_stop()) {
+		schedule();
+		set_current_state(TASK_INTERRUPTIBLE);
+	}
+
+	__set_current_state(TASK_RUNNING);
+
 	return 0;
 }
 
-static struct task_struct *preemptirq_start_test(void)
+static int preemptirq_run_test(void)
 {
+	struct task_struct *task;
+
 	char task_name[50];
 
 	snprintf(task_name, sizeof(task_name), "%s_test", test_mode);
-	return kthread_run(preemptirq_delay_run, NULL, task_name);
+	task =  kthread_run(preemptirq_delay_run, NULL, task_name);
+	if (IS_ERR(task))
+		return PTR_ERR(task);
+	if (task)
+		kthread_stop(task);
+	return 0;
 }
 
 
 static ssize_t trigger_store(struct kobject *kobj, struct kobj_attribute *attr,
 			 const char *buf, size_t count)
 {
-	preemptirq_start_test();
+	ssize_t ret;
+
+	ret = preemptirq_run_test();
+	if (ret)
+		return ret;
 	return count;
 }
 
@@ -148,11 +168,9 @@ static struct kobject *preemptirq_delay_kobj;
 
 static int __init preemptirq_delay_init(void)
 {
-	struct task_struct *test_task;
 	int retval;
 
-	test_task = preemptirq_start_test();
-	retval = PTR_ERR_OR_ZERO(test_task);
+	retval = preemptirq_run_test();
 	if (retval != 0)
 		return retval;
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8d2b98812625..29615f15a820 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -947,7 +947,8 @@ int __trace_bputs(unsigned long ip, const char *str)
 EXPORT_SYMBOL_GPL(__trace_bputs);
 
 #ifdef CONFIG_TRACER_SNAPSHOT
-void tracing_snapshot_instance_cond(struct trace_array *tr, void *cond_data)
+static void tracing_snapshot_instance_cond(struct trace_array *tr,
+					   void *cond_data)
 {
 	struct tracer *tracer = tr->current_trace;
 	unsigned long flags;
@@ -8525,6 +8526,19 @@ static int allocate_trace_buffers(struct trace_array *tr, int size)
 	 */
 	allocate_snapshot = false;
 #endif
+
+	/*
+	 * Because of some magic with the way alloc_percpu() works on
+	 * x86_64, we need to synchronize the pgd of all the tables,
+	 * otherwise the trace events that happen in x86_64 page fault
+	 * handlers can't cope with accessing the chance that a
+	 * alloc_percpu()'d memory might be touched in the page fault trace
+	 * event. Oh, and we need to audit all other alloc_percpu() and vmalloc()
+	 * calls in tracing, because something might get triggered within a
+	 * page fault trace event!
+	 */
+	vmalloc_sync_mappings();
+
 	return 0;
 }
 
diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 06d7feb5255f..9de29bb45a27 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -95,24 +95,20 @@ trace_boot_add_kprobe_event(struct xbc_node *node, const char *event)
 	struct xbc_node *anode;
 	char buf[MAX_BUF_LEN];
 	const char *val;
-	int ret;
+	int ret = 0;
 
-	kprobe_event_cmd_init(&cmd, buf, MAX_BUF_LEN);
+	xbc_node_for_each_array_value(node, "probes", anode, val) {
+		kprobe_event_cmd_init(&cmd, buf, MAX_BUF_LEN);
 
-	ret = kprobe_event_gen_cmd_start(&cmd, event, NULL);
-	if (ret)
-		return ret;
+		ret = kprobe_event_gen_cmd_start(&cmd, event, val);
+		if (ret)
+			break;
 
-	xbc_node_for_each_array_value(node, "probes", anode, val) {
-		ret = kprobe_event_add_field(&cmd, val);
+		ret = kprobe_event_gen_cmd_end(&cmd);
 		if (ret)
-			return ret;
+			pr_err("Failed to add probe: %s\n", buf);
 	}
 
-	ret = kprobe_event_gen_cmd_end(&cmd);
-	if (ret)
-		pr_err("Failed to add probe: %s\n", buf);
-
 	return ret;
 }
 #else
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index d0568af4a0ef..35989383ae11 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -453,7 +453,7 @@ static bool __within_notrace_func(unsigned long addr)
 
 static bool within_notrace_func(struct trace_kprobe *tk)
 {
-	unsigned long addr = addr = trace_kprobe_address(tk);
+	unsigned long addr = trace_kprobe_address(tk);
 	char symname[KSYM_NAME_LEN], *p;
 
 	if (!__within_notrace_func(addr))
@@ -940,6 +940,9 @@ EXPORT_SYMBOL_GPL(kprobe_event_cmd_init);
  * complete command or only the first part of it; in the latter case,
  * kprobe_event_add_fields() can be used to add more fields following this.
  *
+ * Unlikely the synth_event_gen_cmd_start(), @loc must be specified. This
+ * returns -EINVAL if @loc == NULL.
+ *
  * Return: 0 if successful, error otherwise.
  */
 int __kprobe_event_gen_cmd_start(struct dynevent_cmd *cmd, bool kretprobe,
@@ -953,6 +956,9 @@ int __kprobe_event_gen_cmd_start(struct dynevent_cmd *cmd, bool kretprobe,
 	if (cmd->type != DYNEVENT_TYPE_KPROBE)
 		return -EINVAL;
 
+	if (!loc)
+		return -EINVAL;
+
 	if (kretprobe)
 		snprintf(buf, MAX_EVENT_NAME_LEN, "r:kprobes/%s", name);
 	else
diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
index 80b4a70315b6..13a35f7cbe66 100644
--- a/samples/trace_events/trace-events-sample.h
+++ b/samples/trace_events/trace-events-sample.h
@@ -416,7 +416,7 @@ TRACE_EVENT_FN(foo_bar_with_fn,
  * Note, TRACE_EVENT() itself is simply defined as:
  *
  * #define TRACE_EVENT(name, proto, args, tstruct, assign, printk)  \
- *  DEFINE_EVENT_CLASS(name, proto, args, tstruct, assign, printk); \
+ *  DECLARE_EVENT_CLASS(name, proto, args, tstruct, assign, printk); \
  *  DEFINE_EVENT(name, name, proto, args)
  *
  * The DEFINE_EVENT() also can be declared with conditions and reg functions:
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 16b9a420e6fd..001076c51712 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -314,6 +314,7 @@ int apply_xbc(const char *path, const char *xbc_path)
 	ret = delete_xbc(path);
 	if (ret < 0) {
 		pr_err("Failed to delete previous boot config: %d\n", ret);
+		free(data);
 		return ret;
 	}
 
@@ -321,24 +322,26 @@ int apply_xbc(const char *path, const char *xbc_path)
 	fd = open(path, O_RDWR | O_APPEND);
 	if (fd < 0) {
 		pr_err("Failed to open %s: %d\n", path, fd);
+		free(data);
 		return fd;
 	}
 	/* TODO: Ensure the @path is initramfs/initrd image */
 	ret = write(fd, data, size + 8);
 	if (ret < 0) {
 		pr_err("Failed to apply a boot config: %d\n", ret);
-		return ret;
+		goto out;
 	}
 	/* Write a magic word of the bootconfig */
 	ret = write(fd, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
 	if (ret < 0) {
 		pr_err("Failed to apply a boot config magic: %d\n", ret);
-		return ret;
+		goto out;
 	}
+out:
 	close(fd);
 	free(data);
 
-	return 0;
+	return ret;
 }
 
 int usage(void)
