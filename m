Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80892CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7CED2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dUlRC2wU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388592AbgEMNzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgEMNzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:55:12 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C338EC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:55:11 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l18so20993155wrn.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=48yigY3AW0OWi2KarYrK3onBX5FM3CeGZqGr4rehEH0=;
        b=dUlRC2wU20YGQCEEu1spx689311kjDxpkjS7LRClVxEbFbv2IhwNfObt/CcB9LTjxi
         GpPw77ArCZqrtdPobECOYSjrkvQC8EeC5xe34FaECex0AAFRfIIHzkRGugDupGlhGDtR
         m5QrEvnf4zKf+8z3Z+E0j+sjSFGYLLRVuYJrKe1GYXsWkUYxZnhDlT7fXgXwoXMusaoQ
         swzVpEBtDOZxfZ3TcBZqHRUnQRKW9pvva9dqNqnx4DqgOlMfcHi3NDyS7F3MOOSAuCUT
         BliWn0MMglQYgF5E17RByLHHuMTn3P8Z9IkFp5UhRPlkX+yvyixDxjSdpmdJbXiT4H2t
         JHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=48yigY3AW0OWi2KarYrK3onBX5FM3CeGZqGr4rehEH0=;
        b=N/GFgYxIrFtuRuKlJrXpJGvWFRXNyrDi5E8SthDo2MZdhnqou/5kTQlq0BPVBGuWIt
         tNjJ72nEwFlq/6t/2h/GIWJ2T1XE5MoK64AMmkrQJI/kTGGNdjyiWiLislKnU28E84FV
         0W4DNVm0RBbF51mdKi7zBe0qVK2mdEd9/Von7/RvuEC+nzfyvPcpAGMUWjXCrRApnmbU
         SiBp6UOqeN8YpsKKu2YRfFMOAePgi1uHKU5lyymxcxkpXVBpd0apn7jbtmZAbTOlN/1R
         xBILt/oqcYB758F1GyVlU5LY2Vym83CsXLtDrf4R6Ye9ByK9bHWIuqlfk3pJBSXDzSMA
         vDUA==
X-Gm-Message-State: AGi0PuYj9iECaLPQK16YCLdGnYp9kDa6Vy5Eyt3sSCkdnmHxBFbKiQCW
        HMxXRS+mCq/frxQvqWD4itdMVw==
X-Google-Smtp-Source: APiQypJCdW+0lUJ5TdZTUHT0D3gjO6fpf4NeDs72V8iSEyo17JjX0nvKvG2A1t2tmcLDBG8xdGOifA==
X-Received: by 2002:a5d:550c:: with SMTP id b12mr33201422wrv.152.1589378110345;
        Wed, 13 May 2020 06:55:10 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:e00f:4685:acf1:ea5e])
        by smtp.gmail.com with ESMTPSA id g6sm27619898wrw.34.2020.05.13.06.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 06:55:09 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     pauld@redhat.com, ouwen210@hotmail.com, pkondeti@codeaurora.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3] sched/fair: enqueue_task_fair optimization
Date:   Wed, 13 May 2020 15:55:02 +0200
Message-Id: <20200513135502.4672-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enqueue_task_fair jumps to enqueue_throttle label when cfs_rq_of(se) is
throttled which means that se can't be NULL in such case and we can move
the label after the if (!se) statement. Futhermore, the latter can be
removed because se is always NULL when reaching this point.

Reviewed-by: Phil Auld <pauld@redhat.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

v3 changes:
  - updated commit message 
  - removed an extra }

 kernel/sched/fair.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9a58874ef104..4e586863827b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5512,28 +5512,27 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
                        list_add_leaf_cfs_rq(cfs_rq);
 	}
 
-enqueue_throttle:
-	if (!se) {
-		add_nr_running(rq, 1);
-		/*
-		 * Since new tasks are assigned an initial util_avg equal to
-		 * half of the spare capacity of their CPU, tiny tasks have the
-		 * ability to cross the overutilized threshold, which will
-		 * result in the load balancer ruining all the task placement
-		 * done by EAS. As a way to mitigate that effect, do not account
-		 * for the first enqueue operation of new tasks during the
-		 * overutilized flag detection.
-		 *
-		 * A better way of solving this problem would be to wait for
-		 * the PELT signals of tasks to converge before taking them
-		 * into account, but that is not straightforward to implement,
-		 * and the following generally works well enough in practice.
-		 */
-		if (flags & ENQUEUE_WAKEUP)
-			update_overutilized_status(rq);
+	/* At this point se is NULL and we are at root level*/
+	add_nr_running(rq, 1);
 
-	}
+	/*
+	 * Since new tasks are assigned an initial util_avg equal to
+	 * half of the spare capacity of their CPU, tiny tasks have the
+	 * ability to cross the overutilized threshold, which will
+	 * result in the load balancer ruining all the task placement
+	 * done by EAS. As a way to mitigate that effect, do not account
+	 * for the first enqueue operation of new tasks during the
+	 * overutilized flag detection.
+	 *
+	 * A better way of solving this problem would be to wait for
+	 * the PELT signals of tasks to converge before taking them
+	 * into account, but that is not straightforward to implement,
+	 * and the following generally works well enough in practice.
+	 */
+	if (flags & ENQUEUE_WAKEUP)
+		update_overutilized_status(rq);
 
+enqueue_throttle:
 	if (cfs_bandwidth_used()) {
 		/*
 		 * When bandwidth control is enabled; the cfs_rq_throttled()
-- 
2.17.1

