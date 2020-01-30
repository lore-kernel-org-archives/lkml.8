Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7993C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A383420708
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R7Sh17c5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgA3Uda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:33:30 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37406 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgA3Ud3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 15:33:29 -0500
Received: by mail-pj1-f67.google.com with SMTP id m13so1846677pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 12:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=58rFl291UmTkYlNNX01WtaXXpWSfcc8zmOGh8ZKRbkM=;
        b=R7Sh17c5xh4WlcOwY+/Tlq2HTEsei7tkNwEUEUX14GKFXGrzRh8eluUHXQRy1alX78
         kYhXxN4i8JaUajVJY9UasCqwpiL7+ZdurmgrCdA0xjcP5yyheWjd6UjF+p9lmW22Rszq
         K9dWvy2+sBViVxd2NE9tBOlEK6zN0ZaGpvwZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=58rFl291UmTkYlNNX01WtaXXpWSfcc8zmOGh8ZKRbkM=;
        b=nw/om6/Mw1SPoZzqP3DgyW1hnr+TdBz36aAsGdaV4a5ulBE/O0ATs6QiNZ5jOWTl7K
         ayaXnQ93Khr7UrPCYE0G37NIKp2OuSmKo8C1GhxRBmnnhWX5yCCKGHZ1rjBotSFJvqkc
         NhcZzmkhCecT3RSaR4c6jE7lwjEQq1pq11MaHuvi+ZpRP5kG0kgIjmf2Z1ZYCV1IXUBB
         TgNdhGd7hHbWe0SmwAKei/1cHn4thZjRS2UZK+mAVzppR1/wXrVlSoAKqhJ6vxdezpmJ
         bS93tKEGD78J9it2uGtKml9xMbFOkZzgXmt2qxnMv15ZN9XBClS1rJ70LHG23LyT4Zve
         c0CA==
X-Gm-Message-State: APjAAAV4FOYKqMfMY4B9ZB7IqZns8PuMgPtLvushhDDfStV1JORNN7B+
        0mcVimvAuJUsHEBzLisnpLdlD0aFaq0=
X-Google-Smtp-Source: APXvYqy1ZtesqJwHA+jgzlZxdmrAvLLmIWP3/8TfPofnc6FmWX0jJgnFQ6L4TMKnqUBNsCvPAIPJ3g==
X-Received: by 2002:a17:90a:a78b:: with SMTP id f11mr8177740pjq.8.1580416408858;
        Thu, 30 Jan 2020 12:33:28 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id q12sm7469321pfh.158.2020.01.30.12.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:33:28 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 05/17] platform/chrome: sensorhub: Use send_cmd_msg()
Date:   Thu, 30 Jan 2020 12:30:42 -0800
Message-Id: <20200130203106.201894-6-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200130203106.201894-1-pmalani@chromium.org>
References: <20200130203106.201894-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the register() function to use the new
cros_ec_send_cmd_msg() function instead of cros_ec_cmd_xfer_status().

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_sensorhub.c | 29 +++++++++------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_sensorhub.c b/drivers/platform/chrome/cros_ec_sensorhub.c
index 04d8879689e985..8a05e7f5a71b2d 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub.c
@@ -54,7 +54,7 @@ static int cros_ec_sensorhub_register(struct device *dev,
 	struct cros_ec_dev *ec = sensorhub->ec;
 	struct ec_params_motion_sense *params;
 	struct ec_response_motion_sense *resp;
-	struct cros_ec_command *msg;
+	void *ec_buf;
 	int ret, i, sensor_num;
 	char *name;
 
@@ -71,27 +71,23 @@ static int cros_ec_sensorhub_register(struct device *dev,
 		return -EINVAL;
 	}
 
-	/* Prepare a message to send INFO command to each sensor. */
-	msg = kzalloc(sizeof(*msg) + max(sizeof(*params), sizeof(*resp)),
-		      GFP_KERNEL);
-	if (!msg)
+	ec_buf = kzalloc(max(sizeof(*params), sizeof(*resp)), GFP_KERNEL);
+	if (!ec_buf)
 		return -ENOMEM;
 
-	msg->version = 1;
-	msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
-	msg->outsize = sizeof(*params);
-	msg->insize = sizeof(*resp);
-	params = (struct ec_params_motion_sense *)msg->data;
-	resp = (struct ec_response_motion_sense *)msg->data;
+	params = ec_buf;
+	resp = ec_buf;
 
 	for (i = 0; i < sensor_num; i++) {
 		params->cmd = MOTIONSENSE_CMD_INFO;
 		params->info.sensor_num = i;
 
-		ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
+		ret = cros_ec_send_cmd_msg(ec->ec_dev, 1,
+				EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset,
+				params, sizeof(*params), resp, sizeof(*resp));
 		if (ret < 0) {
-			dev_warn(dev, "no info for EC sensor %d : %d/%d\n",
-				 i, ret, msg->result);
+			dev_warn(dev, "no info for EC sensor %d : %d\n",
+				 i, ret);
 			continue;
 		}
 
@@ -141,11 +137,10 @@ static int cros_ec_sensorhub_register(struct device *dev,
 			goto error;
 	}
 
-	kfree(msg);
-	return 0;
+	ret =  0;
 
 error:
-	kfree(msg);
+	kfree(ec_buf);
 	return ret;
 }
 
-- 
2.25.0.341.g760bfbb309-goog

