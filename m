Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BC6C2D0FC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30DFD22384
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="M/Au1mtf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388239AbgEMNi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388189AbgEMNiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:38:54 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCB1C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:38:54 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s8so20955356wrt.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N4tnjsx74zfjEiGN4AVN3WivqX+vN/K0hbsTMSGuGKc=;
        b=M/Au1mtf637fE49LjUWpOy5c/Dc7SVnK/fec49o+IJ+rd3KZ+rs4TLSQAdAlMXz74O
         tBqjrddV6Xtt+2vaDEwGkJt9tykl6DnXUMJvyzZLgSI54HVq/IZsVoLMdTe1wi+txQCp
         8sC2zwp6AI2tiCJwmskQJV2JG9KDROPzy7zxhQviMZNsRrQpKbBpPynqK7f7yhU8cLbY
         HtlVUKiA8w7bjBdCj+fmCT/niGR3TczchqRuriN/sWjizop6Wo/Rc4uNhKVSDuO5iVcd
         z2mQ4iBzlH/BQzIsrDky7PdFvmYeem0aZSEHvgpd4WRUO2UxeIfJ4wMQ+UCA6Oln7Kmc
         7VjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N4tnjsx74zfjEiGN4AVN3WivqX+vN/K0hbsTMSGuGKc=;
        b=YpO0+a8N65iT7rhNZdOM2lDjRpuSdP2kMu7cEmVxrTrcnlxKME/tr7Uwb4L5yLPmUw
         4//UIJl5jCb2oUKJzjU8oL8BQ8YPiuPrntR+Ql3CWCXbBQZSNclcb7FEVdfJbWGOLKzE
         V0MJuSsXbaGKFZMnmamKZD0yjmvzWcORsC8Mt1ubJqlJ6T36kZkHzxYM6onNEKYDKrzz
         uyuoIB5bgvoLG2RNlFVHXIUf/alk4YOtzvYbVZvxTZ9k2ZPtn20ueB9nYrGfijxj9Qbb
         df54AptBEKF/yBrzdsy9a6STNEdK603RWDaSebdR9cWyF7OPkk6E6/0coLCflXBXzUPP
         NoGQ==
X-Gm-Message-State: AGi0PuYFT62CQ38yVD8nupRT8fVx4mAqdJxwrLRShinj6MqVpKIKBbBn
        f2Nl9B1ySbeohaTHxH+luw14Ww==
X-Google-Smtp-Source: APiQypLF0JO0A7KUhinkJ32QI/HYHE16/WvvsU+c1NE58s5yvy9WXda4oQ/YQBWrumxU5Cuc+/sssg==
X-Received: by 2002:adf:9422:: with SMTP id 31mr23964444wrq.10.1589377133240;
        Wed, 13 May 2020 06:38:53 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id m6sm26202653wrq.5.2020.05.13.06.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 06:38:52 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, maco@google.com,
        kernel-team@android.com, bvanassche@acm.org,
        Chaitanya.Kulkarni@wdc.com, jaegeuk@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>
Subject: [PATCH v5 03/11] loop: Factor out setting loop device size
Date:   Wed, 13 May 2020 15:38:37 +0200
Message-Id: <20200513133845.244903-4-maco@android.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
In-Reply-To: <20200513133845.244903-1-maco@android.com>
References: <20200513133845.244903-1-maco@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code is used repeatedly.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 00de7fec0ed5..e69ff3c19eff 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -228,20 +228,35 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
 		blk_mq_unfreeze_queue(lo->lo_queue);
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
 static void
 figure_loop_size(struct loop_device *lo, loff_t offset, loff_t sizelimit)
 {
 	loff_t size = get_size(offset, sizelimit, lo->lo_backing_file);
-	struct block_device *bdev = lo->lo_device;
 
 	if (lo->lo_offset != offset)
 		lo->lo_offset = offset;
 	if (lo->lo_sizelimit != sizelimit)
 		lo->lo_sizelimit = sizelimit;
-	set_capacity(lo->lo_disk, size);
-	bd_set_size(bdev, (loff_t)get_capacity(bdev->bd_disk) << 9);
-	/* let user-space know about the new size */
-	kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
+
+	loop_set_size(lo, size);
 }
 
 static inline int
@@ -1034,11 +1049,8 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 
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
2.26.2.645.ge9eca65c58-goog

