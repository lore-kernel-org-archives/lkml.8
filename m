Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79180C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C55246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgB1Nww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:52:52 -0500
Received: from mga14.intel.com ([192.55.52.115]:23007 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726378AbgB1Nwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:52:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 05:52:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,496,1574150400"; 
   d="scan'208";a="242383283"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.167])
  by orsmga006.jf.intel.com with ESMTP; 28 Feb 2020 05:52:47 -0800
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
Subject: [PATCH V3 08/13] ftrace: Add perf text poke events for ftrace trampolines
Date:   Fri, 28 Feb 2020 15:51:20 +0200
Message-Id: <20200228135125.567-9-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200228135125.567-1-adrian.hunter@intel.com>
References: <20200228135125.567-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add perf text poke events for ftrace trampolines when created and when
freed.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/x86/kernel/ftrace.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 34e1dd495ce4..cec2ffae9e60 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -410,6 +410,8 @@ static void create_trampoline(struct ftrace_ops *ops)
 	ftrace_add_trampoline_to_kallsyms(ops);
 	perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_OOL, (u64)trampoline,
 			   tramp_size, false, FTRACE_TRAMPOLINE_SYM);
+	/* Record the perf text poke event after the ksymbol register event */
+	perf_event_text_poke(trampoline, NULL, 0, trampoline, tramp_size);
 
 	set_vm_flush_reset_perms(trampoline);
 
@@ -537,6 +539,9 @@ void arch_ftrace_trampoline_free(struct ftrace_ops *ops)
 	if (!ops || !(ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP))
 		return;
 
+	/* Record the text poke event before the ksymbol unregister event */
+	perf_event_text_poke((void *)ops->trampoline, (void *)ops->trampoline,
+			     ops->trampoline_size, NULL, 0);
 	perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_OOL, (u64)ops->trampoline,
 			   ops->trampoline_size, true, FTRACE_TRAMPOLINE_SYM);
 	/* Remove from kallsyms after the perf events */
-- 
2.17.1

