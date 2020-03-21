Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887C1C43332
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 09:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B21220781
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 09:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g0wF+ou+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbgCUJpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 05:45:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35673 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgCUJpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 05:45:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so10361569wru.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 02:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3aRXmKaWpCikyhPB1r1OmE2K1u3/BRFi1kHB95qxuFw=;
        b=g0wF+ou+Z581+cBmPEU9Ede5RC7dNifbbFNqvzLutBgtLAn120kUaMH0t4rxT+JlH4
         Mn5DNctfVE8t7kUofJeoSEOlHwMPXgyE/bb36JYczb2ot/a5MmIk1EYpkCa7wHjaHmYF
         DutIkIG2KE7GqcdZfou7rHwDDJouipWqQP4BNLdoA17IK5NxsFaudtxDUgXdfaNnVzUD
         OLRV6jOj9B6USC7AWKqnBQQDwoL+bTGXklYXJkqC8JVh/0+NDTjXpvSotK4Z02cqIqhE
         FDm8fEyv1A0lnRbI/pSBaUlLnd+iyciDalVskfkqUK2I2WK95UIwAw3hXJ1lcIdQzSuM
         OV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3aRXmKaWpCikyhPB1r1OmE2K1u3/BRFi1kHB95qxuFw=;
        b=o2vmWDAugnL/jT9CrBCl+jKDGB8wzG7DqayxYB8zLPDBQm/e4yJE/Te+xg+U63rMAc
         5BM5kIgsFaxujDbiuoSvZltHhm3UsvyRdGnAxdWTvZT6mgqcQkbcKNIlY8zIC1sdX/i8
         rE/q1I95iTBYEfAPskHqSNujd7EfkEt/1DTnhx+dhWeAqTwEpjo9aZH7msK4Zu5cYhOY
         qet8+go+Vi+v1wAe7ybpBhosh81uHev8srrCQFuc4YFi8nWrCTMqPOMri+Wso1RdltSh
         6kCawkpWWnwMOMSzRzxxb2w33XYArZmM3vQqxtYKkkRrSojcQjI30OU3+oVGkdy0+aJH
         8OAQ==
X-Gm-Message-State: ANhLgQ0p+tOVowV9ciiNnchKqIPax5lvrlguGhYA2iweaYzvyXJBAnfN
        3Q6b0NMir4gYVZ1nQqdAn/Tz7w==
X-Google-Smtp-Source: ADFU+vt6T6nUeI6bl3t9eRMr9wGqBkGoytGMG7fogvZ6K4Vx2wN+9uT8zFhopeIu3DiGK0gsaJu5Nw==
X-Received: by 2002:a5d:5106:: with SMTP id s6mr15497200wrt.24.1584783913506;
        Sat, 21 Mar 2020 02:45:13 -0700 (PDT)
Received: from localhost.localdomain ([84.33.129.193])
        by smtp.gmail.com with ESMTPSA id z203sm5396378wmg.12.2020.03.21.02.45.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2020 02:45:12 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        rasibley@redhat.com, vkabatov@redhat.com, xzhou@redhat.com,
        jstancek@redhat.com, Paolo Valente <paolo.valente@linaro.org>,
        cki-project@redhat.com
Subject: [PATCH BUGFIX 1/4] block, bfq: move forward the getting of an extra ref in bfq_bfqq_move
Date:   Sat, 21 Mar 2020 10:45:18 +0100
Message-Id: <20200321094521.85986-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200321094521.85986-1-paolo.valente@linaro.org>
References: <20200321094521.85986-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ecedd3d7e199 ("block, bfq: get extra ref to prevent a queue
from being freed during a group move") gets an extra reference to a
bfq_queue before possibly deactivating it (temporarily), in
bfq_bfqq_move(). This prevents the bfq_queue from disappearing before
being reactivated in its new group.

Yet, the bfq_queue may also be expired (i.e., its service may be
stopped) before the bfq_queue is deactivated. And also an expiration
may lead to a premature freeing. This commit fixes this issue by
simply moving forward the getting of the extra reference already
introduced by commit ecedd3d7e199 ("block, bfq: get extra ref to
prevent a queue from being freed during a group move").

Reported-by: cki-project@redhat.com
Tested-by: cki-project@redhat.com
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-cgroup.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index f0ff6654af28..9d963ed518d1 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -642,6 +642,12 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 {
 	struct bfq_entity *entity = &bfqq->entity;
 
+	/*
+	 * Get extra reference to prevent bfqq from being freed in
+	 * next possible expire or deactivate.
+	 */
+	bfqq->ref++;
+
 	/* If bfqq is empty, then bfq_bfqq_expire also invokes
 	 * bfq_del_bfqq_busy, thereby removing bfqq and its entity
 	 * from data structures related to current group. Otherwise we
@@ -652,12 +658,6 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		bfq_bfqq_expire(bfqd, bfqd->in_service_queue,
 				false, BFQQE_PREEMPTED);
 
-	/*
-	 * get extra reference to prevent bfqq from being freed in
-	 * next possible deactivate
-	 */
-	bfqq->ref++;
-
 	if (bfq_bfqq_busy(bfqq))
 		bfq_deactivate_bfqq(bfqd, bfqq, false, false);
 	else if (entity->on_st_or_in_serv)
@@ -677,7 +677,7 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 	if (!bfqd->in_service_queue && !bfqd->rq_in_driver)
 		bfq_schedule_dispatch(bfqd);
-	/* release extra ref taken above */
+	/* release extra ref taken above, bfqq may happen to be freed now */
 	bfq_put_queue(bfqq);
 }
 
-- 
2.20.1

