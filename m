Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0761C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9614B206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dc7urap3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fBBCXzrf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732755AbgGTQbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731251AbgGTP5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:57:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B319C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 08:57:09 -0700 (PDT)
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595260628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u8dxK0yYYZ2TmdZueYqwzVlsb3EwKsvtatP/Xk9jtMk=;
        b=dc7urap3yvHuZhPsL/67K/n3FtxXJ/aPt04GyjFsl4IZJtOdPIdsLUe8pHl+n5IghMHhMV
        u8lTTWweg7jogoTmIkSCBrLHf4BS1wX7tSXtgzSS54Ns3y9qTk5k+iUX53T4GUYqXxJg6i
        MDOK6XSRvRYv5DSQ7x0r8Qer2LVigwRVM103OOXF7naomiZ2DeHFaJOkw7kXaD6ftv1DE7
        bssi8t02hE2/fimi7fMmANrX2WQdtGWj0LzuBv2RMaIN/sU1amY2Zzs+hQTk2tA4EnxDiq
        OrcwR1MiJ8vCYS3DdivOhYE4N5pWABkLzQZU5k3c3HksiSJvOrlEmGaceuoymg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595260628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u8dxK0yYYZ2TmdZueYqwzVlsb3EwKsvtatP/Xk9jtMk=;
        b=fBBCXzrf8tqAAmIAhpByHL7L93QgpN13azazim0BD4wXDwOmwejjBdArYwBrUtXwFovGqi
        UNtJT7iVFACx+lAQ==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4 20/24] iocost: Use sequence counter with associated spinlock
Date:   Mon, 20 Jul 2020 17:55:26 +0200
Message-Id: <20200720155530.1173732-21-a.darwish@linutronix.de>
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

Use the new seqcount_spinlock_t data type, which allows to associate a
spinlock with the sequence counter. This enables lockdep to verify that
the spinlock used for writer serialization is held when the write side
critical section is entered.

If lockdep is disabled this lock association is compiled out and has
neither storage size nor runtime overhead.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
---
 block/blk-iocost.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 8ac4aad66ebc..8e940c27c27c 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -406,7 +406,7 @@ struct ioc {
 	enum ioc_running		running;
 	atomic64_t			vtime_rate;
 
-	seqcount_t			period_seqcount;
+	seqcount_spinlock_t		period_seqcount;
 	u32				period_at;	/* wallclock starttime */
 	u64				period_at_vtime; /* vtime starttime */
 
@@ -873,7 +873,6 @@ static void ioc_now(struct ioc *ioc, struct ioc_now *now)
 
 static void ioc_start_period(struct ioc *ioc, struct ioc_now *now)
 {
-	lockdep_assert_held(&ioc->lock);
 	WARN_ON_ONCE(ioc->running != IOC_RUNNING);
 
 	write_seqcount_begin(&ioc->period_seqcount);
@@ -2001,7 +2000,7 @@ static int blk_iocost_init(struct request_queue *q)
 
 	ioc->running = IOC_IDLE;
 	atomic64_set(&ioc->vtime_rate, VTIME_PER_USEC);
-	seqcount_init(&ioc->period_seqcount);
+	seqcount_spinlock_init(&ioc->period_seqcount, &ioc->lock);
 	ioc->period_at = ktime_to_us(ktime_get());
 	atomic64_set(&ioc->cur_period, 0);
 	atomic_set(&ioc->hweight_gen, 0);
-- 
2.20.1

