Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53636C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 334E024953
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="E2/VFAYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgEHScU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 14:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727095AbgEHScQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 14:32:16 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336B8C05BD09
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 11:32:16 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id z90so2119969qtd.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 11:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EjChPX7glAdooI23QIihtHHWKSsyoFkOYmamMQuDTUs=;
        b=E2/VFAYie4kY0oIe+I5W4UoCkIR1MFpm8OEx4ahvA8yieQG6LQNzAimM1n3W6Li+Oc
         I0/5BUjFGqhTxN8yW7GlZ3Qzgx77PFKUTO/h1kkZEBPp6kUrL/LmkNlQb1nLZXjWmB0e
         rVfbzBbUsU1z770LBdlYdN5Lm4Dn5WiB6Yvl/XrvK1A2xYQHB9jIvQZjN+BkQ6AHKJ0Z
         vLZWRfxOlBhIZzVQIEwWwp+RcnrRAK1wpNAGjkQX5HJxuSN0dt59OcKSyfcOZ8DqFpJe
         5E+Xw3g91V+3mRBPj1qstLwYoLSWZwC6SzFfsjqKkKRqw6wOVDd6flbMtu4wLGK37FZw
         LjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EjChPX7glAdooI23QIihtHHWKSsyoFkOYmamMQuDTUs=;
        b=to3Qh81sCteaFrEDrse3W9fMtEUp3a+aTXbms4i54EstkbW74FJ83sEEPdhWuMLCjn
         P+loAqBhYvaamMx1zlXQSkvU6IAO939zbMb+gKqqpHhCpUsFVmLZClUuIPX7iTllQ9pC
         NMKRvAKgd9z54iN1u3u8vzd15SlLTLAwKqhL7MZKrESOI/jCQ2NrKp775ZHm2N0/KD09
         QMgZjYs5Pwq6znGNCALv9H9o3wsbRmuhD5XQHtrHAzFw3ZtD+jULRGmZv3UL4yw4CDYa
         1FM8A3LiZgy0R/4JoQApzHNoF9ky61D/GinFdJDLrUJ1XuFKlcHFTdVIOdKEHJchM5s6
         UnQw==
X-Gm-Message-State: AGi0PuZQPnucv/9t71w5D4YFUzlwQ0zFsSkCT+bFxB+W7eT664kLpYTY
        1LnxRwP7QZhNgM2XZmFeFL6FZQ==
X-Google-Smtp-Source: APiQypKfEaNko+TNl5fRiEjFygGSRu6c+fbfE4Rvr4dO+JYHm+E6+/ujwz88q8b+m6+BImDW3PWNwA==
X-Received: by 2002:ac8:c0d:: with SMTP id k13mr1670052qti.136.1588962735392;
        Fri, 08 May 2020 11:32:15 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2627])
        by smtp.gmail.com with ESMTPSA id g11sm1725212qkk.106.2020.05.08.11.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 11:32:14 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Joonsoo Kim <js1304@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 02/19] mm: memcontrol: fix stat-corrupting race in charge moving
Date:   Fri,  8 May 2020 14:30:49 -0400
Message-Id: <20200508183105.225460-3-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508183105.225460-1-hannes@cmpxchg.org>
References: <20200508183105.225460-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The move_lock is a per-memcg lock, but the VM accounting code that
needs to acquire it comes from the page and follows page->mem_cgroup
under RCU protection. That means that the page becomes unlocked not
when we drop the move_lock, but when we update page->mem_cgroup. And
that assignment doesn't imply any memory ordering. If that pointer
write gets reordered against the reads of the page state -
page_mapped, PageDirty etc. the state may change while we rely on it
being stable and we can end up corrupting the counters.

Place an SMP memory barrier to make sure we're done with all page
state by the time the new page->mem_cgroup becomes visible.

Also replace the open-coded move_lock with a lock_page_memcg() to make
it more obvious what we're serializing against.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 317dbbaac603..cdd29b59929b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5376,7 +5376,6 @@ static int mem_cgroup_move_account(struct page *page,
 {
 	struct lruvec *from_vec, *to_vec;
 	struct pglist_data *pgdat;
-	unsigned long flags;
 	unsigned int nr_pages = compound ? hpage_nr_pages(page) : 1;
 	int ret;
 	bool anon;
@@ -5403,18 +5402,13 @@ static int mem_cgroup_move_account(struct page *page,
 	from_vec = mem_cgroup_lruvec(from, pgdat);
 	to_vec = mem_cgroup_lruvec(to, pgdat);
 
-	spin_lock_irqsave(&from->move_lock, flags);
+	lock_page_memcg(page);
 
 	if (!anon && page_mapped(page)) {
 		__mod_lruvec_state(from_vec, NR_FILE_MAPPED, -nr_pages);
 		__mod_lruvec_state(to_vec, NR_FILE_MAPPED, nr_pages);
 	}
 
-	/*
-	 * move_lock grabbed above and caller set from->moving_account, so
-	 * mod_memcg_page_state will serialize updates to PageDirty.
-	 * So mapping should be stable for dirty pages.
-	 */
 	if (!anon && PageDirty(page)) {
 		struct address_space *mapping = page_mapping(page);
 
@@ -5430,15 +5424,23 @@ static int mem_cgroup_move_account(struct page *page,
 	}
 
 	/*
+	 * All state has been migrated, let's switch to the new memcg.
+	 *
 	 * It is safe to change page->mem_cgroup here because the page
-	 * is referenced, charged, and isolated - we can't race with
-	 * uncharging, charging, migration, or LRU putback.
+	 * is referenced, charged, isolated, and locked: we can't race
+	 * with (un)charging, migration, LRU putback, or anything else
+	 * that would rely on a stable page->mem_cgroup.
+	 *
+	 * Note that lock_page_memcg is a memcg lock, not a page lock,
+	 * to save space. As soon as we switch page->mem_cgroup to a
+	 * new memcg that isn't locked, the above state can change
+	 * concurrently again. Make sure we're truly done with it.
 	 */
+	smp_mb();
 
-	/* caller should have done css_get */
-	page->mem_cgroup = to;
+	page->mem_cgroup = to; 	/* caller should have done css_get */
 
-	spin_unlock_irqrestore(&from->move_lock, flags);
+	__unlock_page_memcg(from);
 
 	ret = 0;
 
-- 
2.26.2

