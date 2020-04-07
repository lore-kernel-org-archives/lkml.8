Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851F4C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD4B20719
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BnoKNjaE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgDGBKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:10:22 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39415 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgDGBKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:10:22 -0400
Received: by mail-pj1-f67.google.com with SMTP id z3so26888pjr.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+SOvjcy0RIbMcS2aQbxOguDxAviW57HFKkk4ajq+vDY=;
        b=BnoKNjaEeevnKZ+QUKWbJbFOqCv3XTdV78ABf4MC/vEtevoBKJvB1FoGEkYMKKw8y/
         ruNrQc/5ouGxcXdFVjj0j00vfGAQCof3lhG4IQ8aiKqXdxX2r3K62NJloMGKNL0dzc6Q
         B7bh4F8YhIgAyxhlZ9h8TRO56gfzoYrRVC0oA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+SOvjcy0RIbMcS2aQbxOguDxAviW57HFKkk4ajq+vDY=;
        b=MfPw8OzEzmbNY0JJ/UDbZqobiKLjJ9lDFgVAlIXXGQEzVkTiw1hirVnJl1RLZiaQ5B
         yTmP/UDFM/rrim8GmOgMV4u3HrXusYqF9JfZR+CwLFsYm4ZA8J1U9fZQTawTVsCrm6YK
         YH7NH2wo1W0c4T2+LHdT2oM31/4SdPQncXe7dCADWKlYUf4mGu8AOWPIP/YenlD2is5v
         ye/eaTFq/PvqDnPoZAQ/wYC9qsTbbyfhOP0gwksqIEIKPM9aYr9qCxi9hwC2XMg5LTa2
         eOXSlFYhTjK3MoOTbCSH1OCQPaG/xPGw6HnlBhmSjBARX2Qd/fs9QDHyrks2UTg1bE6P
         vGlA==
X-Gm-Message-State: AGi0PuZCcXiKcm+qbzsqfDN8PRRyL6tqyzq4x5s+1ofKK/rWPPtnuEU+
        Qppl6Ef2hkDD4JFIUb/N8YddR0m6umo=
X-Google-Smtp-Source: APiQypK7fmSKEHFP3womyUcRkyEApyZxBSHbSj1qG0FxAftCM6mbjOac4K0IRX+7b5T4qR8cd9cjLw==
X-Received: by 2002:a17:90b:3656:: with SMTP id nh22mr2385514pjb.71.1586221820065;
        Mon, 06 Apr 2020 18:10:20 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id s27sm12086500pgn.90.2020.04.06.18.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 18:10:19 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 2/3] platform/chrome: typec: Add struct for port data
Date:   Mon,  6 Apr 2020 18:09:40 -0700
Message-Id: <20200407010940.155490-3-pmalani@chromium.org>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
In-Reply-To: <20200407010940.155490-1-pmalani@chromium.org>
References: <20200407010940.155490-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a separate struct for storing port data, including Type C connector
class struct pointers and caps.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 49 ++++++++++++++++---------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index cf7c2652a1d6d..1955e1dfebc6d 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -17,6 +17,13 @@
 
 #define DRV_NAME "cros-ec-typec"
 
+/* Per port data. */
+struct cros_typec_port {
+	struct typec_port *port;
+	/* Initial capabilities for the port. */
+	struct typec_capability caps;
+};
+
 /* Platform-specific data for the Chrome OS EC Type C controller. */
 struct cros_typec_data {
 	struct device *dev;
@@ -24,9 +31,7 @@ struct cros_typec_data {
 	int num_ports;
 	unsigned int cmd_ver;
 	/* Array of ports, indexed by port number. */
-	struct typec_port *ports[EC_USB_PD_MAX_PORTS];
-	/* Initial capabilities for each port. */
-	struct typec_capability *caps[EC_USB_PD_MAX_PORTS];
+	struct cros_typec_port *ports[EC_USB_PD_MAX_PORTS];
 	struct notifier_block nb;
 };
 
@@ -76,14 +81,26 @@ static int cros_typec_parse_port_props(struct typec_capability *cap,
 	return 0;
 }
 
+static void cros_unregister_ports(struct cros_typec_data *typec)
+{
+	int i;
+
+	for (i = 0; i < typec->num_ports; i++) {
+		if (!typec->ports[i])
+			continue;
+		typec_unregister_port(typec->ports[i]->port);
+		devm_kfree(typec->dev, typec->ports[i]);
+	}
+}
+
 static int cros_typec_init_ports(struct cros_typec_data *typec)
 {
 	struct device *dev = typec->dev;
 	struct typec_capability *cap;
 	struct fwnode_handle *fwnode;
+	struct cros_typec_port *cros_port;
 	const char *port_prop;
 	int ret;
-	int i;
 	int nports;
 	u32 port_num = 0;
 
@@ -115,22 +132,23 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 
 		dev_dbg(dev, "Registering port %d\n", port_num);
 
-		cap = devm_kzalloc(dev, sizeof(*cap), GFP_KERNEL);
-		if (!cap) {
+		cros_port = devm_kzalloc(dev, sizeof(*cros_port), GFP_KERNEL);
+		if (!cros_port) {
 			ret = -ENOMEM;
 			goto unregister_ports;
 		}
 
-		typec->caps[port_num] = cap;
+		typec->ports[port_num] = cros_port;
+		cap = &cros_port->caps;
 
 		ret = cros_typec_parse_port_props(cap, fwnode, dev);
 		if (ret < 0)
 			goto unregister_ports;
 
-		typec->ports[port_num] = typec_register_port(dev, cap);
-		if (IS_ERR(typec->ports[port_num])) {
+		cros_port->port = typec_register_port(dev, cap);
+		if (IS_ERR(cros_port->port)) {
 			dev_err(dev, "Failed to register port %d\n", port_num);
-			ret = PTR_ERR(typec->ports[port_num]);
+			ret = PTR_ERR(cros_port->port);
 			goto unregister_ports;
 		}
 	}
@@ -138,8 +156,7 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 	return 0;
 
 unregister_ports:
-	for (i = 0; i < typec->num_ports; i++)
-		typec_unregister_port(typec->ports[i]);
+	cros_unregister_ports(typec);
 	return ret;
 }
 
@@ -177,7 +194,7 @@ static int cros_typec_ec_command(struct cros_typec_data *typec,
 static void cros_typec_set_port_params_v0(struct cros_typec_data *typec,
 		int port_num, struct ec_response_usb_pd_control *resp)
 {
-	struct typec_port *port = typec->ports[port_num];
+	struct typec_port *port = typec->ports[port_num]->port;
 	enum typec_orientation polarity;
 
 	if (!resp->enabled)
@@ -194,7 +211,7 @@ static void cros_typec_set_port_params_v0(struct cros_typec_data *typec,
 static void cros_typec_set_port_params_v1(struct cros_typec_data *typec,
 		int port_num, struct ec_response_usb_pd_control_v1 *resp)
 {
-	struct typec_port *port = typec->ports[port_num];
+	struct typec_port *port = typec->ports[port_num]->port;
 	enum typec_orientation polarity;
 
 	if (!(resp->enabled & PD_CTRL_RESP_ENABLED_CONNECTED))
@@ -360,9 +377,7 @@ static int cros_typec_probe(struct platform_device *pdev)
 	return 0;
 
 unregister_ports:
-	for (i = 0; i < typec->num_ports; i++)
-		if (typec->ports[i])
-			typec_unregister_port(typec->ports[i]);
+	cros_unregister_ports(typec);
 	return ret;
 }
 
-- 
2.26.0.292.g33ef6b2f38-goog

