Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B19C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 05:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81748206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 05:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgGXFFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 01:05:16 -0400
Received: from mga03.intel.com ([134.134.136.65]:41004 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbgGXFFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 01:05:15 -0400
IronPort-SDR: fuL2kEU5QDtl2+ABNmkG3mAf2T7JEIycJu3iYDGJld1YjngTvJ4ueAnzfCUTZoV6/bqCOTNnma
 x+gCdIpwJPoA==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="150645706"
X-IronPort-AV: E=Sophos;i="5.75,389,1589266800"; 
   d="scan'208";a="150645706"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 22:05:14 -0700
IronPort-SDR: fwZRTobzmQpzUlmLRedOJhXoZ3qvV74pep3Scq0sn0GbOgaln93ZjCNH0qOHrEwoohaB+8b+c2
 pWXkRhH72SYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,389,1589266800"; 
   d="scan'208";a="302553089"
Received: from itopinsk-mobl1.ccr.corp.intel.com (HELO localhost) ([10.249.36.179])
  by orsmga002.jf.intel.com with ESMTP; 23 Jul 2020 22:05:08 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-mm@kvack.org, Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v5 1/6] kprobes: Remove dependency to the module_mutex
Date:   Fri, 24 Jul 2020 08:04:55 +0300
Message-Id: <20200724050501.1723315-2-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724050501.1723315-1-jarkko.sakkinen@linux.intel.com>
References: <20200724050501.1723315-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add lock_modules() and unlock_modules() wrappers for acquiring module_mutex
in order to remove the compile time dependency to it.

Cc: linux-mm@kvack.org
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 include/linux/module.h      | 18 ++++++++++++++++++
 kernel/kprobes.c            |  4 ++--
 kernel/trace/trace_kprobe.c |  4 ++--
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 2e6670860d27..8850b9692b8f 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -705,6 +705,16 @@ static inline bool is_livepatch_module(struct module *mod)
 bool is_module_sig_enforced(void);
 void set_module_sig_enforced(void);
 
+static inline void lock_modules(void)
+{
+	mutex_lock(&module_mutex);
+}
+
+static inline void unlock_modules(void)
+{
+	mutex_unlock(&module_mutex);
+}
+
 #else /* !CONFIG_MODULES... */
 
 static inline struct module *__module_address(unsigned long addr)
@@ -852,6 +862,14 @@ void *dereference_module_function_descriptor(struct module *mod, void *ptr)
 	return ptr;
 }
 
+static inline void lock_modules(void)
+{
+}
+
+static inline void unlock_modules(void)
+{
+}
+
 #endif /* CONFIG_MODULES */
 
 #ifdef CONFIG_SYSFS
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 2e97febeef77..4e46d96d4e16 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -564,7 +564,7 @@ static void kprobe_optimizer(struct work_struct *work)
 	cpus_read_lock();
 	mutex_lock(&text_mutex);
 	/* Lock modules while optimizing kprobes */
-	mutex_lock(&module_mutex);
+	lock_modules();
 
 	/*
 	 * Step 1: Unoptimize kprobes and collect cleaned (unused and disarmed)
@@ -589,7 +589,7 @@ static void kprobe_optimizer(struct work_struct *work)
 	/* Step 4: Free cleaned kprobes after quiesence period */
 	do_free_cleaned_kprobes();
 
-	mutex_unlock(&module_mutex);
+	unlock_modules();
 	mutex_unlock(&text_mutex);
 	cpus_read_unlock();
 
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index aefb6065b508..710ec6a6aa8f 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -122,9 +122,9 @@ static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
 	if (!p)
 		return true;
 	*p = '\0';
-	mutex_lock(&module_mutex);
+	lock_modules();
 	ret = !!find_module(tk->symbol);
-	mutex_unlock(&module_mutex);
+	unlock_modules();
 	*p = ':';
 
 	return ret;
-- 
2.25.1

