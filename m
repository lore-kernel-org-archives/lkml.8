Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8628C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 09:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6889206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 09:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgEEJ4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 05:56:49 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3795 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725766AbgEEJ4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 05:56:49 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2484EF110FAAF2FDBF65;
        Tue,  5 May 2020 17:56:46 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Tue, 5 May 2020 17:56:39 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] mm: remove duplicated include from madvise.c
Date:   Tue, 5 May 2020 10:00:49 +0000
Message-ID: <20200505100049.191351-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicated include.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 mm/madvise.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 8fec261457a6..f8be54dd92d3 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -29,7 +29,6 @@
 #include <linux/swapops.h>
 #include <linux/shmem_fs.h>
 #include <linux/mmu_notifier.h>
-#include <linux/sched/mm.h>
 #include <linux/uio.h>
 
 #include <asm/tlb.h>





