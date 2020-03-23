Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184EBC54FD2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 05:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C1120732
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 05:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhbjjMzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgCWFwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 01:52:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38637 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgCWFwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 01:52:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id z25so2642914pfa.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 22:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j6iK115r4yAzPkHgkiyJxNjSgms6sufr4Xa73STF5NU=;
        b=MhbjjMzHYMVqut2cxjnRgSo4EzX/RmSpB+NTDaZJlIyJPLHdIGtwn2W90ekr7noqsy
         ZgvlnsLH/A/9OksZ+dM68Nkmsukei9TQVt24kt9/n9+P1qMjVAuagaUUgYzBEDuaX8pG
         0E02S14KWAGYZfwuelei0KPOpyEfxT62v3XUzt7sCTqTf0K/kWLLCvGZE1C+M3LZ9Xj1
         dkk9Kmwqd/Tz2gHENJqmU/Pa6AZkTWGQD3X+id7GF4Q1NCneOQYWSSEN3OBHkd4jkhkl
         PiahZHukZV9OWCv79YCX3h4FiFchwU3xh60ujYOsqE8G6cOQqAVygojyxChwtdyNWXGD
         aHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j6iK115r4yAzPkHgkiyJxNjSgms6sufr4Xa73STF5NU=;
        b=Hj55HEQQYfUInmKqpPq0cHiMoA9ET2gah0e70YYPZoJPEBFuff/D9nVeB3NiQdgoSX
         SENVYFKMDjUz/CkPX/i9sGCL7r+U6aSTejV0Jj7+tmNfOg735erUqbpTK1+QZvY495L3
         grQptr44cFQxMWN5fmrIwZeQ2trh8s4e1awDG5ecquk46c/LPbGQ6/PYB/50ARrP0Y81
         4nf6Kf5R/F2GJvKCFXa2uEADyby52eK+maQRNJm7H7ktBjdciaNKtNKHzsFPiusEhoT4
         jfZgbsouMQYXYg+fUUiRL40MBlgqFYVIzfqu6/P+sucf3MPFNpuDD9Jo5cTK2iAyBL6c
         flOg==
X-Gm-Message-State: ANhLgQ10yeEYOBgz5CVNCt2b2etOIxWRaygEHeDviSqggEWC/3yuYoPg
        uFy2IUJMwJ1wJ0QhexOavMo=
X-Google-Smtp-Source: ADFU+vuuqKs7zJRbxUVUMawYsBYRVOcpKxBqEI48FeeqPqBtqZ8stvfIg91WljIs4dIh07BgiEwzHA==
X-Received: by 2002:a65:641a:: with SMTP id a26mr13873989pgv.247.1584942766280;
        Sun, 22 Mar 2020 22:52:46 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id y30sm12563058pff.67.2020.03.22.22.52.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Mar 2020 22:52:45 -0700 (PDT)
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
Subject: [PATCH v4 5/8] mm/workingset: handle the page without memcg
Date:   Mon, 23 Mar 2020 14:52:09 +0900
Message-Id: <1584942732-2184-6-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584942732-2184-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1584942732-2184-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

When implementing workingset detection for anonymous page, I found
some swapcache pages with NULL memcg. They are brought in by swap
readahead and nobody has touched it.

The idea behind the workingset code is to tell on page fault time
whether pages have been previously used or not. Since this page
hasn't been used, don't store a shadow entry for it; when it later
faults back in, we treat it as the new page that it is.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/workingset.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/workingset.c b/mm/workingset.c
index 59415e0..8b192e8 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -257,6 +257,19 @@ void *workingset_eviction(struct page *page, struct mem_cgroup *target_memcg)
 	VM_BUG_ON_PAGE(page_count(page), page);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 
+	/*
+	 * A page can be without a cgroup here when it was brought in by
+	 * swap readahead and nobody has touched it since.
+	 *
+	 * The idea behind the workingset code is to tell on page fault
+	 * time whether pages have been previously used or not. Since
+	 * this page hasn't been used, don't store a shadow entry for it;
+	 * when it later faults back in, we treat it as the new page
+	 * that it is.
+	 */
+	if (!page_memcg(page))
+		return NULL;
+
 	advance_inactive_age(page_memcg(page), pgdat, file);
 
 	lruvec = mem_cgroup_lruvec(target_memcg, pgdat);
-- 
2.7.4

