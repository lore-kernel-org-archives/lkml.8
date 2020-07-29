Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BE7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 249BA20809
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WjjA4ta8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sHbeNGDv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgG2Odq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:33:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42978 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgG2Odk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:33:40 -0400
Date:   Wed, 29 Jul 2020 14:33:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596033218;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d+R7r+ARNRtKTiPALl/ABkNglcqeAzt55FscC1cm4cM=;
        b=WjjA4ta84rjnSW3/jVwvUGaT4DAIbu1lNhHHrN5Ap/UFbKLWlIWfWT34NEuzOjB8HxkTte
        3Kv0fyUUw+347E8p07uPU7uIjiD1sZtaditXdUi24dwQC6c13UGQvsMDMJW4vC3GfxUT5I
        mHPytKCbW245DsOr1WWX6YoV/A76CFKdno2C0ry+BUkqHAxQngX9oiJ8RNOKXErLyLsPZz
        jIrdxYSD5CyBZZWFGR4c3AWw6j1WM7rtB1mT1X971A/1WrR6s3MpuCoohjKLo8Ji3bHUcb
        wPeZw0VYFOlwRaXZqJdKcK5lx3wQ9vRfUZLCEWtOruqO0XLo4uxTjSgLWj+ocQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596033218;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d+R7r+ARNRtKTiPALl/ABkNglcqeAzt55FscC1cm4cM=;
        b=sHbeNGDvnjDk/0RQLjNAyRdWz1YO1oNL2Yf3bW1nFIZS1KH5tLCHsCCoUY57OgMFAmZ+iD
        VfI8EJKiDf0ChZAA==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] seqlock: lockdep assert non-preemptibility on
 seqcount_t write
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200720155530.1173732-9-a.darwish@linutronix.de>
References: <20200720155530.1173732-9-a.darwish@linutronix.de>
MIME-Version: 1.0
Message-ID: <159603321790.4006.4488497808280914537.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     859247d39fb008ea812e8f0c398a58a20c12899e
Gitweb:        https://git.kernel.org/tip/859247d39fb008ea812e8f0c398a58a20c12899e
Author:        Ahmed S. Darwish <a.darwish@linutronix.de>
AuthorDate:    Mon, 20 Jul 2020 17:55:14 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Jul 2020 16:14:24 +02:00

seqlock: lockdep assert non-preemptibility on seqcount_t write

Preemption must be disabled before entering a sequence count write side
critical section.  Failing to do so, the seqcount read side can preempt
the write side section and spin for the entire scheduler tick.  If that
reader belongs to a real-time scheduling class, it can spin forever and
the kernel will livelock.

Assert through lockdep that preemption is disabled for seqcount writers.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200720155530.1173732-9-a.darwish@linutronix.de
---
 include/linux/seqlock.h | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index e885702..54bc204 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -266,6 +266,12 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
 	kcsan_nestable_atomic_end();
 }
 
+static inline void __write_seqcount_begin_nested(seqcount_t *s, int subclass)
+{
+	raw_write_seqcount_begin(s);
+	seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
+}
+
 /**
  * write_seqcount_begin_nested() - start a seqcount_t write section with
  *                                 custom lockdep nesting level
@@ -276,8 +282,19 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
  */
 static inline void write_seqcount_begin_nested(seqcount_t *s, int subclass)
 {
-	raw_write_seqcount_begin(s);
-	seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
+	lockdep_assert_preemption_disabled();
+	__write_seqcount_begin_nested(s, subclass);
+}
+
+/*
+ * A write_seqcount_begin() variant w/o lockdep non-preemptibility checks.
+ *
+ * Use for internal seqlock.h code where it's known that preemption is
+ * already disabled. For example, seqlock_t write side functions.
+ */
+static inline void __write_seqcount_begin(seqcount_t *s)
+{
+	__write_seqcount_begin_nested(s, 0);
 }
 
 /**
@@ -575,7 +592,7 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 static inline void write_seqlock(seqlock_t *sl)
 {
 	spin_lock(&sl->lock);
-	write_seqcount_begin(&sl->seqcount);
+	__write_seqcount_begin(&sl->seqcount);
 }
 
 /**
@@ -601,7 +618,7 @@ static inline void write_sequnlock(seqlock_t *sl)
 static inline void write_seqlock_bh(seqlock_t *sl)
 {
 	spin_lock_bh(&sl->lock);
-	write_seqcount_begin(&sl->seqcount);
+	__write_seqcount_begin(&sl->seqcount);
 }
 
 /**
@@ -628,7 +645,7 @@ static inline void write_sequnlock_bh(seqlock_t *sl)
 static inline void write_seqlock_irq(seqlock_t *sl)
 {
 	spin_lock_irq(&sl->lock);
-	write_seqcount_begin(&sl->seqcount);
+	__write_seqcount_begin(&sl->seqcount);
 }
 
 /**
@@ -649,7 +666,7 @@ static inline unsigned long __write_seqlock_irqsave(seqlock_t *sl)
 	unsigned long flags;
 
 	spin_lock_irqsave(&sl->lock, flags);
-	write_seqcount_begin(&sl->seqcount);
+	__write_seqcount_begin(&sl->seqcount);
 	return flags;
 }
 
