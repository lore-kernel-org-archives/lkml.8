Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DF3C5ACC1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 05:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B22120736
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 05:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Va/f0gGE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgCQFm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 01:42:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36763 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgCQFm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 01:42:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id z72so1250792pgz.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 22:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2X37snKsWsbjnSC5G8JKDN8U4XxTo8mCwhpNzWhIZ/g=;
        b=Va/f0gGE31wRD/TpGDskcGX2Bef2+hsg3s3UovewxNs+hxNqvyVU5KGLQw3dr5ThQO
         7fzmRVnDqkMUog4CZ9FAIBeHkKqg2Q1Frh+sYHmLspg5JB2MGLV4UgwE0eQ80S5f2dKW
         ZV/dJ/LIHbWXpoivteZR8rbN/cUhoheqoNq8bn4CbNg72ZZjcAHlL2Src5W6j62AUWiN
         dHfDYzcSQz2j8Nxz8F2PckPsowOUf+G/M6VPH531/csFrfA77H7cS8nOEJjM0gesiVW0
         XrWsRkV3MwgYK0VADbCHO9UBqPFCnM0df/HrTvxQrXLqHZKvlk2eAbQ5sRI+3xCv5P0L
         lo3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2X37snKsWsbjnSC5G8JKDN8U4XxTo8mCwhpNzWhIZ/g=;
        b=DATHk4hthfwocup7vKN5foHZld8kNCa7Ux5hqADcy31XmzQs+MxjoPjsuPPEMGbjDG
         DqH1HtMYs5ZjYTlEX6uq/cFOD3jTLYrssYNznq7Le0NjM45y3mltfTEyCMjw0JPJ/wkc
         TPTDIesgJmhAYKNAoDiPsSX8O8bE2sa/bPjjxmWONp2UKuO73GPj3/fz6AKjvZEGDx5N
         1T8UQ29Hs20MY9OnmvNSKTmMziRCi7NZghAUMmNMh+DCqu62Bm6uyGm+Wicvyywd5ykz
         Ixo3ZAcH5/X0kNPn3Lf92fQWAN9oKafgqTPtclGhcOcajipmig1aRrW5wozIYdtDREAY
         xmCA==
X-Gm-Message-State: ANhLgQ03UDGJ2OUIcqBqBX5auD2UMi6A88nD/sfCyi0BxWxzz8sPA9wx
        lSkCBXdsbS2ci9bMkYwADKs=
X-Google-Smtp-Source: ADFU+vtRuRKjW6rHDlPpf7QQve7i+QUC87wnc3hjTi1s21hkuBBIjKnImzczMw4JfQMWJdJjgTmz/Q==
X-Received: by 2002:a62:a116:: with SMTP id b22mr3541272pff.122.1584423745852;
        Mon, 16 Mar 2020 22:42:25 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id i21sm1141757pgn.5.2020.03.16.22.42.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Mar 2020 22:42:25 -0700 (PDT)
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
Subject: [PATCH v3 6/9] mm/workingset: handle the page without memcg
Date:   Tue, 17 Mar 2020 14:41:54 +0900
Message-Id: <1584423717-3440-7-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584423717-3440-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1584423717-3440-1-git-send-email-iamjoonsoo.kim@lge.com>
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

