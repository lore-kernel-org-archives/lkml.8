Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F543C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D876D20825
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ricYBYUu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MLNLEXkI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgH0Hzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbgH0Hye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC54C061232;
        Thu, 27 Aug 2020 00:54:34 -0700 (PDT)
Date:   Thu, 27 Aug 2020 07:54:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514872;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ChM+Uq35sX54+YM5wxygWB7jqAbga2vQAz560SeCEs=;
        b=ricYBYUupUDf5io+EkjXMoyQ/Bl3eR1tIy/Ll+xFPsAmVtUEMP2SOBVlTXE6PVysLinX91
        u3rFfWIVVnC+Fe2UfSbNJ9Un+9Hg7sYajp1KLLWzSJH6FAjOmY1WKH5D+e91FbNtUdgAkm
        9j0Shz0zSl3InRF2Eh1cb0VXY4alG18OBVoBpFj9DGyj61zubE8eSHkht928l0uJJ4Py0F
        fp5dOB6vLrDvIV4sdFN7lzqrwLSL/jMoCJwmPNhyQmIZbyK7QB4Bj1Whze4/dGvOcPJtOp
        sRIr4ZFFKgpOzvuxtgmLrCmy7bEw37izTjSG8ptXCPUDi+OHHpoEgx4Q1Gwgkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514872;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ChM+Uq35sX54+YM5wxygWB7jqAbga2vQAz560SeCEs=;
        b=MLNLEXkIU7PjV3IepMwisZZYTJHNbOXfyY4LO3ZZP4WI7HxjL6B9SaqlW3iuVR0F3RxECb
        Za7EiLDWUJ4fLECQ==
From:   "tip-bot2 for Jiang Biao" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Simplify the work when reweighting entity
Cc:     Jiang Biao <benbjiang@tencent.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200811113209.34057-1-benbjiang@tencent.com>
References: <20200811113209.34057-1-benbjiang@tencent.com>
MIME-Version: 1.0
Message-ID: <159851487221.20229.12705321307195312312.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1724b95b92979a8ea8e55a4817d05b3bb7750958
Gitweb:        https://git.kernel.org/tip/1724b95b92979a8ea8e55a4817d05b3bb7750958
Author:        Jiang Biao <benbjiang@tencent.com>
AuthorDate:    Tue, 11 Aug 2020 19:32:09 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:41:58 +02:00

sched/fair: Simplify the work when reweighting entity

The code in reweight_entity() can be simplified.

For a sched entity on the rq, the entity accounting can be replaced by
cfs_rq instantaneous load updates currently called from within the
entity accounting.

Even though an entity on the rq can't represent a task in
reweight_entity() (a task is always dequeued before calling this
function) and so the numa task accounting and the rq->cfs_tasks list
management of the entity accounting are never called, the redundant
cfs_rq->nr_running decrement/increment will be avoided.

Signed-off-by: Jiang Biao <benbjiang@tencent.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20200811113209.34057-1-benbjiang@tencent.com
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 90ebaa4..33699db 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3084,7 +3084,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 		/* commit outstanding execution time */
 		if (cfs_rq->curr == se)
 			update_curr(cfs_rq);
-		account_entity_dequeue(cfs_rq, se);
+		update_load_sub(&cfs_rq->load, se->load.weight);
 	}
 	dequeue_load_avg(cfs_rq, se);
 
@@ -3100,7 +3100,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 
 	enqueue_load_avg(cfs_rq, se);
 	if (se->on_rq)
-		account_entity_enqueue(cfs_rq, se);
+		update_load_add(&cfs_rq->load, se->load.weight);
 
 }
 
