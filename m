Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480A5C2D0EE
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 22:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13BB721D79
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 22:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585347918;
	bh=vQe8NVEMs1r1iIdW79nChbeEufogMpa18G/zwHFEoSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VdZScNvnMKnrG7fjMHPvm2sbF2KHFLJRpUzNLCEXSnHI3WxSW83lrRCrPdhwOQ1D4
	 3cANe1b0CfHP/zZBHlBAlYccBD8Rp5AIJ3ZuQm/3L9EUowb8/NsiNWVRY1EtoWOsF3
	 vkQMNqRqSadUIfHdNERbGuMot0Izzl+yVuvc6z3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgC0WZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 18:25:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727848AbgC0WZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 18:25:05 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4348120748;
        Fri, 27 Mar 2020 22:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585347905;
        bh=vQe8NVEMs1r1iIdW79nChbeEufogMpa18G/zwHFEoSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SQiiUl5hDCl4F4W5UrTIKu284R2qZVNjSmhtQ2LuOLwHq2Vi7RxFpkjGaBpt8Fqc1
         35iaRZVOIFutS9ooRUWswhZyjl1s6JhHSkKuGfw2XGXuDYkBXPZ85dtPDacW2OGKYZ
         QrWa1lZ5oMSpCAyqSRJLDh+l5NLCK4wuwuuKxicc=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v3 tip/core/rcu 21/34] rcu-tasks: Add a grace-period start time for throttling and debug
Date:   Fri, 27 Mar 2020 15:24:43 -0700
Message-Id: <20200327222456.12470-21-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200327222346.GA12082@paulmck-ThinkPad-P72>
References: <20200327222346.GA12082@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a place to record the grace-period start in jiffies.
This will be used by later commits for debugging purposes and to throttle
IPIs early in the grace period.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index cbc9905..fa9c069 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -46,6 +46,7 @@ struct rcu_tasks {
 	raw_spinlock_t cbs_lock;
 	int gp_state;
 	unsigned long gp_jiffies;
+	unsigned long gp_start;
 	struct task_struct *kthread_ptr;
 	rcu_tasks_gp_func_t gp_func;
 	pregp_func_t pregp_func;
@@ -200,6 +201,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 
 		// Wait for one grace period.
 		set_tasks_gp_state(rtp, RTGS_WAIT_GP);
+		rtp->gp_start = jiffies;
 		rtp->gp_func(rtp);
 
 		/* Invoke the callbacks. */
-- 
2.9.5

