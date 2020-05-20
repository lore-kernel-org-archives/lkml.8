Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DB8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 621F32089D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="Fz6dmISB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgETX0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 19:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728462AbgETX0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 19:26:08 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09DFC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:26:08 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f13so5535044qkh.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HJDfvKd/xQ+U/A8BiqznBlIOAX4alsApJfZU8rh9CnI=;
        b=Fz6dmISBeqccLp92SIXlWpZ4Azk3J/vmLzFY5xmcQlxADIPoHHlyHraLVAj7OZUKVp
         n3BskcozIV7s77yj6cNgbDIZni1VpzH871u2OMtUJXOOmAHgFtjBsBG0UFMjJRBJupvC
         Yz5A9ODIDyk5meuBLYNJ5wk/syTQIMSwrII92tLUyMni08y2bsn59zRkQGqhiZdZHyvA
         wibKQvsMqsubKVxJ4Xn53Wz6L/XBKMlWCs/peKgGpGu2sLdIaDzkpgLcBysyBP7RqTu1
         PUFqqHOtLdaL7yYc+m6Qc+PlYM91ZKwumkyvKsNL8e3t2TFpfyfMfX5SYHtuwf7ee0xA
         yd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HJDfvKd/xQ+U/A8BiqznBlIOAX4alsApJfZU8rh9CnI=;
        b=FwsfTnbvrBK0r5U72E+pBnMB9rqmRamyCS46CYyEuB7Zk43Pk085LprMA0HEpeSur4
         0b+mHl5PS/7IDMUxfqE3O7upBC9Gdq0Qhple/xQeD+naoLI025bOXI33o5eVJM0fKm8N
         3rXCdafx7IgO/dlxOmJHPCO9HygKgoHePS9QOqGmCuyLgLjZWzj/rBqYHPY/6YXbf4Ko
         wI8jIT4z88IoQaF6nZRiWJsbldxWpPyqMasr6Pp9CUT/qbTX/EiQviTbixtwwyGIdv0P
         sI/szyrP8A0wruIQ2tvHdzIVogjHFxyNzEjFC90bO9qNm5SWFEmsCB/t+ABp1k7ndOxt
         awgw==
X-Gm-Message-State: AOAM530VpTYS8IdxICTu5G2yOa2Uyw2q628fwkdm3P+jGxNacKJmXZtc
        E0D3bwzMACMvJu7pRx2QOh+UxA4Eb/c=
X-Google-Smtp-Source: ABdhPJxoMydyCn7v1MWAcLb23MBY3YgxIiym2FF8pOGzEVh285Tr6htPKp/YVFywnRRUF3nRDo/cLA==
X-Received: by 2002:ae9:e404:: with SMTP id q4mr7364353qkc.129.1590017167920;
        Wed, 20 May 2020 16:26:07 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4708])
        by smtp.gmail.com with ESMTPSA id o3sm3596698qtt.56.2020.05.20.16.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 16:26:07 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 05/14] mm: workingset: let cache workingset challenge anon
Date:   Wed, 20 May 2020 19:25:16 -0400
Message-Id: <20200520232525.798933-6-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520232525.798933-1-hannes@cmpxchg.org>
References: <20200520232525.798933-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We activate cache refaults with reuse distances in pages smaller than
the size of the total cache. This allows new pages with competitive
access frequencies to establish themselves, as well as challenge and
potentially displace pages on the active list that have gone cold.

However, that assumes that active cache can only replace other active
cache in a competition for the hottest memory. This is not a great
default assumption. The page cache might be thrashing while there are
enough completely cold and unused anonymous pages sitting around that
we'd only have to write to swap once to stop all IO from the cache.

Activate cache refaults when their reuse distance in pages is smaller
than the total userspace workingset, including anonymous pages.

Reclaim can still decide how to balance pressure among the two LRUs
depending on the IO situation. Rotational drives will prefer avoiding
random IO from swap and go harder after cache. But fundamentally, hot
cache should be able to compete with anon pages for a place in RAM.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/workingset.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index 474186b76ced..e69865739539 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -277,8 +277,8 @@ void workingset_refault(struct page *page, void *shadow)
 	struct mem_cgroup *eviction_memcg;
 	struct lruvec *eviction_lruvec;
 	unsigned long refault_distance;
+	unsigned long workingset_size;
 	struct pglist_data *pgdat;
-	unsigned long active_file;
 	struct mem_cgroup *memcg;
 	unsigned long eviction;
 	struct lruvec *lruvec;
@@ -310,7 +310,6 @@ void workingset_refault(struct page *page, void *shadow)
 		goto out;
 	eviction_lruvec = mem_cgroup_lruvec(eviction_memcg, pgdat);
 	refault = atomic_long_read(&eviction_lruvec->inactive_age);
-	active_file = lruvec_page_state(eviction_lruvec, NR_ACTIVE_FILE);
 
 	/*
 	 * Calculate the refault distance
@@ -345,10 +344,18 @@ void workingset_refault(struct page *page, void *shadow)
 
 	/*
 	 * Compare the distance to the existing workingset size. We
-	 * don't act on pages that couldn't stay resident even if all
-	 * the memory was available to the page cache.
+	 * don't activate pages that couldn't stay resident even if
+	 * all the memory was available to the page cache. Whether
+	 * cache can compete with anon or not depends on having swap.
 	 */
-	if (refault_distance > active_file)
+	workingset_size = lruvec_page_state(eviction_lruvec, NR_ACTIVE_FILE);
+	if (mem_cgroup_get_nr_swap_pages(memcg) > 0) {
+		workingset_size += lruvec_page_state(eviction_lruvec,
+						     NR_INACTIVE_ANON);
+		workingset_size += lruvec_page_state(eviction_lruvec,
+						     NR_ACTIVE_ANON);
+	}
+	if (refault_distance > workingset_size)
 		goto out;
 
 	SetPageActive(page);
-- 
2.26.2

