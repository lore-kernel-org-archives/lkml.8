Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18A2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BC42206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="USV+kt8F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cn+fhZYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgF3FpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 01:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgF3FpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 01:45:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F80C061755;
        Mon, 29 Jun 2020 22:45:05 -0700 (PDT)
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593495902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7E4j18x46zQTsfHze4W8jizD6J0WqMpKwXs6KhlFqs4=;
        b=USV+kt8Ftucg+tg76yTLkDX4rrxGyHj7pXcbxZH/MRkqmtg/Kpsm7r4xQ78CTZsJzc9p/f
        wf+D6RCzSKZ/mIv7Fczep/ISIzdwARJu1+pyfK1uJn8CEmixfOv+oicru9ddyQbKd/HLWi
        scTzN6uJlNwd5oMlaBlgGimOZ+0h66ioBIWDiQxZLy4yCZXGdfx5jJmP+OxR5T06a25zYa
        wDCHWY0mjUTCa48KkdsH85BZCRy6dYGzayxoCmTc4iOAbQk0juWO0IQ4gtHR+zEWGgf71t
        54wWis8UTd9nPCnv1vPxUUUdCUMZGFrm8UWgsC/HAI6lm3yKM67iaGbj3yBPJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593495902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7E4j18x46zQTsfHze4W8jizD6J0WqMpKwXs6KhlFqs4=;
        b=Cn+fhZYJT7uxo0Lbd8GLUr9tb17T+QIL4agkwV4s0Edo1VQktNNy4c6KeM6J7T7ApxFPlE
        mKc2ufuAfxD8eHDw==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH v3 02/20] seqlock: Properly format kernel-doc code samples
Date:   Tue, 30 Jun 2020 07:44:34 +0200
Message-Id: <20200630054452.3675847-3-a.darwish@linutronix.de>
In-Reply-To: <20200630054452.3675847-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200630054452.3675847-1-a.darwish@linutronix.de>
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
 include/linux/seqlock.h | 82 +++++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 39 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index e54ff48e87f8..d3bba59eb4df 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -256,7 +256,7 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
  *
  * This can be used to provide an ordering guarantee instead of the
  * usual consistency guarantee. It is one wmb cheaper, because we can
- * collapse the two back-to-back wmb()s.
+ * collapse the two back-to-back wmb()s::
  *
  * Note that writes surrounding the barrier should be declared atomic (e.g.
  * via WRITE_ONCE): a) to ensure the writes become visible to other threads
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

