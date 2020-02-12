Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D8FC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A2B20714
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgBLMvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 07:51:18 -0500
Received: from mga06.intel.com ([134.134.136.31]:63674 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728168AbgBLMvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 07:51:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 04:51:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="237702531"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.167])
  by orsmga006.jf.intel.com with ESMTP; 12 Feb 2020 04:51:13 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 08/13] ftrace: Add perf text poke events for ftrace trampolines
Date:   Wed, 12 Feb 2020 14:49:44 +0200
Message-Id: <20200212124949.3589-9-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200212124949.3589-1-adrian.hunter@intel.com>
References: <20200212124949.3589-1-adrian.hunter@intel.com>
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

