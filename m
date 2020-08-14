Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CDAC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 16:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FA5B207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 16:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="cusLa7+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgHNQoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 12:44:15 -0400
Received: from mail.efficios.com ([167.114.26.124]:58854 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgHNQoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 12:44:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id F39612988F0;
        Fri, 14 Aug 2020 12:44:05 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id DvwGpdRrY-ES; Fri, 14 Aug 2020 12:44:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 96CAC298C63;
        Fri, 14 Aug 2020 12:44:05 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 96CAC298C63
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1597423445;
        bh=oM5wTB4JJqdlh0JAEKSv9wpzL7LPTjpfby30ulsdAbc=;
        h=From:To:Date:Message-Id;
        b=cusLa7+K6DKY0rYoNOo6gepM5NoFw4RmQQ8jzE6x3BkPseqa7Od7sRP0MV7Mptfvc
         yuygBAPbbxn9s9vxpdrbrYdtongnmmm2YNqP6DKyYlkzW4sEvww6PxIUpyFe5d+Hq7
         yRJmAgkvgKWcVjhRsncLC7eFrF4hBqRFZLjkS7EItKDXQQ0FWPdRP7JD5+YWHss2j9
         EDqxmQLwN6vEmCIVqlcC3aKfj7eXJAzyMuV7th3N9zorZCtOr8F3djIoNkVNR9qYVH
         4gFDImLXQxOoPktuAq5P8Km62BXjVLmose5OwOG9spwvCxKXGcclqb8GJnLp55mGEY
         S5vbDUthmScqA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 50iriB8CUg77; Fri, 14 Aug 2020 12:44:05 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 657B4298A7F;
        Fri, 14 Aug 2020 12:44:05 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH 3/3] sched: membarrier: document memory ordering scenarios
Date:   Fri, 14 Aug 2020 12:43:58 -0400
Message-Id: <20200814164358.4783-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200814164358.4783-1-mathieu.desnoyers@efficios.com>
References: <20200814164358.4783-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document membarrier ordering scenarios in membarrier.c. Thanks to Alan
Stern for refreshing my memory. Now that I have those in mind, it seems
appropriate to serialize them to comments for posterity.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
---
 kernel/sched/membarrier.c | 128 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 8a294483074d..103f5edb8ba5 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -7,6 +7,134 @@
 #include "sched.h"
 
 /*
+ * For documentation purposes, here are some membarrier ordering
+ * scenarios to keep in mind:
+ *
+ * A) Userspace thread execution after IPI vs membarrier's memory
+ *    barrier before sending the IPI
+ *
+ * Userspace variables:
+ *
+ * int x = 0, y = 0;
+ *
+ * The memory barrier at the start of membarrier() on CPU0 is necessary in
+ * order to enforce the guarantee that any writes occurring on CPU0 before
+ * the membarrier() is executed will be visible to any code executing on
+ * CPU1 after the IPI-induced memory barrier:
+ *
+ *         CPU0                              CPU1
+ *
+ *         x = 1
+ *         membarrier():
+ *           a: smp_mb()
+ *           b: send IPI                       IPI-induced mb
+ *           c: smp_mb()
+ *         r2 = y
+ *                                           y = 1
+ *                                           barrier()
+ *                                           r1 = x
+ *
+ *                     BUG_ON(r1 == 0 && r2 == 0)
+ *
+ * The write to y and load from x by CPU1 are unordered by the hardware,
+ * so it's possible to have "r1 = x" reordered before "y = 1" at any
+ * point after (b).  If the memory barrier at (a) is omitted, then "x = 1"
+ * can be reordered after (a) (although not after (c)), so we get r1 == 0
+ * and r2 == 0.  This violates the guarantee that membarrier() is
+ * supposed by provide.
+ *
+ * The timing of the memory barrier at (a) has to ensure that it executes
+ * before the IPI-induced memory barrier on CPU1.
+ *
+ * B) Userspace thread execution before IPI vs membarrier's memory
+ *    barrier after completing the IPI
+ *
+ * Userspace variables:
+ *
+ * int x = 0, y = 0;
+ *
+ * The memory barrier at the end of membarrier() on CPU0 is necessary in
+ * order to enforce the guarantee that any writes occurring on CPU1 before
+ * the membarrier() is executed will be visible to any code executing on
+ * CPU0 after the membarrier():
+ *
+ *         CPU0                              CPU1
+ *
+ *                                           x = 1
+ *                                           barrier()
+ *                                           y = 1
+ *         r2 = y
+ *         membarrier():
+ *           a: smp_mb()
+ *           b: send IPI                       IPI-induced mb
+ *           c: smp_mb()
+ *         r1 = x
+ *         BUG_ON(r1 == 0 && r2 == 1)
+ *
+ * The writes to x and y are unordered by the hardware, so it's possible to
+ * have "r2 = 1" even though the write to x doesn't execute until (b).  If
+ * the memory barrier at (c) is omitted then "r1 = x" can be reordered
+ * before (b) (although not before (a)), so we get "r1 = 0".  This violates
+ * the guarantee that membarrier() is supposed to provide.
+ *
+ * The timing of the memory barrier at (c) has to ensure that it executes
+ * after the IPI-induced memory barrier on CPU1.
+ *
+ * C) Scheduling userspace thread -> kthread -> userspace thread vs membarrier
+ *
+ *           CPU0                            CPU1
+ *
+ *           membarrier():
+ *           a: smp_mb()
+ *                                           d: switch to kthread (includes mb)
+ *           b: read rq->curr->mm == NULL
+ *                                           e: switch to user (includes mb)
+ *           c: smp_mb()
+ *
+ * Using the scenario from (A), we can show that (a) needs to be paired
+ * with (e). Using the scenario from (B), we can show that (c) needs to
+ * be paired with (d).
+ *
+ * D) exit_mm vs membarrier
+ *
+ * Two thread groups are created, A and B.  Thread group B is created by
+ * issuing clone from group A with flag CLONE_VM set, but not CLONE_THREAD.
+ * Let's assume we have a single thread within each thread group (Thread A
+ * and Thread B).  Thread A runs on CPU0, Thread B runs on CPU1.
+ *
+ *           CPU0                            CPU1
+ *
+ *           membarrier():
+ *             a: smp_mb()
+ *                                           exit_mm():
+ *                                             d: smp_mb()
+ *                                             e: current->mm = NULL
+ *             b: read rq->curr->mm == NULL
+ *             c: smp_mb()
+ *
+ * Using scenario (B), we can show that (c) needs to be paired with (d).
+ *
+ * E) kthread_{use,unuse}_mm vs membarrier
+ *
+ *           CPU0                            CPU1
+ *
+ *           membarrier():
+ *           a: smp_mb()
+ *                                           kthread_unuse_mm()
+ *                                             d: smp_mb()
+ *                                             e: current->mm = NULL
+ *           b: read rq->curr->mm == NULL
+ *                                           kthread_use_mm()
+ *                                             f: current->mm = mm
+ *                                             g: smp_mb()
+ *           c: smp_mb()
+ *
+ * Using the scenario from (A), we can show that (a) needs to be paired
+ * with (g). Using the scenario from (B), we can show that (c) needs to
+ * be paired with (d).
+ */
+
+/*
  * Bitmask made from a "or" of all commands within enum membarrier_cmd,
  * except MEMBARRIER_CMD_QUERY.
  */
-- 
2.11.0

