Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764BBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4588F21744
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgHGJNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:13:19 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:57180 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726721AbgHGJNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 05:13:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U5.0C2._1596791595;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U5.0C2._1596791595)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 07 Aug 2020 17:13:16 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH 01/10] mm/hugetlb: not necessary to coalesce regions recursively
Date:   Fri,  7 Aug 2020 17:12:42 +0800
Message-Id: <20200807091251.12129-2-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
References: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per my understanding, we keep the regions ordered and would always
coalesce regions properly. So the task to keep this property is just
to coalesce its neighbour.

Let's simplify this.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 mm/hugetlb.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 590111ea6975..62ec74f6d03f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -307,8 +307,7 @@ static void coalesce_file_region(struct resv_map *resv, struct file_region *rg)
 		list_del(&rg->link);
 		kfree(rg);
 
-		coalesce_file_region(resv, prg);
-		return;
+		rg = prg;
 	}
 
 	nrg = list_next_entry(rg, link);
@@ -318,9 +317,6 @@ static void coalesce_file_region(struct resv_map *resv, struct file_region *rg)
 
 		list_del(&rg->link);
 		kfree(rg);
-
-		coalesce_file_region(resv, nrg);
-		return;
 	}
 }
 
-- 
2.20.1 (Apple Git-117)

