Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3734C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A702077D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EAdVcQMf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404627AbgDCSIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:08:15 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:46280 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404617AbgDCSIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 14:08:14 -0400
Received: by mail-qk1-f202.google.com with SMTP id y5so7127790qky.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 11:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vKSRcwOgSxpovOTlIQ2GGXc7undTikgLR4vPeODvBEg=;
        b=EAdVcQMfqNQMWp+4WRmfe91idIJgxgyEfZOUxbBy5g7FhdJ3iwUVewvmIgdlkqwKKB
         4XGNVvOFr0KM7VoBQjEDBe0GhQv0F0yrLTTCdeyAERNGWx+iroMIx7J1123VuaGXl0IO
         air1JUnAgGTLBNudw8Qwiya3n+dbaxmbd8WNxz8kiz4SyqBE/T8dEJFunVE6ma9t0jdH
         PhbYjrpBSqVmzygopF4G9frAkLgylR1+3Az5YUa5yXseLNV0X1siNiGUoJ6m5aOckuDO
         N6jdBJBvMihi9JSqZM7CDvBukST8mvAXKx01SSJAoJaN68Pa4McVpwJXITE1bezXTBv/
         P4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vKSRcwOgSxpovOTlIQ2GGXc7undTikgLR4vPeODvBEg=;
        b=JjVqiCN6aa9PNpQ/2Q5K/PTB/JO2hqmnSCt84mBFj2lI+iA13trJHdC9RcOTo+JPo/
         /fFjirA9Kw9WWDtaPTECtGOLy9vXDsBkfkzRkq7JkH3kAGeith960u2b9RoyioLbm2vg
         kjXUE8Mq+MZswAZOVhncRdQJp/Mgnpo8DwHe4Skqmxh/HVlXGuRd/DYV4wdE5dxXPg3S
         FrDQizejyWALjKfEGPHlDx9Ww7f2MzFtbx4dNk/igU/P8kD9DdsAvOZ15y5rQ7QFxiOt
         jQpVhxJ75FCqRu7L5YRnNFkNZc7GocbF559zspiboQdjg7/4VX2eX5NcvPFJz25PU0sM
         B1jg==
X-Gm-Message-State: AGi0PuZxlu+RwObE7JzdxrqVTrhKDgpa+M3GPd6zKgX34RvaUEQxZMEP
        VlBCi1inIAOlTzk0LBIJVF14lY1p
X-Google-Smtp-Source: APiQypJWimwWNrbHSFo3IzrjsTj5VaB+oSMTVhhwvL+zxZmNdg193dSzzY6KHEEtRKYIPFlNYX8ohl5u
X-Received: by 2002:ac8:1aed:: with SMTP id h42mr9705788qtk.43.1585937293082;
 Fri, 03 Apr 2020 11:08:13 -0700 (PDT)
Date:   Fri,  3 Apr 2020 14:08:01 -0400
Message-Id: <20200403180801.209970-1-brho@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: perf/cgroup: use the cgroup_id() helper
From:   Barret Rhoden <brho@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We had a few places that still used cgrp->kn->id instead of cgroup_id().

Signed-off-by: Barret Rhoden <brho@google.com>
---
 kernel/events/core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 318435c5bf0b..e5deab0e7185 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1594,7 +1594,8 @@ perf_event_groups_less(struct perf_event *left, struct perf_event *right)
 			return false;
 		}
 		/* Two dissimilar cgroups, order by id. */
-		if (left->cgrp->css.cgroup->kn->id < right->cgrp->css.cgroup->kn->id)
+		if (cgroup_id(left->cgrp->css.cgroup) <
+		    cgroup_id(right->cgrp->css.cgroup))
 			return true;
 
 		return false;
@@ -1692,7 +1693,7 @@ perf_event_groups_first(struct perf_event_groups *groups, int cpu,
 	u64 node_cgrp_id, cgrp_id = 0;
 
 	if (cgrp)
-		cgrp_id = cgrp->kn->id;
+		cgrp_id = cgroup_id(cgrp);
 #endif
 
 	while (node) {
@@ -1709,7 +1710,7 @@ perf_event_groups_first(struct perf_event_groups *groups, int cpu,
 #ifdef CONFIG_CGROUP_PERF
 		node_cgrp_id = 0;
 		if (node_event->cgrp && node_event->cgrp->css.cgroup)
-			node_cgrp_id = node_event->cgrp->css.cgroup->kn->id;
+			node_cgrp_id = cgroup_id(node_event->cgrp->css.cgroup);
 
 		if (cgrp_id < node_cgrp_id) {
 			node = node->rb_left;
@@ -1745,10 +1746,10 @@ perf_event_groups_next(struct perf_event *event)
 
 #ifdef CONFIG_CGROUP_PERF
 	if (event->cgrp && event->cgrp->css.cgroup)
-		curr_cgrp_id = event->cgrp->css.cgroup->kn->id;
+		curr_cgrp_id = cgroup_id(event->cgrp->css.cgroup);
 
 	if (next->cgrp && next->cgrp->css.cgroup)
-		next_cgrp_id = next->cgrp->css.cgroup->kn->id;
+		next_cgrp_id = cgroup_id(next->cgrp->css.cgroup);
 
 	if (curr_cgrp_id != next_cgrp_id)
 		return NULL;
-- 
2.26.0.292.g33ef6b2f38-goog

