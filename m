Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1587C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7843320768
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586977915;
	bh=qliPcXgbk/xRPVAz0PYha9JPnj6oxTj+gchEtQmm5FI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vwPJAcfzpEjWi3wSovKpLI54L2M/74lA/q37Xd+6RPKkT5QpWwIiUy0Y9SHvu8NFx
	 cQAwSesfyeJKVKzOvDt4dqTCxcSIxX7XLyag8cRWULu22/sN7I09pPC6CnqtquFA9Q
	 bwNh8mKUom18seJMkfP059abI+x6/P56hyARwmJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441640AbgDOTLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:11:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416861AbgDOSts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:49:48 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18228215A4;
        Wed, 15 Apr 2020 18:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586976588;
        bh=qliPcXgbk/xRPVAz0PYha9JPnj6oxTj+gchEtQmm5FI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p8636ajAogvbWYwXcGWeD5pUPWrNrv2REdMrxjlktzanL8Bp3mU0DzVf184LKAjgy
         1u3GPUk75QSgnmxZjCUbOXwkScqmALCzYHVWsGGjju+j040urjjVGpYSQ/BUxPts4Y
         qjvE3XiVAagtZeAmG/9wF+3EYDPEeVCTeEi5GfNw=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH lkmm tip/core/rcu 05/10] Documentation: LKMM: Add litmus test for RCU GP guarantee where reader stores
Date:   Wed, 15 Apr 2020 11:49:40 -0700
Message-Id: <20200415184945.16487-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415183343.GA12265@paulmck-ThinkPad-P72>
References: <20200415183343.GA12265@paulmck-ThinkPad-P72>
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
 Documentation/litmus-tests/README                  |  5 +++
 .../litmus-tests/rcu/RCU+sync+read.litmus          | 37 ++++++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 Documentation/litmus-tests/rcu/RCU+sync+read.litmus

diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
index 84208bc..79d187f 100644
--- a/Documentation/litmus-tests/README
+++ b/Documentation/litmus-tests/README
@@ -7,3 +7,8 @@ RCU (/rcu directory)
 MP+onceassign+derefonce.litmus
     Demonstrates that rcu_assign_pointer() and rcu_dereference() to
     ensure that an RCU reader will not see pre-initialization garbage.
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

