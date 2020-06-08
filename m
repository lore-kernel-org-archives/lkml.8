Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB7EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 00:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42DEB2075A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 00:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgFHA7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 20:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729074AbgFHA7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 20:59:03 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97276C08C5C3
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 17:59:03 -0700 (PDT)
Received: from [5.158.153.53] (helo=debian-buster-darwi.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <a.darwish@linutronix.de>)
        id 1ji67u-00011Q-Pp; Mon, 08 Jun 2020 02:58:58 +0200
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH v2 18/18] hrtimer: Use sequence counter with associated raw spinlock
Date:   Mon,  8 Jun 2020 02:57:29 +0200
Message-Id: <20200608005729.1874024-19-a.darwish@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200608005729.1874024-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200608005729.1874024-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
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

