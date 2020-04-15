Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4BDC2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 05:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64FC420784
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 05:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZWKzb6Fr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390401AbgDOFaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 01:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728378AbgDOFaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 01:30:14 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2502CC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 22:30:14 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a13so1035835pfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 22:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IoL3T1qTxwe3puC/PKTMHXlhXR8Dk+HUJk8SlLAfRZg=;
        b=ZWKzb6FrTFVEE4Q2Wz7uP9GCEEcYq1/cJx2Yv+857QaUjXHv08Tz8fH8sWyOkU0aOC
         N7KnYFwDdhB7Tj6wYo2Uv4fr4pN2EWP4kRJscbfgkN3rm4Zd+38Y6oHCvoxVw0rqPxFi
         QRvzHEIg2dN4QOYewtz4wwEG+NoBaLv+mNuyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IoL3T1qTxwe3puC/PKTMHXlhXR8Dk+HUJk8SlLAfRZg=;
        b=JS5KTXwmDIaiN10HN3B5EiIDwTIWJw3Vwbu42+b0i6pGJNh/VkTlSoDezO+NsyQjxE
         6AO7yIF9M48F0gtCGuILYXFOsOFCHECV9yqNjPfurF5/oKgLkBGo35Di628DueQ73quz
         Vb+2kQHRWXMpAPSmSj9Y/yrRGg9I1vD2MGamyla+RAIqPYd0SVorV3oXmFf5uXvKcDJd
         N7kz4wCZbPLMbWawjALrLpFyXYOTLKDe5gRkWcVUi8yqB179yHqGtPM9ZggaEzQI0rAY
         gdWsfPzEPPoj3ERvOg4FaSezrbDcYT5B+5khCqDwtrWFoMyBp7WQu2wiydClCcIl+ZLW
         utfw==
X-Gm-Message-State: AGi0PubxzQcZBZeedjVKL3SS5LiinKVtgDR/MWmntlUvfi6kUy/0DyQy
        1O2vHk2OadNmEOopwjKk10x/a66SlJQ=
X-Google-Smtp-Source: APiQypIWNMLCDs6hWKQCO1SqSwIvIHAywvgF9/9cBLdpNtiswKbRPN6u8wdu9QuaSRASrj4fbjvxdQ==
X-Received: by 2002:a63:602:: with SMTP id 2mr25241243pgg.383.1586928613394;
        Tue, 14 Apr 2020 22:30:13 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id p1sm13314213pjr.40.2020.04.14.22.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 22:30:12 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Jon Flatley <jflat@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v4 3/3] platform/chrome: typec: Register port partner
Date:   Tue, 14 Apr 2020 22:29:43 -0700
Message-Id: <20200415052943.93009-4-pmalani@chromium.org>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200415052943.93009-1-pmalani@chromium.org>
References: <20200415052943.93009-1-pmalani@chromium.org>
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
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---

Changes in v4:
- Changed IS_ERR_OR_NULL() check to IS_ERR().

Changes in v3:
- No changes.

Changes in v2:
- Fixed error pointer return value.

 drivers/platform/chrome/cros_ec_typec.c | 48 +++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 56ded09a60ff..eda57db26f8d 100644
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
+	if (IS_ERR(port->partner)) {
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

