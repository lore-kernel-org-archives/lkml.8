Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62845C3B1BF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 00:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7FE2081E
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 00:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581726337;
	bh=aFrC3VieevuRGK51bLjR/jOgJU4Z132NOHODkIr6RY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JR2o2pHgu/PHp2MVfej4zJTZwVRyfXSw9VtMl9PDVkSN+qtr1aDn/nwRN86bWmJ/J
	 M/pcC/GNUUnnPA6oN51bgqLmVNREV7PniXH6q+HBTmwtwWXlXdrcDJBCfgovFsf8g+
	 kz5DC58oL6uCi1I5/y5xWvuYU7Y+6e/xa+PzPXcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgBOAZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:25:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:44644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbgBOAZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:25:35 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2731217F4;
        Sat, 15 Feb 2020 00:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581726335;
        bh=aFrC3VieevuRGK51bLjR/jOgJU4Z132NOHODkIr6RY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=suWQwk61nyILqEM0dShQlMtzklw3V1thzcmJiyyqh+RR1mi2VdaB5PsXj1w/ERsAo
         3MnDMzC/2zQlObA4ZYj+wvIcbOB39EKsJjUK8pUT7lZSQwLY75wnCngRL0e5pnWhJC
         VA3sh3FpzxYkpjTQbFT2/oLbqpKKBzR1EEs35zZc=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Jules Irenge <jbi.octave@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 3/3] rcu: Add missing annotation for exit_tasks_rcu_finish()
Date:   Fri, 14 Feb 2020 16:25:20 -0800
Message-Id: <20200215002520.15746-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215002446.GA15663@paulmck-ThinkPad-P72>
References: <20200215002446.GA15663@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jules Irenge <jbi.octave@gmail.com>

Sparse reports a warning at exit_tasks_rcu_finish(void)

|warning: context imbalance in exit_tasks_rcu_finish()
|- wrong count at exit

To fix this, this commit adds a __releases(&tasks_rcu_exit_srcu).
Given that exit_tasks_rcu_finish() does actually call __srcu_read_lock(),
this not only fixes the warning but also improves on the readability of
the code.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/update.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index a04fe54..ede656c 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -809,7 +809,7 @@ void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
 }
 
 /* Do the srcu_read_unlock() for the above synchronize_srcu().  */
-void exit_tasks_rcu_finish(void)
+void exit_tasks_rcu_finish(void) __releases(&tasks_rcu_exit_srcu)
 {
 	preempt_disable();
 	__srcu_read_unlock(&tasks_rcu_exit_srcu, current->rcu_tasks_idx);
-- 
2.9.5

