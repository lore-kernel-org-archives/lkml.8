Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E96C38A2A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 02:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3B3821841
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 02:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbgEIC6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 22:58:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55166 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728353AbgEIC6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 22:58:39 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A13122A3C9F461F677E0;
        Sat,  9 May 2020 10:58:34 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Sat, 9 May 2020 10:58:28 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] mm/hmm/test: fix missing unlock on error in dmirror_migrate_finalize_and_map()
Date:   Sat, 9 May 2020 03:02:25 +0000
Message-ID: <20200509030225.14592-1-weiyongjun1@huawei.com>
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

Add the missing unlock before return from function
dmirror_migrate_finalize_and_map() in the error
handling case.

Fixes: 5d5e54be8a1e ("mm/hmm/test: add selftest driver for HMM")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 lib/test_hmm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 00bca6116f93..30462193c4ff 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -647,8 +647,10 @@ static int dmirror_migrate_finalize_and_map(struct migrate_vma *args,
 		if (*dst & MIGRATE_PFN_WRITE)
 			entry = xa_tag_pointer(entry, DPT_XA_TAG_WRITE);
 		entry = xa_store(&dmirror->pt, pfn, entry, GFP_ATOMIC);
-		if (xa_is_err(entry))
+		if (xa_is_err(entry)) {
+			mutex_unlock(&dmirror->mutex);
 			return xa_err(entry);
+		}
 	}
 
 	mutex_unlock(&dmirror->mutex);



