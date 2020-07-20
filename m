Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAE9C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3489720734
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YS60SVfQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l4mOM5HO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731930AbgGTP5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:57:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59024 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731630AbgGTP5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:57:30 -0400
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595260647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UmigHx4BW8UOIynqAPFCArO8Ak7spa6ugzxCvPtvbYY=;
        b=YS60SVfQBxqT/Li2iQB5b0h4QDLCcgPMbHVGl1woTVLkVdAxPZ1gw6JcM0M8asl1zLB0FH
        V2QRS+7qXcHD05dmdsRgbqxMqlSTpQ4mCacpY0fAd0V0tUNnxLsxdcU7nt4oVzPGfqBoU7
        yH6d1QndFTzPTDvR8kaWgCm8+5z362PAItSXbi9IvflIanYn3Ivx+RAmrWT8guIdBBQVwY
        GEkbKYHvWof9jGmtT0DZTKkeSZ4Q2VZRNd6Qja44UCDST7zaryrKkphMogVQhIL7LZlxvU
        kkhkZfJpGXI6j+VY/PJq1Ua8lSVLqtT7476HPwXNKm2V3YyS3/3FbE0STm0aNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595260647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UmigHx4BW8UOIynqAPFCArO8Ak7spa6ugzxCvPtvbYY=;
        b=l4mOM5HO2qcAozOIfeVDMN68nNfJxASG344/KNPrhaSuW+tVwWGl0+njfUd/TR3j5KGsfW
        7J2DjFoy5TOd6eAQ==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH v4 24/24] hrtimer: Use sequence counter with associated raw spinlock
Date:   Mon, 20 Jul 2020 17:55:30 +0200
Message-Id: <20200720155530.1173732-25-a.darwish@linutronix.de>
In-Reply-To: <20200720155530.1173732-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200720155530.1173732-1-a.darwish@linutronix.de>
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
 include/linux/hrtimer.h |  2 +-
 kernel/time/hrtimer.c   | 13 ++++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 15c8ac313678..25993b86ac5c 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -159,7 +159,7 @@ struct hrtimer_clock_base {
 	struct hrtimer_cpu_base	*cpu_base;
 	unsigned int		index;
 	clockid_t		clockid;
-	seqcount_t		seq;
+	seqcount_raw_spinlock_t	seq;
 	struct hrtimer		*running;
 	struct timerqueue_head	active;
 	ktime_t			(*get_time)(void);
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index d89da1c7e005..c4038511d5c9 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -135,7 +135,11 @@ static const int hrtimer_clock_to_base_table[MAX_CLOCKS] = {
  * timer->base->cpu_base
  */
 static struct hrtimer_cpu_base migration_cpu_base = {
-	.clock_base = { { .cpu_base = &migration_cpu_base, }, },
+	.clock_base = { {
+		.cpu_base = &migration_cpu_base,
+		.seq      = SEQCNT_RAW_SPINLOCK_ZERO(migration_cpu_base.seq,
+						     &migration_cpu_base.lock),
+	}, },
 };
 
 #define migration_base	migration_cpu_base.clock_base[0]
@@ -1998,8 +2002,11 @@ int hrtimers_prepare_cpu(unsigned int cpu)
 	int i;
 
 	for (i = 0; i < HRTIMER_MAX_CLOCK_BASES; i++) {
-		cpu_base->clock_base[i].cpu_base = cpu_base;
-		timerqueue_init_head(&cpu_base->clock_base[i].active);
+		struct hrtimer_clock_base *clock_b = &cpu_base->clock_base[i];
+
+		clock_b->cpu_base = cpu_base;
+		seqcount_raw_spinlock_init(&clock_b->seq, &cpu_base->lock);
+		timerqueue_init_head(&clock_b->active);
 	}
 
 	cpu_base->cpu = cpu;
-- 
2.20.1

