Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E7AC2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 00:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080B0215A4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 00:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iHl1nnP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbgDJAJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 20:09:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45678 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbgDJAJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 20:09:15 -0400
Received: by mail-pf1-f196.google.com with SMTP id r14so292873pfl.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 17:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=caullk2JpxyA8XTv34dW2t2SU+wbN7hf/K+rYHru9WI=;
        b=iHl1nnP78KZLVM7XkDEQnzzyLTrdec91iiBkF/C3thfsUyoYBD6vueOH3Vs88g1prh
         uN1Gqf3EHx201mJc1a7LzIORanNmFadPXs0290zk8Ovsd1oB3OvwGyIfoz3F9PCH1bCZ
         QtHOrMhlqaG8h5iJEjQQcpcY5yjRYQewc8zrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=caullk2JpxyA8XTv34dW2t2SU+wbN7hf/K+rYHru9WI=;
        b=a01DfneTGIXBd6fssJ9acAVHEzuGOxUJ2v5Ee+7GjYlJ8B3eWRqPhLjBK2HXqSCraS
         mWEKlstuD9aHlisc3XyzeF8VXBcmjaG7CIrI+f8H65RqcC662KyhAyaY9t++g3Oy5Qu8
         UXVYDqI+12De+an7phaw/5QqLuyNNl1ZUbDHGMMg1BH/Vwim1hSfWmL9zSyvnZiZbG1V
         d497T+vmqVAk6rffE6k4lK00DcHDaWh8MzmCG+myuemAGE8UV76KJYDfV0CEtDNqfswt
         zJQ1V1gBKfnX275Do/iZY+1bozhkYoByHLPYldeAuFmHrH7vTNcb6rBft//zZKWMC2Sy
         ls6Q==
X-Gm-Message-State: AGi0PuaHhqJbW8enqsJNgkPye8kWpXH50ENOOFEBOk3MoM4wJi4uOUCn
        Au5seXGiy4oMtpMMHW5+RZ33GPLhbcw=
X-Google-Smtp-Source: APiQypKoPOFXa6Wu5cbZipeNThmq9bYOmO8KXvh0BE7UzKbfFTfL94kX32Uw7fL4PUqbqGd/1kYjnA==
X-Received: by 2002:a63:af1d:: with SMTP id w29mr2039212pge.161.1586477354265;
        Thu, 09 Apr 2020 17:09:14 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id 6sm216421pgm.51.2020.04.09.17.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 17:09:13 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v2 2/3] platform/chrome: typec: Add struct for port data
Date:   Thu,  9 Apr 2020 17:08:21 -0700
Message-Id: <20200410000819.198668-3-pmalani@chromium.org>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200410000819.198668-1-pmalani@chromium.org>
References: <20200410000819.198668-1-pmalani@chromium.org>
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

Changes in v2:
- Removed unrequired devm_kfree() call.

 drivers/platform/chrome/cros_ec_typec.c | 48 ++++++++++++++++---------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index d444dd7422a2a..56ded09a60ffb 100644
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

