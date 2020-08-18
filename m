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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6292CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D47B206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bQ/GzzWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgHRSrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 14:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgHRSrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 14:47:15 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7DFC061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 11:47:15 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id q7so15055470qtd.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 11:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gehHRqDo170D8ggpcqt5L8gyM4hpiP3lcUb1NEGWSW0=;
        b=bQ/GzzWCVMuhyt2laZU2VxcoEcEJ0awKHw177BB3iK9JBuhbMoqOMb55rEFzzispi4
         ywbPZWNcaLgifIEPXSTOz563MWK+2uyPYoJ0xUHlueLw8MgtrLdr8wbNjMFUN+Or3S0P
         iFQIqxP58WduRybClJ8bhoc927M7lCiLlkV056WLQRc3mFjEth5caAjZwDkc0tSlDRK7
         PR4W0wMOT8pAoPiyhV5ylKxZPeOSn9Qj6yms7eHC9/mfODiKNLp2EDPyQcC/1OlsvYma
         q9N9WYkzvVBiWbNQ07qYsS7ND29LTFcqHnC9eCJY4qJyPTjUgMP56T2G8gvL5L+zvWDx
         lx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gehHRqDo170D8ggpcqt5L8gyM4hpiP3lcUb1NEGWSW0=;
        b=Xv6WCYgR3Ucae1yFQbYBY2/rOhQmourMSQAretUZXbu30VBHk598qleFjG/5d4sqCi
         ZaS4lBRo3eBqYNnlFtMiCzzrPnzzIMAnxgkHFqCWj8vPt5H3S+tNKhmjYr1nId5E/Yb0
         csPjZZCWzmzPAoXdecJjyKODmwTII5fuTpXSqfgmtWZKkmOVtHL7ISk1SJdcOKfXtmGG
         8JZFcXTkvrFMOG4Wbf+L07dELnAqg2LfnnDkDJLy2/efDYrlaBf3toKWgVMuLxJ4Ruqh
         d820eUZpfRnRToFlaGAJ8X5XxGnfCSd2HHTR6YMRG0MEFMww3qYhNxZR2htVvOEVTFZt
         ojXg==
X-Gm-Message-State: AOAM532qrF0xrfsZLJ+2FeYuEusj0LNhszFfpjms9eY8zpmSEjbypaMR
        kxbK7ai3sDhQcr84Fv2bZgdCyYYMRYg=
X-Google-Smtp-Source: ABdhPJyX7PxrdwZp8JKMZ0YQglNCQFusxUHnYaz351dVMOTyN3ebFvNOcxIaiSUrRohWV46bcjlxOvwE/VU=
X-Received: by 2002:ad4:54c6:: with SMTP id j6mr20694395qvx.126.1597776433446;
 Tue, 18 Aug 2020 11:47:13 -0700 (PDT)
Date:   Tue, 18 Aug 2020 12:47:03 -0600
In-Reply-To: <20200818184704.3625199-1-yuzhao@google.com>
Message-Id: <20200818184704.3625199-2-yuzhao@google.com>
Mime-Version: 1.0
References: <20200818184704.3625199-1-yuzhao@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH v2 2/3] mm: remove superfluous __ClearPageActive()
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

To activate a page, mark_page_accessed() always holds a reference
on it. It either gets a new reference when adding a page to
lru_pvecs.activate_page or reuses an existing one it previously
got when it added a page to lru_pvecs.lru_add. So it doesn't call
SetPageActive() on a page that doesn't have any reference left.
Therefore, the race is impossible these days (I didn't brother to
dig into its history).

For other paths, namely reclaim and migration, a reference count is
always held while calling SetPageActive() on a page.

SetPageSlabPfmemalloc() also uses SetPageActive(), but it's irrelevant
to LRU pages.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/memremap.c | 2 --
 mm/swap.c     | 2 --
 2 files changed, 4 deletions(-)

diff --git a/mm/memremap.c b/mm/memremap.c
index 03e38b7a38f1..3a06eb91cb59 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -451,8 +451,6 @@ void free_devmap_managed_page(struct page *page)
 		return;
 	}
 
-	/* Clear Active bit in case of parallel mark_page_accessed */
-	__ClearPageActive(page);
 	__ClearPageWaiters(page);
 
 	mem_cgroup_uncharge(page);
diff --git a/mm/swap.c b/mm/swap.c
index 25c4043491b3..999a84dbe12c 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -900,8 +900,6 @@ void release_pages(struct page **pages, int nr)
 			del_page_from_lru_list(page, lruvec, page_off_lru(page));
 		}
 
-		/* Clear Active bit in case of parallel mark_page_accessed */
-		__ClearPageActive(page);
 		__ClearPageWaiters(page);
 
 		list_add(&page->lru, &pages_to_free);
-- 
2.28.0.220.ged08abb693-goog

