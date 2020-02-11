Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA49BC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 06:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA0320714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 06:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSS0geKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgBKGU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 01:20:29 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42605 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbgBKGU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 01:20:27 -0500
Received: by mail-pf1-f194.google.com with SMTP id 4so4949928pfz.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 22:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=460wxLtmI3ryLyEB72gt4NohfkSkdpIrWM1CKB3DHkA=;
        b=DSS0geKjBvmmPD4/kQwA8is8vXGeoq3qm8aAQKoYT340gjoRm+GbH0B6oaUzmWq0Tl
         zdAQjI0Sfa4yclVNnvBJolDNAlcpXIYuXFBJYYbcoYvndL5gmmoZjak8fzn2iOdnAiZJ
         D9FtGyOfilb7hubOaxzyMmpOVe1zuiIudY55+dR0WmxfX0dqilmw1zhmRqCQUxW5/4xo
         /xGGFzwCA3dq/IvGC2c0i/Ahqg7sJNNyX+keJjR3Q4/hVuBsgt9UEZj6xBRmZAgXE4Lj
         ebbyjtfbft3xxZ8lFaiXZLybmgSAB4aliromL7TwYm9Q3zD0109vDdqpx80O7X7PAc8G
         oN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=460wxLtmI3ryLyEB72gt4NohfkSkdpIrWM1CKB3DHkA=;
        b=IxQJJHAZxPW33xsgQlXZKJk4wdVhX2JwyUwK1PR+wCK15qbzMUL+Yak/KuvFL/7er6
         FffzBmOqMzCWTVsyBiWg0JC8vW7ojXlUrOLoB/jAuh6OZSELWHa4OIQGSu+ftQuNftCq
         BfEMWD9pfwNIrNRgiv0XI9jCo9xKSu4db6nM3+IOTJY1paXKJ14grDb/6PlQj84Bqr7H
         JUI2N7UaBsHXtHnLUlysewkcNPhIKMWOg/SBvyioPaWue1nHZm85ztxZpzZrgAMepmuK
         Xq7ZHxggePLTztdnwSIMqofli4ixcm/Ir6lAgMRrVWNaR5Bs6BSYVNM1r3RnVqsVUVcD
         QSwg==
X-Gm-Message-State: APjAAAUwQR83z0e5+feT/sDmd/G0KmamzOO5rTVAceXZfX+KJN5YX5Fd
        Cw/y3ypn/kpyLVzTYYF/fBY=
X-Google-Smtp-Source: APXvYqyblQHupVZhudVVjhgl7nOM31gRBTNsRCyR9TAXoqAUtSeTf2m8XEotm90O3yBPeMp5oe/jDw==
X-Received: by 2002:a63:7457:: with SMTP id e23mr5451770pgn.386.1581402025451;
        Mon, 10 Feb 2020 22:20:25 -0800 (PST)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id x197sm2578696pfc.1.2020.02.10.22.20.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Feb 2020 22:20:25 -0800 (PST)
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
Subject: [PATCH 5/9] mm/workingset: use the node counter if memcg is the root memcg
Date:   Tue, 11 Feb 2020 15:19:49 +0900
Message-Id: <1581401993-20041-6-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581401993-20041-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1581401993-20041-1-git-send-email-iamjoonsoo.kim@lge.com>
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
index d04f70a..636aafc 100644
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

