Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC7CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5226206F7
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nc6uI5mt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404635AbgFXPwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404385AbgFXPvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:51:50 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D29C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=haOeI1eZxDJ6jZ+MJAOIZT1VjJU5YRsLJ7XmkFeRNws=; b=nc6uI5mtiCpdjSU19Ft8atU/Pz
        FCsoQO48Kei/3wSEJaSYrbsqDP+RT8yuV/zUgREDEKh7i3WRGsDjtfrUQTUg2/G9GFLxz42iAXGv+
        cVpvG0MwHnIhjOATXc2KMlzmN/QQWdFw9Z3BYrA/TaGVBgknvDTPqCUSlMx4vyxnWT66xyeKw3xtS
        Io21MrMtw5A57kNkz/DSiy1cXZ9AoqzLGwTAqQX+J2oV0v/oEXMVFk/lV9+r3Kq7pHx8awRKWnUza
        37o+z4WUdxiULxvO8LoAhnUP1ZdIYB7kV9Zt6C5di70cpfu2PXqZtN4o3wKqh8M//F4QMPA78PNqM
        z8DmvgtA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo7gD-0004rg-CP; Wed, 24 Jun 2020 15:51:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C08A33079DC;
        Wed, 24 Jun 2020 17:51:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 097F8236E7764; Wed, 24 Jun 2020 17:51:14 +0200 (CEST)
Message-ID: <20200624154157.659488639@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 24 Jun 2020 17:30:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com, linux@rasmusvillemoes.dk
Subject: [PATCH v5 15/17] static_call: Allow early init
References: <20200624153024.794671356@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to use static_call() to wire up x86_pmu, we need to
initialize earlier; copy some of the tricks from jump_label to enable
this.

Primarily we overload key->next to store a sites pointer when there
are no modules, this avoids having to use kmalloc() to initialize the
sites and allows us to run much earlier.

(arguably, this is much much earlier than needed for perf, but it
might allow other uses.)

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/setup.c       |    2 +
 arch/x86/kernel/static_call.c |    8 +++++-
 include/linux/static_call.h   |   15 +++++++++--
 kernel/static_call.c          |   55 +++++++++++++++++++++++++++++++++++++++---
 4 files changed, 74 insertions(+), 6 deletions(-)

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
@@ -99,6 +99,8 @@ extern void arch_static_call_transform(v
 
 #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
 
+extern void __init static_call_init(void);
+
 struct static_call_mod {
 	struct static_call_mod *next;
 	struct module *mod; /* for vmlinux, mod == NULL */
@@ -107,7 +109,12 @@ struct static_call_mod {
 
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
@@ -118,7 +125,7 @@ extern int static_call_text_reserved(voi
 	DECLARE_STATIC_CALL(name, _func);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
 		.func = _func,						\
-		.mods = NULL,						\
+		.type = 1,						\
 	};								\
 	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
 
@@ -143,6 +150,8 @@ extern int static_call_text_reserved(voi
 
 #elif defined(CONFIG_HAVE_STATIC_CALL)
 
+static inline void static_call_init(void) { }
+
 struct static_call_key {
 	void *func;
 };
@@ -188,6 +197,8 @@ static inline int static_call_text_reser
 
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
@@ -192,16 +222,35 @@ static int __static_call_init(struct mod
 		if (key != prev_key) {
 			prev_key = key;
 
+			if (!mod) {
+				key->sites = site;
+				key->type |= 1;
+				goto do_transform;
+			}
+
 			site_mod = kzalloc(sizeof(*site_mod), GFP_KERNEL);
 			if (!site_mod)
 				return -ENOMEM;
 
+			if (!static_call_key_has_mods(key)) {
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
 			site_mod->next = key->mods;
 			key->mods = site_mod;
 		}
 
+do_transform:
 		arch_static_call_transform(site_addr, NULL, key->func,
 				static_call_is_tail(site));
 	}
@@ -344,7 +393,7 @@ int static_call_text_reserved(void *star
 	return ret;
 }
 
-static void __init static_call_init(void)
+void __init static_call_init(void)
 {
 	int ret;
 


