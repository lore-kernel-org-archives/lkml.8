Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF08DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AF6721744
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgHGJNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:13:22 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:39499 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726721AbgHGJNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 05:13:21 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U5.DnVI_1596791598;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U5.DnVI_1596791598)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 07 Aug 2020 17:13:18 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH 05/10] mm/hugetlb: remove the redundant check on non_swap_entry()
Date:   Fri,  7 Aug 2020 17:12:46 +0800
Message-Id: <20200807091251.12129-6-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
References: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Migration and hwpoison entry is a subset of non_swap_entry().

Remove the redundant check on non_swap_entry().

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 mm/hugetlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d775e514eb2e..f5f04e89000d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3778,7 +3778,7 @@ bool is_hugetlb_entry_migration(pte_t pte)
 	if (huge_pte_none(pte) || pte_present(pte))
 		return false;
 	swp = pte_to_swp_entry(pte);
-	if (non_swap_entry(swp) && is_migration_entry(swp))
+	if (is_migration_entry(swp))
 		return true;
 	else
 		return false;
@@ -3791,7 +3791,7 @@ static int is_hugetlb_entry_hwpoisoned(pte_t pte)
 	if (huge_pte_none(pte) || pte_present(pte))
 		return 0;
 	swp = pte_to_swp_entry(pte);
-	if (non_swap_entry(swp) && is_hwpoison_entry(swp))
+	if (is_hwpoison_entry(swp))
 		return 1;
 	else
 		return 0;
-- 
2.20.1 (Apple Git-117)

