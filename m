Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06A4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81B2A22D2B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WCV1mi5c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cXOXNSJy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgH0HyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgH0HyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D57EC061264;
        Thu, 27 Aug 2020 00:54:17 -0700 (PDT)
Date:   Thu, 27 Aug 2020 07:54:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514855;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BmdgD8aRx+NkXrffxySXTl0IhoJmFxLLR11F0fHAfoA=;
        b=WCV1mi5cLPrURoLGTJZWjt3waIVtqs512M1B3jNDZrIownPEQSWlH6bLcpZkoCHsx1qPiM
        T9aCs498D6YKp68mP/3eW5sFCk3ns8CRRvRLMYrfkDz/KFbMbCOeAy6BOmZWM3q0OefHLO
        H092AzHn0SzbhGcqF5G5pEvuB4FHujGF7Q9cdXbXPKjKl7guXwPbKhxjAQvPPDEA8Ciueh
        UjyGA0unV4T00KdnjRsQFfu71okHylwiKUshiRsCnNE6wETTdsakHNgTqWnNQrp+kMqqPh
        Dj+ypOqfyPOyJYNCyRzP/oyDknnmHLS4M/38sMaXXcAQ01ue2TD5iHKA56UX2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514855;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BmdgD8aRx+NkXrffxySXTl0IhoJmFxLLR11F0fHAfoA=;
        b=cXOXNSJyG94rIBCrdoqG5I0PxzOXkkuCLJNS4TnYHsYqzbVbAO2+8rJHQVgghkdJSPTLO0
        IRKJ4/hmWo1Jx2Dg==
From:   "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep/selftest: Introduce recursion3
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200807074238.1632519-20-boqun.feng@gmail.com>
References: <20200807074238.1632519-20-boqun.feng@gmail.com>
MIME-Version: 1.0
Message-ID: <159851485457.20229.17439142206591711184.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     96a16f45aed89cf024606a11679b0609d09552c7
Gitweb:        https://git.kernel.org/tip/96a16f45aed89cf024606a11679b0609d09552c7
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Fri, 07 Aug 2020 15:42:38 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:42:08 +02:00

lockdep/selftest: Introduce recursion3

Add a test case shows that USED_IN_*_READ and ENABLE_*_READ can cause
deadlock too.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200807074238.1632519-20-boqun.feng@gmail.com
---
 lib/locking-selftest.c | 55 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 17f8f6f..a899b3f 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -1249,6 +1249,60 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_soft_rlock)
 #include "locking-selftest-wlock.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_soft_wlock)
 
+#undef E1
+#undef E2
+#undef E3
+/*
+ * read-lock / write-lock recursion that is unsafe.
+ *
+ * A is a ENABLED_*_READ lock
+ * B is a USED_IN_*_READ lock
+ *
+ * read_lock(A);
+ *			write_lock(B);
+ * <interrupt>
+ * read_lock(B);
+ * 			write_lock(A); // if this one is read_lock(), no deadlock
+ */
+
+#define E1()				\
+					\
+	IRQ_DISABLE();			\
+	WL(B);				\
+	LOCK(A);			\
+	UNLOCK(A);			\
+	WU(B);				\
+	IRQ_ENABLE();
+
+#define E2()				\
+					\
+	RL(A);				\
+	RU(A);				\
+
+#define E3()				\
+					\
+	IRQ_ENTER();			\
+	RL(B);				\
+	RU(B);				\
+	IRQ_EXIT();
+
+/*
+ * Generate 24 testcases:
+ */
+#include "locking-selftest-hardirq.h"
+#include "locking-selftest-rlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion3_hard_rlock)
+
+#include "locking-selftest-wlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion3_hard_wlock)
+
+#include "locking-selftest-softirq.h"
+#include "locking-selftest-rlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion3_soft_rlock)
+
+#include "locking-selftest-wlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion3_soft_wlock)
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define I_SPINLOCK(x)	lockdep_reset_lock(&lock_##x.dep_map)
 # define I_RWLOCK(x)	lockdep_reset_lock(&rwlock_##x.dep_map)
@@ -2413,6 +2467,7 @@ void locking_selftest(void)
 
 	DO_TESTCASE_6x2x2RW("irq read-recursion", irq_read_recursion);
 	DO_TESTCASE_6x2x2RW("irq read-recursion #2", irq_read_recursion2);
+	DO_TESTCASE_6x2x2RW("irq read-recursion #3", irq_read_recursion3);
 
 	ww_tests();
 
