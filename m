Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB40C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABBC2206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kqT6pe5d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4TrtQC+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbgF3FqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 01:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729941AbgF3FqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 01:46:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE64BC03E979
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 22:46:01 -0700 (PDT)
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593495960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GofmFicM0Ot7KWATWSSEdP5X+bhnBzrS2jXewofFGIY=;
        b=kqT6pe5d+ywJEQM3b0TTNx5/R+dEd3w5ZvCRXzmdlBKadJbpHbkRTw/kbTJDyv4x9j6uHN
        V4Nvmkz536Qs6hIi7Z9hGJf/NxpFkO7VuXTxI2s4F/qv1XLzCamlxSRlNCIM5Dq60nlz+A
        U9qxL8x3Z70zsFmMLQuSU3PancZKIKgHnchM5wuiVpAgZ5jMdtucCGAJ5kzlAXp3xupas4
        vguMIdIMgSrrwO8rV6+9iRTfanhbZHNPNLxWGCbeK/NqyA8r5vhGWHj21UFie5E+6ANysn
        hYxhtH9yXFgud8UXRfOP46gtFOa+kUexIZPHMvYgtGYIwPIi8DBVprRYMy4p5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593495960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GofmFicM0Ot7KWATWSSEdP5X+bhnBzrS2jXewofFGIY=;
        b=4TrtQC+KizuLTg10cuqZBWFg8S9iRoVB7uzNi73Qci2//bZiyuf7TVj6e2uGi49ogjzXUx
        3kk8VRA/xXOljmAw==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v3 13/20] timekeeping: Use sequence counter with associated raw spinlock
Date:   Tue, 30 Jun 2020 07:44:45 +0200
Message-Id: <20200630054452.3675847-14-a.darwish@linutronix.de>
In-Reply-To: <20200630054452.3675847-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200630054452.3675847-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A sequence counter write side critical section must be protected by some
form of locking to serialize writers. A plain seqcount_t does not
contain the information of which lock must be held when entering a write
side critical section.

Use the new seqcount_raw_spinlock_t data type, which allows to associate
a raw spinlock with the sequence counter. This enables lockdep to verify
that the raw spinlock used for writer serialization is held when the
write side critical section is entered.

If lockdep is disabled this lock association is compiled out and has
neither storage size nor runtime overhead.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 kernel/time/timekeeping.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index d20d489841c8..05ecfd8a3314 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -39,18 +39,19 @@ enum timekeeping_adv_mode {
 	TK_ADV_FREQ
 };
 
+static DEFINE_RAW_SPINLOCK(timekeeper_lock);
+
 /*
  * The most important data for readout fits into a single 64 byte
  * cache line.
  */
 static struct {
-	seqcount_t		seq;
+	seqcount_raw_spinlock_t	seq;
 	struct timekeeper	timekeeper;
 } tk_core ____cacheline_aligned = {
-	.seq = SEQCNT_ZERO(tk_core.seq),
+	.seq = SEQCNT_RAW_SPINLOCK_ZERO(tk_core.seq, &timekeeper_lock),
 };
 
-static DEFINE_RAW_SPINLOCK(timekeeper_lock);
 static struct timekeeper shadow_timekeeper;
 
 /**
@@ -63,7 +64,7 @@ static struct timekeeper shadow_timekeeper;
  * See @update_fast_timekeeper() below.
  */
 struct tk_fast {
-	seqcount_t		seq;
+	seqcount_raw_spinlock_t	seq;
 	struct tk_read_base	base[2];
 };
 
@@ -80,11 +81,13 @@ static struct clocksource dummy_clock = {
 };
 
 static struct tk_fast tk_fast_mono ____cacheline_aligned = {
+	.seq     = SEQCNT_RAW_SPINLOCK_ZERO(tk_fast_mono.seq, &timekeeper_lock),
 	.base[0] = { .clock = &dummy_clock, },
 	.base[1] = { .clock = &dummy_clock, },
 };
 
 static struct tk_fast tk_fast_raw  ____cacheline_aligned = {
+	.seq     = SEQCNT_RAW_SPINLOCK_ZERO(tk_fast_raw.seq, &timekeeper_lock),
 	.base[0] = { .clock = &dummy_clock, },
 	.base[1] = { .clock = &dummy_clock, },
 };
@@ -157,7 +160,7 @@ static inline void tk_update_sleep_time(struct timekeeper *tk, ktime_t delta)
  * tk_clock_read - atomic clocksource read() helper
  *
  * This helper is necessary to use in the read paths because, while the
- * seqlock ensures we don't return a bad value while structures are updated,
+ * seqcount ensures we don't return a bad value while structures are updated,
  * it doesn't protect from potential crashes. There is the possibility that
  * the tkr's clocksource may change between the read reference, and the
  * clock reference passed to the read function.  This can cause crashes if
@@ -222,10 +225,10 @@ static inline u64 timekeeping_get_delta(const struct tk_read_base *tkr)
 	unsigned int seq;
 
 	/*
-	 * Since we're called holding a seqlock, the data may shift
+	 * Since we're called holding a seqcount, the data may shift
 	 * under us while we're doing the calculation. This can cause
 	 * false positives, since we'd note a problem but throw the
-	 * results away. So nest another seqlock here to atomically
+	 * results away. So nest another seqcount here to atomically
 	 * grab the points we are checking with.
 	 */
 	do {
@@ -486,7 +489,7 @@ EXPORT_SYMBOL_GPL(ktime_get_raw_fast_ns);
  *
  * To keep it NMI safe since we're accessing from tracing, we're not using a
  * separate timekeeper with updates to monotonic clock and boot offset
- * protected with seqlocks. This has the following minor side effects:
+ * protected with seqcounts. This has the following minor side effects:
  *
  * (1) Its possible that a timestamp be taken after the boot offset is updated
  * but before the timekeeper is updated. If this happens, the new boot offset
-- 
2.20.1

