Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEE4C2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 00:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025FD2074F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 00:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bacjUqhe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgDJAX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 20:23:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41910 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgDJAX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 20:23:58 -0400
Received: by mail-pl1-f193.google.com with SMTP id d24so112397pll.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 17:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PekQpdTe53YZ6bCaVqpLuHo7JzQt1TrNwrfQ4KAKyNA=;
        b=bacjUqheJ3umSKUu0DdQ4fVfBxjytDM4j7lCNsEOW+yjjmifeEfD6uUAxgeiqs/NwN
         QM5LbOGx3txnD+IEqQrUcalkze+ncpEGbkytfn7R0Pfe+Jl1o72h9/0ppfTdPNwU5WMD
         CS2YyLU3VTGBZekhJ496gftsnsOn50g6akEnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PekQpdTe53YZ6bCaVqpLuHo7JzQt1TrNwrfQ4KAKyNA=;
        b=uie7oZv/i9bA4lJAofRVntwa3NUNNUihkH1Gwji813ANROom6nwwRkW8f5hZleU381
         LOReEgf0CMdoQlU94nTSOYdnpL4xRwCRCZVBaTBkNmZ6ZNmiNvI373QkZuVZ2Zo8BvKE
         xkv9ddiCnF2f04VXmJX67Qq+c2AwKvvbTn2xGc7CBNa6+TJ/D6nCFy755oSV4TVOGm0+
         eE6L525Z622rQw+UMapZqc3rtDEp8BmnlEIxEkOBv5qb4RAU3UE12Zqm+AJDaBWs5pPz
         OK8zX7wPgLvEf5I/ZmvpG7D0Ovt8Biq+yEFnciSXPniHy7TXUPqwu2xZ4fxXp6+uoC3V
         27fw==
X-Gm-Message-State: AGi0PuaU1q0KcJAForlXGE5cpGbxPaSRurU+G/Rj4vzf+0Abe/yCz9Lv
        wKQihjbQuy60eIl0ZlBvV9hYD3/22aw=
X-Google-Smtp-Source: APiQypKuGIyNn9NGmFpts+IaDPVMaDa+A+p3blnsS3xpj4QYzWuH3YcCydqX1gv15tgQw+MUoQr16g==
X-Received: by 2002:a17:902:aa88:: with SMTP id d8mr2144177plr.201.1586478235999;
        Thu, 09 Apr 2020 17:23:55 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id z7sm286952pju.37.2020.04.09.17.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 17:23:55 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Jon Flatley <jflat@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v3 3/3] platform/chrome: typec: Register port partner
Date:   Thu,  9 Apr 2020 17:23:17 -0700
Message-Id: <20200410002316.202107-4-pmalani@chromium.org>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200410002316.202107-1-pmalani@chromium.org>
References: <20200410002316.202107-1-pmalani@chromium.org>
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

Changes in v3:
- No changes.

Changes in v2:
- Fixed error pointer return value.

 drivers/platform/chrome/cros_ec_typec.c | 48 +++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 56ded09a60ffb..304e0b20f279b 100644
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
@@ -190,6 +193,30 @@ static int cros_typec_ec_command(struct cros_typec_data *typec,
 	return ret;
 }
 
+static int cros_typec_add_partner(struct cros_typec_data *typec, int port_num,
+				  bool pd_en)
+{
+	struct cros_typec_port *port = typec->ports[port_num];
+	struct typec_partner_desc p_desc = {
+		.usb_pd = pd_en,
+	};
+	int ret = 0;
+
+	/*
+	 * Fill an initial PD identity, which will then be updated with info
+	 * from the EC.
+	 */
+	p_desc.identity = &port->p_identity;
+
+	port->partner = typec_register_partner(port->port, &p_desc);
+	if (IS_ERR_OR_NULL(port->partner)) {
+		ret = PTR_ERR(port->partner);
+		port->partner = NULL;
+	}
+
+	return ret;
+}
+
 static void cros_typec_set_port_params_v0(struct cros_typec_data *typec,
 		int port_num, struct ec_response_usb_pd_control *resp)
 {
@@ -212,6 +239,8 @@ static void cros_typec_set_port_params_v1(struct cros_typec_data *typec,
 {
 	struct typec_port *port = typec->ports[port_num]->port;
 	enum typec_orientation polarity;
+	bool pd_en;
+	int ret;
 
 	if (!(resp->enabled & PD_CTRL_RESP_ENABLED_CONNECTED))
 		polarity = TYPEC_ORIENTATION_NONE;
@@ -226,6 +255,25 @@ static void cros_typec_set_port_params_v1(struct cros_typec_data *typec,
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
2.26.0.110.g2183baf09c-goog

