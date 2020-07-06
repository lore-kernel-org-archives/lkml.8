Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151DBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB9D120722
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3N9evgP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbgGFQEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 12:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729293AbgGFQEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 12:04:47 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7351C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 09:04:47 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 207so16961127pfu.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 09:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=1O/Egd50pEVl2FelAZIRD/QJ5lxPCURdcJF1swLorD8=;
        b=F3N9evgPeqozsKRdL5MuPfNxY8qb2Xk62i0VHUIebj+0bLNz6hGUekawEGAz+wlHda
         EoIb5jguU4/ZSdr/isnmOF7/W3qoTViInegllx66QIOxUhqWCB0ddu0yXx58ih+zlZB/
         3KGUCd4WYsrCv+7EH0TGjL+LasXm+h6vOLOcKTFLsYgqKi5FPt39phP8A1rAIv6jQzvV
         lLAu/co6dVnoXAQ1M+jv3PYWTVtNE/nR417fTc2TTT8o7vcLCWe8EBOA1rYbkNq+UFuV
         z71KMFyi482zUzecnlheEgpE1EML2K8mrK2O/1NMTqFa53/zzs4QAXMGt2gRQ6LE8578
         gf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1O/Egd50pEVl2FelAZIRD/QJ5lxPCURdcJF1swLorD8=;
        b=rKBcstcJpdYuvr146qBpyWw7clnkTQCLP+jtXG+VNn8X5RVQ40XFKAQvR5p9BaOBG/
         3tm9U65sifKE2bBhv54U3AU0sLY04EjByzWd6BIGU6ak5AKAJtO2ykt2YBDKKgHWB2qg
         uQi4ZqOHQKFx64bQUnLWqNAcKkOWQCCelcGG2cp8NPPi4bYpROVF0e4uQeBRlg2/8qL/
         JY/jUxwhmYztZVWeD+AJPgSZVYWZmADJS6X8Tya0HpqPU4lyXuqYHetLlCVRMIuJduGo
         XT4iWc3dnFdHFpYSFJwcmqH4OKcgzlb8pf+AQK99KsFMsnjeNIE8luKF0DYsLKzGDFyu
         bddw==
X-Gm-Message-State: AOAM531UM311LHeo+jLe0RURIKmc8aCJ5kAa3ZitSSIwUILnKTkwXof6
        8V4FVF5b6R0/TUgiSjhrZnyCPJSt
X-Google-Smtp-Source: ABdhPJzFrsV2bvzcUwE0zu7VeWr+6UfN4DNGhwdfbWtjJRwWKdorpp7xsjrH/H7WJLzPY5zH4RsSlw==
X-Received: by 2002:a62:29c6:: with SMTP id p189mr27001545pfp.55.1594051486581;
        Mon, 06 Jul 2020 09:04:46 -0700 (PDT)
Received: from iZj6chx1xj0e0buvshuecpZ ([47.75.1.235])
        by smtp.gmail.com with ESMTPSA id e12sm19489268pfd.69.2020.07.06.09.04.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Jul 2020 09:04:45 -0700 (PDT)
Date:   Tue, 7 Jul 2020 00:04:42 +0800
From:   Peng Liu <iwtbavbm@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Subject: [PATCH] sched/deadline: dome some cleanup for push_dl_task()
Message-ID: <20200706160442.GA19741@iZj6chx1xj0e0buvshuecpZ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'commit 840d719604b0 ("sched/deadline: Update rq_clock of later_rq when pushing a task")'
introduced the update_rq_clock() to fix the "used-before-update" bug.

'commit f4904815f97a ("sched/deadline: Fix double accounting of rq/running bw in push & pull")'
took away the bug source(add_running_bw()).

We no longer need to update rq_clock in advance, let activate_task()
worry about that.

Signed-off-by: Peng Liu <iwtbavbm@gmail.com>
---
 kernel/sched/deadline.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 504d2f51b0d6..c3fa11f84d93 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2104,13 +2104,7 @@ static int push_dl_task(struct rq *rq)
 
 	deactivate_task(rq, next_task, 0);
 	set_task_cpu(next_task, later_rq->cpu);
-
-	/*
-	 * Update the later_rq clock here, because the clock is used
-	 * by the cpufreq_update_util() inside __add_running_bw().
-	 */
-	update_rq_clock(later_rq);
-	activate_task(later_rq, next_task, ENQUEUE_NOCLOCK);
+	activate_task(later_rq, next_task, 0);
 	ret = 1;
 
 	resched_curr(later_rq);
-- 
2.20.1

