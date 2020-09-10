Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91803C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 05:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AF482078E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 05:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgIJFSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 01:18:40 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:6503 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725855AbgIJFSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 01:18:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U8TC1ti_1599715103;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U8TC1ti_1599715103)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 10 Sep 2020 13:18:24 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: remove unused marco writeback
Date:   Thu, 10 Sep 2020 13:18:16 +0800
Message-Id: <1599715096-20369-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike others we don't use the marco writeback. so let's remove it to
tame gcc warning:

mm/memory-failure.c:827: warning: macro "writeback" is not used
[-Wunused-macros]

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com> 
Cc: Andrew Morton <akpm@linux-foundation.org> 
Cc: linux-mm@kvack.org 
Cc: linux-kernel@vger.kernel.org 
---
 mm/memory-failure.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index f1aa6433f404..3a97440cdf8c 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -824,7 +824,6 @@ static int me_huge_page(struct page *p, unsigned long pfn)
 #define sc		((1UL << PG_swapcache) | (1UL << PG_swapbacked))
 #define unevict		(1UL << PG_unevictable)
 #define mlock		(1UL << PG_mlocked)
-#define writeback	(1UL << PG_writeback)
 #define lru		(1UL << PG_lru)
 #define head		(1UL << PG_head)
 #define slab		(1UL << PG_slab)
@@ -873,7 +872,6 @@ static int me_huge_page(struct page *p, unsigned long pfn)
 #undef sc
 #undef unevict
 #undef mlock
-#undef writeback
 #undef lru
 #undef head
 #undef slab
-- 
1.8.3.1

