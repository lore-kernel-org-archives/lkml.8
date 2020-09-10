Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66CFC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8186D21556
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VMz6dL4y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wwB99Isc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgIJT0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730408AbgIJPs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:48:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772ECC061357;
        Thu, 10 Sep 2020 08:08:29 -0700 (PDT)
Date:   Thu, 10 Sep 2020 15:08:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599750508;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L0m5hkB+ccYH+x0REmVy1EbpacF/uWU6RknxT4dz2eE=;
        b=VMz6dL4yUiRiwUrxthpgSI5eAS1bzOnTA9DTFdL8ZV6ImIbQQh3RbFK9FhQM4FlOpqJfMK
        pZzcPO3U3Mjt1cGe9TREoX8fPdd9Zs21VMowg3EPtgRHCB5Tncf/yAAeA8DPJFtigrFo3R
        FELoOJxNQivl3UI5W0ly/oMY2bOriIfMRo5uVMkLXI1Ycb49XcsHeAuTZ8qPiLPHl6jQE4
        v2BuPFw3ZUWyDeepVf3e9fog4eQf0BfZIbw88nDg9N+S8DEhlHdc+2w4Xff/Z+wmMGnUSr
        vFivSpI9NKo/R/8QFZaciclCSs4U9relzbCoVth+fArJ0JULxev3S6H/rVuqPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599750508;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L0m5hkB+ccYH+x0REmVy1EbpacF/uWU6RknxT4dz2eE=;
        b=wwB99IscBcsPFeUbKjxInZFJd2XZmmWU+4G8MG+3lq181I1M5i2fZKWOzo1yhfa2eB5K7B
        wl+UVK1dOE6viOBA==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] timekeeping: Use seqcount_latch_t
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200827114044.11173-6-a.darwish@linutronix.de>
References: <20200827114044.11173-6-a.darwish@linutronix.de>
MIME-Version: 1.0
Message-ID: <159975050740.20229.1073373223572014594.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     249d053835320cb3e7c00066cf085a6ba9b1f126
Gitweb:        https://git.kernel.org/tip/249d053835320cb3e7c00066cf085a6ba9b=
1f126
Author:        Ahmed S. Darwish <a.darwish@linutronix.de>
AuthorDate:    Thu, 27 Aug 2020 13:40:41 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 10 Sep 2020 11:19:29 +02:00

timekeeping: Use seqcount_latch_t

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
be used. seqcount_LOCKTYPE_t's raison d'=C3=AAtre -- verifying that the
seqcount_t writer serialization lock is held -- cannot thus be done.

References: 0c3351d451ae ("seqlock: Use raw_ prefix instead of _no_lockdep")
References: 55f3560df975 ("seqlock: Extend seqcount API with associated locks=
")
Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200827114044.11173-6-a.darwish@linutronix.de
---
 kernel/time/timekeeping.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 4c47f38..999c981 100644
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
=20
@@ -81,13 +81,13 @@ static struct clocksource dummy_clock =3D {
 };
=20
 static struct tk_fast tk_fast_mono ____cacheline_aligned =3D {
-	.seq     =3D SEQCNT_RAW_SPINLOCK_ZERO(tk_fast_mono.seq, &timekeeper_lock),
+	.seq     =3D SEQCNT_LATCH_ZERO(tk_fast_mono.seq),
 	.base[0] =3D { .clock =3D &dummy_clock, },
 	.base[1] =3D { .clock =3D &dummy_clock, },
 };
=20
 static struct tk_fast tk_fast_raw  ____cacheline_aligned =3D {
-	.seq     =3D SEQCNT_RAW_SPINLOCK_ZERO(tk_fast_raw.seq, &timekeeper_lock),
+	.seq     =3D SEQCNT_LATCH_ZERO(tk_fast_raw.seq),
 	.base[0] =3D { .clock =3D &dummy_clock, },
 	.base[1] =3D { .clock =3D &dummy_clock, },
 };
@@ -467,7 +467,7 @@ static __always_inline u64 __ktime_get_fast_ns(struct tk_=
fast *tkf)
 					tk_clock_read(tkr),
 					tkr->cycle_last,
 					tkr->mask));
-	} while (read_seqcount_retry(&tkf->seq, seq));
+	} while (read_seqcount_latch_retry(&tkf->seq, seq));
=20
 	return now;
 }
@@ -533,7 +533,7 @@ static __always_inline u64 __ktime_get_real_fast_ns(struc=
t tk_fast *tkf)
 					tk_clock_read(tkr),
 					tkr->cycle_last,
 					tkr->mask));
-	} while (read_seqcount_retry(&tkf->seq, seq));
+	} while (read_seqcount_latch_retry(&tkf->seq, seq));
=20
 	return now;
 }
