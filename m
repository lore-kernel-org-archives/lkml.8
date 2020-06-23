Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617A4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CBCE2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592871779;
	bh=/CiuJ8N63nbne1ba3aBdq1NMNrybxRRLEfsSFK702sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RCS/S6yBp4aj1+2qs2jJQ6u2CzG68BvqHScmLfMpbQEAD0GI7Ha22QdTuEOnraolC
	 T0iy1tNGxoLob/Nko8ugAXep/6pannnXNNmXF4W0nXdq50PE9xqTwju2Ks6d0u3Aoj
	 28HvJp0rCriEjY9WLrYvwsDI5AFAkJEZPV4Us3Jw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731767AbgFWAW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:22:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:48154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731527AbgFWAVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:21:52 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BF4820836;
        Tue, 23 Jun 2020 00:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592871711;
        bh=/CiuJ8N63nbne1ba3aBdq1NMNrybxRRLEfsSFK702sc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y7pQnvCrFGvgYPEhxYMLUGYpoq81ZqznQCNOdfMRRk4GKBgLihsuuogZG9QiC5cvk
         Hv55xQrpWgz/dQpYN3rwOOHDSRet5yYTq9th2y7ESyOAnhulN2Nr4CIScbr+boQuDZ
         ndgLUaYgIjDmv7vqYkbvO0/lCND3HnVr/rzq8AI4=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Lihao Liang <lihaoliang@google.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 12/26] rcu: Update comment from rsp->rcu_gp_seq to rsp->gp_seq
Date:   Mon, 22 Jun 2020 17:21:33 -0700
Message-Id: <20200623002147.25750-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002128.GA25456@paulmck-ThinkPad-P72>
References: <20200623002128.GA25456@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lihao Liang <lihaoliang@google.com>

Signed-off-by: Lihao Liang <lihaoliang@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 9c6f734..575745f 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -41,7 +41,7 @@ struct rcu_node {
 	raw_spinlock_t __private lock;	/* Root rcu_node's lock protects */
 					/*  some rcu_state fields as well as */
 					/*  following. */
-	unsigned long gp_seq;	/* Track rsp->rcu_gp_seq. */
+	unsigned long gp_seq;	/* Track rsp->gp_seq. */
 	unsigned long gp_seq_needed; /* Track furthest future GP request. */
 	unsigned long completedqs; /* All QSes done for this node. */
 	unsigned long qsmask;	/* CPUs or groups that need to switch in */
@@ -149,7 +149,7 @@ union rcu_noqs {
 /* Per-CPU data for read-copy update. */
 struct rcu_data {
 	/* 1) quiescent-state and grace-period handling : */
-	unsigned long	gp_seq;		/* Track rsp->rcu_gp_seq counter. */
+	unsigned long	gp_seq;		/* Track rsp->gp_seq counter. */
 	unsigned long	gp_seq_needed;	/* Track furthest future GP request. */
 	union rcu_noqs	cpu_no_qs;	/* No QSes yet for this CPU. */
 	bool		core_needs_qs;	/* Core waits for quiesc state. */
-- 
2.9.5

