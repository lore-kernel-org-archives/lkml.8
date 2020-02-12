Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32978C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F400C20714
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgBLMvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 07:51:10 -0500
Received: from mga06.intel.com ([134.134.136.31]:63674 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgBLMvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 07:51:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 04:51:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="237702510"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.167])
  by orsmga006.jf.intel.com with ESMTP; 12 Feb 2020 04:51:05 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 06/13] ftrace: Add symbols for ftrace trampolines
Date:   Wed, 12 Feb 2020 14:49:42 +0200
Message-Id: <20200212124949.3589-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200212124949.3589-1-adrian.hunter@intel.com>
References: <20200212124949.3589-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Symbols are needed for tools to describe instruction addresses. Pages
allocated for ftrace's purposes need symbols to be created for them.
Add such symbols to be visible via /proc/kallsyms.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/x86/kernel/ftrace.c | 26 ++++++++++----------
 include/linux/ftrace.h   | 15 ++++++++----
 kernel/trace/ftrace.c    | 52 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 76 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 108ee96f8b66..76920ce85b9c 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -307,9 +307,9 @@ union ftrace_op_code_union {
 
 #define RET_SIZE		1
 
-static unsigned long
-create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
+static void create_trampoline(struct ftrace_ops *ops)
 {
+	unsigned int tramp_size;
 	unsigned long start_offset;
 	unsigned long end_offset;
 	unsigned long op_offset;
@@ -347,10 +347,10 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	 */
 	trampoline = alloc_tramp(size + RET_SIZE + sizeof(void *));
 	if (!trampoline)
-		return 0;
+		return;
 
-	*tramp_size = size + RET_SIZE + sizeof(void *);
-	npages = DIV_ROUND_UP(*tramp_size, PAGE_SIZE);
+	tramp_size = size + RET_SIZE + sizeof(void *);
+	npages = DIV_ROUND_UP(tramp_size, PAGE_SIZE);
 
 	/* Copy ftrace_caller onto the trampoline memory */
 	ret = probe_kernel_read(trampoline, (void *)start_offset, size);
@@ -403,15 +403,18 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 
 	/* ALLOC_TRAMP flags lets us know we created it */
 	ops->flags |= FTRACE_OPS_FL_ALLOC_TRAMP;
+	ops->trampoline = (unsigned long)trampoline;
+	ops->trampoline_size = tramp_size;
+
+	ftrace_add_trampoline_to_kallsyms(ops);
 
 	set_vm_flush_reset_perms(trampoline);
 
 	set_memory_ro((unsigned long)trampoline, npages);
 	set_memory_x((unsigned long)trampoline, npages);
-	return (unsigned long)trampoline;
+	return;
 fail:
 	tramp_free(trampoline);
-	return 0;
 }
 
 static unsigned long calc_trampoline_call_offset(bool save_regs)
@@ -435,14 +438,10 @@ void arch_ftrace_update_trampoline(struct ftrace_ops *ops)
 	ftrace_func_t func;
 	unsigned long offset;
 	unsigned long ip;
-	unsigned int size;
 	const char *new;
 
 	if (!ops->trampoline) {
-		ops->trampoline = create_trampoline(ops, &size);
-		if (!ops->trampoline)
-			return;
-		ops->trampoline_size = size;
+		create_trampoline(ops);
 		return;
 	}
 
@@ -535,6 +534,9 @@ void arch_ftrace_trampoline_free(struct ftrace_ops *ops)
 	if (!ops || !(ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP))
 		return;
 
+	ftrace_remove_trampoline_from_kallsyms(ops);
+	synchronize_rcu();
+
 	tramp_free((void *)ops->trampoline);
 	ops->trampoline = 0;
 }
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index db95244a62d4..70dea4785443 100644
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
@@ -179,6 +182,9 @@ struct ftrace_ops_hash {
 
 void ftrace_free_init_mem(void);
 void ftrace_free_mem(struct module *mod, void *start, void *end);
+#define FTRACE_TRAMPOLINE_SYM "ftrace_trampoline"
+void ftrace_add_trampoline_to_kallsyms(struct ftrace_ops *ops);
+void ftrace_remove_trampoline_from_kallsyms(struct ftrace_ops *ops);
 #else
 static inline void ftrace_free_init_mem(void) { }
 static inline void ftrace_free_mem(struct module *mod, void *start, void *end) { }
@@ -207,6 +213,7 @@ struct ftrace_ops {
 	struct ftrace_ops_hash		old_hash;
 	unsigned long			trampoline;
 	unsigned long			trampoline_size;
+	struct list_head		list;
 #endif
 };
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 9bf1f2cd515e..697ab4759f0c 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6174,6 +6174,41 @@ struct ftrace_mod_map {
 	unsigned int		num_funcs;
 };
 
+/* List of trace_ops that have allocated trampolines */
+static LIST_HEAD(ftrace_ops_trampoline_list);
+
+void ftrace_add_trampoline_to_kallsyms(struct ftrace_ops *ops)
+{
+	lockdep_assert_held(&ftrace_lock);
+	list_add_rcu(&ops->list, &ftrace_ops_trampoline_list);
+}
+
+void ftrace_remove_trampoline_from_kallsyms(struct ftrace_ops *ops)
+{
+	lockdep_assert_held(&ftrace_lock);
+	list_del_rcu(&ops->list);
+}
+
+int ftrace_get_trampoline_kallsym(unsigned int symnum, unsigned long *value,
+				  char *type, char *name, char *module_name,
+				  int *exported)
+{
+	struct ftrace_ops *op;
+
+	list_for_each_entry_rcu(op, &ftrace_ops_trampoline_list, list) {
+		if (!op->trampoline || symnum--)
+			continue;
+		*value = op->trampoline;
+		*type = 't';
+		strlcpy(name, FTRACE_TRAMPOLINE_SYM, KSYM_NAME_LEN);
+		strlcpy(module_name, "ftrace", MODULE_NAME_LEN);
+		*exported = 0;
+		return 0;
+	}
+
+	return -ERANGE;
+}
+
 #ifdef CONFIG_MODULES
 
 #define next_to_ftrace_page(p) container_of(p, struct ftrace_page, next)
@@ -6510,6 +6545,7 @@ int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *value,
 {
 	struct ftrace_mod_map *mod_map;
 	struct ftrace_mod_func *mod_func;
+	int ret;
 
 	preempt_disable();
 	list_for_each_entry_rcu(mod_map, &ftrace_mod_maps, list) {
@@ -6536,8 +6572,10 @@ int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *value,
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
@@ -6549,6 +6587,18 @@ allocate_ftrace_mod_map(struct module *mod,
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
-- 
2.17.1

