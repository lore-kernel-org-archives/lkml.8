Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A32C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7180205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgESVs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 17:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbgESVqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 17:46:54 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71792C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 14:46:54 -0700 (PDT)
Received: from [5.158.153.53] (helo=debian-buster-darwi.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <a.darwish@linutronix.de>)
        id 1jbA4D-0002fp-GG; Tue, 19 May 2020 23:46:29 +0200
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH v1 08/25] seqlock: lockdep assert non-preemptibility on seqcount_t write
Date:   Tue, 19 May 2020 23:45:30 +0200
Message-Id: <20200519214547.352050-9-a.darwish@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519214547.352050-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preemption must be disabled before entering a sequence count write side
critical section.  Failing to do so, the seqcount read side can preempt
the write side section and spin for the entire scheduler tick.  If that
reader belongs to a real-time scheduling class, it can spin forever and
the kernel will livelock.

Assert through lockdep that preemption is disabled for seqcount writers.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 include/linux/seqlock.h | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 0491d963d47e..d35be7709403 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -369,14 +369,32 @@ static inline void raw_write_seqcount_latch(seqcount_t *s)
 
 /*
  * Sequence counter only version assumes that callers are using their
- * own mutexing.
+ * own locking and preemption is disabled.
  */
-static inline void write_seqcount_begin_nested(seqcount_t *s, int subclass)
+
+static inline void __write_seqcount_begin_nested(seqcount_t *s, int subclass)
 {
 	raw_write_seqcount_begin(s);
 	seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
 }
 
+static inline void write_seqcount_begin_nested(seqcount_t *s, int subclass)
+{
+	lockdep_assert_preemption_disabled();
+	__write_seqcount_begin_nested(s, subclass);
+}
+
+/*
+ * write_seqcount_begin() without lockdep non-preemptibility checks.
+ *
+ * Use for internal seqlock.h code where it's known that preemption
+ * is already disabled. For example, seqlock_t write functions.
+ */
+static inline void __write_seqcount_begin(seqcount_t *s)
+{
+	__write_seqcount_begin_nested(s, 0);
+}
+
 static inline void write_seqcount_begin(seqcount_t *s)
 {
 	write_seqcount_begin_nested(s, 0);
@@ -446,7 +464,7 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 static inline void write_seqlock(seqlock_t *sl)
 {
 	spin_lock(&sl->lock);
-	write_seqcount_begin(&sl->seqcount);
+	__write_seqcount_begin(&sl->seqcount);
 }
 
 static inline void write_sequnlock(seqlock_t *sl)
@@ -458,7 +476,7 @@ static inline void write_sequnlock(seqlock_t *sl)
 static inline void write_seqlock_bh(seqlock_t *sl)
 {
 	spin_lock_bh(&sl->lock);
-	write_seqcount_begin(&sl->seqcount);
+	__write_seqcount_begin(&sl->seqcount);
 }
 
 static inline void write_sequnlock_bh(seqlock_t *sl)
@@ -470,7 +488,7 @@ static inline void write_sequnlock_bh(seqlock_t *sl)
 static inline void write_seqlock_irq(seqlock_t *sl)
 {
 	spin_lock_irq(&sl->lock);
-	write_seqcount_begin(&sl->seqcount);
+	__write_seqcount_begin(&sl->seqcount);
 }
 
 static inline void write_sequnlock_irq(seqlock_t *sl)
@@ -484,7 +502,7 @@ static inline unsigned long __write_seqlock_irqsave(seqlock_t *sl)
 	unsigned long flags;
 
 	spin_lock_irqsave(&sl->lock, flags);
-	write_seqcount_begin(&sl->seqcount);
+	__write_seqcount_begin(&sl->seqcount);
 	return flags;
 }
 
-- 
2.20.1

