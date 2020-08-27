Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F7BC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4439B20825
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v7ITrjWl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qOVfVV3t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbgH0H5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbgH0HyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBD3C061264;
        Thu, 27 Aug 2020 00:54:24 -0700 (PDT)
Date:   Thu, 27 Aug 2020 07:54:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514863;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VmsOkT6QWTQSrj1TTxvkK8Jl1Wo9FX5s0w6TlZUgGqI=;
        b=v7ITrjWlY46HMBqx1HIizd7qSyNQE7HWYbILz45/FNkrtchvHL0WINwp3uuXpNG1MipvM9
        dIUZP/4vv2N0lCywnC5wkDI7SToe3+Vgfc+DSI915MpAhCpOJhEAuwVYORe2qVHBWFRyoZ
        tXYxusxUnyJgSise7UkpWRYBVq0m0aoZW1KCg/a8KOKIVPcXaVsbtetoIcupXEjAVPu5nZ
        78S9xpmOJEs0hKxuV+SmocYximj58jOQ4Qqzn0s6GsfVIMOa6tpauOwaWo4G754Lfz41c9
        teMTAuX8Oss6y4/Uxi//wPubKxsMmhacVUa9wlv5lAHvFlzXVDC1RR21/FP6qQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514863;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VmsOkT6QWTQSrj1TTxvkK8Jl1Wo9FX5s0w6TlZUgGqI=;
        b=qOVfVV3tnK4dhuj19gnsPXJbdsSp7bPrvVEOAHtwFNxtut0vVFVtuFdEDwQO2QQhFNFkCQ
        QR3llC7uu3Dj1WCw==
From:   "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking: More accurate annotations for read_lock()
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200807074238.1632519-2-boqun.feng@gmail.com>
References: <20200807074238.1632519-2-boqun.feng@gmail.com>
MIME-Version: 1.0
Message-ID: <159851486232.20229.2972315816824977686.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     e918188611f073063415f40fae568fa4d86d9044
Gitweb:        https://git.kernel.org/tip/e918188611f073063415f40fae568fa4d86d9044
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Fri, 07 Aug 2020 15:42:20 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:42:02 +02:00

locking: More accurate annotations for read_lock()

On the archs using QUEUED_RWLOCKS, read_lock() is not always a recursive
read lock, actually it's only recursive if in_interrupt() is true. So
change the annotation accordingly to catch more deadlocks.

Note we used to treat read_lock() as pure recursive read locks in
lib/locking-seftest.c, and this is useful, especially for the lockdep
development selftest, so we keep this via a variable to force switching
lock annotation for read_lock().

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200807074238.1632519-2-boqun.feng@gmail.com
---
 include/linux/lockdep.h  | 23 ++++++++++++++++++++++-
 kernel/locking/lockdep.c | 14 ++++++++++++++
 lib/locking-selftest.c   | 11 +++++++++++
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 6a584b3..7cae5ea 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -469,6 +469,20 @@ static inline void print_irqtrace_events(struct task_struct *curr)
 }
 #endif
 
+/* Variable used to make lockdep treat read_lock() as recursive in selftests */
+#ifdef CONFIG_DEBUG_LOCKING_API_SELFTESTS
+extern unsigned int force_read_lock_recursive;
+#else /* CONFIG_DEBUG_LOCKING_API_SELFTESTS */
+#define force_read_lock_recursive 0
+#endif /* CONFIG_DEBUG_LOCKING_API_SELFTESTS */
+
+#ifdef CONFIG_LOCKDEP
+extern bool read_lock_is_recursive(void);
+#else /* CONFIG_LOCKDEP */
+/* If !LOCKDEP, the value is meaningless */
+#define read_lock_is_recursive() 0
+#endif
+
 /*
  * For trivial one-depth nesting of a lock-class, the following
  * global define can be used. (Subsystems with multiple levels
@@ -490,7 +504,14 @@ static inline void print_irqtrace_events(struct task_struct *curr)
 #define spin_release(l, i)			lock_release(l, i)
 
 #define rwlock_acquire(l, s, t, i)		lock_acquire_exclusive(l, s, t, NULL, i)
-#define rwlock_acquire_read(l, s, t, i)		lock_acquire_shared_recursive(l, s, t, NULL, i)
+#define rwlock_acquire_read(l, s, t, i)					\
+do {									\
+	if (read_lock_is_recursive())					\
+		lock_acquire_shared_recursive(l, s, t, NULL, i);	\
+	else								\
+		lock_acquire_shared(l, s, t, NULL, i);			\
+} while (0)
+
 #define rwlock_release(l, i)			lock_release(l, i)
 
 #define seqcount_acquire(l, s, t, i)		lock_acquire_exclusive(l, s, t, NULL, i)
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 54b74fa..77cd9e6 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4968,6 +4968,20 @@ static bool lockdep_nmi(void)
 }
 
 /*
+ * read_lock() is recursive if:
+ * 1. We force lockdep think this way in selftests or
+ * 2. The implementation is not queued read/write lock or
+ * 3. The locker is at an in_interrupt() context.
+ */
+bool read_lock_is_recursive(void)
+{
+	return force_read_lock_recursive ||
+	       !IS_ENABLED(CONFIG_QUEUED_RWLOCKS) ||
+	       in_interrupt();
+}
+EXPORT_SYMBOL_GPL(read_lock_is_recursive);
+
+/*
  * We are not always called with irqs disabled - do that here,
  * and also avoid lockdep recursion:
  */
diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 14f44f5..caadc4d 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -28,6 +28,7 @@
  * Change this to 1 if you want to see the failure printouts:
  */
 static unsigned int debug_locks_verbose;
+unsigned int force_read_lock_recursive;
 
 static DEFINE_WD_CLASS(ww_lockdep);
 
@@ -1979,6 +1980,11 @@ void locking_selftest(void)
 	}
 
 	/*
+	 * treats read_lock() as recursive read locks for testing purpose
+	 */
+	force_read_lock_recursive = 1;
+
+	/*
 	 * Run the testsuite:
 	 */
 	printk("------------------------\n");
@@ -2073,6 +2079,11 @@ void locking_selftest(void)
 
 	ww_tests();
 
+	force_read_lock_recursive = 0;
+	/*
+	 * queued_read_lock() specific test cases can be put here
+	 */
+
 	if (unexpected_testcase_failures) {
 		printk("-----------------------------------------------------------------\n");
 		debug_locks = 0;
