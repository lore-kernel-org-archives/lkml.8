Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF3FC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CAB0208FE
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="kJ8IquZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgD2OEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727999AbgD2ODu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:03:50 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008A5C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 07:03:49 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e26so2160155wmk.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 07:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PSfbPTORILGMmy9wi1uMwPHU+QF0h0YWCES/qqpWmno=;
        b=kJ8IquZ7YxxuHbIawgD2euMh4fvtUg6vQsnmwKnHVh9yxtm2qDtfNcrReo3r3/LrvC
         x2Wpp7ROj65v20V04lnpdZh55JeEbrDSWf16GI5oKQuF+MDM0SbnNbNkUzPjEKchLXp1
         WlXxgr5/3+Wb7Rmacdj/hnzKyadnnCWfx0Ei+KYtpWJo1tlqXfHL2pnULz63u4nthsU3
         QQncpO1+l43dgX/77Stvn8wBl7EWY14G+mCvvRcJTDIMcp9PDEe0PWcZkkjvIszsb9fv
         uEKMX+CMkePL/9aT/ZL30rLsfaoGN2M4mG8qZ7y4uVFoDOsOoPhPa80iDpF5Dgn4QYwN
         4cpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PSfbPTORILGMmy9wi1uMwPHU+QF0h0YWCES/qqpWmno=;
        b=eceW45eGa82uFS36FEFHEsWR57lEKWZFiEzCjgahGo+wKKLktrNDFG9a6N6PFV9/RC
         EqXAF1JK2Km2IDQz5HIKCG+Y9S4LmYDV++UDcZ1bvfoMK4PMc+8O9zFypn0dX/fcJK1s
         v78+hOpp9/GaTNA5bwGeLI3WGheiEDqTyPt2O5oUKT7b1iaVzhnSBdKpKlCXwn6Taw7J
         PK5CSLcf0HjmXEtyuuFNK29K9mAaoZZX/b/g/LpAoVfKRAuRCAxWzHokF1KffYMT4ifh
         zNACCFR2rRyO4CwPmt8zqd4fv4Fy4TN3fPYNlzPZ48WVSCgFPGRPLldTYvG+UtFBp2z9
         lpBQ==
X-Gm-Message-State: AGi0PuZ6E/vPIZW+YkwEdqbV9F/LX5uVVYRiZuUNzMCYLsONgt6N9hzi
        tDoOoZcYX2rIQuCcmuXvn7rKlw==
X-Google-Smtp-Source: APiQypJsEbPf4KHwwqefKDtX7LOwJ1N3QidiKiM8JwypyuHYoxNvQM6kC0a3HDoA+yBY6hppzTtm2Q==
X-Received: by 2002:a05:600c:1008:: with SMTP id c8mr3359726wmc.14.1588169027770;
        Wed, 29 Apr 2020 07:03:47 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id d133sm8887008wmc.27.2020.04.29.07.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 07:03:46 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martijn Coenen <maco@android.com>
Subject: [PATCH v4 02/10] loop: Factor out setting loop device size
Date:   Wed, 29 Apr 2020 16:03:33 +0200
Message-Id: <20200429140341.13294-3-maco@android.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200429140341.13294-1-maco@android.com>
References: <20200429140341.13294-1-maco@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code is used repeatedly.

Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 396b8bd4d75c..6643e48ad71c 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -241,12 +241,29 @@ loop_validate_size(loff_t size)
 	return 0;
 }
 
+/**
+ * loop_set_size() - sets device size and notifies userspace
+ * @lo: struct loop_device to set the size for
+ * @size: new size of the loop device
+ *
+ * Callers must validate that the size passed into this function fits into
+ * a sector_t, eg using loop_validate_size()
+ */
+static void loop_set_size(struct loop_device *lo, loff_t size)
+{
+	struct block_device *bdev = lo->lo_device;
+
+	set_capacity(lo->lo_disk, size);
+	bd_set_size(bdev, size << SECTOR_SHIFT);
+	/* let user-space know about the new size */
+	kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
+}
+
 static int
 figure_loop_size(struct loop_device *lo, loff_t offset, loff_t sizelimit)
 {
 	int err;
 	loff_t size = get_size(offset, sizelimit, lo->lo_backing_file);
-	struct block_device *bdev = lo->lo_device;
 
 	err = loop_validate_size(size);
 	if (err)
@@ -256,10 +273,9 @@ figure_loop_size(struct loop_device *lo, loff_t offset, loff_t sizelimit)
 		lo->lo_offset = offset;
 	if (lo->lo_sizelimit != sizelimit)
 		lo->lo_sizelimit = sizelimit;
-	set_capacity(lo->lo_disk, x);
-	bd_set_size(bdev, (loff_t)get_capacity(bdev->bd_disk) << 9);
-	/* let user-space know about the new size */
-	kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
+
+	loop_set_size(lo, size);
+
 	return 0;
 }
 
@@ -1055,11 +1071,8 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 
 	loop_update_rotational(lo);
 	loop_update_dio(lo);
-	set_capacity(lo->lo_disk, size);
-	bd_set_size(bdev, size << 9);
 	loop_sysfs_init(lo);
-	/* let user-space know about the new size */
-	kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
+	loop_set_size(lo, size);
 
 	set_blocksize(bdev, S_ISBLK(inode->i_mode) ?
 		      block_size(inode->i_bdev) : PAGE_SIZE);
-- 
2.26.2.303.gf8c07b1a785-goog

