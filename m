Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1152C2D0E5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 22:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B25882072F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 22:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpllLOss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgC0WBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 18:01:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39772 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbgC0WBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 18:01:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id e9so2252611wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 15:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XnLQep2lydjftwMmt6HoIl5lVjdDRVIm/B2qHNSgXII=;
        b=BpllLOssvHng2UrUTpZ8HD5uh0iHoPm0xW5pzyg910YurEuPaXzvxN9kcEyxiUYHHb
         pm+4GooXP881cTpknMX0aMtiqQ353cNcMFGZc69n4qIgwedXPcd0tVm17NgSxvVwUAwJ
         tq6sQtDrQpVNXUr7jHrkU0AqedXQLXfENEHXdbq6WKvPom1dWFK7Ie+mPXu+GT1y2jeP
         NwbEjCzfKhsFppSYBqt9apVdVWA2Wk0St1VsfjCIjtrg8u1mxn0hbpa28w1hZebMDCdq
         JU8ZehegVn88bcluyOprHYxGWh+IgRmaSlgsPSSXUHqJtAsg/XlPW2RLdT5sj2KVnlFR
         4G1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XnLQep2lydjftwMmt6HoIl5lVjdDRVIm/B2qHNSgXII=;
        b=fK+DE2dnE4/AtoDKM1+R2YQGpnfqM9VJWEPBlXICaNulwERBjLcqu9u5OSzI4OQAoj
         6JGpVywRcR7Hw5bUBSYiLNG3drp4f+yAR1nmqqg2tWzKEb+pg8WPfpKx2yUXXkItBL1s
         yrHUps7wvoUbmC9xQ1ynm+OaYqdGg1OhJr5wRg4P9H4uu5WQQieHII6nymzh/vgrEUHU
         SeLw/r9AVD4Gststgf4uqFtKlOzGU5d6PmRgjcDVAF+Kd7x2ULRq3JBP8zCpSULg/yJh
         RMjzP2HcOq5eQMk9W6QJAbo4GAdnUgmFvJz25x3cotLOLYJoaVkm94bstgt3huUE3MXX
         okRA==
X-Gm-Message-State: ANhLgQ1p7CCrJcJh4UUqi73In9BVgflLqDSEiDbcsqmZ68G0PFrvQBaW
        e+iy2d9jhVCEJ0mgKORVDk0=
X-Google-Smtp-Source: ADFU+vt/HkTH78PKwAOIbtRVmwgtK8/TzNy0i9xLfALHCE1xvdi6K+3teolQyt9PMe5QoSP2uFv7EQ==
X-Received: by 2002:a1c:2605:: with SMTP id m5mr833534wmm.184.1585346503517;
        Fri, 27 Mar 2020 15:01:43 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a186sm9522774wmh.33.2020.03.27.15.01.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Mar 2020 15:01:42 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca,
        david@redhat.com, Wei Yang <richard.weiyang@gmail.com>
Subject: [Patch v2 2/2] mm/page_alloc.c: define node_order with all zero
Date:   Fri, 27 Mar 2020 22:01:21 +0000
Message-Id: <20200327220121.27823-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200327220121.27823-1-richard.weiyang@gmail.com>
References: <20200327220121.27823-1-richard.weiyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we always clear node_order before getting it, we can leverage
compiler to do this instead of at run time.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 mm/page_alloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index dfcf2682ed40..49dd1f25c000 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5585,7 +5585,7 @@ static void build_thisnode_zonelists(pg_data_t *pgdat)
 
 static void build_zonelists(pg_data_t *pgdat)
 {
-	static int node_order[MAX_NUMNODES];
+	static int node_order[MAX_NUMNODES] = {0};
 	int node, load, nr_nodes = 0;
 	nodemask_t used_mask = NODE_MASK_NONE;
 	int local_node, prev_node;
@@ -5595,7 +5595,6 @@ static void build_zonelists(pg_data_t *pgdat)
 	load = nr_online_nodes;
 	prev_node = local_node;
 
-	memset(node_order, 0, sizeof(node_order));
 	while ((node = find_next_best_node(local_node, &used_mask)) >= 0) {
 		/*
 		 * We don't want to pressure a particular node.
-- 
2.23.0

