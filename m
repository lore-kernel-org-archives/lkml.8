Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433B8C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 01:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 233AC2076A
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 01:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vqc0dVCP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgGKBPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 21:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgGKBPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 21:15:07 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE80C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 18:15:07 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id a25so4805436pfl.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 18:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=U5INvZHUBg4ofchuBpYEmrsR0JVEvqywIM5ZpiyAXHI=;
        b=Vqc0dVCPkiIhRztJakvxnD5/CbvZkoLqqkWRKgipucloSLX3KJKQ+gO7iBCohgWL/h
         a7iCV0zMQYyZN7dmF5SQAJFYfmAPLuq9edmHoB+QUpKf2Lm4kDb+zBfTMgcA53hXAwQW
         8jyPNUd+aDlb5dI54nMA5C99IaFtQDFKWI8nmxOSomEXB95YaCyK9mYmpScip7eTJrED
         2IsLwgduzjf5x/+qO6RilO5f6LIMHNUeHgy0w2LuxNGeJRrVDPbfb1GuE1mOBLL2SoFi
         kCqrcSu4+BVInG15BShvpUILEjf2a/9htOYICbbnqmjHu+soHfVEro46Ka29eZY1tPhi
         SqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=U5INvZHUBg4ofchuBpYEmrsR0JVEvqywIM5ZpiyAXHI=;
        b=gahws3zMf8S2ejjyOwIyRGnB7WAEJSoQIOzMiNL7dbZ9QOahJFhtdSUFAmatcADpCD
         sbZbzLzHIhZu+Vs+iSPDktcJFSxSEwgrZ+1w+bkx9R48E//1/M4Lieyi1Ga9B1acMzo1
         dUtQBito7TvEvX3kxOKJwp6WDUNxbu1zTl+dMznrxEfRKJAa9Ak5uuIm9bdCUQ23cJ96
         omeaes2WbfQE1gYgFpKEaUGrRRu/obLpz517B4b9+6AnaFg+YFeTYQT8o852pRSJ7aa+
         iOUbW2kscoxzzEgon4kWO7hT+Vz0qLyy0pn11USJIVtv4sB3ob7nvKuj2INU65VMBKIz
         kd3A==
X-Gm-Message-State: AOAM533ha6FDSkYDACpreadCY3qY1pPTFM3GBa1eCAcLWu/Ffk/gQRC+
        /2DoSQOUQrOSHDOAwaq5HP59jCx47XUNYg==
X-Google-Smtp-Source: ABdhPJz30qPG2tBMvb+LcVB4D7J198s33oZLzj9uQnuf8VxfukhyRVVMvK5TlsDHo2F41f0K7s6iBg7wHa1yig==
X-Received: by 2002:a17:90a:f493:: with SMTP id bx19mr7799392pjb.134.1594430106382;
 Fri, 10 Jul 2020 18:15:06 -0700 (PDT)
Date:   Fri, 10 Jul 2020 18:14:59 -0700
Message-Id: <20200711011459.1159929-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH] mm: vmscan: consistent update to pgrefill
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vmstat pgrefill is useful together with pgscan and pgsteal stats to
measure the reclaim efficiency. However vmstat's pgrefill is not updated
consistently at system level. It gets updated for both global and memcg
reclaim however pgscan and pgsteal are updated for only global reclaim.
So, update pgrefill only for global reclaim. If someone is interested in
the stats representing both system level as well as memcg level reclaim,
then consult the root memcg's memory.stat instead of /proc/vmstat.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/vmscan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5215840ee217..4167b0cc1784 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2030,7 +2030,8 @@ static void shrink_active_list(unsigned long nr_to_scan,
 
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, nr_taken);
 
-	__count_vm_events(PGREFILL, nr_scanned);
+	if (!cgroup_reclaim(sc))
+		__count_vm_events(PGREFILL, nr_scanned);
 	__count_memcg_events(lruvec_memcg(lruvec), PGREFILL, nr_scanned);
 
 	spin_unlock_irq(&pgdat->lru_lock);
-- 
2.27.0.383.g050319c2ae-goog

