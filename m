Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650EDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F70320672
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZxAVa4to";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lTx3kz5S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbgF3FpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 01:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729615AbgF3FpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 01:45:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEC2C03E979
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 22:45:18 -0700 (PDT)
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593495916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lunRlhcxXkJk+oc9hwlO5PkFmWrHF2RhUujVoo87/FM=;
        b=ZxAVa4to3pAig/0VmF03G3MMNTGgLHCCuu/o6G87J4rC8YbiSbY4rtPgRV6ZbqaAJi1/JO
        Y09XbLqti1N9d0XEktgqFm1lRSDJSEsQ1XCVH3p5KyWEnueZHODDXr2isZa9iRcu34sWlE
        whEX7sPURX3OL/9xowsVN1qARLhZx1gBeDtG7res4Qu4s7Ua+ZYzLvxoikGtHCsaXiVK2A
        bIykX0FHl0AfH4mh+7hhCMukglf5B6bh8LP7BJdxRCb3COw0disoQoI+GCQXuYM5rMc//8
        rrzuZC632sRPA3KAd8UL3rm/16ecLOmki+HL3OSq1bKr0yToWQNL0s/7K2xxIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593495916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lunRlhcxXkJk+oc9hwlO5PkFmWrHF2RhUujVoo87/FM=;
        b=lTx3kz5SZxcJ6hhWdhZMl4D3aIXlhfg52i+BjAB8LlawV9Pg5teFb+MMsSMDqSRark2LWC
        E1S67aHbVej/88Bg==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH v3 05/20] seqlock: lockdep assert non-preemptibility on seqcount_t write
Date:   Tue, 30 Jun 2020 07:44:37 +0200
Message-Id: <20200630054452.3675847-6-a.darwish@linutronix.de>
In-Reply-To: <20200630054452.3675847-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200630054452.3675847-1-a.darwish@linutronix.de>
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
 include/linux/seqlock.h | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 057f7326a877..679c440b17fe 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -419,12 +419,29 @@ static inline void raw_write_seqcount_latch(seqcount_t *s)
        smp_wmb();      /* increment "sequence" before following stores */
 }
 
-static inline void write_seqcount_begin_nested(seqcount_t *s, int subclass)
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
+ * Use for internal seqlock.h code where it's known that preemption is
+ * already disabled. For example, seqlock_t write side functions.
+ */
+static inline void __write_seqcount_begin(seqcount_t *s)
+{
+	__write_seqcount_begin_nested(s, 0);
+}
+
 /**
  * write_seqcount_begin() - start a seqcount_t write-side critical section
  * @s: Pointer to &typedef seqcount_t
@@ -563,7 +580,7 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 static inline void write_seqlock(seqlock_t *sl)
 {
 	spin_lock(&sl->lock);
-	write_seqcount_begin(&sl->seqcount);
+	__write_seqcount_begin(&sl->seqcount);
 }
 
 /**
@@ -591,7 +608,7 @@ static inline void write_sequnlock(seqlock_t *sl)
 static inline void write_seqlock_bh(seqlock_t *sl)
 {
 	spin_lock_bh(&sl->lock);
-	write_seqcount_begin(&sl->seqcount);
+	__write_seqcount_begin(&sl->seqcount);
 }
 
 /**
@@ -618,7 +635,7 @@ static inline void write_sequnlock_bh(seqlock_t *sl)
 static inline void write_seqlock_irq(seqlock_t *sl)
 {
 	spin_lock_irq(&sl->lock);
-	write_seqcount_begin(&sl->seqcount);
+	__write_seqcount_begin(&sl->seqcount);
 }
 
 /**
@@ -639,7 +656,7 @@ static inline unsigned long __write_seqlock_irqsave(seqlock_t *sl)
 	unsigned long flags;
 
 	spin_lock_irqsave(&sl->lock, flags);
-	write_seqcount_begin(&sl->seqcount);
+	__write_seqcount_begin(&sl->seqcount);
 	return flags;
 }
 
-- 
2.20.1

