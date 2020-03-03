Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1FDC3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7527208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583257528;
	bh=QSddxbOIuXOSIenujxjq0OMAUwUhOp52UmJF0c0wavs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mpoCPayZknYL2MSEDZxm9bTZ2QOdn9Kn6y4kxTG8b0weFC9c2csmcII5CvixdB8V4
	 kdYuh3ECOzlJ+IVXpkqetlDKNQ/dAO7W7NC8X1OaJU5mnQ+Dv7ztbJ7PdCGUjPbaEY
	 WaT7Z84LbMoxcl+SeIFXbDck1kCI5XlPS4Eht78k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730933AbgCCRp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:45:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:51360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730916AbgCCRpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:45:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF78C2146E;
        Tue,  3 Mar 2020 17:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583257522;
        bh=QSddxbOIuXOSIenujxjq0OMAUwUhOp52UmJF0c0wavs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IgRF9f+FCvryGrBRM3segbuSZzdGG3M8M0h33aqbDL061uvse9xTodnpon0RIBJ6S
         eSfr8a/Nz3TbToxFSEjqxztYwJf0UwsLPZ2HZj+U2249utHAUelvph2P2E8AAU0b4q
         B47CLoKhVIVez1ZcWtQ36m0itMcXOzLiB2GgZbyQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Scott Wood <swood@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 027/176] sched/core: Dont skip remote tick for idle CPUs
Date:   Tue,  3 Mar 2020 18:41:31 +0100
Message-Id: <20200303174307.647824604@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174304.593872177@linuxfoundation.org>
References: <20200303174304.593872177@linuxfoundation.org>
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
index b2564d62a0f74..3cb879f4eb9c6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3669,22 +3669,24 @@ static void sched_tick_remote(struct work_struct *work)
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



