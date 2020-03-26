Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C378C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1442D2082D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585234197;
	bh=0ftlkzYHF/b8rzXkT2h8EzUPg/VHnvX9r1tPA724Zk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s9eyjXosNuEfvnZXKlXNMaYl0FLM7EIPEYmGUC/oZdF0tAQHs2gkvAnk23f36L3K+
	 cV1BGUuQkdXJ3MnGsAAqwLLpTJrd1kqiKuY83HfYs0tdXIj2OWb/WB+1/kAst7B9Ve
	 Gov0u8AHhCZVFVrZ4Is68/ZTS13WrivZL/h+Q3X8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgCZOtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 10:49:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgCZOtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 10:49:55 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBEEF2077D;
        Thu, 26 Mar 2020 14:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585234194;
        bh=0ftlkzYHF/b8rzXkT2h8EzUPg/VHnvX9r1tPA724Zk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k+QcV8NBKo5Ix9iGX/ih9MOU1F/jP96Lh6trgiCiKHsIk+88+t4guaLV6ZDyrbEqq
         Yg2xtw6kwR8tx7yerRfWGSeFcaauQ0TMhDL2nE4LkXeFPc3iB10oIK6XTCoklL/oQ2
         2zHh51ULBrx8U8mTdgu4znlUG87GUe6dpJoMHcFI=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Paul McKenney <paulmck@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH -tip 2/4] kprobes: Support __kprobes blacklist in modules
Date:   Thu, 26 Mar 2020 23:49:48 +0900
Message-Id: <158523418821.24735.15379873028352411526.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158523416289.24735.10455512519475919061.stgit@devnote2>
References: <158523416289.24735.10455512519475919061.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support __kprobes attribute for blacklist functions in modules.
The __kprobes attribute functions are stored in .kprobes.text
section.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/module.h |    4 ++++
 kernel/kprobes.c       |   42 ++++++++++++++++++++++++++++++++++++++++++
 kernel/module.c        |    4 ++++
 3 files changed, 50 insertions(+)

diff --git a/include/linux/module.h b/include/linux/module.h
index 1ad393e62bef..369c354f9207 100644
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
index 570d60827656..b7549992b9bd 100644
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
index 33569a01d6e1..f7712a923d63 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3193,6 +3193,10 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 	mod->ei_funcs = section_objs(info, "_error_injection_whitelist",
 					    sizeof(*mod->ei_funcs),
 					    &mod->num_ei_funcs);
+#endif
+#ifdef CONFIG_KPROBES
+	mod->kprobes_text_start = section_objs(info, ".kprobes.text", 1,
+						&mod->kprobes_text_size);
 #endif
 	mod->extable = section_objs(info, "__ex_table",
 				    sizeof(*mod->extable), &mod->num_exentries);

