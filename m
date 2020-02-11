Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25600C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 06:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E6A208C4
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 06:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8+gkVEx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgBKGUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 01:20:33 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40071 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbgBKGU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 01:20:29 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so3833405plp.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 22:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vhjcjAXSe/y4wvj+GJktp0lCL/rhZzJbEkZv0Rz8J3s=;
        b=h8+gkVEx9vXkAAQFIngjWuVqspD+lGBkSftfueODYCJIA221nWA1wOUmU3avSebYhZ
         P2VcGSpdUnlXcgiZlM863mQ/v8v/w/5R38HzPKONS+l0YXIwOK46aJaEF38GVXQRufBx
         J25LMmyM9hUSO5x6cw2ri3kk0DTDR+FPfXwkhuOWlDTARBuwDokhkjfxEKFRP4tbU+l+
         ZmcZaAuIdbYKwJ9P7VemfBjeQTkzE4WAfvh7uV7fW9Y1LDbbJ/OSHq/eSBNCl8N/SNGq
         QcKHCxyaRTtcnwx064m4RV+LYWzqZ2JPRtXpgQco0TuzPg/dUNGFUccyjm4WhIw5ZWBG
         q9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vhjcjAXSe/y4wvj+GJktp0lCL/rhZzJbEkZv0Rz8J3s=;
        b=Oe6zAzM7IkMBToyDOLq46Fvqe0ZtgipttB+zoUOuqhidbNgUIVHMDgvUo87S6Nd+bI
         afFt2BrjPnIPx0qFd5yPXUsiSkEz86Bh+jNYeNnCpblgCSe++QHQlJHxC2tk4ekA347L
         eWkiuM/Y2xZJ/gGrjq9NMBsyqS/VwDbhvE1xHA25W93J1STs3nUyHdICIGTp5YqhbeO/
         d+Ke4FYYYI/S7NC7ucS2/zVWNfgxZj9UITjuXRTbZoMhpQw4X44h2pSnWIp+/spOplVJ
         fb0OcQBIg+/r3HaQw3mkxK0ALT7pcQqCOmx2RGFxygnGWp/wXUlRM3Ndk5b5eBGeGx1m
         6AqA==
X-Gm-Message-State: APjAAAWUR8kBU1H8Ak+ALtnOT1S74lBsMKbAtYUlK8J51KDBTSoPeG3a
        va6VBAkO7FTNJqknrK1kOh8=
X-Google-Smtp-Source: APXvYqx8Sx/tt2hOQkWb50Oo0CRZIN6lgR3hNkyRJ7/KCKenmmV9Y0FjzMQmQ/umdIv26f8bJka6Qg==
X-Received: by 2002:a17:90a:8586:: with SMTP id m6mr1854877pjn.121.1581402028634;
        Mon, 10 Feb 2020 22:20:28 -0800 (PST)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id x197sm2578696pfc.1.2020.02.10.22.20.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Feb 2020 22:20:28 -0800 (PST)
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
Subject: [PATCH 6/9] mm/workingset: handle the page without memcg
Date:   Tue, 11 Feb 2020 15:19:50 +0900
Message-Id: <1581401993-20041-7-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581401993-20041-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1581401993-20041-1-git-send-email-iamjoonsoo.kim@lge.com>
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
index 636aafc..20286d6 100644
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

