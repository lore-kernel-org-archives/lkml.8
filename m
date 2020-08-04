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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5655BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 19:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 360A12076E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 19:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cz0abD2C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgHDTeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 15:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgHDTeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 15:34:16 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8892C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 12:34:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e196so49188712ybh.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 12:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xWqorcV6jScQp1fTMrirlsQiv+GO5jT/AZFaZd6qZmg=;
        b=cz0abD2CuErsP1cPYzQqrjOvfdUUcsWYndcB9cK0MO78kPFUsR208ibCtkDzzDvVzG
         IffR12hbOmz5jglFa7rCfvYbAQbG5GU83g4xno7w3fuj2Iml8RVxWcOVFrPYmKJyFpOO
         TdI910ML+3sP2DuuMEvxdBvhKFaEhz9OgsAjmzW28WKCy7OBuM8fgXZgxxu1cd6URb3O
         gveWMduPBbRUa9sqNeSy6XqvGVIEvDdlEY7WO5Bn2K5cy2KnFy5Upo/cLUPcf2ZuM7m0
         l1ClUb4WPhyMq7dlJ+TPpG+coxH3jS6fBsgp2qJR6mHWb1YhdJUKPhRkVGRxwZBa/SGp
         qtcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xWqorcV6jScQp1fTMrirlsQiv+GO5jT/AZFaZd6qZmg=;
        b=uaerCQYJfpgIser2GOlpN+dXGcjI4WYjnLt0zjMsJX+8UPsePlUJkK8zQrRDr86zmh
         tzrZSLggvfzNJ941fOYBGyNKtaqlPJr23vzfWEhViiPiHa0i1g7twgtp3bZvwrNW1MWv
         /nsaS6doxdQH8vK61+IguhDX4Yp6Lm8L24ZFNfjsJd7+z0dIbdWTJkdMWm97VedTh3Gr
         yUEWx+KnOMmtrGScrF1B3UBkdhxoOSRW+vdFpvaeBPWmXeDTYF+gwsqbd+8T0PcLYFwk
         xKlItiPtl3x7JGgN9YsutfvwvOyVE7bSdWn4LDVJX9wi9kEj+Eh0vYUeRpkCHHUkvNFC
         kzFQ==
X-Gm-Message-State: AOAM532GOY6WXRQHm2GEgNhduqaRO25U122xsGcplNseGwylTQ4u6eN5
        Yh8Fhf9v5jLsyyFlzATSkN06irbSkTbL
X-Google-Smtp-Source: ABdhPJz0CuSMaL1ISs2pfDUY8PU9xchxhpkIhBdTqy6rbJ0GFwDh/+gZsRfYcs9ghlaQ/KIFM7U+TfPA2PGN
X-Received: by 2002:a25:c7cd:: with SMTP id w196mr33418875ybe.351.1596569654967;
 Tue, 04 Aug 2020 12:34:14 -0700 (PDT)
Date:   Tue,  4 Aug 2020 12:34:13 -0700
In-Reply-To: <20200804105619.GE2657@hirez.programming.kicks-ass.net>
Message-Id: <20200804193413.510651-1-joshdon@google.com>
Mime-Version: 1.0
References: <20200804105619.GE2657@hirez.programming.kicks-ass.net>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v2] sched/fair: ignore cache hotness for SMT migration
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
 kernel/sched/fair.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1a68a0536add..abdb54e2339f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7402,6 +7402,10 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
 	if (unlikely(task_has_idle_policy(p)))
 		return 0;
 
+	/* SMT siblings share cache */
+	if (env->sd->flags & SD_SHARE_CPUCAPACITY)
+		return 0;
+
 	/*
 	 * Buddy candidates are cache hot:
 	 */
-- 
2.28.0.163.g6104cc2f0b6-goog

