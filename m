Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119F0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D413A22B40
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RAz0FjDt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RJJldY2C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732391AbgGaJXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:23:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56434 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732286AbgGaJW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:22:58 -0400
Date:   Fri, 31 Jul 2020 09:22:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187375;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=sbYCIUsOAV3704u7mcpiRX1NVlpsC2ejS56Gb5y4xeM=;
        b=RAz0FjDt84ztKHlGp4GW+DRDtq349r634pEG/kTXGSGHa6eUVm5oCxO68bkwMZ0Nazcda4
        0E1Kxy5vMBc2Wyur9tFvazOjEj9V136rPeBngivpoYxtj2pIgWkW16JYqG/XJ7PGKOrzmE
        rXd59PB6shEj/LVTW+xKw3/fIK8rWPOPRHjAwrLk16FpUFAeSHny8yzP4NUT16Fr8kaPAU
        LqqNNWjPzVoP4xi8JEvpKfhdIXg5mrB8/ls7x+jD2pYDH8CkcXL4+dXPiBXNAAC0pO1Nme
        36OyBhHH9UIy6M60xUo2pBoA5Ec6Ktt/eV8t22eLRfjgQfyWLaSCSMnYreL0/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187375;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=sbYCIUsOAV3704u7mcpiRX1NVlpsC2ejS56Gb5y4xeM=;
        b=RJJldY2CB1qY/8s/WfNF8BxNZNLNXwqoKvC6iOZ/j8e56P/BnvGCq2W/Zz4gxXgd6fIgPu
        /IfvTkAP0PHMf1Dw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] refperf: Change readdelay module parameter to nanoseconds
Cc:     Akira Yokosawa <akiyks@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618737528.4006.7436673446115115268.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     918b351d965560c7902ad482cf87049517843ff2
Gitweb:        https://git.kernel.org/tip/918b351d965560c7902ad482cf87049517843ff2
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sun, 31 May 2020 18:14:57 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:00:45 -07:00

refperf: Change readdelay module parameter to nanoseconds

The current units of microseconds are too coarse, so this commit
changes the units to nanoseconds.  However, ndelay is used only for the
nanoseconds with udelay being used for whole microseconds.  For example,
setting refperf.readdelay=1500 results in a udelay(1) followed by an
ndelay(500).

Suggested-by: Akira Yokosawa <akiyks@gmail.com>
[ paulmck: Abstracted delay per Akira feedback and move from 80 to 100 lines. ]
[ paulmck: Fix names as suggested by kbuild test robot. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 80d4490..49fffb9 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -66,8 +66,8 @@ torture_param(long, loops, 10000, "Number of loops per experiment.");
 torture_param(int, nreaders, -1, "Number of readers, -1 for 75% of CPUs.");
 // Number of runs.
 torture_param(int, nruns, 30, "Number of experiments to run.");
-// Reader delay in microseconds, 0 for no delay.
-torture_param(int, readdelay, 0, "Read-side delay in microseconds.");
+// Reader delay in nanoseconds, 0 for no delay.
+torture_param(int, readdelay, 0, "Read-side delay in nanoseconds.");
 
 #ifdef MODULE
 # define REFPERF_SHUTDOWN 0
@@ -111,12 +111,20 @@ struct ref_perf_ops {
 	void (*init)(void);
 	void (*cleanup)(void);
 	void (*readsection)(const int nloops);
-	void (*delaysection)(const int nloops, const int ndelay);
+	void (*delaysection)(const int nloops, const int udl, const int ndl);
 	const char *name;
 };
 
 static struct ref_perf_ops *cur_ops;
 
+static void un_delay(const int udl, const int ndl)
+{
+	if (udl)
+		udelay(udl);
+	if (ndl)
+		ndelay(ndl);
+}
+
 static void ref_rcu_read_section(const int nloops)
 {
 	int i;
@@ -127,13 +135,13 @@ static void ref_rcu_read_section(const int nloops)
 	}
 }
 
-static void ref_rcu_delay_section(const int nloops, const int ndelay)
+static void ref_rcu_delay_section(const int nloops, const int udl, const int ndl)
 {
 	int i;
 
 	for (i = nloops; i >= 0; i--) {
 		rcu_read_lock();
-		udelay(ndelay);
+		un_delay(udl, ndl);
 		rcu_read_unlock();
 	}
 }
@@ -165,14 +173,14 @@ static void srcu_ref_perf_read_section(const int nloops)
 	}
 }
 
-static void srcu_ref_perf_delay_section(const int nloops, const int ndelay)
+static void srcu_ref_perf_delay_section(const int nloops, const int udl, const int ndl)
 {
 	int i;
 	int idx;
 
 	for (i = nloops; i >= 0; i--) {
 		idx = srcu_read_lock(srcu_ctlp);
-		udelay(ndelay);
+		un_delay(udl, ndl);
 		srcu_read_unlock(srcu_ctlp, idx);
 	}
 }
@@ -197,13 +205,13 @@ static void ref_refcnt_section(const int nloops)
 	}
 }
 
-static void ref_refcnt_delay_section(const int nloops, const int ndelay)
+static void ref_refcnt_delay_section(const int nloops, const int udl, const int ndl)
 {
 	int i;
 
 	for (i = nloops; i >= 0; i--) {
 		atomic_inc(&refcnt);
-		udelay(ndelay);
+		un_delay(udl, ndl);
 		atomic_dec(&refcnt);
 	}
 }
@@ -233,13 +241,13 @@ static void ref_rwlock_section(const int nloops)
 	}
 }
 
-static void ref_rwlock_delay_section(const int nloops, const int ndelay)
+static void ref_rwlock_delay_section(const int nloops, const int udl, const int ndl)
 {
 	int i;
 
 	for (i = nloops; i >= 0; i--) {
 		read_lock(&test_rwlock);
-		udelay(ndelay);
+		un_delay(udl, ndl);
 		read_unlock(&test_rwlock);
 	}
 }
@@ -269,13 +277,13 @@ static void ref_rwsem_section(const int nloops)
 	}
 }
 
-static void ref_rwsem_delay_section(const int nloops, const int ndelay)
+static void ref_rwsem_delay_section(const int nloops, const int udl, const int ndl)
 {
 	int i;
 
 	for (i = nloops; i >= 0; i--) {
 		down_read(&test_rwsem);
-		udelay(ndelay);
+		un_delay(udl, ndl);
 		up_read(&test_rwsem);
 	}
 }
@@ -292,7 +300,7 @@ static void rcu_perf_one_reader(void)
 	if (readdelay <= 0)
 		cur_ops->readsection(loops);
 	else
-		cur_ops->delaysection(loops, readdelay);
+		cur_ops->delaysection(loops, readdelay / 1000, readdelay % 1000);
 }
 
 // Reader kthread.  Repeatedly does empty RCU read-side
