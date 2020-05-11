Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85EEC54E8F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 23:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FF3E20675
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 23:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MWoKMev1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgEKXTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 19:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725987AbgEKXTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 19:19:03 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536ECC05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 16:19:01 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f134so7604542wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 16:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=htWLsPXxnD3s+Ak+OsHOd4Z+bbLisHPSJDmkJfsO+9A=;
        b=MWoKMev1EAGY5CSGNDm4/jSw+i1b4/V0SZ6GGxEyoe8ve85KRM0TX9lOlHb+sfqbnp
         qlYVx8mQEN/1vuw0Qm8mtLgkS1FUhNShNpSm2VC1jxVmZlJIcTDJq+75U/nwrCPSXo1s
         yTh01AyujaFFL1ToNgCZO/gqAHTg0HsT9unfLZwzfkHBNCLOWIj23C12g0/+QAoNgPK2
         HHVM2ZcpfNPMcPZB+0lW5HwaeHFve8EQ22+RE3xIenBoObHSTB1of8073J+inwt2ZYI1
         XveanW4AWhtUjRN+ph9jAk/IUfI4/TjUN3+dvdHitIXKvI5sSR7Gs2dBuuq2Thhds1Jp
         akpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=htWLsPXxnD3s+Ak+OsHOd4Z+bbLisHPSJDmkJfsO+9A=;
        b=fqQxZM8a/wNCZnSFwYyStwNF4MrxayNnjXh4BOBYrpgzcyn3O22OCMhTXyjmD2Aqcf
         ydtNYd8dv+me6PL7pCwzXPy6j9gsRGWSY/I6RoGjXo9+gTLdvtYeETYBs5Ulv0eE3qxX
         qcYwZ5x+ZwDi87/C8mRrnrv5VqeZNl81NFxUj5G11jHJS+46c/mmeMDWKGwD5lKdMMqM
         EmT77IBCbUCzGLgpgKewcm7D5XqOIWpSZ5wMthp30ReqZWAXh4QhLn3WJ9o5F8F1zYXo
         +xe55cVIsb16I5T/D+DsF2syijY+8esnkZTIjAZFOYhCkVhbwEHMw+ek0gNZI6Et7ckQ
         vdiw==
X-Gm-Message-State: AGi0Puam7b/r7/rYAXJsnaPJJj9vPfeXTEj7+wDLmUe0/CeKjUHU2oUX
        izQA/PPCiXkULrSE/SVOzT7bfw==
X-Google-Smtp-Source: APiQypJkEvfnL3ff6hmymJTiKdHywu/T6Kx/KgGG3Oaligwi4hbo1zKKuHyNqU+zFf8l+Rn63x43yw==
X-Received: by 2002:a1c:3581:: with SMTP id c123mr23251363wma.150.1589239139895;
        Mon, 11 May 2020 16:18:59 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id t2sm29844707wmt.15.2020.05.11.16.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 16:18:59 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, bryan.odonoghue@linaro.org
Cc:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Gustavo A . R . Silva" <garsilva@embeddedor.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] usb: typec: tps6598x: Add USB role switching logic
Date:   Tue, 12 May 2020 00:19:30 +0100
Message-Id: <20200511231930.2825183-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200511231930.2825183-1-bryan.odonoghue@linaro.org>
References: <20200511231930.2825183-1-bryan.odonoghue@linaro.org>
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
 drivers/usb/typec/tps6598x.c | 57 +++++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/typec/tps6598x.c b/drivers/usb/typec/tps6598x.c
index defa651282b0..b7c9fe5caabe 100644
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
@@ -495,11 +515,22 @@ static int tps6598x_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
+	fwnode = device_get_named_child_node(&client->dev, "connector");
+	if (IS_ERR(fwnode))
+		return PTR_ERR(fwnode);
+
+	tps->role_sw = fwnode_usb_role_switch_get(fwnode);
+	if (IS_ERR(tps->role_sw)) {
+		ret = PTR_ERR(tps->role_sw);
+		goto err_fwnode_put;
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
@@ -525,12 +556,16 @@ static int tps6598x_probe(struct i2c_client *client)
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
@@ -545,12 +580,19 @@ static int tps6598x_probe(struct i2c_client *client)
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
@@ -559,6 +601,7 @@ static int tps6598x_remove(struct i2c_client *client)
 
 	tps6598x_disconnect(tps, 0);
 	typec_unregister_port(tps->port);
+	usb_role_switch_put(tps->role_sw);
 
 	return 0;
 }
-- 
2.25.1

