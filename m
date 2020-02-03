Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4983C33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A062080D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fpRDQwIu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbgBCKl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 05:41:26 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35280 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbgBCKlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 05:41:20 -0500
Received: by mail-wm1-f66.google.com with SMTP id b17so16328774wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 02:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wqMailTmZiDzGAaQzZRxkipnoj+fRUU9PJ6V3DKETq8=;
        b=fpRDQwIuTnnsEyXB2ySM/p4PTDa0o6mNCWb97yzJoMIxm1hOjOzyJyl9xYG18z2uPT
         +jjhRpUSiO5EEmKc8XND/iIKh/C8Sid5YDykNK8GeUaFBNaeFqu440ubfjfPwErQFY5B
         Mdc5VNe4/Q3wSBv0XE/og6Ag1FH1RZcXJEgt4cN20kVrJN+4JkBYfeQolvG8+EzaAK0c
         kgyMnqnPWWGke+XbsIrlZR+VcsFrioLHzE0ZWlgXCXXfYoEM+79cz7DN/avZ3RlPmf90
         /ZzHsLINcogFG4EytfuVjKt5Qf/J8ELSjr/Iz3h/StandjtsbMtxWa9y45V6Ch1YExbq
         dNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wqMailTmZiDzGAaQzZRxkipnoj+fRUU9PJ6V3DKETq8=;
        b=X/pFFU3eZKMbV3EABBPtD+R6rTqM3/LMTUxsPubG76lcri40JX2rzKHSEx25vDedL2
         AxvZNJh4TPK07guJt9lrPtCLnDPIcfawtazl0M94StpVxMybMWjloGJzlqPWlKkHHynF
         CZ8xOEma5vSUHscQnB22hYQHsExhnAvWL6p7csLgWrsxySKrVdTVnbz9nbbWaD0xk/cL
         H+/VZy1okS4fo5TOa8J3Haw6mVQ26pLAL/Un/ME3/g9TlMbgLqEKwKvKi6h7L/EOmQGz
         hy4Hm6HPh0rzF+G9Mtw2I/X2HqMqPDmd/WLcZJN1QFg/fWkB36SIYnx5w4sSx7hNMZp6
         X7PQ==
X-Gm-Message-State: APjAAAUh8zv3naZOLBLmDc4PH5ENqOEkY6kpAwv6YbNKfF3sTQ2b26qR
        HSXW8tiYVTISuBoCX4B7KVHLXA==
X-Google-Smtp-Source: APXvYqyqDixFhZw5tU0O0/JrbBtxhUTUGNteo4ruPRhRyMasg9wLTEjyyUN0NQFTSelH+2sWXvkRyg==
X-Received: by 2002:a05:600c:d7:: with SMTP id u23mr29183580wmm.145.1580726476193;
        Mon, 03 Feb 2020 02:41:16 -0800 (PST)
Received: from localhost.localdomain (84-33-65-46.dyn.eolo.it. [84.33.65.46])
        by smtp.gmail.com with ESMTPSA id i204sm23798930wma.44.2020.02.03.02.41.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Feb 2020 02:41:15 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        patdung100@gmail.com, cevich@redhat.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX V2 1/7] block, bfq: do not plug I/O for bfq_queues with no proc refs
Date:   Mon,  3 Feb 2020 11:40:54 +0100
Message-Id: <20200203104100.16965-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203104100.16965-1-paolo.valente@linaro.org>
References: <20200203104100.16965-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 478de3380c1c ("block, bfq: deschedule empty bfq_queues not
referred by any process") fixed commit 3726112ec731 ("block, bfq:
re-schedule empty queues if they deserve I/O plugging") by
descheduling an empty bfq_queue when it remains with not process
reference. Yet, this still left a case uncovered: an empty bfq_queue
with not process reference that remains in service. This happens for
an in-service sync bfq_queue that is deemed to deserve I/O-dispatch
plugging when it remains empty. Yet no new requests will arrive for
such a bfq_queue if no process sends requests to it any longer. Even
worse, the bfq_queue may happen to be prematurely freed while still in
service (because there may remain no reference to it any longer).

This commit solves this problem by preventing I/O dispatch from being
plugged for the in-service bfq_queue, if the latter has no process
reference (the bfq_queue is then prevented from remaining in service).

Fixes: 3726112ec731 ("block, bfq: re-schedule empty queues if they deserve I/O plugging")
Reported-by: Patrick Dung <patdung100@gmail.com>
Tested-by: Patrick Dung <patdung100@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 4686b68b48b4..55d4328e7c12 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -3443,6 +3443,10 @@ static void bfq_dispatch_remove(struct request_queue *q, struct request *rq)
 static bool idling_needed_for_service_guarantees(struct bfq_data *bfqd,
 						 struct bfq_queue *bfqq)
 {
+	/* No point in idling for bfqq if it won't get requests any longer */
+	if (unlikely(!bfqq_process_refs(bfqq)))
+		return false;
+
 	return (bfqq->wr_coeff > 1 &&
 		(bfqd->wr_busy_queues <
 		 bfq_tot_busy_queues(bfqd) ||
@@ -4076,6 +4080,10 @@ static bool idling_boosts_thr_without_issues(struct bfq_data *bfqd,
 		bfqq_sequential_and_IO_bound,
 		idling_boosts_thr;
 
+	/* No point in idling for bfqq if it won't get requests any longer */
+	if (unlikely(!bfqq_process_refs(bfqq)))
+		return false;
+
 	bfqq_sequential_and_IO_bound = !BFQQ_SEEKY(bfqq) &&
 		bfq_bfqq_IO_bound(bfqq) && bfq_bfqq_has_short_ttime(bfqq);
 
@@ -4169,6 +4177,10 @@ static bool bfq_better_to_idle(struct bfq_queue *bfqq)
 	struct bfq_data *bfqd = bfqq->bfqd;
 	bool idling_boosts_thr_with_no_issue, idling_needed_for_service_guar;
 
+	/* No point in idling for bfqq if it won't get requests any longer */
+	if (unlikely(!bfqq_process_refs(bfqq)))
+		return false;
+
 	if (unlikely(bfqd->strict_guarantees))
 		return true;
 
-- 
2.20.1

