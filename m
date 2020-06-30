Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EA8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3369820672
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xxvCKva9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dr+zoPA+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbgF3Fqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 01:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729836AbgF3Fqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 01:46:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1348DC061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 22:46:35 -0700 (PDT)
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593495993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UmigHx4BW8UOIynqAPFCArO8Ak7spa6ugzxCvPtvbYY=;
        b=xxvCKva9RnnBYSKhEn/oFk6GeNyTICD8JlRgqOP9lmH0a3AVC/I061UBqPV6ijq/2TyTQg
        5hwnT3OFraM5ZDBhXCak3k5UQv9G7z1xUzrpLmqVx94xL8nCcpFNzvXettOcKy/BZI96pz
        bPw1VgUB5MdJpEBG7KEsM2dvDat2CE2wkiSmQ0mCih0mEsMQ7FJJxqmvrGfQ+aaHoyzNWP
        F4woHpUniQT/YG1LuY9E9XpKM4vhUiKq7zrqadY9u/lQo1vVvK8vzwOPBmGjJN2nK5dE+t
        yqWcqiNltd8GDcukDboajYzofWHgCk/H2TlRATT90kzxLRS1XLT0tJ0ePgTriw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593495993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UmigHx4BW8UOIynqAPFCArO8Ak7spa6ugzxCvPtvbYY=;
        b=Dr+zoPA+8MQv7+LzU7NqEM6ykc3bBaGhRPqfTb57yMiC9ZgBc8aN+k7DvAMaAeNN55QU+g
        q6pEtb/sma+PW0Cw==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH v3 20/20] hrtimer: Use sequence counter with associated raw spinlock
Date:   Tue, 30 Jun 2020 07:44:52 +0200
Message-Id: <20200630054452.3675847-21-a.darwish@linutronix.de>
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

