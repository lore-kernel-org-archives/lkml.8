Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208B7C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3B2E22BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J7VIbabl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bL49tc/V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgH0H5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:57:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36550 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbgH0HyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:25 -0400
Date:   Thu, 27 Aug 2020 07:54:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514862;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AaJf4vzeb8lp3ebQQLlqfjkj7mAEZZA0/yhMp64P4jc=;
        b=J7VIbabl2X9PmCff69MJKh/iHk/3NsPHWbiDXQ1/VWW1rF2negIppKECS3GsrrT6Nr3uXX
        Wv66Yjp3v+yrQAgok+Cj3D6wVjdwNHxvq7e7coco38b47flu1fsfS3xfiPU5vsdHSkoHzK
        gvRwU+KL14PJFRWXB1F7EXNGBza6acQ/CFczQy6iBdF/K5v2M5AyAwtYU0Z6pbJTsD+eRA
        6/SzZKnnLahEPE/HQJW1sM21SM4Ev1oiWcFDC0Fkqfh2SsAa0t7x/eNW9UJkgMemmWyNz6
        oyVLVW/Y1I+c0M6aowoB+RMVcktOzX9Ldas4IrMPWb2Nji842NCy3Wdn2sSbwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514862;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AaJf4vzeb8lp3ebQQLlqfjkj7mAEZZA0/yhMp64P4jc=;
        b=bL49tc/V1oLDj5juHInbljZI0Nydjpt35MndocV19SKF21JNjb67lH8UFCADyUBMDYcmc1
        iU/iwN3mkQRT4pCQ==
From:   "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep/Documention: Recursive read lock
 detection reasoning
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200807074238.1632519-3-boqun.feng@gmail.com>
References: <20200807074238.1632519-3-boqun.feng@gmail.com>
MIME-Version: 1.0
Message-ID: <159851486191.20229.8841390715473332296.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     224ec489d3cdb0af6794e257eeee39d98dc9c5b2
Gitweb:        https://git.kernel.org/tip/224ec489d3cdb0af6794e257eeee39d98dc9c5b2
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Fri, 07 Aug 2020 15:42:21 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:42:03 +02:00

lockdep/Documention: Recursive read lock detection reasoning

This patch add the documentation piece for the reasoning of deadlock
detection related to recursive read lock. The following sections are
added:

*	Explain what is a recursive read lock, and what deadlock cases
	they could introduce.

*	Introduce the notations for different types of dependencies, and
	the definition of strong paths.

*	Proof for a closed strong path is both sufficient and necessary
	for deadlock detections with recursive read locks involved. The
	proof could also explain why we call the path "strong"

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200807074238.1632519-3-boqun.feng@gmail.com
---
 Documentation/locking/lockdep-design.rst | 258 ++++++++++++++++++++++-
 1 file changed, 258 insertions(+)

diff --git a/Documentation/locking/lockdep-design.rst b/Documentation/locking/lockdep-design.rst
index 23fcbc4..cec03bd 100644
--- a/Documentation/locking/lockdep-design.rst
+++ b/Documentation/locking/lockdep-design.rst
@@ -392,3 +392,261 @@ Run the command and save the output, then compare against the output from
 a later run of this command to identify the leakers.  This same output
 can also help you find situations where runtime lock initialization has
 been omitted.
+
+Recursive read locks:
+---------------------
+The whole of the rest document tries to prove a certain type of cycle is equivalent
+to deadlock possibility.
+
+There are three types of lockers: writers (i.e. exclusive lockers, like
+spin_lock() or write_lock()), non-recursive readers (i.e. shared lockers, like
+down_read()) and recursive readers (recursive shared lockers, like rcu_read_lock()).
+And we use the following notations of those lockers in the rest of the document:
+
+	W or E:	stands for writers (exclusive lockers).
+	r:	stands for non-recursive readers.
+	R:	stands for recursive readers.
+	S:	stands for all readers (non-recursive + recursive), as both are shared lockers.
+	N:	stands for writers and non-recursive readers, as both are not recursive.
+
+Obviously, N is "r or W" and S is "r or R".
+
+Recursive readers, as their name indicates, are the lockers allowed to acquire
+even inside the critical section of another reader of the same lock instance,
+in other words, allowing nested read-side critical sections of one lock instance.
+
+While non-recursive readers will cause a self deadlock if trying to acquire inside
+the critical section of another reader of the same lock instance.
+
+The difference between recursive readers and non-recursive readers is because:
+recursive readers get blocked only by a write lock *holder*, while non-recursive
+readers could get blocked by a write lock *waiter*. Considering the follow example:
+
+	TASK A:			TASK B:
+
+	read_lock(X);
+				write_lock(X);
+	read_lock_2(X);
+
+Task A gets the reader (no matter whether recursive or non-recursive) on X via
+read_lock() first. And when task B tries to acquire writer on X, it will block
+and become a waiter for writer on X. Now if read_lock_2() is recursive readers,
+task A will make progress, because writer waiters don't block recursive readers,
+and there is no deadlock. However, if read_lock_2() is non-recursive readers,
+it will get blocked by writer waiter B, and cause a self deadlock.
+
+Block conditions on readers/writers of the same lock instance:
+--------------------------------------------------------------
+There are simply four block conditions:
+
+1.	Writers block other writers.
+2.	Readers block writers.
+3.	Writers block both recursive readers and non-recursive readers.
+4.	And readers (recursive or not) don't block other recursive readers but
+	may block non-recursive readers (because of the potential co-existing
+	writer waiters)
+
+Block condition matrix, Y means the row blocks the column, and N means otherwise.
+
+	    | E | r | R |
+	+---+---+---+---+
+	  E | Y | Y | Y |
+	+---+---+---+---+
+	  r | Y | Y | N |
+	+---+---+---+---+
+	  R | Y | Y | N |
+
+	(W: writers, r: non-recursive readers, R: recursive readers)
+
+
+acquired recursively. Unlike non-recursive read locks, recursive read locks
+only get blocked by current write lock *holders* other than write lock
+*waiters*, for example:
+
+	TASK A:			TASK B:
+
+	read_lock(X);
+
+				write_lock(X);
+
+	read_lock(X);
+
+is not a deadlock for recursive read locks, as while the task B is waiting for
+the lock X, the second read_lock() doesn't need to wait because it's a recursive
+read lock. However if the read_lock() is non-recursive read lock, then the above
+case is a deadlock, because even if the write_lock() in TASK B cannot get the
+lock, but it can block the second read_lock() in TASK A.
+
+Note that a lock can be a write lock (exclusive lock), a non-recursive read
+lock (non-recursive shared lock) or a recursive read lock (recursive shared
+lock), depending on the lock operations used to acquire it (more specifically,
+the value of the 'read' parameter for lock_acquire()). In other words, a single
+lock instance has three types of acquisition depending on the acquisition
+functions: exclusive, non-recursive read, and recursive read.
+
+To be concise, we call that write locks and non-recursive read locks as
+"non-recursive" locks and recursive read locks as "recursive" locks.
+
+Recursive locks don't block each other, while non-recursive locks do (this is
+even true for two non-recursive read locks). A non-recursive lock can block the
+corresponding recursive lock, and vice versa.
+
+A deadlock case with recursive locks involved is as follow:
+
+	TASK A:			TASK B:
+
+	read_lock(X);
+				read_lock(Y);
+	write_lock(Y);
+				write_lock(X);
+
+Task A is waiting for task B to read_unlock() Y and task B is waiting for task
+A to read_unlock() X.
+
+Dependency types and strong dependency paths:
+---------------------------------------------
+Lock dependencies record the orders of the acquisitions of a pair of locks, and
+because there are 3 types for lockers, there are, in theory, 9 types of lock
+dependencies, but we can show that 4 types of lock dependencies are enough for
+deadlock detection.
+
+For each lock dependency:
+
+	L1 -> L2
+
+, which means lockdep has seen L1 held before L2 held in the same context at runtime.
+And in deadlock detection, we care whether we could get blocked on L2 with L1 held,
+IOW, whether there is a locker L3 that L1 blocks L3 and L2 gets blocked by L3. So
+we only care about 1) what L1 blocks and 2) what blocks L2. As a result, we can combine
+recursive readers and non-recursive readers for L1 (as they block the same types) and
+we can combine writers and non-recursive readers for L2 (as they get blocked by the
+same types).
+
+With the above combination for simplification, there are 4 types of dependency edges
+in the lockdep graph:
+
+1) -(ER)->: exclusive writer to recursive reader dependency, "X -(ER)-> Y" means
+	    X -> Y and X is a writer and Y is a recursive reader.
+
+2) -(EN)->: exclusive writer to non-recursive locker dependency, "X -(EN)-> Y" means
+	    X -> Y and X is a writer and Y is either a writer or non-recursive reader.
+
+3) -(SR)->: shared reader to recursive reader dependency, "X -(SR)-> Y" means
+	    X -> Y and X is a reader (recursive or not) and Y is a recursive reader.
+
+4) -(SN)->: shared reader to non-recursive locker dependency, "X -(SN)-> Y" means
+	    X -> Y and X is a reader (recursive or not) and Y is either a writer or
+	    non-recursive reader.
+
+Note that given two locks, they may have multiple dependencies between them, for example:
+
+	TASK A:
+
+	read_lock(X);
+	write_lock(Y);
+	...
+
+	TASK B:
+
+	write_lock(X);
+	write_lock(Y);
+
+, we have both X -(SN)-> Y and X -(EN)-> Y in the dependency graph.
+
+We use -(xN)-> to represent edges that are either -(EN)-> or -(SN)->, the
+similar for -(Ex)->, -(xR)-> and -(Sx)->
+
+A "path" is a series of conjunct dependency edges in the graph. And we define a
+"strong" path, which indicates the strong dependency throughout each dependency
+in the path, as the path that doesn't have two conjunct edges (dependencies) as
+-(xR)-> and -(Sx)->. In other words, a "strong" path is a path from a lock
+walking to another through the lock dependencies, and if X -> Y -> Z is in the
+path (where X, Y, Z are locks), and the walk from X to Y is through a -(SR)-> or
+-(ER)-> dependency, the walk from Y to Z must not be through a -(SN)-> or
+-(SR)-> dependency.
+
+We will see why the path is called "strong" in next section.
+
+Recursive Read Deadlock Detection:
+----------------------------------
+
+We now prove two things:
+
+Lemma 1:
+
+If there is a closed strong path (i.e. a strong circle), then there is a
+combination of locking sequences that causes deadlock. I.e. a strong circle is
+sufficient for deadlock detection.
+
+Lemma 2:
+
+If there is no closed strong path (i.e. strong circle), then there is no
+combination of locking sequences that could cause deadlock. I.e.  strong
+circles are necessary for deadlock detection.
+
+With these two Lemmas, we can easily say a closed strong path is both sufficient
+and necessary for deadlocks, therefore a closed strong path is equivalent to
+deadlock possibility. As a closed strong path stands for a dependency chain that
+could cause deadlocks, so we call it "strong", considering there are dependency
+circles that won't cause deadlocks.
+
+Proof for sufficiency (Lemma 1):
+
+Let's say we have a strong circle:
+
+	L1 -> L2 ... -> Ln -> L1
+
+, which means we have dependencies:
+
+	L1 -> L2
+	L2 -> L3
+	...
+	Ln-1 -> Ln
+	Ln -> L1
+
+We now can construct a combination of locking sequences that cause deadlock:
+
+Firstly let's make one CPU/task get the L1 in L1 -> L2, and then another get
+the L2 in L2 -> L3, and so on. After this, all of the Lx in Lx -> Lx+1 are
+held by different CPU/tasks.
+
+And then because we have L1 -> L2, so the holder of L1 is going to acquire L2
+in L1 -> L2, however since L2 is already held by another CPU/task, plus L1 ->
+L2 and L2 -> L3 are not -(xR)-> and -(Sx)-> (the definition of strong), which
+means either L2 in L1 -> L2 is a non-recursive locker (blocked by anyone) or
+the L2 in L2 -> L3, is writer (blocking anyone), therefore the holder of L1
+cannot get L2, it has to wait L2's holder to release.
+
+Moreover, we can have a similar conclusion for L2's holder: it has to wait L3's
+holder to release, and so on. We now can prove that Lx's holder has to wait for
+Lx+1's holder to release, and note that Ln+1 is L1, so we have a circular
+waiting scenario and nobody can get progress, therefore a deadlock.
+
+Proof for necessary (Lemma 2):
+
+Lemma 2 is equivalent to: If there is a deadlock scenario, then there must be a
+strong circle in the dependency graph.
+
+According to Wikipedia[1], if there is a deadlock, then there must be a circular
+waiting scenario, means there are N CPU/tasks, where CPU/task P1 is waiting for
+a lock held by P2, and P2 is waiting for a lock held by P3, ... and Pn is waiting
+for a lock held by P1. Let's name the lock Px is waiting as Lx, so since P1 is waiting
+for L1 and holding Ln, so we will have Ln -> L1 in the dependency graph. Similarly,
+we have L1 -> L2, L2 -> L3, ..., Ln-1 -> Ln in the dependency graph, which means we
+have a circle:
+
+	Ln -> L1 -> L2 -> ... -> Ln
+
+, and now let's prove the circle is strong:
+
+For a lock Lx, Px contributes the dependency Lx-1 -> Lx and Px+1 contributes
+the dependency Lx -> Lx+1, and since Px is waiting for Px+1 to release Lx,
+so it's impossible that Lx on Px+1 is a reader and Lx on Px is a recursive
+reader, because readers (no matter recursive or not) don't block recursive
+readers, therefore Lx-1 -> Lx and Lx -> Lx+1 cannot be a -(xR)-> -(Sx)-> pair,
+and this is true for any lock in the circle, therefore, the circle is strong.
+
+References:
+-----------
+[1]: https://en.wikipedia.org/wiki/Deadlock
+[2]: Shibu, K. (2009). Intro To Embedded Systems (1st ed.). Tata McGraw-Hill
