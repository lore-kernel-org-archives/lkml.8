Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F6FC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB542467F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdPILWaO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgB0INR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 03:13:17 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46045 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbgB0INR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 03:13:17 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so1200887pfg.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 00:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qD302y73miyDoytN6KevCtwc5RG9cZdqszRF+lAFyHw=;
        b=QdPILWaOA+hmt1MjuVaoUD1XKSSMJXw1R4MxC6kxphOiRXp2I6XUN/kFSwoKE3nsFH
         +/ir4jkW02kXAK7hI9un1dv5LnKxYrd4ff4Tsp3EeUrcJx+iIt19qTwEyxu7wF8j54Eq
         0GtB87eWAuvmcSoOP17FOF7fyfe1K8+NKbhnwQWnqUhIEFZg6+S09oCKzkNOib64QP/d
         T+CeUwIwkjTvR/A6EH7jyIVRpELTlZXD+A4sLQaD+oKCCKCbC74jWLxo0rB/KK5k2xR/
         e+2y60q6dZ0tOC2GywO9xmFJijHX0LgFhbNQhExFB9nJUfGa68cEF25Uckk13Hg4wOpJ
         MtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qD302y73miyDoytN6KevCtwc5RG9cZdqszRF+lAFyHw=;
        b=BP/MGzACiOLGnnkqihth492+Qn48ITAWszoUZ4fFaLURj/IQmC069a2g4QtNMSQLTF
         Or4rUhKd79Kdj33BlAwp2wFL6nUwj9MHqdKU7pX0N97yEyH7eRA+DrgUl1WgcgNh4YYr
         rNJ31I8uIp50rEYHnhxyyMDM9UXfEK20Z5OZHoFeZFz91/T+Fx3USKEhMhDSrHHYM/9U
         7PZOs6jT2a4/2ot6FM7w0L04QOi1OBGgGVz0R0kP1shfHuDkC+ivAs56+aU3PNJdPVPB
         Wc1rxoo7A+wPjOb2mKuZAvUmxMQb7IdZFvkLsEeGKVJLpTwfZyuZuPx2i7i4Mu3QBVt8
         BNnQ==
X-Gm-Message-State: APjAAAWmik/qBplfA3Bwfg1ymZn/P5eQKOjFbkey8jm6ryL+7IG8vIzv
        UYO+z5IKBVTNANKQiXOSUPM=
X-Google-Smtp-Source: APXvYqxvQOLTvaW7Wga8Xm4wMANRBY4lhqIyZDCSbxZBGXs6evaDcQMv6E1BFgQ/rQqy2JUG/t69qQ==
X-Received: by 2002:a62:16d0:: with SMTP id 199mr2888136pfw.96.1582791196319;
        Thu, 27 Feb 2020 00:13:16 -0800 (PST)
Received: from huyue2.ccdomain.com ([103.29.143.67])
        by smtp.gmail.com with ESMTPSA id h132sm1379824pfe.118.2020.02.27.00.13.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Feb 2020 00:13:15 -0800 (PST)
From:   Yue Hu <zbestahu@gmail.com>
To:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, huyue2@yulong.com, zbestahu@163.com
Subject: [PATCH] drivers/block/zram/zram_drv.c: avoid needless checks in backing_dev_store() failure path
Date:   Thu, 27 Feb 2020 16:12:19 +0800
Message-Id: <20200227081219.13144-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

There are null pointer checks in out block if backing_dev_store() fails.
That is needless, we can avoid them by setting different jumping label.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/block/zram/zram_drv.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 61b10ab..a896f5c 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -465,7 +465,7 @@ static ssize_t backing_dev_store(struct device *dev,
 	if (init_done(zram)) {
 		pr_info("Can't setup backing device for initialized device\n");
 		err = -EBUSY;
-		goto out;
+		goto out_unlock;
 	}
 
 	strlcpy(file_name, buf, PATH_MAX);
@@ -478,7 +478,7 @@ static ssize_t backing_dev_store(struct device *dev,
 	if (IS_ERR(backing_dev)) {
 		err = PTR_ERR(backing_dev);
 		backing_dev = NULL;
-		goto out;
+		goto out_unlock;
 	}
 
 	mapping = backing_dev->f_mapping;
@@ -487,14 +487,14 @@ static ssize_t backing_dev_store(struct device *dev,
 	/* Support only block device in this moment */
 	if (!S_ISBLK(inode->i_mode)) {
 		err = -ENOTBLK;
-		goto out;
+		goto out_fclose;
 	}
 
 	bdev = bdgrab(I_BDEV(inode));
 	err = blkdev_get(bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL, zram);
 	if (err < 0) {
 		bdev = NULL;
-		goto out;
+		goto out_fclose;
 	}
 
 	nr_pages = i_size_read(inode) >> PAGE_SHIFT;
@@ -502,13 +502,13 @@ static ssize_t backing_dev_store(struct device *dev,
 	bitmap = kvzalloc(bitmap_sz, GFP_KERNEL);
 	if (!bitmap) {
 		err = -ENOMEM;
-		goto out;
+		goto out_blkdev_put;
 	}
 
 	old_block_size = block_size(bdev);
 	err = set_blocksize(bdev, PAGE_SIZE);
 	if (err)
-		goto out;
+		goto out_free_bitmap;
 
 	reset_bdev(zram);
 
@@ -535,16 +535,14 @@ static ssize_t backing_dev_store(struct device *dev,
 	kfree(file_name);
 
 	return len;
-out:
-	if (bitmap)
-		kvfree(bitmap);
-
-	if (bdev)
-		blkdev_put(bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
-
-	if (backing_dev)
-		filp_close(backing_dev, NULL);
 
+out_free_bitmap:
+	kvfree(bitmap);
+out_blkdev_put:
+	blkdev_put(bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
+out_fclose:
+	filp_close(backing_dev, NULL);
+out_unlock:
 	up_write(&zram->init_lock);
 
 	kfree(file_name);
-- 
1.9.1

