Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE7AC11D81
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D14E24654
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNXlrIU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgBTFMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 00:12:22 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37480 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgBTFMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 00:12:20 -0500
Received: by mail-pf1-f193.google.com with SMTP id p14so1308252pfn.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 21:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9wb/P3LPDlbugq1CDyVA5kSUSv6vOvUhfJXNTDD+0wY=;
        b=SNXlrIU9vBkpDfdPdssBSOmNPnkkuPS8e9u8DKOKxgUG2zjLVLmiawotnQ7HGxuBvp
         TtmFtfHu9I5EAyoS14CaZ1dEJe/YpiXVccQYzt/ombDO0lbXOesSmoybJcyQwQWH1+yi
         qYCh8vavpMm6H6Wt6RLSv4ImGte9dPS5TZfryLqP6SFK/9wnlhYyf81sChx4KqTyGnDP
         Wq2ctFI2eUql1q0CGLCgYPytPx1kosaKCW3mFFybgRqfflwuAojiY860V+C4p+vQ9Mji
         1CSnkGQtP78B77oscphEFESc+dR4BpUJuVmgD7MNkYkSN331A0bDPIf0N0e8U8PCQuT8
         iy6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9wb/P3LPDlbugq1CDyVA5kSUSv6vOvUhfJXNTDD+0wY=;
        b=CVvY8h6P0LkwDl6xzzujnJDoITA/pTVkGyPXjwv20GtQzQDovOt5oEkuqtiGAeLdRp
         fyMDcsAaLSJ56VDdDSo8k4Au9POpH+kCO5FpBiS5xfBAwrVOENssi/YSNlKOeQvEIoav
         nfKamqBt/3f5hDept08jP/up9Jh2mW7pqcuQVqhwIXTsxt12k9p6gadVTkS8++38Fj0v
         rbMK6ntkD0Q7yW2zbIcpIbxA0B+Y7HUCZvNhP43lNGyxj3syxkaAe4tIVqhfxhBzug5V
         y7K80uMi8Dq/tmlGdBSbgKhuLKpuAvZAn66VzWey3hF0vnhjwRjePZKH8nRCJCMdp+kg
         OYXw==
X-Gm-Message-State: APjAAAXbSGlPjOryP24oIveraUJV13a84d3igAJ1lx8GJO4wmK5+6r3x
        nmCYH+ywRv4MVL2wb2NazTI=
X-Google-Smtp-Source: APXvYqxGhH1XvgsCzvYlxhVrJSu1Cx/AEALUQCK1x+DR5+5e9wZy+smGUonK+C39lOt0K325+K/Rjg==
X-Received: by 2002:a62:1cd6:: with SMTP id c205mr30226967pfc.179.1582175538873;
        Wed, 19 Feb 2020 21:12:18 -0800 (PST)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id t15sm1472599pgr.60.2020.02.19.21.12.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Feb 2020 21:12:18 -0800 (PST)
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
Subject: [PATCH v2 5/9] mm/workingset: use the node counter if memcg is the root memcg
Date:   Thu, 20 Feb 2020 14:11:49 +0900
Message-Id: <1582175513-22601-6-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582175513-22601-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1582175513-22601-1-git-send-email-iamjoonsoo.kim@lge.com>
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

