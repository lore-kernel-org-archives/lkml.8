Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD30C54E8E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4E91206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbgELPTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 11:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730236AbgELPTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:19:03 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154F6C061A0C;
        Tue, 12 May 2020 08:19:03 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYWgN-0007Dx-Es; Tue, 12 May 2020 17:18:59 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EE15D1C02FC;
        Tue, 12 May 2020 17:18:58 +0200 (CEST)
Date:   Tue, 12 May 2020 15:18:58 -0000
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/kprobes] kprobes: Support __kprobes blacklist in modules
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134059.678201813@linutronix.de>
References: <20200505134059.678201813@linutronix.de>
MIME-Version: 1.0
Message-ID: <158929673889.390.13328702877624565278.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/kprobes branch of tip:

Commit-ID:     1e6769b0aece51ea7a3dc3117c37d4a5669e4a21
Gitweb:        https://git.kernel.org/tip/1e6769b0aece51ea7a3dc3117c37d4a5669e4a21
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Thu, 26 Mar 2020 23:49:48 +09:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 May 2020 17:15:32 +02:00

kprobes: Support __kprobes blacklist in modules

Support __kprobes attribute for blacklist functions in modules.  The
__kprobes attribute functions are stored in .kprobes.text section.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200505134059.678201813@linutronix.de

---
 include/linux/module.h |  4 ++++-
 kernel/kprobes.c       | 42 +++++++++++++++++++++++++++++++++++++++++-
 kernel/module.c        |  4 ++++-
 3 files changed, 50 insertions(+)

diff --git a/include/linux/module.h b/include/linux/module.h
index 1ad393e..369c354 100644
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
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 570d608..b754999 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2179,6 +2179,19 @@ int kprobe_add_area_blacklist(unsigned long start, unsigned long end)
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
@@ -2215,6 +2228,28 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
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
@@ -2225,6 +2260,11 @@ static int kprobes_module_callback(struct notifier_block *nb,
 	unsigned int i;
 	int checkcore = (val == MODULE_STATE_GOING);
 
+	if (val == MODULE_STATE_COMING) {
+		mutex_lock(&kprobe_mutex);
+		add_module_kprobe_blacklist(mod);
+		mutex_unlock(&kprobe_mutex);
+	}
 	if (val != MODULE_STATE_GOING && val != MODULE_STATE_LIVE)
 		return NOTIFY_DONE;
 
@@ -2255,6 +2295,8 @@ static int kprobes_module_callback(struct notifier_block *nb,
 				kill_kprobe(p);
 			}
 	}
+	if (val == MODULE_STATE_GOING)
+		remove_module_kprobe_blacklist(mod);
 	mutex_unlock(&kprobe_mutex);
 	return NOTIFY_DONE;
 }
diff --git a/kernel/module.c b/kernel/module.c
index 646f1e2..978f3fa 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3194,6 +3194,10 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 					    sizeof(*mod->ei_funcs),
 					    &mod->num_ei_funcs);
 #endif
+#ifdef CONFIG_KPROBES
+	mod->kprobes_text_start = section_objs(info, ".kprobes.text", 1,
+						&mod->kprobes_text_size);
+#endif
 	mod->extable = section_objs(info, "__ex_table",
 				    sizeof(*mod->extable), &mod->num_exentries);
 
