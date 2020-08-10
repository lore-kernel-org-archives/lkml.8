Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C4FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 09:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE100206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 09:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TOqxMiqr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="seX6A356"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgHJJyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 05:54:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50114 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgHJJyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 05:54:33 -0400
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597053270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OwTf2rcMfOzqkyJabkT5LAdFYDC9N6p5znlTc4VlJfo=;
        b=TOqxMiqrdBOYvVJCtkD1vuf1GzOtVkMyfS9IjcH1oFq8FD7mTb8YdAQPgwsOLjg6tIk0eQ
        gzyISfEYnO4ZlpOuWVoH4WKQyP6XGoqKq/YqoqsH0NLsPVi4NgkqZS1HKTuFZxTSRcgqzy
        8ZPLeGb0g4OGd4GmEbPO9qJ9MEDGWI2MfWsHUwky0tuHd1BeRHlVlvyTri/J3fb/4WB1qd
        ZdoS851886IFzE7mcRRFBZqX/gczYIeN7cGYtj5v8B0Wp4NxnBfHiQAt6UdweByaUWtvCY
        lbOH6CLRgiDWa4h6VmfvvXF/TmSKvM61zWdNOTNK652+11ZVI8Wc04jSEISHRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597053270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OwTf2rcMfOzqkyJabkT5LAdFYDC9N6p5znlTc4VlJfo=;
        b=seX6A356Ojp1aDK+1HrbrYb+bpzAH8XIC2z/ZK1v4vA5qBw96z/S27tPrEODaCksMDwSpr
        0urQ3T89eHokGSDg==
To:     gregkh@linuxfoundation.org
Cc:     a.darwish@linutronix.de, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, linux@roeck-us.net, mingo@redhat.com,
        paulmck@kernel.org, peterz@infradead.org, rostedt@goodmis.org,
        tglx@linutronix.de, will@kernel.org
Subject: [PATCH] Revert "seqlock: lockdep assert non-preemptibility on seqcount_t write"
Date:   Mon, 10 Aug 2020 11:54:28 +0200
Message-Id: <20200810095428.2602276-1-a.darwish@linutronix.de>
In-Reply-To: <20200810085954.GA1591892@kroah.com>
References: <20200810085954.GA1591892@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 859247d39fb008ea812e8f0c398a58a20c12899e.

Current implementation of lockdep_assert_preemption_disabled() uses
per-CPU variables, which was done to untangle the existing
seqlock.h<=>sched.h 'current->' task_struct circular dependency.

Using per-CPU variables did not fully untangle the dependency for
various non-x86 architectures though, resulting in multiple broken
builds. For the affected architectures, raw_smp_processor_id() led
back to 'current->', thus having the original seqlock.h<=>sched.h
dependency in full-effect.

For now, revert adding lockdep_assert_preemption_disabled() to
seqlock.h.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lkml.kernel.org/r/20200808232122.GA176509@roeck-us.net
Link: https://lkml.kernel.org/r/20200810085954.GA1591892@kroah.com
References: Commit a21ee6055c30 ("lockdep: Change hardirq{s_enabled,_context} to per-cpu variables")
Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---

Notes:
    My apologies for the mess on this one :-(

 include/linux/seqlock.h | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 54bc20496392..e885702d8b82 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -266,12 +266,6 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
 	kcsan_nestable_atomic_end();
 }
 
-static inline void __write_seqcount_begin_nested(seqcount_t *s, int subclass)
-{
-	raw_write_seqcount_begin(s);
-	seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
-}
-
 /**
  * write_seqcount_begin_nested() - start a seqcount_t write section with
  *                                 custom lockdep nesting level
@@ -282,19 +276,8 @@ static inline void __write_seqcount_begin_nested(seqcount_t *s, int subclass)
  */
 static inline void write_seqcount_begin_nested(seqcount_t *s, int subclass)
 {
-	lockdep_assert_preemption_disabled();
-	__write_seqcount_begin_nested(s, subclass);
-}
-
-/*
- * A write_seqcount_begin() variant w/o lockdep non-preemptibility checks.
- *
- * Use for internal seqlock.h code where it's known that preemption is
- * already disabled. For example, seqlock_t write side functions.
- */
-static inline void __write_seqcount_begin(seqcount_t *s)
-{
-	__write_seqcount_begin_nested(s, 0);
+	raw_write_seqcount_begin(s);
+	seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
 }
 
 /**
@@ -592,7 +575,7 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 static inline void write_seqlock(seqlock_t *sl)
 {
 	spin_lock(&sl->lock);
-	__write_seqcount_begin(&sl->seqcount);
+	write_seqcount_begin(&sl->seqcount);
 }
 
 /**
@@ -618,7 +601,7 @@ static inline void write_sequnlock(seqlock_t *sl)
 static inline void write_seqlock_bh(seqlock_t *sl)
 {
 	spin_lock_bh(&sl->lock);
-	__write_seqcount_begin(&sl->seqcount);
+	write_seqcount_begin(&sl->seqcount);
 }
 
 /**
@@ -645,7 +628,7 @@ static inline void write_sequnlock_bh(seqlock_t *sl)
 static inline void write_seqlock_irq(seqlock_t *sl)
 {
 	spin_lock_irq(&sl->lock);
-	__write_seqcount_begin(&sl->seqcount);
+	write_seqcount_begin(&sl->seqcount);
 }
 
 /**
@@ -666,7 +649,7 @@ static inline unsigned long __write_seqlock_irqsave(seqlock_t *sl)
 	unsigned long flags;
 
 	spin_lock_irqsave(&sl->lock, flags);
-	__write_seqcount_begin(&sl->seqcount);
+	write_seqcount_begin(&sl->seqcount);
 	return flags;
 }
 
-- 
2.28.0

