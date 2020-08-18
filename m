Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316B9C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BE8A20786
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lpfGBqZ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgHROQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbgHROM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:12:26 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF03C061343
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 07:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=AwvM0zlXDZu+2GkEyaiWz2zndTWZII374Hua899bqqw=; b=lpfGBqZ16nioA2YSQ3wJ/a/vil
        YH+6g2hLVxMsMS7ZO0cUpbNYLGnWyLkAXDPtaRnbO6CoEdrF0tbv+eC85IIHr8TJBUJW+NcgBczWo
        XILNIFrCrJ7Mn7UsHn15RTt0Da4g1PbTMQiBYJKSlB9wgcCtquXYZxkDqBohLu+eLMEnIZQhqgZ4a
        Xonp5rb39APGqNU40pQg2qFyQ6pUK/zllhmRqHpunw9BQevAlozaOPkhoBbaFVBPjyeC5OE3Cg6C7
        0BgMkQAgdfEAY4xVieELx3ISkQ7S4wbtNNQ1n9I1H8qfLkSO5PL06LrFOzf/Zbv9L6b5bkQ0pE2Eu
        YBoU3lFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k82LL-0000oL-8X; Tue, 18 Aug 2020 14:12:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B1E60307985;
        Tue, 18 Aug 2020 16:12:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E43A923D42C10; Tue, 18 Aug 2020 16:11:59 +0200 (CEST)
Message-ID: <20200818135805.220737930@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 18 Aug 2020 15:57:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com, linux@rasmusvillemoes.dk
Subject: [PATCH v7 16/18] static_call: Allow early init
References: <20200818135735.948368560@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to use static_call() to wire up x86_pmu, we need to
initialize earlier, specifically before memory allocation works; copy
some of the tricks from jump_label to enable this.

Primarily we overload key->next to store a sites pointer when there
are no modules, this avoids having to use kmalloc() to initialize the
sites and allows us to run much earlier.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/kernel/setup.c       |    2 +
 arch/x86/kernel/static_call.c |    5 ++-
 include/linux/static_call.h   |   15 +++++++--
 kernel/static_call.c          |   70 +++++++++++++++++++++++++++++++++++++++---
 4 files changed, 85 insertions(+), 7 deletions(-)

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
@@ -38,6 +38,9 @@ static void __static_call_transform(void
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
 


