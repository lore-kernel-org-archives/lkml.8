Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D398C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA892073D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbgCCQQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 11:16:43 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:37245 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729208AbgCCQQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 11:16:43 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=shile.zhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TrZg1ZS_1583252154;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:shile.zhang@linux.alibaba.com fp:SMTPD_---0TrZg1ZS_1583252154)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 04 Mar 2020 00:16:24 +0800
From:   Shile Zhang <shile.zhang@linux.alibaba.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shile Zhang <shile.zhang@linux.alibaba.com>
Subject: [PATCH v2 1/1] mm: fix interrupt disabled long time inside deferred_init_memmap()
Date:   Wed,  4 Mar 2020 00:15:51 +0800
Message-Id: <20200303161551.132263-2-shile.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.0.rc2
In-Reply-To: <20200303161551.132263-1-shile.zhang@linux.alibaba.com>
References: <20200303161551.132263-1-shile.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When 'CONFIG_DEFERRED_STRUCT_PAGE_INIT' is set, 'pgdatinit' kthread will
initialise the deferred pages with local interrupts disabled. It is
introduced by commit 3a2d7fa8a3d5 ("mm: disable interrupts while
initializing deferred pages").

The local interrupt will be disabled long time inside
deferred_init_memmap(), depends on memory size.
On machine with NCPUS <= 2, the 'pgdatinit' kthread could be pined on
boot CPU, then the tick timer will stuck long time, which caused the
system wall time inaccuracy.

For example, the dmesg shown that:

  [    0.197975] node 0 initialised, 32170688 pages in 1ms

Obviously, 1ms is unreasonable.
Now, fix it by restore in the pending interrupts inside the while loop.
The reasonable demsg shown likes:

[    1.069306] node 0 initialised, 32203456 pages in 894ms

Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
---
 mm/page_alloc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3c4eb750a199..d3f337f2e089 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1809,8 +1809,12 @@ static int __init deferred_init_memmap(void *data)
 	 * that we can avoid introducing any issues with the buddy
 	 * allocator.
 	 */
-	while (spfn < epfn)
+	while (spfn < epfn) {
 		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
+		/* let in any pending interrupts */
+		local_irq_restore(flags);
+		local_irq_save(flags);
+	}
 zone_empty:
 	pgdat_resize_unlock(pgdat, &flags);
 
-- 
2.24.0.rc2

