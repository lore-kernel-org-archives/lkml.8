Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7525DC3404C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9FC24654
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Acq69Agx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgBTFMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 00:12:25 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40746 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbgBTFMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 00:12:22 -0500
Received: by mail-pf1-f194.google.com with SMTP id b185so1299202pfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 21:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2X37snKsWsbjnSC5G8JKDN8U4XxTo8mCwhpNzWhIZ/g=;
        b=Acq69AgxNmIWtDhcNNl9N3V0JLpmicXt0Bv9AbkvFUJAHq3y91fvxJdDryQwz+cnpi
         Pfm0pSzDI/CaisNYqIVBO/V1ClVjL+SXL2KT3EUETedpQ2XWinfVYgT2AedKKPkhoQDP
         zxQYofRDAjLEWzKHaPf6ToP1AT4OtI5kDOlfdbtkcMlqY9KfEekAaNk2ULAWA5Kr9uRs
         mmI87WTsKFiasYV6UZhrWx6G3gd29kPFGn9SQ0UruMk33Np3tYR2tTmJ644tm7wB466E
         m1vb18qsNVNnanSgzygrz3lHf1Ngfg0Ef2TOYBJOp5clE9xXnggl972BSJLHQkS87Dg8
         QMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2X37snKsWsbjnSC5G8JKDN8U4XxTo8mCwhpNzWhIZ/g=;
        b=ogbW3ZE8PELgGuWe+0DHOKDyZnuuBNoScdCJrrGYSyl2+5Ye/enq574ZowHW0GciZ0
         AOXABkFKnBQoXxEUhONpGYeaRIm61A+VmQibLwNxKyP82LcHbP6N56F/58ecg2Edn5iA
         k7lJ+QQb08yGphH/Ni937uFntieHdDHlGnoiWf6bPe/cbr4VPHLMuKGk96a7Xs9C7+Bu
         t+OA9VvLYEtRjwzb5kZx7AUfwmo2lPijWiisc4RGoXyF3IhqcXcI9zNXH2pqXrzizqgZ
         Nf9prUDjFj3MF95J95Dy3pF5XlSqC5Ue4ZpjhlaZkURwuOHXLJqpqct+uqPoMfrHdRq2
         2AMg==
X-Gm-Message-State: APjAAAW3fW2thw0AY+ubjnEWjqLPEfbIVk5liDWZgs8Kv4pDvWCQFSHo
        F/Z7sBSIb3K8KF/xGE1bbQQ=
X-Google-Smtp-Source: APXvYqzj2jLsMKBB2X799oxwYMJQK2EJEVp0IToh9yv4SjwCu5TpPnSa2+xq1RiJnio9Ww+ylpkcJA==
X-Received: by 2002:a62:18c9:: with SMTP id 192mr29983465pfy.117.1582175542013;
        Wed, 19 Feb 2020 21:12:22 -0800 (PST)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id t15sm1472599pgr.60.2020.02.19.21.12.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Feb 2020 21:12:21 -0800 (PST)
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
Subject: [PATCH v2 6/9] mm/workingset: handle the page without memcg
Date:   Thu, 20 Feb 2020 14:11:50 +0900
Message-Id: <1582175513-22601-7-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582175513-22601-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1582175513-22601-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

When implementing workingset detection for anonymous page, I found
some swapcache pages with NULL memcg. From the code reading, I found
two reasons.

One is the case that swap-in readahead happens. The other is the
corner case related to the shmem cache. These two problems should be
fixed, but, it's not straight-forward to fix. For example, when swap-off,
all swapped-out pages are read into swapcache. In this case, who's the
owner of the swapcache page?

Since this problem doesn't look trivial, I decide to leave the issue and
handles this corner case on the place where the error occurs.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/workingset.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/workingset.c b/mm/workingset.c
index a9f474a..8d2e83a 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -257,6 +257,10 @@ void *workingset_eviction(struct page *page, struct mem_cgroup *target_memcg)
 	VM_BUG_ON_PAGE(page_count(page), page);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 
+	/* page_memcg() can be NULL if swap-in readahead happens */
+	if (!page_memcg(page))
+		return NULL;
+
 	advance_inactive_age(page_memcg(page), pgdat, is_file);
 
 	lruvec = mem_cgroup_lruvec(target_memcg, pgdat);
-- 
2.7.4

