Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF0FC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 19:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8546420730
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 19:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XVhusW/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgBETSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 14:18:32 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36289 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgBETSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 14:18:32 -0500
Received: by mail-pf1-f196.google.com with SMTP id 185so1711432pfv.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 11:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sIFpMqGTN8n/WcYKnxRJgbTze8DyNUUZFg70ZbIEoWI=;
        b=XVhusW/LvjaHg45v8IC8C/sf8nqOfxR/MgkOe7tWcZ5rqexAZOw27w9omEU3kFoUj6
         yamxpa+X3Qf/Y83drLrOSbaZi9LWIMQ/xdlM/FSgeH4NeH9nWr22UZeNxVXs4MiFQn4r
         kQBI3IEUXAtTCaW+1u8wHXwiChhvk5AEdmq+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sIFpMqGTN8n/WcYKnxRJgbTze8DyNUUZFg70ZbIEoWI=;
        b=t4V8ql3y2MgeccDCzQXDG6iAu7MR4LQVyd7KT+f7WRbzIFi0whRQu+P7+r/5NOXDTn
         2sKxJ5M5K8qXExqIMOMIoaSBIQg06UyTwubcwBXPEenmr/1z/hr2f8d5sIos10NpsYxO
         uBH3qalJeJ2mHmmm+aC3y/t+2zvc53QI76rJ4uHpHpARgd3YcnaQKcn4TOMGfxUJSFa6
         MG9C8PjKj9Az9fgSXp21vg/+u2FqeV6ZlnWFt4p26zbW0a9KaBwwcN+1Kz1a2k4fk5GA
         L9Ih4V6efAfKPRV/ERcZdwTLNCOWDtvtwzktvsBuTfOCOjMPv+v6bNQztWTmPttJ6GwM
         Nbqw==
X-Gm-Message-State: APjAAAW6KsvCB46sX78Tq/7GRBXE/esV5hp/JNO9UJP9kJOfe9rmQX0L
        xoJekCatsESL73ItO4mNyXYr4ruKwoU=
X-Google-Smtp-Source: APXvYqxPpI/egGs5VfP1lfsj8LKYY+ZuiZR7QWRXekYLGdP4+g4jIec04hsk/l1nke1QrQ2mtlwzIQ==
X-Received: by 2002:a63:7b5a:: with SMTP id k26mr16144682pgn.406.1580930310289;
        Wed, 05 Feb 2020 11:18:30 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id u23sm257224pfm.29.2020.02.05.11.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 11:18:29 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-rtc@vger.kernel.org (open list:REAL TIME CLOCK (RTC) SUBSYSTEM)
Subject: [PATCH v2 14/17] rtc: cros-ec: Use cros_ec_cmd()
Date:   Wed,  5 Feb 2020 11:00:22 -0800
Message-Id: <20200205190028.183069-15-pmalani@chromium.org>
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
message buffer setup and cleanup.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v2:
- Updated to use new function name and parameter list.

 drivers/rtc/rtc-cros-ec.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/rtc/rtc-cros-ec.c b/drivers/rtc/rtc-cros-ec.c
index f7343c289cab73..6886100ad0b8b7 100644
--- a/drivers/rtc/rtc-cros-ec.c
+++ b/drivers/rtc/rtc-cros-ec.c
@@ -33,16 +33,11 @@ static int cros_ec_rtc_get(struct cros_ec_device *cros_ec, u32 command,
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
+	ret = cros_ec_cmd(cros_ec, 0, command, NULL, 0, &data, sizeof(data),
+			  NULL);
 	if (ret < 0) {
 		dev_err(cros_ec->dev,
 			"error getting %s from EC: %d\n",
@@ -51,7 +46,7 @@ static int cros_ec_rtc_get(struct cros_ec_device *cros_ec, u32 command,
 		return ret;
 	}
 
-	*response = msg.data.time;
+	*response = data.time;
 
 	return 0;
 }
@@ -60,17 +55,11 @@ static int cros_ec_rtc_set(struct cros_ec_device *cros_ec, u32 command,
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
+	ret = cros_ec_cmd(cros_ec, 0, command, &data, sizeof(data), NULL, 0,
+			  NULL);
 	if (ret < 0) {
 		dev_err(cros_ec->dev, "error setting %s on EC: %d\n",
 			command == EC_CMD_RTC_SET_VALUE ? "time" : "alarm",
-- 
2.25.0.341.g760bfbb309-goog

