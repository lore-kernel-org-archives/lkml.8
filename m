Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9124C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0872072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BXQpAnMQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgDGBKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:10:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45471 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgDGBKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:10:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id r14so1571pfl.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VC3SLvTdq/V2XxQBnHjlxlGQ9Dy4ljty56rsxBscTDI=;
        b=BXQpAnMQQSyCB146l8URqZ2NIcvdkaAWa8O3LXjlYJhbUiZEOIKrGfQijuUSX2YUKg
         AirN2lQ5RMnhXlgd9H17zi1z9m57+SRLkOsjphYXmyzYaRYbCTXQmwipvdNplSjRaFNZ
         PLL/cxojRiufInioI52TJKNQuyK1ff7vJ7n1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VC3SLvTdq/V2XxQBnHjlxlGQ9Dy4ljty56rsxBscTDI=;
        b=JETf0LZrmR1SOAZbSGeaRtT0jVmoZrQJGcBUjK3BXzHIM2qPz1FrmL7eUxucbvb4Vp
         QF+ktc8g+UyozquIRmbcnP0AV5e1Z1yB5jvhxhlm1r3Adnn6wteSZHGRnIX7wL6tY75c
         rDwrwbJ9mFh/z7rvFw9UHZs7w/0v7OvX2PfD9Awrf1nJFkFQ9Y1KLe6sHAHXwXBv2u9a
         xrI/98nSUznQHouQqxjmt9KCibs4O4wgUAfm9CDvaLYVqh7hlLMPXHL0sP1ohvaYm7MM
         +ibfvtNsYhzlnzyB3mcIZfzeB8WmdRumDIqmZckNdMDNGynPxrCxPuiBFFBy6Y7VuO5o
         ls1A==
X-Gm-Message-State: AGi0PuZtPaQ888UhvqvhZ811v8n/C7CNFPOftd/r0DKjjBn96UiwWw50
        gJwO0KWG0Q2O8X07Xzzdj26AYCAuxEc=
X-Google-Smtp-Source: APiQypLt1r4EN/iF/v8O5tnGt6DOgfO0Qce0u0Dn3zlL5aoDaVCfgwyGQNR+ou3+yJ7OZubxzfzg+Q==
X-Received: by 2002:a63:f50c:: with SMTP id w12mr1771730pgh.253.1586221847593;
        Mon, 06 Apr 2020 18:10:47 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id s27sm12086500pgn.90.2020.04.06.18.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 18:10:47 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Jon Flatley <jflat@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 3/3] platform/chrome: typec: Register port partner
Date:   Mon,  6 Apr 2020 18:09:42 -0700
Message-Id: <20200407010940.155490-4-pmalani@chromium.org>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
In-Reply-To: <20200407010940.155490-1-pmalani@chromium.org>
References: <20200407010940.155490-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register (and unregister) the port partner when a connect (and
disconnect) is detected.

Co-developed-by: Jon Flatley <jflat@chromium.org>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 47 +++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 1955e1dfebc6d..e7d4d6ccccca6 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -22,6 +22,9 @@ struct cros_typec_port {
 	struct typec_port *port;
 	/* Initial capabilities for the port. */
 	struct typec_capability caps;
+	struct typec_partner *partner;
+	/* Port partner PD identity info. */
+	struct usb_pd_identity p_identity;
 };
 
 /* Platform-specific data for the Chrome OS EC Type C controller. */
@@ -191,6 +194,29 @@ static int cros_typec_ec_command(struct cros_typec_data *typec,
 	return ret;
 }
 
+static int cros_typec_add_partner(struct cros_typec_data *typec, int port_num,
+				  bool pd_en)
+{
+	struct cros_typec_port *port = typec->ports[port_num];
+	struct typec_partner_desc p_desc = {
+		.usb_pd = pd_en,
+	};
+
+	/*
+	 * Fill an initial PD identity, which will then be updated with info
+	 * from the EC.
+	 */
+	p_desc.identity = &port->p_identity;
+
+	port->partner = typec_register_partner(port->port, &p_desc);
+	if (IS_ERR_OR_NULL(port->partner)) {
+		port->partner = NULL;
+		return PTR_ERR(port->partner);
+	}
+
+	return 0;
+}
+
 static void cros_typec_set_port_params_v0(struct cros_typec_data *typec,
 		int port_num, struct ec_response_usb_pd_control *resp)
 {
@@ -213,6 +239,8 @@ static void cros_typec_set_port_params_v1(struct cros_typec_data *typec,
 {
 	struct typec_port *port = typec->ports[port_num]->port;
 	enum typec_orientation polarity;
+	bool pd_en;
+	int ret;
 
 	if (!(resp->enabled & PD_CTRL_RESP_ENABLED_CONNECTED))
 		polarity = TYPEC_ORIENTATION_NONE;
@@ -227,6 +255,25 @@ static void cros_typec_set_port_params_v1(struct cros_typec_data *typec,
 			TYPEC_SOURCE : TYPEC_SINK);
 	typec_set_vconn_role(port, resp->role & PD_CTRL_RESP_ROLE_VCONN ?
 			TYPEC_SOURCE : TYPEC_SINK);
+
+	/* Register/remove partners when a connect/disconnect occurs. */
+	if (resp->enabled & PD_CTRL_RESP_ENABLED_CONNECTED) {
+		if (typec->ports[port_num]->partner)
+			return;
+
+		pd_en = resp->enabled & PD_CTRL_RESP_ENABLED_PD_CAPABLE;
+		ret = cros_typec_add_partner(typec, port_num, pd_en);
+		if (!ret)
+			dev_warn(typec->dev,
+				 "Failed to register partner on port: %d\n",
+				 port_num);
+	} else {
+		if (!typec->ports[port_num]->partner)
+			return;
+
+		typec_unregister_partner(typec->ports[port_num]->partner);
+		typec->ports[port_num]->partner = NULL;
+	}
 }
 
 static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
-- 
2.26.0.292.g33ef6b2f38-goog

