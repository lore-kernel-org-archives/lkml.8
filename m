Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37239C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FA0A20738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405610AbgFXRnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:43:45 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:40125 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405567AbgFXRnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:43:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U0cU66h_1593020612;
Received: from localhost(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0U0cU66h_1593020612)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 25 Jun 2020 01:43:41 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     hannes@cmpxchg.org, riel@surriel.com, shakeelb@google.com,
        gavin.dg@linux.alibaba.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: filemap: clear idle flag for writes
Date:   Thu, 25 Jun 2020 01:43:32 +0800
Message-Id: <1593020612-13051-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit bbddabe2e436aa7869b3ac5248df5c14ddde0cbf ("mm: filemap:
only do access activations on reads"), mark_page_accessed() is called
for reads only.  But the idle flag is cleared by mark_page_accessed() so
the idle flag won't get cleared if the page is write accessed only.

Basically idle page tracking is used to estimate workingset size of
workload, noticeable size of workingset might be missed if the idle flag
is not maintained correctly.

It seems good enough to just clear idle flag for write operations.

Fixes: bbddabe2e436 ("mm: filemap: only do access activations on reads")
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Shakeel Butt <shakeelb@google.com>
Reported-by: Gang Deng <gavin.dg@linux.alibaba.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/filemap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index f0ae9a6..0589aef 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -41,6 +41,7 @@
 #include <linux/delayacct.h>
 #include <linux/psi.h>
 #include <linux/ramfs.h>
+#include <linux/page_idle.h>
 #include "internal.h"
 
 #define CREATE_TRACE_POINTS
@@ -1630,6 +1631,11 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 
 	if (fgp_flags & FGP_ACCESSED)
 		mark_page_accessed(page);
+	else if (fgp_flags & FGP_WRITE) {
+		/* Clear idle flag for buffer write */
+		if (page_is_idle(page))
+			clear_page_idle(page);
+	}
 
 no_page:
 	if (!page && (fgp_flags & FGP_CREAT)) {
-- 
1.8.3.1

