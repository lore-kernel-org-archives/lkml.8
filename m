Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA63C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFE3F20FC3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OAbyTnFc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pAmBXemI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgG2OfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:35:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42966 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgG2Odd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:33:33 -0400
Date:   Wed, 29 Jul 2020 14:33:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596033210;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4MHMRc9J3xW26AE/zZ9xnPxPhKLboMX+mZi+E25DpdE=;
        b=OAbyTnFcabA0nU2pjYta+cGV7X1T9bTOerKUGg9nFLz0TTCTE41hGwwyS5lzaLPw/0Uwjl
        1La3/LCqgMquj+fnLUT3OQygrYNT1aMF/EomnFh8wFsgVSzA3Bs3bZvGzJG1VjVlEhPPQ5
        /KrymTvJ31LB3kZDonyMOUKwAdekYABwv4JcAVweGHgvSFWtItdJ0SOv7Spie0Oq4PZGAD
        jmaJhTdMJxl8wCKrOhhndCbBwtR5IG/shADnnT6IMtWJVRwhY2vl/EnnFREOxATZ+TknVv
        +PEEH9ow/0X9yf7keOpooTHIJUAnPPiXqGpL7SvME4chKIkfTiB7eRofawJL9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596033210;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4MHMRc9J3xW26AE/zZ9xnPxPhKLboMX+mZi+E25DpdE=;
        b=pAmBXemI180jeWDe+YdexoQigl1dqKgF2IjAt3wuT8zjqFK7RdoS0v3mTD/3q0m17TVNT5
        dCLybZnzWvjbn/Cg==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] iocost: Use sequence counter with associated spinlock
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Wagner <dwagner@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200720155530.1173732-21-a.darwish@linutronix.de>
References: <20200720155530.1173732-21-a.darwish@linutronix.de>
MIME-Version: 1.0
Message-ID: <159603320985.4006.12938811827876475485.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     67b7b641ca69cafb467f7560316b09b8ff0fa5c9
Gitweb:        https://git.kernel.org/tip/67b7b641ca69cafb467f7560316b09b8ff0fa5c9
Author:        Ahmed S. Darwish <a.darwish@linutronix.de>
AuthorDate:    Mon, 20 Jul 2020 17:55:26 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Jul 2020 16:14:28 +02:00

iocost: Use sequence counter with associated spinlock

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Link: https://lkml.kernel.org/r/20200720155530.1173732-21-a.darwish@linutronix.de
---
 block/blk-iocost.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 8ac4aad..8e940c2 100644
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
