Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD23DC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A245720774
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="oeHrjjDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732262AbgDVK4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbgDVKGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:06:46 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29991C03C1A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 03:06:46 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y24so1647576wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 03:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jyo8ye8PIhzgdKAIi2DN9FqA/i7QGb6jE4ELaahTUdI=;
        b=oeHrjjDVrskgRR/vnSC0Kw+k7XEQ+0JHZIQurMmOFnwzHeCwO+WGJey7RSZToOK0aN
         /9NbohcIQeN0O8/Dxd2m6gI2sJNFh0ibz6y9Ghm/xrgN4tJo9LmPpVLL5ZlQuw1VzcdA
         Y+rEb6vpxEi56dVE+Omi1RdFVrkEnaFERf2lGwXCBwFybk0ThujfbwyDtqnWoV2gVZCX
         ezMpvTloc2YTxeWxZx7NDiuSg0Ko0I2e5kLsaVTx71WLl89gaZQ9ULO7el7YW7IWx316
         olmzwj3XRm0QTJXGfBo6VflS92L7mKshZpfZM4fWpS5NhXSxHc57nmNVnEpMsDFUwk82
         xlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jyo8ye8PIhzgdKAIi2DN9FqA/i7QGb6jE4ELaahTUdI=;
        b=f0wh9TrDGHtrQYt6jUj6omLM+wXUXxXs9LGgjhqLI+Ky382JOzBcK+jnSgMiSdzaMR
         fqIfkP2cHO15awWotEhuLvJGk2Wqx1QCK23x1ESlyvL0jAUn+0TRnRar24rO0/ohblPr
         q0kQLD+mDy1xO1tNb8s392axKIzDh25pEK99Cj1Z3KNLDR0QfwwftQuIGinNYv0dXc6D
         rX42GQ+zD3EAFi58SpDavNaRrqK/gPyFSyxgfR4WVzPjm1Z6gOQRb1fwnv3gb6utYHHa
         VM9HziEZkt3vslf0beU4u2JYlunLRmy8F6pnUI/tFWRZ4ihWQKAoGa/5WAkt1QwUvGHU
         pSzg==
X-Gm-Message-State: AGi0Pubn7C+SmDmnaimJNOR+vEjNh5S62aWXDflp3R39R4kaWRL6/s93
        me9OyStvKWsF7sUkS4glBlRvxg==
X-Google-Smtp-Source: APiQypKHvDI64iD2AdYtrAT2zOe/a0I1w+st9gtBcL2PFw288hPuqwYvPnIKlJWt43lqDTQy5KIcog==
X-Received: by 2002:a1c:6545:: with SMTP id z66mr9388327wmb.81.1587550004869;
        Wed, 22 Apr 2020 03:06:44 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id j13sm7812462wrq.24.2020.04.22.03.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 03:06:43 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org, Martijn Coenen <maco@android.com>
Subject: [PATCH v2 2/5] loop: Factor out configuring loop from status
Date:   Wed, 22 Apr 2020 12:06:33 +0200
Message-Id: <20200422100636.46357-3-maco@android.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200422100636.46357-1-maco@android.com>
References: <20200422100636.46357-1-maco@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out this code into a separate function, so it can be reused by
other code more easily.

Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c | 117 +++++++++++++++++++++++++------------------
 1 file changed, 67 insertions(+), 50 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 4f5c765c73d8..3f8051d3115e 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1275,13 +1275,78 @@ static int loop_clr_fd(struct loop_device *lo)
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
+static int
+loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
+{
+	int err;
 	struct block_device *bdev;
+	kuid_t uid = current_uid();
 	bool partscan = false;
 	bool size_changed = false;
 	loff_t validated_size;
@@ -1299,10 +1364,6 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		err = -ENXIO;
 		goto out_unlock;
 	}
-	if ((unsigned int) info->lo_encrypt_key_size > LO_KEY_SIZE) {
-		err = -EINVAL;
-		goto out_unlock;
-	}
 
 	if (lo->lo_offset != info->lo_offset ||
 	    lo->lo_sizelimit != info->lo_sizelimit) {
@@ -1330,54 +1391,10 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		goto out_unfreeze;
 	}
 
-	err = loop_release_xfer(lo);
+	err = loop_set_status_from_info(lo, info);
 	if (err)
 		goto out_unfreeze;
 
-	if (info->lo_encrypt_type) {
-		unsigned int type = info->lo_encrypt_type;
-
-		if (type >= MAX_LO_CRYPT) {
-			err = -EINVAL;
-			goto out_unfreeze;
-		}
-		xfer = xfer_funcs[type];
-		if (xfer == NULL) {
-			err = -EINVAL;
-			goto out_unfreeze;
-		}
-	} else
-		xfer = NULL;
-
-	err = loop_init_xfer(lo, xfer, info);
-	if (err)
-		goto out_unfreeze;
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
 	if (size_changed)
 		loop_set_size(lo, validated_size);
 
-- 
2.26.2.303.gf8c07b1a785-goog

