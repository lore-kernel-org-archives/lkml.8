Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D825C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B6E2208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lBx3cTcp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dZH5tGcT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732380AbgGaJXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:23:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56344 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732266AbgGaJWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:22:55 -0400
Date:   Fri, 31 Jul 2020 09:22:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187373;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=GPpffx2Bkt27uZ657mrb56I8xaNfqiApprib8yY0JqU=;
        b=lBx3cTcpocIv14cOGLQe3ao9jMN2jLPEhuN0A8xe8cPoygBnHUB1CrvMewCEEhn05ECTHz
        TKlXszFXiJ/z5GKj4npbWExRS8MjxCiNJumLgw+wPALHTgjqBNOHILzFYprSnyLTglH+a0
        paU7O4Rt2szDqM338VCOI+diH/lmHDKAo6SiRutkFeSwRVwkVGscOoUdJkUdpj+N29Z0DH
        r/3lLEUJaMj/EC2pRFCZZeJdaIRxuSMPQzT1bad9VsaQn8BVfYlBIQjOt/YRjLp4kKwW/5
        +fDsMZyJsATJ1JCiTs9nZBv9wrwJ2NjITrcR6ONkvdAwRW2YlrN8al6PAtq9gA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187373;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=GPpffx2Bkt27uZ657mrb56I8xaNfqiApprib8yY0JqU=;
        b=dZH5tGcTcDxiATpxh70ZPXwGTStmuk9FghuEAcvPVQGW1V9j8rp+ZZIwsrOaVKxaCH7wv6
        J1sOLHfeCtosk+Dw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] refperf: Rename RCU_REF_PERF_TEST to RCU_REF_SCALE_TEST
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618737259.4006.16274882036768270688.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     8e4ec3d02b549a731c94b4bcddff212bb92cdbaf
Gitweb:        https://git.kernel.org/tip/8e4ec3d02b549a731c94b4bcddff212bb92cdbaf
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 17 Jun 2020 11:33:54 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:00:46 -07:00

refperf: Rename RCU_REF_PERF_TEST to RCU_REF_SCALE_TEST

The old Kconfig option name is all too easy to conflate with the
unrelated "perf" feature, so this commit renames RCU_REF_PERF_TEST to
RCU_REF_SCALE_TEST.

Reported-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig.debug                                    | 4 ++--
 kernel/rcu/Makefile                                         | 2 +-
 kernel/rcu/refperf.c                                        | 6 +++---
 tools/testing/selftests/rcutorture/configs/refperf/CFcommon | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 858765b..3cf6132 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -61,8 +61,8 @@ config RCU_TORTURE_TEST
 	  Say M if you want the RCU torture tests to build as a module.
 	  Say N if you are unsure.
 
-config RCU_REF_PERF_TEST
-	tristate "Performance tests for read-side synchronization (RCU and others)"
+config RCU_REF_SCALE_TEST
+	tristate "Scalability tests for read-side synchronization (RCU and others)"
 	depends on DEBUG_KERNEL
 	select TORTURE_TEST
 	select SRCU
diff --git a/kernel/rcu/Makefile b/kernel/rcu/Makefile
index ba7d826..45d562d 100644
--- a/kernel/rcu/Makefile
+++ b/kernel/rcu/Makefile
@@ -12,7 +12,7 @@ obj-$(CONFIG_TREE_SRCU) += srcutree.o
 obj-$(CONFIG_TINY_SRCU) += srcutiny.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
 obj-$(CONFIG_RCU_PERF_TEST) += rcuperf.o
-obj-$(CONFIG_RCU_REF_PERF_TEST) += refperf.o
+obj-$(CONFIG_RCU_REF_SCALE_TEST) += refperf.o
 obj-$(CONFIG_TREE_RCU) += tree.o
 obj-$(CONFIG_TINY_RCU) += tiny.o
 obj-$(CONFIG_RCU_NEED_SEGCBLIST) += rcu_segcblist.o
diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 2bfdcdc..7c98057 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 //
-// Performance test comparing RCU vs other mechanisms
+// Scalability test comparing RCU vs other mechanisms
 // for acquiring references on objects.
 //
 // Copyright (C) Google, 2020.
@@ -59,7 +59,7 @@ MODULE_PARM_DESC(perf_type, "Type of test (rcu, srcu, refcnt, rwsem, rwlock.");
 torture_param(int, verbose, 0, "Enable verbose debugging printk()s");
 
 // Wait until there are multiple CPUs before starting test.
-torture_param(int, holdoff, IS_BUILTIN(CONFIG_RCU_REF_PERF_TEST) ? 10 : 0,
+torture_param(int, holdoff, IS_BUILTIN(CONFIG_RCU_REF_SCALE_TEST) ? 10 : 0,
 	      "Holdoff time before test start (s)");
 // Number of loops per experiment, all readers execute operations concurrently.
 torture_param(long, loops, 10000, "Number of loops per experiment.");
@@ -656,7 +656,7 @@ ref_perf_init(void)
 		for (i = 0; i < ARRAY_SIZE(perf_ops); i++)
 			pr_cont(" %s", perf_ops[i]->name);
 		pr_cont("\n");
-		WARN_ON(!IS_MODULE(CONFIG_RCU_REF_PERF_TEST));
+		WARN_ON(!IS_MODULE(CONFIG_RCU_REF_SCALE_TEST));
 		firsterr = -EINVAL;
 		cur_ops = NULL;
 		goto unwind;
diff --git a/tools/testing/selftests/rcutorture/configs/refperf/CFcommon b/tools/testing/selftests/rcutorture/configs/refperf/CFcommon
index 8ba5ba2..a98b58b 100644
--- a/tools/testing/selftests/rcutorture/configs/refperf/CFcommon
+++ b/tools/testing/selftests/rcutorture/configs/refperf/CFcommon
@@ -1,2 +1,2 @@
-CONFIG_RCU_REF_PERF_TEST=y
+CONFIG_RCU_REF_SCALE_TEST=y
 CONFIG_PRINTK_TIME=y
