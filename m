Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21638C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F18082076E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592873566;
	bh=svODkwxakQ4y62OkzdQboTX2De2+sPLtPtUYQu2CPE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ATH1WIa46c9rHIGu1O87YgLpgtNWnOAhjeScI0KZqTmYDnsTy4WyIgqc04U3nLb4h
	 4xRfgRhgXT8ECk7xLMGdUJXSsAWXFK8Mlq2mcOocPPRglEb6ejDsFrDFeG9e+hEbXF
	 7EhbdY3RXMLJIIB4ekgZA/xydUkmJj5a4vp36BW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732417AbgFWAwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:52:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732371AbgFWAwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:52:34 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACE302082F;
        Tue, 23 Jun 2020 00:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592873553;
        bh=svODkwxakQ4y62OkzdQboTX2De2+sPLtPtUYQu2CPE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uLIFIiPmYRAIvgQFQvrRM2jKxv6S6VUOVkbiDzAeitui60B8MV3U+9I17PTkkbgmV
         RwaxmMbts/kTg7ZoecucDnrvnusVp1vkhvdAKBMv7WKvueVpMcm1Jw9v7DUaZdH+OL
         /1REMn3dFP8Q1Y+uehbTn8raCoFCBKr2Mjymfgy0=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 04/14] Documentation: LKMM: Add litmus test for RCU GP guarantee where reader stores
Date:   Mon, 22 Jun 2020 17:52:21 -0700
Message-Id: <20200623005231.27712-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623005152.GA27459@paulmck-ThinkPad-P72>
References: <20200623005152.GA27459@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

This adds an example for the important RCU grace period guarantee, which
shows an RCU reader can never span a grace period.

Acked-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/litmus-tests/README                  | 11 +++++++
 .../litmus-tests/rcu/RCU+sync+read.litmus          | 37 ++++++++++++++++++++++
 2 files changed, 48 insertions(+)
 create mode 100644 Documentation/litmus-tests/README
 create mode 100644 Documentation/litmus-tests/rcu/RCU+sync+read.litmus

diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
new file mode 100644
index 0000000..c4307ea
--- /dev/null
+++ b/Documentation/litmus-tests/README
@@ -0,0 +1,11 @@
+============
+LITMUS TESTS
+============
+
+RCU (/rcu directory)
+--------------------
+
+RCU+sync+read.litmus
+RCU+sync+free.litmus
+    Both the above litmus tests demonstrate the RCU grace period guarantee
+    that an RCU read-side critical section can never span a grace period.
diff --git a/Documentation/litmus-tests/rcu/RCU+sync+read.litmus b/Documentation/litmus-tests/rcu/RCU+sync+read.litmus
new file mode 100644
index 0000000..f341767
--- /dev/null
+++ b/Documentation/litmus-tests/rcu/RCU+sync+read.litmus
@@ -0,0 +1,37 @@
+C RCU+sync+read
+
+(*
+ * Result: Never
+ *
+ * This litmus test demonstrates that after a grace period, an RCU updater always
+ * sees all stores done in prior RCU read-side critical sections. Such
+ * read-side critical sections would have ended before the grace period ended.
+ *
+ * This is one implication of the RCU grace-period guarantee, which says (among
+ * other things) that an RCU read-side critical section cannot span a grace period.
+ *)
+
+{
+int x = 0;
+int y = 0;
+}
+
+P0(int *x, int *y)
+{
+	rcu_read_lock();
+	WRITE_ONCE(*x, 1);
+	WRITE_ONCE(*y, 1);
+	rcu_read_unlock();
+}
+
+P1(int *x, int *y)
+{
+	int r0;
+	int r1;
+
+	r0 = READ_ONCE(*x);
+	synchronize_rcu();
+	r1 = READ_ONCE(*y);
+}
+
+exists (1:r0=1 /\ 1:r1=0)
-- 
2.9.5

