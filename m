Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683F7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AB03208B8
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592871726;
	bh=DGy4EdNKG0yljU+ZxMTFgQoinjFh+ymTJxVXMdydMzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MAXPo14R1nu1XQ6lK4jKyiotPCtVZrcOLnQAgS20lpZ9Q/j29aLKBqk/eFEQNxk1H
	 tt2QP0y80j0EhMzZ4wr/raers7pXzy8raioi/xXQ3w1b+1dR6Z0GMiVbrp0Jy3s0TY
	 4QXuVNHUKgdAmGfJCIynrFKZDfv3MUt0DIk3q2FQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731637AbgFWAWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:22:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:48094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731496AbgFWAVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:21:51 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4597520857;
        Tue, 23 Jun 2020 00:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592871711;
        bh=DGy4EdNKG0yljU+ZxMTFgQoinjFh+ymTJxVXMdydMzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bu/H9mPTtzQhsrTWNwFzPrC02vg+1jZPjxukM5Z+j4HYG4aoLp3a9aBmp1A/B90jQ
         vm0oWD0CxH+RM0EKL3qvcTtZKcAbZjZNoCXWY3E/CySnVj/jCtzqUvnE1QE+gpHJWh
         jK/5m1q1EFMhw1CufD3/cGLQSCi/HrgA9B1TRACY=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 10/26] rcu: Expedited grace-period sleeps to idle priority
Date:   Mon, 22 Jun 2020 17:21:31 -0700
Message-Id: <20200623002147.25750-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002128.GA25456@paulmck-ThinkPad-P72>
References: <20200623002128.GA25456@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit converts the schedule_timeout_uninterruptible() call used
by RCU's expedited grace-period processing to schedule_timeout_idle().
This conversion avoids polluting the load-average with RCU-related
sleeping.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 72952ed..1888c0e 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -403,7 +403,7 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 			/* Online, so delay for a bit and try again. */
 			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 			trace_rcu_exp_grace_period(rcu_state.name, rcu_exp_gp_seq_endval(), TPS("selectofl"));
-			schedule_timeout_uninterruptible(1);
+			schedule_timeout_idle(1);
 			goto retry_ipi;
 		}
 		/* CPU really is offline, so we must report its QS. */
-- 
2.9.5

