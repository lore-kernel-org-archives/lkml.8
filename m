Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA830C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 16:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7B4D20829
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 16:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="R1hiTHwf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgHNQoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 12:44:07 -0400
Received: from mail.efficios.com ([167.114.26.124]:58810 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgHNQoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 12:44:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 69835298CCF;
        Fri, 14 Aug 2020 12:44:05 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id m8xIlR6s5KER; Fri, 14 Aug 2020 12:44:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 2BA7D298F08;
        Fri, 14 Aug 2020 12:44:05 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2BA7D298F08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1597423445;
        bh=gWMfYz3pTPNPAFbvbx6cVT/WalgvXWmMXDyplE97vOU=;
        h=From:To:Date:Message-Id;
        b=R1hiTHwfeuCsuFYTexf4jJWTC+bhRFma3Qsx1ilOigYhmOOklty9mBnqtOq1c8H5T
         iuRUc4aEU1bFCB4sNuHzwpKyuQEXUyTjiQHE4Psmukka0rQ7kcf3+kJ2AI5LPMOoRL
         Hd0DVRB68ErLtai2I818A5SkWLB5qmB0T3Xu4TaTplTHlywhmWKy2oCvCiKfLJ58Jm
         KbX5O/FVToG8HbP0KVBxf4mZWei1fOcd7KuFLzj4tWw1+PrzYiZ30qFy1QJV1RcdSR
         BwbdTWMBlpgnqJFHg+6fcmEN2dcUrmVKk/2Hg3D/7PZvaXnM5oY47e3uB9yvsVslcP
         yIv2KbKvQP5ug==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cLUW4hHJ8BLb; Fri, 14 Aug 2020 12:44:05 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id E2935298E3B;
        Fri, 14 Aug 2020 12:44:04 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org
Subject: [RFC PATCH 1/3] sched: fix exit_mm vs membarrier (v2)
Date:   Fri, 14 Aug 2020 12:43:56 -0400
Message-Id: <20200814164358.4783-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200814164358.4783-1-mathieu.desnoyers@efficios.com>
References: <20200814164358.4783-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

exit_mm should issue memory barriers after user-space memory accesses,
before clearing current->mm, to order user-space memory accesses
performed prior to exit_mm before clearing tsk->mm, which has the
effect of skipping the membarrier private expedited IPIs.

The membarrier system call can be issued concurrently with do_exit
if we have thread groups created with CLONE_VM but not CLONE_THREAD.

Here is the scenario I have in mind:

Two thread groups are created, A and B. Thread group B is created by
issuing clone from group A with flag CLONE_VM set, but not CLONE_THREAD.
Let's assume we have a single thread within each thread group (Thread A
and Thread B).

The AFAIU we can have:

Userspace variables:

int x = 0, y = 0;

CPU 0                   CPU 1
Thread A                Thread B
(in thread group A)     (in thread group B)

x = 1
barrier()
y = 1
exit()
exit_mm()
current->mm = NULL;
                        r1 = load y
                        membarrier()
                          skips CPU 0 (no IPI) because its current mm is NULL
                        r2 = load x
                        BUG_ON(r1 == 1 && r2 == 0)

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-mm@kvack.org
---
Changes since v1:
- Use smp_mb__after_spinlock rather than smp_mb.
- Document race scenario in commit message.
---
 kernel/exit.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/exit.c b/kernel/exit.c
index 733e80f334e7..fe64e6e28dd5 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -475,6 +475,14 @@ static void exit_mm(void)
 	BUG_ON(mm != current->active_mm);
 	/* more a memory barrier than a real lock */
 	task_lock(current);
+	/*
+	 * When a thread stops operating on an address space, the loop
+	 * in membarrier_{private,global}_expedited() may not observe
+	 * that tsk->mm, and not issue an IPI. Membarrier requires a
+	 * memory barrier after accessing user-space memory, before
+	 * clearing tsk->mm.
+	 */
+	smp_mb__after_spinlock();
 	current->mm = NULL;
 	mmap_read_unlock(mm);
 	enter_lazy_tlb(mm, current);
-- 
2.11.0

