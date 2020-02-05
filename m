Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F94C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 19:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E5E217BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 19:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CO4CrP+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgBETT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 14:19:57 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43118 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgBETT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 14:19:57 -0500
Received: by mail-pf1-f196.google.com with SMTP id s1so1698031pfh.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 11:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3kaWiVgCUzHQzm8XNSi+4KOVQd2YyqHUv1usmw/72LM=;
        b=CO4CrP+PQwUxailENkBM1kFSgtk0eKkblQlMdzpIQpAFOVTyZbdF3Vqhlw5sqfA9uM
         J/kEf5KKjzE/Q9McYWqw0RvFuSjEB1dRusTICnXxfSt83mlxxpZDjRr5WwKa1dPQAHPJ
         g2RAa0Yj+zQdyRFFYfGHQ42PFCp7MHOcYFGec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3kaWiVgCUzHQzm8XNSi+4KOVQd2YyqHUv1usmw/72LM=;
        b=JtZdMfezpUhRd2BY7lOshKqwKgDoasm72zs/cxMDvlB/0OG80rCOJbo1TUSvsUBraJ
         bij6bzIYBIjbh60K6d9XJylHsQAiT3RYfAYWNGmQQORQfLsFDygSAy4Aj5Vm6ZgPnOyG
         R/RjplCu+uf3bSW8oLfVsA4kWyekOkdmzZaiXJGG8dY0b0YhT2yaLU2JcSh+2WWi2Im4
         NrJSBo2QrOVfqIybDlNwTR905ph2IBglbXsvnSVBQEEdGFWMC/vsOouIT9U0tQqnYQ1N
         957a7uL2QuptoEES4y0ln0UJuFKORNH9yUZNgYmwl72AYZxUY1V+TMLPYLm6GoWSE57I
         x2HA==
X-Gm-Message-State: APjAAAV7+csRwIIYo5Nhipbc3GdsQAHBfRiVAyTvC9Ov1uIf/KbHzGRI
        iObk6GO3JVQidOMwiDsAWrjYcp31+sw=
X-Google-Smtp-Source: APXvYqw1egACkYs16SkZQ0SvN+AIzw2ZfFe0dA8G3jL2rE8nn48PZ/IdUGPcyCH9RHSxGF6Vb7C1aQ==
X-Received: by 2002:a63:3487:: with SMTP id b129mr38154712pga.320.1580930395429;
        Wed, 05 Feb 2020 11:19:55 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id u23sm257224pfm.29.2020.02.05.11.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 11:19:54 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        kbuild test robot <lkp@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-media@vger.kernel.org (open list:MEDIA INPUT INFRASTRUCTURE
        (V4L/DVB))
Subject: [PATCH v2 15/17] media: cros-ec-cec: Use cros_ec_cmd()
Date:   Wed,  5 Feb 2020 11:00:24 -0800
Message-Id: <20200205190028.183069-16-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200205190028.183069-1-pmalani@chromium.org>
References: <20200205190028.183069-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace cros_ec_cmd_xfer_status() with cros_ec_cmd() which does the
message buffer setup and cleanup, but is located in platform/chrome
and used by other drivers.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
Reported-by: kbuild test robot <lkp@intel.com>
---

Changes in v2:
- Updated to use new function name and parameter list.
- Used C99 element setting to initialize struct.

 .../media/platform/cros-ec-cec/cros-ec-cec.c  | 45 +++++++------------
 1 file changed, 16 insertions(+), 29 deletions(-)

diff --git a/drivers/media/platform/cros-ec-cec/cros-ec-cec.c b/drivers/media/platform/cros-ec-cec/cros-ec-cec.c
index 0e7e2772f08f96..a462af1c9ae04b 100644
--- a/drivers/media/platform/cros-ec-cec/cros-ec-cec.c
+++ b/drivers/media/platform/cros-ec-cec/cros-ec-cec.c
@@ -93,18 +93,14 @@ static int cros_ec_cec_set_log_addr(struct cec_adapter *adap, u8 logical_addr)
 {
 	struct cros_ec_cec *cros_ec_cec = adap->priv;
 	struct cros_ec_device *cros_ec = cros_ec_cec->cros_ec;
-	struct {
-		struct cros_ec_command msg;
-		struct ec_params_cec_set data;
-	} __packed msg = {};
+	struct ec_params_cec_set data = {
+		.cmd = CEC_CMD_LOGICAL_ADDRESS,
+		.val = logical_addr,
+	};
 	int ret;
 
-	msg.msg.command = EC_CMD_CEC_SET;
-	msg.msg.outsize = sizeof(msg.data);
-	msg.data.cmd = CEC_CMD_LOGICAL_ADDRESS;
-	msg.data.val = logical_addr;
-
-	ret = cros_ec_cmd_xfer_status(cros_ec, &msg.msg);
+	ret = cros_ec_cmd(cros_ec, 0, EC_CMD_CEC_SET, &data, sizeof(data),
+			  NULL, 0, NULL);
 	if (ret < 0) {
 		dev_err(cros_ec->dev,
 			"error setting CEC logical address on EC: %d\n", ret);
@@ -119,17 +115,12 @@ static int cros_ec_cec_transmit(struct cec_adapter *adap, u8 attempts,
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
-	msg.msg.outsize = cec_msg->len;
-	memcpy(msg.data.msg, cec_msg->msg, cec_msg->len);
-
-	ret = cros_ec_cmd_xfer_status(cros_ec, &msg.msg);
+	memcpy(data.msg, cec_msg->msg, cec_msg->len);
+	ret = cros_ec_cmd(cros_ec, 0, EC_CMD_CEC_WRITE_MSG, &data,
+			  sizeof(cec_msg->len), NULL, 0, NULL);
 	if (ret < 0) {
 		dev_err(cros_ec->dev,
 			"error writing CEC msg on EC: %d\n", ret);
@@ -143,18 +134,14 @@ static int cros_ec_cec_adap_enable(struct cec_adapter *adap, bool enable)
 {
 	struct cros_ec_cec *cros_ec_cec = adap->priv;
 	struct cros_ec_device *cros_ec = cros_ec_cec->cros_ec;
-	struct {
-		struct cros_ec_command msg;
-		struct ec_params_cec_set data;
-	} __packed msg = {};
+	struct ec_params_cec_set data = {
+		.cmd = CEC_CMD_ENABLE,
+		.val = enable,
+	};
 	int ret;
 
-	msg.msg.command = EC_CMD_CEC_SET;
-	msg.msg.outsize = sizeof(msg.data);
-	msg.data.cmd = CEC_CMD_ENABLE;
-	msg.data.val = enable;
-
-	ret = cros_ec_cmd_xfer_status(cros_ec, &msg.msg);
+	ret = cros_ec_cmd(cros_ec, 0, EC_CMD_CEC_SET, &data, sizeof(data),
+			  NULL, 0, NULL);
 	if (ret < 0) {
 		dev_err(cros_ec->dev,
 			"error %sabling CEC on EC: %d\n",
-- 
2.25.0.341.g760bfbb309-goog

