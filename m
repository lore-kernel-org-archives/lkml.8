Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB9EC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C89215A4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgCCI5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 03:57:18 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:40528 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725818AbgCCI5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 03:57:18 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BDEFBDE0C075254D2FC2;
        Tue,  3 Mar 2020 16:57:15 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Tue, 3 Mar 2020 16:57:09 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: compress: fix to call missing destroy_compress_ctx()
Date:   Tue, 3 Mar 2020 16:57:06 +0800
Message-ID: <20200303085707.45104-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise, it will cause memory leak.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index bd3ea01db448..b373102ed4af 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -398,6 +398,8 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
 		cc->cpages[i] = NULL;
 	}
 
+	cops->destroy_compress_ctx(cc);
+
 	cc->nr_cpages = nr_cpages;
 
 	trace_f2fs_compress_pages_end(cc->inode, cc->cluster_idx,
-- 
2.18.0.rc1

