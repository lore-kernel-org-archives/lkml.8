Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18217C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 18:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC77420849
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 18:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbgGMSVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 14:21:48 -0400
Received: from mga07.intel.com ([134.134.136.100]:34624 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbgGMSVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 14:21:47 -0400
IronPort-SDR: 4zl5akwv0CHx6HkbCYN0s6gB8AE4tacjbeAizwFGqMInHrCF21Jg+Q377EGbXT8vpwUxIjZL7i
 TQMvPYo8xsyg==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="213520108"
X-IronPort-AV: E=Sophos;i="5.75,348,1589266800"; 
   d="scan'208";a="213520108"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2020 11:21:47 -0700
IronPort-SDR: i3gjZw8MEb6BcvEbigSe/N+i1JQpXzB3wXV7nLMnpOOsBwaGwNK2dfb3tjoxabDfDwSgfUC2dc
 8cMDxgslYZoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,348,1589266800"; 
   d="scan'208";a="299283619"
Received: from bcope-mobl.ger.corp.intel.com (HELO localhost) ([10.249.32.223])
  by orsmga002.jf.intel.com with ESMTP; 13 Jul 2020 11:21:37 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jessica Yu <jeyu@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 3/3] kprobes: Flag out CONFIG_MODULES dependent code
Date:   Mon, 13 Jul 2020 21:19:39 +0300
Message-Id: <20200713182030.1418041-3-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713182030.1418041-1-jarkko.sakkinen@linux.intel.com>
References: <20200713182030.1418041-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove CONFIG_MODULES dependency by flagging out the dependent code. This
allows to use kprobes in a kernel without support for loadable modules,
which could be useful for a test kernel or perhaps an embedded kernel.

Cc: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 arch/Kconfig                |  1 -
 include/linux/module.h      | 14 +++++++-------
 kernel/kprobes.c            |  9 +++++++++
 kernel/trace/trace_kprobe.c | 16 +++++++++++++++-
 4 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8cc35dc556c7..bb59cdf335ab 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -61,7 +61,6 @@ config OPROFILE_NMI_TIMER
 
 config KPROBES
 	bool "Kprobes"
-	depends on MODULES
 	depends on HAVE_KPROBES
 	select KALLSYMS
 	help
diff --git a/include/linux/module.h b/include/linux/module.h
index 857b84bf9e90..eaa8ad02f75c 100644
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
index bbe3423cb2b8..047353008cb6 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1608,6 +1608,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 			goto out;
 		}
 
+#ifdef CONFIG_MODULES
 		/*
 		 * If the module freed .init.text, we couldn't insert
 		 * kprobes in there.
@@ -1618,6 +1619,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 			*probed_mod = NULL;
 			ret = -ENOENT;
 		}
+#endif
 	}
 out:
 	preempt_enable();
@@ -2214,6 +2216,7 @@ int kprobe_add_area_blacklist(unsigned long start, unsigned long end)
 	return 0;
 }
 
+#ifdef CONFIG_MODULES
 /* Remove all symbols in given area from kprobe blacklist */
 static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
 {
@@ -2231,6 +2234,7 @@ static void kprobe_remove_ksym_blacklist(unsigned long entry)
 {
 	kprobe_remove_area_blacklist(entry, entry + 1);
 }
+#endif
 
 int __init __weak arch_populate_kprobe_blacklist(void)
 {
@@ -2274,6 +2278,7 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
 	return ret ? : arch_populate_kprobe_blacklist();
 }
 
+#ifdef CONFIG_MODULES
 static void add_module_kprobe_blacklist(struct module *mod)
 {
 	unsigned long start, end;
@@ -2319,6 +2324,10 @@ static void remove_module_kprobe_blacklist(struct module *mod)
 		kprobe_remove_area_blacklist(start, end);
 	}
 }
+#else
+static void add_module_kprobe_blacklist(struct module *mod) {}
+static void remove_module_kprobe_blacklist(struct module *mod) {}
+#endif /* CONFIG_MODULES */
 
 /* Module notifier call back, checking kprobes on the module */
 static int kprobes_module_callback(struct notifier_block *nb,
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 710ec6a6aa8f..7fcd1bf2d96e 100644
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
@@ -685,10 +697,12 @@ static int trace_kprobe_module_callback(struct notifier_block *nb,
 			/* Don't need to check busy - this should have gone. */
 			__unregister_trace_kprobe(tk);
 			ret = __register_trace_kprobe(tk);
+#ifdef CONFIG_MODULES
 			if (ret)
 				pr_warn("Failed to re-register probe %s on %s: %d\n",
 					trace_probe_name(&tk->tp),
 					mod->name, ret);
+#endif
 		}
 	}
 	mutex_unlock(&event_mutex);
-- 
2.25.1

