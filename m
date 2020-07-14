Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8B6C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3D9A20890
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T4lGjp5k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbgGNScl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgGNScj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:32:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF03DC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 11:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fn8RCnuPYs1jbGANAck/tpAN8jjDykWur1DGYFDEJyQ=; b=T4lGjp5kGRoCAXu3p1WSAR7Nhw
        lcvFJryDfs71W2Qx0ALI+Ynf8kCe4n1sYukR5L8WZSSafrkmCysUa7TB/76O2uinXHvLDbULVzlb3
        7JFgTFsKZj6RNj3zfa9CZu2xA+CyxgJ+AQFbH3IiMaSdMaw3EUAYEkBwDUkDerrcBC0DtrLBifMKT
        VRJsH84MeH+zNuyXRB0ajaxUnwbOXuHKUcvBPinNjhY1srpQvaIrj3y17V+bmStmicExaSA1766Yq
        eLly3y06gWe9JmVHvzYZEhhw2RdwNZ+mUzNSEN8jND4Xv5WU7EaHlYsqrvn7wLpHY1NUE5fWpzqMg
        7B+JlhHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvPiP-0002sa-Ba; Tue, 14 Jul 2020 18:31:41 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 513079817E0; Tue, 14 Jul 2020 20:31:43 +0200 (CEST)
Date:   Tue, 14 Jul 2020 20:31:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v6 15/17] static_call: Allow early init
Message-ID: <20200714183143.GF5523@worktop.programming.kicks-ass.net>
References: <20200710133831.943894387@infradead.org>
 <20200710134337.036717190@infradead.org>
 <20200710211426.298a3d94@oasis.local.home>
 <20200711050831.GY597537@hirez.programming.kicks-ass.net>
 <20200713162419.3a45f334@oasis.local.home>
 <20200714095117.GS10769@hirez.programming.kicks-ass.net>
 <20200714101636.5022a558@oasis.local.home>
 <20200714155417.GZ10769@hirez.programming.kicks-ass.net>
 <20200714120701.332f310d@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714120701.332f310d@oasis.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 12:07:01PM -0400, Steven Rostedt wrote:
> Can we add a statement that says something like: "Because x86 now calls
> static_call_init() before the setup of the memory allocator, we must
> avoid using kmalloc() and friends for core kernel static calls." ?
> 
> This was the missing piece for me.

It now reads like this.

---
Subject: static_call: Allow early init
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 4 Oct 17:21:10 CEST 2019

In order to use static_call() to wire up x86_pmu, we need to
initialize earlier, specifically before memory allocation works; copy
some of the tricks from jump_label to enable this.

Primarily we overload key->next to store a sites pointer when there
are no modules, this avoids having to use kmalloc() to initialize the
sites and allows us to run much earlier.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/setup.c       |    2 +
 arch/x86/kernel/static_call.c |    8 ++++
 include/linux/static_call.h   |   15 +++++++--
 kernel/static_call.c          |   70 +++++++++++++++++++++++++++++++++++++++---
 4 files changed, 88 insertions(+), 7 deletions(-)

--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -19,6 +19,7 @@
 #include <linux/hugetlb.h>
 #include <linux/tboot.h>
 #include <linux/usb/xhci-dbgp.h>
+#include <linux/static_call.h>

 #include <uapi/linux/mount.h>

@@ -848,6 +849,7 @@ void __init setup_arch(char **cmdline_p)
 	early_cpu_init();
 	arch_init_ideal_nops();
 	jump_label_init();
+	static_call_init();
 	early_ioremap_init();

 	setup_olpc_ofw_pgd();
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -11,7 +11,7 @@ enum insn_type {
 	RET = 3,  /* tramp / site cond-tail-call */
 };

-static void __static_call_transform(void *insn, enum insn_type type, void *func)
+static void __ref __static_call_transform(void *insn, enum insn_type type, void *func)
 {
 	int size = CALL_INSN_SIZE;
 	const void *code;
@@ -33,11 +33,17 @@ static void __static_call_transform(void
 		code = text_gen_insn(RET_INSN_OPCODE, insn, func);
 		size = RET_INSN_SIZE;
 		break;
+
+	default: /* GCC is a moron -- it figures @code can be uninitialized below */
+		BUG();
 	}

 	if (memcmp(insn, code, size) == 0)
 		return;

+	if (unlikely(system_state == SYSTEM_BOOTING))
+		return text_poke_early(insn, code, size);
+
 	text_poke_bp(insn, code, size, NULL);
 }

--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -136,6 +136,8 @@ extern void arch_static_call_transform(v

 #ifdef CONFIG_HAVE_STATIC_CALL_INLINE

+extern void __init static_call_init(void);
+
 struct static_call_mod {
 	struct static_call_mod *next;
 	struct module *mod; /* for vmlinux, mod == NULL */
@@ -144,7 +146,12 @@ struct static_call_mod {

 struct static_call_key {
 	void *func;
-	struct static_call_mod *mods;
+	union {
+		/* bit 0: 0 = mods, 1 = sites */
+		unsigned long type;
+		struct static_call_mod *mods;
+		struct static_call_site *sites;
+	};
 };

 extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
@@ -155,7 +162,7 @@ extern int static_call_text_reserved(voi
 	DECLARE_STATIC_CALL(name, _func);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
 		.func = _func,						\
-		.mods = NULL,						\
+		.type = 1,						\
 	};								\
 	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)

@@ -180,6 +187,8 @@ extern int static_call_text_reserved(voi

 #elif defined(CONFIG_HAVE_STATIC_CALL)

+static inline void static_call_init(void) { }
+
 struct static_call_key {
 	void *func;
 };
@@ -225,6 +234,8 @@ static inline int static_call_text_reser

 #else /* Generic implementation */

+static inline void static_call_init(void) { }
+
 struct static_call_key {
 	void *func;
 };
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -94,10 +94,31 @@ static inline void static_call_sort_entr
 	     static_call_site_cmp, static_call_site_swap);
 }

+static inline bool static_call_key_has_mods(struct static_call_key *key)
+{
+	return !(key->type & 1);
+}
+
+static inline struct static_call_mod *static_call_key_next(struct static_call_key *key)
+{
+	if (!static_call_key_has_mods(key))
+		return NULL;
+
+	return key->mods;
+}
+
+static inline struct static_call_site *static_call_key_sites(struct static_call_key *key)
+{
+	if (static_call_key_has_mods(key))
+		return NULL;
+
+	return (struct static_call_site *)(key->type & ~1);
+}
+
 void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 {
 	struct static_call_site *site, *stop;
-	struct static_call_mod *site_mod;
+	struct static_call_mod *site_mod, first;

 	cpus_read_lock();
 	static_call_lock();
@@ -116,13 +137,22 @@ void __static_call_update(struct static_
 	if (WARN_ON_ONCE(!static_call_initialized))
 		goto done;

-	for (site_mod = key->mods; site_mod; site_mod = site_mod->next) {
+	first = (struct static_call_mod){
+		.next = static_call_key_next(key),
+		.mod = NULL,
+		.sites = static_call_key_sites(key),
+	};
+
+	for (site_mod = &first; site_mod; site_mod = site_mod->next) {
 		struct module *mod = site_mod->mod;

 		if (!site_mod->sites) {
 			/*
 			 * This can happen if the static call key is defined in
 			 * a module which doesn't use it.
+			 *
+			 * It also happens in the has_mods case, where the
+			 * 'first' entry has no sites associated with it.
 			 */
 			continue;
 		}
@@ -192,16 +222,48 @@ static int __static_call_init(struct mod
 		if (key != prev_key) {
 			prev_key = key;

+			/*
+			 * For vmlinux (!mod) avoid the allocation by storing
+			 * the sites pointer in the key itself. Also see
+			 * __static_call_update()'s @first.
+			 *
+			 * This allows architectures (eg. x86) to call
+			 * static_call_init() before memory allocation works.
+			 */
+			if (!mod) {
+				key->sites = site;
+				key->type |= 1;
+				goto do_transform;
+			}
+
 			site_mod = kzalloc(sizeof(*site_mod), GFP_KERNEL);
 			if (!site_mod)
 				return -ENOMEM;

+			/*
+			 * When the key has a direct sites pointer, extract
+			 * that into an explicit struct static_call_mod, so we
+			 * can have a list of modules.
+			 */
+			if (static_call_key_sites(key)) {
+				site_mod->mod = NULL;
+				site_mod->next = NULL;
+				site_mod->sites = static_call_key_sites(key);
+
+				key->mods = site_mod;
+
+				site_mod = kzalloc(sizeof(*site_mod), GFP_KERNEL);
+				if (!site_mod)
+					return -ENOMEM;
+			}
+
 			site_mod->mod = mod;
 			site_mod->sites = site;
-			site_mod->next = key->mods;
+			site_mod->next = static_call_key_next(key);
 			key->mods = site_mod;
 		}

+do_transform:
 		arch_static_call_transform(site_addr, NULL, key->func,
 				static_call_is_tail(site));
 	}
@@ -348,7 +410,7 @@ int static_call_text_reserved(void *star
 	return __static_call_mod_text_reserved(start, end);
 }

-static void __init static_call_init(void)
+void __init static_call_init(void)
 {
 	int ret;


