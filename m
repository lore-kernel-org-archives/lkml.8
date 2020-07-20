Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3BAC433F7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0800A2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aE6HVWQ7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8sQVdjG9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbgGTP5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:57:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58948 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731865AbgGTP5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:57:05 -0400
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595260623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xAbB9oKLEGHYN+w+z0ndpRUVlVFavwl3/3bbk6nkTI4=;
        b=aE6HVWQ7elJ3Wu43Nx5S0EQ9uUnwoWtplV7pqe9NN1rsZuauKrP9qAmb6mHlhJ7U1sFSgw
        AxExVzSlqPCo7f2hJBEUQ9fxPD9kfIMD9fn/jzMWs+qYfqBdFwIBDMFtaR+nroor6T2IO7
        B/lq1xpYO7qfSDgiEwK/u5bUU4jAo1f4liQajoKBqfgyKSWxKOhglHIcUJDJ/uovzhkW3t
        /r/U3lkl0ScjCT828osOd2wnToGbfvCzbQjnfJFcm9G20jbVFIei/qonANgpXdfibLORrG
        LXIwwdJ69ykwevM0BHecoxt3L9lD15kOCm2dUBPivw0BpPHrBTBCvQOtdWMd2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595260623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xAbB9oKLEGHYN+w+z0ndpRUVlVFavwl3/3bbk6nkTI4=;
        b=8sQVdjG9J9NWk5nP1uFu8LkSAunXaXDWeXbROR0vV/v1xYMoVS1qTisuyD7tE97Y+Dlut3
        5SAPGx+i1aRtshCQ==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Song Liu <song@kernel.org>, linux-raid@vger.kernel.org
Subject: [PATCH v4 19/24] raid5: Use sequence counter with associated spinlock
Date:   Mon, 20 Jul 2020 17:55:25 +0200
Message-Id: <20200720155530.1173732-20-a.darwish@linutronix.de>
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
---
 drivers/md/raid5.c | 2 +-
 drivers/md/raid5.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index ab8067f9ce8c..892aefe88fa7 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6935,7 +6935,7 @@ static struct r5conf *setup_conf(struct mddev *mddev)
 	} else
 		goto abort;
 	spin_lock_init(&conf->device_lock);
-	seqcount_init(&conf->gen_lock);
+	seqcount_spinlock_init(&conf->gen_lock, &conf->device_lock);
 	mutex_init(&conf->cache_size_mutex);
 	init_waitqueue_head(&conf->wait_for_quiescent);
 	init_waitqueue_head(&conf->wait_for_stripe);
diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index f90e0704bed9..a2c9e9e9f5ac 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -589,7 +589,7 @@ struct r5conf {
 	int			prev_chunk_sectors;
 	int			prev_algo;
 	short			generation; /* increments with every reshape */
-	seqcount_t		gen_lock;	/* lock against generation changes */
+	seqcount_spinlock_t	gen_lock;	/* lock against generation changes */
 	unsigned long		reshape_checkpoint; /* Time we last updated
 						     * metadata */
 	long long		min_offset_diff; /* minimum difference between
-- 
2.20.1

