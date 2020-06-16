Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592B7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37EF520C56
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbgFPMY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728518AbgFPMVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:21:54 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEC6C08C5C5;
        Tue, 16 Jun 2020 05:21:54 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlAb6-0004cI-T2; Tue, 16 Jun 2020 14:21:49 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 041B51C0095;
        Tue, 16 Jun 2020 14:21:48 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:21:47 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] ftrace: Add perf ksymbol events for ftrace trampolines
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200512121922.8997-8-adrian.hunter@intel.com>
References: <20200512121922.8997-8-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <159231010776.16989.18364549093455814587.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     dd9ddf466ad7a5d2e247925d81ebb0b878bf3b76
Gitweb:        https://git.kernel.org/tip/dd9ddf466ad7a5d2e247925d81ebb0b878bf3b76
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Tue, 12 May 2020 15:19:14 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:09:49 +02:00

ftrace: Add perf ksymbol events for ftrace trampolines

Symbols are needed for tools to describe instruction addresses. Pages
allocated for ftrace's purposes need symbols to be created for them.
Add such symbols to be visible via perf ksymbol events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200512121922.8997-8-adrian.hunter@intel.com
---
 include/uapi/linux/perf_event.h |  2 +-
 kernel/trace/ftrace.c           | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index e1a4179..52ca209 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1051,7 +1051,7 @@ enum perf_record_ksymbol_type {
 	PERF_RECORD_KSYMBOL_TYPE_BPF		= 1,
 	/*
 	 * Out of line code such as kprobe-replaced instructions or optimized
-	 * kprobes.
+	 * kprobes or ftrace trampolines.
 	 */
 	PERF_RECORD_KSYMBOL_TYPE_OOL		= 2,
 	PERF_RECORD_KSYMBOL_TYPE_MAX		/* non-ABI */
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 31675b2..2baaf77 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2790,8 +2790,13 @@ static void ftrace_remove_trampoline_from_kallsyms(struct ftrace_ops *ops)
 static void ftrace_trampoline_free(struct ftrace_ops *ops)
 {
 	if (ops && (ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP) &&
-	    ops->trampoline)
+	    ops->trampoline) {
+		perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_OOL,
+				   ops->trampoline, ops->trampoline_size,
+				   true, FTRACE_TRAMPOLINE_SYM);
+		/* Remove from kallsyms after the perf events */
 		ftrace_remove_trampoline_from_kallsyms(ops);
+	}
 
 	arch_ftrace_trampoline_free(ops);
 }
@@ -6805,8 +6810,13 @@ static void ftrace_update_trampoline(struct ftrace_ops *ops)
 
 	arch_ftrace_update_trampoline(ops);
 	if (ops->trampoline && ops->trampoline != trampoline &&
-	    (ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP))
+	    (ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP)) {
+		/* Add to kallsyms before the perf events */
 		ftrace_add_trampoline_to_kallsyms(ops);
+		perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_OOL,
+				   ops->trampoline, ops->trampoline_size, false,
+				   FTRACE_TRAMPOLINE_SYM);
+	}
 }
 
 void ftrace_init_trace_array(struct trace_array *tr)
