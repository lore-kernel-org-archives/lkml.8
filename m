Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947C0C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68DFD207DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xj0EqevI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgEGMpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 08:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725947AbgEGMp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 08:45:27 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81C5C05BD0B
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 05:45:25 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id v8so7426753wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 05:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pJB9m0M9ebkMwlNYW0iM/Z0atXBgx6rsTT39CBh9YJM=;
        b=Xj0EqevI1H3thAbAujeNEVv8nsErfiRg6ebkJkNN19Qav2YiK6jWrGvN520ozCgtUK
         Kj7B2oKnyjT1/A0PsNT/N3e/a2dGN0Tc0IRN2Ee7rKYzmAaW7OkvvpHqdvlguc50xSU4
         erWet4o6QonSXTO6803Il9BOSQMXbDYm1RX6xq+rRz742r04rhKs1ScYIj2N0d9XZg+G
         Inu39WHF3OiYlQuiaiSE2tTwdOue0plqD2N44r+yiQgu8kumGaywkOPwpQu8oiuv4dDP
         MsE9W9mwtx5thr2ucyePieecLRQ6bnUbH4iv66N5Vf6A0CaSjgqxjVrZt+pQqIELIaiw
         hx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pJB9m0M9ebkMwlNYW0iM/Z0atXBgx6rsTT39CBh9YJM=;
        b=BTonhOHR7Q6kMTXHRM/4B2xDLhKA2g/4kt+osnkNkAquhcsfA6KZ40snEPnTQ/P/sp
         rTi2dDRnl2rFCsl6XZIWy3eyAnSHfbQGcM745egW/dFibBtpFO8mC0i81sj/GSk8dvry
         NYGI3dXQTiRcKWWR74eJPvNmVRxV4jBeaL+3P/vJk0MIe27NDoaxofwOiYy1dE6CB21Q
         oFAkPyd52lcdIbQ8Wp9npyLLrqE/6Wymi6fQPhgfhq0cpPkIL6JFQwWTZbuDK77E/+9o
         bCizZrTX/T+mrV03gCyUiRiN7sUZW8MdVqryPlIxQQwrY+rHBrsPld8WnFZaT7FYLyhz
         6aRA==
X-Gm-Message-State: AGi0PuZDq/r0rSYZCghVAmQGKaEJ9EwA/SxhwV/nMKBvJqyUS69lk7cv
        +nA5HkX7DnoDZmRPOjI/vElV+Q==
X-Google-Smtp-Source: APiQypLYVKXHgNpSBTZXJZ4JulcivWXjREgMkQD7d/tsmwbafmM8SwaaDEqEY8yDWRipPU5oNNo+wA==
X-Received: by 2002:a05:600c:210:: with SMTP id 16mr3218901wmi.15.1588855524113;
        Thu, 07 May 2020 05:45:24 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id c17sm8034106wrn.59.2020.05.07.05.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 05:45:23 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     heikki.krogerus@linux.intel.com, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        nikolaus.voss@loewensteinmedical.de,
        andriy.shevchenko@linux.intel.com, garsilva@embeddedor.com,
        keescook@chromium.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH 1/1] usb: typec: tps6598x: Add USB role switching logic
Date:   Thu,  7 May 2020 13:45:56 +0100
Message-Id: <20200507124556.1774311-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200507124556.1774311-1-bryan.odonoghue@linaro.org>
References: <20200507124556.1774311-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds USB role switch support to the tps6598x. Validated with a
tps65986 on an arm64 system.

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Gustavo A. R. Silva <garsilva@embeddedor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/usb/typec/tps6598x.c | 56 +++++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/typec/tps6598x.c b/drivers/usb/typec/tps6598x.c
index 61c6761072c9..b323d82bbd51 100644
--- a/drivers/usb/typec/tps6598x.c
+++ b/drivers/usb/typec/tps6598x.c
@@ -12,6 +12,7 @@
 #include <linux/regmap.h>
 #include <linux/interrupt.h>
 #include <linux/usb/typec.h>
+#include <linux/usb/role.h>
 
 /* Register offsets */
 #define TPS_REG_VID			0x00
@@ -94,6 +95,7 @@ struct tps6598x {
 	struct typec_port *port;
 	struct typec_partner *partner;
 	struct usb_pd_identity partner_identity;
+	struct usb_role_switch *role_sw;
 };
 
 /*
@@ -190,6 +192,23 @@ static int tps6598x_read_partner_identity(struct tps6598x *tps)
 	return 0;
 }
 
+static void tps6598x_set_data_role(struct tps6598x *tps,
+				   enum typec_data_role role, bool connected)
+{
+	enum usb_role role_val;
+
+	if (role == TYPEC_HOST)
+		role_val = USB_ROLE_HOST;
+	else
+		role_val = USB_ROLE_DEVICE;
+
+	if (!connected)
+		role_val = USB_ROLE_NONE;
+
+	usb_role_switch_set_role(tps->role_sw, role_val);
+	typec_set_data_role(tps->port, role);
+}
+
 static int tps6598x_connect(struct tps6598x *tps, u32 status)
 {
 	struct typec_partner_desc desc;
@@ -220,7 +239,7 @@ static int tps6598x_connect(struct tps6598x *tps, u32 status)
 	typec_set_pwr_opmode(tps->port, mode);
 	typec_set_pwr_role(tps->port, TPS_STATUS_PORTROLE(status));
 	typec_set_vconn_role(tps->port, TPS_STATUS_VCONN(status));
-	typec_set_data_role(tps->port, TPS_STATUS_DATAROLE(status));
+	tps6598x_set_data_role(tps, TPS_STATUS_DATAROLE(status), true);
 
 	tps->partner = typec_register_partner(tps->port, &desc);
 	if (IS_ERR(tps->partner))
@@ -240,7 +259,7 @@ static void tps6598x_disconnect(struct tps6598x *tps, u32 status)
 	typec_set_pwr_opmode(tps->port, TYPEC_PWR_MODE_USB);
 	typec_set_pwr_role(tps->port, TPS_STATUS_PORTROLE(status));
 	typec_set_vconn_role(tps->port, TPS_STATUS_VCONN(status));
-	typec_set_data_role(tps->port, TPS_STATUS_DATAROLE(status));
+	tps6598x_set_data_role(tps, TPS_STATUS_DATAROLE(status), false);
 }
 
 static int tps6598x_exec_cmd(struct tps6598x *tps, const char *cmd,
@@ -328,7 +347,7 @@ static int tps6598x_dr_set(struct typec_port *port, enum typec_data_role role)
 		goto out_unlock;
 	}
 
-	typec_set_data_role(tps->port, role);
+	tps6598x_set_data_role(tps, role, true);
 
 out_unlock:
 	mutex_unlock(&tps->lock);
@@ -452,6 +471,7 @@ static int tps6598x_probe(struct i2c_client *client)
 {
 	struct typec_capability typec_cap = { };
 	struct tps6598x *tps;
+	struct fwnode_handle *fwnode;
 	u32 status;
 	u32 conf;
 	u32 vid;
@@ -495,11 +515,21 @@ static int tps6598x_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
+	fwnode = device_get_named_child_node(&client->dev, "connector");
+	if (!IS_ERR_OR_NULL(fwnode)) {
+		tps->role_sw = fwnode_usb_role_switch_get(fwnode);
+		if (IS_ERR(tps->role_sw)) {
+			ret = PTR_ERR(tps->role_sw);
+			goto err_fwnode_put;
+		}
+	}
+
 	typec_cap.revision = USB_TYPEC_REV_1_2;
 	typec_cap.pd_revision = 0x200;
 	typec_cap.prefer_role = TYPEC_NO_PREFERRED_ROLE;
 	typec_cap.driver_data = tps;
 	typec_cap.ops = &tps6598x_ops;
+	typec_cap.fwnode = fwnode;
 
 	switch (TPS_SYSCONF_PORTINFO(conf)) {
 	case TPS_PORTINFO_SINK_ACCESSORY:
@@ -525,12 +555,16 @@ static int tps6598x_probe(struct i2c_client *client)
 		typec_cap.data = TYPEC_PORT_DFP;
 		break;
 	default:
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err_role_put;
 	}
 
 	tps->port = typec_register_port(&client->dev, &typec_cap);
-	if (IS_ERR(tps->port))
-		return PTR_ERR(tps->port);
+	if (IS_ERR(tps->port)) {
+		ret = PTR_ERR(tps->port);
+		goto err_role_put;
+	}
+	fwnode_handle_put(fwnode);
 
 	if (status & TPS_STATUS_PLUG_PRESENT) {
 		ret = tps6598x_connect(tps, status);
@@ -545,12 +579,19 @@ static int tps6598x_probe(struct i2c_client *client)
 	if (ret) {
 		tps6598x_disconnect(tps, 0);
 		typec_unregister_port(tps->port);
-		return ret;
+		goto err_role_put;
 	}
 
 	i2c_set_clientdata(client, tps);
 
 	return 0;
+
+err_role_put:
+	usb_role_switch_put(tps->role_sw);
+err_fwnode_put:
+	fwnode_handle_put(fwnode);
+
+	return ret;
 }
 
 static int tps6598x_remove(struct i2c_client *client)
@@ -559,6 +600,7 @@ static int tps6598x_remove(struct i2c_client *client)
 
 	tps6598x_disconnect(tps, 0);
 	typec_unregister_port(tps->port);
+	usb_role_switch_put(tps->role_sw);
 
 	return 0;
 }
-- 
2.25.1

