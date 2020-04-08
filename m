Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F73C2BA80
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 12:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182EE2083E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 12:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgDHMVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 08:21:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49688 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728562AbgDHMVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 08:21:01 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jM9hR-0006C4-Vk; Wed, 08 Apr 2020 14:20:58 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9C6DB1C0131;
        Wed,  8 Apr 2020 14:20:57 +0200 (CEST)
Date:   Wed, 08 Apr 2020 12:20:57 -0000
From:   "tip-bot2 for Qian Cai" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking/percpu-rwsem: Fix a task_struct refcount
Cc:     Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@lca.pw>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200330213002.2374-1-cai@lca.pw>
References: <20200330213002.2374-1-cai@lca.pw>
MIME-Version: 1.0
Message-ID: <158634845721.28353.1181972786465191647.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     d22cc7f67d55ebf2d5be865453971c783e9fb21a
Gitweb:        https://git.kernel.org/tip/d22cc7f67d55ebf2d5be865453971c783e9fb21a
Author:        Qian Cai <cai@lca.pw>
AuthorDate:    Mon, 30 Mar 2020 17:30:02 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 08 Apr 2020 12:05:06 +02:00

locking/percpu-rwsem: Fix a task_struct refcount

The following commit:

  7f26482a872c ("locking/percpu-rwsem: Remove the embedded rwsem")

introduced task_struct memory leaks due to messing up the task_struct
refcount.

At the beginning of percpu_rwsem_wake_function(), it calls get_task_struct(),
but if the trylock failed, it will remain in the waitqueue. However, it
will run percpu_rwsem_wake_function() again with get_task_struct() to
increase the refcount but then only call put_task_struct() once the trylock
succeeded.

Fix it by adjusting percpu_rwsem_wake_function() a bit to guard against
when percpu_rwsem_wait() observing !private, terminating the wait and
doing a quick exit() while percpu_rwsem_wake_function() then doing
wake_up_process(p) as a use-after-free.

Fixes: 7f26482a872c ("locking/percpu-rwsem: Remove the embedded rwsem")
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Qian Cai <cai@lca.pw>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200330213002.2374-1-cai@lca.pw
---
 kernel/locking/percpu-rwsem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index a008a1b..8bbafe3 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -118,14 +118,15 @@ static int percpu_rwsem_wake_function(struct wait_queue_entry *wq_entry,
 				      unsigned int mode, int wake_flags,
 				      void *key)
 {
-	struct task_struct *p = get_task_struct(wq_entry->private);
 	bool reader = wq_entry->flags & WQ_FLAG_CUSTOM;
 	struct percpu_rw_semaphore *sem = key;
+	struct task_struct *p;
 
 	/* concurrent against percpu_down_write(), can get stolen */
 	if (!__percpu_rwsem_trylock(sem, reader))
 		return 1;
 
+	p = get_task_struct(wq_entry->private);
 	list_del_init(&wq_entry->entry);
 	smp_store_release(&wq_entry->private, NULL);
 
