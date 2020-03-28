Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D5BC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 13:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A70206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 13:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgC1NCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 09:02:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56746 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726225AbgC1NCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 09:02:15 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CC0D1DB02DE44016DCAE;
        Sat, 28 Mar 2020 21:01:26 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Sat, 28 Mar 2020 21:01:20 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <nixiaoming@huawei.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wangle6@huawei.com>,
        <zhangweimin12@huawei.com>, <yebin10@huawei.com>,
        <houtao1@huawei.com>
Subject: [PATCH] mtd:clear cache_state to avoid writing to bad clocks repeatedly
Date:   Sat, 28 Mar 2020 21:01:17 +0800
Message-ID: <1585400477-65705-1-git-send-email-nixiaoming@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function call process is as follows:
	mtd_blktrans_work()
	  while (1)
	    do_blktrans_request()
	      mtdblock_writesect()
	        do_cached_write()
	          write_cached_data() /*if cache_state is STATE_DIRTY*/
	            erase_write()

write_cached_data() returns failure without modifying cache_state
and cache_offset. so when do_cached_write() is called again,
write_cached_data() will be called again to perform erase_write()
on the same cache_offset.

but if this cache_offset points to a bad block, erase_write() will
always return -EIO. Writing to this mtdblk is equivalent to losing
the current data, and repeatedly writing to the bad block.

Repeatedly writing a bad block has no real benefits,
but brings some negative effects:
1 Lost subsequent data
2 Loss of flash device life
3 erase_write() bad blocks are very time-consuming. for example:
	the function do_erase_oneblock() in chips/cfi_cmdset_0020.c or
	chips/cfi_cmdset_0002.c may take more than 20 seconds to return

Therefore, when erase_write() returns -EIO in write_cached_data(),
clear cache_state to avoid writing to bad clocks repeatedly.

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
---
 drivers/mtd/mtdblock.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/mtdblock.c b/drivers/mtd/mtdblock.c
index 078e0f6..98c25d6 100644
--- a/drivers/mtd/mtdblock.c
+++ b/drivers/mtd/mtdblock.c
@@ -89,8 +89,6 @@ static int write_cached_data (struct mtdblk_dev *mtdblk)
 
 	ret = erase_write (mtd, mtdblk->cache_offset,
 			   mtdblk->cache_size, mtdblk->cache_data);
-	if (ret)
-		return ret;
 
 	/*
 	 * Here we could arguably set the cache state to STATE_CLEAN.
@@ -98,9 +96,14 @@ static int write_cached_data (struct mtdblk_dev *mtdblk)
 	 * be notified if this content is altered on the flash by other
 	 * means.  Let's declare it empty and leave buffering tasks to
 	 * the buffer cache instead.
+	 *
+	 * if this cache_offset points to a bad block
+	 * data cannot be written to the device.
+	 * clear cache_state to avoid writing to bad clocks repeatedly
 	 */
-	mtdblk->cache_state = STATE_EMPTY;
-	return 0;
+	if (ret == 0 || ret == -EIO)
+		mtdblk->cache_state = STATE_EMPTY;
+	return ret;
 }
 
 
-- 
1.8.5.6

