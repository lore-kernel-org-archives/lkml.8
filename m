Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6276EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38BA322B40
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fawarhuy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pPWlLF/r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732729AbgGaJ1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:27:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56338 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732375AbgGaJXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:11 -0400
Date:   Fri, 31 Jul 2020 09:23:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187390;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Q/UJ+x0Bjyl2/JWTgI1+3ScpG6M5r153+oSlUAkUQTU=;
        b=fawarhuyI6+60GkadKSwxXULCQw3X1lbg4bB00y3v+mzmA6TH338/ZQpk5O5e0Wnz5EaSM
        g5SX4CTL9aKjYDTA7+mFp7pInpXpkX+0SxxKXHkZ6xhwq/WDMdMQDGHUug7EQ1uC8rpEWH
        cEk9z9b8zHVCMjqpcGiaf4MJHs+P9pCZknCVOe8mdiB120eCNuvkZkoLNIl90RfCzUdT/C
        YfsYqnYEtsh7VDpJP8wrjzv45N/rF0laZMc1KP3nn8n0aiBavajzpmSUygD49z1NaPvwHe
        g5gfWs8/K+9wo+gEIP5w2t3V64cEfmM0jD7m2MqAXkuopf+/92YdaL/TGUDbfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187390;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Q/UJ+x0Bjyl2/JWTgI1+3ScpG6M5r153+oSlUAkUQTU=;
        b=pPWlLF/rKkfq9jSwdU9WT6QxznwnoK7odHBaZxlYwXLf97WtjjyIZjNgaAqmLRVgTKm+7n
        M6jM4jtXcOK7xrDw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcuperf: Add comments explaining the high reader overhead
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618738930.4006.13348759385369896937.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     708cda31652c02e64adaeafafe7b996e4e14c3eb
Gitweb:        https://git.kernel.org/tip/708cda31652c02e64adaeafafe7b996e4e14c3eb
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 25 May 2020 09:22:24 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:00:44 -07:00

rcuperf: Add comments explaining the high reader overhead

This commit adds comments explaining why the readers have otherwise insane
levels of measurement overhead, namely that they are intended as a test
load for update-side performance measurements, not as a straight-up
read-side performance test.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcuperf.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index 246da8f..d906ca9 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -69,6 +69,11 @@ MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com>");
  *	value specified by nr_cpus for a read-only test.
  *
  * Various other use cases may of course be specified.
+ *
+ * Note that this test's readers are intended only as a test load for
+ * the writers.  The reader performance statistics will be overly
+ * pessimistic due to the per-critical-section interrupt disabling,
+ * test-end checks, and the pair of calls through pointers.
  */
 
 #ifdef MODULE
@@ -309,8 +314,10 @@ static void rcu_perf_wait_shutdown(void)
 }
 
 /*
- * RCU perf reader kthread.  Repeatedly does empty RCU read-side
- * critical section, minimizing update-side interference.
+ * RCU perf reader kthread.  Repeatedly does empty RCU read-side critical
+ * section, minimizing update-side interference.  However, the point of
+ * this test is not to evaluate reader performance, but instead to serve
+ * as a test load for update-side performance testing.
  */
 static int
 rcu_perf_reader(void *arg)
