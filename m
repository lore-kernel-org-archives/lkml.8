Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECE2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A618320792
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XcZ8NEau"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbgHDAGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbgHDAGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 20:06:16 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA37CC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 17:06:16 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id p6so28721204plo.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 17:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=16cxH9SNyU+dYbQ8O4g4KQ5RGoppj2BxdNS3QniE0qg=;
        b=XcZ8NEauPhMXWvdr1SeYjUxiwyns2TOKcv2o07F9BB6dn4sJHRhG0Nkf003ag17XBe
         +d72y57K+l29K4QOEipOu9Krr9oSpybIgsyi5uyh75CqFKY5G1reOAvziG/SUOz0VV+A
         jqlF6CLuPlcyv8ZyxpZpx1WyPfa+2Lzw5yISwBS7b1XhF+iYWvrEqcXRzJaSSdOU8nZA
         pbxjEzc61zdsMzQ0l+ebomOlLDWOKf0/0bl/KwABaMxxeDBWuD+skO0rWV80QxEmvZTz
         JzUfpchtGJ5Wl17gZdbMblwO7nqahJ08uanyTwEKHgwdtdbaynD8+gz6M5SkshmZZhdH
         7YOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=16cxH9SNyU+dYbQ8O4g4KQ5RGoppj2BxdNS3QniE0qg=;
        b=KdFQrM3If1ethJYJCRwbNi/h4HEGMftBLiq35gPy0EroUwyz0ZmOrVyE5d6acbej9m
         yZsMVVT5+WkuG3tc3tpv8hcg5vZImbtoAMO/CUEIo2aAXfvtvEjIMiMEdbo55ojkEzG3
         tUszCTR6DBOiuKJCxeOWkihdBvqjSvu8jiY6Fwr7/h3sJIBdyGpub1eIwYs67rsBJFEJ
         4pcae1vktGzLMejYl/KvEHV2pTjUx5u8lTIyUg4JoPSfmHxIUhRHxXqaEJygs21TqvtI
         2Wpu+IFF0fWNNGKw3cwx8e9GyMwMhfDcTptdZk8w7OsKghdTh25QjpRYrMTAGe73X1Co
         oAjQ==
X-Gm-Message-State: AOAM532STVqnap2y8L/3z4Dee5Ei3/ywWoiOtmq0bC9Ktmk5i+wao8q7
        ha/vMZqYkffBLk5KfltlFRIQfl/dMXTK
X-Google-Smtp-Source: ABdhPJw/vfSpadDVVuhstLQitoN99ychwaTmcS5RlVdxpLHWs8GPSyeuBDUGdhWU/odQidGAx4lCUErmLr07
X-Received: by 2002:a65:6710:: with SMTP id u16mr16622183pgf.45.1596499576252;
 Mon, 03 Aug 2020 17:06:16 -0700 (PDT)
Date:   Mon,  3 Aug 2020 17:06:14 -0700
Message-Id: <20200804000614.4176212-1-joshdon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH] sched/fair: ignore cache hotness for SMT migration
From:   Josh Don <joshdon@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org, Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SMT siblings share caches, so cache hotness should be irrelevant for
cross-sibling migration.

Proposed-by: Venkatesh Pallipadi <venki@google.com>
Signed-off-by: Josh Don <joshdon@google.com>
---
 kernel/sched/fair.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2ba8f230feb9..5b203b55bcb2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7402,6 +7402,9 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
 	if (unlikely(task_has_idle_policy(p)))
 		return 0;
 
+	if ((env->sd->flags & cpu_smt_flags()) == cpu_smt_flags())
+		return 0;
+
 	/*
 	 * Buddy candidates are cache hot:
 	 */
-- 
2.28.0.163.g6104cc2f0b6-goog

