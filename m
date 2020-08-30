Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D429FC433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 21:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB7772083E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 21:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c4OqQCxX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgH3VI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 17:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgH3VIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 17:08:24 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF13C061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 14:08:24 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id j7so5477981oij.9
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 14:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=SQ10D8PXryeEKHHcl5IvJgd6P48aMcyJPD1+SoD+oOw=;
        b=c4OqQCxXIwZCv3JjpmkYk1C/CeDsSc970MD8kj38easVa+rgeXjtnreeKAvbX5dnN9
         d2uuNuM4vPcJmTcVou5fUb4QsSDGIo0I3jzh7ZNG+qN6GK/hSQ+UkqXT4pYaGthcv1VY
         89WTQRrQljR99h7ywkXXy3vo2t9LlTpEqqRthmrCKuytS4dvmws+u25TJBxt6AwCfwvX
         bT4yk0N1mRAjDTukMmYU2jHo7PXwaeoqAUCooMsaalgiXLhzYKEMF9PsTlbNZOGJBrAa
         PFUs3sGOo/dZLqlr4+danZhsgj+kTFIxVg381SJZ22wuz518PSM0dkFR3E6QF7kOlmHp
         TUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=SQ10D8PXryeEKHHcl5IvJgd6P48aMcyJPD1+SoD+oOw=;
        b=Fl3DM9iNplOf90kqK80Ah0485nHFWwd0KOZKCl0MoPuJ0t7faB8/IL6GiVgv4vZQia
         S/yN0sC6Iw4EEnt5ji4DgQRhb5dpC/2WM/SAkarzovskaJfw8NdV0R+6UpiBrQCEUGGX
         d1zFOnatK5NZUPgdREd0tbp4p4pnKiSa3jYKHVQt5gXtzLInc+lDc7siVuUilk419v0G
         WOzuuSfzTSvMdd/3Bmoy0lx0s7twhZbs7GOjcGmRpBWlpdIt1WECj/Ap9BYpWKZ/COhp
         C8i2Cly9KHyw6o32husobVdNoCtP6GCjMBPP8+4npmgeyvxoVxw5OUt9UM4Z+MeglZiX
         zJpQ==
X-Gm-Message-State: AOAM530h1C56TBCS1jNKUGoUyfRFL6eYqbGPgNP5aqgcxetk/ft3jDCb
        EZK8GjfkB7hmhqBbZquBQDJqow==
X-Google-Smtp-Source: ABdhPJxF1SCIvzAbelWpBIoB9i54xpvq6aZj7/FIsSEv2EFOm/IpDLQv50VMevxq6JU/ORrsgv5lJQ==
X-Received: by 2002:aca:fc85:: with SMTP id a127mr1801672oii.148.1598821699723;
        Sun, 30 Aug 2020 14:08:19 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 63sm1408348ooj.32.2020.08.30.14.08.17
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 30 Aug 2020 14:08:18 -0700 (PDT)
Date:   Sun, 30 Aug 2020 14:08:16 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Kuo-Hsin Yang <vovoy@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 4/5] mm: fix check_move_unevictable_pages() on THP
In-Reply-To: <alpine.LSU.2.11.2008301343270.5954@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2008301405000.5954@eggly.anvils>
References: <alpine.LSU.2.11.2008301343270.5954@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check_move_unevictable_pages() is used in making unevictable shmem pages
evictable: by shmem_unlock_mapping(), drm_gem_check_release_pagevec() and
i915/gem check_release_pagevec().  Those may pass down subpages of a huge
page, when /sys/kernel/mm/transparent_hugepage/shmem_enabled is "force".

That does not crash or warn at present, but the accounting of vmstats
unevictable_pgs_scanned and unevictable_pgs_rescued is inconsistent:
scanned being incremented on each subpage, rescued only on the head
(since tails already appear evictable once the head has been updated).

5.8 commit 5d91f31faf8e ("mm: swap: fix vmstats for huge page") has
established that vm_events in general (and unevictable_pgs_rescued in
particular) should count every subpage: so follow that precedent here.

Do this in such a way that if mem_cgroup_page_lruvec() is made stricter
(to check page->mem_cgroup is always set), no problem: skip the tails
before calling it, and add thp_nr_pages() to vmstats on the head.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
Nothing here worth going to stable, since it's just a testing config
that is fixed, whose event numbers are not very important; but this
will be needed before Alex Shi's warning, and might as well go in now.

The callers of check_move_unevictable_pages() could be optimized,
to skip over tails: but Matthew Wilcox has other changes in flight
there, so let's skip the optimization for now.

 mm/vmscan.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- 5.9-rc2/mm/vmscan.c	2020-08-16 17:32:50.721507348 -0700
+++ linux/mm/vmscan.c	2020-08-28 17:47:10.595580876 -0700
@@ -4260,8 +4260,14 @@ void check_move_unevictable_pages(struct
 	for (i = 0; i < pvec->nr; i++) {
 		struct page *page = pvec->pages[i];
 		struct pglist_data *pagepgdat = page_pgdat(page);
+		int nr_pages;
+
+		if (PageTransTail(page))
+			continue;
+
+		nr_pages = thp_nr_pages(page);
+		pgscanned += nr_pages;
 
-		pgscanned++;
 		if (pagepgdat != pgdat) {
 			if (pgdat)
 				spin_unlock_irq(&pgdat->lru_lock);
@@ -4280,7 +4286,7 @@ void check_move_unevictable_pages(struct
 			ClearPageUnevictable(page);
 			del_page_from_lru_list(page, lruvec, LRU_UNEVICTABLE);
 			add_page_to_lru_list(page, lruvec, lru);
-			pgrescued++;
+			pgrescued += nr_pages;
 		}
 	}
 
