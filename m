Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DF6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FD0920658
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjpUqioR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgHKLcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 07:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728454AbgHKLcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 07:32:20 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C729C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 04:32:20 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ep8so1729444pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 04:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BctG/qaJdDXtKFvw6lMKacsPfVSKQtLH7iFF3+pMRlM=;
        b=QjpUqioRorxWY/SVtxtGIFTNjlh0OzsQjd3uNqVUz9BeP9g85qFpx8SNmQh3YN/95u
         o8q2jQDvEBwNfpt5hMuoyD40Jbhvz2cBYJn6MLrwDYKktxExxhYGri8iJdkiG/E8m/iE
         2l7Doo6GamuB0cqn6JTzc2DXX89X9qloxT3m5stn5KJc3muyGEM559SNtvqTWfaH5Ex1
         NBLyxEsHuS3AgcUI5cnRf4JHYG6JiIfnrCmzQQk1nGEBim7a0fENx4SbqthDQrB0zSx6
         WWFVsSDoL1usG2DBA29U+tN/xLJ5kml3j6epX4R96177MoDCbJPUOVNf8Fzl43sB+vMW
         bjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BctG/qaJdDXtKFvw6lMKacsPfVSKQtLH7iFF3+pMRlM=;
        b=jYkB1MLjAlyrEyFJUReXNAeyDjGdWTPg+ZOB6zjPkp8drqtsGZsZ1K8qozAuliBbtN
         6nhahchVN+o4hWLAbgu7xdPIfdRYfBKGHQcsnKQGHYvdeafPuAdYwTq+J0qj3d2kdvye
         tbiTeTsTQGbilcH41VAl472foQOaevOEYuSqPYsgWj4hWIj/r7TOBnh7GXwW7htupq0k
         REhewiOzME5UbLd3rhIC21aOMwxHsj47LoQlJj5YjfWm4+8uTaws089e1Pc9kJC61Qk1
         yyxOtEnZXxnTdymYjXFbNrhAu6CU5Nn+jNu9rbVEjQe68YoMAPPzqXj/OQtfNSj80IYg
         0d2w==
X-Gm-Message-State: AOAM532BMDuomvZwoFZA20ihIlZS/7cq9atTo/14W2OUkMYG7wHBxggr
        MkS+1kljFhMdgmzSY/P/i8dHG3Hpv/U=
X-Google-Smtp-Source: ABdhPJx68lUG8OjUmXnQuo1LfXpp0gcnhDvKm3bO8qvqXsjH0lkNvqIoHDCIidrvXBAlqjIbZI8xDg==
X-Received: by 2002:a17:902:8509:: with SMTP id bj9mr473545plb.179.1597145539827;
        Tue, 11 Aug 2020 04:32:19 -0700 (PDT)
Received: from localhost.localdomain ([103.7.29.7])
        by smtp.gmail.com with ESMTPSA id e125sm25462835pfh.69.2020.08.11.04.32.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Aug 2020 04:32:18 -0700 (PDT)
From:   Jiang Biao <benbjiang@gmail.com>
X-Google-Original-From: Jiang Biao <benbjiang@tencent.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        Jiang Biao <benbjiang@tencent.com>
Subject: [PATCH v3] sched/fair: simplfy the work when reweighting entity
Date:   Tue, 11 Aug 2020 19:32:09 +0800
Message-Id: <20200811113209.34057-1-benbjiang@tencent.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiang Biao <benbjiang@tencent.com>

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
---
v3<-v2: Amend commit log taking Dietmar's advice. Thx.
v2<-v1: Amend the commit log

 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 04fa8dbcfa4d..18a8fc7bd0de 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3086,7 +3086,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 		/* commit outstanding execution time */
 		if (cfs_rq->curr == se)
 			update_curr(cfs_rq);
-		account_entity_dequeue(cfs_rq, se);
+		update_load_sub(&cfs_rq->load, se->load.weight);
 	}
 	dequeue_load_avg(cfs_rq, se);
 
@@ -3102,7 +3102,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 
 	enqueue_load_avg(cfs_rq, se);
 	if (se->on_rq)
-		account_entity_enqueue(cfs_rq, se);
+		update_load_add(&cfs_rq->load, se->load.weight);
 
 }
 
-- 
2.21.0

