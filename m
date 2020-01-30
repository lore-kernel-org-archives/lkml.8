Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93157C35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680ED20708
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NCYs16Ob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgA3UfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:35:19 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35394 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbgA3UfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 15:35:19 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so1793571plt.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 12:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K8xpZJk5r8LvK8SEB8UDnXhxydNJQH92r9shiRyDh0U=;
        b=NCYs16ObyUpU5CF6U1vX5Du9Q5jLIvalbfLqCjxUztyNQPzGehPqj9VpiAAmfTsiNx
         dqKimQohqH5cxx+cG3WtqLGLF5lS6/C8bmuwQltO/wVFZappP41B6WGgiQQue7TszP7C
         0y9sYnu9JcpnjXLC90RbyEno5neX/E8Fq000U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K8xpZJk5r8LvK8SEB8UDnXhxydNJQH92r9shiRyDh0U=;
        b=mcBhgI7y0mgaqCczOUf1CA5XtVSVi278nBoiGOwrjVqIXxTYB3fWfloGniDzxOIZs4
         3WcwSeDE5fduxOfFk2AG7u9QPgyytdshivLlQ0o1Ih8fG4tHTA3PdKXvWhlIwUbj6CR2
         jF1tcDo1mIsA1NHak+yD0p1kZBB7aYyK9VtXFJ97Bzo9Gp4U8WeIAH93LHd0sQzTGBHY
         Wbfzo5XwCzZyvHFohtEj4PkX8QUSwtVSlhdPyZKUzNcg7TqIpZi2wF5hewwrUdBV/Fdt
         P/aUjdS+VGz9N74xhCm7tUUghBYisZgOJARDYWJtd/xvaLa0K72CJV4bvM8Z7fnUx7/A
         qI1g==
X-Gm-Message-State: APjAAAU6/qDP1yW9QfBC+zQfvxNnQ5K0Bu93o999q64F5E5kDAY+3jYC
        AgfmetkdUFcQdLNGABlczOx6hqVp/FfGFg==
X-Google-Smtp-Source: APXvYqysCKebpesFDRwT37HHcsQnFbdT9N00zImxHSZYYAj2LAMZDF+V94LnOugKJ3R03+Fz+cVEKQ==
X-Received: by 2002:a17:90a:ba98:: with SMTP id t24mr8115381pjr.12.1580416517735;
        Thu, 30 Jan 2020 12:35:17 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id q12sm7469321pfh.158.2020.01.30.12.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:35:17 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and
        DRIVERS)
Subject: [PATCH 12/17] power: supply: cros: Use cros_ec_send_cmd_msg()
Date:   Thu, 30 Jan 2020 12:30:59 -0800
Message-Id: <20200130203106.201894-13-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200130203106.201894-1-pmalani@chromium.org>
References: <20200130203106.201894-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace cros_usbpd_charger_ec_command() with cros_ec_send_cmd_msg()
which does the same thing, but is defined in a common location in
platform/chrome and exposed for other modules to use. This allows us to
remove cros_usbpd_charger_ec_command() entirely.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/power/supply/cros_usbpd-charger.c | 63 ++++++-----------------
 1 file changed, 15 insertions(+), 48 deletions(-)

diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
index ffad9ee03a6858..cacaca5737a6ee 100644
--- a/drivers/power/supply/cros_usbpd-charger.c
+++ b/drivers/power/supply/cros_usbpd-charger.c
@@ -92,46 +92,14 @@ static bool cros_usbpd_charger_port_is_dedicated(struct port_data *port)
 	return port->port_number >= port->charger->num_usbpd_ports;
 }
 
-static int cros_usbpd_charger_ec_command(struct charger_data *charger,
-					 unsigned int version,
-					 unsigned int command,
-					 void *outdata,
-					 unsigned int outsize,
-					 void *indata,
-					 unsigned int insize)
-{
-	struct cros_ec_dev *ec_dev = charger->ec_dev;
-	struct cros_ec_command *msg;
-	int ret;
-
-	msg = kzalloc(sizeof(*msg) + max(outsize, insize), GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
-
-	msg->version = version;
-	msg->command = ec_dev->cmd_offset + command;
-	msg->outsize = outsize;
-	msg->insize = insize;
-
-	if (outsize)
-		memcpy(msg->data, outdata, outsize);
-
-	ret = cros_ec_cmd_xfer_status(charger->ec_device, msg);
-	if (ret >= 0 && insize)
-		memcpy(indata, msg->data, insize);
-
-	kfree(msg);
-	return ret;
-}
-
 static int cros_usbpd_charger_get_num_ports(struct charger_data *charger)
 {
 	struct ec_response_charge_port_count resp;
 	int ret;
 
-	ret = cros_usbpd_charger_ec_command(charger, 0,
-					    EC_CMD_CHARGE_PORT_COUNT,
-					    NULL, 0, &resp, sizeof(resp));
+	ret = cros_ec_send_cmd_msg(charger->ec_device, 0,
+				   EC_CMD_CHARGE_PORT_COUNT,
+				   NULL, 0, &resp, sizeof(resp));
 	if (ret < 0)
 		return ret;
 
@@ -143,8 +111,8 @@ static int cros_usbpd_charger_get_usbpd_num_ports(struct charger_data *charger)
 	struct ec_response_usb_pd_ports resp;
 	int ret;
 
-	ret = cros_usbpd_charger_ec_command(charger, 0, EC_CMD_USB_PD_PORTS,
-					    NULL, 0, &resp, sizeof(resp));
+	ret = cros_ec_send_cmd_msg(charger->ec_device, 0, EC_CMD_USB_PD_PORTS,
+				   NULL, 0, &resp, sizeof(resp));
 	if (ret < 0)
 		return ret;
 
@@ -160,10 +128,9 @@ static int cros_usbpd_charger_get_discovery_info(struct port_data *port)
 
 	req.port = port->port_number;
 
-	ret = cros_usbpd_charger_ec_command(charger, 0,
-					    EC_CMD_USB_PD_DISCOVERY,
-					    &req, sizeof(req),
-					    &resp, sizeof(resp));
+	ret = cros_ec_send_cmd_msg(charger->ec_device, 0,
+				   EC_CMD_USB_PD_DISCOVERY, &req, sizeof(req),
+				   &resp, sizeof(resp));
 	if (ret < 0) {
 		dev_err(charger->dev,
 			"Unable to query discovery info (err:0x%x)\n", ret);
@@ -190,10 +157,10 @@ static int cros_usbpd_charger_get_power_info(struct port_data *port)
 	int ret;
 
 	req.port = port->port_number;
-	ret = cros_usbpd_charger_ec_command(charger, 0,
-					    EC_CMD_USB_PD_POWER_INFO,
-					    &req, sizeof(req),
-					    &resp, sizeof(resp));
+	ret = cros_ec_send_cmd_msg(charger->ec_device, 0,
+				   EC_CMD_USB_PD_POWER_INFO,
+				   &req, sizeof(req),
+				   &resp, sizeof(resp));
 	if (ret < 0) {
 		dev_err(dev, "Unable to query PD power info (err:0x%x)\n", ret);
 		return ret;
@@ -335,9 +302,9 @@ static int cros_usbpd_charger_set_ext_power_limit(struct charger_data *charger,
 	req.current_lim = current_lim;
 	req.voltage_lim = voltage_lim;
 
-	ret = cros_usbpd_charger_ec_command(charger, 0,
-					    EC_CMD_EXTERNAL_POWER_LIMIT,
-					    &req, sizeof(req), NULL, 0);
+	ret = cros_ec_send_cmd_msg(charger->ec_device, 0,
+				   EC_CMD_EXTERNAL_POWER_LIMIT,
+				   &req, sizeof(req), NULL, 0);
 	if (ret < 0)
 		dev_err(charger->dev,
 			"Unable to set the 'External Power Limit': %d\n", ret);
-- 
2.25.0.341.g760bfbb309-goog

