Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBA2C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 20:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1156206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 20:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731893AbgBKUzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 15:55:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:35570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727786AbgBKUzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 15:55:23 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60CDA206D6;
        Tue, 11 Feb 2020 20:55:21 +0000 (UTC)
Date:   Tue, 11 Feb 2020 15:55:19 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [GIT PULL] tracing: Various fixes for v5.6-rc1
Message-ID: <20200211155519.64c8c589@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Various fixes:

 - Fix an uninitialized variable

 - Fix compile bug to bootconfig userspace tool (in tools directory)

 - Suppress some error messages of bootconfig userspace tool

 - Remove unneeded CONFIG_LIBXBC from bootconfig

 - Allocate bootconfig xbc_nodes dynamically.
   To ease complaints about taking up static memory at boot up

 - Use of parse_args() to parse bootconfig instead of strstr() usage
   Prevents issues of double quotes containing the interested string

 - Fix missing ring_buffer_nest_end() on synthetic event error path

 - Return zero not -EINVAL on soft disabled synthetic event
   (soft disabling must be the same as hard disabling, which returns zero)

 - Consolidate synthetic event code (remove duplicate code)


Please pull the latest trace-v5.6-rc1 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.6-rc1

Tag SHA1: 2c705fb783ee17474ff32f0b48024b70727732e5
Head SHA1: 7276531d4036f5db2af15c8b6caa02e7741f5d80


Gustavo A. R. Silva (1):
      tracing/kprobe: Fix uninitialized variable bug

Masami Hiramatsu (4):
      tools/bootconfig: Fix wrong __VA_ARGS__ usage
      bootconfig: Remove unneeded CONFIG_LIBXBC
      bootconfig: Allocate xbc_nodes array dynamically
      tools/bootconfig: Suppress non-error messages

Steven Rostedt (VMware) (1):
      bootconfig: Use parse_args() to find bootconfig and '--'

Tom Zanussi (3):
      tracing: Add missing nest end to synth_event_trace_start() error case
      tracing: Don't return -EINVAL when tracing soft disabled synth events
      tracing: Consolidate trace() functions

----
 include/linux/trace_events.h              |   2 +-
 init/Kconfig                              |   1 -
 init/main.c                               |  37 ++++-
 kernel/trace/trace_events_hist.c          | 227 +++++++++++-------------------
 kernel/trace/trace_kprobe.c               |   2 +-
 lib/Kconfig                               |   3 -
 lib/Makefile                              |   2 +-
 lib/bootconfig.c                          |  15 +-
 tools/bootconfig/include/linux/memblock.h |  12 ++
 tools/bootconfig/include/linux/printk.h   |   2 +-
 tools/bootconfig/main.c                   |  28 ++--
 tools/bootconfig/test-bootconfig.sh       |   9 ++
 12 files changed, 167 insertions(+), 173 deletions(-)
 create mode 100644 tools/bootconfig/include/linux/memblock.h
---------------------------
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 67f528ecb9e5..21098298b49b 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -424,7 +424,7 @@ struct synth_event_trace_state {
 	struct synth_event *event;
 	unsigned int cur_field;
 	unsigned int n_u64;
-	bool enabled;
+	bool disabled;
 	bool add_next;
 	bool add_name;
 };
diff --git a/init/Kconfig b/init/Kconfig
index 9506299a53e3..4a672c6629d0 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1218,7 +1218,6 @@ endif
 config BOOT_CONFIG
 	bool "Boot config support"
 	depends on BLK_DEV_INITRD
-	select LIBXBC
 	default y
 	help
 	  Extra boot config allows system admin to pass a config file as
diff --git a/init/main.c b/init/main.c
index 491f1cdb3105..59248717c925 100644
--- a/init/main.c
+++ b/init/main.c
@@ -142,6 +142,15 @@ static char *extra_command_line;
 /* Extra init arguments */
 static char *extra_init_args;
 
+#ifdef CONFIG_BOOT_CONFIG
+/* Is bootconfig on command line? */
+static bool bootconfig_found;
+static bool initargs_found;
+#else
+# define bootconfig_found false
+# define initargs_found false
+#endif
+
 static char *execute_command;
 static char *ramdisk_execute_command;
 
@@ -336,17 +345,30 @@ u32 boot_config_checksum(unsigned char *p, u32 size)
 	return ret;
 }
 
+static int __init bootconfig_params(char *param, char *val,
+				    const char *unused, void *arg)
+{
+	if (strcmp(param, "bootconfig") == 0) {
+		bootconfig_found = true;
+	} else if (strcmp(param, "--") == 0) {
+		initargs_found = true;
+	}
+	return 0;
+}
+
 static void __init setup_boot_config(const char *cmdline)
 {
+	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
 	u32 size, csum;
 	char *data, *copy;
-	const char *p;
 	u32 *hdr;
 	int ret;
 
-	p = strstr(cmdline, "bootconfig");
-	if (!p || (p != cmdline && !isspace(*(p-1))) ||
-	    (p[10] && !isspace(p[10])))
+	strlcpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
+	parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
+		   bootconfig_params);
+
+	if (!bootconfig_found)
 		return;
 
 	if (!initrd_end)
@@ -563,11 +585,12 @@ static void __init setup_command_line(char *command_line)
 		 * to init.
 		 */
 		len = strlen(saved_command_line);
-		if (!strstr(boot_command_line, " -- ")) {
+		if (initargs_found) {
+			saved_command_line[len++] = ' ';
+		} else {
 			strcpy(saved_command_line + len, " -- ");
 			len += 4;
-		} else
-			saved_command_line[len++] = ' ';
+		}
 
 		strcpy(saved_command_line + len, extra_init_args);
 	}
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index b3bcfd8c7332..65b54d6a1422 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1791,6 +1791,60 @@ void synth_event_cmd_init(struct dynevent_cmd *cmd, char *buf, int maxlen)
 }
 EXPORT_SYMBOL_GPL(synth_event_cmd_init);
 
+static inline int
+__synth_event_trace_start(struct trace_event_file *file,
+			  struct synth_event_trace_state *trace_state)
+{
+	int entry_size, fields_size = 0;
+	int ret = 0;
+
+	/*
+	 * Normal event tracing doesn't get called at all unless the
+	 * ENABLED bit is set (which attaches the probe thus allowing
+	 * this code to be called, etc).  Because this is called
+	 * directly by the user, we don't have that but we still need
+	 * to honor not logging when disabled.  For the the iterated
+	 * trace case, we save the enabed state upon start and just
+	 * ignore the following data calls.
+	 */
+	if (!(file->flags & EVENT_FILE_FL_ENABLED) ||
+	    trace_trigger_soft_disabled(file)) {
+		trace_state->disabled = true;
+		ret = -ENOENT;
+		goto out;
+	}
+
+	trace_state->event = file->event_call->data;
+
+	fields_size = trace_state->event->n_u64 * sizeof(u64);
+
+	/*
+	 * Avoid ring buffer recursion detection, as this event
+	 * is being performed within another event.
+	 */
+	trace_state->buffer = file->tr->array_buffer.buffer;
+	ring_buffer_nest_start(trace_state->buffer);
+
+	entry_size = sizeof(*trace_state->entry) + fields_size;
+	trace_state->entry = trace_event_buffer_reserve(&trace_state->fbuffer,
+							file,
+							entry_size);
+	if (!trace_state->entry) {
+		ring_buffer_nest_end(trace_state->buffer);
+		ret = -EINVAL;
+	}
+out:
+	return ret;
+}
+
+static inline void
+__synth_event_trace_end(struct synth_event_trace_state *trace_state)
+{
+	trace_event_buffer_commit(&trace_state->fbuffer);
+
+	ring_buffer_nest_end(trace_state->buffer);
+}
+
 /**
  * synth_event_trace - Trace a synthetic event
  * @file: The trace_event_file representing the synthetic event
@@ -1812,71 +1866,38 @@ EXPORT_SYMBOL_GPL(synth_event_cmd_init);
  */
 int synth_event_trace(struct trace_event_file *file, unsigned int n_vals, ...)
 {
-	struct trace_event_buffer fbuffer;
-	struct synth_trace_event *entry;
-	struct trace_buffer *buffer;
-	struct synth_event *event;
+	struct synth_event_trace_state state;
 	unsigned int i, n_u64;
-	int fields_size = 0;
 	va_list args;
-	int ret = 0;
-
-	/*
-	 * Normal event generation doesn't get called at all unless
-	 * the ENABLED bit is set (which attaches the probe thus
-	 * allowing this code to be called, etc).  Because this is
-	 * called directly by the user, we don't have that but we
-	 * still need to honor not logging when disabled.
-	 */
-	if (!(file->flags & EVENT_FILE_FL_ENABLED))
-		return 0;
-
-	event = file->event_call->data;
-
-	if (n_vals != event->n_fields)
-		return -EINVAL;
-
-	if (trace_trigger_soft_disabled(file))
-		return -EINVAL;
-
-	fields_size = event->n_u64 * sizeof(u64);
-
-	/*
-	 * Avoid ring buffer recursion detection, as this event
-	 * is being performed within another event.
-	 */
-	buffer = file->tr->array_buffer.buffer;
-	ring_buffer_nest_start(buffer);
+	int ret;
 
-	entry = trace_event_buffer_reserve(&fbuffer, file,
-					   sizeof(*entry) + fields_size);
-	if (!entry) {
-		ret = -EINVAL;
-		goto out;
+	ret = __synth_event_trace_start(file, &state);
+	if (ret) {
+		if (ret == -ENOENT)
+			ret = 0; /* just disabled, not really an error */
+		return ret;
 	}
 
 	va_start(args, n_vals);
-	for (i = 0, n_u64 = 0; i < event->n_fields; i++) {
+	for (i = 0, n_u64 = 0; i < state.event->n_fields; i++) {
 		u64 val;
 
 		val = va_arg(args, u64);
 
-		if (event->fields[i]->is_string) {
+		if (state.event->fields[i]->is_string) {
 			char *str_val = (char *)(long)val;
-			char *str_field = (char *)&entry->fields[n_u64];
+			char *str_field = (char *)&state.entry->fields[n_u64];
 
 			strscpy(str_field, str_val, STR_VAR_LEN_MAX);
 			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
 		} else {
-			entry->fields[n_u64] = val;
+			state.entry->fields[n_u64] = val;
 			n_u64++;
 		}
 	}
 	va_end(args);
 
-	trace_event_buffer_commit(&fbuffer);
-out:
-	ring_buffer_nest_end(buffer);
+	__synth_event_trace_end(&state);
 
 	return ret;
 }
@@ -1903,64 +1924,31 @@ EXPORT_SYMBOL_GPL(synth_event_trace);
 int synth_event_trace_array(struct trace_event_file *file, u64 *vals,
 			    unsigned int n_vals)
 {
-	struct trace_event_buffer fbuffer;
-	struct synth_trace_event *entry;
-	struct trace_buffer *buffer;
-	struct synth_event *event;
+	struct synth_event_trace_state state;
 	unsigned int i, n_u64;
-	int fields_size = 0;
-	int ret = 0;
-
-	/*
-	 * Normal event generation doesn't get called at all unless
-	 * the ENABLED bit is set (which attaches the probe thus
-	 * allowing this code to be called, etc).  Because this is
-	 * called directly by the user, we don't have that but we
-	 * still need to honor not logging when disabled.
-	 */
-	if (!(file->flags & EVENT_FILE_FL_ENABLED))
-		return 0;
-
-	event = file->event_call->data;
-
-	if (n_vals != event->n_fields)
-		return -EINVAL;
-
-	if (trace_trigger_soft_disabled(file))
-		return -EINVAL;
-
-	fields_size = event->n_u64 * sizeof(u64);
-
-	/*
-	 * Avoid ring buffer recursion detection, as this event
-	 * is being performed within another event.
-	 */
-	buffer = file->tr->array_buffer.buffer;
-	ring_buffer_nest_start(buffer);
+	int ret;
 
-	entry = trace_event_buffer_reserve(&fbuffer, file,
-					   sizeof(*entry) + fields_size);
-	if (!entry) {
-		ret = -EINVAL;
-		goto out;
+	ret = __synth_event_trace_start(file, &state);
+	if (ret) {
+		if (ret == -ENOENT)
+			ret = 0; /* just disabled, not really an error */
+		return ret;
 	}
 
-	for (i = 0, n_u64 = 0; i < event->n_fields; i++) {
-		if (event->fields[i]->is_string) {
+	for (i = 0, n_u64 = 0; i < state.event->n_fields; i++) {
+		if (state.event->fields[i]->is_string) {
 			char *str_val = (char *)(long)vals[i];
-			char *str_field = (char *)&entry->fields[n_u64];
+			char *str_field = (char *)&state.entry->fields[n_u64];
 
 			strscpy(str_field, str_val, STR_VAR_LEN_MAX);
 			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
 		} else {
-			entry->fields[n_u64] = vals[i];
+			state.entry->fields[n_u64] = vals[i];
 			n_u64++;
 		}
 	}
 
-	trace_event_buffer_commit(&fbuffer);
-out:
-	ring_buffer_nest_end(buffer);
+	__synth_event_trace_end(&state);
 
 	return ret;
 }
@@ -1997,58 +1985,17 @@ EXPORT_SYMBOL_GPL(synth_event_trace_array);
 int synth_event_trace_start(struct trace_event_file *file,
 			    struct synth_event_trace_state *trace_state)
 {
-	struct synth_trace_event *entry;
-	int fields_size = 0;
-	int ret = 0;
+	int ret;
 
-	if (!trace_state) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (!trace_state)
+		return -EINVAL;
 
 	memset(trace_state, '\0', sizeof(*trace_state));
 
-	/*
-	 * Normal event tracing doesn't get called at all unless the
-	 * ENABLED bit is set (which attaches the probe thus allowing
-	 * this code to be called, etc).  Because this is called
-	 * directly by the user, we don't have that but we still need
-	 * to honor not logging when disabled.  For the the iterated
-	 * trace case, we save the enabed state upon start and just
-	 * ignore the following data calls.
-	 */
-	if (!(file->flags & EVENT_FILE_FL_ENABLED)) {
-		trace_state->enabled = false;
-		goto out;
-	}
-
-	trace_state->enabled = true;
-
-	trace_state->event = file->event_call->data;
-
-	if (trace_trigger_soft_disabled(file)) {
-		ret = -EINVAL;
-		goto out;
-	}
+	ret = __synth_event_trace_start(file, trace_state);
+	if (ret == -ENOENT)
+		ret = 0; /* just disabled, not really an error */
 
-	fields_size = trace_state->event->n_u64 * sizeof(u64);
-
-	/*
-	 * Avoid ring buffer recursion detection, as this event
-	 * is being performed within another event.
-	 */
-	trace_state->buffer = file->tr->array_buffer.buffer;
-	ring_buffer_nest_start(trace_state->buffer);
-
-	entry = trace_event_buffer_reserve(&trace_state->fbuffer, file,
-					   sizeof(*entry) + fields_size);
-	if (!entry) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	trace_state->entry = entry;
-out:
 	return ret;
 }
 EXPORT_SYMBOL_GPL(synth_event_trace_start);
@@ -2081,7 +2028,7 @@ static int __synth_event_add_val(const char *field_name, u64 val,
 		trace_state->add_next = true;
 	}
 
-	if (!trace_state->enabled)
+	if (trace_state->disabled)
 		goto out;
 
 	event = trace_state->event;
@@ -2216,9 +2163,7 @@ int synth_event_trace_end(struct synth_event_trace_state *trace_state)
 	if (!trace_state)
 		return -EINVAL;
 
-	trace_event_buffer_commit(&trace_state->fbuffer);
-
-	ring_buffer_nest_end(trace_state->buffer);
+	__synth_event_trace_end(trace_state);
 
 	return 0;
 }
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 51efc790aea8..21bafd48f2ac 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1012,7 +1012,7 @@ int __kprobe_event_add_fields(struct dynevent_cmd *cmd, ...)
 {
 	struct dynevent_arg arg;
 	va_list args;
-	int ret;
+	int ret = 0;
 
 	if (cmd->type != DYNEVENT_TYPE_KPROBE)
 		return -EINVAL;
diff --git a/lib/Kconfig b/lib/Kconfig
index 10012b646009..6e790dc55c5b 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -566,9 +566,6 @@ config DIMLIB
 config LIBFDT
 	bool
 
-config LIBXBC
-	bool
-
 config OID_REGISTRY
 	tristate
 	help
diff --git a/lib/Makefile b/lib/Makefile
index 75a64d2552a2..74c1223828c1 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -228,7 +228,7 @@ $(foreach file, $(libfdt_files), \
 	$(eval CFLAGS_$(file) = -I $(srctree)/scripts/dtc/libfdt))
 lib-$(CONFIG_LIBFDT) += $(libfdt_files)
 
-lib-$(CONFIG_LIBXBC) += bootconfig.o
+lib-$(CONFIG_BOOT_CONFIG) += bootconfig.o
 
 obj-$(CONFIG_RBTREE_TEST) += rbtree_test.o
 obj-$(CONFIG_INTERVAL_TREE_TEST) += interval_tree_test.o
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index afb2e767e6fe..3ea601a2eba5 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -6,12 +6,13 @@
 
 #define pr_fmt(fmt)    "bootconfig: " fmt
 
+#include <linux/bootconfig.h>
 #include <linux/bug.h>
 #include <linux/ctype.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
+#include <linux/memblock.h>
 #include <linux/printk.h>
-#include <linux/bootconfig.h>
 #include <linux/string.h>
 
 /*
@@ -23,7 +24,7 @@
  * node (for array).
  */
 
-static struct xbc_node xbc_nodes[XBC_NODE_MAX] __initdata;
+static struct xbc_node *xbc_nodes __initdata;
 static int xbc_node_num __initdata;
 static char *xbc_data __initdata;
 static size_t xbc_data_size __initdata;
@@ -719,7 +720,8 @@ void __init xbc_destroy_all(void)
 	xbc_data = NULL;
 	xbc_data_size = 0;
 	xbc_node_num = 0;
-	memset(xbc_nodes, 0, sizeof(xbc_nodes));
+	memblock_free(__pa(xbc_nodes), sizeof(struct xbc_node) * XBC_NODE_MAX);
+	xbc_nodes = NULL;
 }
 
 /**
@@ -748,6 +750,13 @@ int __init xbc_init(char *buf)
 		return -ERANGE;
 	}
 
+	xbc_nodes = memblock_alloc(sizeof(struct xbc_node) * XBC_NODE_MAX,
+				   SMP_CACHE_BYTES);
+	if (!xbc_nodes) {
+		pr_err("Failed to allocate memory for bootconfig nodes.\n");
+		return -ENOMEM;
+	}
+	memset(xbc_nodes, 0, sizeof(struct xbc_node) * XBC_NODE_MAX);
 	xbc_data = buf;
 	xbc_data_size = ret + 1;
 	last_parent = NULL;
diff --git a/tools/bootconfig/include/linux/memblock.h b/tools/bootconfig/include/linux/memblock.h
new file mode 100644
index 000000000000..7862f217d85d
--- /dev/null
+++ b/tools/bootconfig/include/linux/memblock.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _XBC_LINUX_MEMBLOCK_H
+#define _XBC_LINUX_MEMBLOCK_H
+
+#include <stdlib.h>
+
+#define __pa(addr)	(addr)
+#define SMP_CACHE_BYTES	0
+#define memblock_alloc(size, align)	malloc(size)
+#define memblock_free(paddr, size)	free(paddr)
+
+#endif
diff --git a/tools/bootconfig/include/linux/printk.h b/tools/bootconfig/include/linux/printk.h
index 017bcd6912a5..e978a63d3222 100644
--- a/tools/bootconfig/include/linux/printk.h
+++ b/tools/bootconfig/include/linux/printk.h
@@ -7,7 +7,7 @@
 /* controllable printf */
 extern int pr_output;
 #define printk(fmt, ...)	\
-	(pr_output ? printf(fmt, __VA_ARGS__) : 0)
+	(pr_output ? printf(fmt, ##__VA_ARGS__) : 0)
 
 #define pr_err printk
 #define pr_warn	printk
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 47f488458328..e18eeb070562 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -140,7 +140,7 @@ int load_xbc_from_initrd(int fd, char **buf)
 		return 0;
 
 	if (lseek(fd, -8, SEEK_END) < 0) {
-		printf("Failed to lseek: %d\n", -errno);
+		pr_err("Failed to lseek: %d\n", -errno);
 		return -errno;
 	}
 
@@ -155,7 +155,7 @@ int load_xbc_from_initrd(int fd, char **buf)
 		return 0;
 
 	if (lseek(fd, stat.st_size - 8 - size, SEEK_SET) < 0) {
-		printf("Failed to lseek: %d\n", -errno);
+		pr_err("Failed to lseek: %d\n", -errno);
 		return -errno;
 	}
 
@@ -166,7 +166,7 @@ int load_xbc_from_initrd(int fd, char **buf)
 	/* Wrong Checksum, maybe no boot config here */
 	rcsum = checksum((unsigned char *)*buf, size);
 	if (csum != rcsum) {
-		printf("checksum error: %d != %d\n", csum, rcsum);
+		pr_err("checksum error: %d != %d\n", csum, rcsum);
 		return 0;
 	}
 
@@ -185,13 +185,13 @@ int show_xbc(const char *path)
 
 	fd = open(path, O_RDONLY);
 	if (fd < 0) {
-		printf("Failed to open initrd %s: %d\n", path, fd);
+		pr_err("Failed to open initrd %s: %d\n", path, fd);
 		return -errno;
 	}
 
 	ret = load_xbc_from_initrd(fd, &buf);
 	if (ret < 0)
-		printf("Failed to load a boot config from initrd: %d\n", ret);
+		pr_err("Failed to load a boot config from initrd: %d\n", ret);
 	else
 		xbc_show_compact_tree();
 
@@ -209,7 +209,7 @@ int delete_xbc(const char *path)
 
 	fd = open(path, O_RDWR);
 	if (fd < 0) {
-		printf("Failed to open initrd %s: %d\n", path, fd);
+		pr_err("Failed to open initrd %s: %d\n", path, fd);
 		return -errno;
 	}
 
@@ -222,7 +222,7 @@ int delete_xbc(const char *path)
 	pr_output = 1;
 	if (size < 0) {
 		ret = size;
-		printf("Failed to load a boot config from initrd: %d\n", ret);
+		pr_err("Failed to load a boot config from initrd: %d\n", ret);
 	} else if (size > 0) {
 		ret = fstat(fd, &stat);
 		if (!ret)
@@ -245,7 +245,7 @@ int apply_xbc(const char *path, const char *xbc_path)
 
 	ret = load_xbc_file(xbc_path, &buf);
 	if (ret < 0) {
-		printf("Failed to load %s : %d\n", xbc_path, ret);
+		pr_err("Failed to load %s : %d\n", xbc_path, ret);
 		return ret;
 	}
 	size = strlen(buf) + 1;
@@ -262,7 +262,7 @@ int apply_xbc(const char *path, const char *xbc_path)
 	/* Check the data format */
 	ret = xbc_init(buf);
 	if (ret < 0) {
-		printf("Failed to parse %s: %d\n", xbc_path, ret);
+		pr_err("Failed to parse %s: %d\n", xbc_path, ret);
 		free(data);
 		free(buf);
 		return ret;
@@ -279,20 +279,20 @@ int apply_xbc(const char *path, const char *xbc_path)
 	/* Remove old boot config if exists */
 	ret = delete_xbc(path);
 	if (ret < 0) {
-		printf("Failed to delete previous boot config: %d\n", ret);
+		pr_err("Failed to delete previous boot config: %d\n", ret);
 		return ret;
 	}
 
 	/* Apply new one */
 	fd = open(path, O_RDWR | O_APPEND);
 	if (fd < 0) {
-		printf("Failed to open %s: %d\n", path, fd);
+		pr_err("Failed to open %s: %d\n", path, fd);
 		return fd;
 	}
 	/* TODO: Ensure the @path is initramfs/initrd image */
 	ret = write(fd, data, size + 8);
 	if (ret < 0) {
-		printf("Failed to apply a boot config: %d\n", ret);
+		pr_err("Failed to apply a boot config: %d\n", ret);
 		return ret;
 	}
 	close(fd);
@@ -334,12 +334,12 @@ int main(int argc, char **argv)
 	}
 
 	if (apply && delete) {
-		printf("Error: You can not specify both -a and -d at once.\n");
+		pr_err("Error: You can not specify both -a and -d at once.\n");
 		return usage();
 	}
 
 	if (optind >= argc) {
-		printf("Error: No initrd is specified.\n");
+		pr_err("Error: No initrd is specified.\n");
 		return usage();
 	}
 
diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index 87725e8723f8..1de06de328e2 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -64,6 +64,15 @@ echo "File size check"
 new_size=$(stat -c %s $INITRD)
 xpass test $new_size -eq $initrd_size
 
+echo "No error messge while applying"
+OUTFILE=`mktemp tempout-XXXX`
+dd if=/dev/zero of=$INITRD bs=4096 count=1
+printf " \0\0\0 \0\0\0" >> $INITRD
+$BOOTCONF -a $TEMPCONF $INITRD > $OUTFILE 2>&1
+xfail grep -i "failed" $OUTFILE
+xfail grep -i "error" $OUTFILE
+rm $OUTFILE
+
 echo "Max node number check"
 
 echo -n > $TEMPCONF
