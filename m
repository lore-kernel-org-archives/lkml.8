Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003BBC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 01:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72312073B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 01:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AzMoWvOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbgAYBVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 20:21:32 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35979 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgAYBVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 20:21:31 -0500
Received: by mail-pf1-f194.google.com with SMTP id w2so1953694pfd.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 17:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ozPe0HVPIC1b0/+mSZyQOpz7fXxujT8sGk4dgUhiBjM=;
        b=AzMoWvOhecXo4M/VXlM9KeYJENsopNcUxwEwRrlxOxlYKwT+xf67TUnN7SUPV/pDy1
         k/WKGAo3xA3CmuHKVjPQr6HEnyFgpd/H0Ej6axrKQUgGDgWXZCMKN9ycEIWUTZ/iYv2C
         bKPB/iR4rPzwDorcV/zZAffX9f5N/pWE6+s6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ozPe0HVPIC1b0/+mSZyQOpz7fXxujT8sGk4dgUhiBjM=;
        b=I/e8UjPLOosCMCKD/pLJxj5gUtIPJAHIr1TzSrdQCCBZp/4hsnHRodKEgEACzoQQEZ
         27Aiqt/9pLQuTU+4Awn8FXO5FDWqArOf1lzRAwSEMWC3Xn/QpL9XzPhFDj9Cw0EolQj/
         0N9PK05kTj9/3XxrBrDvG9hDcBdMOkQPNKkjl7G/4rwlk2o15orwylMqOyPJZCFS263u
         PttgAnlVwo69aeQE46/LyPSnq//n+1ocSEDC5FoMrWt6n8tEUAVjL6IOuIG46nyNVZdl
         YBbsG4Snew40tm89KGg6jKWn4mMrszGbVHU39nc6g28Yg+o7Ry2rERC+ZF3O4RuzQ9/P
         5kRA==
X-Gm-Message-State: APjAAAWiX0DxvUEjFVSBE10nwzbyaAU8O23+i3D5b4HvgipCfUhfTMad
        C/kJzFeCnSHZhRNqkcHGov2CUw==
X-Google-Smtp-Source: APXvYqwz8A5b3ZOpRxIiYMPTRMH+JrDjFb2faXAffB5hkPtmOUr+lewKYhxd+K8aazwQRlmnux7x3Q==
X-Received: by 2002:aa7:9484:: with SMTP id z4mr5864625pfk.88.1579915290903;
        Fri, 24 Jan 2020 17:21:30 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id n4sm7443337pgg.88.2020.01.24.17.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 17:21:30 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>
Subject: [PATCH 1/4] platform/chrome: Add EC command msg wrapper
Date:   Fri, 24 Jan 2020 17:21:03 -0800
Message-Id: <20200125012105.59903-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200125012105.59903-1-pmalani@chromium.org>
References: <20200125012105.59903-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many callers of cros_ec_cmd_xfer_status() use a similar set up of
allocating and filling a message buffer and then copying any received
data to a target buffer.

Create a utility function that performs this setup so that callers can
use this function instead.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_proto.c     | 53 +++++++++++++++++++++
 include/linux/platform_data/cros_ec_proto.h |  5 ++
 2 files changed, 58 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index da1b1c4504333..8ef3b7d27d260 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -5,6 +5,7 @@
 
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/mfd/cros_ec.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
@@ -570,6 +571,58 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
 }
 EXPORT_SYMBOL(cros_ec_cmd_xfer_status);
 
+/**
+ * cros_ec_send_cmd_msg() - Utility function to send commands to ChromeOS EC.
+ * @ec: EC device struct.
+ * @version: Command version number (often 0).
+ * @command: Command ID including offset.
+ * @outdata: Data to be sent to the EC.
+ * @outsize: Size of the &outdata buffer.
+ * @indata: Data to be received from the EC.
+ * @insize: Size of the &indata buffer.
+ *
+ * This function is a wrapper around &cros_ec_cmd_xfer_status, and performs
+ * some of the common work involved with sending a command to the EC. This
+ * includes allocating and filling up a &struct cros_ec_command message buffer,
+ * and copying the received data to another buffer.
+ *
+ * Return: The number of bytes transferred on success or negative error code.
+ */
+int cros_ec_send_cmd_msg(struct cros_ec_device *ec, unsigned int version,
+			 unsigned int command, void *outdata,
+			 unsigned int outsize, void *indata,
+			 unsigned int insize)
+{
+	struct cros_ec_command *msg;
+	int ret;
+
+	msg = kzalloc(sizeof(*msg) + max(outsize, insize), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	msg->version = version;
+	msg->command = command;
+	msg->outsize = outsize;
+	msg->insize = insize;
+
+	if (outdata && outsize > 0)
+		memcpy(msg->data, outdata, outsize);
+
+	ret = cros_ec_cmd_xfer_status(ec, msg);
+	if (ret < 0) {
+		dev_warn(ec->dev, "Command failed: %d\n", msg->result);
+		goto cleanup;
+	}
+
+	if (insize)
+		memcpy(indata, msg->data, insize);
+
+cleanup:
+	kfree(msg);
+	return ret;
+}
+EXPORT_SYMBOL(cros_ec_send_cmd_msg);
+
 static int get_next_event_xfer(struct cros_ec_device *ec_dev,
 			       struct cros_ec_command *msg,
 			       struct ec_response_get_next_event_v1 *event,
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 30098a5515231..166ce26bdd79e 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -201,6 +201,11 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
 int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
 			    struct cros_ec_command *msg);
 
+int cros_ec_send_cmd_msg(struct cros_ec_device *ec_dev, unsigned int version,
+			 unsigned int command, void *outdata,
+			 unsigned int outsize, void *indata,
+			 unsigned int insize);
+
 int cros_ec_register(struct cros_ec_device *ec_dev);
 
 int cros_ec_unregister(struct cros_ec_device *ec_dev);
-- 
2.25.0.341.g760bfbb309-goog

