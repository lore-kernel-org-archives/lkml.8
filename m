Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFA8C352A3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 00:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D459217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 00:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgBNA34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 19:29:56 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:53563 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727594AbgBNA34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 19:29:56 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TpvPKhe_1581640185;
Received: from localhost(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TpvPKhe_1581640185)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 14 Feb 2020 08:29:52 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     willy@infradead.org, mhocko@suse.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: migrate.c: migrate PG_readahead flag
Date:   Fri, 14 Feb 2020 08:29:45 +0800
Message-Id: <1581640185-95731-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently migration code doesn't migrate PG_readahead flag.
Theoretically this would incur slight performance loss as the
application might have to ramp its readahead back up again.  Even though
such problem happens, it might be hidden by something else since
migration is typically triggered by compaction and NUMA balancing, any
of which should be more noticeable.

Migrate the flag after end_page_writeback() since it may clear
PG_reclaim flag, which is the same bit as PG_readahead, for the new
page.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
I didn't experience any real problem, found by visual inspection. And, this was
discussed in thread: https://lore.kernel.org/linux-mm/185ce762-f25d-a013-6daa-8c288f1ff791@linux.alibaba.com/T/#m1977ce1de513401b7d09d6fa14fcffe849580aae

 mm/migrate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index edf42ed..f3c492d 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -647,6 +647,14 @@ void migrate_page_states(struct page *newpage, struct page *page)
 	if (PageWriteback(newpage))
 		end_page_writeback(newpage);
 
+	/*
+	 * PG_readahead share the same bit with PG_reclaim, the above
+	 * end_page_writeback() may clear PG_readahead mistakenly, so set
+	 * the bit after that.
+	 */
+	if (PageReadahead(page))
+		SetPageReadahead(newpage);
+
 	copy_page_owner(page, newpage);
 
 	mem_cgroup_migrate(page, newpage);
-- 
1.8.3.1

