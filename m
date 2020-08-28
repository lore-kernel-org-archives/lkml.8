Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC89C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 03:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D94C720936
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 03:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgH1DdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 23:33:10 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:56684 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728114AbgH1Dcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 23:32:55 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U741Gbc_1598585571;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U741Gbc_1598585571)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 28 Aug 2020 11:32:52 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, bhe@redhat.com,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [Patch v2 3/7] mm/hugetlb: use list_splice to merge two list at once
Date:   Fri, 28 Aug 2020 11:32:38 +0800
Message-Id: <20200828033242.8787-4-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200828033242.8787-1-richard.weiyang@linux.alibaba.com>
References: <20200828033242.8787-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of add allocated file_region one by one to region_cache, we
could use list_splice to merge two list at once.

Also we know the number of entries in the list, increase the number
directly.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f325839be617..cbe67428bf99 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -441,11 +441,8 @@ static int allocate_file_region_entries(struct resv_map *resv,
 
 		spin_lock(&resv->lock);
 
-		list_for_each_entry_safe(rg, trg, &allocated_regions, link) {
-			list_del(&rg->link);
-			list_add(&rg->link, &resv->region_cache);
-			resv->region_cache_count++;
-		}
+		list_splice(&allocated_regions, &resv->region_cache);
+		resv->region_cache_count += to_allocate;
 	}
 
 	return 0;
-- 
2.20.1 (Apple Git-117)

