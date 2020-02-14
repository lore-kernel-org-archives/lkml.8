Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F26DC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AAAC206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581702687;
	bh=sjVY1Z5Q4dyM/6xX10VTEQpm72RuUKhACVpanJEy6kw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aQRrMRuLOKyeZwRjAxsn2WJGZ3xBiXUTFnJypFXCiqUEeUc+ZxpzQNF6OV3VIuSsq
	 881nXih3xYDvxp4cO2KkrKsZ+31y1DCWAaK5Gi9HIf4MWO4xn9DbiJbaAph/fCvNBI
	 Qp8z+M1+71aJkkC3r1OBnRo/yfUI70bjrka6r7IE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388716AbgBNP6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:58:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:42672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387878AbgBNP6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:58:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3DBC2067D;
        Fri, 14 Feb 2020 15:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695914;
        bh=sjVY1Z5Q4dyM/6xX10VTEQpm72RuUKhACVpanJEy6kw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dO3SMn2DiN8GMbhpIoNQTzBEAufPTjZgzwBYmpBgn9LDa8CDWeSYHwd/SmkSQeLzO
         /EcZDhXacUj1NgMTTowS6emWtnd+21cMQs+dZ48UGwfsm/E7WGLqKodTD33OerPMAc
         I7zPTq35o/Y/TfTEcga6uJc1S8W0k7N++oA75oak=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Coly Li <colyli@suse.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-bcache@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 453/542] bcache: rework error unwinding in register_bcache
Date:   Fri, 14 Feb 2020 10:47:25 -0500
Message-Id: <20200214154854.6746-453-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 50246693f81fe887f4db78bf7089051d7f1894cc ]

Split the successful and error return path, and use one goto label for each
resource to unwind.  This also fixes some small errors like leaking the
module reference count in the reboot case (which seems entirely harmless)
or printing the wrong warning messages for early failures.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Coly Li <colyli@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/bcache/super.c | 75 +++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 30 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index a573ce1d85aae..bd2ae1d78fe15 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -2375,29 +2375,33 @@ static bool bch_is_open(struct block_device *bdev)
 static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 			       const char *buffer, size_t size)
 {
-	ssize_t ret = -EINVAL;
-	const char *err = "cannot allocate memory";
-	char *path = NULL;
-	struct cache_sb *sb = NULL;
+	const char *err;
+	char *path;
+	struct cache_sb *sb;
 	struct block_device *bdev = NULL;
-	struct page *sb_page = NULL;
+	struct page *sb_page;
+	ssize_t ret;
 
+	ret = -EBUSY;
 	if (!try_module_get(THIS_MODULE))
-		return -EBUSY;
+		goto out;
 
 	/* For latest state of bcache_is_reboot */
 	smp_mb();
 	if (bcache_is_reboot)
-		return -EBUSY;
+		goto out_module_put;
 
+	ret = -ENOMEM;
+	err = "cannot allocate memory";
 	path = kstrndup(buffer, size, GFP_KERNEL);
 	if (!path)
-		goto err;
+		goto out_module_put;
 
 	sb = kmalloc(sizeof(struct cache_sb), GFP_KERNEL);
 	if (!sb)
-		goto err;
+		goto out_free_path;
 
+	ret = -EINVAL;
 	err = "failed to open device";
 	bdev = blkdev_get_by_path(strim(path),
 				  FMODE_READ|FMODE_WRITE|FMODE_EXCL,
@@ -2414,57 +2418,68 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 			if (!IS_ERR(bdev))
 				bdput(bdev);
 			if (attr == &ksysfs_register_quiet)
-				goto quiet_out;
+				goto done;
 		}
-		goto err;
+		goto out_free_sb;
 	}
 
 	err = "failed to set blocksize";
 	if (set_blocksize(bdev, 4096))
-		goto err_close;
+		goto out_blkdev_put;
 
 	err = read_super(sb, bdev, &sb_page);
 	if (err)
-		goto err_close;
+		goto out_blkdev_put;
 
 	err = "failed to register device";
 	if (SB_IS_BDEV(sb)) {
 		struct cached_dev *dc = kzalloc(sizeof(*dc), GFP_KERNEL);
 
 		if (!dc)
-			goto err_close;
+			goto out_put_sb_page;
 
 		mutex_lock(&bch_register_lock);
 		ret = register_bdev(sb, sb_page, bdev, dc);
 		mutex_unlock(&bch_register_lock);
 		/* blkdev_put() will be called in cached_dev_free() */
-		if (ret < 0)
-			goto err;
+		if (ret < 0) {
+			bdev = NULL;
+			goto out_put_sb_page;
+		}
 	} else {
 		struct cache *ca = kzalloc(sizeof(*ca), GFP_KERNEL);
 
 		if (!ca)
-			goto err_close;
+			goto out_put_sb_page;
 
 		/* blkdev_put() will be called in bch_cache_release() */
-		if (register_cache(sb, sb_page, bdev, ca) != 0)
-			goto err;
+		if (register_cache(sb, sb_page, bdev, ca) != 0) {
+			bdev = NULL;
+			goto out_put_sb_page;
+		}
 	}
-quiet_out:
-	ret = size;
-out:
-	if (sb_page)
-		put_page(sb_page);
+
+	put_page(sb_page);
+done:
 	kfree(sb);
 	kfree(path);
 	module_put(THIS_MODULE);
-	return ret;
-
-err_close:
-	blkdev_put(bdev, FMODE_READ|FMODE_WRITE|FMODE_EXCL);
-err:
+	return size;
+
+out_put_sb_page:
+	put_page(sb_page);
+out_blkdev_put:
+	if (bdev)
+		blkdev_put(bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
+out_free_sb:
+	kfree(sb);
+out_free_path:
+	kfree(path);
+out_module_put:
+	module_put(THIS_MODULE);
+out:
 	pr_info("error %s: %s", path, err);
-	goto out;
+	return ret;
 }
 
 
-- 
2.20.1

