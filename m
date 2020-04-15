Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5714C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 781DD216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586970728;
	bh=ULSCJ4AUZ34fFoHXztiykYhBJYb0OeWc+BVUnx4B4hM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o1AKakvJ3EaYEsgBbPvv9BjjR+Ju2b61vNTzn0J3MVzUmHxGVR4yedyvLfMK0RSFw
	 06IKhoGUBhfETtkVAMVDCmFMLgWbwG9ZdDGb4o9AsIFi4u9YSgmpvmjWx3OcjVd+qt
	 IO6C1C8YrW8LiUbz4cIA5JepHudbkQfHLvuhtFDc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416405AbgDORMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:12:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410719AbgDORLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:11:00 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8862221D82;
        Wed, 15 Apr 2020 17:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586970659;
        bh=ULSCJ4AUZ34fFoHXztiykYhBJYb0OeWc+BVUnx4B4hM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K1uijSpQniBBEY5+f7gv3nDAlpMj3ck9xKzoqh0KYTKIqqcty5+rYa15Bj5+c4zHC
         iqmNycF0EaKHnqn/ACNeFVur3uJyEBHC7VlmckB7HBHJuMX65C/F0CIID4GQ4LlMoI
         pkIkNHLQOzIcHEAY7rJuCT5agj61IqglzBJ2Gtdk=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Zhaolong Zhang <zhangzl2013@126.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 11/19] rcu: Fix the (t=0 jiffies) false positive
Date:   Wed, 15 Apr 2020 10:10:46 -0700
Message-Id: <20200415171054.9013-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415171017.GA7821@paulmck-ThinkPad-P72>
References: <20200415171017.GA7821@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaolong Zhang <zhangzl2013@126.com>

It is possible that an over-long grace period will end while the RCU
CPU stall warning message is printing.  In this case, the estimate of
the offending grace period's duration can be erroneous due to refetching
of rcu_state.gp_start, which will now be the time of the newly started
grace period.  Computation of this duration clearly needs to use the
start time for the old over-long grace period, not the fresh new one.
This commit avoids such errors by causing both print_other_cpu_stall() and
print_cpu_stall() to reuse the value previously fetched by their caller.

Signed-off-by: Zhaolong Zhang <zhangzl2013@126.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index e7da111..3a7bc99 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -371,7 +371,7 @@ static void rcu_check_gp_kthread_starvation(void)
 	}
 }
 
-static void print_other_cpu_stall(unsigned long gp_seq)
+static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 {
 	int cpu;
 	unsigned long flags;
@@ -408,7 +408,7 @@ static void print_other_cpu_stall(unsigned long gp_seq)
 	for_each_possible_cpu(cpu)
 		totqlen += rcu_get_n_cbs_cpu(cpu);
 	pr_cont("\t(detected by %d, t=%ld jiffies, g=%ld, q=%lu)\n",
-	       smp_processor_id(), (long)(jiffies - rcu_state.gp_start),
+	       smp_processor_id(), (long)(jiffies - gps),
 	       (long)rcu_seq_current(&rcu_state.gp_seq), totqlen);
 	if (ndetected) {
 		rcu_dump_cpu_stacks();
@@ -442,7 +442,7 @@ static void print_other_cpu_stall(unsigned long gp_seq)
 	rcu_force_quiescent_state();  /* Kick them all. */
 }
 
-static void print_cpu_stall(void)
+static void print_cpu_stall(unsigned long gps)
 {
 	int cpu;
 	unsigned long flags;
@@ -467,7 +467,7 @@ static void print_cpu_stall(void)
 	for_each_possible_cpu(cpu)
 		totqlen += rcu_get_n_cbs_cpu(cpu);
 	pr_cont("\t(t=%lu jiffies g=%ld q=%lu)\n",
-		jiffies - rcu_state.gp_start,
+		jiffies - gps,
 		(long)rcu_seq_current(&rcu_state.gp_seq), totqlen);
 
 	rcu_check_gp_kthread_starvation();
@@ -546,7 +546,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
 	    cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
 
 		/* We haven't checked in, so go dump stack. */
-		print_cpu_stall();
+		print_cpu_stall(gps);
 		if (rcu_cpu_stall_ftrace_dump)
 			rcu_ftrace_dump(DUMP_ALL);
 
@@ -555,7 +555,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
 		   cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
 
 		/* They had a few time units to dump stack, so complain. */
-		print_other_cpu_stall(gs2);
+		print_other_cpu_stall(gs2, gps);
 		if (rcu_cpu_stall_ftrace_dump)
 			rcu_ftrace_dump(DUMP_ALL);
 	}
-- 
2.9.5

