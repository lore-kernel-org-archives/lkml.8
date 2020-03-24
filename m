Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28939C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD0C2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0j8iczpI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbgCXOYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:24:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53552 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbgCXOYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:24:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=i5YoBzN4qoaobbaK60Tev+6A/T5y+Z/0nrQ0ki04TPM=; b=0j8iczpI5BTWshSKZp32cR7nrv
        3C2Mbdy+zZkcXi1JLEv6CUqHRJLK7LLGQtIYWlvKd/5lum2gme2mvhLJXoAT3QmgJrV2zRLR9n/uX
        YDCdD5zGwHpl31VbTIuGa3PT+dpKxolD46K8esfeJnbwdVreT27cZioYMrhFQjDVE1dI8nzP4ewlt
        QDCohDfu1qfBwh0mY6baJZBkGyxzhd4wuJXPJ2b9AzXgKLEyS5kJkp5VuWSZee1XbGuqPm0GXhFXz
        yfCmVvk+kRmETqo4OpR8QMkXPGw3Xr65LNv7nITUV1FRTrZGJywYhPnL0+Cip+sjhPt4YkdGtdQa1
        k54wBLMA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGkTw-0003p7-KM; Tue, 24 Mar 2020 14:24:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8915830796E;
        Tue, 24 Mar 2020 15:24:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 34960286C13BD; Tue, 24 Mar 2020 15:24:35 +0100 (CET)
Message-Id: <20200324142246.247811691@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 24 Mar 2020 14:56:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com
Subject: [RESEND][PATCH v3 16/17] static_call: Allow early init
References: <20200324135603.483964896@infradead.org>
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
 include/linux/static_call.h   |   15 ++++++++++--
 kernel/static_call.c          |   52 +++++++++++++++++++++++++++++++++++++++---
 4 files changed, 71 insertions(+), 6 deletions(-)

--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -18,6 +18,7 @@
 #include <linux/sfi.h>
 #include <linux/tboot.h>
 #include <linux/usb/xhci-dbgp.h>
+#include <linux/static_call.h>
 
 #include <uapi/linux/mount.h>
 
@@ -841,6 +842,7 @@ void __init setup_arch(char **cmdline_p)
 	early_cpu_init();
 	arch_init_ideal_nops();
 	jump_label_init();
+	static_call_init();
 	early_ioremap_init();
 
 	setup_olpc_ofw_pgd();
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -11,7 +11,7 @@ enum insn_type {
 	ret = 3,  /* tramp / site cond-tail-call */
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
@@ -84,6 +84,8 @@ extern void arch_static_call_transform(v
 
 #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
 
+extern void __init static_call_init(void);
+
 struct static_call_mod {
 	struct static_call_mod *next;
 	struct module *mod; /* for vmlinux, mod == NULL */
@@ -92,7 +94,12 @@ struct static_call_mod {
 
 struct static_call_key {
 	void *func;
-	struct static_call_mod *next;
+	union {
+		/* bit0 => 0 - next, 1 - sites */
+		unsigned long type;
+		struct static_call_mod *next;
+		struct static_call_site *sites;
+	};
 };
 
 extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
@@ -103,7 +110,7 @@ extern int static_call_text_reserved(voi
 	DECLARE_STATIC_CALL(name, _func);				\
 	struct static_call_key STATIC_CALL_NAME(name) = {		\
 		.func = _func,						\
-		.next = NULL,						\
+		.type = 1,						\
 	};								\
 	__ADDRESSABLE(STATIC_CALL_NAME(name));				\
 	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
@@ -121,6 +128,8 @@ extern int static_call_text_reserved(voi
 
 #elif defined(CONFIG_HAVE_STATIC_CALL)
 
+static inline void static_call_init(void) { }
+
 struct static_call_key {
 	void *func;
 };
@@ -154,6 +163,8 @@ static inline int static_call_text_reser
 
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
 
+static inline bool static_call_key_has_next(struct static_call_key *key)
+{
+	return !(key->type & 1);
+}
+
+static inline struct static_call_mod *static_call_key_next(struct static_call_key *key)
+{
+	if (static_call_key_has_next(key))
+		return key->next->next;
+
+	return NULL;
+}
+
+static inline struct static_call_site *static_call_key_sites(struct static_call_key *key)
+{
+	if (static_call_key_has_next(key))
+		return key->next->sites;
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
@@ -116,7 +137,13 @@ void __static_call_update(struct static_
 	if (WARN_ON_ONCE(!static_call_initialized))
 		goto done;
 
-	for (site_mod = key->next; site_mod; site_mod = site_mod->next) {
+	first = (struct static_call_mod){
+		.next = static_call_key_next(key),
+		.mod = NULL,
+		.sites = static_call_key_sites(key),
+	};
+
+	for (site_mod = &first; site_mod; site_mod = site_mod->next) {
 		if (!site_mod->sites) {
 			/*
 			 * This can happen if the static call key is defined in
@@ -191,16 +218,35 @@ static int __static_call_init(struct mod
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
 
+			if (!static_call_key_has_next(key)) {
+				site_mod->mod = NULL;
+				site_mod->next = NULL;
+				site_mod->sites = static_call_key_sites(key);
+
+				key->next = site_mod;
+
+				site_mod = kzalloc(sizeof(*site_mod), GFP_KERNEL);
+				if (!site_mod)
+					return -ENOMEM;
+			}
+
 			site_mod->mod = mod;
 			site_mod->sites = site;
 			site_mod->next = key->next;
 			key->next = site_mod;
 		}
 
+do_transform:
 		arch_static_call_transform(site_addr, NULL, key->func,
 				static_call_is_tail(site));
 	}
@@ -343,7 +389,7 @@ int static_call_text_reserved(void *star
 	return ret;
 }
 
-static void __init static_call_init(void)
+void __init static_call_init(void)
 {
 	int ret;
 


