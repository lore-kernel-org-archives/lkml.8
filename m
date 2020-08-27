Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE7CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 08:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BB2E20825
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 08:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s8OIq+si";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XoJWfpSK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgH0IAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 04:00:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36550 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgH0HyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:20 -0400
Date:   Thu, 27 Aug 2020 07:54:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CJNGFXmIzTTKA+mr7sy1cpSLK/82tJMzknTULsKXe08=;
        b=s8OIq+siHj8Csj140JQY/sQ4LbMb14Gy68mO7eV+UxzpAa9dAyFGerq0ny3rSChsVt69ys
        uRpD6qiSJb4wTz/X6qxvurfcL/jBdc1VB+84hz55ga22p0o7ZR7CM5g6YFdIlWcvsgbn0w
        OtrxLQU43HJCdHrW0vyHO6LvlZffErHz2shxxyE+vBDIXCrzS9kj9/e6AqfHQYxzKwpYjG
        /Xe+Jo0xBLmvmFlYKVmgp7O/V7Ry9FIwznvZO/JZSO6jVYeWgIosLsu02gmTcf9kQZkGkZ
        goXx1ZDkJ6aA1o+iBroUkk1S3xpr6ondy96Xb8BntE0LejL3EMsu09ZYxwAWWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CJNGFXmIzTTKA+mr7sy1cpSLK/82tJMzknTULsKXe08=;
        b=XoJWfpSKzAbveU5ddHKTI4tieQ+L6Ou+vPqxRcS5ze3apSfFQSVlnO2Y5Ff4YUdEcrcZ7L
        KcXiz0jJwCZGnUBg==
From:   "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep/selftest: Add a R-L/L-W test case
 specific to chain cache behavior
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200807074238.1632519-14-boqun.feng@gmail.com>
References: <20200807074238.1632519-14-boqun.feng@gmail.com>
MIME-Version: 1.0
Message-ID: <159851485713.20229.4453836851225791723.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     d4f200e579e96051f1f081f795820787826eb234
Gitweb:        https://git.kernel.org/tip/d4f200e579e96051f1f081f795820787826eb234
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Fri, 07 Aug 2020 15:42:32 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:42:06 +02:00

lockdep/selftest: Add a R-L/L-W test case specific to chain cache behavior

As our chain cache doesn't differ read/write locks, so even we can
detect a read-lock/lock-write deadlock in check_noncircular(), we can
still be fooled if a read-lock/lock-read case(which is not a deadlock)
comes first.

So introduce this test case to test specific to the chain cache behavior
on detecting recursive read lock related deadlocks.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200807074238.1632519-14-boqun.feng@gmail.com
---
 lib/locking-selftest.c | 47 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index caadc4d..002d1ec 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -400,6 +400,49 @@ static void rwsem_ABBA1(void)
  * read_lock(A)
  * spin_lock(B)
  *		spin_lock(B)
+ *		write_lock(A)
+ *
+ * This test case is aimed at poking whether the chain cache prevents us from
+ * detecting a read-lock/lock-write deadlock: if the chain cache doesn't differ
+ * read/write locks, the following case may happen
+ *
+ * 	{ read_lock(A)->lock(B) dependency exists }
+ *
+ * 	P0:
+ * 	lock(B);
+ * 	read_lock(A);
+ *
+ *	{ Not a deadlock, B -> A is added in the chain cache }
+ *
+ *	P1:
+ *	lock(B);
+ *	write_lock(A);
+ *
+ *	{ B->A found in chain cache, not reported as a deadlock }
+ *
+ */
+static void rlock_chaincache_ABBA1(void)
+{
+	RL(X1);
+	L(Y1);
+	U(Y1);
+	RU(X1);
+
+	L(Y1);
+	RL(X1);
+	RU(X1);
+	U(Y1);
+
+	L(Y1);
+	WL(X1);
+	WU(X1);
+	U(Y1); // should fail
+}
+
+/*
+ * read_lock(A)
+ * spin_lock(B)
+ *		spin_lock(B)
  *		read_lock(A)
  */
 static void rlock_ABBA2(void)
@@ -2062,6 +2105,10 @@ void locking_selftest(void)
 	pr_cont("             |");
 	dotest(rwsem_ABBA3, FAILURE, LOCKTYPE_RWSEM);
 
+	print_testname("chain cached mixed R-L/L-W ABBA");
+	pr_cont("             |");
+	dotest(rlock_chaincache_ABBA1, FAILURE, LOCKTYPE_RWLOCK);
+
 	printk("  --------------------------------------------------------------------------\n");
 
 	/*
