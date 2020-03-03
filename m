Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F6BC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C116A20870
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583258392;
	bh=dj1HLVWtS06vubJbJJPoUV4zTCw6tLtJL83/NG1u1nE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VnjD+npfZcRtF27EprlixCIQyx1Hp7CIciZM3Jz1IBI9hA7hzKG+oTNerd6q1NXcS
	 vY1TmfE1ZFCvSs9sRwRU3UeZI2tgz6lg9vk7CPvx4D9kobukEqVI1O5qr36nqVJUav
	 fw+e4g3+CMHuvxlpKHZ5+Ic/z3mRKkVU/LNi1YP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731782AbgCCR7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:59:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:43062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387643AbgCCR7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:59:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F287C2072D;
        Tue,  3 Mar 2020 17:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583258380;
        bh=dj1HLVWtS06vubJbJJPoUV4zTCw6tLtJL83/NG1u1nE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v78R/8GkdSLLIWIS6uLUgcvIBybKQ8h0ddx+9y0hjB+h/Uas6iI6XOHaeUP9BFVPX
         39yeTGE1Ndp/rnUNgoHZKHywaGy9trLWAK6X/LBMLkoIPqWgexffyjr5Ql5UXgLc2M
         NtqW1l7TBBV2bbOMVZyI2ynh1obcbPsPnux8sMXw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Scott Wood <swood@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 05/87] sched/core: Dont skip remote tick for idle CPUs
Date:   Tue,  3 Mar 2020 18:42:56 +0100
Message-Id: <20200303174349.478213998@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174349.075101355@linuxfoundation.org>
References: <20200303174349.075101355@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Scott Wood <swood@redhat.com>

[ Upstream commit 488603b815a7514c7009e6fc339d74ed4a30f343 ]

This will be used in the next patch to get a loadavg update from
nohz cpus.  The delta check is skipped because idle_sched_class
doesn't update se.exec_start.

Signed-off-by: Scott Wood <swood@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/1578736419-14628-2-git-send-email-swood@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2befd2c4ce9e6..3c7e039eae9a1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3117,22 +3117,24 @@ static void sched_tick_remote(struct work_struct *work)
 	 * statistics and checks timeslices in a time-independent way, regardless
 	 * of when exactly it is running.
 	 */
-	if (idle_cpu(cpu) || !tick_nohz_tick_stopped_cpu(cpu))
+	if (!tick_nohz_tick_stopped_cpu(cpu))
 		goto out_requeue;
 
 	rq_lock_irq(rq, &rf);
 	curr = rq->curr;
-	if (is_idle_task(curr) || cpu_is_offline(cpu))
+	if (cpu_is_offline(cpu))
 		goto out_unlock;
 
 	update_rq_clock(rq);
-	delta = rq_clock_task(rq) - curr->se.exec_start;
 
-	/*
-	 * Make sure the next tick runs within a reasonable
-	 * amount of time.
-	 */
-	WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
+	if (!is_idle_task(curr)) {
+		/*
+		 * Make sure the next tick runs within a reasonable
+		 * amount of time.
+		 */
+		delta = rq_clock_task(rq) - curr->se.exec_start;
+		WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
+	}
 	curr->sched_class->task_tick(rq, curr, 0);
 
 out_unlock:
-- 
2.20.1



