Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62226C33C99
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 06:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4065720721
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 06:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgAJGD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 01:03:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56667 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgAJGD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 01:03:57 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipnOZ-00064L-E6; Fri, 10 Jan 2020 07:03:43 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B24901C2D4F;
        Fri, 10 Jan 2020 07:03:42 +0100 (CET)
Date:   Fri, 10 Jan 2020 06:03:42 -0000
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/kprobes] kprobes: Fix
 optimize_kprobe()/unoptimize_kprobe() cancellation logic
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, bristot@redhat.com,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <157840814418.7181.13478003006386303481.stgit@devnote2>
References: <157840814418.7181.13478003006386303481.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <157863622256.30329.5004888454070050302.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/kprobes branch of tip:

Commit-ID:     e4add247789e4ba5e08ad8256183ce2e211877d4
Gitweb:        https://git.kernel.org/tip/e4add247789e4ba5e08ad8256183ce2e211877d4
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Tue, 07 Jan 2020 23:42:24 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 09 Jan 2020 12:40:13 +01:00

kprobes: Fix optimize_kprobe()/unoptimize_kprobe() cancellation logic

optimize_kprobe() and unoptimize_kprobe() cancels if a given kprobe
is on the optimizing_list or unoptimizing_list already. However, since
the following commit:

  f66c0447cca1 ("kprobes: Set unoptimized flag after unoptimizing code")

modified the update timing of the KPROBE_FLAG_OPTIMIZED, it doesn't
work as expected anymore.

The optimized_kprobe could be in the following states:

- [optimizing]: Before inserting jump instruction
  op.kp->flags has KPROBE_FLAG_OPTIMIZED and
  op->list is not empty.

- [optimized]: jump inserted
  op.kp->flags has KPROBE_FLAG_OPTIMIZED and
  op->list is empty.

- [unoptimizing]: Before removing jump instruction (including unused
  optprobe)
  op.kp->flags has KPROBE_FLAG_OPTIMIZED and
  op->list is not empty.

- [unoptimized]: jump removed
  op.kp->flags doesn't have KPROBE_FLAG_OPTIMIZED and
  op->list is empty.

Current code mis-expects [unoptimizing] state doesn't have
KPROBE_FLAG_OPTIMIZED, and that can cause incorrect results.

To fix this, introduce optprobe_queued_unopt() to distinguish [optimizing]
and [unoptimizing] states and fixes the logic in optimize_kprobe() and
unoptimize_kprobe().

[ mingo: Cleaned up the changelog and the code a bit. ]

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bristot@redhat.com
Fixes: f66c0447cca1 ("kprobes: Set unoptimized flag after unoptimizing code")
Link: https://lkml.kernel.org/r/157840814418.7181.13478003006386303481.stgit@devnote2
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/kprobes.c | 67 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 24 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 34e28b2..2625c24 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -612,6 +612,18 @@ void wait_for_kprobe_optimizer(void)
 	mutex_unlock(&kprobe_mutex);
 }
 
+static bool optprobe_queued_unopt(struct optimized_kprobe *op)
+{
+	struct optimized_kprobe *_op;
+
+	list_for_each_entry(_op, &unoptimizing_list, list) {
+		if (op == _op)
+			return true;
+	}
+
+	return false;
+}
+
 /* Optimize kprobe if p is ready to be optimized */
 static void optimize_kprobe(struct kprobe *p)
 {
@@ -633,17 +645,21 @@ static void optimize_kprobe(struct kprobe *p)
 		return;
 
 	/* Check if it is already optimized. */
-	if (op->kp.flags & KPROBE_FLAG_OPTIMIZED)
+	if (op->kp.flags & KPROBE_FLAG_OPTIMIZED) {
+		if (optprobe_queued_unopt(op)) {
+			/* This is under unoptimizing. Just dequeue the probe */
+			list_del_init(&op->list);
+		}
 		return;
+	}
 	op->kp.flags |= KPROBE_FLAG_OPTIMIZED;
 
-	if (!list_empty(&op->list))
-		/* This is under unoptimizing. Just dequeue the probe */
-		list_del_init(&op->list);
-	else {
-		list_add(&op->list, &optimizing_list);
-		kick_kprobe_optimizer();
-	}
+	/* On unoptimizing/optimizing_list, op must have OPTIMIZED flag */
+	if (WARN_ON_ONCE(!list_empty(&op->list)))
+		return;
+
+	list_add(&op->list, &optimizing_list);
+	kick_kprobe_optimizer();
 }
 
 /* Short cut to direct unoptimizing */
@@ -665,30 +681,33 @@ static void unoptimize_kprobe(struct kprobe *p, bool force)
 		return; /* This is not an optprobe nor optimized */
 
 	op = container_of(p, struct optimized_kprobe, kp);
-	if (!kprobe_optimized(p)) {
-		/* Unoptimized or unoptimizing case */
-		if (force && !list_empty(&op->list)) {
-			/*
-			 * Only if this is unoptimizing kprobe and forced,
-			 * forcibly unoptimize it. (No need to unoptimize
-			 * unoptimized kprobe again :)
-			 */
-			list_del_init(&op->list);
-			force_unoptimize_kprobe(op);
-		}
+	if (!kprobe_optimized(p))
 		return;
-	}
 
 	if (!list_empty(&op->list)) {
-		/* Dequeue from the optimization queue */
-		list_del_init(&op->list);
+		if (optprobe_queued_unopt(op)) {
+			/* Queued in unoptimizing queue */
+			if (force) {
+				/*
+				 * Forcibly unoptimize the kprobe here, and queue it
+				 * in the freeing list for release afterwards.
+				 */
+				force_unoptimize_kprobe(op);
+				list_move(&op->list, &freeing_list);
+			}
+		} else {
+			/* Dequeue from the optimizing queue */
+			list_del_init(&op->list);
+			op->kp.flags &= ~KPROBE_FLAG_OPTIMIZED;
+		}
 		return;
 	}
+
 	/* Optimized kprobe case */
-	if (force)
+	if (force) {
 		/* Forcibly update the code: this is a special case */
 		force_unoptimize_kprobe(op);
-	else {
+	} else {
 		list_add(&op->list, &unoptimizing_list);
 		kick_kprobe_optimizer();
 	}
