Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0623C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 926C320882
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KMkqAsWF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SRNhO+Y2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgIJT1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731351AbgIJPsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:48:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEA5C06134E;
        Thu, 10 Sep 2020 08:08:28 -0700 (PDT)
Date:   Thu, 10 Sep 2020 15:08:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599750506;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nxy1DHpcw4NzFK3ktRgxyoEl9LnzftlIXEEZObm4SdE=;
        b=KMkqAsWFJlF3Hvw0ytOBueMi+rAuY1Qidu9TRR1KzAATkOkcjlRIfwNR2Y+GbDLjsr8iR6
        Iz0sSpGOqSNIKwCOX7/KLtHviA5WQ7n+DBgfk1KXMr2Qb9puGHuUHAbfEA4d0fFo1KON2H
        lwnHrV8A2uaXjiLfNDGC/ZmwT3imu/EbiGtjlkwzRBnAE96S3u49AV/prCJvEsJVpIj1Sx
        fD+/LbZqEnFEg9Ti2Nfzqm8VJjwlLQ3BOhc0F1UK56uDxNNQgt+5T7QYrnZXYLqOb2qawm
        mBFolJMbWdfXztxGEGNa2AL5FhOHjiepbo7eHIBmbubykxCe6ySEYM/PGKcNpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599750506;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nxy1DHpcw4NzFK3ktRgxyoEl9LnzftlIXEEZObm4SdE=;
        b=SRNhO+Y2qINVHNZLVvIZrwsgDdl3woNvIqAS44dIK8b/kd8qFPwTxtaMVdPwOeVfXixA4B
        B48I6NsdI9k2IKAA==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] seqlock: seqcount latch APIs: Only allow seqcount_latch_t
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200827114044.11173-9-a.darwish@linutronix.de>
References: <20200827114044.11173-9-a.darwish@linutronix.de>
MIME-Version: 1.0
Message-ID: <159975050603.20229.9844172785774718591.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     0c9794c8b6781eb7dad8e19b78c5d4557790597a
Gitweb:        https://git.kernel.org/tip/0c9794c8b6781eb7dad8e19b78c5d4557790597a
Author:        Ahmed S. Darwish <a.darwish@linutronix.de>
AuthorDate:    Thu, 27 Aug 2020 13:40:44 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 10 Sep 2020 11:19:30 +02:00

seqlock: seqcount latch APIs: Only allow seqcount_latch_t

All latch sequence counter call-sites have now been converted from plain
seqcount_t to the new seqcount_latch_t data type.

Enforce type-safety by modifying seqlock.h latch APIs to only accept
seqcount_latch_t.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200827114044.11173-9-a.darwish@linutronix.de
---
 include/linux/seqlock.h | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 88b917d..f2a7a46 100644
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
