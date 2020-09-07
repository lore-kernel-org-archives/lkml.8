Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0DBC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 13:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B272215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 13:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z27I9OnE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbgIGNIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 09:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729401AbgIGNFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 09:05:16 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABE3C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 06:05:15 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id v24so4135282uaj.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 06:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KvN1/qLXUSMhUJDichDGSiWqVXXQ7CC04a1pfNpGZyA=;
        b=Z27I9OnECLM+ZyhD/d0xTc2horhrvsOLQS9eVhpTRTH1lCnaiyrMu1Ms1zSzvSSGrW
         DprQLFiclixmGwYGge489zf7VrMGu5uvy5hbiz+BsobufcDZ4wUdRROmBG1X1w/nkGLk
         PIlsUAUJtqwwIYMqTU0HDBXLQKjR24+k0+esQvIpiDkS46FU6FDwGWRbkc2FVeNJzUfT
         6BdP5NbqS+H1mQuXeQJcXZ5kJw1zJycoWwELg9lRq8zx4b5vgjTerTfMwML5lJg70f+p
         vomXM+2U7mMRMkpUPdNPeEY7s7JhIP96B23yRXJbLPqQ8W0nQvnjn8u4y7LmDCCazS4h
         XQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KvN1/qLXUSMhUJDichDGSiWqVXXQ7CC04a1pfNpGZyA=;
        b=pcDCVL9+j9XlVCY3O48QmsmOOVxnkhFygzhUbBrgRuEIVlXS4SrgRG+Yh6rUCtIjiP
         k1EZ0edPnpbtvAudI/7UQR5FywmGdP4LSHOG0TRNjIhLKwaPJNdTniHf693j0q463Ch+
         X8f8tZ28Tl+dLO/QWzUkJx4ccuPYlXeWD4U8jHaRpQKrVhc3SNzdcdpFW6XPZOXV1+Gd
         6LJQABURtAby9iM2gfeDQl8xX6UQqBxY5ZMRX+FvZ6IsGZASC2wnyGdYOjGMyC9iTich
         hM2Uy3W2Zk0K5PwndFcBII2yNwVPQCyQv1pN3Nc44AQZRJcerOzAdEJ+Wy/wNVQEUdu6
         wbww==
X-Gm-Message-State: AOAM532Ln7b1Ni3TiCUqTQ95eB4yK5VriaQ+voejDsjsGQk7pFzBDwa0
        13OmLYwVCwRVChyXJVpCZh8=
X-Google-Smtp-Source: ABdhPJwXCrwOy9Rr9lEHVbe4iLNTVayIw0CNqrA6JjBCja4S70L9vRiAHpklNgRbSB2mr/iPLwDVww==
X-Received: by 2002:ab0:35e9:: with SMTP id w9mr8504571uau.48.1599483915149;
        Mon, 07 Sep 2020 06:05:15 -0700 (PDT)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id f190sm925783vka.1.2020.09.07.06.05.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Sep 2020 06:05:14 -0700 (PDT)
From:   qianjun.kernel@gmail.com
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Cc:     laoar.shao@gmail.com, jun qian <qianjun.kernel@gmail.com>
Subject: [PATCH 1/1] kernel/sched:use the enum code replace of the int variable
Date:   Mon,  7 Sep 2020 21:05:02 +0800
Message-Id: <20200907130502.44200-1-qianjun.kernel@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jun qian <qianjun.kernel@gmail.com>

It is hard to understand what the meaning of the value from
the return value of wakeup_preempt_entity, so I fix it.

Signed-off-by: jun qian <qianjun.kernel@gmail.com>
---
 kernel/sched/fair.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 658aa7a..60bb184 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -86,6 +86,12 @@
 
 const_debug unsigned int sysctl_sched_migration_cost	= 500000UL;
 
+enum preempt_curr_code {
+	NO_NEED_PREEMPT = -1,
+	MAY_NEED_PREEMPT = 0,
+	NEED_PREEMPT = 1,
+};
+
 int sched_thermal_decay_shift;
 static int __init setup_sched_thermal_decay_shift(char *str)
 {
@@ -4445,20 +4451,20 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se)
 				second = curr;
 		}
 
-		if (second && wakeup_preempt_entity(second, left) < 1)
+		if (second && wakeup_preempt_entity(second, left) != NEED_PREEMPT)
 			se = second;
 	}
 
 	/*
 	 * Prefer last buddy, try to return the CPU to a preempted task.
 	 */
-	if (cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, left) < 1)
+	if (cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, left) != NEED_PREEMPT)
 		se = cfs_rq->last;
 
 	/*
 	 * Someone really wants this to run. If it's not unfair, run it.
 	 */
-	if (cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) < 1)
+	if (cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) != NEED_PREEMPT)
 		se = cfs_rq->next;
 
 	clear_buddies(cfs_rq, se);
@@ -6822,9 +6828,9 @@ static unsigned long wakeup_gran(struct sched_entity *se)
  *         g
  *      |<--->|c
  *
- *  w(c, s1) = -1
- *  w(c, s2) =  0
- *  w(c, s3) =  1
+ *  w(c, s1) = NO_NEED_PREEMPT
+ *  w(c, s2) = MAY_NEED_PREEMPT
+ *  w(c, s3) = NEED_PREEMPT
  *
  */
 static int
@@ -6833,13 +6839,13 @@ static unsigned long wakeup_gran(struct sched_entity *se)
 	s64 gran, vdiff = curr->vruntime - se->vruntime;
 
 	if (vdiff <= 0)
-		return -1;
+		return NO_NEED_PREEMPT;
 
 	gran = wakeup_gran(se);
 	if (vdiff > gran)
-		return 1;
+		return NEED_PREEMPT;
 
-	return 0;
+	return MAY_NEED_PREEMPT;
 }
 
 static void set_last_buddy(struct sched_entity *se)
@@ -6928,7 +6934,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	find_matching_se(&se, &pse);
 	update_curr(cfs_rq_of(se));
 	BUG_ON(!pse);
-	if (wakeup_preempt_entity(se, pse) == 1) {
+	if (wakeup_preempt_entity(se, pse) == NEED_PREEMPT) {
 		/*
 		 * Bias pick_next to pick the sched entity that is
 		 * triggering this preemption.
-- 
1.8.3.1

