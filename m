Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AB7C35280
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1D5D20870
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="urEL29q1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgEGV7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 17:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgEGV7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 17:59:08 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA867C05BD0A
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 14:59:07 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l18so8243169wrn.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 14:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a7yutLiiYWk5rSLSRJ9cBBMwzNnLxXg5ORyInfs2XQk=;
        b=urEL29q1eC3xetfSsnLKR1xOzVcdDz49Esa9y+l+ff1NoiTHOTNl0Nq2311w4kqwgT
         y+KQ9Q6mc43FjfqMQgCr0lqm5xmoNhF0yi2MzLpej2sagqFiD+KkwNOfhY7cAMTN6Dnm
         FT5NE5x3n7/rXLn3XyOjfFGWGykb4lyr6Y3ZQQq8RYWDtnCqCVxis1k6pkKCoSEP0Gyc
         nLIsyEY+3ZuGinPDRXtQOWZr4Mr0EngeCDeEMrUH5NNwyCMASyZL3/ejcO2i/2lTpDvN
         B9b8yvLZ9CK5RsJhOC8vtWYe38qFKvOpCsD/CdgkK9ztnM/FHA7or8rK7qzJwxfIzgiy
         nLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a7yutLiiYWk5rSLSRJ9cBBMwzNnLxXg5ORyInfs2XQk=;
        b=aqg+MTzot5bNPxpOiblfgUNOMefXLs/Lg5Zi9E4PlWE+wHcPzFMP22P1bOrbVFzxV4
         J7LzZw+ihb7WbO8puLh8g7ByAC7s7JA1SDAYcgwtsCHKQxZNLr0TqLiJ1W7E8bx7FLnE
         SVNS4SDtJw/pVRaW4QOKsIcHJn6RAwcbxSAxhFmyLAQ2lJr3EtxZlqah7jNewvO0c9D7
         vj3EIyl+xqiW4rN7F18OKXxh26EXPSwWQeGF5/zShsoxQR7Bbsuyf3FZEehODcknVsUN
         usMX39emD4zON3cNYXp6Eq11Vu5MLjmYS2CKx9wTRfOfz3Laz9rfI4wWfaJIuk2lJ9kZ
         DikA==
X-Gm-Message-State: AGi0PuZ3pMxUKkJE6IjbiAX04iuGvb5dnxWKD4KKrCDb/eotwF9gtfWi
        oeQCX896/r8r5nSQVbR0G0AOQw==
X-Google-Smtp-Source: APiQypJwV9E32UUqInHSJ0zZOfbQz8+nCzjf65o7j2ihNjo/8ZL+ZbUb2HvFXQ+z61VMq3ZX5t8PSQ==
X-Received: by 2002:adf:ab57:: with SMTP id r23mr19309375wrc.180.1588888746316;
        Thu, 07 May 2020 14:59:06 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id z18sm9814245wrw.41.2020.05.07.14.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:59:05 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        nikolaus.voss@loewensteinmedical.de,
        andriy.shevchenko@linux.intel.com, garsilva@embeddedor.com,
        keescook@chromium.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v2] usb: typec: tps6598x: Add USB role switching logic
Date:   Thu,  7 May 2020 22:59:38 +0100
Message-Id: <20200507215938.1983363-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200507215938.1983363-1-bryan.odonoghue@linaro.org>
References: <20200507215938.1983363-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds USB role switch support to the tps6598x.

The setup to initiate or accept a data-role switch is both assumed and
currently required to be baked-into the firmware as described in TI's
document here.

Link: https://www.ti.com/lit/an/slva843a/slva843a.pdf

With this change its possible to use the USB role-switch API to detect and
notify role-switches to downstream consumers.

Tested with a ChipIdea controller on a Qualcomm MSM8939.

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
index defa651282b0..b190097c9dba 100644
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

