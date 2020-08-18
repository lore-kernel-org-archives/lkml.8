Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95037C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 05:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 554A720738
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 05:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgHRFJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 01:09:11 -0400
Received: from mga01.intel.com ([192.55.52.88]:3654 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgHRFJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 01:09:09 -0400
IronPort-SDR: FTqrzF8TunJyv02OCkuRuBAjvhtklurs+5LzCO9BdvjhiLJUuIfQJVl/oZrW2U0w8VWIDw9AT0
 K+TT+dIw9iPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="172891204"
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="172891204"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 22:09:09 -0700
IronPort-SDR: ziaGWUr8V2D2f+nbYi83m8NhaLhf+LOFOtV1ZlsiIHVxSSqIOiBLxguavrTz/eGQ3Oc8FxO1Hh
 yBXL5N74MYFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="292652501"
Received: from lcrossx-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.46.217])
  by orsmga003.jf.intel.com with ESMTP; 17 Aug 2020 22:09:05 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-mm@kvack.org, Andi Kleen <ak@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH] kprobes: Use module_name() macro
Date:   Tue, 18 Aug 2020 08:08:57 +0300
Message-Id: <20200818050857.117998-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is advised to use module_name() macro instead of dereferencing mod->name
directly. This makes sense for consistencys sake and also it prevents a
hard dependency to CONFIG_MODULES.

Cc: linux-mm@kvack.org
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
I thought that to get things moving it would make sense to fix this low
hanging fruit issue first. Similarly as Masami's fix kernel/kprobes.c
this will make my patch set less rambling, and thus easier to follow.
 kernel/trace/trace_kprobe.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index aefb6065b508..19c00ee90945 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -106,9 +106,10 @@ static nokprobe_inline bool trace_kprobe_has_gone(struct trace_kprobe *tk)
 static nokprobe_inline bool trace_kprobe_within_module(struct trace_kprobe *tk,
 						 struct module *mod)
 {
-	int len = strlen(mod->name);
+	int len = strlen(module_name(mod));
 	const char *name = trace_kprobe_symbol(tk);
-	return strncmp(mod->name, name, len) == 0 && name[len] == ':';
+
+	return strncmp(module_name(mod), name, len) == 0 && name[len] == ':';
 }
 
 static nokprobe_inline bool trace_kprobe_module_exist(struct trace_kprobe *tk)
@@ -688,7 +689,7 @@ static int trace_kprobe_module_callback(struct notifier_block *nb,
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

