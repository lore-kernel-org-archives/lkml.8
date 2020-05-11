Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C03C54E91
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56CD120736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u6dBDpt3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731545AbgEKTXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 15:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731483AbgEKTXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 15:23:09 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC052C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 12:23:08 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x17so12445278wrt.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 12:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=cFIT0J6PoVqR+tEKlplt/PAZxnGBqZJ5IERsHFGuA7I=;
        b=u6dBDpt3CAOHAVkhocx8NUHsot35nXrA5CKfaZh5l3HWDtw+7Pqx+qs9yFLv3QQTa4
         4QZX0axP36V4HCjIzFXC3gCfGZvsnEwee3CUR+qzNCyXbI2A+C6A9az21l0b63gVp7e7
         t1fsOymbS2h1tw0u5bxbB1/RSNZzj8Tx+gw0lCyrwlu9qGuf3DfsHFFH288pUZCsyYyU
         FIZlUEeKYxCssmDMvSadUu52VsLrVD2jJXYquzxGLaO4DyfRqmOBNbw/VlOcPuzzK8xj
         9AMd/bkHPir1IBwhphLrcwASE9KG9ePGL5q+pJGc/NUZq6sf29ls6puARqmlhreD0rI8
         LxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cFIT0J6PoVqR+tEKlplt/PAZxnGBqZJ5IERsHFGuA7I=;
        b=qFXfRoGqGczTIl0CvE9I/xG0wf7bDpGxawRQlXsd1sRrRkLo9p5s5AzBXdDfoHBo0b
         dzmtLmjX8vOgtDoe3Rn8pEOHW44zkm7Gm3rBEoODsBjqp5onvzd3oml3RoMPCRCmjUUY
         0kLwL2sOJJSdIelltdv5Jafe+atulFKksPZBUauw8FZlhDqQNjBFqHvr65XMDRH22Vp+
         0TU4avX1Kl7GeurK0HQJeaRtJedLeqk8wMGvPYve0fa5micVcQ5rYe8+ZKrt/6BeFsP9
         TBClZ9mYwkJrwDDpa3jbAP1JKOWYYFmCKnFdmg+fjYIFIkrP206A7X9L5I64vyNOyAIV
         pYJQ==
X-Gm-Message-State: AGi0PuZVEVb42iJ7THknTx3dgHkctldWzAtebuigAYHc0Rdil92gogkS
        YTWBCb1aEGl9j1PYws7b0NqTxw==
X-Google-Smtp-Source: APiQypJimWp3gwMe2Rh5sEaWbTa52ZliVq/pLRrw83Nmh7WmsxAeZNnX/xRoGynvRGXcqZ8hZ/kbcA==
X-Received: by 2002:adf:d4c6:: with SMTP id w6mr21552220wrk.92.1589224987619;
        Mon, 11 May 2020 12:23:07 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:6467:c897:33c1:f11e])
        by smtp.gmail.com with ESMTPSA id q5sm11965823wra.36.2020.05.11.12.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 12:23:06 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, pauld@redhat.com,
        ouwen210@hotmail.com
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair: enqueue_task_fair optimization
Date:   Mon, 11 May 2020 21:23:01 +0200
Message-Id: <20200511192301.1009-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enqueue_task_fair() jumps to enqueue_throttle when cfs_rq_of(se) is
throttled, which means that se can't be NULL and we can skip the test.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4b73518aa25c..910bbbe50365 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5512,7 +5512,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
                        list_add_leaf_cfs_rq(cfs_rq);
 	}
 
-enqueue_throttle:
 	if (!se) {
 		add_nr_running(rq, 1);
 		/*
@@ -5534,6 +5533,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 	}
 
+enqueue_throttle:
 	if (cfs_bandwidth_used()) {
 		/*
 		 * When bandwidth control is enabled; the cfs_rq_throttled()
-- 
2.17.1

