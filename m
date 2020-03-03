Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0204BC3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9731206D5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583257981;
	bh=04bLf5ZF+iT/s2pbQBzlAHsRKIocpNNdPK6H9ClI+ag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bRVttxeXgNEFvHeHKCyfGBube1rOgyjbziQD5rDWQnSd76G4HchDwQDqUHvKX+gZy
	 ZfY6JkgMlQk2DY+FjzLSMTAvLkARwj+DsT+KpMGWjJAQfhNf1JsRjF1ZTTyZrrtYUG
	 Sk6u3EU4pgp9y2Hxh7LFLDhhMsYgVcCLeKWWiAgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732270AbgCCRxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:53:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:33322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732253AbgCCRw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:52:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C683320728;
        Tue,  3 Mar 2020 17:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583257975;
        bh=04bLf5ZF+iT/s2pbQBzlAHsRKIocpNNdPK6H9ClI+ag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vDfz2D3aMvfx2PLyOQJ6zSZkXwbUge5AWW9CeaJOxUirN+hc1FMH1RHJYSkFBVwgN
         iVr5hdhcdHewyiDpGC7a05AJjHfcVK03M/he9Ie5svdFyR6TRLRPFACN7Q9yeiuJNw
         nbIiCOKTKZUrdrj9hPJwZL2/+/+E+3itpL7GYtpg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Scott Wood <swood@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 024/152] sched/core: Dont skip remote tick for idle CPUs
Date:   Tue,  3 Mar 2020 18:42:02 +0100
Message-Id: <20200303174305.197468611@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174302.523080016@linuxfoundation.org>
References: <20200303174302.523080016@linuxfoundation.org>
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
 kernel/sched/core.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3668,22 +3668,24 @@ static void sched_tick_remote(struct wor
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


