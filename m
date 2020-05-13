Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60928C2D0FC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B9D0223D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="XLDLOeJ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388526AbgEMNjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387466AbgEMNi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:38:59 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124F3C05BD0B
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:38:59 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f134so14417097wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i9VKkgYcutgK58oduvWyhmP92sHEi0TmGwJSY9JiTVM=;
        b=XLDLOeJ1jWNVKadKhYblmQ1wc4bEzYSUdgqh1AqZiiYrEA/XsSyYwmM2WkUOMKMUah
         cOEzxOAWJmeSZ0QteHp+uD1rnPmWKGxm/jQH8nw7TW6iuSgi59OX35Vy1D68K/qnSPlE
         snxwDVOe8FIW4qJuExZJ5y9fipQcCUZK7HAv0dLaT4oUdvnRG0B1VgpM5PndmB7SraQW
         6VebFD8iPbRJSp1UzrPOd8SOBIqA/iOxWmuV+Tn714cU8wud9K4UD30bqg7l6gyu4pnK
         9WPjUOdyoTAmxBRDrbYAp4XqDhpowcjRdNiwWCfXn0AUThalcp9WZTuZDU5MFmfz+q6/
         ebcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i9VKkgYcutgK58oduvWyhmP92sHEi0TmGwJSY9JiTVM=;
        b=MGQI/El+ZzEtytmytp9uZI4+Vv01UT2xviHXtpHiUAW6SDv04hpe8nbPTtfKTZOgdc
         YIlKIdZhemZVlElXCqNW49+5X2zzpzyVGIehYAGoDHNXJjLy1zW9HnxOltbEtFL0SVg7
         gp9drhXWgTmT9N+Ftco419kWs7XKvCeb7nfYNUDY0evUBVcOKS6vNDy+QJmo0vQdbT02
         L/k7M/IZqB+8BzzIJOBinPHQHgZgtl1YSHREJxgUmatqURMrNunHvT202gbvc0jl4eex
         HMy+ajx+TQ54b642SwfXM3nV21wolO2+CiKLSkOa/fewd4B0I1LNYfxdbKKIpJW+SQU2
         GQfQ==
X-Gm-Message-State: AGi0PuaNPwUWmLFzB++1iXkVHIM3QVr4qjeCuuxZMhAMEgFSCvLTOCYu
        ZPiT5AIfNXbmVV4dWZHXOUfjnA==
X-Google-Smtp-Source: APiQypLc80O1KIJtrEk8zdvq1XtASt6qABrDzk+XGaNM/J21GEj9gZ53eLHBoJLozC6/kn4sxpfU0A==
X-Received: by 2002:a7b:c959:: with SMTP id i25mr23723098wml.84.1589377137700;
        Wed, 13 May 2020 06:38:57 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id m6sm26202653wrq.5.2020.05.13.06.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 06:38:57 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, maco@google.com,
        kernel-team@android.com, bvanassche@acm.org,
        Chaitanya.Kulkarni@wdc.com, jaegeuk@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>
Subject: [PATCH v5 07/11] loop: Factor out configuring loop from status
Date:   Wed, 13 May 2020 15:38:41 +0200
Message-Id: <20200513133845.244903-8-maco@android.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
In-Reply-To: <20200513133845.244903-1-maco@android.com>
References: <20200513133845.244903-1-maco@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out this code into a separate function, so it can be reused by
other code more easily.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c | 117 +++++++++++++++++++++++++------------------
 1 file changed, 67 insertions(+), 50 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index e281a9f03d96..6a4c0ba225ca 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1251,75 +1251,43 @@ static int loop_clr_fd(struct loop_device *lo)
 	return __loop_clr_fd(lo, false);
 }
 
+/**
+ * loop_set_status_from_info - configure device from loop_info
+ * @lo: struct loop_device to configure
+ * @info: struct loop_info64 to configure the device with
+ *
+ * Configures the loop device parameters according to the passed
+ * in loop_info64 configuration.
+ */
 static int
-loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
+loop_set_status_from_info(struct loop_device *lo,
+			  const struct loop_info64 *info)
 {
 	int err;
 	struct loop_func_table *xfer;
 	kuid_t uid = current_uid();
-	struct block_device *bdev;
-	bool partscan = false;
-	bool size_changed = false;
-
-	err = mutex_lock_killable(&loop_ctl_mutex);
-	if (err)
-		return err;
-	if (lo->lo_encrypt_key_size &&
-	    !uid_eq(lo->lo_key_owner, uid) &&
-	    !capable(CAP_SYS_ADMIN)) {
-		err = -EPERM;
-		goto out_unlock;
-	}
-	if (lo->lo_state != Lo_bound) {
-		err = -ENXIO;
-		goto out_unlock;
-	}
-	if ((unsigned int) info->lo_encrypt_key_size > LO_KEY_SIZE) {
-		err = -EINVAL;
-		goto out_unlock;
-	}
-
-	if (lo->lo_offset != info->lo_offset ||
-	    lo->lo_sizelimit != info->lo_sizelimit) {
-		size_changed = true;
-		sync_blockdev(lo->lo_device);
-		kill_bdev(lo->lo_device);
-	}
 
-	/* I/O need to be drained during transfer transition */
-	blk_mq_freeze_queue(lo->lo_queue);
-
-	if (size_changed && lo->lo_device->bd_inode->i_mapping->nrpages) {
-		/* If any pages were dirtied after kill_bdev(), try again */
-		err = -EAGAIN;
-		pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
-			__func__, lo->lo_number, lo->lo_file_name,
-			lo->lo_device->bd_inode->i_mapping->nrpages);
-		goto out_unfreeze;
-	}
+	if ((unsigned int) info->lo_encrypt_key_size > LO_KEY_SIZE)
+		return -EINVAL;
 
 	err = loop_release_xfer(lo);
 	if (err)
-		goto out_unfreeze;
+		return err;
 
 	if (info->lo_encrypt_type) {
 		unsigned int type = info->lo_encrypt_type;
 
-		if (type >= MAX_LO_CRYPT) {
-			err = -EINVAL;
-			goto out_unfreeze;
-		}
+		if (type >= MAX_LO_CRYPT)
+			return -EINVAL;
 		xfer = xfer_funcs[type];
-		if (xfer == NULL) {
-			err = -EINVAL;
-			goto out_unfreeze;
-		}
+		if (xfer == NULL)
+			return -EINVAL;
 	} else
 		xfer = NULL;
 
 	err = loop_init_xfer(lo, xfer, info);
 	if (err)
-		goto out_unfreeze;
+		return err;
 
 	lo->lo_offset = info->lo_offset;
 	lo->lo_sizelimit = info->lo_sizelimit;
@@ -1346,6 +1314,55 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		lo->lo_key_owner = uid;
 	}
 
+	return 0;
+}
+
+static int
+loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
+{
+	int err;
+	struct block_device *bdev;
+	kuid_t uid = current_uid();
+	bool partscan = false;
+	bool size_changed = false;
+
+	err = mutex_lock_killable(&loop_ctl_mutex);
+	if (err)
+		return err;
+	if (lo->lo_encrypt_key_size &&
+	    !uid_eq(lo->lo_key_owner, uid) &&
+	    !capable(CAP_SYS_ADMIN)) {
+		err = -EPERM;
+		goto out_unlock;
+	}
+	if (lo->lo_state != Lo_bound) {
+		err = -ENXIO;
+		goto out_unlock;
+	}
+
+	if (lo->lo_offset != info->lo_offset ||
+	    lo->lo_sizelimit != info->lo_sizelimit) {
+		size_changed = true;
+		sync_blockdev(lo->lo_device);
+		kill_bdev(lo->lo_device);
+	}
+
+	/* I/O need to be drained during transfer transition */
+	blk_mq_freeze_queue(lo->lo_queue);
+
+	if (size_changed && lo->lo_device->bd_inode->i_mapping->nrpages) {
+		/* If any pages were dirtied after kill_bdev(), try again */
+		err = -EAGAIN;
+		pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
+			__func__, lo->lo_number, lo->lo_file_name,
+			lo->lo_device->bd_inode->i_mapping->nrpages);
+		goto out_unfreeze;
+	}
+
+	err = loop_set_status_from_info(lo, info);
+	if (err)
+		goto out_unfreeze;
+
 	if (size_changed) {
 		loff_t new_size = get_size(lo->lo_offset, lo->lo_sizelimit,
 					   lo->lo_backing_file);
-- 
2.26.2.645.ge9eca65c58-goog

