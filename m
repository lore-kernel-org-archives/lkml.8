Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58385C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 355E420772
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JVho9R3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgHRSrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 14:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgHRSrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 14:47:14 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116D6C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 11:47:14 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id r1so23439639ybg.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 11:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/E5eAbEMdGecxil6UrL49SnbBNTAteYJO6ZYPEM5dLY=;
        b=JVho9R3BbAEAJN3/ABbAA0Q8qoaA4DB7htuEZjfa/UrhMXpsJYFmC7+ZhNNZwKO2NQ
         PUc5iLYdObTaoIIro8tIsaxuloxbDtq2BRHvJ4HImEh99kGzHSMlwGqvrpFkSNH5ILjH
         7OMrfDapLBjDBr/Ron5FwpH8Ed9zJSRBQoNzjeni2Bb9CZZZzkBMHI6Mo9WOMW9GV3Ks
         hGjjHW9qk302727BeP4WxexH6OJY479SyLXh2AXO/Et+r5tnXqWS8TzIEF24kDQVSBkz
         TVXnU9sXK1hSVqkA4lJrmI7dZxvQJSTmBveDUy51OpONWhUYv5f7/rdQAsba4BdwvKED
         meng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/E5eAbEMdGecxil6UrL49SnbBNTAteYJO6ZYPEM5dLY=;
        b=uiARhX3dWJ3DcW5pVaePWzG9Rt2qGZrb1y+F/3r8uhal/G1ZadHpI8kavQx9LuBkSN
         JSFsADgnhaIyiGhQ3TpunoKWyLLd5RF4p59jcb360elU/NhptluMA9njVeu9IrkYoVe/
         FnAK/IaeL10Ib/+bJ5d04XgYsLLL0vVDxhTcdlVdhlVmtliPKV2/QXIIBG2lJc1beILp
         Zw2l+iwIpOUjUup6ewSvN05eGcv3/WPkLqijrYzNwHh7eqAgvn+JZwCX2O0CoHJYVitk
         jN/n208HuPNZn9iPj8Bmx359befwuVMh6snVLxYGD5nEeQwh982WBfuab00DSOVOdkav
         vNgg==
X-Gm-Message-State: AOAM532836sve1nLrEsBbuID442/CvlgkZAdY+SAndt+Z1QtxbVhS7k+
        JHBQz9D4kuW8xFzHUzLxStm9WJMP4es=
X-Google-Smtp-Source: ABdhPJzU4R0PcrHVEc2b75WaWjsd33ALQzPjuw40VrEB0Drky/Odddmf1lW46QmY6IDqhw2oeSJVIkW1ZK8=
X-Received: by 2002:a25:3b0d:: with SMTP id i13mr28488393yba.314.1597776432330;
 Tue, 18 Aug 2020 11:47:12 -0700 (PDT)
Date:   Tue, 18 Aug 2020 12:47:02 -0600
Message-Id: <20200818184704.3625199-1-yuzhao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH v2 1/3] mm: remove activate_page() from unuse_pte()
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, Qian Cai <cai@lca.pw>,
        Mel Gorman <mgorman@suse.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        "=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?=" <jglisse@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't initially add anon pages to active lruvec after
commit b518154e59aa ("mm/vmscan: protect the workingset on anonymous LRU").
Remove activate_page() from unuse_pte(), which seems to be missed by
the commit. And make the function static while we are at it.

Before the commit, we called lru_cache_add_active_or_unevictable() to
add new ksm pages to active lruvec. Therefore, activate_page() wasn't
necessary for them in the first place.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/swap.h | 1 -
 mm/swap.c            | 4 ++--
 mm/swapfile.c        | 5 -----
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 661046994db4..df6207346078 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -340,7 +340,6 @@ extern void lru_note_cost_page(struct page *);
 extern void lru_cache_add(struct page *);
 extern void lru_add_page_tail(struct page *page, struct page *page_tail,
 			 struct lruvec *lruvec, struct list_head *head);
-extern void activate_page(struct page *);
 extern void mark_page_accessed(struct page *);
 extern void lru_add_drain(void);
 extern void lru_add_drain_cpu(int cpu);
diff --git a/mm/swap.c b/mm/swap.c
index d16d65d9b4e0..25c4043491b3 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -348,7 +348,7 @@ static bool need_activate_page_drain(int cpu)
 	return pagevec_count(&per_cpu(lru_pvecs.activate_page, cpu)) != 0;
 }
 
-void activate_page(struct page *page)
+static void activate_page(struct page *page)
 {
 	page = compound_head(page);
 	if (PageLRU(page) && !PageActive(page) && !PageUnevictable(page)) {
@@ -368,7 +368,7 @@ static inline void activate_page_drain(int cpu)
 {
 }
 
-void activate_page(struct page *page)
+static void activate_page(struct page *page)
 {
 	pg_data_t *pgdat = page_pgdat(page);
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 12f59e641b5e..c287c560f96d 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1925,11 +1925,6 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 		lru_cache_add_inactive_or_unevictable(page, vma);
 	}
 	swap_free(entry);
-	/*
-	 * Move the page to the active list so it is not
-	 * immediately swapped out again after swapon.
-	 */
-	activate_page(page);
 out:
 	pte_unmap_unlock(pte, ptl);
 	if (page != swapcache) {
-- 
2.28.0.220.ged08abb693-goog

