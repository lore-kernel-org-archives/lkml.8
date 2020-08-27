Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22CBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 11:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B53C32177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 11:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mKp2X5xO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CzVsPmaG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgH0LzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 07:55:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38254 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgH0LlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:41:04 -0400
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598528462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5yW6UWqShjkqpT4CJrOfJI69Xnpi5/tapvijWzXrGwU=;
        b=mKp2X5xOPvrMJfz7ehRotTqQGzLs1tyMTWC6dIKAL1DTsjE9HllSC+a3+YPSUsD7BP2fSr
        5FhzBehT+C4VMTrz8dnkrSPDCYfFsE4D/b3R8Zn6lML84U6q+KtN6a71kZqYYplj96DwDh
        3/mRnAQHh/yKZ1kMfbjaQiy7/5jzD5sRSkVQISe22wSE1E0DBF4nzaaiCL3vWWpwhf2KLx
        dFdWMecfUIEEe2wOVAihScYuHLpItCA1sKkosNwzx+VzrIa/gtmy4R/lwmALJEr+T7YIVq
        94vWP+1CvDW2N3jHyNPxGeuhxI4pHSuFuiiX8rYnRAAZshqxR/XU1GB3SNUFBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598528462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5yW6UWqShjkqpT4CJrOfJI69Xnpi5/tapvijWzXrGwU=;
        b=CzVsPmaGkSspWa8Wm5KuG2pXNR4xBNdreEC90d3BfrzRp8L/yAYTxhFvledQceg+/t5JkV
        dXTW+AXL321RZ+DQ==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH v1 8/8] seqlock: seqcount latch APIs: Only allow seqcount_latch_t
Date:   Thu, 27 Aug 2020 13:40:44 +0200
Message-Id: <20200827114044.11173-9-a.darwish@linutronix.de>
In-Reply-To: <20200827114044.11173-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200827114044.11173-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All latch sequence counter call-sites have now been converted from plain
seqcount_t to the new seqcount_latch_t data type.

Enforce type-safety by modifying seqlock.h latch APIs to only accept
seqcount_latch_t.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 include/linux/seqlock.h | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index f83fbf2180db..04db28499331 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -620,7 +620,7 @@ static inline void seqcount_latch_init(seqcount_latch_t *s)
 
 /**
  * raw_read_seqcount_latch() - pick even/odd latch data copy
- * @s: Pointer to seqcount_t, seqcount_raw_spinlock_t, or seqcount_latch_t
+ * @s: Pointer to seqcount_latch_t
  *
  * See raw_write_seqcount_latch() for details and a full reader/writer
  * usage example.
@@ -629,17 +629,14 @@ static inline void seqcount_latch_init(seqcount_latch_t *s)
  * picking which data copy to read. The full counter must then be checked
  * with read_seqcount_latch_retry().
  */
-#define raw_read_seqcount_latch(s)						\
-({										\
-	/*									\
-	 * Pairs with the first smp_wmb() in raw_write_seqcount_latch().	\
-	 * Due to the dependent load, a full smp_rmb() is not needed.		\
-	 */									\
-	_Generic(*(s),								\
-		 seqcount_t:		  READ_ONCE(((seqcount_t *)s)->sequence),			\
-		 seqcount_raw_spinlock_t: READ_ONCE(((seqcount_raw_spinlock_t *)s)->seqcount.sequence),	\
-		 seqcount_latch_t:	  READ_ONCE(((seqcount_latch_t *)s)->seqcount.sequence));	\
-})
+static inline unsigned raw_read_seqcount_latch(const seqcount_latch_t *s)
+{
+	/*
+	 * Pairs with the first smp_wmb() in raw_write_seqcount_latch().
+	 * Due to the dependent load, a full smp_rmb() is not needed.
+	 */
+	return READ_ONCE(s->seqcount.sequence);
+}
 
 /**
  * read_seqcount_latch_retry() - end a seqcount_latch_t read section
@@ -656,7 +653,7 @@ read_seqcount_latch_retry(const seqcount_latch_t *s, unsigned start)
 
 /**
  * raw_write_seqcount_latch() - redirect latch readers to even/odd copy
- * @s: Pointer to seqcount_t, seqcount_raw_spinlock_t, or seqcount_latch_t
+ * @s: Pointer to seqcount_latch_t
  *
  * The latch technique is a multiversion concurrency control method that allows
  * queries during non-atomic modifications. If you can guarantee queries never
@@ -735,14 +732,11 @@ read_seqcount_latch_retry(const seqcount_latch_t *s, unsigned start)
  *	When data is a dynamic data structure; one should use regular RCU
  *	patterns to manage the lifetimes of the objects within.
  */
-#define raw_write_seqcount_latch(s)						\
-{										\
-       smp_wmb();      /* prior stores before incrementing "sequence" */	\
-       _Generic(*(s),								\
-		seqcount_t:		((seqcount_t *)s)->sequence++,		\
-		seqcount_raw_spinlock_t:((seqcount_raw_spinlock_t *)s)->seqcount.sequence++, \
-		seqcount_latch_t:	((seqcount_latch_t *)s)->seqcount.sequence++); \
-       smp_wmb();      /* increment "sequence" before following stores */	\
+static inline void raw_write_seqcount_latch(seqcount_latch_t *s)
+{
+	smp_wmb();	/* prior stores before incrementing "sequence" */
+	s->seqcount.sequence++;
+	smp_wmb();      /* increment "sequence" before following stores */
 }
 
 /*
-- 
2.28.0

