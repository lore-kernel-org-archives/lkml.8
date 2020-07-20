Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0978FC433F8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC64122CB2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595259577;
	bh=OKdb+YSLf5LN+NT2gPEeYDmw6M4oyqgIEYE8Ybajrws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Iv/42JKARJln5q0Ki2vKatly9g1A6VTqK2TwYBmhRaDHmcNTFg0SzUi2Dun6V5Wdq
	 UZmM4ijicm+qXUuwXg6Ki+t98k7J7a8ik0DqpJCom2P4kv4Z4i1HCQPmSP6Ia1WMna
	 haLtqkdIEcTOGKlrVlXKWVO+6vRJ3CzprEpxHUFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbgGTPjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:39:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729527AbgGTPje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:39:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E60522CF7;
        Mon, 20 Jul 2020 15:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259573;
        bh=OKdb+YSLf5LN+NT2gPEeYDmw6M4oyqgIEYE8Ybajrws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TacfXhk7j6mkJ2szT+Ss87bTP8WgEofwRMtF7OHBqEDD9JqBYfv03MGlNTlFv7hFW
         hXW/i0AtEhUOFs0xmSfGzVoFiKQsa3XNDRCY3mUF/Xy+lvwUo/gt9i+yKV+wvh97Ae
         DTlQHl8CDce9/PStinOFBG3QQMjb/Epjflf/xhiA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [PATCH 4.4 58/58] sched/fair: handle case of task_h_load() returning 0
Date:   Mon, 20 Jul 2020 17:37:14 +0200
Message-Id: <20200720152750.160417898@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152747.127988571@linuxfoundation.org>
References: <20200720152747.127988571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Guittot <vincent.guittot@linaro.org>

commit 01cfcde9c26d8555f0e6e9aea9d6049f87683998 upstream.

task_h_load() can return 0 in some situations like running stress-ng
mmapfork, which forks thousands of threads, in a sched group on a 224 cores
system. The load balance doesn't handle this correctly because
env->imbalance never decreases and it will stop pulling tasks only after
reaching loop_max, which can be equal to the number of running tasks of
the cfs. Make sure that imbalance will be decreased by at least 1.

misfit task is the other feature that doesn't handle correctly such
situation although it's probably more difficult to face the problem
because of the smaller number of CPUs and running tasks on heterogenous
system.

We can't simply ensure that task_h_load() returns at least one because it
would imply to handle underflow in other places.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: <stable@vger.kernel.org> # v4.4+
Link: https://lkml.kernel.org/r/20200710152426.16981-1-vincent.guittot@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/fair.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5939,7 +5939,15 @@ static int detach_tasks(struct lb_env *e
 		if (!can_migrate_task(p, env))
 			goto next;
 
-		load = task_h_load(p);
+		/*
+		 * Depending of the number of CPUs and tasks and the
+		 * cgroup hierarchy, task_h_load() can return a null
+		 * value. Make sure that env->imbalance decreases
+		 * otherwise detach_tasks() will stop only after
+		 * detaching up to loop_max tasks.
+		 */
+		load = max_t(unsigned long, task_h_load(p), 1);
+
 
 		if (sched_feat(LB_MIN) && load < 16 && !env->sd->nr_balance_failed)
 			goto next;


