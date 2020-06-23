Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B7EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFED920706
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592873601;
	bh=Th+jdtartrhmwAEj1KC8jRZjrDuHbjYxGiJX4JBNQZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M3SE1/O0IJx4vkH1DJfGf2x+8kmFlsVKxtdtCfqiMNPwTm/HsDZv7xNQ1QekLHxdV
	 N1cFwzhbPvNnTYmdWL2Iqxd4V5S50cqw32KItCsjwJn6BdbcLCR8QV9HCst4t9xlWs
	 6naflbsjgzL1UUyibw0YV4MIHvVr5IqegbLU45Dk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732490AbgFWAxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:53:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732389AbgFWAwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:52:35 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38A1420767;
        Tue, 23 Jun 2020 00:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592873555;
        bh=Th+jdtartrhmwAEj1KC8jRZjrDuHbjYxGiJX4JBNQZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h6FQm0mWqBJJhrvRUgkDIueGrOo6+7N4a9wJaicrOvFebo/TLr+XDjUa8fHQBNU5u
         JMoIoCmrBG42QMGRRrxW6HqJbo+MjpBHYc+6jKmVozpRoZL4uQ23c/mTAyaK+JzhTW
         ML+RbIJT2YGVDldr5g1x+23hHBWVNjQm3VTttDL8=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 12/14] Documentation/litmus-tests: Cite an RCU litmus test
Date:   Mon, 22 Jun 2020 17:52:29 -0700
Message-Id: <20200623005231.27712-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623005152.GA27459@paulmck-ThinkPad-P72>
References: <20200623005152.GA27459@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

This commit cites a pertinent RCU-related litmus test.

Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Co-developed-by: Akira Yokosawa <akiyks@gmail.com>
[Alan: grammar nit]
[ paulmck: Update commit log and title per Akira feedback. ]
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/litmus-tests/README | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
index ac0b270..b79e640 100644
--- a/Documentation/litmus-tests/README
+++ b/Documentation/litmus-tests/README
@@ -24,6 +24,10 @@ Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
 RCU (/rcu directory)
 --------------------
 
+MP+onceassign+derefonce.litmus (under tools/memory-model/litmus-tests/)
+    Demonstrates the use of rcu_assign_pointer() and rcu_dereference() to
+    ensure that an RCU reader will not see pre-initialization garbage.
+
 RCU+sync+read.litmus
 RCU+sync+free.litmus
     Both the above litmus tests demonstrate the RCU grace period guarantee
-- 
2.9.5

