Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254C4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0261A20759
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="OELmW9qL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbgETX0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 19:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728846AbgETX0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 19:26:16 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46126C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:26:16 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f189so5498381qkd.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cWi8GUMvjXVcjgAmpN1v26MqAhRkGwn3WDFKVSmqebQ=;
        b=OELmW9qLobpcB8i03ujKYrp+niXe2qkQDDyCEagaV+SP83teno7CkK8mwvctRBTkg1
         Jn2aAhUzNJaZz9tfP80zhnf138nqWeO0vsvISlzXvS2SGVB93ZvUEVNaN3q2O+GkN7NE
         bjg8Tg/TDJarAz+t2CHuC3NxYvV30ehHzuIqNk7gjrpRyt3UkikzztTsRkDHEd+njr0f
         nM8CH+weltbNVSkCzZRV+t3r4RbdHr+Pw5a8Kuz1ujBKDCzLMMOzuAcXrX8etVZiQqlc
         HFQ0hCpStUibnNrSOGGtuXoKx+Y7Xr81FW+cwTS/uhV6bMLBMl+hCXebE0sLmM8ZmxPZ
         /01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cWi8GUMvjXVcjgAmpN1v26MqAhRkGwn3WDFKVSmqebQ=;
        b=JAdN8SARWVEmFdi2b+LLiE5WA5lmrPjahPZyXgQlwTa7PV9AEZJkvSP0sv0PAXD+TG
         5AiwD2hoIRagYNvxW+eNOkqPRK4F10MzajZKlc79VT2jklJ0zLEvf5QgWJnX0pAakLqT
         a33F6a5dqOmhGhrI/B9ENCPUMWH4LeMDPLnNnP4bm/dIAmd9qq6rEKwJQrrwRRHBReRF
         wW/tHfMERM99QLiASJgsGWfkC7EgTkF5dB9Wxad+oQDiT5BF2VZPidg2hHccnPPHUN5F
         h0TZtOdQBLcX3HUnoLadjDzCJZPduxKqbuQY8geOJ/DN4A0suyLgc/rbbhAZYaPoIPRW
         OXbw==
X-Gm-Message-State: AOAM533YN0dxHVtJApjVE1PzERn7WhATZOOwqzY5kNqJ0s/5gr9UJePq
        MYxTGQlHynfT4diKgf4f55aqyQ0ZJbw=
X-Google-Smtp-Source: ABdhPJw3U94cPbOfdJ5cTZaAWKG+ZGczSAYc2f5W6Y4QceSR5KNnjHRzPv09HTHZ8XUkGYZlDFHjoA==
X-Received: by 2002:a37:bd81:: with SMTP id n123mr7017392qkf.57.1590017175541;
        Wed, 20 May 2020 16:26:15 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4708])
        by smtp.gmail.com with ESMTPSA id p22sm2693945qkp.109.2020.05.20.16.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 16:26:14 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 10/14] mm: only count actual rotations as LRU reclaim cost
Date:   Wed, 20 May 2020 19:25:21 -0400
Message-Id: <20200520232525.798933-11-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520232525.798933-1-hannes@cmpxchg.org>
References: <20200520232525.798933-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When shrinking the active file list we rotate referenced pages only
when they're in an executable mapping. The others get deactivated.
When it comes to balancing scan pressure, though, we count all
referenced pages as rotated, even the deactivated ones. Yet they do
not carry the same cost to the system: the deactivated page *might*
refault later on, but the deactivation is tangible progress toward
freeing pages; rotations on the other hand cost time and effort
without getting any closer to freeing memory.

Don't treat both events as equal. The following patch will hook up LRU
balancing to cache and anon refaults, which are a much more concrete
cost signal for reclaiming one list over the other. Thus, remove the
maybe-IO cost bias from page references, and only note the CPU cost
for actual rotations that prevent the pages from getting reclaimed.

v2: readable changelog (Michal Hocko)

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Minchan Kim <minchan@kernel.org>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/vmscan.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6ff63906a288..2c3fb8dd1159 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2054,7 +2054,6 @@ static void shrink_active_list(unsigned long nr_to_scan,
 
 		if (page_referenced(page, 0, sc->target_mem_cgroup,
 				    &vm_flags)) {
-			nr_rotated += hpage_nr_pages(page);
 			/*
 			 * Identify referenced, file-backed active pages and
 			 * give them one more trip around the active list. So
@@ -2065,6 +2064,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 			 * so we ignore them here.
 			 */
 			if ((vm_flags & VM_EXEC) && page_is_file_lru(page)) {
+				nr_rotated += hpage_nr_pages(page);
 				list_add(&page->lru, &l_active);
 				continue;
 			}
@@ -2080,10 +2080,8 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	 */
 	spin_lock_irq(&pgdat->lru_lock);
 	/*
-	 * Count referenced pages from currently used mappings as rotated,
-	 * even though only some of them are actually re-activated.  This
-	 * helps balance scan pressure between file and anonymous pages in
-	 * get_scan_count.
+	 * Rotating pages costs CPU without actually
+	 * progressing toward the reclaim goal.
 	 */
 	lru_note_cost(lruvec, file, nr_rotated);
 
-- 
2.26.2

