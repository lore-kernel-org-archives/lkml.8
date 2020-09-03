Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3D5C433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 09:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECCCB20709
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 09:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b8Y3hFjx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgICJyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 05:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgICJyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 05:54:37 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92026C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 02:54:37 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id o68so1913823pfg.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 02:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RVbMMao6eXbbJWq/3Lh2it4P0heF+Qd3gd6MPM/MrF4=;
        b=b8Y3hFjxLA5/OhtT30nHHSqeFOhgrC/xKA2O59hqabQSpL190xH9G/hYHdTx+KXDd6
         bRBqqqswo0SzsvsdMfs9axFNrDC0VSfB3A3u02ZqldyB6VjNOsQYKuZxgq4pi2QWkjIS
         a7uQlwU5ejm6xQ6lO2To9yesI9jUFCKX2rbHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RVbMMao6eXbbJWq/3Lh2it4P0heF+Qd3gd6MPM/MrF4=;
        b=GAi2iUKJEY1jfsFyzw8W3YQEeRquG/E2aV68CmtDaXdoEeXSLia1svVhWcj+/WTpBf
         OzKZduFtfiCzaKfcnLeMAYiUa0mecADxHiDiXJpff4suSefwktte0VsAbu3WbvhbEbSI
         RNAEtJEJlij+wlbK1bQNsni6hRNf3xbGAF5YftgpzvzVdZjZSg9YgJPFgAHQk/TOkTqN
         gKyk0ZuFaZ0+ca+m0avxJK7DwFD/pKFWyEjbaBy2841alFxAxVs2JAT7mI8JySh5EzNI
         qh+i1wC6WPZuXfkbiGuYyQE7W4tsheYy6nwy4Mf2qSxF3veyYSaATyOou+8dcYtdyY3v
         WwRw==
X-Gm-Message-State: AOAM531/tn/pq0br8s8dAe61vvW8+zxV8hOb/0uqEqJzv3E0kItm43K6
        x/edB8z1tLbWkvqfxtnfA0lEBkPm1SKkKw==
X-Google-Smtp-Source: ABdhPJzGttOMu5tc8tdIPuShGfoRQoXoyGlSx9AOBcIkgrQPWCZB4RmoLWEtOhHOuCRxmVSTrSDKow==
X-Received: by 2002:a62:8286:0:b029:13c:1611:6588 with SMTP id w128-20020a6282860000b029013c16116588mr1409419pfd.5.1599126876892;
        Thu, 03 Sep 2020 02:54:36 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id y7sm2094475pgk.73.2020.09.03.02.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 02:54:36 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwendal@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 2/2] platform/chrome: cros_ec_proto: Drop cros_ec_cmd_xfer()
Date:   Thu,  3 Sep 2020 02:54:16 -0700
Message-Id: <20200903095415.2572049-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
In-Reply-To: <20200903095415.2572049-1-pmalani@chromium.org>
References: <20200903095415.2572049-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since cros_ec_cmd_xfer_status() now returns Linux error codes and all
other files use that command, remove the now-unused function
cros_ec_cmd_xfer().

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_proto.c | 44 +++++++------------------
 1 file changed, 11 insertions(+), 33 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 2cb1defcdd13..0ecee8b8773d 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -549,19 +549,22 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
 EXPORT_SYMBOL(cros_ec_query_all);
 
 /**
- * cros_ec_cmd_xfer() - Send a command to the ChromeOS EC.
+ * cros_ec_cmd_xfer_status() - Send a command to the ChromeOS EC.
  * @ec_dev: EC device.
  * @msg: Message to write.
  *
- * Call this to send a command to the ChromeOS EC.  This should be used
- * instead of calling the EC's cmd_xfer() callback directly.
+ * Call this to send a command to the ChromeOS EC. This should be used instead of calling the EC's
+ * cmd_xfer() callback directly. It returns success status only if both the command was transmitted
+ * successfully and the EC replied with success status.
  *
- * Return: 0 on success or negative error code.
+ * Return:
+ * >=0 - The number of bytes transferred
+ * <0 - Linux error code
  */
-static int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
+int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
 			    struct cros_ec_command *msg)
 {
-	int ret;
+	int ret, mapped;
 
 	mutex_lock(&ec_dev->lock);
 	if (ec_dev->proto_version == EC_PROTO_VERSION_UNKNOWN) {
@@ -598,42 +601,17 @@ static int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
 			return -EMSGSIZE;
 		}
 	}
+
 	ret = send_command(ec_dev, msg);
 	mutex_unlock(&ec_dev->lock);
 
-	return ret;
-}
-
-/**
- * cros_ec_cmd_xfer_status() - Send a command to the ChromeOS EC.
- * @ec_dev: EC device.
- * @msg: Message to write.
- *
- * This function is identical to cros_ec_cmd_xfer, except it returns success
- * status only if both the command was transmitted successfully and the EC
- * replied with success status. It's not necessary to check msg->result when
- * using this function.
- *
- * Return:
- * >=0 - The number of bytes transferred
- * <0 - Linux error code
- */
-int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
-			    struct cros_ec_command *msg)
-{
-	int ret, mapped;
-
-	ret = cros_ec_cmd_xfer(ec_dev, msg);
-	if (ret < 0) {
-		dev_err(ec_dev->dev, "Command xfer error (err:%d)\n", ret);
-		return ret;
-	}
 	mapped = cros_ec_map_error(msg->result);
 	if (mapped) {
 		dev_dbg(ec_dev->dev, "Command result (err: %d [%d])\n",
 			msg->result, mapped);
 		ret = mapped;
 	}
+
 	return ret;
 }
 EXPORT_SYMBOL(cros_ec_cmd_xfer_status);
-- 
2.28.0.526.ge36021eeef-goog

