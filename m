Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF2FC3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206632072D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387802AbgCDJHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 04:07:39 -0500
Received: from mga03.intel.com ([134.134.136.65]:17638 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387398AbgCDJHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 04:07:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 01:07:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,513,1574150400"; 
   d="scan'208";a="413074254"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.167])
  by orsmga005.jf.intel.com with ESMTP; 04 Mar 2020 01:07:32 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V4 04/13] kprobes: Add perf ksymbol events for kprobe insn pages
Date:   Wed,  4 Mar 2020 11:06:24 +0200
Message-Id: <20200304090633.420-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200304090633.420-1-adrian.hunter@intel.com>
References: <20200304090633.420-1-adrian.hunter@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Symbols are needed for tools to describe instruction addresses. Pages
allocated for kprobe's purposes need symbols to be created for them.
Add such symbols to be visible via perf ksymbol events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/uapi/linux/perf_event.h |  5 +++++
 kernel/kprobes.c                | 12 ++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index bae9e9d2d897..9b38ac04c110 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1031,6 +1031,11 @@ enum perf_event_type {
 enum perf_record_ksymbol_type {
 	PERF_RECORD_KSYMBOL_TYPE_UNKNOWN	= 0,
 	PERF_RECORD_KSYMBOL_TYPE_BPF		= 1,
+	/*
+	 * Out of line code such as kprobe-replaced instructions or optimized
+	 * kprobes.
+	 */
+	PERF_RECORD_KSYMBOL_TYPE_OOL		= 2,
 	PERF_RECORD_KSYMBOL_TYPE_MAX		/* non-ABI */
 };
 
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 229d1b596690..f880eb2189c0 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -35,6 +35,7 @@
 #include <linux/ftrace.h>
 #include <linux/cpu.h>
 #include <linux/jump_label.h>
+#include <linux/perf_event.h>
 
 #include <asm/sections.h>
 #include <asm/cacheflush.h>
@@ -184,6 +185,10 @@ kprobe_opcode_t *__get_insn_slot(struct kprobe_insn_cache *c)
 	kip->cache = c;
 	list_add_rcu(&kip->list, &c->pages);
 	slot = kip->insns;
+
+	/* Record the perf ksymbol register event after adding the page */
+	perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_OOL, (u64)kip->insns,
+			   PAGE_SIZE, false, c->sym);
 out:
 	mutex_unlock(&c->mutex);
 	return slot;
@@ -202,6 +207,13 @@ static int collect_one_slot(struct kprobe_insn_page *kip, int idx)
 		 * next time somebody inserts a probe.
 		 */
 		if (!list_is_singular(&kip->list)) {
+			/*
+			 * Record perf ksymbol unregister event before removing
+			 * the page.
+			 */
+			perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_OOL,
+					   (u64)kip->insns, PAGE_SIZE, true,
+					   kip->cache->sym);
 			list_del_rcu(&kip->list);
 			synchronize_rcu();
 			kip->cache->free(kip->insns);
-- 
2.17.1

