Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69993C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 09:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B2F7207D0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 09:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="O+y7bSyD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgE3J3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 05:29:10 -0400
Received: from m12-17.163.com ([220.181.12.17]:40774 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbgE3J3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 05:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=IEi7UB8bSft1TR6wKS
        R4gEPBVZ8KLcUJhnTRUk9xfjU=; b=O+y7bSyDAt9NOferZch9gXJozk1qqMuJcv
        ESSsQsMyAmhJzBb9bphFWHvQx7P+8mCrXIvl74gHRxEc6/wKHAV0QpwKhgSdTg0+
        xFFAZFC2oJgVFV/UTMo+dHBXZX67zGGF8FWwcO6+LRi5v+OINJZP208dqFG9HaJv
        RNP9UfgNg=
Received: from localhost.localdomain (unknown [183.209.58.25])
        by smtp13 (Coremail) with SMTP id EcCowABnHyFXJ9Je7fAqEw--.25451S2;
        Sat, 30 May 2020 17:28:56 +0800 (CST)
From:   Yue Hu <zbestahu@163.com>
To:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, huyue2@yulong.com
Subject: [PATCH] drivers/block/zram/zram_drv.c: remove ret check for invalid io request
Date:   Sat, 30 May 2020 17:28:53 +0800
Message-Id: <20200530092853.3253-1-zbestahu@163.com>
X-Mailer: git-send-email 2.11.0
X-CM-TRANSID: EcCowABnHyFXJ9Je7fAqEw--.25451S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw17KF47uw1xGrykJrWkWFg_yoWkJrc_ur
        n7X3Z7Xrs7Ar4rG3yUJan5Zr9Fvr1qqF1rWw4fKF95WFWxXw47AryUXrn0yF15XrWUu3Z8
        Cry3CrWfXw15WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8QyCJUUUUU==
X-Originating-IP: [183.209.58.25]
X-CM-SenderInfo: p2eh23xdkxqiywtou0bp/xtbBaxg0EVet0igszgAAs0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

There is no need to goto out to check ret if it's an invalid io request
since we know ret = -EINVAL. Let's return the error directly in that
case.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/block/zram/zram_drv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 1bdb5793842b..bdca06930504 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1639,8 +1639,7 @@ static int zram_rw_page(struct block_device *bdev, sector_t sector,
 
 	if (!valid_io_request(zram, sector, PAGE_SIZE)) {
 		atomic64_inc(&zram->stats.invalid_io);
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	index = sector >> SECTORS_PER_PAGE_SHIFT;
@@ -1651,7 +1650,7 @@ static int zram_rw_page(struct block_device *bdev, sector_t sector,
 	bv.bv_offset = 0;
 
 	ret = zram_bvec_rw(zram, &bv, index, offset, op, NULL);
-out:
+
 	/*
 	 * If I/O fails, just return error(ie, non-zero) without
 	 * calling page_endio.
-- 
2.11.0


