Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2317AC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3A8B20775
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GCewutXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgGGOsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:48:52 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:14570 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgGGOsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594133332; x=1625669332;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=3cn2fFarr9khrJLb1VKOUd3GG4bZbVaq3DfkaSlwmdw=;
  b=GCewutXoKiR4F/r7TbAcVB6A5LSxu6hYuF2eMegjnc7jcEcBRG5zGklu
   kcqd0XQMp/f4O+MYjXCNquPS0S2MWEU8m2DdLqaNB+wFDe0mTiV6cUA9m
   JhL23JcQQof7khVlJ25F03jHIUg6xN5UTGfqoYwHFlU1fGrzHYkNfPKMm
   Y=;
IronPort-SDR: Sxvg+RtMv0jpRvxACUOU6MEBwmFu+8toIb29UzNpVQeVvSzZZzxcIehKDCDSbdW0CHuAs0dDIC
 ywzlBB6RzJdA==
X-IronPort-AV: E=Sophos;i="5.75,324,1589241600"; 
   d="scan'208";a="40470231"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-53356bf6.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 07 Jul 2020 14:48:44 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-53356bf6.us-west-2.amazon.com (Postfix) with ESMTPS id 5586BA0628;
        Tue,  7 Jul 2020 14:48:41 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 7 Jul 2020 14:48:40 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.214) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 7 Jul 2020 14:48:24 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <david@redhat.com>,
        <dwmw@amazon.com>, <foersleo@amazon.de>, <irogers@google.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <rppt@kernel.org>, <sblbir@amazon.com>,
        <shakeelb@google.com>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <snu@amazon.de>, <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC v5 06/11] mm/rmap: Export essential functions for rmap_run
Date:   Tue, 7 Jul 2020 16:45:35 +0200
Message-ID: <20200707144540.21216-7-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200707144540.21216-1-sjpark@amazon.com>
References: <20200707144540.21216-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.214]
X-ClientProxiedBy: EX13D35UWC001.ant.amazon.com (10.43.162.197) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit exports the three essential functions for ramp walk,
'page_lock_anon_vma_read()', 'rmap_walk()', and 'page_rmapping()', to
GPL modules.  Those will be used by DAMON for the physical memory
address based access monitoring in the following commit.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/rmap.c | 2 ++
 mm/util.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/mm/rmap.c b/mm/rmap.c
index f79a206b271a..20ac37b27a7d 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -579,6 +579,7 @@ struct anon_vma *page_lock_anon_vma_read(struct page *page)
 	rcu_read_unlock();
 	return anon_vma;
 }
+EXPORT_SYMBOL_GPL(page_lock_anon_vma_read);
 
 void page_unlock_anon_vma_read(struct anon_vma *anon_vma)
 {
@@ -1934,6 +1935,7 @@ void rmap_walk(struct page *page, struct rmap_walk_control *rwc)
 	else
 		rmap_walk_file(page, rwc, false);
 }
+EXPORT_SYMBOL_GPL(rmap_walk);
 
 /* Like rmap_walk, but caller holds relevant rmap lock */
 void rmap_walk_locked(struct page *page, struct rmap_walk_control *rwc)
diff --git a/mm/util.c b/mm/util.c
index 988d11e6c17c..1df32546fe28 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -620,6 +620,7 @@ void *page_rmapping(struct page *page)
 	page = compound_head(page);
 	return __page_rmapping(page);
 }
+EXPORT_SYMBOL_GPL(page_rmapping);
 
 /*
  * Return true if this page is mapped into pagetables.
-- 
2.17.1

