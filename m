Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC626C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 05:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82EE720767
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 05:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AEeBOadM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393332AbgDOFa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 01:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2393314AbgDOFaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 01:30:11 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E4EC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 22:30:10 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g6so983721pgs.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 22:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JhR9qB5vYsXWd+GMt9NiyCi67fEhYiJB7BmODnlGv3o=;
        b=AEeBOadMc6D3UpyH+FWMrvA5IqM/V9vw9yA6hrVP6WHVSsAwLntWS3NzhBwQ0ASEd1
         4NG23Ww3UP61WwTbRYznVeXE9n8SCFJxRZ9ZDkrt5PLY8TrDFpehjjYUpWRegvw9GG+D
         HDVZENCfN8QhPdyHxzAwc8u5iX8ANyWk7iD8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JhR9qB5vYsXWd+GMt9NiyCi67fEhYiJB7BmODnlGv3o=;
        b=tEtSySFyyGeDH0PlMqUbjruEcgMB0EB66cmMMA4UKOLeBW1XrfkQZ4PnSD3TzNoK9u
         kBLfzTvkzrfE3rlPwFpx2p+3dd/b+XsrZWSEGrX4ueZawOIxjafuRAY98yZG4u1sok8U
         L+iOqzR4I9v0xAjq/M7qee0r8v1iS2Ub9CXTzflkbtNtUqZ98vbctQ55yBq0Xs+E7l1W
         0IybCDcAdHpHtTIsHSs0zZyTuIt7nrfcfskHym7Qi4YdHR3dm6+vBs1r/aSYQVGv3ybM
         1tbDOtSdBqcHE0f772k0j5NBmj0IvVovJIzRYg4NL9waaSk45vD7EY1gEygXq1it3A6P
         pHYQ==
X-Gm-Message-State: AGi0PubwkNKhWsIKNpL2hea7wMpO4LYn0Y7wm+jrxlZqPfu0I28CnOvJ
        VMtbFHOHqur9Waq/Kr8qEkWf22EN3uI=
X-Google-Smtp-Source: APiQypKmon/pB2DdBaQT+NeJggG7JLM+xNHSV7BowSUwM+4oZe4/FZ4YIkBh9QcMMnzXxtarAlQfSg==
X-Received: by 2002:a63:8c4b:: with SMTP id q11mr25701069pgn.131.1586928610135;
        Tue, 14 Apr 2020 22:30:10 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id p1sm13314213pjr.40.2020.04.14.22.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 22:30:09 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v4 2/3] platform/chrome: typec: Add struct for port data
Date:   Tue, 14 Apr 2020 22:29:42 -0700
Message-Id: <20200415052943.93009-3-pmalani@chromium.org>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200415052943.93009-1-pmalani@chromium.org>
References: <20200415052943.93009-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a separate struct for storing port data, including Type C connector
class struct pointers and caps.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---

Changes in v4:
- No changes.

Changes in v3:
- No changes.

Changes in v2:
- Removed unrequired devm_kfree() call.

 drivers/platform/chrome/cros_ec_typec.c | 48 ++++++++++++++++---------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index d444dd7422a2..56ded09a60ff 100644
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
 
@@ -76,14 +81,25 @@ static int cros_typec_parse_port_props(struct typec_capability *cap,
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
 
@@ -115,22 +131,23 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 
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
@@ -138,8 +155,7 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 	return 0;
 
 unregister_ports:
-	for (i = 0; i < typec->num_ports; i++)
-		typec_unregister_port(typec->ports[i]);
+	cros_unregister_ports(typec);
 	return ret;
 }
 
@@ -177,7 +193,7 @@ static int cros_typec_ec_command(struct cros_typec_data *typec,
 static void cros_typec_set_port_params_v0(struct cros_typec_data *typec,
 		int port_num, struct ec_response_usb_pd_control *resp)
 {
-	struct typec_port *port = typec->ports[port_num];
+	struct typec_port *port = typec->ports[port_num]->port;
 	enum typec_orientation polarity;
 
 	if (!resp->enabled)
@@ -194,7 +210,7 @@ static void cros_typec_set_port_params_v0(struct cros_typec_data *typec,
 static void cros_typec_set_port_params_v1(struct cros_typec_data *typec,
 		int port_num, struct ec_response_usb_pd_control_v1 *resp)
 {
-	struct typec_port *port = typec->ports[port_num];
+	struct typec_port *port = typec->ports[port_num]->port;
 	enum typec_orientation polarity;
 
 	if (!(resp->enabled & PD_CTRL_RESP_ENABLED_CONNECTED))
@@ -358,9 +374,7 @@ static int cros_typec_probe(struct platform_device *pdev)
 	return 0;
 
 unregister_ports:
-	for (i = 0; i < typec->num_ports; i++)
-		if (typec->ports[i])
-			typec_unregister_port(typec->ports[i]);
+	cros_unregister_ports(typec);
 	return ret;
 }
 
-- 
2.26.0.110.g2183baf09c-goog

