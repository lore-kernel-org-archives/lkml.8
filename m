Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6FBC35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3160320708
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ulucti+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgA3Ufp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:35:45 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42252 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbgA3Ufp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 15:35:45 -0500
Received: by mail-pl1-f195.google.com with SMTP id p9so1779693plk.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 12:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ldqIZ6sPhq//haR6JhuLeaz+UARJkR4FJ67lvvC/A2Y=;
        b=Ulucti+2qvuFC3vI4rNTAN/cJDWhE7oBYsz4wXAMUl1LItbzBv7fsrsGX97hK4cjlP
         jYF7i3PPDJGArgokJjNswcH0qJr1MP1VmFGswBvgu5ET7ZVobicNE6+rqyDjlpc/KnO6
         VEcuNXxY6M2OFVJIOY5pgCc8dPZuLRjEAd1Pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ldqIZ6sPhq//haR6JhuLeaz+UARJkR4FJ67lvvC/A2Y=;
        b=WD51yDBmsVlP0ggp3bbcgLtzPOIMeZjraW6sTW/D8VdAwiBvMtXa+g9yoEyfC56zLz
         K2bjqDTyNueAH4RAIi+FT6pudY7FL3Nqqbt+RZXEjASwDdGs2N3+dhlbalDJm6CbLk9M
         o9MIOUmoar4VPfbpaClb8gXQ64aUQM7T1Womq4gsiweXcW/qzHa64+UX5G1tRM/PciG4
         eHI3RRnpRQDhPpJJB5PyFvAPaE55MPhL7cf3yzvJJBpFz9Ol3uomKvbiKXleROYqiVfh
         1nMpen1QI4ntiZb25LVLA8yvUaUzbszyGCAroVUQcFS95WSjGamhLQeTILu1d+VZ0Gx9
         7PqQ==
X-Gm-Message-State: APjAAAXx4IGQz9hfUrOt+5Cway5BYYpztPqqH9eh8DAPRqtfYCXahXnK
        w0LWMy0uJRbe8y8DEu/lMqGUXWo/Du8LsA==
X-Google-Smtp-Source: APXvYqzsUims1gTPplV0R4QmmovDkeLvsAFQ+78ErasQirqavgYKt4DVmq4UrEpBdDxO7aO/jwEGgQ==
X-Received: by 2002:a17:90b:3109:: with SMTP id gc9mr8021528pjb.30.1580416544193;
        Thu, 30 Jan 2020 12:35:44 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id q12sm7469321pfh.158.2020.01.30.12.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:35:43 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-rtc@vger.kernel.org (open list:REAL TIME CLOCK (RTC) SUBSYSTEM)
Subject: [PATCH 14/17] rtc: cros-ec: Use cros_ec_send_cmd_msg()
Date:   Thu, 30 Jan 2020 12:31:03 -0800
Message-Id: <20200130203106.201894-15-pmalani@chromium.org>
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
the message buffer setup and cleanup.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/rtc/rtc-cros-ec.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/rtc/rtc-cros-ec.c b/drivers/rtc/rtc-cros-ec.c
index d043d30f05bc1d..113638a82e2c0c 100644
--- a/drivers/rtc/rtc-cros-ec.c
+++ b/drivers/rtc/rtc-cros-ec.c
@@ -34,16 +34,11 @@ static int cros_ec_rtc_get(struct cros_ec_device *cros_ec, u32 command,
 			   u32 *response)
 {
 	int ret;
-	struct {
-		struct cros_ec_command msg;
-		struct ec_response_rtc data;
-	} __packed msg;
 
-	memset(&msg, 0, sizeof(msg));
-	msg.msg.command = command;
-	msg.msg.insize = sizeof(msg.data);
+	struct ec_response_rtc data = {0};
 
-	ret = cros_ec_cmd_xfer_status(cros_ec, &msg.msg);
+	ret = cros_ec_send_cmd_msg(cros_ec, 0, command, NULL, 0,
+				   &data, sizeof(data));
 	if (ret < 0) {
 		dev_err(cros_ec->dev,
 			"error getting %s from EC: %d\n",
@@ -52,7 +47,7 @@ static int cros_ec_rtc_get(struct cros_ec_device *cros_ec, u32 command,
 		return ret;
 	}
 
-	*response = msg.data.time;
+	*response = data.time;
 
 	return 0;
 }
@@ -61,17 +56,11 @@ static int cros_ec_rtc_set(struct cros_ec_device *cros_ec, u32 command,
 			   u32 param)
 {
 	int ret = 0;
-	struct {
-		struct cros_ec_command msg;
-		struct ec_response_rtc data;
-	} __packed msg;
+	struct ec_response_rtc  data;
 
-	memset(&msg, 0, sizeof(msg));
-	msg.msg.command = command;
-	msg.msg.outsize = sizeof(msg.data);
-	msg.data.time = param;
-
-	ret = cros_ec_cmd_xfer_status(cros_ec, &msg.msg);
+	data.time = param;
+	ret = cros_ec_send_cmd_msg(cros_ec, 0, command, &data, sizeof(data),
+				   NULL, 0);
 	if (ret < 0) {
 		dev_err(cros_ec->dev, "error setting %s on EC: %d\n",
 			command == EC_CMD_RTC_SET_VALUE ? "time" : "alarm",
-- 
2.25.0.341.g760bfbb309-goog

