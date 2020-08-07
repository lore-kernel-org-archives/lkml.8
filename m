Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1A1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 03:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5892222CAF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 03:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uDRrlxTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgHGDcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 23:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgHGDco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 23:32:44 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C9CC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 20:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=YLxCW6xg6sz+b32+oQ80pTmUSAxJU4PIX9UyCAmR5KE=; b=uDRrlxTFktRSNcFduUpvin8Jyn
        i5dHJX+PhTsoYuSMsSFgYUHrCXF/zTxWKqegYOOVeKIYo3D7jNzDEWxCz0S+K6NjEC3hNT/EYXSnL
        qftWeBBiOWg8jDEnx9KNU4wVoQAKnpSGnOO8Szm4RWdgLSrzJVD46rQqC9nxYG8p6Wiv9LUJ6r2/P
        tytzh7vVMHny6dW/2WH0nM/V/6yA3Xy2Qgz6K2z+31Hk31pMcR6lUAYYgd/dGcL8jC69ufzJfvnYr
        kF8oXqMZULO7t1eY2fMCMcSz+zbubc1SihfKKhSqumGjl1IHQmWy0dVz/URUaZldhqPmcgkGB3MW6
        2zn2R6Hw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3t7Z-0006pC-9H; Fri, 07 Aug 2020 03:32:41 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] kernel: sched: delete repeated words in comments
Date:   Thu,  6 Aug 2020 20:32:36 -0700
Message-Id: <20200807033236.8400-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop repeated words in kernel/sched/.
{in, not}

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c       |    2 +-
 kernel/sched/membarrier.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200806.orig/kernel/sched/fair.c
+++ linux-next-20200806/kernel/sched/fair.c
@@ -5109,7 +5109,7 @@ static void do_sched_cfs_slack_timer(str
 /*
  * When a group wakes up we want to make sure that its quota is not already
  * expired/exceeded, otherwise it may be allowed to steal additional ticks of
- * runtime as update_curr() throttling can not not trigger until it's on-rq.
+ * runtime as update_curr() throttling can not trigger until it's on-rq.
  */
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq)
 {
--- linux-next-20200806.orig/kernel/sched/membarrier.c
+++ linux-next-20200806/kernel/sched/membarrier.c
@@ -229,7 +229,7 @@ static int sync_runqueues_membarrier_sta
 
 	/*
 	 * For each cpu runqueue, if the task's mm match @mm, ensure that all
-	 * @mm's membarrier state set bits are also set in in the runqueue's
+	 * @mm's membarrier state set bits are also set in the runqueue's
 	 * membarrier state. This ensures that a runqueue scheduling
 	 * between threads which are users of @mm has its membarrier state
 	 * updated.
