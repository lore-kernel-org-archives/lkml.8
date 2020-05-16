Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B03DC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 10:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C9A7207C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 10:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgEPKKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 06:10:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4853 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725792AbgEPKKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 06:10:45 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 65FC387165E396FE2340;
        Sat, 16 May 2020 18:10:44 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.237) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Sat, 16 May 2020
 18:10:38 +0800
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH] uprobe: switch to bitmap_zalloc() in __create_xol_area()
Message-ID: <41b31e6d-9af3-0c5e-0334-12508b869f13@huawei.com>
Date:   Sat, 16 May 2020 18:10:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.237]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to bitmap_zalloc() to show clearly in __create_xol_area().

No functional change.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 kernel/events/uprobes.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index ece7e13f6e4a..1d3dde9101b0 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1490,8 +1490,7 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 	if (unlikely(!area))
 		goto out;

-	area->bitmap = kcalloc(BITS_TO_LONGS(UINSNS_PER_PAGE), sizeof(long),
-			       GFP_KERNEL);
+	area->bitmap = bitmap_zalloc(UINSNS_PER_PAGE, GFP_KERNEL);
 	if (!area->bitmap)
 		goto free_area;

@@ -1515,7 +1514,7 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)

 	__free_page(area->pages[0]);
  free_bitmap:
-	kfree(area->bitmap);
+	bitmap_free(area->bitmap);
  free_area:
 	kfree(area);
  out:
@@ -1556,7 +1555,7 @@ void uprobe_clear_state(struct mm_struct *mm)
 		return;

 	put_page(area->pages[0]);
-	kfree(area->bitmap);
+	bitmap_free(area->bitmap);
 	kfree(area);
 }

-- 
1.8.3.1

