Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AE3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2B0420672
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rvJu64eY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3GnXUT0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbgF3FqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 01:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729811AbgF3FqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 01:46:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545A4C061755;
        Mon, 29 Jun 2020 22:46:11 -0700 (PDT)
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593495970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xAbB9oKLEGHYN+w+z0ndpRUVlVFavwl3/3bbk6nkTI4=;
        b=rvJu64eY7bS9Ir5/N1LjQAVQ+/Gc9LNl7dorDdUgfJ6rNE76pkrh8yBaGyMhMHUJxHxQS3
        PuFvFbljhuqZ6545iZTwIpoYPqMS6cDFZonmj8Y5Ksndbnx9FYokvglbh8tCN5jb9Mf5Rh
        r0wHtUcZChUAcCLk+McJrQa8F1RhsIzyn4Tkulo1KFDtfIXd2ZlBgnjiAGf4bUbgIxuT3p
        6IYvDV/ifvRjjVimphEALE6OpqHwqcIXo+j3aLJ+RwsDgi8VYCxNIuOP9WEttxOczzyOzI
        9o8hhieha3cFaC+eJE7fcFddc9wvGhITO01/I0oG5QN51Ziwv5pNrCdzJqHKBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593495970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xAbB9oKLEGHYN+w+z0ndpRUVlVFavwl3/3bbk6nkTI4=;
        b=3GnXUT0NYEOA76vJPT7kAU6dbj67yPQUf13YdD2IP3Zlpm1MaZJHQahoCp1iP6wKoJGsW8
        /pAHwcMnUFN2EVBA==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Song Liu <song@kernel.org>, linux-raid@vger.kernel.org
Subject: [PATCH v3 15/20] raid5: Use sequence counter with associated spinlock
Date:   Tue, 30 Jun 2020 07:44:47 +0200
Message-Id: <20200630054452.3675847-16-a.darwish@linutronix.de>
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

