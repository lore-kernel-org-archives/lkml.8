Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8ACEC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8889B2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DNjZlxuW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgA3UeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:34:13 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37442 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbgA3UeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 15:34:12 -0500
Received: by mail-pj1-f67.google.com with SMTP id m13so1847366pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 12:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=poNd8Knt9iYU4WLCgt+W/hIt77GJjU6hjXWszSb6Ux0=;
        b=DNjZlxuWNQShvB5zjTDJjJvNicwKi9rnDgK69x7wLe7r15G52//uN0wdGU9MDNbwPr
         uLNs2OolqwOKVua+MGTuHHTw4MGR4Ci15Iu5Tsk5xqbkqQefEbNtzbj9dRfV+n+H3XE2
         Z/z6ggAwTRHEpcpZco9L74L9wyXGgghSzykio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=poNd8Knt9iYU4WLCgt+W/hIt77GJjU6hjXWszSb6Ux0=;
        b=BhQNZwW6waxf8+6KwnXttPJ+GaE95oGC+2mJsF2pxpyGamj+W63To0iaRga/oxB1S8
         6bbw1P9cFLqJD4KGxTkP3pR6w7XRbCChKSj0i8kzoNXEeSpYM60rWo1q/yEdB7IJNeMI
         srtVGogvD+dT9kuYW283snp6bN91iQX4yO4WpPB0xYz0STwwDszMabTWwVJMp4wUgDt4
         v0X4P7epas3zrHN+RPyNkp0Q5AriuAlPfjyObEzBd0THcvQQ+/tSsI6QvycukmTgu5mA
         uWJUuwwmcHd1zKp361CzIwBdQF0q/6ROp9Z5AmjvRQbDZC9WsZQ/tS9Ddyu3OlYQPxTK
         uFDA==
X-Gm-Message-State: APjAAAW7V8o1ougx/kxKilisnOS/hFnFA6x5/be5TY64CRWx7Hmgx2Fk
        JV8CvXuhfIi+eKGsmauwF/zg05FIz0Hl3A==
X-Google-Smtp-Source: APXvYqye5KJgxBgi3l2rxg/g1KlRyWFBGEe/VeBl118G0P+FitCf/Dws3Ig06DI/5Fv0+Rhk0h+Htg==
X-Received: by 2002:a17:902:76c5:: with SMTP id j5mr70044plt.172.1580416451708;
        Thu, 30 Jan 2020 12:34:11 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id q12sm7469321pfh.158.2020.01.30.12.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:34:11 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 08/17] extcon: cros_ec: Use cros_ec_send_cmd_msg()
Date:   Thu, 30 Jan 2020 12:30:49 -0800
Message-Id: <20200130203106.201894-9-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200130203106.201894-1-pmalani@chromium.org>
References: <20200130203106.201894-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace cros_ec_pd_command() with cros_ec_send_cmd_msg() which does the
same thing, but is defined in a common location in platform/chrome and
exposed for other modules to use.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/extcon/extcon-usbc-cros-ec.c | 62 ++++------------------------
 1 file changed, 9 insertions(+), 53 deletions(-)

diff --git a/drivers/extcon/extcon-usbc-cros-ec.c b/drivers/extcon/extcon-usbc-cros-ec.c
index 5290cc2d19d953..e42d929d3a76da 100644
--- a/drivers/extcon/extcon-usbc-cros-ec.c
+++ b/drivers/extcon/extcon-usbc-cros-ec.c
@@ -45,49 +45,6 @@ enum usb_data_roles {
 	DR_DEVICE,
 };
 
-/**
- * cros_ec_pd_command() - Send a command to the EC.
- * @info: pointer to struct cros_ec_extcon_info
- * @command: EC command
- * @version: EC command version
- * @outdata: EC command output data
- * @outsize: Size of outdata
- * @indata: EC command input data
- * @insize: Size of indata
- *
- * Return: 0 on success, <0 on failure.
- */
-static int cros_ec_pd_command(struct cros_ec_extcon_info *info,
-			      unsigned int command,
-			      unsigned int version,
-			      void *outdata,
-			      unsigned int outsize,
-			      void *indata,
-			      unsigned int insize)
-{
-	struct cros_ec_command *msg;
-	int ret;
-
-	msg = kzalloc(sizeof(*msg) + max(outsize, insize), GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
-
-	msg->version = version;
-	msg->command = command;
-	msg->outsize = outsize;
-	msg->insize = insize;
-
-	if (outsize)
-		memcpy(msg->data, outdata, outsize);
-
-	ret = cros_ec_cmd_xfer_status(info->ec, msg);
-	if (ret >= 0 && insize)
-		memcpy(indata, msg->data, insize);
-
-	kfree(msg);
-	return ret;
-}
-
 /**
  * cros_ec_usb_get_power_type() - Get power type info about PD device attached
  * to given port.
@@ -102,8 +59,8 @@ static int cros_ec_usb_get_power_type(struct cros_ec_extcon_info *info)
 	int ret;
 
 	req.port = info->port_id;
-	ret = cros_ec_pd_command(info, EC_CMD_USB_PD_POWER_INFO, 0,
-				 &req, sizeof(req), &resp, sizeof(resp));
+	ret = cros_ec_send_cmd_msg(info->ec, 0, EC_CMD_USB_PD_POWER_INFO,
+				   &req, sizeof(req), &resp, sizeof(resp));
 	if (ret < 0)
 		return ret;
 
@@ -123,9 +80,8 @@ static int cros_ec_usb_get_pd_mux_state(struct cros_ec_extcon_info *info)
 	int ret;
 
 	req.port = info->port_id;
-	ret = cros_ec_pd_command(info, EC_CMD_USB_PD_MUX_INFO, 0,
-				 &req, sizeof(req),
-				 &resp, sizeof(resp));
+	ret = cros_ec_send_cmd_msg(info->ec, 0, EC_CMD_USB_PD_MUX_INFO,
+				   &req, sizeof(req), &resp, sizeof(resp));
 	if (ret < 0)
 		return ret;
 
@@ -152,9 +108,9 @@ static int cros_ec_usb_get_role(struct cros_ec_extcon_info *info,
 	pd_control.role = USB_PD_CTRL_ROLE_NO_CHANGE;
 	pd_control.mux = USB_PD_CTRL_MUX_NO_CHANGE;
 	pd_control.swap = USB_PD_CTRL_SWAP_NONE;
-	ret = cros_ec_pd_command(info, EC_CMD_USB_PD_CONTROL, 1,
-				 &pd_control, sizeof(pd_control),
-				 &resp, sizeof(resp));
+	ret = cros_ec_send_cmd_msg(info->ec, 1, EC_CMD_USB_PD_CONTROL,
+				   &pd_control, sizeof(pd_control),
+				   &resp, sizeof(resp));
 	if (ret < 0)
 		return ret;
 
@@ -177,8 +133,8 @@ static int cros_ec_pd_get_num_ports(struct cros_ec_extcon_info *info)
 	struct ec_response_usb_pd_ports resp;
 	int ret;
 
-	ret = cros_ec_pd_command(info, EC_CMD_USB_PD_PORTS,
-				 0, NULL, 0, &resp, sizeof(resp));
+	ret = cros_ec_send_cmd_msg(info->ec, 0, EC_CMD_USB_PD_PORTS, NULL, 0,
+				   &resp, sizeof(resp));
 	if (ret < 0)
 		return ret;
 
-- 
2.25.0.341.g760bfbb309-goog

