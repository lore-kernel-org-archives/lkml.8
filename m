Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61B3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A25DE207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gchd5bI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbgFONSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730114AbgFONSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:18:53 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B64C05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 06:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=hmmNwzz5oxkILwbBVmNd4XJD+Tm0JTTO4CoI0JBhoBE=; b=Gchd5bI/MjHaLrmqs0//IjWoZa
        9OVL74MBDGg98qY4+NofPn5i2+CHnzLNFhy0qErzp5uToxPYIJtHMivfvOJJyZUqdxG08XiidP67f
        9ecAcZKU1XuYMUHG639qkRRaOQifTU1Zse+UJxFRL3QNnCgG9qgUBvLZwXBjYK08SVFwaJJdsjxDP
        ZQ57cz7zLFkO/MiS3twouIvVKbZnoqXBiErPzEXREbVrBCjHDHQqLscjphoss2YCxcvgnHZY/h3Y4
        s6fwSL8arPLGyi3m+OA6wxNovxNLQBBDV/duI1ic/VsecfhyP47YNLkFMDiSPvMGddw3JL9PjeC48
        2fvhM7+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkp0F-0004P7-OK; Mon, 15 Jun 2020 13:18:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B7C1E306089;
        Mon, 15 Jun 2020 15:18:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A48302392E70A; Mon, 15 Jun 2020 15:18:16 +0200 (CEST)
Message-ID: <20200615131143.252527836@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 15 Jun 2020 14:56:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        paulmck@kernel.org, frederic@kernel.org, peterz@infradead.org
Subject: [PATCH 3/6] sched: s/WF_ON_RQ/WQ_ON_CPU/
References: <20200615125654.678940605@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoids confusion...

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c  |    4 ++--
 kernel/sched/sched.h |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2380,7 +2380,7 @@ static inline bool ttwu_queue_cond(int c
 	 * the soon-to-be-idle CPU as the current CPU is likely busy.
 	 * nr_running is checked to avoid unnecessary task stacking.
 	 */
-	if ((wake_flags & WF_ON_RQ) && cpu_rq(cpu)->nr_running <= 1)
+	if ((wake_flags & WF_ON_CPU) && cpu_rq(cpu)->nr_running <= 1)
 		return true;
 
 	return false;
@@ -2626,7 +2626,7 @@ try_to_wake_up(struct task_struct *p, un
 	 * let the waker make forward progress. This is safe because IRQs are
 	 * disabled and the IPI will deliver after on_cpu is cleared.
 	 */
-	if (READ_ONCE(p->on_cpu) && ttwu_queue_wakelist(p, cpu, wake_flags | WF_ON_RQ))
+	if (READ_ONCE(p->on_cpu) && ttwu_queue_wakelist(p, cpu, wake_flags | WF_ON_CPU))
 		goto unlock;
 
 	/*
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1682,7 +1682,7 @@ static inline int task_on_rq_migrating(s
 #define WF_SYNC			0x01		/* Waker goes to sleep after wakeup */
 #define WF_FORK			0x02		/* Child wakeup after fork */
 #define WF_MIGRATED		0x04		/* Internal use, task got migrated */
-#define WF_ON_RQ		0x08		/* Wakee is on_rq */
+#define WF_ON_CPU		0x08		/* Wakee is on_cpu */
 
 /*
  * To aid in avoiding the subversion of "niceness" due to uneven distribution


