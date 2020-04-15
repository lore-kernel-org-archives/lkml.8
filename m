Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6048C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 979CC21734
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586970769;
	bh=KYD8+W5IgD2AkDof0MwUojG9ZeSTMNtc3XO6QSao+aQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yKYXwmN0a50/sAgpI8rCts7hwqIM457ImP2vcfzCg4VZlDyCJYHGcZ6Wij5KwqeNp
	 ux88n8QAyzJxwyW+mQ5tBLZ0oBGUGh7hjuhBv7lXRnqhcewsBZQpyqpAV1rulRT2a7
	 JoJyoOVdzq/Cl4TPDn1wY2mIl7ryeIxsq9jEVacA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416462AbgDORMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:12:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410717AbgDORK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:10:59 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7AF221D7B;
        Wed, 15 Apr 2020 17:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586970658;
        bh=KYD8+W5IgD2AkDof0MwUojG9ZeSTMNtc3XO6QSao+aQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ru+f9t05X4n9+3mdyIXkqozhH+Tm1/f1qN9rnA8gIUCGCMoSTEukkKbgwWZs7nk6c
         Tp48kioSedWjOSopHRfuBZBhlhltJvUkQz+Gi5HYk9kmmLD6c/+vXeag8MXgGVcaiq
         cSRpZGoJT194BBuYjisb8sgzqDp5dFFDjbYvBSwc=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 06/19] srcu: Add data_race() to ->srcu_lock_count and ->srcu_unlock_count arrays
Date:   Wed, 15 Apr 2020 10:10:41 -0700
Message-Id: <20200415171054.9013-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415171017.GA7821@paulmck-ThinkPad-P72>
References: <20200415171017.GA7821@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The srcu_data structure's ->srcu_lock_count and ->srcu_unlock_count arrays
are read and written locklessly, so this commit adds the data_race()
to the diagnostic-print loads from these arrays in order mark them as
known and approved data-racy accesses.

This data race was reported by KCSAN. Not appropriate for backporting due
to failure being unlikely and due to this being used only by rcutorture.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index ba2b751..6d3ef70 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1281,8 +1281,8 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
 		struct srcu_data *sdp;
 
 		sdp = per_cpu_ptr(ssp->sda, cpu);
-		u0 = sdp->srcu_unlock_count[!idx];
-		u1 = sdp->srcu_unlock_count[idx];
+		u0 = data_race(sdp->srcu_unlock_count[!idx]);
+		u1 = data_race(sdp->srcu_unlock_count[idx]);
 
 		/*
 		 * Make sure that a lock is always counted if the corresponding
@@ -1290,8 +1290,8 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
 		 */
 		smp_rmb();
 
-		l0 = sdp->srcu_lock_count[!idx];
-		l1 = sdp->srcu_lock_count[idx];
+		l0 = data_race(sdp->srcu_lock_count[!idx]);
+		l1 = data_race(sdp->srcu_lock_count[idx]);
 
 		c0 = l0 - u0;
 		c1 = l1 - u1;
-- 
2.9.5

