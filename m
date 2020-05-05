Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AC6C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB3B620838
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730510AbgEEOX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729471AbgEEON6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:13:58 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B54C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:13:58 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyKK-0000Za-G2; Tue, 05 May 2020 16:13:40 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id EE108FFC8D;
        Tue,  5 May 2020 16:13:39 +0200 (CEST)
Message-Id: <20200505134100.179862032@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:16:23 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: [patch V4 part 1 21/36] kprobes: Prevent probes in .noinstr.text section
References: <20200505131602.633487962@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instrumentation is forbidden in the .noinstr.text section. Make kprobes
respect this.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/module.h |    2 ++
 kernel/kprobes.c       |   18 ++++++++++++++++++
 kernel/module.c        |    3 +++
 3 files changed, 23 insertions(+)

--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -458,6 +458,8 @@ struct module {
 	void __percpu *percpu;
 	unsigned int percpu_size;
 #endif
+	void *noinstr_text_start;
+	unsigned int noinstr_text_size;
 
 #ifdef CONFIG_TRACEPOINTS
 	unsigned int num_tracepoints;
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2229,6 +2229,12 @@ static int __init populate_kprobe_blackl
 	/* Symbols in __kprobes_text are blacklisted */
 	ret = kprobe_add_area_blacklist((unsigned long)__kprobes_text_start,
 					(unsigned long)__kprobes_text_end);
+	if (ret)
+		return ret;
+
+	/* Symbols in noinstr section are blacklisted */
+	ret = kprobe_add_area_blacklist((unsigned long)__noinstr_text_start,
+					(unsigned long)__noinstr_text_end);
 
 	return ret ? : arch_populate_kprobe_blacklist();
 }
@@ -2248,6 +2254,12 @@ static void add_module_kprobe_blacklist(
 		end = start + mod->kprobes_text_size;
 		kprobe_add_area_blacklist(start, end);
 	}
+
+	start = (unsigned long)mod->noinstr_text_start;
+	if (start) {
+		end = start + mod->noinstr_text_size;
+		kprobe_add_area_blacklist(start, end);
+	}
 }
 
 static void remove_module_kprobe_blacklist(struct module *mod)
@@ -2265,6 +2277,12 @@ static void remove_module_kprobe_blackli
 		end = start + mod->kprobes_text_size;
 		kprobe_remove_area_blacklist(start, end);
 	}
+
+	start = (unsigned long)mod->noinstr_text_start;
+	if (start) {
+		end = start + mod->noinstr_text_size;
+		kprobe_remove_area_blacklist(start, end);
+	}
 }
 
 /* Module notifier call back, checking kprobes on the module */
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3150,6 +3150,9 @@ static int find_module_sections(struct m
 	}
 #endif
 
+	mod->noinstr_text_start = section_objs(info, ".noinstr.text", 1,
+						&mod->noinstr_text_size);
+
 #ifdef CONFIG_TRACEPOINTS
 	mod->tracepoints_ptrs = section_objs(info, "__tracepoints_ptrs",
 					     sizeof(*mod->tracepoints_ptrs),

