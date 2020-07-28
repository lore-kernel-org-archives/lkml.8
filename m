Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C724C433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D91C2207F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="C1MPTM42"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbgG1QAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:00:16 -0400
Received: from mail.efficios.com ([167.114.26.124]:44346 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730963AbgG1QAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:00:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id BC8B129A885;
        Tue, 28 Jul 2020 12:00:14 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id obXD5Ex2Fd8J; Tue, 28 Jul 2020 12:00:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 68EF029A729;
        Tue, 28 Jul 2020 12:00:14 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 68EF029A729
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1595952014;
        bh=EsIILeHJT4NfTbu7fm/u4BIXkEOajS4ZSBPxyFmkiW0=;
        h=From:To:Date:Message-Id;
        b=C1MPTM42Z8g6VHgVCF52mmaOC722/ltqP/9Td0PZxGWmxIBqwzPf5rhpWwK+ovU8S
         RNYUsiIAExsUtnDuRD2kexQx2gsoSdjCoJeGf5+22xrz6IK122fJjhRMKyg26jMIIl
         +BdBndIZpuZVNE27j6+l9TuZ9F8Wdw2Lw7W5p1bQCLjfFtudEPoQ5DJVFKDM1P+Un+
         sGSD1Kdfq1tc1MQBmDFETevVpK/EcDh/0EEaViQvOR13mONOw8Wb9MJvuqxkRS6f/J
         XawgQ6ejD8LLdi2YQ/rgA/zy49gonxTgYtch690QCl3J3FZ9LaJUxQtTTaVq+ck7vA
         LidJ6g/fIp3Qg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nWA6AhyGx8a1; Tue, 28 Jul 2020 12:00:14 -0400 (EDT)
Received: from thinkos.etherlink (unknown [192.222.236.144])
        by mail.efficios.com (Postfix) with ESMTPSA id 2F97229A724;
        Tue, 28 Jul 2020 12:00:14 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>, linux-mm@kvack.org
Subject: [RFC PATCH 1/2] sched: Fix exit_mm vs membarrier
Date:   Tue, 28 Jul 2020 12:00:09 -0400
Message-Id: <20200728160010.3314-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
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

The following comment in exit_mm() seems rather puzzling though:

        /* more a memory barrier than a real lock */
        task_lock(current);

So considering that spinlocks are not full memory barriers nowadays,
some digging into the origins of this comment led me to 2002, at the
earliest commit tracked by Thomas Gleixner's bitkeeper era's history
at https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/

At that point, this comment was followed by:

+               /* more a memory barrier than a real lock */
+               task_lock(tsk);
+               tsk->mm = NULL;
+               task_unlock(tsk);

Which seems to indicate that grabbing the lock is really about acting as
a memory barrier, but I wonder if it is meant to be a full barrier or
just an acquire.

If a full memory barrier happens to be needed even without membarrier,
perhaps this fix also corrects other issues ? It unclear from the
comment what this memory barrier orders though. Is it the chain
exit -> waitpid, or is it related to entering lazy TLB ?

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
 kernel/exit.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/exit.c b/kernel/exit.c
index 727150f28103..ce272ec55cdc 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -474,6 +474,14 @@ static void exit_mm(void)
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
+	smp_mb();
 	current->mm = NULL;
 	mmap_read_unlock(mm);
 	enter_lazy_tlb(mm, current);
-- 
2.11.0

