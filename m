Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A70C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23F962053B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872417;
	bh=sMGNVRXAx+HAT87nCLHIHjcPxoSvxcr3AHtAYuFR1h8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lT3d1uF6kYePNd48xwI4Ruv6pA3xfyRUTYPjxpHqx0GPTy8xXOav5T/8+3sCOp8Rt
	 FjTyTOHp/iE6VOjf9kQX6L6AqzraUbSZM/MeK0pk9M0PrH8kYfqZewoeJzNUCqOZP5
	 IinHEucTa7t0o/erHErdbqcq8jrip2k08YQQYNfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731807AbgFWAdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:33:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731433AbgFWAdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:33:35 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D7DB20720;
        Tue, 23 Jun 2020 00:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872414;
        bh=sMGNVRXAx+HAT87nCLHIHjcPxoSvxcr3AHtAYuFR1h8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PY3vjDIbFdJ23Jxol9uzyR+4tusnl1n5g8DTo5IcRCkq0jcBQwA65G+GAoT7OVkjZ
         AxsxTc/hVs6idiXgCgo7R/3dPN0daxPfcqSagxVaburc9rWzVYb2RcP7L2MWy8bSgd
         9AdUiCoJpQSxf58ukR8mkYL4i9+up5Zug5nlbPeM=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Ethon Paul <ethp@qq.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 1/3] srcu: Fix a typo in comment "amoritized"->"amortized"
Date:   Mon, 22 Jun 2020 17:33:31 -0700
Message-Id: <20200623003333.26611-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623003310.GA26539@paulmck-ThinkPad-P72>
References: <20200623003310.GA26539@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ethon Paul <ethp@qq.com>

This commit fixes a typo in a comment.

Signed-off-by: Ethon Paul <ethp@qq.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 6d3ef70..8ff71e5 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -766,7 +766,7 @@ static void srcu_flip(struct srcu_struct *ssp)
  * it, if this function was preempted for enough time for the counters
  * to wrap, it really doesn't matter whether or not we expedite the grace
  * period.  The extra overhead of a needlessly expedited grace period is
- * negligible when amoritized over that time period, and the extra latency
+ * negligible when amortized over that time period, and the extra latency
  * of a needlessly non-expedited grace period is similarly negligible.
  */
 static bool srcu_might_be_idle(struct srcu_struct *ssp)
-- 
2.9.5

