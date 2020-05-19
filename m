Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F2DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 815E020657
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgESVrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 17:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728322AbgESVrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 17:47:05 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E12C08C5C0;
        Tue, 19 May 2020 14:47:05 -0700 (PDT)
Received: from [5.158.153.53] (helo=debian-buster-darwi.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <a.darwish@linutronix.de>)
        id 1jbA4N-0002i2-AJ; Tue, 19 May 2020 23:46:39 +0200
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH v1 10/25] seqlock: Add RST directives to kernel-doc code samples and notes
Date:   Tue, 19 May 2020 23:45:32 +0200
Message-Id: <20200519214547.352050-11-a.darwish@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519214547.352050-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark all C code samples inside seqlock.h kernel-doc text with the RST
'code-block: c' directive. Sphinx won't properly format the example code
and will produce noisy text indentation warnings otherwise.

Mark all kernel-doc "NOTE" sections with the RST 'attention' directive.
Otherwise Sphinx produces "duplicate section name 'NOTE'" warnings.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/seqlock.h | 82 +++++++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 35 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 2a4af746b1da..dfec0c9c19c4 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -232,6 +232,8 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
  * usual consistency guarantee. It is one wmb cheaper, because we can
  * collapse the two back-to-back wmb()s.
  *
+ * .. code-block:: c
+ *
  *      seqcount_t seq;
  *      bool X = true, Y = false;
  *
@@ -292,62 +294,72 @@ static inline int raw_read_seqcount_latch(seqcount_t *s)
  *
  * The basic form is a data structure like:
  *
- * struct latch_struct {
- *	seqcount_t		seq;
- *	struct data_struct	data[2];
- * };
+ * .. code-block:: c
+ *
+ *	struct latch_struct {
+ *		seqcount_t		seq;
+ *		struct data_struct	data[2];
+ *	};
  *
  * Where a modification, which is assumed to be externally serialized, does the
  * following:
  *
- * void latch_modify(struct latch_struct *latch, ...)
- * {
- *	smp_wmb();	<- Ensure that the last data[1] update is visible
- *	latch->seq++;
- *	smp_wmb();	<- Ensure that the seqcount update is visible
+ * .. code-block:: c
  *
- *	modify(latch->data[0], ...);
+ *	void latch_modify(struct latch_struct *latch, ...)
+ *	{
+ *		smp_wmb();	// Ensure that the last data[1] update is visible
+ *		latch->seq++;
+ *		smp_wmb();	// Ensure that the seqcount update is visible
  *
- *	smp_wmb();	<- Ensure that the data[0] update is visible
- *	latch->seq++;
- *	smp_wmb();	<- Ensure that the seqcount update is visible
+ *		modify(latch->data[0], ...);
  *
- *	modify(latch->data[1], ...);
- * }
+ *		smp_wmb();	// Ensure that the data[0] update is visible
+ *		latch->seq++;
+ *		smp_wmb();	// Ensure that the seqcount update is visible
+ *
+ *		modify(latch->data[1], ...);
+ *	}
  *
  * The query will have a form like:
  *
- * struct entry *latch_query(struct latch_struct *latch, ...)
- * {
- *	struct entry *entry;
- *	unsigned seq, idx;
+ * .. code-block:: c
  *
- *	do {
- *		seq = raw_read_seqcount_latch(&latch->seq);
+ *	struct entry *latch_query(struct latch_struct *latch, ...)
+ *	{
+ *		struct entry *entry;
+ *		unsigned seq, idx;
  *
- *		idx = seq & 0x01;
- *		entry = data_query(latch->data[idx], ...);
+ *		do {
+ *			seq = raw_read_seqcount_latch(&latch->seq);
  *
- *		smp_rmb();
- *	} while (seq != latch->seq);
+ *			idx = seq & 0x01;
+ *			entry = data_query(latch->data[idx], ...);
  *
- *	return entry;
- * }
+ *			smp_rmb();
+ *		} while (seq != latch->seq);
+ *
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
+ * .. attention::
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
+ * .. attention::
+ *
+ *	When data is a dynamic data structure; one should use regular RCU
+ *	patterns to manage the lifetimes of the objects within.
  */
 static inline void raw_write_seqcount_latch(seqcount_t *s)
 {
-- 
2.20.1

