Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8C7C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A19720FC3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbgFPMYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728779AbgFPMV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:21:56 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C041C08C5C4;
        Tue, 16 Jun 2020 05:21:56 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlAb8-0004cw-MU; Tue, 16 Jun 2020 14:21:50 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 39C281C0095;
        Tue, 16 Jun 2020 14:21:49 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:21:49 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] kprobes: Add symbols for kprobe insn pages
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200528080058.20230-1-adrian.hunter@intel.com>
References: <20200528080058.20230-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <159231010903.16989.11238689768998623451.tip-bot2@tip-bot2>
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

Commit-ID:     d002b8bc6dbc20e9043e279196cff8795dba05fe
Gitweb:        https://git.kernel.org/tip/d002b8bc6dbc20e9043e279196cff8795dba05fe
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Thu, 28 May 2020 11:00:58 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:09:48 +02:00

kprobes: Add symbols for kprobe insn pages

Symbols are needed for tools to describe instruction addresses. Pages
allocated for kprobe's purposes need symbols to be created for them.
Add such symbols to be visible via /proc/kallsyms.

Note: kprobe insn pages are not used if ftrace is configured. To see the
effect of this patch, the kernel must be configured with:

	# CONFIG_FUNCTION_TRACER is not set
	CONFIG_KPROBES=y

and for optimised kprobes:

	CONFIG_OPTPROBES=y

Example on x86:

	# perf probe __schedule
	Added new event:
	  probe:__schedule     (on __schedule)
	# cat /proc/kallsyms | grep '\[__builtin__kprobes\]'
	ffffffffc00d4000 t kprobe_insn_page     [__builtin__kprobes]
	ffffffffc00d6000 t kprobe_optinsn_page  [__builtin__kprobes]

Note: This patch adds "__builtin__kprobes" as a module name in
/proc/kallsyms for symbols for pages allocated for kprobes' purposes, even
though "__builtin__kprobes" is not a module.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lkml.kernel.org/r/20200528080058.20230-1-adrian.hunter@intel.com
---
 include/linux/kprobes.h | 15 +++++++++++++-
 kernel/kallsyms.c       | 37 +++++++++++++++++++++++++++++----
 kernel/kprobes.c        | 45 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 93 insertions(+), 4 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 594265b..13fc58a 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -242,6 +242,7 @@ struct kprobe_insn_cache {
 	struct mutex mutex;
 	void *(*alloc)(void);	/* allocate insn page */
 	void (*free)(void *);	/* free insn page */
+	const char *sym;	/* symbol for insn pages */
 	struct list_head pages; /* list of kprobe_insn_page */
 	size_t insn_size;	/* size of instruction slot */
 	int nr_garbage;
@@ -272,6 +273,10 @@ static inline bool is_kprobe_##__name##_slot(unsigned long addr)	\
 {									\
 	return __is_insn_slot_addr(&kprobe_##__name##_slots, addr);	\
 }
+#define KPROBE_INSN_PAGE_SYM		"kprobe_insn_page"
+#define KPROBE_OPTINSN_PAGE_SYM		"kprobe_optinsn_page"
+int kprobe_cache_get_kallsym(struct kprobe_insn_cache *c, unsigned int *symnum,
+			     unsigned long *value, char *type, char *sym);
 #else /* __ARCH_WANT_KPROBES_INSN_SLOT */
 #define DEFINE_INSN_CACHE_OPS(__name)					\
 static inline bool is_kprobe_##__name##_slot(unsigned long addr)	\
@@ -373,6 +378,11 @@ void dump_kprobe(struct kprobe *kp);
 void *alloc_insn_page(void);
 void free_insn_page(void *page);
 
+int kprobe_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
+		       char *sym);
+
+int arch_kprobe_get_kallsym(unsigned int *symnum, unsigned long *value,
+			    char *type, char *sym);
 #else /* !CONFIG_KPROBES: */
 
 static inline int kprobes_built_in(void)
@@ -435,6 +445,11 @@ static inline bool within_kprobe_blacklist(unsigned long addr)
 {
 	return true;
 }
+static inline int kprobe_get_kallsym(unsigned int symnum, unsigned long *value,
+				     char *type, char *sym)
+{
+	return -ERANGE;
+}
 #endif /* CONFIG_KPROBES */
 static inline int disable_kretprobe(struct kretprobe *rp)
 {
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 16c8c60..c6cc293 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/filter.h>
 #include <linux/ftrace.h>
+#include <linux/kprobes.h>
 #include <linux/compiler.h>
 
 /*
@@ -437,6 +438,7 @@ struct kallsym_iter {
 	loff_t pos_arch_end;
 	loff_t pos_mod_end;
 	loff_t pos_ftrace_mod_end;
+	loff_t pos_bpf_end;
 	unsigned long value;
 	unsigned int nameoff; /* If iterating in core kernel symbols. */
 	char type;
@@ -496,11 +498,33 @@ static int get_ksymbol_ftrace_mod(struct kallsym_iter *iter)
 
 static int get_ksymbol_bpf(struct kallsym_iter *iter)
 {
+	int ret;
+
 	strlcpy(iter->module_name, "bpf", MODULE_NAME_LEN);
 	iter->exported = 0;
-	return bpf_get_kallsym(iter->pos - iter->pos_ftrace_mod_end,
-			       &iter->value, &iter->type,
-			       iter->name) < 0 ? 0 : 1;
+	ret = bpf_get_kallsym(iter->pos - iter->pos_ftrace_mod_end,
+			      &iter->value, &iter->type,
+			      iter->name);
+	if (ret < 0) {
+		iter->pos_bpf_end = iter->pos;
+		return 0;
+	}
+
+	return 1;
+}
+
+/*
+ * This uses "__builtin__kprobes" as a module name for symbols for pages
+ * allocated for kprobes' purposes, even though "__builtin__kprobes" is not a
+ * module.
+ */
+static int get_ksymbol_kprobe(struct kallsym_iter *iter)
+{
+	strlcpy(iter->module_name, "__builtin__kprobes", MODULE_NAME_LEN);
+	iter->exported = 0;
+	return kprobe_get_kallsym(iter->pos - iter->pos_bpf_end,
+				  &iter->value, &iter->type,
+				  iter->name) < 0 ? 0 : 1;
 }
 
 /* Returns space to next name. */
@@ -527,6 +551,7 @@ static void reset_iter(struct kallsym_iter *iter, loff_t new_pos)
 		iter->pos_arch_end = 0;
 		iter->pos_mod_end = 0;
 		iter->pos_ftrace_mod_end = 0;
+		iter->pos_bpf_end = 0;
 	}
 }
 
@@ -551,7 +576,11 @@ static int update_iter_mod(struct kallsym_iter *iter, loff_t pos)
 	    get_ksymbol_ftrace_mod(iter))
 		return 1;
 
-	return get_ksymbol_bpf(iter);
+	if ((!iter->pos_bpf_end || iter->pos_bpf_end > pos) &&
+	    get_ksymbol_bpf(iter))
+		return 1;
+
+	return get_ksymbol_kprobe(iter);
 }
 
 /* Returns false if pos at or past end of file. */
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 50cd84f..058c0be 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -118,6 +118,7 @@ struct kprobe_insn_cache kprobe_insn_slots = {
 	.mutex = __MUTEX_INITIALIZER(kprobe_insn_slots.mutex),
 	.alloc = alloc_insn_page,
 	.free = free_insn_page,
+	.sym = KPROBE_INSN_PAGE_SYM,
 	.pages = LIST_HEAD_INIT(kprobe_insn_slots.pages),
 	.insn_size = MAX_INSN_SIZE,
 	.nr_garbage = 0,
@@ -290,12 +291,34 @@ bool __is_insn_slot_addr(struct kprobe_insn_cache *c, unsigned long addr)
 	return ret;
 }
 
+int kprobe_cache_get_kallsym(struct kprobe_insn_cache *c, unsigned int *symnum,
+			     unsigned long *value, char *type, char *sym)
+{
+	struct kprobe_insn_page *kip;
+	int ret = -ERANGE;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(kip, &c->pages, list) {
+		if ((*symnum)--)
+			continue;
+		strlcpy(sym, c->sym, KSYM_NAME_LEN);
+		*type = 't';
+		*value = (unsigned long)kip->insns;
+		ret = 0;
+		break;
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+
 #ifdef CONFIG_OPTPROBES
 /* For optimized_kprobe buffer */
 struct kprobe_insn_cache kprobe_optinsn_slots = {
 	.mutex = __MUTEX_INITIALIZER(kprobe_optinsn_slots.mutex),
 	.alloc = alloc_insn_page,
 	.free = free_insn_page,
+	.sym = KPROBE_OPTINSN_PAGE_SYM,
 	.pages = LIST_HEAD_INIT(kprobe_optinsn_slots.pages),
 	/* .insn_size is initialized later */
 	.nr_garbage = 0,
@@ -2197,6 +2220,28 @@ static void kprobe_remove_ksym_blacklist(unsigned long entry)
 	kprobe_remove_area_blacklist(entry, entry + 1);
 }
 
+int __weak arch_kprobe_get_kallsym(unsigned int *symnum, unsigned long *value,
+				   char *type, char *sym)
+{
+	return -ERANGE;
+}
+
+int kprobe_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
+		       char *sym)
+{
+#ifdef __ARCH_WANT_KPROBES_INSN_SLOT
+	if (!kprobe_cache_get_kallsym(&kprobe_insn_slots, &symnum, value, type, sym))
+		return 0;
+#ifdef CONFIG_OPTPROBES
+	if (!kprobe_cache_get_kallsym(&kprobe_optinsn_slots, &symnum, value, type, sym))
+		return 0;
+#endif
+#endif
+	if (!arch_kprobe_get_kallsym(&symnum, value, type, sym))
+		return 0;
+	return -ERANGE;
+}
+
 int __init __weak arch_populate_kprobe_blacklist(void)
 {
 	return 0;
