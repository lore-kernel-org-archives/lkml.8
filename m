Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6CCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 520D42075E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgHRLpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 07:45:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9761 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726273AbgHRLpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 07:45:19 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6B6F886E0FB447E9D465;
        Tue, 18 Aug 2020 19:45:15 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Tue, 18 Aug 2020
 19:45:07 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <akpm@linux-foundation.org>, <minchan@kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] mm/madvise: Remove duplicate include
Date:   Tue, 18 Aug 2020 19:44:48 +0800
Message-ID: <20200818114448.45492-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate header which is included twice.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 mm/madvise.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 843f6fad3b89..fda6164db356 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -29,7 +29,6 @@
 #include <linux/swapops.h>
 #include <linux/shmem_fs.h>
 #include <linux/mmu_notifier.h>
-#include <linux/sched/mm.h>
 #include <linux/uio.h>
 
 #include <asm/tlb.h>
-- 
2.17.1


