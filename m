Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86251C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B60C206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uP6cbJoF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6jL0d5GK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgIAOQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:16:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39608 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgIALt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:49:28 -0400
Date:   Tue, 01 Sep 2020 11:48:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598960886;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4kgut8ahZ0Lq5VEhFAm0U5nUC9zhWeebYfNZufUqLCU=;
        b=uP6cbJoFXj0+lpXl+lBPj8OenWKGrf49PGRNYgwpRkuwxoZBoPRy98np3QjpkAgi93ZF32
        sdbgb4NdSGAVM/WYbVM1xmZnSYmBxzKDLoQlnhWBDtxqtk6XifrBzxQutHojUvp9bt44lJ
        JiMpQfuKr4nzz+6HsUhExXGcSebZ+YJsLndIVnOuO7X6GEVczcrR24m8nEEFAliLz5G2IS
        gEApeB7vDyiw+rPvj1U0sZqwrD75ifpgiOtOSRuW+5ZMq2vxH1e45ZWQwAr43zEZlXQ5aQ
        LohAsaZwJb6X/Qb70V3jBAnD4Bx6T+elzVQwRyXEucNf83OnrQOnvqx9jEKB7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598960886;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4kgut8ahZ0Lq5VEhFAm0U5nUC9zhWeebYfNZufUqLCU=;
        b=6jL0d5GKOvR9NRdV7PXns3ki8Wq8lW08b6J9fby+KHKaS1ot3ybgjwvMrTJFrFJumqbxdF
        f1MHs2cRYQekGPCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/static_call] static_call: Avoid kprobes on inline static_call()s
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200818135804.744920586@infradead.org>
References: <20200818135804.744920586@infradead.org>
MIME-Version: 1.0
Message-ID: <159896088615.20229.15511148906614733874.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/static_call branch of tip:

Commit-ID:     6333e8f73b834f54e395a056e6002403f0862c51
Gitweb:        https://git.kernel.org/tip/6333e8f73b834f54e395a056e6002403f0862c51
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 18 Aug 2020 15:57:43 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Sep 2020 09:58:04 +02:00

static_call: Avoid kprobes on inline static_call()s

Similar to how we disallow kprobes on any other dynamic text
(ftrace/jump_label) also disallow kprobes on inline static_call()s.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200818135804.744920586@infradead.org
---
 arch/x86/kernel/kprobes/opt.c |  4 +-
 include/linux/static_call.h   | 11 ++++++-
 kernel/kprobes.c              |  2 +-
 kernel/static_call.c          | 68 ++++++++++++++++++++++++++++++++++-
 4 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 40f3804..c068e21 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -18,6 +18,7 @@
 #include <linux/ftrace.h>
 #include <linux/frame.h>
 #include <linux/pgtable.h>
+#include <linux/static_call.h>
 
 #include <asm/text-patching.h>
 #include <asm/cacheflush.h>
@@ -210,7 +211,8 @@ static int copy_optimized_instructions(u8 *dest, u8 *src, u8 *real)
 	/* Check whether the address range is reserved */
 	if (ftrace_text_reserved(src, src + len - 1) ||
 	    alternatives_text_reserved(src, src + len - 1) ||
-	    jump_label_text_reserved(src, src + len - 1))
+	    jump_label_text_reserved(src, src + len - 1) ||
+	    static_call_text_reserved(src, src + len - 1))
 		return -EBUSY;
 
 	return len;
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 0d7f9ef..6f62ced 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -110,6 +110,7 @@ struct static_call_key {
 
 extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
 extern int static_call_mod_init(struct module *mod);
+extern int static_call_text_reserved(void *start, void *end);
 
 #define DEFINE_STATIC_CALL(name, _func)					\
 	DECLARE_STATIC_CALL(name, _func);				\
@@ -153,6 +154,11 @@ void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 	cpus_read_unlock();
 }
 
+static inline int static_call_text_reserved(void *start, void *end)
+{
+	return 0;
+}
+
 #define EXPORT_STATIC_CALL(name)					\
 	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
 	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
@@ -182,6 +188,11 @@ void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 	WRITE_ONCE(key->func, func);
 }
 
+static inline int static_call_text_reserved(void *start, void *end)
+{
+	return 0;
+}
+
 #define EXPORT_STATIC_CALL(name)	EXPORT_SYMBOL(STATIC_CALL_KEY(name))
 #define EXPORT_STATIC_CALL_GPL(name)	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name))
 
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 287b263..67e6a8c 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -36,6 +36,7 @@
 #include <linux/cpu.h>
 #include <linux/jump_label.h>
 #include <linux/perf_event.h>
+#include <linux/static_call.h>
 
 #include <asm/sections.h>
 #include <asm/cacheflush.h>
@@ -1634,6 +1635,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	if (!kernel_text_address((unsigned long) p->addr) ||
 	    within_kprobe_blacklist((unsigned long) p->addr) ||
 	    jump_label_text_reserved(p->addr, p->addr) ||
+	    static_call_text_reserved(p->addr, p->addr) ||
 	    find_bug((unsigned long)p->addr)) {
 		ret = -EINVAL;
 		goto out;
diff --git a/kernel/static_call.c b/kernel/static_call.c
index d243492..753b2f1 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -204,8 +204,58 @@ static int __static_call_init(struct module *mod,
 	return 0;
 }
 
+static int addr_conflict(struct static_call_site *site, void *start, void *end)
+{
+	unsigned long addr = (unsigned long)static_call_addr(site);
+
+	if (addr <= (unsigned long)end &&
+	    addr + CALL_INSN_SIZE > (unsigned long)start)
+		return 1;
+
+	return 0;
+}
+
+static int __static_call_text_reserved(struct static_call_site *iter_start,
+				       struct static_call_site *iter_stop,
+				       void *start, void *end)
+{
+	struct static_call_site *iter = iter_start;
+
+	while (iter < iter_stop) {
+		if (addr_conflict(iter, start, end))
+			return 1;
+		iter++;
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_MODULES
 
+static int __static_call_mod_text_reserved(void *start, void *end)
+{
+	struct module *mod;
+	int ret;
+
+	preempt_disable();
+	mod = __module_text_address((unsigned long)start);
+	WARN_ON_ONCE(__module_text_address((unsigned long)end) != mod);
+	if (!try_module_get(mod))
+		mod = NULL;
+	preempt_enable();
+
+	if (!mod)
+		return 0;
+
+	ret = __static_call_text_reserved(mod->static_call_sites,
+			mod->static_call_sites + mod->num_static_call_sites,
+			start, end);
+
+	module_put(mod);
+
+	return ret;
+}
+
 static int static_call_add_module(struct module *mod)
 {
 	return __static_call_init(mod, mod->static_call_sites,
@@ -273,8 +323,26 @@ static struct notifier_block static_call_module_nb = {
 	.notifier_call = static_call_module_notify,
 };
 
+#else
+
+static inline int __static_call_mod_text_reserved(void *start, void *end)
+{
+	return 0;
+}
+
 #endif /* CONFIG_MODULES */
 
+int static_call_text_reserved(void *start, void *end)
+{
+	int ret = __static_call_text_reserved(__start_static_call_sites,
+			__stop_static_call_sites, start, end);
+
+	if (ret)
+		return ret;
+
+	return __static_call_mod_text_reserved(start, end);
+}
+
 static void __init static_call_init(void)
 {
 	int ret;
