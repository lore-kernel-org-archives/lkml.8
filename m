Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A46C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93D1F2177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TX1+1wja";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FXAOT/OD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgH0PMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:12:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38220 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbgH0Lkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:40:51 -0400
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598528448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=26R9zahhoyqsZTU4t3ThQWnrhdQZn+07MTILm+kfM9s=;
        b=TX1+1wjanjrE/bOMnAQJie2vzXwTv8I0mkZYGbi/xU31jqm7ZFLfRE5JIId1euJZdx1fBC
        6D3SFXifQe3Ah1JhIdhmk7X43ZLaC5aYb8qe4sqHU/Uwg/IiMPlNn/1B4OoxerZuP8VlO5
        EoFwQ9a7hRIF5bvQTQ9ciobIPaIS2QKmB3VTNcgzlxlKr/QZu/bY4ILbzmRXydf+vsAAeo
        tJWMORL7SJlZyv4VAHjp5Lx/jcd/DbBO/Z4jF5zAA6kp6A+sj2M60omDGkj4T7dILH/5Th
        rh/2ZCngAaSjLIMxKU0XoB1k0A99UCf46JEUMj5Pc+zqzvLgGAwPkvu+67ApdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598528448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=26R9zahhoyqsZTU4t3ThQWnrhdQZn+07MTILm+kfM9s=;
        b=FXAOT/ODjYG0Jo2PimtDdINR90AKk8xVV8aVgquY793/G71eFay0QrpsWD+Oi8gUZDP9xw
        I9O81Vd9Q6hGHOAw==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH v1 5/8] timekeeping: Use seqcount_latch_t
Date:   Thu, 27 Aug 2020 13:40:41 +0200
Message-Id: <20200827114044.11173-6-a.darwish@linutronix.de>
In-Reply-To: <20200827114044.11173-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200827114044.11173-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Latch sequence counters are a multiversion concurrency control mechanism
where the seqcount_t counter even/odd value is used to switch between
two data storage copies. This allows the seqcount_t read path to safely
interrupt its write side critical section (e.g. from NMIs).

Initially, latch sequence counters were implemented as a single write
function, raw_write_seqcount_latch(), above plain seqcount_t. The read
path was expected to use plain seqcount_t raw_read_seqcount().

A specialized read function was later added, raw_read_seqcount_latch(),
and became the standardized way for latch read paths. Having unique read
and write APIs meant that latch sequence counters are basically a data
type of their own -- just inappropriately overloading plain seqcount_t.
The seqcount_latch_t data type was thus introduced at seqlock.h.

Use that new data type instead of seqcount_raw_spinlock_t. This ensures
that only latch-safe APIs are to be used with the sequence counter.

Note that the use of seqcount_raw_spinlock_t was not very useful in the
first place. Only the "raw_" subset of seqcount_t APIs were used at
timekeeping.c. This subset was created for contexts where lockdep cannot
be used. seqcount_LOCKTYPE_t's raison d'être -- verifying that the
seqcount_t writer serialization lock is held -- cannot thus be done.

References: 0c3351d451ae ("seqlock: Use raw_ prefix instead of _no_lockdep")
References: 55f3560df975 ("seqlock: Extend seqcount API with associated locks")
Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 kernel/time/timekeeping.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 4c47f388a83f..999c981ae766 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -64,7 +64,7 @@ static struct timekeeper shadow_timekeeper;
  * See @update_fast_timekeeper() below.
  */
 struct tk_fast {
-	seqcount_raw_spinlock_t	seq;
+	seqcount_latch_t	seq;
 	struct tk_read_base	base[2];
 };
 
@@ -81,13 +81,13 @@ static struct clocksource dummy_clock = {
 };
 
 static struct tk_fast tk_fast_mono ____cacheline_aligned = {
-	.seq     = SEQCNT_RAW_SPINLOCK_ZERO(tk_fast_mono.seq, &timekeeper_lock),
+	.seq     = SEQCNT_LATCH_ZERO(tk_fast_mono.seq),
 	.base[0] = { .clock = &dummy_clock, },
 	.base[1] = { .clock = &dummy_clock, },
 };
 
 static struct tk_fast tk_fast_raw  ____cacheline_aligned = {
-	.seq     = SEQCNT_RAW_SPINLOCK_ZERO(tk_fast_raw.seq, &timekeeper_lock),
+	.seq     = SEQCNT_LATCH_ZERO(tk_fast_raw.seq),
 	.base[0] = { .clock = &dummy_clock, },
 	.base[1] = { .clock = &dummy_clock, },
 };
@@ -467,7 +467,7 @@ static __always_inline u64 __ktime_get_fast_ns(struct tk_fast *tkf)
 					tk_clock_read(tkr),
 					tkr->cycle_last,
 					tkr->mask));
-	} while (read_seqcount_retry(&tkf->seq, seq));
+	} while (read_seqcount_latch_retry(&tkf->seq, seq));
 
 	return now;
 }
@@ -533,7 +533,7 @@ static __always_inline u64 __ktime_get_real_fast_ns(struct tk_fast *tkf)
 					tk_clock_read(tkr),
 					tkr->cycle_last,
 					tkr->mask));
-	} while (read_seqcount_retry(&tkf->seq, seq));
+	} while (read_seqcount_latch_retry(&tkf->seq, seq));
 
 	return now;
 }
-- 
2.28.0

