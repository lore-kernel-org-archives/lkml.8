Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797D4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5314722B43
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V8InLXok";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="njGUaeuU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgG2Oec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:34:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42918 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgG2Odj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:33:39 -0400
Date:   Wed, 29 Jul 2020 14:33:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596033217;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c6nr+L+ClkATOfG91T0QQ7+b87skFpVeKNStBsr2yIc=;
        b=V8InLXokdP+MS3zVeSs3VaOx3qA65JY6bMoK0gj2yiEP1ta9k5Epn0tjy2f92LpwUy7Ih2
        5kpyIV4Xbc++ZII3PJM1LdhzFstB60fqGZ1ftyzf0tcC/IqGcqoN1l3Wo6MLuOPtcKWEIe
        VNKG+FiHmfEerx9WDkwfCbfJcsP17KJUX6eNtZtOgQqt8oLe3MZcebZXRkL8bW+Ng2PvWd
        2zOA5ZtHvweucrhBS1D2xnDgrF16gZCdEOKBbNvAN+MT0zAYRsSPCA9ffNU9Smz1jAFdii
        IOTw2EBp4GiQBY/bHcXNU8HLcvdJKGu3/o86saNEPiqnAeLN4e4BUBggB8HDxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596033217;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c6nr+L+ClkATOfG91T0QQ7+b87skFpVeKNStBsr2yIc=;
        b=njGUaeuUjYn3geBzj4IjXrLbW3ivzMsXhwVE2Uh4U+grM/qc1mdHjth2u+sbWUch5THorL
        nwPAkim3RS7JT9Bg==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] seqlock: Align multi-line macros newline escapes
 at 72 columns
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200720155530.1173732-11-a.darwish@linutronix.de>
References: <20200720155530.1173732-11-a.darwish@linutronix.de>
MIME-Version: 1.0
Message-ID: <159603321659.4006.12710822667162605079.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     ec8702da570ebb59f38471007bf71359c51b027b
Gitweb:        https://git.kernel.org/tip/ec8702da570ebb59f38471007bf71359c51b027b
Author:        Ahmed S. Darwish <a.darwish@linutronix.de>
AuthorDate:    Mon, 20 Jul 2020 17:55:16 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Jul 2020 16:14:25 +02:00

seqlock: Align multi-line macros newline escapes at 72 columns

Parent commit, "seqlock: Extend seqcount API with associated locks",
introduced a big number of multi-line macros that are newline-escaped
at 72 columns.

For overall cohesion, align the earlier-existing macros similarly.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200720155530.1173732-11-a.darwish@linutronix.de
---
 include/linux/seqlock.h | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 8c16a49..b487299 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -80,17 +80,18 @@ static inline void __seqcount_init(seqcount_t *s, const char *name,
 }
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-# define SEQCOUNT_DEP_MAP_INIT(lockname) \
-		.dep_map = { .name = #lockname } \
+
+# define SEQCOUNT_DEP_MAP_INIT(lockname)				\
+		.dep_map = { .name = #lockname }
 
 /**
  * seqcount_init() - runtime initializer for seqcount_t
  * @s: Pointer to the seqcount_t instance
  */
-# define seqcount_init(s)				\
-	do {						\
-		static struct lock_class_key __key;	\
-		__seqcount_init((s), #s, &__key);	\
+# define seqcount_init(s)						\
+	do {								\
+		static struct lock_class_key __key;			\
+		__seqcount_init((s), #s, &__key);			\
 	} while (0)
 
 static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
@@ -842,20 +843,20 @@ typedef struct {
 	spinlock_t lock;
 } seqlock_t;
 
-#define __SEQLOCK_UNLOCKED(lockname)			\
-	{						\
-		.seqcount = SEQCNT_ZERO(lockname),	\
-		.lock =	__SPIN_LOCK_UNLOCKED(lockname)	\
+#define __SEQLOCK_UNLOCKED(lockname)					\
+	{								\
+		.seqcount = SEQCNT_ZERO(lockname),			\
+		.lock =	__SPIN_LOCK_UNLOCKED(lockname)			\
 	}
 
 /**
  * seqlock_init() - dynamic initializer for seqlock_t
  * @sl: Pointer to the seqlock_t instance
  */
-#define seqlock_init(sl)				\
-	do {						\
-		seqcount_init(&(sl)->seqcount);		\
-		spin_lock_init(&(sl)->lock);		\
+#define seqlock_init(sl)						\
+	do {								\
+		seqcount_init(&(sl)->seqcount);				\
+		spin_lock_init(&(sl)->lock);				\
 	} while (0)
 
 /**
