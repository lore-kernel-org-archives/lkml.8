Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0C9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93B9D20FC3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbgFPMY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbgFPMVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:21:54 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920DCC08C5C3;
        Tue, 16 Jun 2020 05:21:54 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlAb6-0004bd-1S; Tue, 16 Jun 2020 14:21:48 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A34081C0475;
        Tue, 16 Jun 2020 14:21:47 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:21:47 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] ftrace: Add perf text poke events for ftrace trampolines
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200512121922.8997-9-adrian.hunter@intel.com>
References: <20200512121922.8997-9-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <159231010740.16989.5134348688413119974.tip-bot2@tip-bot2>
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

Commit-ID:     548e1f6c76e1eb80ba29edd4286b9b9f2c37f5bf
Gitweb:        https://git.kernel.org/tip/548e1f6c76e1eb80ba29edd4286b9b9f2c37f5bf
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Tue, 12 May 2020 15:19:15 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:09:50 +02:00

ftrace: Add perf text poke events for ftrace trampolines

Add perf text poke events for ftrace trampolines when created and when
freed.

There can be 3 text_poke events for ftrace trampolines:

1. NULL -> trampoline
   By ftrace_update_trampoline() when !ops->trampoline
   Trampoline created

2. [e.g. on x86] CALL rel32 -> CALL rel32
   By arch_ftrace_update_trampoline() when ops->trampoline and
                        ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP
   [e.g. on x86] via text_poke_bp() which generates text poke events
   Trampoline-called function target updated

3. trampoline -> NULL
   By ftrace_trampoline_free() when ops->trampoline and
                 ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP
   Trampoline freed

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200512121922.8997-9-adrian.hunter@intel.com
---
 kernel/trace/ftrace.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 2baaf77..d6bba73 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2791,6 +2791,13 @@ static void ftrace_trampoline_free(struct ftrace_ops *ops)
 {
 	if (ops && (ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP) &&
 	    ops->trampoline) {
+		/*
+		 * Record the text poke event before the ksymbol unregister
+		 * event.
+		 */
+		perf_event_text_poke((void *)ops->trampoline,
+				     (void *)ops->trampoline,
+				     ops->trampoline_size, NULL, 0);
 		perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_OOL,
 				   ops->trampoline, ops->trampoline_size,
 				   true, FTRACE_TRAMPOLINE_SYM);
@@ -6816,6 +6823,13 @@ static void ftrace_update_trampoline(struct ftrace_ops *ops)
 		perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_OOL,
 				   ops->trampoline, ops->trampoline_size, false,
 				   FTRACE_TRAMPOLINE_SYM);
+		/*
+		 * Record the perf text poke event after the ksymbol register
+		 * event.
+		 */
+		perf_event_text_poke((void *)ops->trampoline, NULL, 0,
+				     (void *)ops->trampoline,
+				     ops->trampoline_size);
 	}
 }
 
