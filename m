Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E5EC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3020E206EB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1ZJ9+9VH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CpRIMmJo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgIAOPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:15:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39768 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgIALt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:49:29 -0400
Date:   Tue, 01 Sep 2020 11:48:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598960887;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lfq5Y6RZBlFitQrrAbG7s2uKjXYMRziGFPYG/R9/02M=;
        b=1ZJ9+9VHxE9M9MViJgdYXGT43BojbShyueK9MzH0sEL0a8waUTMA4QxgI2A5XlRWbKdmcW
        f/UboVytla+7gy4sATkIyluZGoJBw6FEbt6HjVs1BmT2/JH322LDNHXXrVGc0rA2+IAUM+
        opXihO7Ew7z8STiAYAMQ+6hclJuaI/itzIOCE56z1tJZl1kON4PNa4tqfN2CcYrzwskOEE
        F4wvYFZhqaQ705OLunS/ycnBN+wm05stbWCgLuq8EBfEdE7okp7Ylr8LWB+3b2gf2jv8tb
        pG09ez09Nu97kkI3HsdxBdcci8GlXz3nmmaNL1uSTPo1AZKsreQIR3nEAKVxOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598960887;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lfq5Y6RZBlFitQrrAbG7s2uKjXYMRziGFPYG/R9/02M=;
        b=CpRIMmJoGcznlJfL0m+VmGG/ZboTLhsZJj5Kwzel4lyRFveU4hv+oX32PqyPRzRULA+EWN
        gijaDeX1mKhNBkDQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/static_call] static_call: Add inline static call infrastructure
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200818135804.684334440@infradead.org>
References: <20200818135804.684334440@infradead.org>
MIME-Version: 1.0
Message-ID: <159896088657.20229.14497152178407959374.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/static_call branch of tip:

Commit-ID:     9183c3f9ed710a8edf1a61e8a96d497258d26e08
Gitweb:        https://git.kernel.org/tip/9183c3f9ed710a8edf1a61e8a96d497258d26e08
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Tue, 18 Aug 2020 15:57:42 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Sep 2020 09:58:04 +02:00

static_call: Add inline static call infrastructure

Add infrastructure for an arch-specific CONFIG_HAVE_STATIC_CALL_INLINE
option, which is a faster version of CONFIG_HAVE_STATIC_CALL.  At
runtime, the static call sites are patched directly, rather than using
the out-of-line trampolines.

Compared to out-of-line static calls, the performance benefits are more
modest, but still measurable.  Steven Rostedt did some tracepoint
measurements:

  https://lkml.kernel.org/r/20181126155405.72b4f718@gandalf.local.home

This code is heavily inspired by the jump label code (aka "static
jumps"), as some of the concepts are very similar.

For more details, see the comments in include/linux/static_call.h.

[peterz: simplified interface; merged trampolines]

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20200818135804.684334440@infradead.org
---
 arch/Kconfig                      |   4 +-
 include/asm-generic/vmlinux.lds.h |   7 +-
 include/linux/module.h            |   5 +-
 include/linux/static_call.h       |  36 ++-
 include/linux/static_call_types.h |  13 +-
 kernel/Makefile                   |   1 +-
 kernel/module.c                   |   5 +-
 kernel/static_call.c              | 303 +++++++++++++++++++++++++++++-
 8 files changed, 373 insertions(+), 1 deletion(-)
 create mode 100644 kernel/static_call.c

diff --git a/arch/Kconfig b/arch/Kconfig
index 806e6df..2c4936a 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -978,6 +978,10 @@ config ARCH_HAS_VDSO_DATA
 config HAVE_STATIC_CALL
 	bool
 
+config HAVE_STATIC_CALL_INLINE
+	bool
+	depends on HAVE_STATIC_CALL
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5430feb..0088a5c 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -388,6 +388,12 @@
 	KEEP(*(__jump_table))						\
 	__stop___jump_table = .;
 
+#define STATIC_CALL_DATA						\
+	. = ALIGN(8);							\
+	__start_static_call_sites = .;					\
+	KEEP(*(.static_call_sites))					\
+	__stop_static_call_sites = .;
+
 /*
  * Allow architectures to handle ro_after_init data on their
  * own by defining an empty RO_AFTER_INIT_DATA.
@@ -398,6 +404,7 @@
 	__start_ro_after_init = .;					\
 	*(.data..ro_after_init)						\
 	JUMP_TABLE_DATA							\
+	STATIC_CALL_DATA						\
 	__end_ro_after_init = .;
 #endif
 
diff --git a/include/linux/module.h b/include/linux/module.h
index e30ed5f..a29187f 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -25,6 +25,7 @@
 #include <linux/error-injection.h>
 #include <linux/tracepoint-defs.h>
 #include <linux/srcu.h>
+#include <linux/static_call_types.h>
 
 #include <linux/percpu.h>
 #include <asm/module.h>
@@ -498,6 +499,10 @@ struct module {
 	unsigned long *kprobe_blacklist;
 	unsigned int num_kprobe_blacklist;
 #endif
+#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
+	int num_static_call_sites;
+	struct static_call_site *static_call_sites;
+#endif
 
 #ifdef CONFIG_LIVEPATCH
 	bool klp; /* Is this a livepatch module? */
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index d8892df..0d7f9ef 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -95,7 +95,41 @@ extern void arch_static_call_transform(void *site, void *tramp, void *func);
 			     STATIC_CALL_TRAMP_ADDR(name), func);	\
 })
 
-#if defined(CONFIG_HAVE_STATIC_CALL)
+#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
+
+struct static_call_mod {
+	struct static_call_mod *next;
+	struct module *mod; /* for vmlinux, mod == NULL */
+	struct static_call_site *sites;
+};
+
+struct static_call_key {
+	void *func;
+	struct static_call_mod *mods;
+};
+
+extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
+extern int static_call_mod_init(struct module *mod);
+
+#define DEFINE_STATIC_CALL(name, _func)					\
+	DECLARE_STATIC_CALL(name, _func);				\
+	struct static_call_key STATIC_CALL_KEY(name) = {		\
+		.func = _func,						\
+		.mods = NULL,						\
+	};								\
+	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
+
+#define static_call(name)	__static_call(name)
+
+#define EXPORT_STATIC_CALL(name)					\
+	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
+	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
+
+#define EXPORT_STATIC_CALL_GPL(name)					\
+	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
+	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
+
+#elif defined(CONFIG_HAVE_STATIC_CALL)
 
 struct static_call_key {
 	void *func;
diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
index 5ed249d..408d345 100644
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -2,14 +2,27 @@
 #ifndef _STATIC_CALL_TYPES_H
 #define _STATIC_CALL_TYPES_H
 
+#include <linux/types.h>
 #include <linux/stringify.h>
 
 #define STATIC_CALL_KEY_PREFIX		__SCK__
+#define STATIC_CALL_KEY_PREFIX_STR	__stringify(STATIC_CALL_KEY_PREFIX)
+#define STATIC_CALL_KEY_PREFIX_LEN	(sizeof(STATIC_CALL_KEY_PREFIX_STR) - 1)
 #define STATIC_CALL_KEY(name)		__PASTE(STATIC_CALL_KEY_PREFIX, name)
 
 #define STATIC_CALL_TRAMP_PREFIX	__SCT__
 #define STATIC_CALL_TRAMP_PREFIX_STR	__stringify(STATIC_CALL_TRAMP_PREFIX)
+#define STATIC_CALL_TRAMP_PREFIX_LEN	(sizeof(STATIC_CALL_TRAMP_PREFIX_STR) - 1)
 #define STATIC_CALL_TRAMP(name)		__PASTE(STATIC_CALL_TRAMP_PREFIX, name)
 #define STATIC_CALL_TRAMP_STR(name)	__stringify(STATIC_CALL_TRAMP(name))
 
+/*
+ * The static call site table needs to be created by external tooling (objtool
+ * or a compiler plugin).
+ */
+struct static_call_site {
+	s32 addr;
+	s32 key;
+};
+
 #endif /* _STATIC_CALL_TYPES_H */
diff --git a/kernel/Makefile b/kernel/Makefile
index 9a20016..b74820d 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -111,6 +111,7 @@ obj-$(CONFIG_CPU_PM) += cpu_pm.o
 obj-$(CONFIG_BPF) += bpf/
 obj-$(CONFIG_KCSAN) += kcsan/
 obj-$(CONFIG_SHADOW_CALL_STACK) += scs.o
+obj-$(CONFIG_HAVE_STATIC_CALL_INLINE) += static_call.o
 
 obj-$(CONFIG_PERF_EVENTS) += events/
 
diff --git a/kernel/module.c b/kernel/module.c
index 3c465cf..c075a18 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3275,6 +3275,11 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 						sizeof(unsigned long),
 						&mod->num_kprobe_blacklist);
 #endif
+#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
+	mod->static_call_sites = section_objs(info, ".static_call_sites",
+					      sizeof(*mod->static_call_sites),
+					      &mod->num_static_call_sites);
+#endif
 	mod->extable = section_objs(info, "__ex_table",
 				    sizeof(*mod->extable), &mod->num_exentries);
 
diff --git a/kernel/static_call.c b/kernel/static_call.c
new file mode 100644
index 0000000..d243492
--- /dev/null
+++ b/kernel/static_call.c
@@ -0,0 +1,303 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/init.h>
+#include <linux/static_call.h>
+#include <linux/bug.h>
+#include <linux/smp.h>
+#include <linux/sort.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/cpu.h>
+#include <linux/processor.h>
+#include <asm/sections.h>
+
+extern struct static_call_site __start_static_call_sites[],
+			       __stop_static_call_sites[];
+
+static bool static_call_initialized;
+
+#define STATIC_CALL_INIT 1UL
+
+/* mutex to protect key modules/sites */
+static DEFINE_MUTEX(static_call_mutex);
+
+static void static_call_lock(void)
+{
+	mutex_lock(&static_call_mutex);
+}
+
+static void static_call_unlock(void)
+{
+	mutex_unlock(&static_call_mutex);
+}
+
+static inline void *static_call_addr(struct static_call_site *site)
+{
+	return (void *)((long)site->addr + (long)&site->addr);
+}
+
+
+static inline struct static_call_key *static_call_key(const struct static_call_site *site)
+{
+	return (struct static_call_key *)
+		(((long)site->key + (long)&site->key) & ~STATIC_CALL_INIT);
+}
+
+/* These assume the key is word-aligned. */
+static inline bool static_call_is_init(struct static_call_site *site)
+{
+	return ((long)site->key + (long)&site->key) & STATIC_CALL_INIT;
+}
+
+static inline void static_call_set_init(struct static_call_site *site)
+{
+	site->key = ((long)static_call_key(site) | STATIC_CALL_INIT) -
+		    (long)&site->key;
+}
+
+static int static_call_site_cmp(const void *_a, const void *_b)
+{
+	const struct static_call_site *a = _a;
+	const struct static_call_site *b = _b;
+	const struct static_call_key *key_a = static_call_key(a);
+	const struct static_call_key *key_b = static_call_key(b);
+
+	if (key_a < key_b)
+		return -1;
+
+	if (key_a > key_b)
+		return 1;
+
+	return 0;
+}
+
+static void static_call_site_swap(void *_a, void *_b, int size)
+{
+	long delta = (unsigned long)_a - (unsigned long)_b;
+	struct static_call_site *a = _a;
+	struct static_call_site *b = _b;
+	struct static_call_site tmp = *a;
+
+	a->addr = b->addr  - delta;
+	a->key  = b->key   - delta;
+
+	b->addr = tmp.addr + delta;
+	b->key  = tmp.key  + delta;
+}
+
+static inline void static_call_sort_entries(struct static_call_site *start,
+					    struct static_call_site *stop)
+{
+	sort(start, stop - start, sizeof(struct static_call_site),
+	     static_call_site_cmp, static_call_site_swap);
+}
+
+void __static_call_update(struct static_call_key *key, void *tramp, void *func)
+{
+	struct static_call_site *site, *stop;
+	struct static_call_mod *site_mod;
+
+	cpus_read_lock();
+	static_call_lock();
+
+	if (key->func == func)
+		goto done;
+
+	key->func = func;
+
+	arch_static_call_transform(NULL, tramp, func);
+
+	/*
+	 * If uninitialized, we'll not update the callsites, but they still
+	 * point to the trampoline and we just patched that.
+	 */
+	if (WARN_ON_ONCE(!static_call_initialized))
+		goto done;
+
+	for (site_mod = key->mods; site_mod; site_mod = site_mod->next) {
+		struct module *mod = site_mod->mod;
+
+		if (!site_mod->sites) {
+			/*
+			 * This can happen if the static call key is defined in
+			 * a module which doesn't use it.
+			 */
+			continue;
+		}
+
+		stop = __stop_static_call_sites;
+
+#ifdef CONFIG_MODULES
+		if (mod) {
+			stop = mod->static_call_sites +
+			       mod->num_static_call_sites;
+		}
+#endif
+
+		for (site = site_mod->sites;
+		     site < stop && static_call_key(site) == key; site++) {
+			void *site_addr = static_call_addr(site);
+
+			if (static_call_is_init(site)) {
+				/*
+				 * Don't write to call sites which were in
+				 * initmem and have since been freed.
+				 */
+				if (!mod && system_state >= SYSTEM_RUNNING)
+					continue;
+				if (mod && !within_module_init((unsigned long)site_addr, mod))
+					continue;
+			}
+
+			if (!kernel_text_address((unsigned long)site_addr)) {
+				WARN_ONCE(1, "can't patch static call site at %pS",
+					  site_addr);
+				continue;
+			}
+
+			arch_static_call_transform(site_addr, NULL, func);
+		}
+	}
+
+done:
+	static_call_unlock();
+	cpus_read_unlock();
+}
+EXPORT_SYMBOL_GPL(__static_call_update);
+
+static int __static_call_init(struct module *mod,
+			      struct static_call_site *start,
+			      struct static_call_site *stop)
+{
+	struct static_call_site *site;
+	struct static_call_key *key, *prev_key = NULL;
+	struct static_call_mod *site_mod;
+
+	if (start == stop)
+		return 0;
+
+	static_call_sort_entries(start, stop);
+
+	for (site = start; site < stop; site++) {
+		void *site_addr = static_call_addr(site);
+
+		if ((mod && within_module_init((unsigned long)site_addr, mod)) ||
+		    (!mod && init_section_contains(site_addr, 1)))
+			static_call_set_init(site);
+
+		key = static_call_key(site);
+		if (key != prev_key) {
+			prev_key = key;
+
+			site_mod = kzalloc(sizeof(*site_mod), GFP_KERNEL);
+			if (!site_mod)
+				return -ENOMEM;
+
+			site_mod->mod = mod;
+			site_mod->sites = site;
+			site_mod->next = key->mods;
+			key->mods = site_mod;
+		}
+
+		arch_static_call_transform(site_addr, NULL, key->func);
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_MODULES
+
+static int static_call_add_module(struct module *mod)
+{
+	return __static_call_init(mod, mod->static_call_sites,
+				  mod->static_call_sites + mod->num_static_call_sites);
+}
+
+static void static_call_del_module(struct module *mod)
+{
+	struct static_call_site *start = mod->static_call_sites;
+	struct static_call_site *stop = mod->static_call_sites +
+					mod->num_static_call_sites;
+	struct static_call_key *key, *prev_key = NULL;
+	struct static_call_mod *site_mod, **prev;
+	struct static_call_site *site;
+
+	for (site = start; site < stop; site++) {
+		key = static_call_key(site);
+		if (key == prev_key)
+			continue;
+
+		prev_key = key;
+
+		for (prev = &key->mods, site_mod = key->mods;
+		     site_mod && site_mod->mod != mod;
+		     prev = &site_mod->next, site_mod = site_mod->next)
+			;
+
+		if (!site_mod)
+			continue;
+
+		*prev = site_mod->next;
+		kfree(site_mod);
+	}
+}
+
+static int static_call_module_notify(struct notifier_block *nb,
+				     unsigned long val, void *data)
+{
+	struct module *mod = data;
+	int ret = 0;
+
+	cpus_read_lock();
+	static_call_lock();
+
+	switch (val) {
+	case MODULE_STATE_COMING:
+		ret = static_call_add_module(mod);
+		if (ret) {
+			WARN(1, "Failed to allocate memory for static calls");
+			static_call_del_module(mod);
+		}
+		break;
+	case MODULE_STATE_GOING:
+		static_call_del_module(mod);
+		break;
+	}
+
+	static_call_unlock();
+	cpus_read_unlock();
+
+	return notifier_from_errno(ret);
+}
+
+static struct notifier_block static_call_module_nb = {
+	.notifier_call = static_call_module_notify,
+};
+
+#endif /* CONFIG_MODULES */
+
+static void __init static_call_init(void)
+{
+	int ret;
+
+	if (static_call_initialized)
+		return;
+
+	cpus_read_lock();
+	static_call_lock();
+	ret = __static_call_init(NULL, __start_static_call_sites,
+				 __stop_static_call_sites);
+	static_call_unlock();
+	cpus_read_unlock();
+
+	if (ret) {
+		pr_err("Failed to allocate memory for static_call!\n");
+		BUG();
+	}
+
+	static_call_initialized = true;
+
+#ifdef CONFIG_MODULES
+	register_module_notifier(&static_call_module_nb);
+#endif
+}
+early_initcall(static_call_init);
