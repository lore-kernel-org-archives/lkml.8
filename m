Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF005C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 00:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C65A32075A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 00:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgFHA5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 20:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgFHA5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 20:57:51 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD841C08C5C3;
        Sun,  7 Jun 2020 17:57:50 -0700 (PDT)
Received: from [5.158.153.53] (helo=debian-buster-darwi.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <a.darwish@linutronix.de>)
        id 1ji66e-0000iX-JU; Mon, 08 Jun 2020 02:57:40 +0200
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
Subject: [PATCH v2 02/18] seqlock: Properly format kernel-doc code samples
Date:   Mon,  8 Jun 2020 02:57:13 +0200
Message-Id: <20200608005729.1874024-3-a.darwish@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200608005729.1874024-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200608005729.1874024-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
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
index aee894dc49aa..7296af778301 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -232,7 +232,7 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
  *
  * This can be used to provide an ordering guarantee instead of the
  * usual consistency guarantee. It is one wmb cheaper, because we can
- * collapse the two back-to-back wmb()s.
+ * collapse the two back-to-back wmb()s::
  *
  *      seqcount_t seq;
  *      bool X = true, Y = false;
@@ -292,64 +292,68 @@ static inline int raw_read_seqcount_latch(seqcount_t *s)
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

