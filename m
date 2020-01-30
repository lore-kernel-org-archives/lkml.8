Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE76C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E34320708
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bU3OkX/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgA3UcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:32:25 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:38067 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbgA3UcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 15:32:25 -0500
Received: by mail-pj1-f66.google.com with SMTP id j17so1838667pjz.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 12:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FtaX6Xi6b29v8c3hFnfNeJynlPhMvPp4kwKKUlNr6FY=;
        b=bU3OkX/GZ8FgQO/qrUMVpk8hUwdH915nU108xMvX0gxuX3Fpi1zsTIrtFni2q/0otW
         ULjL806iRDKIUkKFEEFH9XXp0IZdk/dEV7r0tzFW1F7HaWyFqscA8JXBQkAIIoth5Qhd
         1Osot+LO750iHubwtMcoOfHeRCsBEmBCsEWWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FtaX6Xi6b29v8c3hFnfNeJynlPhMvPp4kwKKUlNr6FY=;
        b=CyEK0SW0bnBRGSPyhbQXx91ErTIMdQhdnMHQ0g9JUJqC8nM7NQhWoTAsSQ8pbNu5dg
         0UckoEmKnJnVhIr6bUewxcFKI3Q0PgUNAJ+wnUk+pMGdMkI4JVN9aGU+HiHYZMYP/DeE
         kcVFi71dYRFLsjIODioNdwsHq4/d3zT6D1q0djJZvsG3bpnE5uS2mCpwf8h9446Lx06o
         riZAtXnEbMOhEsvNRL89zAuRzfXKDRiYiZb1PDsHgxIie+rZ8F6PAhdMt2jYobxP0huO
         lisjLwRxb2cEIpeNBSbBMgIZMRE0nZPN0ceYLpjaMNwv6JP396m8kVv0z79V08qz/D6K
         JbHg==
X-Gm-Message-State: APjAAAWLLsB/UvBSQUe81rw7fmbb+4hegEO5jjUsv1NqqsilMXeqVrLT
        kuninIffvL9vFEzi/A3zFEfFeIuUuRQPfw==
X-Google-Smtp-Source: APXvYqxtwkvlrfQ3ZA85U0NkLD1pZIMXRR0SDz0oy3y3XmxMHkDho8sAMdJwdXslIdYOrZ4nCa4NcQ==
X-Received: by 2002:a17:902:9a8e:: with SMTP id w14mr6385660plp.315.1580416342663;
        Thu, 30 Jan 2020 12:32:22 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id q12sm7469321pfh.158.2020.01.30.12.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:32:22 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Evan Green <evgreen@chromium.org>
Subject: [PATCH 01/17] platform/chrome: Add EC command msg wrapper
Date:   Thu, 30 Jan 2020 12:30:33 -0800
Message-Id: <20200130203106.201894-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200130203106.201894-1-pmalani@chromium.org>
References: <20200130203106.201894-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many callers of cros_ec_cmd_xfer_status() use a similar set up of
allocating and filling a message buffer and then copying any received
data to a target buffer.

Create a utility function cros_ec_send_cmd_msg() that performs this
setup so that callers can use this function instead. Subsequent patches
will convert callers of cros_ec_cmd_xfer_status() to the new function
instead.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_proto.c     | 57 +++++++++++++++++++++
 include/linux/platform_data/cros_ec_proto.h |  5 ++
 2 files changed, 62 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index da1b1c45043333..53f3bfac71d90e 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -5,6 +5,7 @@
 
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/mfd/cros_ec.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
@@ -570,6 +571,62 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
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
+	ret = cros_ec_cmd_xfer(ec, msg);
+	if (ret < 0) {
+		dev_err(ec->dev, "Command xfer error (err:%d)\n", ret);
+		goto cleanup;
+	} else if (msg->result != EC_RES_SUCCESS) {
+		dev_dbg(ec->dev, "Command result (err: %d)\n", msg->result);
+		ret = -EPROTO;
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
index 30098a5515231d..166ce26bdd79eb 100644
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

