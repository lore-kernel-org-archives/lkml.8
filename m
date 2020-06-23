Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882DBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66E1920771
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732636AbgFWMmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 08:42:16 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:47588 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732544AbgFWMmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 08:42:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U0VwpCf_1592916131;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U0VwpCf_1592916131)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Jun 2020 20:42:11 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     mgorman@suse.de, akpm@linux-foundation.org,
        richard.weiyang@linux.alibaba.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] mm/page_alloc.c: extract the common part in pfn_to_bitidx()
Date:   Tue, 23 Jun 2020 20:41:59 +0800
Message-Id: <20200623124201.8199-2-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200623124201.8199-1-richard.weiyang@linux.alibaba.com>
References: <20200623124201.8199-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value calculation is the same both for SPARSEMEM or not.

Just took it out.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 mm/page_alloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 727751219003..efc2c355ac52 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -459,11 +459,10 @@ static inline int pfn_to_bitidx(struct page *page, unsigned long pfn)
 {
 #ifdef CONFIG_SPARSEMEM
 	pfn &= (PAGES_PER_SECTION-1);
-	return (pfn >> pageblock_order) * NR_PAGEBLOCK_BITS;
 #else
 	pfn = pfn - round_down(page_zone(page)->zone_start_pfn, pageblock_nr_pages);
-	return (pfn >> pageblock_order) * NR_PAGEBLOCK_BITS;
 #endif /* CONFIG_SPARSEMEM */
+	return (pfn >> pageblock_order) * NR_PAGEBLOCK_BITS;
 }
 
 /**
-- 
2.20.1 (Apple Git-117)

