Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8CCC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 03:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 012D120936
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 03:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgH1DdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 23:33:14 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:51442 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728115AbgH1Dcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 23:32:55 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U736V1Q_1598585571;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U736V1Q_1598585571)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 28 Aug 2020 11:32:51 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, bhe@redhat.com,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [Patch v2 2/7] mm/hugetlb: remove VM_BUG_ON(!nrg) in get_file_region_entry_from_cache()
Date:   Fri, 28 Aug 2020 11:32:37 +0800
Message-Id: <20200828033242.8787-3-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200828033242.8787-1-richard.weiyang@linux.alibaba.com>
References: <20200828033242.8787-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are sure to get a valid file_region, otherwise the
VM_BUG_ON(resv->region_cache_count <= 0) at the very beginning would be
triggered.

Let's remove the redundant one.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 mm/hugetlb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 62ec74f6d03f..f325839be617 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -238,7 +238,6 @@ get_file_region_entry_from_cache(struct resv_map *resv, long from, long to)
 
 	resv->region_cache_count--;
 	nrg = list_first_entry(&resv->region_cache, struct file_region, link);
-	VM_BUG_ON(!nrg);
 	list_del(&nrg->link);
 
 	nrg->from = from;
-- 
2.20.1 (Apple Git-117)

