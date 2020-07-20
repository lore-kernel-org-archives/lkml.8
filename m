Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C1FC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1131206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cVVTSp/y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KkPA6Rbw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731723AbgGTPzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:55:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58700 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731225AbgGTPzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:55:43 -0400
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595260541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=osTtrNUr4OHk/B4zAgkYVq1r5kpsvFsCr0rPGrUYJ3o=;
        b=cVVTSp/yxcUkuUT49JWGd0r+9986GyT5GOZQD6zLLS7JkcAKnHGz9oYf1FP67YJ6amNKfx
        wj/IxFAlJW4QYey51hJ5jShODthCuI4yn7Ofmpak9lFjDU8+T/nFn9//xthonl2FzFRNJf
        Z+8q17yC3OcApu1DrgwhcLWm5006nD7evxF49tPLb9jRZFKmRya/29bFsVBRWyiwVwbfvb
        6XnSj358njN6AJgxEqxozYLM/J4z/fS9zIuXpBlWwBXJB2NFRDt07mueqs1sR441EGYrIy
        tA8QYdZP4XinaOsRkb2BYdlt1OTM+6AudDclRB5OVSllsXRmChIyWLehTXh4hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595260541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=osTtrNUr4OHk/B4zAgkYVq1r5kpsvFsCr0rPGrUYJ3o=;
        b=KkPA6RbwZMRD0z7JCvjKoZ5vai1cuanX0ola+cD+7oYDkJwTyjNpjUeA+gHtGdEIHNyfdu
        u6bZViCZw/6soPAA==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH v4 02/24] seqlock: Properly format kernel-doc code samples
Date:   Mon, 20 Jul 2020 17:55:08 +0200
Message-Id: <20200720155530.1173732-3-a.darwish@linutronix.de>
In-Reply-To: <20200720155530.1173732-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200720155530.1173732-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align the code samples and note sections inside kernel-doc comments with
tabs. This way they can be properly parsed and rendered by Sphinx. It
also makes the code samples easier to read from text editors.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 include/linux/seqlock.h | 108 +++++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 52 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 299d68f10325..6c4f68ef1393 100644
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
  *
- *       An iteration might start in data[0] and get suspended long enough
- *       to miss an entire modification sequence, once it resumes it might
- *       observe the new entry.
+ *	The non-requirement for atomic modifications does _NOT_ include
+ *	the publishing of new entries in the case where data is a dynamic
+ *	data structure.
  *
- * NOTE: When data is a dynamic data structure; one should use regular RCU
- *       patterns to manage the lifetimes of the objects within.
+ *	An iteration might start in data[0] and get suspended long enough
+ *	to miss an entire modification sequence, once it resumes it might
+ *	observe the new entry.
+ *
+ * NOTE:
+ *
+ *	When data is a dynamic data structure; one should use regular RCU
+ *	patterns to manage the lifetimes of the objects within.
  */
 static inline void raw_write_seqcount_latch(seqcount_t *s)
 {
-- 
2.20.1

