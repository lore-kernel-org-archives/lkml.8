Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A7FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 07:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBEEC2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 07:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9w48TLk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgHDHMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 03:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgHDHMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 03:12:35 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3103EC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 00:12:35 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id i92so1154687pje.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 00:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CaqqamNdhYLVbX4eDBUlRawUBk2GdVTZJjZpvT7ECgk=;
        b=A9w48TLkFUTvKXvFVlveJdgdfOzpTqs3s7MXUTs6lHLl/wlW3BEhzszA+wSQCFzKCX
         fUJYXMMLP0Rj+L1V+5mRklbuAL3m80k8PjqUOby+yCGTF+KJ7EG/Dy8bumBiNd0NR1fL
         szpvt4NlRHjqOh30QWl38Nj8LGdLLp9+GiePfuEYt2rk1QwrK2mq3xHV7zng44PE4pXy
         3JQSrXJzUoym/i5Xs0/pfwNTVgLRvcjO87UkLCpaurYgy9L/Jwcf75pvCbaBgxJTgNk4
         dA1yhk/+dKZtWFHTTz/MeN5RU8Vel8tgyCEGnb9zSECAnOQrUR8w6wXwoJ0hAqfmYtfl
         7oYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CaqqamNdhYLVbX4eDBUlRawUBk2GdVTZJjZpvT7ECgk=;
        b=QuSgxhvAOiZL0N/98cTHvFiHIw2mmHtoymnXGwnFiafmjrK3BFa3nfE49y4Yfr0HF1
         uQcKCjto9Egx+9ee6TtATt7AcVBGGJy77wNRAx6TRC7GOXvrD+C1vGD+0oZKKmURqACg
         QG50nsIzMWAMFUpYJ5js8WAJFIKLNA/UY1wJpcFYlL29Msocg3CASdvHnVsso9xtYgjF
         v3P/VOeDe7U5yDypIFdmhCrGo4QtFr0LmWLydtH40/TwKZ+23DPt7AuPD3UYQPKgw1L5
         5TOrSL6+D4PIX7R5wi6QMuo6Ipxk8m+xlFcrjLfMOhnZBSMOXIAdRIw7J3aG49wKoX2Q
         Hx1A==
X-Gm-Message-State: AOAM530iPjaj1xfczrDAwj7At5zYRJ24EezFiH0aA5Hkv+ywALkS4laO
        SbYn+TnNs6EcJ0JamyOD0kU=
X-Google-Smtp-Source: ABdhPJwl3pA75q8OFWt8CL0JtAkTJyAmkUdwXBzbTdQnoFwbbTIGKrdEJPrzdf40MltFOR56PNM2Bw==
X-Received: by 2002:a17:90a:fa94:: with SMTP id cu20mr3127943pjb.145.1596525154737;
        Tue, 04 Aug 2020 00:12:34 -0700 (PDT)
Received: from localhost.localdomain ([103.7.29.6])
        by smtp.gmail.com with ESMTPSA id 3sm1486363pjo.40.2020.08.04.00.12.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2020 00:12:34 -0700 (PDT)
From:   Jiang Biao <benbjiang@gmail.com>
X-Google-Original-From: Jiang Biao <benbjiang@tencent.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        Jiang Biao <benbjiang@tencent.com>
Subject: [PATCH RFC] sched/fair: simplfy the work when reweighting entity
Date:   Tue,  4 Aug 2020 15:12:22 +0800
Message-Id: <20200804071222.31675-1-benbjiang@tencent.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a se is on_rq when reweighting entity, all we need should be
updating the load of cfs_rq, other dequeue/enqueue works could be
redundant, such as,
* account_numa_dequeue/account_numa_enqueue
* list_del/list_add from/into cfs_tasks
* nr_running--/nr_running++

Just simplfy the work. Could be helpful for the hot path.

Signed-off-by: Jiang Biao <benbjiang@tencent.com>
---
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

