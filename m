Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E74CC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7BB72078B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Us9wDE0w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o4p89Ldr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgIJTZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731432AbgIJPtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:49:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172DEC061359;
        Thu, 10 Sep 2020 08:08:30 -0700 (PDT)
Date:   Thu, 10 Sep 2020 15:08:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599750508;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+jjvgvg8v7X9x4JwflR3nMK+NU2SOxAmY9V8+lUvIog=;
        b=Us9wDE0wIYvubUecgDtJ3SBUydhgIo0S0Ge2e15G12wHLWyKGGsQypL82gbYOTeyDp0bEy
        fVvuyVgE4P6d1yX8+4rHP6grGToQnwz4DKkiFcV/56D3mzGzbFuMRjB9A49WCSSjkrYOZf
        JeiDcPfcXygjbG1SowPQzhlbqcOXv7xYg1brK/X5bv+5f/JifyY+KaCcFK/xlbbxixDeAq
        hkB1xZnaCIaszJXqZpVVPRfnG0HlCM4aVkJ+geyXzmkBUP1rX3F8kh/PBVlg8VL60k0drM
        NeVAmER8q+nI45lu7j2cyvCvpWkiPun2QLEgw3oqvaWADX/fTmLs7a1g/f/92Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599750508;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+jjvgvg8v7X9x4JwflR3nMK+NU2SOxAmY9V8+lUvIog=;
        b=o4p89Ldr9hqj5978rJSnSDZ91TDvcraJp8mbotMBDbTtFHcdZ9pZ1rkTYdgFUsTw3g6KfJ
        jX4Y1sM4uf+em2Cw==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] seqlock: Introduce seqcount_latch_t
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200827114044.11173-4-a.darwish@linutronix.de>
References: <20200827114044.11173-4-a.darwish@linutronix.de>
MIME-Version: 1.0
Message-ID: <159975050825.20229.5708039330860036478.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     80793c3471d90d4dc2b48deadb6413bdfe39500f
Gitweb:        https://git.kernel.org/tip/80793c3471d90d4dc2b48deadb6413bdfe39500f
Author:        Ahmed S. Darwish <a.darwish@linutronix.de>
AuthorDate:    Thu, 27 Aug 2020 13:40:39 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 10 Sep 2020 11:19:28 +02:00

seqlock: Introduce seqcount_latch_t

Latch sequence counters are a multiversion concurrency control mechanism
where the seqcount_t counter even/odd value is used to switch between
two copies of protected data. This allows the seqcount_t read path to
safely interrupt its write side critical section (e.g. from NMIs).

Initially, latch sequence counters were implemented as a single write
function above plain seqcount_t: raw_write_seqcount_latch(). The read
side was expected to use plain seqcount_t raw_read_seqcount().

A specialized latch read function, raw_read_seqcount_latch(), was later
added. It became the standardized way for latch read paths.  Due to the
dependent load, it has one read memory barrier less than the plain
seqcount_t raw_read_seqcount() API.

Only raw_write_seqcount_latch() and raw_read_seqcount_latch() should be
used with latch sequence counters. Having *unique* read and write path
APIs means that latch sequence counters are actually a data type of
their own -- just inappropriately overloading plain seqcount_t.

Introduce seqcount_latch_t. This adds type-safety and ensures that only
the correct latch-safe APIs are to be used.

Not to break bisection, let the latch APIs also accept plain seqcount_t
or seqcount_raw_spinlock_t. After converting all call sites to
seqcount_latch_t, only that new data type will be allowed.

References: 9b0fd802e8c0 ("seqcount: Add raw_write_seqcount_latch()")
References: 7fc26327b756 ("seqlock: Introduce raw_read_seqcount_latch()")
References: aadd6e5caaac ("time/sched_clock: Use raw_read_seqcount_latch()")
Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200827114044.11173-4-a.darwish@linutronix.de
---
 Documentation/locking/seqlock.rst |  18 +++++-
 include/linux/seqlock.h           | 104 ++++++++++++++++++++---------
 2 files changed, 91 insertions(+), 31 deletions(-)

diff --git a/Documentation/locking/seqlock.rst b/Documentation/locking/seqlock.rst
index 62c5ad9..a334b58 100644
--- a/Documentation/locking/seqlock.rst
+++ b/Documentation/locking/seqlock.rst
@@ -139,6 +139,24 @@ with the associated LOCKTYPE lock acquired.
 
 Read path: same as in :ref:`seqcount_t`.
 
+
+.. _seqcount_latch_t:
+
+Latch sequence counters (``seqcount_latch_t``)
+----------------------------------------------
+
+Latch sequence counters are a multiversion concurrency control mechanism
+where the embedded seqcount_t counter even/odd value is used to switch
+between two copies of protected data. This allows the sequence counter
+read path to safely interrupt its own write side critical section.
+
+Use seqcount_latch_t when the write side sections cannot be protected
+from interruption by readers. This is typically the case when the read
+side can be invoked from NMI handlers.
+
+Check `raw_write_seqcount_latch()` for more information.
+
+
 .. _seqlock_t:
 
 Sequential locks (``seqlock_t``)
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 300cbf3..88b917d 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -587,34 +587,76 @@ static inline void write_seqcount_t_invalidate(seqcount_t *s)
 	kcsan_nestable_atomic_end();
 }
 
-/**
- * raw_read_seqcount_latch() - pick even/odd seqcount_t latch data copy
- * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
+/*
+ * Latch sequence counters (seqcount_latch_t)
  *
- * Use seqcount_t latching to switch between two storage places protected
- * by a sequence counter. Doing so allows having interruptible, preemptible,
- * seqcount_t write side critical sections.
+ * A sequence counter variant where the counter even/odd value is used to
+ * switch between two copies of protected data. This allows the read path,
+ * typically NMIs, to safely interrupt the write side critical section.
  *
- * Check raw_write_seqcount_latch() for more details and a full reader and
- * writer usage example.
+ * As the write sections are fully preemptible, no special handling for
+ * PREEMPT_RT is needed.
+ */
+typedef struct {
+	seqcount_t seqcount;
+} seqcount_latch_t;
+
+/**
+ * SEQCNT_LATCH_ZERO() - static initializer for seqcount_latch_t
+ * @seq_name: Name of the seqcount_latch_t instance
+ */
+#define SEQCNT_LATCH_ZERO(seq_name) {					\
+	.seqcount		= SEQCNT_ZERO(seq_name.seqcount),	\
+}
+
+/**
+ * seqcount_latch_init() - runtime initializer for seqcount_latch_t
+ * @s: Pointer to the seqcount_latch_t instance
+ */
+static inline void seqcount_latch_init(seqcount_latch_t *s)
+{
+	seqcount_init(&s->seqcount);
+}
+
+/**
+ * raw_read_seqcount_latch() - pick even/odd latch data copy
+ * @s: Pointer to seqcount_t, seqcount_raw_spinlock_t, or seqcount_latch_t
+ *
+ * See raw_write_seqcount_latch() for details and a full reader/writer
+ * usage example.
  *
  * Return: sequence counter raw value. Use the lowest bit as an index for
- * picking which data copy to read. The full counter value must then be
- * checked with read_seqcount_retry().
+ * picking which data copy to read. The full counter must then be checked
+ * with read_seqcount_latch_retry().
  */
-#define raw_read_seqcount_latch(s)					\
-	raw_read_seqcount_t_latch(__seqcount_ptr(s))
+#define raw_read_seqcount_latch(s)						\
+({										\
+	/*									\
+	 * Pairs with the first smp_wmb() in raw_write_seqcount_latch().	\
+	 * Due to the dependent load, a full smp_rmb() is not needed.		\
+	 */									\
+	_Generic(*(s),								\
+		 seqcount_t:		  READ_ONCE(((seqcount_t *)s)->sequence),			\
+		 seqcount_raw_spinlock_t: READ_ONCE(((seqcount_raw_spinlock_t *)s)->seqcount.sequence),	\
+		 seqcount_latch_t:	  READ_ONCE(((seqcount_latch_t *)s)->seqcount.sequence));	\
+})
 
-static inline int raw_read_seqcount_t_latch(seqcount_t *s)
+/**
+ * read_seqcount_latch_retry() - end a seqcount_latch_t read section
+ * @s:		Pointer to seqcount_latch_t
+ * @start:	count, from raw_read_seqcount_latch()
+ *
+ * Return: true if a read section retry is required, else false
+ */
+static inline int
+read_seqcount_latch_retry(const seqcount_latch_t *s, unsigned start)
 {
-	/* Pairs with the first smp_wmb() in raw_write_seqcount_latch() */
-	int seq = READ_ONCE(s->sequence); /* ^^^ */
-	return seq;
+	return read_seqcount_retry(&s->seqcount, start);
 }
 
 /**
- * raw_write_seqcount_latch() - redirect readers to even/odd copy
- * @s: Pointer to seqcount_t or any of the seqcount_locktype_t variants
+ * raw_write_seqcount_latch() - redirect latch readers to even/odd copy
+ * @s: Pointer to seqcount_t, seqcount_raw_spinlock_t, or seqcount_latch_t
  *
  * The latch technique is a multiversion concurrency control method that allows
  * queries during non-atomic modifications. If you can guarantee queries never
@@ -633,7 +675,7 @@ static inline int raw_read_seqcount_t_latch(seqcount_t *s)
  * The basic form is a data structure like::
  *
  *	struct latch_struct {
- *		seqcount_t		seq;
+ *		seqcount_latch_t	seq;
  *		struct data_struct	data[2];
  *	};
  *
@@ -643,13 +685,13 @@ static inline int raw_read_seqcount_t_latch(seqcount_t *s)
  *	void latch_modify(struct latch_struct *latch, ...)
  *	{
  *		smp_wmb();	// Ensure that the last data[1] update is visible
- *		latch->seq++;
+ *		latch->seq.sequence++;
  *		smp_wmb();	// Ensure that the seqcount update is visible
  *
  *		modify(latch->data[0], ...);
  *
  *		smp_wmb();	// Ensure that the data[0] update is visible
- *		latch->seq++;
+ *		latch->seq.sequence++;
  *		smp_wmb();	// Ensure that the seqcount update is visible
  *
  *		modify(latch->data[1], ...);
@@ -668,8 +710,8 @@ static inline int raw_read_seqcount_t_latch(seqcount_t *s)
  *			idx = seq & 0x01;
  *			entry = data_query(latch->data[idx], ...);
  *
- *		// read_seqcount_retry() includes needed smp_rmb()
- *		} while (read_seqcount_retry(&latch->seq, seq));
+ *		// This includes needed smp_rmb()
+ *		} while (read_seqcount_latch_retry(&latch->seq, seq));
  *
  *		return entry;
  *	}
@@ -693,14 +735,14 @@ static inline int raw_read_seqcount_t_latch(seqcount_t *s)
  *	When data is a dynamic data structure; one should use regular RCU
  *	patterns to manage the lifetimes of the objects within.
  */
-#define raw_write_seqcount_latch(s)					\
-	raw_write_seqcount_t_latch(__seqcount_ptr(s))
-
-static inline void raw_write_seqcount_t_latch(seqcount_t *s)
-{
-       smp_wmb();      /* prior stores before incrementing "sequence" */
-       s->sequence++;
-       smp_wmb();      /* increment "sequence" before following stores */
+#define raw_write_seqcount_latch(s)						\
+{										\
+       smp_wmb();      /* prior stores before incrementing "sequence" */	\
+       _Generic(*(s),								\
+		seqcount_t:		((seqcount_t *)s)->sequence++,		\
+		seqcount_raw_spinlock_t:((seqcount_raw_spinlock_t *)s)->seqcount.sequence++, \
+		seqcount_latch_t:	((seqcount_latch_t *)s)->seqcount.sequence++); \
+       smp_wmb();      /* increment "sequence" before following stores */	\
 }
 
 /*
