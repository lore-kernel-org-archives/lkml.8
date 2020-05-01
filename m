Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B958C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E0DE21924
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IfptimWg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgEAUbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 16:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgEAUbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 16:31:37 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DCCC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 13:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Sw4ERXI3r73tyUwEjyZgq/YYzPc3swez0MF5PckWJF8=; b=IfptimWgYWg0AwLX97bdoBMleQ
        JpcT68ozd3dpB+KlxcrMEbr9zUudauI2430VpQUXQPkc4uiguifvSHs9MBmnf9C55lrfGSFzLlo/k
        ik+0VuZItBO7MqvJyMuPLOTO8E7Dz1DxxgUXvLGWX8fiwM2ZDOyUvpLuAlenckxnpLBLQJT0g5tJG
        hg0PxoT9CLtBlWH56PmEJX66w/5/JsyBAxf3WndLORBZXELEqDyTegZDKKkPBHX5kpo7DrsyTPtC2
        4LcSYFTriwq5+yqRZXIjWpfBe/urP309hs+B3wBOudoFCGTxWjDgMUCfmKs9L/ua0KmR89FDYgtSy
        ldAnGs+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUcJL-0007R1-LU; Fri, 01 May 2020 20:31:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7F638307197;
        Fri,  1 May 2020 22:31:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D2CC629BF6262; Fri,  1 May 2020 22:31:00 +0200 (CEST)
Message-Id: <20200501202944.244063853@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 01 May 2020 22:28:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com
Subject: [PATCH v4 08/18] static_call: Avoid kprobes on inline static_call()s
References: <20200501202849.647891881@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to how we disallow kprobes on any other dynamic text
(ftrace/jump_label) also disallow kprobes on inline static_call()s.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/kprobes/opt.c |    4 +-
 include/linux/static_call.h   |   11 +++++++
 kernel/kprobes.c              |    2 +
 kernel/static_call.c          |   64 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 80 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -16,6 +16,7 @@
 #include <linux/kallsyms.h>
 #include <linux/ftrace.h>
 #include <linux/frame.h>
+#include <linux/static_call.h>
 
 #include <asm/text-patching.h>
 #include <asm/cacheflush.h>
@@ -209,7 +210,8 @@ static int copy_optimized_instructions(u
 	/* Check whether the address range is reserved */
 	if (ftrace_text_reserved(src, src + len - 1) ||
 	    alternatives_text_reserved(src, src + len - 1) ||
-	    jump_label_text_reserved(src, src + len - 1))
+	    jump_label_text_reserved(src, src + len - 1) ||
+	    static_call_text_reserved(src, src + len - 1))
 		return -EBUSY;
 
 	return len;
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -110,6 +110,7 @@ struct static_call_key {
 
 extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
 extern int static_call_mod_init(struct module *mod);
+extern int static_call_text_reserved(void *start, void *end);
 
 #define DEFINE_STATIC_CALL(name, _func)					\
 	DECLARE_STATIC_CALL(name, _func);				\
@@ -153,6 +154,11 @@ void __static_call_update(struct static_
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
@@ -182,6 +188,11 @@ void __static_call_update(struct static_
 	WRITE_ONCE(key->func, func);
 }
 
+static inline int static_call_text_reserved(void *start, void *end)
+{
+	return 0;
+}
+
 #define EXPORT_STATIC_CALL(name)	EXPORT_SYMBOL(STATIC_CALL_KEY(name))
 #define EXPORT_STATIC_CALL_GPL(name)	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name))
 
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -35,6 +35,7 @@
 #include <linux/ftrace.h>
 #include <linux/cpu.h>
 #include <linux/jump_label.h>
+#include <linux/static_call.h>
 
 #include <asm/sections.h>
 #include <asm/cacheflush.h>
@@ -1560,6 +1561,7 @@ static int check_kprobe_address_safe(str
 	if (!kernel_text_address((unsigned long) p->addr) ||
 	    within_kprobe_blacklist((unsigned long) p->addr) ||
 	    jump_label_text_reserved(p->addr, p->addr) ||
+	    static_call_text_reserved(p->addr, p->addr) ||
 	    find_bug((unsigned long)p->addr)) {
 		ret = -EINVAL;
 		goto out;
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -203,8 +203,58 @@ static int __static_call_init(struct mod
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
@@ -274,6 +324,20 @@ static struct notifier_block static_call
 
 #endif /* CONFIG_MODULES */
 
+int static_call_text_reserved(void *start, void *end)
+{
+	int ret = __static_call_text_reserved(__start_static_call_sites,
+			__stop_static_call_sites, start, end);
+
+	if (ret)
+		return ret;
+
+#ifdef CONFIG_MODULES
+	ret = __static_call_mod_text_reserved(start, end);
+#endif
+	return ret;
+}
+
 static void __init static_call_init(void)
 {
 	int ret;


