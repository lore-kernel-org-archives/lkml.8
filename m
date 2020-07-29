Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A107C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 252762173E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X1mwxjQv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Oj1jIMUb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgG2Odk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:33:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42918 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgG2Ode (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:33:34 -0400
Date:   Wed, 29 Jul 2020 14:33:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596033212;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d+E+dohbkBMdQOxP2xMUEuoeG4Agc6EKRuq4RZm9pfw=;
        b=X1mwxjQveNueKBo41uN17G/Uka18imMGXvyHjpDxod068To6Q3Tm5gzuE0LrypKN1niD26
        JnVkS+TlOiWYUFMF0VZC1lCMaw7Kr6UjowmIBS3TtsiQR0qnvmp8VSDPyc15OgUsMKTfGq
        WlXkvKtftKpyzwKDcW5krenRIXfNS0olvfId0OPkg36k+is4jw97qAJhDNUVonTPLK3WPE
        e/XBXwALR5g40ULa0Z3geVCXHLGUbb31ntezLR9uPUIqUSgo7jRGCyYJWG/jfcVQaYmySA
        pNZizowlv8sakwwQI15DP3LKU/28GTS3U/rTPSS5CpjENm0OmctxHwjbyVzY7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596033212;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d+E+dohbkBMdQOxP2xMUEuoeG4Agc6EKRuq4RZm9pfw=;
        b=Oj1jIMUbmcHnmGIq54Lga4+Q9vMJlEpYVdDUhUNs4VvagTFhPFoGRD+p/P1vOh2lkmgv0g
        ROsjD647W6ME+yBg==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] timekeeping: Use sequence counter with associated
 raw spinlock
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200720155530.1173732-18-a.darwish@linutronix.de>
References: <20200720155530.1173732-18-a.darwish@linutronix.de>
MIME-Version: 1.0
Message-ID: <159603321180.4006.6658058761874358283.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     025e82bcbc34cd071390e72fd0b31593282f9425
Gitweb:        https://git.kernel.org/tip/025e82bcbc34cd071390e72fd0b31593282f9425
Author:        Ahmed S. Darwish <a.darwish@linutronix.de>
AuthorDate:    Mon, 20 Jul 2020 17:55:23 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Jul 2020 16:14:27 +02:00

timekeeping: Use sequence counter with associated raw spinlock

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200720155530.1173732-18-a.darwish@linutronix.de
---
 kernel/time/timekeeping.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index d20d489..05ecfd8 100644
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
