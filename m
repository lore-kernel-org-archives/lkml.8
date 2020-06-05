Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1CEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E9F72075B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591360200;
	bh=Vd13UFuLRvX/wXDN1nr/A/1EkJ1sZrXmJi+i4KKoCh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UgsJuzxdv/HZPrBxRGjxac2Ogtm5yM7f0ub085dHGM4pbHwJwtM29X/6TCVK5WfjG
	 9FKDMINpzNyXsmpcitgxB1V5iwkJs6Gek3d8//EUqH0UtCGYk9E1Y6n4Zy+hEze0Wa
	 Ur2p/ixGGJ7wnwhADwkxH36hd+lbmpcnRq31JD4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgFEM37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 08:29:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbgFEMZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 08:25:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D080720B80;
        Fri,  5 Jun 2020 12:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591359944;
        bh=Vd13UFuLRvX/wXDN1nr/A/1EkJ1sZrXmJi+i4KKoCh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OaH7mOVIvw9kZz9vUYjpxL69iKIZwEADwXwLFqjZz/alXv7pSwbPsi/U0gno/sMYj
         btsL3rfiJfySw/qGIoy2dEK6Xi2HA70+3iULd05c0Wld9umAQyKSwySFRwLMAokviO
         PdNie6sa6nHc1sF59icLRKDKyu/iPpZW5f71LqxU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 03/14] sched/fair: Don't NUMA balance for kthreads
Date:   Fri,  5 Jun 2020 08:25:29 -0400
Message-Id: <20200605122540.2882539-3-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200605122540.2882539-1-sashal@kernel.org>
References: <20200605122540.2882539-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit 18f855e574d9799a0e7489f8ae6fd8447d0dd74a ]

Stefano reported a crash with using SQPOLL with io_uring:

  BUG: kernel NULL pointer dereference, address: 00000000000003b0
  CPU: 2 PID: 1307 Comm: io_uring-sq Not tainted 5.7.0-rc7 #11
  RIP: 0010:task_numa_work+0x4f/0x2c0
  Call Trace:
   task_work_run+0x68/0xa0
   io_sq_thread+0x252/0x3d0
   kthread+0xf9/0x130
   ret_from_fork+0x35/0x40

which is task_numa_work() oopsing on current->mm being NULL.

The task work is queued by task_tick_numa(), which checks if current->mm is
NULL at the time of the call. But this state isn't necessarily persistent,
if the kthread is using use_mm() to temporarily adopt the mm of a task.

Change the task_tick_numa() check to exclude kernel threads in general,
as it doesn't make sense to attempt ot balance for kthreads anyway.

Reported-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/865de121-8190-5d30-ece5-3b097dc74431@kernel.dk
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 193b6ab74d7f..8a0e6bdba50d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2678,7 +2678,7 @@ static void task_tick_numa(struct rq *rq, struct task_struct *curr)
 	/*
 	 * We don't care about NUMA placement if we don't have memory.
 	 */
-	if (!curr->mm || (curr->flags & PF_EXITING) || work->next != work)
+	if ((curr->flags & (PF_EXITING | PF_KTHREAD)) || work->next != work)
 		return;
 
 	/*
-- 
2.25.1

