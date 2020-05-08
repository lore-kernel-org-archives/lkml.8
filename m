Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD73BC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9096B2192A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="zsUtCnon"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgEHSca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 14:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727937AbgEHSc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 14:32:27 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC68C05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 11:32:26 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id w18so1230792qvs.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 11:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OaPQ/6k0L3jh0C6o7CfSb8YWPSRRpIDUVegV83C74dM=;
        b=zsUtCnonxo6Zog/FPVNSwTnBaCeM0640kwri6ouMQy5dP2WS5K0VL3Uvua0clO1WBf
         BRitoPXoqUDeRAN3oCRArMc0i5WyRWV5zibXNnGvLKFsfxZfB46eyMtJ1T+ADLs86OCv
         LZx/kJXhWDmi573Z9v9iEtE7MPuSnPQAeSsW9ktSHlahFKAGyE3tgF/3HMfZppUOuR2T
         vtpeWzPAdHEQDHLQ+DLtQo6+dje3HLAIlF7UMTktdJowPW9vr1UAxTEoHprG65c/iRSm
         pLM0u4C80GxbnbdQrdhxsGROOssrDKHBbDmYIIdnn4iZb4ScmI8zkH0K8z67JNA8P1nt
         w/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OaPQ/6k0L3jh0C6o7CfSb8YWPSRRpIDUVegV83C74dM=;
        b=a53RtS4BjKfLESSQvQjj5/4XYpOHOs5PvheA002RGwrY5s07S6IpflFKYbtROfGUg6
         8HEHynsjWh5JHjle6qzsSM1vgILG+U+1HnqhpuZAOcvzCoL6qbX/6esQeJvVldgeg4rp
         0Hb3sgJ7MEnPOHhU4YfkmB/BR1lTCRKK+8s243Cn3TfOSt5zox4c3CqYXRLZYHuoFUBF
         uX4mq1kLUJFmmE5Yxd8lHHWSzQeKYWG7RV0jQPsjCGZRoHB3ttUpv04lzlyf5Ir3ngL6
         7RIZzg0WTMtHq+cgZ9rNPreUluZPr8HUfqwUIpsnTMgCxbWl/GD/Eub+AIT661Hs+pkR
         hcng==
X-Gm-Message-State: AGi0Pub/DpnQHhlP3mRDTbcl5VPWtsCftODdPSUXHD2NIcYOkt5pPetK
        CrezWoFYsa3cT3/OXwWIBl18EA==
X-Google-Smtp-Source: APiQypKCSdSc0epyu6nb+Tpb5XOJSFpmyaxgKolFX3J9ZjZhpGz+pazhpY0Kj+ub8fsq8v8fRnV6dg==
X-Received: by 2002:a05:6214:42b:: with SMTP id a11mr4097681qvy.186.1588962745866;
        Fri, 08 May 2020 11:32:25 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2627])
        by smtp.gmail.com with ESMTPSA id o94sm2046783qtd.34.2020.05.08.11.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 11:32:25 -0700 (PDT)
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
Subject: [PATCH 08/19] mm: memcontrol: prepare cgroup vmstat infrastructure for native anon counters
Date:   Fri,  8 May 2020 14:30:55 -0400
Message-Id: <20200508183105.225460-9-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508183105.225460-1-hannes@cmpxchg.org>
References: <20200508183105.225460-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anonymous compound pages can be mapped by ptes, which means that if we
want to track NR_MAPPED_ANON, NR_ANON_THPS on a per-cgroup basis, we
have to be prepared to see tail pages in our accounting functions.

Make mod_lruvec_page_state() and lock_page_memcg() deal with tail
pages correctly, namely by redirecting to the head page which has the
page->mem_cgroup set up.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/memcontrol.h | 5 +++--
 mm/memcontrol.c            | 9 ++++++---
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 57339514d960..5b110ac7dd83 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -723,16 +723,17 @@ static inline void mod_lruvec_state(struct lruvec *lruvec,
 static inline void __mod_lruvec_page_state(struct page *page,
 					   enum node_stat_item idx, int val)
 {
+	struct page *head = compound_head(page); /* rmap on tail pages */
 	pg_data_t *pgdat = page_pgdat(page);
 	struct lruvec *lruvec;
 
 	/* Untracked pages have no memcg, no lruvec. Update only the node */
-	if (!page->mem_cgroup) {
+	if (!head->mem_cgroup) {
 		__mod_node_page_state(pgdat, idx, val);
 		return;
 	}
 
-	lruvec = mem_cgroup_lruvec(page->mem_cgroup, pgdat);
+	lruvec = mem_cgroup_lruvec(head->mem_cgroup, pgdat);
 	__mod_lruvec_state(lruvec, idx, val);
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index fe4212db8411..b7be4cd6ddc5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1979,6 +1979,7 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg)
  */
 struct mem_cgroup *lock_page_memcg(struct page *page)
 {
+	struct page *head = compound_head(page); /* rmap on tail pages */
 	struct mem_cgroup *memcg;
 	unsigned long flags;
 
@@ -1998,7 +1999,7 @@ struct mem_cgroup *lock_page_memcg(struct page *page)
 	if (mem_cgroup_disabled())
 		return NULL;
 again:
-	memcg = page->mem_cgroup;
+	memcg = head->mem_cgroup;
 	if (unlikely(!memcg))
 		return NULL;
 
@@ -2006,7 +2007,7 @@ struct mem_cgroup *lock_page_memcg(struct page *page)
 		return memcg;
 
 	spin_lock_irqsave(&memcg->move_lock, flags);
-	if (memcg != page->mem_cgroup) {
+	if (memcg != head->mem_cgroup) {
 		spin_unlock_irqrestore(&memcg->move_lock, flags);
 		goto again;
 	}
@@ -2049,7 +2050,9 @@ void __unlock_page_memcg(struct mem_cgroup *memcg)
  */
 void unlock_page_memcg(struct page *page)
 {
-	__unlock_page_memcg(page->mem_cgroup);
+	struct page *head = compound_head(page);
+
+	__unlock_page_memcg(head->mem_cgroup);
 }
 EXPORT_SYMBOL(unlock_page_memcg);
 
-- 
2.26.2

