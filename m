Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E90C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67AAB21475
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbgFPMWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbgFPMV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:21:59 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FD4C08C5C2;
        Tue, 16 Jun 2020 05:21:58 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlAbC-0004cb-2b; Tue, 16 Jun 2020 14:21:54 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 58B641C0475;
        Tue, 16 Jun 2020 14:21:48 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:21:48 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] ftrace: Add symbols for ftrace trampolines
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200512121922.8997-7-adrian.hunter@intel.com>
References: <20200512121922.8997-7-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <159231010811.16989.9609331219224673450.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     fc0ea795f53c8d7040fa42471f74fe51d78d0834
Gitweb:        https://git.kernel.org/tip/fc0ea795f53c8d7040fa42471f74fe51d78d0834
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Tue, 12 May 2020 15:19:13 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:09:49 +02:00

ftrace: Add symbols for ftrace trampolines

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200512121922.8997-7-adrian.hunter@intel.com
---
 include/linux/ftrace.h | 12 ++++--
 kernel/kallsyms.c      |  5 +++-
 kernel/trace/ftrace.c  | 77 +++++++++++++++++++++++++++++++++++++++--
 3 files changed, 88 insertions(+), 6 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index e339dac..ce2c06f 100644
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
index c6cc293..834bfdc 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -482,6 +482,11 @@ static int get_ksymbol_mod(struct kallsym_iter *iter)
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
index c163c35..31675b2 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2764,6 +2764,38 @@ void __weak arch_ftrace_trampoline_free(struct ftrace_ops *ops)
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
@@ -2934,7 +2966,7 @@ int ftrace_shutdown(struct ftrace_ops *ops, int command)
 			synchronize_rcu_tasks();
 
  free_ops:
-		arch_ftrace_trampoline_free(ops);
+		ftrace_trampoline_free(ops);
 	}
 
 	return 0;
@@ -6178,6 +6210,27 @@ struct ftrace_mod_map {
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
@@ -6514,6 +6567,7 @@ int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *value,
 {
 	struct ftrace_mod_map *mod_map;
 	struct ftrace_mod_func *mod_func;
+	int ret;
 
 	preempt_disable();
 	list_for_each_entry_rcu(mod_map, &ftrace_mod_maps, list) {
@@ -6540,8 +6594,10 @@ int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *value,
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
@@ -6553,6 +6609,18 @@ allocate_ftrace_mod_map(struct module *mod,
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
@@ -6733,7 +6801,12 @@ void __weak arch_ftrace_update_trampoline(struct ftrace_ops *ops)
 
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
