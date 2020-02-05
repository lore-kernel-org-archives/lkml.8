Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A6CC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 19:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A9F21741
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 19:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VOHxRvsQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbgBETKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 14:10:54 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:53384 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbgBETKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 14:10:53 -0500
Received: by mail-pj1-f67.google.com with SMTP id n96so1382054pjc.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 11:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=amr41VQ+ov/3FHdSaO7nRJdWSyyl+QIxOuaNb9WUjvA=;
        b=VOHxRvsQAhXVnRNZHh8IzoFGmySV8SxSEw4f0VrV17nl5SmT6cvxcWBdy4hf3A0HVf
         DHwtr37dnwyLSlgoUmt1jWAN6HVbpUfpwbv+SM10Cs8f+znrcuvRl41b1/aZA27MrRDG
         wckehZslNLSyQ1KKNrKbA9627/sMMJfNtMiSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=amr41VQ+ov/3FHdSaO7nRJdWSyyl+QIxOuaNb9WUjvA=;
        b=jFj8kzJdOyhh/U5IKUO01V4ZjwEBGmJxKrHZFGiIk61yt4dj69hU+O2FY5EOqineNl
         WFK+P2lHZX5tpRIoGXeCCZa8zxV/Q+7PP2+SlGGkg52izQN1PgODl5krwaseIdFQ4eXG
         Xv7Lb2ZKIiAsaXUR4ZIJzWoJbpGiv8a3fuXwif5N0xSbF38uPNHMpxsCWtW3NbOti9uc
         YcdvS8M/WXg8Urz5ak1IkCNSxoj3wxG6SwSefysoLIFMM92blLdVTXJYpR4PeT8sPMa0
         FD/g9O2Wobmy3VnBO0lZcKkH923/NoHS6GsKJpjmhEmlYSCX3EmTBAhdydTs/QiT8yJO
         4axg==
X-Gm-Message-State: APjAAAXOOOA2Heh1EZab1N2RYlUE6bNlX+cSHY5Y7Z2kZtG5GZUCxBcn
        h8JpydVBS/3iwM3ND5HBQ9UWvnEXiuM=
X-Google-Smtp-Source: APXvYqyn1JHXj6wFMEEX8gmsq2idWTb1vj/lxD4pFRbUveUwSZuOb0YBEgp6S4BaotDDWsYTViUu6A==
X-Received: by 2002:a17:902:9a8c:: with SMTP id w12mr36161333plp.149.1580929851564;
        Wed, 05 Feb 2020 11:10:51 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id u23sm257224pfm.29.2020.02.05.11.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 11:10:51 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v2 08/17] extcon: cros_ec: Use cros_ec_cmd()
Date:   Wed,  5 Feb 2020 11:00:09 -0800
Message-Id: <20200205190028.183069-9-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200205190028.183069-1-pmalani@chromium.org>
References: <20200205190028.183069-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace cros_ec_pd_command() with cros_ec_cmd() which does the same
thing, but is defined in a common location in platform/chrome and
exposed for other modules to use.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v2:
- Updated to use new function name and parameter list.

 drivers/extcon/extcon-usbc-cros-ec.c | 61 ++++------------------------
 1 file changed, 8 insertions(+), 53 deletions(-)

diff --git a/drivers/extcon/extcon-usbc-cros-ec.c b/drivers/extcon/extcon-usbc-cros-ec.c
index 5290cc2d19d953..2939cedca04798 100644
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
+	ret = cros_ec_cmd(info->ec, 0, EC_CMD_USB_PD_POWER_INFO, &req,
+			  sizeof(req), &resp, sizeof(resp), NULL);
 	if (ret < 0)
 		return ret;
 
@@ -123,9 +80,8 @@ static int cros_ec_usb_get_pd_mux_state(struct cros_ec_extcon_info *info)
 	int ret;
 
 	req.port = info->port_id;
-	ret = cros_ec_pd_command(info, EC_CMD_USB_PD_MUX_INFO, 0,
-				 &req, sizeof(req),
-				 &resp, sizeof(resp));
+	ret = cros_ec_cmd(info->ec, 0, EC_CMD_USB_PD_MUX_INFO, &req,
+			  sizeof(req), &resp, sizeof(resp), NULL);
 	if (ret < 0)
 		return ret;
 
@@ -152,9 +108,8 @@ static int cros_ec_usb_get_role(struct cros_ec_extcon_info *info,
 	pd_control.role = USB_PD_CTRL_ROLE_NO_CHANGE;
 	pd_control.mux = USB_PD_CTRL_MUX_NO_CHANGE;
 	pd_control.swap = USB_PD_CTRL_SWAP_NONE;
-	ret = cros_ec_pd_command(info, EC_CMD_USB_PD_CONTROL, 1,
-				 &pd_control, sizeof(pd_control),
-				 &resp, sizeof(resp));
+	ret = cros_ec_cmd(info->ec, 1, EC_CMD_USB_PD_CONTROL, &pd_control,
+			  sizeof(pd_control), &resp, sizeof(resp), NULL);
 	if (ret < 0)
 		return ret;
 
@@ -177,8 +132,8 @@ static int cros_ec_pd_get_num_ports(struct cros_ec_extcon_info *info)
 	struct ec_response_usb_pd_ports resp;
 	int ret;
 
-	ret = cros_ec_pd_command(info, EC_CMD_USB_PD_PORTS,
-				 0, NULL, 0, &resp, sizeof(resp));
+	ret = cros_ec_cmd(info->ec, 0, EC_CMD_USB_PD_PORTS, NULL, 0, &resp,
+			  sizeof(resp), NULL);
 	if (ret < 0)
 		return ret;
 
-- 
2.25.0.341.g760bfbb309-goog

