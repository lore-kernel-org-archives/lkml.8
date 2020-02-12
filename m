Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894C1C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5785D20714
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgBLMu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 07:50:59 -0500
Received: from mga06.intel.com ([134.134.136.31]:63674 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgBLMu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 07:50:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 04:50:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="237702441"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.167])
  by orsmga006.jf.intel.com with ESMTP; 12 Feb 2020 04:50:54 -0800
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
Subject: [PATCH V2 03/13] kprobes: Add symbols for kprobe insn pages
Date:   Wed, 12 Feb 2020 14:49:39 +0200
Message-Id: <20200212124949.3589-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200212124949.3589-1-adrian.hunter@intel.com>
References: <20200212124949.3589-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Symbols are needed for tools to describe instruction addresses. Pages
allocated for kprobe's purposes need symbols to be created for them.
Add such symbols to be visible via /proc/kallsyms.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 include/linux/kprobes.h | 28 +++++++++++++++++++++++++
 kernel/kallsyms.c       | 32 +++++++++++++++++++++++++----
 kernel/kprobes.c        | 45 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+), 4 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 04bdaf01112c..6613682f3961 100644
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
@@ -272,6 +273,8 @@ static inline bool is_kprobe_##__name##_slot(unsigned long addr)	\
 {									\
 	return __is_insn_slot_addr(&kprobe_##__name##_slots, addr);	\
 }
+#define KPROBE_INSN_PAGE_SYM		"kprobe_insn_page"
+#define KPROBE_OPTINSN_PAGE_SYM		"kprobe_optinsn_page"
 #else /* __ARCH_WANT_KPROBES_INSN_SLOT */
 #define DEFINE_INSN_CACHE_OPS(__name)					\
 static inline bool is_kprobe_##__name##_slot(unsigned long addr)	\
@@ -373,6 +376,13 @@ void dump_kprobe(struct kprobe *kp);
 void *alloc_insn_page(void);
 void free_insn_page(void *page);
 
+int kprobe_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
+		       char *sym);
+int kprobe_cache_get_kallsym(struct kprobe_insn_cache *c, unsigned int *symnum,
+			     unsigned long *value, char *type, char *sym);
+
+int arch_kprobe_get_kallsym(unsigned int *symnum, unsigned long *value,
+			    char *type, char *sym);
 #else /* !CONFIG_KPROBES: */
 
 static inline int kprobes_built_in(void)
@@ -435,6 +445,24 @@ static inline bool within_kprobe_blacklist(unsigned long addr)
 {
 	return true;
 }
+static inline int kprobe_get_kallsym(unsigned int symnum, unsigned long *value,
+				     char *type, char *sym)
+{
+	return 0;
+}
+static inline int kprobe_cache_get_kallsym(struct kprobe_insn_cache *c,
+					   unsigned int *symnum,
+					   unsigned long *value, char *type,
+					   char *sym)
+{
+	return 0;
+}
+static inline int arch_kprobe_get_kallsym(unsigned int *symnum,
+					  unsigned long *value, char *type,
+					  char *sym)
+{
+	return 0;
+}
 #endif /* CONFIG_KPROBES */
 static inline int disable_kretprobe(struct kretprobe *rp)
 {
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 136ce049c4ad..fd5579171087 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/filter.h>
 #include <linux/ftrace.h>
+#include <linux/kprobes.h>
 #include <linux/compiler.h>
 
 /*
@@ -438,6 +439,7 @@ struct kallsym_iter {
 	loff_t pos_arch_end;
 	loff_t pos_mod_end;
 	loff_t pos_ftrace_mod_end;
+	loff_t pos_bpf_end;
 	unsigned long value;
 	unsigned int nameoff; /* If iterating in core kernel symbols. */
 	char type;
@@ -497,11 +499,28 @@ static int get_ksymbol_ftrace_mod(struct kallsym_iter *iter)
 
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
+static int get_ksymbol_kprobe(struct kallsym_iter *iter)
+{
+	strlcpy(iter->module_name, "kprobe", MODULE_NAME_LEN);
+	iter->exported = 0;
+	return kprobe_get_kallsym(iter->pos - iter->pos_bpf_end,
+				  &iter->value, &iter->type,
+				  iter->name) < 0 ? 0 : 1;
 }
 
 /* Returns space to next name. */
@@ -528,6 +547,7 @@ static void reset_iter(struct kallsym_iter *iter, loff_t new_pos)
 		iter->pos_arch_end = 0;
 		iter->pos_mod_end = 0;
 		iter->pos_ftrace_mod_end = 0;
+		iter->pos_bpf_end = 0;
 	}
 }
 
@@ -552,7 +572,11 @@ static int update_iter_mod(struct kallsym_iter *iter, loff_t pos)
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
index 2625c241ac00..229d1b596690 100644
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
@@ -296,6 +297,7 @@ struct kprobe_insn_cache kprobe_optinsn_slots = {
 	.mutex = __MUTEX_INITIALIZER(kprobe_optinsn_slots.mutex),
 	.alloc = alloc_insn_page,
 	.free = free_insn_page,
+	.sym = KPROBE_OPTINSN_PAGE_SYM,
 	.pages = LIST_HEAD_INIT(kprobe_optinsn_slots.pages),
 	/* .insn_size is initialized later */
 	.nr_garbage = 0,
@@ -2179,6 +2181,49 @@ int kprobe_add_area_blacklist(unsigned long start, unsigned long end)
 	return 0;
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
-- 
2.17.1

