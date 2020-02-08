Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A17C04EB5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 06:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6F720726
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 06:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RzWuq/5G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgBHGm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 01:42:57 -0500
Received: from m12-14.163.com ([220.181.12.14]:34497 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgBHGm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 01:42:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=E3heCWEUQK8P55bOwk
        9XkMm6MTwZ6hOOkgnpU1HElmU=; b=RzWuq/5G+AZ4nYDBpp2HqlwoYvJPerWM35
        18+ByICTQ7alruOWPo8cAhd37qgA/3cEaSDZOItRh0axc4R8d25+tC6GcQ9us5lC
        fYZ/iLY0fpG89MI9G9Jttsz5k5CMVGJ33bVjAUyPx65p5qQT0vwkLB1kuRl6IpUs
        QZEl6Oin0=
Received: from localhost.localdomain (unknown [183.209.151.218])
        by smtp10 (Coremail) with SMTP id DsCowAB3fJxfWD5euXg+Ow--.26387S2;
        Sat, 08 Feb 2020 14:42:41 +0800 (CST)
From:   Yue Hu <zbestahu@163.com>
To:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com
Cc:     linux-kernel@vger.kernel.org, huyue2@yulong.com,
        Yue Hu <zbestahu@163.com>
Subject: [PATCH] drivers/block/zram/zram_drv.c: remove ret check for invalid io request
Date:   Sat,  8 Feb 2020 14:42:34 +0800
Message-Id: <20200208064234.4824-1-zbestahu@163.com>
X-Mailer: git-send-email 2.11.0
X-CM-TRANSID: DsCowAB3fJxfWD5euXg+Ow--.26387S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF43AFWfGF1fKF47Kw45ZFb_yoWDurc_ur
        n7W3Z7Xrs7Ar4rC3yUJan5Zr9FvrnFqF1fWw4ftFZ3WFWxXa13AryUXrZ8AF15XrWUu3Z8
        Cr9xurWrZw1FgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeH5l5UUUUU==
X-Originating-IP: [183.209.151.218]
X-CM-SenderInfo: p2eh23xdkxqiywtou0bp/xtbBZgHDEVaD5QZdaQAAs3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to goto out to check ret if it's an invalid io request
since we know ret = -EINVAL. Let's return the error directly in that
case.

Signed-off-by: Yue Hu <zbestahu@163.com>
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


