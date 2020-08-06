Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7918C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16AA823119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBJ+xRcZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbgHFQ7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgHFQkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:40:40 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CA1C002174
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 09:14:46 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id r4so17213173pls.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 09:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E+VfmnxDV498yxI5rDUMFgAbVpKeY5DLzESFio3gnB4=;
        b=UBJ+xRcZblEVxSJwz/PK+6Kw1nyvUVkSJPh5W3yJfyKUV1zBsLoDfTSVMzPYi0aXAB
         MoIYnymHlZyzMpW2QDQGcE1yacW3lPSxo41W77F74qUi7yZyaUPg4mZaaTps4uw7arDv
         MHSZarQlh9DmRRObpE31wn60GWelGoIPB5AylEpEXUq4SI+QeMWpN/xCPgXX1c1h//Sp
         S9Ey6QXTSzW1azNC4LSOgHLG0DM60r0TB8IOANE/aQ4gxx5NyI3mz9gnPTAW/h9jxKfp
         0lb+PuigzZbdX2MQNlrcwr4HG7qc6BD+BJ/i/5L79G1rwr7l4ZDWOMuBD7XJZmcLs1MT
         o4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E+VfmnxDV498yxI5rDUMFgAbVpKeY5DLzESFio3gnB4=;
        b=SBwnrenk2TlLHmHqwQdZ9N44NQ2mS85L2DpxBwFRZB77ilnNExoP+VEYN5J0M1Z2Zv
         +tM2ip3ZuFA4zWqku8hsner9i/80LJKBNpqUhDSsFpNVqwpKkyCSfWJvvGzwwU9T0z5e
         w4RU33xki2cxtZ83xstkPxC0D4fU/LSKwSc8n/MpiDzC6tBCBRIlE4VOzntu002vdTH2
         Vn6fcBiMpNxzZZw1BLmlztYeuLXS7BO+wRmRY5WQzDWySNIioB5NnDbzEj7QywLLe67U
         zg5qoR4RQcrNxXGyw5dxVgg/uLBeuZyioq+GldYdAibwPGOaZxiH9LRtixa+GEM5SItq
         A6EA==
X-Gm-Message-State: AOAM5330OeXPq5ZwXtTN/XtgBhYo1U8WMQL1s1C0mN6jD1O7ef20Sfdn
        9dikICr73SKkc45BxIif9oA=
X-Google-Smtp-Source: ABdhPJygnoz1mAHZpteX4eA3W25LGEwX06xrCjfRfUvdj+ghvykms+CWaAws1JOdPxRlOy6x95gWgw==
X-Received: by 2002:a17:90a:e551:: with SMTP id ei17mr9109006pjb.224.1596730485648;
        Thu, 06 Aug 2020 09:14:45 -0700 (PDT)
Received: from localhost.localdomain ([112.44.78.113])
        by smtp.gmail.com with ESMTPSA id x127sm9537245pfd.86.2020.08.06.09.14.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Aug 2020 09:14:44 -0700 (PDT)
From:   Jiang Biao <benbjiang@gmail.com>
X-Google-Original-From: Jiang Biao <benbjiang@tencent.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        Jiang Biao <benbjiang@tencent.com>
Subject: [PATCH RFC v2] sched/fair: simplify the work when reweighting entity
Date:   Fri,  7 Aug 2020 00:14:06 +0800
Message-Id: <20200806161406.22629-1-benbjiang@tencent.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiang Biao <benbjiang@tencent.com>

If a se is on_rq when reweighting entity, all we need should be
updating the load of cfs_rq, other dequeue/enqueue work could be
redundant, such as,
* nr_running--/nr_running++

Even though the following dequeue/enqueue path would never be reached
* account_numa_dequeue/account_numa_enqueue
* list_del/list_add from/into cfs_tasks
but it could be a little confusing.

Simplifying the logic could be helpful to reduce a litte overhead for
hot path, and make it cleaner and more readable.

Signed-off-by: Jiang Biao <benbjiang@tencent.com>
---
v2<-v1: 
- Amend the commit log.

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

