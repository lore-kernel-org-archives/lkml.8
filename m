Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F373CC47257
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D78E5206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbgEEOYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729434AbgEEONw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:13:52 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23754C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:13:52 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyKE-0000Uv-7f; Tue, 05 May 2020 16:13:34 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id B61D5FFC8D;
        Tue,  5 May 2020 16:13:33 +0200 (CEST)
Message-Id: <20200505134059.678201813@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:16:18 +0200
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
Subject: [patch V4 part 1 16/36] kprobes: Support __kprobes blacklist in modules
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

From: Masami Hiramatsu <mhiramat@kernel.org>

Support __kprobes attribute for blacklist functions in modules.  The
__kprobes attribute functions are stored in .kprobes.text section.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/158523418821.24735.15379873028352411526.stgit@devnote2

---
 include/linux/module.h |    4 ++++
 kernel/kprobes.c       |   42 ++++++++++++++++++++++++++++++++++++++++++
 kernel/module.c        |    4 ++++
 3 files changed, 50 insertions(+)

--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -489,6 +489,10 @@ struct module {
 	unsigned int num_ftrace_callsites;
 	unsigned long *ftrace_callsites;
 #endif
+#ifdef CONFIG_KPROBES
+	void *kprobes_text_start;
+	unsigned int kprobes_text_size;
+#endif
 
 #ifdef CONFIG_LIVEPATCH
 	bool klp; /* Is this a livepatch module? */
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2179,6 +2179,19 @@ int kprobe_add_area_blacklist(unsigned l
 	return 0;
 }
 
+/* Remove all symbols in given area from kprobe blacklist */
+static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
+{
+	struct kprobe_blacklist_entry *ent, *n;
+
+	list_for_each_entry_safe(ent, n, &kprobe_blacklist, list) {
+		if (ent->start_addr < start || ent->start_addr >= end)
+			continue;
+		list_del(&ent->list);
+		kfree(ent);
+	}
+}
+
 int __init __weak arch_populate_kprobe_blacklist(void)
 {
 	return 0;
@@ -2215,6 +2228,28 @@ static int __init populate_kprobe_blackl
 	return ret ? : arch_populate_kprobe_blacklist();
 }
 
+static void add_module_kprobe_blacklist(struct module *mod)
+{
+	unsigned long start, end;
+
+	start = (unsigned long)mod->kprobes_text_start;
+	if (start) {
+		end = start + mod->kprobes_text_size;
+		kprobe_add_area_blacklist(start, end);
+	}
+}
+
+static void remove_module_kprobe_blacklist(struct module *mod)
+{
+	unsigned long start, end;
+
+	start = (unsigned long)mod->kprobes_text_start;
+	if (start) {
+		end = start + mod->kprobes_text_size;
+		kprobe_remove_area_blacklist(start, end);
+	}
+}
+
 /* Module notifier call back, checking kprobes on the module */
 static int kprobes_module_callback(struct notifier_block *nb,
 				   unsigned long val, void *data)
@@ -2225,6 +2260,11 @@ static int kprobes_module_callback(struc
 	unsigned int i;
 	int checkcore = (val == MODULE_STATE_GOING);
 
+	if (val == MODULE_STATE_COMING) {
+		mutex_lock(&kprobe_mutex);
+		add_module_kprobe_blacklist(mod);
+		mutex_unlock(&kprobe_mutex);
+	}
 	if (val != MODULE_STATE_GOING && val != MODULE_STATE_LIVE)
 		return NOTIFY_DONE;
 
@@ -2255,6 +2295,8 @@ static int kprobes_module_callback(struc
 				kill_kprobe(p);
 			}
 	}
+	if (val == MODULE_STATE_GOING)
+		remove_module_kprobe_blacklist(mod);
 	mutex_unlock(&kprobe_mutex);
 	return NOTIFY_DONE;
 }
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3194,6 +3194,10 @@ static int find_module_sections(struct m
 					    sizeof(*mod->ei_funcs),
 					    &mod->num_ei_funcs);
 #endif
+#ifdef CONFIG_KPROBES
+	mod->kprobes_text_start = section_objs(info, ".kprobes.text", 1,
+						&mod->kprobes_text_size);
+#endif
 	mod->extable = section_objs(info, "__ex_table",
 				    sizeof(*mod->extable), &mod->num_exentries);
 

