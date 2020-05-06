Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23DBC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E0F020575
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QJnPZ/fH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgEFOSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 10:18:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51454 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728555AbgEFOSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 10:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588774710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Xx8NZJaUL0RR3l7R3ci+3F53w2H1axeM8TrTtW6I+X0=;
        b=QJnPZ/fHM4Top9JQZEpt3wkiyTOxIp2c6lx9VoRKPX7c8IESVT12465b1t6EQ77SkWqFGV
        gpEPUDylOVUZeLr8OR2vWhgWFYlv0EItMmeM0WjWLQnE+Dl1T9rqVDZI7E4bFbwXT+wYX2
        UrojG37pAkIRE79IxZWYvRA5cnYDg2w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-fr5VGyzUPta0zP_gqPMaqg-1; Wed, 06 May 2020 10:18:27 -0400
X-MC-Unique: fr5VGyzUPta0zP_gqPMaqg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2809B835B41;
        Wed,  6 May 2020 14:18:26 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-114-141.phx2.redhat.com [10.3.114.141])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C9FFF5F7E2;
        Wed,  6 May 2020 14:18:22 +0000 (UTC)
Date:   Wed, 6 May 2020 10:18:21 -0400
From:   Phil Auld <pauld@redhat.com>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        vincent.guittot@linaro.org, juri.lelli@redhat.com
Subject: [PATCH] sched/fair: Fix enqueue_task_fair warning some more
Message-ID: <20200506141821.GA9773@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sched/fair: Fix enqueue_task_fair warning some more

The recent patch, fe61468b2cb (sched/fair: Fix enqueue_task_fair warning)
did not fully resolve the issues with the (rq->tmp_alone_branch !=
&rq->leaf_cfs_rq_list) warning in enqueue_task_fair. There is a case where
the first for_each_sched_entity loop exits due to on_rq, having incompletely
updated the list.  In this case the second for_each_sched_entity loop can
further modify se. The later code to fix up the list management fails to do
what is needed because se does not point to the sched_entity which broke out
of the first loop.

Address this issue by saving the se pointer when the first loop exits and
resetting it before doing the fix up, if needed.

Signed-off-by: Phil Auld <pauld@redhat.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/fair.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 02f323b85b6d..719c996317e3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5432,6 +5432,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
+	struct sched_entity *saved_se = NULL;
 	int idle_h_nr_running = task_has_idle_policy(p);
 
 	/*
@@ -5466,6 +5467,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		flags = ENQUEUE_WAKEUP;
 	}
 
+	saved_se = se;
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 
@@ -5510,6 +5512,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		 * leaf list maintenance, resulting in triggering the assertion
 		 * below.
 		 */
+		if (saved_se)
+			se = saved_se;
 		for_each_sched_entity(se) {
 			cfs_rq = cfs_rq_of(se);
 
-- 
2.18.0


Cheers,
Phil

