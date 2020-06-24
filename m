Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18965C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB3AC20781
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EIXNV2Zn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404732AbgFXPwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404590AbgFXPvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:51:51 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC17C061797
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=+OQOqbXhwLjDPHSut+GR0bTAU82w1KX+xqp6BPPwYTI=; b=EIXNV2ZneqHfIdlPR/W/ymR5+r
        EHbs5HRZc3gkR0NyEw5WCd/1HSxHBsyCLEDDzuoLzYdtsP7OWwRwtZDwXO+OTEcfo4HepXFTekZWV
        OnypX347MSLuwqcNiGeK65Xpcd6aUTE4bH+avtR5iyJ46MoIluiCOKY0x5MOxTGXjmXvAigl1yRq/
        4W1iL3yYIIIIXQyv4fIJbUqYJiCetSLWX8nmDchGnl0OpfUXsyl8DB9y+V3eCGSnmFKexjaK5Jmmd
        A7GIRDeV8fw9Vj6DHJ8FcDd/61B0HAZ6/blF8CrCma/T68WgV/npxlMfe8Hp629pBoF9FHBcL73I0
        J5rbpMyw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo7gD-0004rd-8G; Wed, 24 Jun 2020 15:51:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 90B07306089;
        Wed, 24 Jun 2020 17:51:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E2425236E775C; Wed, 24 Jun 2020 17:51:13 +0200 (CEST)
Message-ID: <20200624154157.146357919@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 24 Jun 2020 17:30:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com, linux@rasmusvillemoes.dk
Subject: [PATCH v5 07/17] static_call: Add inline static call infrastructure
References: <20200624153024.794671356@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

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
---
 arch/Kconfig                      |    4 
 include/asm-generic/vmlinux.lds.h |    7 
 include/linux/module.h            |    5 
 include/linux/static_call.h       |   36 ++++
 include/linux/static_call_types.h |   13 +
 kernel/Makefile                   |    1 
 kernel/module.c                   |    5 
 kernel/static_call.c              |  303 ++++++++++++++++++++++++++++++++++++++
 8 files changed, 373 insertions(+), 1 deletion(-)
 create mode 100644 kernel/static_call.c

--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -982,6 +982,10 @@ config HAVE_SPARSE_SYSCALL_NR
 config HAVE_STATIC_CALL
 	bool
 
+config HAVE_STATIC_CALL_INLINE
+	bool
+	depends on HAVE_STATIC_CALL
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -368,6 +368,12 @@
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
@@ -377,6 +383,7 @@
 	__start_ro_after_init = .;					\
 	*(.data..ro_after_init)						\
 	JUMP_TABLE_DATA							\
+	STATIC_CALL_DATA						\
 	__end_ro_after_init = .;
 #endif
 
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -25,6 +25,7 @@
 #include <linux/error-injection.h>
 #include <linux/tracepoint-defs.h>
 #include <linux/srcu.h>
+#include <linux/static_call_types.h>
 
 #include <linux/percpu.h>
 #include <asm/module.h>
@@ -497,6 +498,10 @@ struct module {
 	unsigned long *kprobe_blacklist;
 	unsigned int num_kprobe_blacklist;
 #endif
+#ifdef CONFIG_HAVE_STATIC_CALL_INLINE
+	int num_static_call_sites;
+	struct static_call_site *static_call_sites;
+#endif
 
 #ifdef CONFIG_LIVEPATCH
 	bool klp; /* Is this a livepatch module? */
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -95,7 +95,41 @@ extern void arch_static_call_transform(v
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
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -109,6 +109,7 @@ obj-$(CONFIG_CPU_PM) += cpu_pm.o
 obj-$(CONFIG_BPF) += bpf/
 obj-$(CONFIG_KCSAN) += kcsan/
 obj-$(CONFIG_SHADOW_CALL_STACK) += scs.o
+obj-$(CONFIG_HAVE_STATIC_CALL_INLINE) += static_call.o
 
 obj-$(CONFIG_PERF_EVENTS) += events/
 
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3226,6 +3226,11 @@ static int find_module_sections(struct m
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


