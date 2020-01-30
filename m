Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3C1C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3EC20708
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YcXTlLf9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgA3UgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:36:08 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39288 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbgA3UgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 15:36:07 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so1787095plp.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 12:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bm4YzehtYvCtm+QPiWtk/5LZt32vGs8W5AoWJFGUkv8=;
        b=YcXTlLf9EK4kMX7y9+Kv2Enpr4KpPX5XdXR9xzNVpzvCS1ierMjfJnPEmcISwf62bz
         49UOpx1dWtAl9LVw9AX0rd8G5oRfzTfnEsWeG1Ty800rno3rEvAyLklxJrOYR26sOnYt
         gNHKae6iWSy6+Lb92c+z9407B80Pxt8wm6snI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bm4YzehtYvCtm+QPiWtk/5LZt32vGs8W5AoWJFGUkv8=;
        b=Vso5iYJRZVl72MQDCkkgnsZOzgCUfftr9/H7jDLJlw5FwOzc3S9HUZMgBEiRy40+Vs
         Tdne8SlRi8WrsHD94GTBMuOOnGDXncp1i0arY8kQk0ueF8WH6Tgz+pgX7PN/7Cjj1tSL
         afnvHzAKUsd9gSvYJKXwl4oEvThIdcQN1+FGSczipBr+tkIsbi9x6ZV1ezMi5J9D2OPp
         uQVUK6s0MxE/GE/LqeC7poT/N48pWpikA7XhTCp5cM09RgS5VsAZlzB+yehdP84klAuv
         YEDos5hk/2RIIKsy8P6d8VN2jBvMRoIM8oCrYmEnn6gkHYKiEtoJltr26YHQqRPEDW3i
         JR0w==
X-Gm-Message-State: APjAAAV4igGR57j+RVgAr5u8oy0lF1HCrYLx0tMB4P8YQWMrhRGSR9so
        HpylZ2SbDCn0/u8Smna+wbzUAeY4dMWNgQ==
X-Google-Smtp-Source: APXvYqwlrr3nFu91vdEM3yoKLJV96UxroluhruTPCyhooGDX15GI6iMRabMhFzrDA06h+oMvUze8mA==
X-Received: by 2002:a17:90a:a60c:: with SMTP id c12mr8244503pjq.28.1580416566898;
        Thu, 30 Jan 2020 12:36:06 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id q12sm7469321pfh.158.2020.01.30.12.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:36:06 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-media@vger.kernel.org (open list:MEDIA INPUT INFRASTRUCTURE
        (V4L/DVB))
Subject: [PATCH 15/17] media: cros-ec-cec: Use cros_ec_send_cmd_msg()
Date:   Thu, 30 Jan 2020 12:31:06 -0800
Message-Id: <20200130203106.201894-16-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200130203106.201894-1-pmalani@chromium.org>
References: <20200130203106.201894-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace cros_ec_cmd_xfer_status() with cros_ec_send_cmd_msg() which does
the message buffer setup and cleanup, but is located in platform/chrome
and used by other drivers.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 .../media/platform/cros-ec-cec/cros-ec-cec.c  | 39 +++++++------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/media/platform/cros-ec-cec/cros-ec-cec.c b/drivers/media/platform/cros-ec-cec/cros-ec-cec.c
index f048e89947850e..0ee7354dca9724 100644
--- a/drivers/media/platform/cros-ec-cec/cros-ec-cec.c
+++ b/drivers/media/platform/cros-ec-cec/cros-ec-cec.c
@@ -94,18 +94,14 @@ static int cros_ec_cec_set_log_addr(struct cec_adapter *adap, u8 logical_addr)
 {
 	struct cros_ec_cec *cros_ec_cec = adap->priv;
 	struct cros_ec_device *cros_ec = cros_ec_cec->cros_ec;
-	struct {
-		struct cros_ec_command msg;
-		struct ec_params_cec_set data;
-	} __packed msg = {};
+	struct ec_params_cec_set data;
 	int ret;
 
-	msg.msg.command = EC_CMD_CEC_SET;
-	msg.msg.outsize = sizeof(msg.data);
-	msg.data.cmd = CEC_CMD_LOGICAL_ADDRESS;
-	msg.data.val = logical_addr;
+	data.cmd = CEC_CMD_LOGICAL_ADDRESS;
+	data.val = logical_addr;
 
-	ret = cros_ec_cmd_xfer_status(cros_ec, &msg.msg);
+	ret = cros_ec_send_cmd_msg(cros_ec, 0, EC_CMD_CEC_SET, &data,
+				   sizeof(data), NULL, 0);
 	if (ret < 0) {
 		dev_err(cros_ec->dev,
 			"error setting CEC logical address on EC: %d\n", ret);
@@ -120,17 +116,14 @@ static int cros_ec_cec_transmit(struct cec_adapter *adap, u8 attempts,
 {
 	struct cros_ec_cec *cros_ec_cec = adap->priv;
 	struct cros_ec_device *cros_ec = cros_ec_cec->cros_ec;
-	struct {
-		struct cros_ec_command msg;
-		struct ec_params_cec_write data;
-	} __packed msg = {};
+	struct ec_params_cec_write data = {};
 	int ret;
 
-	msg.msg.command = EC_CMD_CEC_WRITE_MSG;
 	msg.msg.outsize = cec_msg->len;
-	memcpy(msg.data.msg, cec_msg->msg, cec_msg->len);
+	memcpy(data.msg, cec_msg->msg, cec_msg->len);
 
-	ret = cros_ec_cmd_xfer_status(cros_ec, &msg.msg);
+	ret = cros_ec_send_cmd_msg(cros_ec, 0, EC_CMD_CEC_WRITE_MSG,
+				   &data, sizeof(cec_msg->len), NULL, 0);
 	if (ret < 0) {
 		dev_err(cros_ec->dev,
 			"error writing CEC msg on EC: %d\n", ret);
@@ -144,18 +137,14 @@ static int cros_ec_cec_adap_enable(struct cec_adapter *adap, bool enable)
 {
 	struct cros_ec_cec *cros_ec_cec = adap->priv;
 	struct cros_ec_device *cros_ec = cros_ec_cec->cros_ec;
-	struct {
-		struct cros_ec_command msg;
-		struct ec_params_cec_set data;
-	} __packed msg = {};
+	struct ec_params_cec_set data = {0};
 	int ret;
 
-	msg.msg.command = EC_CMD_CEC_SET;
-	msg.msg.outsize = sizeof(msg.data);
-	msg.data.cmd = CEC_CMD_ENABLE;
-	msg.data.val = enable;
+	data.cmd = CEC_CMD_ENABLE;
+	data.val = enable;
 
-	ret = cros_ec_cmd_xfer_status(cros_ec, &msg.msg);
+	ret = cros_ec_send_cmd_msg(cros_ec, 0, EC_CMD_CEC_SET, &data,
+				   sizeof(data), NULL, 0);
 	if (ret < 0) {
 		dev_err(cros_ec->dev,
 			"error %sabling CEC on EC: %d\n",
-- 
2.25.0.341.g760bfbb309-goog

