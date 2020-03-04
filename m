Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC191C3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834522072D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387823AbgCDJHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 04:07:47 -0500
Received: from mga03.intel.com ([134.134.136.65]:17638 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387814AbgCDJHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 04:07:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 01:07:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,513,1574150400"; 
   d="scan'208";a="413074270"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.167])
  by orsmga005.jf.intel.com with ESMTP; 04 Mar 2020 01:07:41 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V4 06/13] ftrace: Add symbols for ftrace trampolines
Date:   Wed,  4 Mar 2020 11:06:26 +0200
Message-Id: <20200304090633.420-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200304090633.420-1-adrian.hunter@intel.com>
References: <20200304090633.420-1-adrian.hunter@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Symbols are needed for tools to describe instruction addresses. Pages
allocated for ftrace's purposes need symbols to be created for them.
Add such symbols to be visible via /proc/kallsyms.

Example on x86 with CONFIG_DYNAMIC_FTRACE=y

	# echo function > /sys/kernel/debug/tracing/current_tracer
	# cat /proc/kallsyms | grep '\[__builtin__ftrace\]'
	ffffffffc0238000 t ftrace_trampoline    [__builtin__ftrace]

Note: This patch adds "__builtin__ftrace" as a module name in /proc/kallsyms for
symbols for pages allocated for ftrace's purposes, even though "__builtin__ftrace"
is not a module.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 include/linux/ftrace.h | 12 ++++---
 kernel/kallsyms.c      |  5 +++
 kernel/trace/ftrace.c  | 77 ++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 88 insertions(+), 6 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index db95244a62d4..ea726ad1fa83 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -58,9 +58,6 @@ struct ftrace_direct_func;
 const char *
 ftrace_mod_address_lookup(unsigned long addr, unsigned long *size,
 		   unsigned long *off, char **modname, char *sym);
-int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *value,
-			   char *type, char *name,
-			   char *module_name, int *exported);
 #else
 static inline const char *
 ftrace_mod_address_lookup(unsigned long addr, unsigned long *size,
@@ -68,6 +65,13 @@ ftrace_mod_address_lookup(unsigned long addr, unsigned long *size,
 {
 	return NULL;
 }
+#endif
+
+#if defined(CONFIG_FUNCTION_TRACER) && defined(CONFIG_DYNAMIC_FTRACE)
+int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *value,
+			   char *type, char *name,
+			   char *module_name, int *exported);
+#else
 static inline int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *value,
 					 char *type, char *name,
 					 char *module_name, int *exported)
@@ -76,7 +80,6 @@ static inline int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *val
 }
 #endif
 
-
 #ifdef CONFIG_FUNCTION_TRACER
 
 extern int ftrace_enabled;
@@ -207,6 +210,7 @@ struct ftrace_ops {
 	struct ftrace_ops_hash		old_hash;
 	unsigned long			trampoline;
 	unsigned long			trampoline_size;
+	struct list_head		list;
 #endif
 };
 
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 4a93511e6243..24638586a39e 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -483,6 +483,11 @@ static int get_ksymbol_mod(struct kallsym_iter *iter)
 	return 1;
 }
 
+/*
+ * ftrace_mod_get_kallsym() may also get symbols for pages allocated for ftrace
+ * purposes. In that case "__builtin__ftrace" is used as a module name, even
+ * though "__builtin__ftrace" is not a module.
+ */
 static int get_ksymbol_ftrace_mod(struct kallsym_iter *iter)
 {
 	int ret = ftrace_mod_get_kallsym(iter->pos - iter->pos_mod_end,
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 9bf1f2cd515e..aa3149fd1fc2 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2768,6 +2768,38 @@ void __weak arch_ftrace_trampoline_free(struct ftrace_ops *ops)
 {
 }
 
+/* List of trace_ops that have allocated trampolines */
+static LIST_HEAD(ftrace_ops_trampoline_list);
+
+static void ftrace_add_trampoline_to_kallsyms(struct ftrace_ops *ops)
+{
+	lockdep_assert_held(&ftrace_lock);
+	list_add_rcu(&ops->list, &ftrace_ops_trampoline_list);
+}
+
+static void ftrace_remove_trampoline_from_kallsyms(struct ftrace_ops *ops)
+{
+	lockdep_assert_held(&ftrace_lock);
+	list_del_rcu(&ops->list);
+}
+
+/*
+ * "__builtin__ftrace" is used as a module name in /proc/kallsyms for symbols
+ * for pages allocated for ftrace purposes, even though "__builtin__ftrace" is
+ * not a module.
+ */
+#define FTRACE_TRAMPOLINE_MOD "__builtin__ftrace"
+#define FTRACE_TRAMPOLINE_SYM "ftrace_trampoline"
+
+static void ftrace_trampoline_free(struct ftrace_ops *ops)
+{
+	if (ops && (ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP) &&
+	    ops->trampoline)
+		ftrace_remove_trampoline_from_kallsyms(ops);
+
+	arch_ftrace_trampoline_free(ops);
+}
+
 static void ftrace_startup_enable(int command)
 {
 	if (saved_ftrace_func != ftrace_trace_function) {
@@ -2938,7 +2970,7 @@ int ftrace_shutdown(struct ftrace_ops *ops, int command)
 			synchronize_rcu_tasks();
 
  free_ops:
-		arch_ftrace_trampoline_free(ops);
+		ftrace_trampoline_free(ops);
 	}
 
 	return 0;
@@ -6174,6 +6206,27 @@ struct ftrace_mod_map {
 	unsigned int		num_funcs;
 };
 
+static int ftrace_get_trampoline_kallsym(unsigned int symnum,
+					 unsigned long *value, char *type,
+					 char *name, char *module_name,
+					 int *exported)
+{
+	struct ftrace_ops *op;
+
+	list_for_each_entry_rcu(op, &ftrace_ops_trampoline_list, list) {
+		if (!op->trampoline || symnum--)
+			continue;
+		*value = op->trampoline;
+		*type = 't';
+		strlcpy(name, FTRACE_TRAMPOLINE_SYM, KSYM_NAME_LEN);
+		strlcpy(module_name, FTRACE_TRAMPOLINE_MOD, MODULE_NAME_LEN);
+		*exported = 0;
+		return 0;
+	}
+
+	return -ERANGE;
+}
+
 #ifdef CONFIG_MODULES
 
 #define next_to_ftrace_page(p) container_of(p, struct ftrace_page, next)
@@ -6510,6 +6563,7 @@ int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *value,
 {
 	struct ftrace_mod_map *mod_map;
 	struct ftrace_mod_func *mod_func;
+	int ret;
 
 	preempt_disable();
 	list_for_each_entry_rcu(mod_map, &ftrace_mod_maps, list) {
@@ -6536,8 +6590,10 @@ int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *value,
 		WARN_ON(1);
 		break;
 	}
+	ret = ftrace_get_trampoline_kallsym(symnum, value, type, name,
+					    module_name, exported);
 	preempt_enable();
-	return -ERANGE;
+	return ret;
 }
 
 #else
@@ -6549,6 +6605,18 @@ allocate_ftrace_mod_map(struct module *mod,
 {
 	return NULL;
 }
+int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *value,
+			   char *type, char *name, char *module_name,
+			   int *exported)
+{
+	int ret;
+
+	preempt_disable();
+	ret = ftrace_get_trampoline_kallsym(symnum, value, type, name,
+					    module_name, exported);
+	preempt_enable();
+	return ret;
+}
 #endif /* CONFIG_MODULES */
 
 struct ftrace_init_func {
@@ -6729,7 +6797,12 @@ void __weak arch_ftrace_update_trampoline(struct ftrace_ops *ops)
 
 static void ftrace_update_trampoline(struct ftrace_ops *ops)
 {
+	unsigned long trampoline = ops->trampoline;
+
 	arch_ftrace_update_trampoline(ops);
+	if (ops->trampoline && ops->trampoline != trampoline &&
+	    (ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP))
+		ftrace_add_trampoline_to_kallsyms(ops);
 }
 
 void ftrace_init_trace_array(struct trace_array *tr)
-- 
2.17.1

