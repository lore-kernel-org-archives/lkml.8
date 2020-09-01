Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C32AC433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 716CC2220B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MZkOHEZz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SFZyZRLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgIAOt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:49:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39618 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbgIALs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:48:29 -0400
Date:   Tue, 01 Sep 2020 11:48:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598960883;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z7agiW4QyJ/KwxkgyxmE/KuLGl4OhPxpu3gpLz1BoIY=;
        b=MZkOHEZzQNDCf58BRRdAf2ICd30/zCDUVPbzTWy2a19zbNCaz9ZWa9PtCYbXUfKXfDH+Ds
        QtNlST16BFzyV0vl283P6W6/lskQXeYUL4Mq7jRz0gPvIk0pvJa8TqOGbUKSbKkWZwKSq2
        j4qL+S4zcIovMEWbg1ExAM/8qQ6h3WQP2fjH2mEDugF/x2+2lneIuwlApE9mJszeOzMbes
        qWIhvKMKJMI/P4vXsaX9DQF9tpOm4GWpFk90+VavxPNBeQZPUsU7eRd3e9H+83SqA+8AA8
        eurvyvaOtLujbAi7phUz7AcRIu4tuYrTq05fD2vwa1U85gL9XS5Amn0z4ChhYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598960883;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z7agiW4QyJ/KwxkgyxmE/KuLGl4OhPxpu3gpLz1BoIY=;
        b=SFZyZRLAxBezvWumwK2Gu/vUnAAVXw4zrfZqP7VVWxlR2yhL59omwop5CAi3E4pr4UeWl/
        CyY/Qx/2ekuC23Bg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/static_call] static_call: Allow early init
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200818135805.220737930@infradead.org>
References: <20200818135805.220737930@infradead.org>
MIME-Version: 1.0
Message-ID: <159896088285.20229.7006009162500635991.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/static_call branch of tip:

Commit-ID:     a945c8345ec0decb2f1a7f19a8c5e60bcb1dd1eb
Gitweb:        https://git.kernel.org/tip/a945c8345ec0decb2f1a7f19a8c5e60bcb1dd1eb
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 18 Aug 2020 15:57:51 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Sep 2020 09:58:06 +02:00

static_call: Allow early init

In order to use static_call() to wire up x86_pmu, we need to
initialize earlier, specifically before memory allocation works; copy
some of the tricks from jump_label to enable this.

Primarily we overload key->next to store a sites pointer when there
are no modules, this avoids having to use kmalloc() to initialize the
sites and allows us to run much earlier.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Link: https://lore.kernel.org/r/20200818135805.220737930@infradead.org
---
 arch/x86/kernel/setup.c       |  2 +-
 arch/x86/kernel/static_call.c |  5 +-
 include/linux/static_call.h   | 15 ++++++-
 kernel/static_call.c          | 70 ++++++++++++++++++++++++++++++++--
 4 files changed, 85 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 3511736..799a6de 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -19,6 +19,7 @@
 #include <linux/hugetlb.h>
 #include <linux/tboot.h>
 #include <linux/usb/xhci-dbgp.h>
+#include <linux/static_call.h>
 
 #include <uapi/linux/mount.h>
 
@@ -849,6 +850,7 @@ void __init setup_arch(char **cmdline_p)
 	early_cpu_init();
 	arch_init_ideal_nops();
 	jump_label_init();
+	static_call_init();
 	early_ioremap_init();
 
 	setup_olpc_ofw_pgd();
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index 55140d8..ca9a380 100644
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
@@ -38,6 +38,9 @@ static void __static_call_transform(void *insn, enum insn_type type, void *func)
 	if (memcmp(insn, code, size) == 0)
 		return;
 
+	if (unlikely(system_state == SYSTEM_BOOTING))
+		return text_poke_early(insn, code, size);
+
 	text_poke_bp(insn, code, size, NULL);
 }
 
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 519bd66..bfa2ba3 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -136,6 +136,8 @@ extern void arch_static_call_transform(void *site, void *tramp, void *func, bool
 
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
@@ -155,7 +162,7 @@ extern int static_call_text_reserved(void *start, void *end);
 	DECLARE_STATIC_CALL(name, _func);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
 		.func = _func,						\
-		.mods = NULL,						\
+		.type = 1,						\
 	};								\
 	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
 
@@ -180,6 +187,8 @@ extern int static_call_text_reserved(void *start, void *end);
 
 #elif defined(CONFIG_HAVE_STATIC_CALL)
 
+static inline void static_call_init(void) { }
+
 struct static_call_key {
 	void *func;
 };
@@ -225,6 +234,8 @@ static inline int static_call_text_reserved(void *start, void *end)
 
 #else /* Generic implementation */
 
+static inline void static_call_init(void) { }
+
 struct static_call_key {
 	void *func;
 };
diff --git a/kernel/static_call.c b/kernel/static_call.c
index d98e0e4..f8362b3 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -94,10 +94,31 @@ static inline void static_call_sort_entries(struct static_call_site *start,
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
@@ -116,13 +137,22 @@ void __static_call_update(struct static_call_key *key, void *tramp, void *func)
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
@@ -192,16 +222,48 @@ static int __static_call_init(struct module *mod,
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
@@ -348,7 +410,7 @@ int static_call_text_reserved(void *start, void *end)
 	return __static_call_mod_text_reserved(start, end);
 }
 
-static void __init static_call_init(void)
+void __init static_call_init(void)
 {
 	int ret;
 
