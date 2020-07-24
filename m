Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0215C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 05:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F783206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 05:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgGXFGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 01:06:55 -0400
Received: from mga14.intel.com ([192.55.52.115]:1960 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbgGXFGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 01:06:55 -0400
IronPort-SDR: 7wjU/mUAS3/6pKDegQysAiWc4UbPqkFLPbCqO63EBrkScxAfW5dy6U3HX/LrKf3Wr3NEwRTGjz
 XXJFaBLG5vEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="149850680"
X-IronPort-AV: E=Sophos;i="5.75,389,1589266800"; 
   d="scan'208";a="149850680"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 22:06:51 -0700
IronPort-SDR: NkQ3nkTLEOTcS3WUcF0IMgpx6xsIhIk7jenqF0E1B2U0PJ6N8E5GZfdov8Qyi+ytdAnJoi+O1C
 cK1rk3kfUvoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,389,1589266800"; 
   d="scan'208";a="432970230"
Received: from itopinsk-mobl1.ccr.corp.intel.com (HELO localhost) ([10.249.36.179])
  by orsmga004.jf.intel.com with ESMTP; 23 Jul 2020 22:06:41 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-mm@kvack.org, Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v5 6/6] kprobes: Remove CONFIG_MODULES dependency
Date:   Fri, 24 Jul 2020 08:05:53 +0300
Message-Id: <20200724050553.1724168-7-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com>
References: <20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove CONFIG_MODULES dependency by flagging out the dependent code. This
allows to use kprobes in a kernel without support for loadable modules,
which is an useful feature for test kernels and embedded kernels.

Cc: linux-mm@kvack.org
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 arch/Kconfig                |  2 +-
 include/linux/module.h      | 14 +++++------
 kernel/kprobes.c            | 48 +++++++++++++++++++++++--------------
 kernel/trace/trace_kprobe.c | 16 +++++++++++--
 4 files changed, 52 insertions(+), 28 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8cc35dc556c7..e3d6b6868ccb 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -61,7 +61,7 @@ config OPROFILE_NMI_TIMER
 
 config KPROBES
 	bool "Kprobes"
-	depends on MODULES
+	depends on MODULES || ARCH_HAS_TEXT_ALLOC
 	depends on HAVE_KPROBES
 	select KALLSYMS
 	help
diff --git a/include/linux/module.h b/include/linux/module.h
index 8850b9692b8f..22c646cff6bd 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -290,6 +290,13 @@ extern typeof(name) __mod_##type##__##name##_device_table		\
 
 struct notifier_block;
 
+enum module_state {
+	MODULE_STATE_LIVE,	/* Normal state. */
+	MODULE_STATE_COMING,	/* Full formed, running module_init. */
+	MODULE_STATE_GOING,	/* Going away. */
+	MODULE_STATE_UNFORMED,	/* Still setting it up. */
+};
+
 #ifdef CONFIG_MODULES
 
 extern int modules_disabled; /* for sysctl */
@@ -305,13 +312,6 @@ struct module_use {
 	struct module *source, *target;
 };
 
-enum module_state {
-	MODULE_STATE_LIVE,	/* Normal state. */
-	MODULE_STATE_COMING,	/* Full formed, running module_init. */
-	MODULE_STATE_GOING,	/* Going away. */
-	MODULE_STATE_UNFORMED,	/* Still setting it up. */
-};
-
 struct mod_tree_node {
 	struct module *mod;
 	struct latch_tree_node node;
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 611fcda9f6bf..bb2e3070481a 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1617,6 +1617,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 			goto out;
 		}
 
+#ifdef CONFIG_MODULES
 		/*
 		 * If the module freed .init.text, we couldn't insert
 		 * kprobes in there.
@@ -1627,6 +1628,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 			*probed_mod = NULL;
 			ret = -ENOENT;
 		}
+#endif
 	}
 out:
 	preempt_enable();
@@ -2223,24 +2225,6 @@ int kprobe_add_area_blacklist(unsigned long start, unsigned long end)
 	return 0;
 }
 
-/* Remove all symbols in given area from kprobe blacklist */
-static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
-{
-	struct kprobe_blacklist_entry *ent, *n;
-
-	list_for_each_entry_safe(ent, n, &kprobe_blacklist, list) {
-		if (ent->start_addr < start || ent->start_addr >= end)
-			continue;
-		list_del(&ent->list);
-		kfree(ent);
-	}
-}
-
-static void kprobe_remove_ksym_blacklist(unsigned long entry)
-{
-	kprobe_remove_area_blacklist(entry, entry + 1);
-}
-
 int __init __weak arch_populate_kprobe_blacklist(void)
 {
 	return 0;
@@ -2283,6 +2267,25 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
 	return ret ? : arch_populate_kprobe_blacklist();
 }
 
+#ifdef CONFIG_MODULES
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
+static void kprobe_remove_ksym_blacklist(unsigned long entry)
+{
+	kprobe_remove_area_blacklist(entry, entry + 1);
+}
+
 static void add_module_kprobe_blacklist(struct module *mod)
 {
 	unsigned long start, end;
@@ -2328,6 +2331,15 @@ static void remove_module_kprobe_blacklist(struct module *mod)
 		kprobe_remove_area_blacklist(start, end);
 	}
 }
+#else
+static void add_module_kprobe_blacklist(struct module *mod)
+{
+}
+
+static void remove_module_kprobe_blacklist(struct module *mod)
+{
+}
+#endif /* CONFIG_MODULES */
 
 /* Module notifier call back, checking kprobes on the module */
 static int kprobes_module_callback(struct notifier_block *nb,
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 710ec6a6aa8f..881c998d0162 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -103,8 +103,9 @@ static nokprobe_inline bool trace_kprobe_has_gone(struct trace_kprobe *tk)
 	return !!(kprobe_gone(&tk->rp.kp));
 }
 
+#ifdef CONFIG_MODULES
 static nokprobe_inline bool trace_kprobe_within_module(struct trace_kprobe *tk,
-						 struct module *mod)
+						       struct module *mod)
 {
 	int len = strlen(mod->name);
 	const char *name = trace_kprobe_symbol(tk);
@@ -129,6 +130,17 @@ static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
 
 	return ret;
 }
+#else
+static nokprobe_inline bool trace_kprobe_within_module(struct trace_kprobe *tk,
+						       struct module *mod)
+{
+	return false;
+}
+static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
+{
+	return false;
+}
+#endif
 
 static bool trace_kprobe_is_busy(struct dyn_event *ev)
 {
@@ -688,7 +700,7 @@ static int trace_kprobe_module_callback(struct notifier_block *nb,
 			if (ret)
 				pr_warn("Failed to re-register probe %s on %s: %d\n",
 					trace_probe_name(&tk->tp),
-					mod->name, ret);
+					module_name(mod), ret);
 		}
 	}
 	mutex_unlock(&event_mutex);
-- 
2.25.1

