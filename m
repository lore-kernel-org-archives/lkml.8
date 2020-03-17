Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168D9C5ACC0
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 05:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE02620719
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 05:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUFtryvr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgCQFmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 01:42:25 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39769 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgCQFmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 01:42:23 -0400
Received: by mail-pl1-f195.google.com with SMTP id m1so919814pll.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 22:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9wb/P3LPDlbugq1CDyVA5kSUSv6vOvUhfJXNTDD+0wY=;
        b=HUFtryvrggxqsdgMcaIJkI5PlHQpf/d426P43SkE68+uCxMmRxAgW29VbfpzX8Gv1c
         yuYoqfiyoGFGojyZCxXmM7OdvkkEXwLDG1qua3NoH6gYyqfvI/Vymne5r4jy+y1dTkVo
         nySuJtnMji4kGXAhfr83BtEllAi49vmjFpF4vBMshA9AF8T1dzHb/w83+KamUimjlTYC
         HTSHtUEYdZMdjf5oRc3H4Fz3Bcr2Mp2nEBTzMczPYr3oXCfXmuDp+u6mrelq1LwZH3fy
         RQrw6sd6fy44g54QZkG9MuAF87HzmemOJ1CEOBNoJcf9fHC0kPtqNoy6Uq5VzwwuVPLg
         +aXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9wb/P3LPDlbugq1CDyVA5kSUSv6vOvUhfJXNTDD+0wY=;
        b=DgaeaMcrqbfpQSImKV5C10VOa7/uyVDWYQ+Rix+v5rziV0H/GHY8syRF8zLx2DaSFF
         Qsrjt3qWHakBaItNCbPn2yP+BZnMUyFpsrJ1WVLLbDQQ4cbfAg3sJy9GHy+7pBF5dJH4
         mHcYnuS+flVhKUHbwpA0s8Gl7Q94ZWTh19CsIvAeEhrY250wfKKfRGxg5EoERcyY6W+C
         O96EQmrbF+QR72PAldFWa+XcA9yTLxDmyFGS46vObQt3x7Jaj08xLt9+/ZZXIM2pRik5
         poIA7LnySEVXj6wv0RO9CxEG7ewSeh4er6UKcAaLkEtJVmxiP5BtIKpihDsxPDkmNrqM
         6iYQ==
X-Gm-Message-State: ANhLgQ3v0SPyq+/hAqlBMQCV0Wv3NWLOJ6iLNjGBYoDz1r6LHr2TwTXr
        God2SzAUFuHi6vM9Hr/2jFU=
X-Google-Smtp-Source: ADFU+vvuskdqe81LJ9kaYHhwm+SdnxkieUhqPLtJJEHaTvIKEEhTmeUaX7U2gRjxYIgNNDdxeo6XbQ==
X-Received: by 2002:a17:90a:d80b:: with SMTP id a11mr3492749pjv.21.1584423742470;
        Mon, 16 Mar 2020 22:42:22 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id i21sm1141757pgn.5.2020.03.16.22.42.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Mar 2020 22:42:21 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v3 5/9] mm/workingset: use the node counter if memcg is the root memcg
Date:   Tue, 17 Mar 2020 14:41:53 +0900
Message-Id: <1584423717-3440-6-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584423717-3440-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1584423717-3440-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

In the following patch, workingset detection is implemented for the
swap cache. Swap cache's node is usually allocated by kswapd and it
isn't charged by kmemcg since it is from the kernel thread. So the swap
cache's shadow node is managed by the node list of the list_lru rather
than the memcg specific one.

If counting the shadow node on the root memcg happens to reclaim the slab
object, the shadow node count returns the number of the shadow node on
the node list of the list_lru since root memcg has the kmem_cache_id, -1.

However, the size of pages on the LRU is calculated by using the specific
memcg, so mismatch happens. This causes the number of shadow node not to
be increased to the enough size and, therefore, workingset detection
cannot work correctly. This patch fixes this bug by checking if the memcg
is the root memcg or not. If it is the root memcg, instead of using
the memcg-specific LRU, the system-wide LRU is used to calculate proper
size of the shadow node so that the number of the shadow node can grow
as expected.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/workingset.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index 5fb8f85..a9f474a 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -468,7 +468,13 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
 	 * PAGE_SIZE / xa_nodes / node_entries * 8 / PAGE_SIZE
 	 */
 #ifdef CONFIG_MEMCG
-	if (sc->memcg) {
+	/*
+	 * Kernel allocation on root memcg isn't regarded as allocation of
+	 * specific memcg. So, if sc->memcg is the root memcg, we need to
+	 * use the count for the node rather than one for the specific
+	 * memcg.
+	 */
+	if (sc->memcg && !mem_cgroup_is_root(sc->memcg)) {
 		struct lruvec *lruvec;
 		int i;
 
-- 
2.7.4

