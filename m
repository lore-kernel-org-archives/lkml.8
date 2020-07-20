Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F00DC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 277F5206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I7BgZSnv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HPtNFSpY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbgGTP4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731741AbgGTP4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:56:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96802C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 08:56:11 -0700 (PDT)
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595260570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=csm6qsmcvrkuC3wqo2RObLqWMOC0odk2hhFpp4R4S68=;
        b=I7BgZSnv43hlG/8MAWSzdbawh2+/ymgU6baklhFOO96spk58wM7RcSneVgAmuDUYHCtf2R
        QglGd9/4K4BqjrFBBtHBbXbBkOzlBaPp/CbTuk7IaSM+fQxyBsH/X4kEYAfY5DSh1iUhk2
        ALJhBpO0xAkbnvoVMjGl9XhdRlBsnXhpJM2lfXDSwQ72WuCepYL2Cdi8rNtCaH5S63bOXG
        5zR92mmXyVRxRY3a+ptoQ7W7lMWGnlFYxV5Mq2a2htP4Dl8FjnUPZtJ5hKu43qROnR/OsT
        l6NBZPfQ4QUDbPVy9EgWffLfNP24ixVctpSNKB/ToFBy1BykMSiKlstTWzP4NQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595260570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=csm6qsmcvrkuC3wqo2RObLqWMOC0odk2hhFpp4R4S68=;
        b=HPtNFSpYcYbtURCsvIqNiXS4p9eGFcLbf5SeYCeVrGmrS5umnwW7q/tvdGN3HFOPTaj2/b
        lLK5SsAsSMdRymCQ==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH v4 08/24] seqlock: lockdep assert non-preemptibility on seqcount_t write
Date:   Mon, 20 Jul 2020 17:55:14 +0200
Message-Id: <20200720155530.1173732-9-a.darwish@linutronix.de>
In-Reply-To: <20200720155530.1173732-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200720155530.1173732-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 include/linux/seqlock.h | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index e885702d8b82..54bc20496392 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -266,6 +266,12 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
 	kcsan_nestable_atomic_end();
 }
 
+static inline void __write_seqcount_begin_nested(seqcount_t *s, int subclass)
+{
+	raw_write_seqcount_begin(s);
+	seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
+}
+
 /**
  * write_seqcount_begin_nested() - start a seqcount_t write section with
  *                                 custom lockdep nesting level
@@ -276,8 +282,19 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
  */
 static inline void write_seqcount_begin_nested(seqcount_t *s, int subclass)
 {
-	raw_write_seqcount_begin(s);
-	seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
+	lockdep_assert_preemption_disabled();
+	__write_seqcount_begin_nested(s, subclass);
+}
+
+/*
+ * A write_seqcount_begin() variant w/o lockdep non-preemptibility checks.
+ *
+ * Use for internal seqlock.h code where it's known that preemption is
+ * already disabled. For example, seqlock_t write side functions.
+ */
+static inline void __write_seqcount_begin(seqcount_t *s)
+{
+	__write_seqcount_begin_nested(s, 0);
 }
 
 /**
@@ -575,7 +592,7 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 static inline void write_seqlock(seqlock_t *sl)
 {
 	spin_lock(&sl->lock);
-	write_seqcount_begin(&sl->seqcount);
+	__write_seqcount_begin(&sl->seqcount);
 }
 
 /**
@@ -601,7 +618,7 @@ static inline void write_sequnlock(seqlock_t *sl)
 static inline void write_seqlock_bh(seqlock_t *sl)
 {
 	spin_lock_bh(&sl->lock);
-	write_seqcount_begin(&sl->seqcount);
+	__write_seqcount_begin(&sl->seqcount);
 }
 
 /**
@@ -628,7 +645,7 @@ static inline void write_sequnlock_bh(seqlock_t *sl)
 static inline void write_seqlock_irq(seqlock_t *sl)
 {
 	spin_lock_irq(&sl->lock);
-	write_seqcount_begin(&sl->seqcount);
+	__write_seqcount_begin(&sl->seqcount);
 }
 
 /**
@@ -649,7 +666,7 @@ static inline unsigned long __write_seqlock_irqsave(seqlock_t *sl)
 	unsigned long flags;
 
 	spin_lock_irqsave(&sl->lock, flags);
-	write_seqcount_begin(&sl->seqcount);
+	__write_seqcount_begin(&sl->seqcount);
 	return flags;
 }
 
-- 
2.20.1

