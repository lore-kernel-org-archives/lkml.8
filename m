Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BA2C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F34422C9E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OeIi67fu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e4eRxc0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgG2OeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:34:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43114 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgG2Odp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:33:45 -0400
Date:   Wed, 29 Jul 2020 14:33:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596033222;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pKZyPfylgBNuuFURrJgJg3ENrenqZcFEcbvg7YtWPWI=;
        b=OeIi67fuoc+lSXcnoltXwKKYR6HrH3FjjyyWN8vIjHOT0A/xPqBb8SvN6k+EmMeaUqzSgz
        6cvV6VzO8pVV9BlnnKAPBzRcSJdu7Qp+epKxfJQhlhRj6++1hUFXup3wgCuYXBADTa3vD0
        +sV0n9YH1iA+4gAHpHtFYhAG2fUMQv46RCypH36NVERz5KWaHg4CtICnoUUPiNgTJNEIqt
        z91n9UMJ2fK2r2Rjxq+fTgKacYINrTEWrDMLDN5u/AMCm/ftxPMDV4BgiavvtWp4ZY4/7l
        TPx7OpgulVV02W0zmFNg30ShyuIY9MxS38FiiHClfsYcypIwZgE1/yKLBv4ULQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596033222;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pKZyPfylgBNuuFURrJgJg3ENrenqZcFEcbvg7YtWPWI=;
        b=e4eRxc0dvvWzLOMgjrZStKcsr8srIy0Jg6Kh8XrF5LJkwKlT0ysFX9CnFLmDharoLFZQoa
        DazHn+9cR5VPdYCA==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] seqlock: Properly format kernel-doc code samples
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200720155530.1173732-3-a.darwish@linutronix.de>
References: <20200720155530.1173732-3-a.darwish@linutronix.de>
MIME-Version: 1.0
Message-ID: <159603322198.4006.14903341074510380226.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     15cbe67bbd3adeb4854c42713dbeaf2ff876beee
Gitweb:        https://git.kernel.org/tip/15cbe67bbd3adeb4854c42713dbeaf2ff876beee
Author:        Ahmed S. Darwish <a.darwish@linutronix.de>
AuthorDate:    Mon, 20 Jul 2020 17:55:08 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Jul 2020 16:14:23 +02:00

seqlock: Properly format kernel-doc code samples

Align the code samples and note sections inside kernel-doc comments with
tabs. This way they can be properly parsed and rendered by Sphinx. It
also makes the code samples easier to read from text editors.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200720155530.1173732-3-a.darwish@linutronix.de
---
 include/linux/seqlock.h | 108 ++++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 52 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 299d68f..6c4f68e 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -263,32 +263,32 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
  * atomically, avoiding compiler optimizations; b) to document which writes are
  * meant to propagate to the reader critical section. This is necessary because
  * neither writes before and after the barrier are enclosed in a seq-writer
- * critical section that would ensure readers are aware of ongoing writes.
+ * critical section that would ensure readers are aware of ongoing writes::
  *
- *      seqcount_t seq;
- *      bool X = true, Y = false;
+ *	seqcount_t seq;
+ *	bool X = true, Y = false;
  *
- *      void read(void)
- *      {
- *              bool x, y;
+ *	void read(void)
+ *	{
+ *		bool x, y;
  *
- *              do {
- *                      int s = read_seqcount_begin(&seq);
+ *		do {
+ *			int s = read_seqcount_begin(&seq);
  *
- *                      x = X; y = Y;
+ *			x = X; y = Y;
  *
- *              } while (read_seqcount_retry(&seq, s));
+ *		} while (read_seqcount_retry(&seq, s));
  *
- *              BUG_ON(!x && !y);
+ *		BUG_ON(!x && !y);
  *      }
  *
  *      void write(void)
  *      {
- *              WRITE_ONCE(Y, true);
+ *		WRITE_ONCE(Y, true);
  *
- *              raw_write_seqcount_barrier(seq);
+ *		raw_write_seqcount_barrier(seq);
  *
- *              WRITE_ONCE(X, false);
+ *		WRITE_ONCE(X, false);
  *      }
  */
 static inline void raw_write_seqcount_barrier(seqcount_t *s)
@@ -325,64 +325,68 @@ static inline int raw_read_seqcount_latch(seqcount_t *s)
  * Very simply put: we first modify one copy and then the other. This ensures
  * there is always one copy in a stable state, ready to give us an answer.
  *
- * The basic form is a data structure like:
+ * The basic form is a data structure like::
  *
- * struct latch_struct {
- *	seqcount_t		seq;
- *	struct data_struct	data[2];
- * };
+ *	struct latch_struct {
+ *		seqcount_t		seq;
+ *		struct data_struct	data[2];
+ *	};
  *
  * Where a modification, which is assumed to be externally serialized, does the
- * following:
+ * following::
  *
- * void latch_modify(struct latch_struct *latch, ...)
- * {
- *	smp_wmb();	<- Ensure that the last data[1] update is visible
- *	latch->seq++;
- *	smp_wmb();	<- Ensure that the seqcount update is visible
+ *	void latch_modify(struct latch_struct *latch, ...)
+ *	{
+ *		smp_wmb();	// Ensure that the last data[1] update is visible
+ *		latch->seq++;
+ *		smp_wmb();	// Ensure that the seqcount update is visible
  *
- *	modify(latch->data[0], ...);
+ *		modify(latch->data[0], ...);
  *
- *	smp_wmb();	<- Ensure that the data[0] update is visible
- *	latch->seq++;
- *	smp_wmb();	<- Ensure that the seqcount update is visible
+ *		smp_wmb();	// Ensure that the data[0] update is visible
+ *		latch->seq++;
+ *		smp_wmb();	// Ensure that the seqcount update is visible
  *
- *	modify(latch->data[1], ...);
- * }
+ *		modify(latch->data[1], ...);
+ *	}
  *
- * The query will have a form like:
+ * The query will have a form like::
  *
- * struct entry *latch_query(struct latch_struct *latch, ...)
- * {
- *	struct entry *entry;
- *	unsigned seq, idx;
+ *	struct entry *latch_query(struct latch_struct *latch, ...)
+ *	{
+ *		struct entry *entry;
+ *		unsigned seq, idx;
  *
- *	do {
- *		seq = raw_read_seqcount_latch(&latch->seq);
+ *		do {
+ *			seq = raw_read_seqcount_latch(&latch->seq);
  *
- *		idx = seq & 0x01;
- *		entry = data_query(latch->data[idx], ...);
+ *			idx = seq & 0x01;
+ *			entry = data_query(latch->data[idx], ...);
  *
- *		smp_rmb();
- *	} while (seq != latch->seq);
+ *			smp_rmb();
+ *		} while (seq != latch->seq);
  *
- *	return entry;
- * }
+ *		return entry;
+ *	}
  *
  * So during the modification, queries are first redirected to data[1]. Then we
  * modify data[0]. When that is complete, we redirect queries back to data[0]
  * and we can modify data[1].
  *
- * NOTE: The non-requirement for atomic modifications does _NOT_ include
- *       the publishing of new entries in the case where data is a dynamic
- *       data structure.
+ * NOTE:
+ *
+ *	The non-requirement for atomic modifications does _NOT_ include
+ *	the publishing of new entries in the case where data is a dynamic
+ *	data structure.
+ *
+ *	An iteration might start in data[0] and get suspended long enough
+ *	to miss an entire modification sequence, once it resumes it might
+ *	observe the new entry.
  *
- *       An iteration might start in data[0] and get suspended long enough
- *       to miss an entire modification sequence, once it resumes it might
- *       observe the new entry.
+ * NOTE:
  *
- * NOTE: When data is a dynamic data structure; one should use regular RCU
- *       patterns to manage the lifetimes of the objects within.
+ *	When data is a dynamic data structure; one should use regular RCU
+ *	patterns to manage the lifetimes of the objects within.
  */
 static inline void raw_write_seqcount_latch(seqcount_t *s)
 {
