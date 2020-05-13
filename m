Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1D6CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AD2C2240C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="MRimYn1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388599AbgEMNjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388354AbgEMNjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:39:00 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD78C05BD09
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:39:00 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f134so14417201wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LBTQ6eQQNZClAXm4Mu8rwjnwwY7IgTM1Zu9ooGgm8tc=;
        b=MRimYn1BzHn9Y/kf1+72ehYmhU8z3RGbI4382aewpxl+wuzBqpQpfoH5bKGMm5RCQk
         yCYWz3dQxrUMWRnWQcrfaz7JF6t4X3Ym/Xdn9l9ADB0AGXL0px1CEXhNMoR67V7Is6fg
         P4/ACLUwNjeD/TcCN1Vf9ImkwV2MtmyraGAA6vhlGpxIwJ+AJuu/0xisboiPC3zUn9Ae
         r4oUmrFknq/WKMah8f14fjaDvd0bZCnyhIcf0FhCNhj681X0njTEdaNiV2E6auXIoZcD
         adcJyjfpoJ4lI39KcFUkoR0XBnvr7Ff4mLmrfh+HaVpEFVxcsb5XRCasB9WGx/gw1jFv
         qZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LBTQ6eQQNZClAXm4Mu8rwjnwwY7IgTM1Zu9ooGgm8tc=;
        b=tag5R/8zZ6O99xUJXddoSBwfifFGRhuCJ9UxmV14zMgNsiFETMGMcMQw1HODeNYMSR
         +QHDY9GPkfcJazk7yk7RGvCotVh3uBOujfFEi+1r+9k3vvv7hDb33awDE9kSgdasLmd0
         geVIXe5BgGC94DP2Cv2aTY8qOhHaFrvW81UWA3nX8FsNZNekIwmI231+kV97+IGVz834
         mwJMMU2QyIpIKuW4ujH8p2R/Pc7SB3AHGNyNHdEIOP+1UhzOmqHchbu92i8/qOacIZlo
         byO087GiRGS5IJAkWiLDLTdr9cJgZfVdexXAnDzN9hVjQGBIYktzmgfswQFn2G9G+0q3
         gtPA==
X-Gm-Message-State: AGi0PuZEfYxpPGN1AlLDhqcpxXLCnKs4oU1HfCKQqlWjsm5MHBz08M9R
        ypVGsvGXyLEz/Rh+pWK7Qh/GRw==
X-Google-Smtp-Source: APiQypKDZXiGlqbbIXjnTDfD4v2C9vlzh6r01ctvDN2CH70edPD/tPjXN6HV6xGGJv4pYFtfPIss4g==
X-Received: by 2002:a7b:cb53:: with SMTP id v19mr41936758wmj.166.1589377139165;
        Wed, 13 May 2020 06:38:59 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id m6sm26202653wrq.5.2020.05.13.06.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 06:38:58 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, maco@google.com,
        kernel-team@android.com, bvanassche@acm.org,
        Chaitanya.Kulkarni@wdc.com, jaegeuk@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>
Subject: [PATCH v5 08/11] loop: Move loop_set_status_from_info() and friends up
Date:   Wed, 13 May 2020 15:38:42 +0200
Message-Id: <20200513133845.244903-9-maco@android.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
In-Reply-To: <20200513133845.244903-1-maco@android.com>
References: <20200513133845.244903-1-maco@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So we can use it without forward declaration. This is a separate commit
to make it easier to verify that this is just a move, without functional
modifications.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c | 206 +++++++++++++++++++++----------------------
 1 file changed, 103 insertions(+), 103 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 6a4c0ba225ca..4dc11d954169 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -949,6 +949,109 @@ static void loop_update_rotational(struct loop_device *lo)
 		blk_queue_flag_clear(QUEUE_FLAG_NONROT, q);
 }
 
+static int
+loop_release_xfer(struct loop_device *lo)
+{
+	int err = 0;
+	struct loop_func_table *xfer = lo->lo_encryption;
+
+	if (xfer) {
+		if (xfer->release)
+			err = xfer->release(lo);
+		lo->transfer = NULL;
+		lo->lo_encryption = NULL;
+		module_put(xfer->owner);
+	}
+	return err;
+}
+
+static int
+loop_init_xfer(struct loop_device *lo, struct loop_func_table *xfer,
+	       const struct loop_info64 *i)
+{
+	int err = 0;
+
+	if (xfer) {
+		struct module *owner = xfer->owner;
+
+		if (!try_module_get(owner))
+			return -EINVAL;
+		if (xfer->init)
+			err = xfer->init(lo, i);
+		if (err)
+			module_put(owner);
+		else
+			lo->lo_encryption = xfer;
+	}
+	return err;
+}
+
+/**
+ * loop_set_status_from_info - configure device from loop_info
+ * @lo: struct loop_device to configure
+ * @info: struct loop_info64 to configure the device with
+ *
+ * Configures the loop device parameters according to the passed
+ * in loop_info64 configuration.
+ */
+static int
+loop_set_status_from_info(struct loop_device *lo,
+			  const struct loop_info64 *info)
+{
+	int err;
+	struct loop_func_table *xfer;
+	kuid_t uid = current_uid();
+
+	if ((unsigned int) info->lo_encrypt_key_size > LO_KEY_SIZE)
+		return -EINVAL;
+
+	err = loop_release_xfer(lo);
+	if (err)
+		return err;
+
+	if (info->lo_encrypt_type) {
+		unsigned int type = info->lo_encrypt_type;
+
+		if (type >= MAX_LO_CRYPT)
+			return -EINVAL;
+		xfer = xfer_funcs[type];
+		if (xfer == NULL)
+			return -EINVAL;
+	} else
+		xfer = NULL;
+
+	err = loop_init_xfer(lo, xfer, info);
+	if (err)
+		return err;
+
+	lo->lo_offset = info->lo_offset;
+	lo->lo_sizelimit = info->lo_sizelimit;
+	memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
+	memcpy(lo->lo_crypt_name, info->lo_crypt_name, LO_NAME_SIZE);
+	lo->lo_file_name[LO_NAME_SIZE-1] = 0;
+	lo->lo_crypt_name[LO_NAME_SIZE-1] = 0;
+
+	if (!xfer)
+		xfer = &none_funcs;
+	lo->transfer = xfer->transfer;
+	lo->ioctl = xfer->ioctl;
+
+	if ((lo->lo_flags & LO_FLAGS_AUTOCLEAR) !=
+	     (info->lo_flags & LO_FLAGS_AUTOCLEAR))
+		lo->lo_flags ^= LO_FLAGS_AUTOCLEAR;
+
+	lo->lo_encrypt_key_size = info->lo_encrypt_key_size;
+	lo->lo_init[0] = info->lo_init[0];
+	lo->lo_init[1] = info->lo_init[1];
+	if (info->lo_encrypt_key_size) {
+		memcpy(lo->lo_encrypt_key, info->lo_encrypt_key,
+		       info->lo_encrypt_key_size);
+		lo->lo_key_owner = uid;
+	}
+
+	return 0;
+}
+
 static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 		       struct block_device *bdev, unsigned int arg)
 {
@@ -1070,43 +1173,6 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	return error;
 }
 
-static int
-loop_release_xfer(struct loop_device *lo)
-{
-	int err = 0;
-	struct loop_func_table *xfer = lo->lo_encryption;
-
-	if (xfer) {
-		if (xfer->release)
-			err = xfer->release(lo);
-		lo->transfer = NULL;
-		lo->lo_encryption = NULL;
-		module_put(xfer->owner);
-	}
-	return err;
-}
-
-static int
-loop_init_xfer(struct loop_device *lo, struct loop_func_table *xfer,
-	       const struct loop_info64 *i)
-{
-	int err = 0;
-
-	if (xfer) {
-		struct module *owner = xfer->owner;
-
-		if (!try_module_get(owner))
-			return -EINVAL;
-		if (xfer->init)
-			err = xfer->init(lo, i);
-		if (err)
-			module_put(owner);
-		else
-			lo->lo_encryption = xfer;
-	}
-	return err;
-}
-
 static int __loop_clr_fd(struct loop_device *lo, bool release)
 {
 	struct file *filp = NULL;
@@ -1251,72 +1317,6 @@ static int loop_clr_fd(struct loop_device *lo)
 	return __loop_clr_fd(lo, false);
 }
 
-/**
- * loop_set_status_from_info - configure device from loop_info
- * @lo: struct loop_device to configure
- * @info: struct loop_info64 to configure the device with
- *
- * Configures the loop device parameters according to the passed
- * in loop_info64 configuration.
- */
-static int
-loop_set_status_from_info(struct loop_device *lo,
-			  const struct loop_info64 *info)
-{
-	int err;
-	struct loop_func_table *xfer;
-	kuid_t uid = current_uid();
-
-	if ((unsigned int) info->lo_encrypt_key_size > LO_KEY_SIZE)
-		return -EINVAL;
-
-	err = loop_release_xfer(lo);
-	if (err)
-		return err;
-
-	if (info->lo_encrypt_type) {
-		unsigned int type = info->lo_encrypt_type;
-
-		if (type >= MAX_LO_CRYPT)
-			return -EINVAL;
-		xfer = xfer_funcs[type];
-		if (xfer == NULL)
-			return -EINVAL;
-	} else
-		xfer = NULL;
-
-	err = loop_init_xfer(lo, xfer, info);
-	if (err)
-		return err;
-
-	lo->lo_offset = info->lo_offset;
-	lo->lo_sizelimit = info->lo_sizelimit;
-	memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
-	memcpy(lo->lo_crypt_name, info->lo_crypt_name, LO_NAME_SIZE);
-	lo->lo_file_name[LO_NAME_SIZE-1] = 0;
-	lo->lo_crypt_name[LO_NAME_SIZE-1] = 0;
-
-	if (!xfer)
-		xfer = &none_funcs;
-	lo->transfer = xfer->transfer;
-	lo->ioctl = xfer->ioctl;
-
-	if ((lo->lo_flags & LO_FLAGS_AUTOCLEAR) !=
-	     (info->lo_flags & LO_FLAGS_AUTOCLEAR))
-		lo->lo_flags ^= LO_FLAGS_AUTOCLEAR;
-
-	lo->lo_encrypt_key_size = info->lo_encrypt_key_size;
-	lo->lo_init[0] = info->lo_init[0];
-	lo->lo_init[1] = info->lo_init[1];
-	if (info->lo_encrypt_key_size) {
-		memcpy(lo->lo_encrypt_key, info->lo_encrypt_key,
-		       info->lo_encrypt_key_size);
-		lo->lo_key_owner = uid;
-	}
-
-	return 0;
-}
-
 static int
 loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 {
-- 
2.26.2.645.ge9eca65c58-goog

