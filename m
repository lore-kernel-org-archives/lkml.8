Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F4CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3BE722CBB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="28osquip";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p1bz2hWO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731550AbgGTP4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:56:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58800 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731531AbgGTP4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:56:21 -0400
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595260579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9sMvdfPqgkfiJMGReS66DVtI2iXr+XlSYrSm8LW2usk=;
        b=28osquip+6Q7PbCFEqpoMl35F/GbwYKz30TejevbtAYTwhhEDG+9f/5tEt4f3+SQBfy2bd
        e8/ML7Nt0hXuIWXWzTMvy0PbGZ/I1OyF0MPCJSw2H97QK8JIZAt1kROgBqBut22Tcu/YYM
        nilnqPn/fgEQ+V6QeuSkW5ZdyRp2PXB8XKpZsTFK0iI52RWbba8UruyqMKPLwmGnlfOX7X
        TUFASJZYG8a4Tmr84lFSlKFk1jzQ13Lav0fLWtm0Nj85MoEUbQiGXY+l6wNwm4C0sy5mI1
        F0st6FaRLqlL757p4Dk/szpjKnk3dlZQxZx5HwkPlw1R1jfT3JlMIndDRSV3Cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595260579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9sMvdfPqgkfiJMGReS66DVtI2iXr+XlSYrSm8LW2usk=;
        b=p1bz2hWO+seggOtH06CdEzJVmBRBgK7cylyIjkZNWU//Br38Z8YBxh30MAENma7JePcVWs
        rc6kLF5MTzeXRcCw==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH v4 10/24] seqlock: Align multi-line macros newline escapes at 72 columns
Date:   Mon, 20 Jul 2020 17:55:16 +0200
Message-Id: <20200720155530.1173732-11-a.darwish@linutronix.de>
In-Reply-To: <20200720155530.1173732-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200720155530.1173732-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parent commit, "seqlock: Extend seqcount API with associated locks",
introduced a big number of multi-line macros that are newline-escaped
at 72 columns.

For overall cohesion, align the earlier-existing macros similarly.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 include/linux/seqlock.h | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 8c16a494c968..b48729988325 100644
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
-- 
2.20.1

