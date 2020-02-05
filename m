Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312D8C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 21:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED31220720
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 21:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QR2/W4p4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbgBEVCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 16:02:18 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37802 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgBEVCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 16:02:17 -0500
Received: by mail-pl1-f195.google.com with SMTP id c23so1379672plz.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 13:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1GKmfOgEfc+T65S9fe0HlKXKx9NnWDi37nRmrX7afPE=;
        b=QR2/W4p4NKNy2jSR9gzQSGSMcD0j7zWf+DtEIaUAgCfeJNq5e4ohdqhIHyMO1NEX03
         YFmQFNvV0v3+qEg+Pwq7KdWGagIp+I1BcobZOgHQLkS5jRMs8WogHOstX9DRndm2Vwcw
         0fTTTixnPrBj1GQ+MtwYxLFzfP/t9FCh3V1oQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1GKmfOgEfc+T65S9fe0HlKXKx9NnWDi37nRmrX7afPE=;
        b=jymm9LHzPbPXQv6Z8Hk28GmfyNNWgCeUZKpE1Z3xuNzrSyarGDsbsBm1NiRrEn51G3
         pC5hy3nerEAp+niiQswswfZ3uQLVIzcPoJaj9uhwTOC7LxqkV+EE3o+0S2a0IKr01WCS
         +A0oHyo2IRF0rNgVBGj0vkaY/3fr6PeLk5aUPYrM4tJ4gGRBolHqfF7MV7180NN2G9T6
         pOO9NKR6zPNLYU+xtLmBsSvWJzEpF7ZBFCbsewTr6DT1kUTW9ecauOeFG+b70wHmv2u0
         kbtW3EnXzNKs2i4cStAt2MKPRN9dAtncioQAIYodANqWZwLk7Yugyb/02trw+iO7Zspj
         pluA==
X-Gm-Message-State: APjAAAW0Fyel8LubGX7jWvNW5xoQ8D2P0qrG5tOzBeuHPj7KCRU94WmG
        NTKvu6jmIAvKTPJmkMjcYn6WxtOJVS8=
X-Google-Smtp-Source: APXvYqyItlB2yXfCMAOo4ljBCXUyqu5U37x8g0ORLqtoH+jF+mmeOfpjwra/9H+MV41tU0RO7SqhCg==
X-Received: by 2002:a17:902:d711:: with SMTP id w17mr37810456ply.303.1580936535813;
        Wed, 05 Feb 2020 13:02:15 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id f8sm648797pjg.28.2020.02.05.13.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 13:02:15 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@intel.com, enric.balletbo@collabora.com,
        bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Jon Flatley <jflat@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 3/3] platform/chrome: typec: Update port info from EC
Date:   Wed,  5 Feb 2020 12:59:54 -0800
Message-Id: <20200205205954.84503-4-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200205205954.84503-1-pmalani@chromium.org>
References: <20200205205954.84503-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After registering the ports at probe, get the current port information
from EC and update the Type C connector class ports accordingly.

Co-developed-by: Jon Flatley <jflat@chromium.org>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 88 ++++++++++++++++++++++++-
 1 file changed, 87 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index b8edcfaa8a5297..f6aeba5bdc4972 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -153,6 +153,80 @@ static int cros_typec_ec_command(struct cros_typec_data *typec,
 	return ret;
 }
 
+static void cros_typec_set_port_params_v0(struct cros_typec_data *typec,
+		int port_num, struct ec_response_usb_pd_control *resp)
+{
+	struct typec_port *port = typec->ports[port_num];
+	enum typec_orientation polarity;
+
+	if (!resp->enabled)
+		polarity = TYPEC_ORIENTATION_NONE;
+	else if (!resp->polarity)
+		polarity = TYPEC_ORIENTATION_NORMAL;
+	else
+		polarity = TYPEC_ORIENTATION_REVERSE;
+
+	typec_set_pwr_role(port, resp->role ? TYPEC_SOURCE : TYPEC_SINK);
+	typec_set_orientation(port, polarity);
+}
+
+static void cros_typec_set_port_params_v1(struct cros_typec_data *typec,
+		int port_num, struct ec_response_usb_pd_control_v1 *resp)
+{
+	struct typec_port *port = typec->ports[port_num];
+	enum typec_orientation polarity;
+
+	if (!(resp->enabled & PD_CTRL_RESP_ENABLED_CONNECTED))
+		polarity = TYPEC_ORIENTATION_NONE;
+	else if (!resp->polarity)
+		polarity = TYPEC_ORIENTATION_NORMAL;
+	else
+		polarity = TYPEC_ORIENTATION_REVERSE;
+	typec_set_orientation(port, polarity);
+	typec_set_data_role(port, resp->role & PD_CTRL_RESP_ROLE_DATA ?
+			TYPEC_HOST : TYPEC_DEVICE);
+	typec_set_pwr_role(port, resp->role & PD_CTRL_RESP_ROLE_POWER ?
+			TYPEC_SOURCE : TYPEC_SINK);
+	typec_set_vconn_role(port, resp->role & PD_CTRL_RESP_ROLE_VCONN ?
+			TYPEC_SOURCE : TYPEC_SINK);
+}
+
+static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
+{
+	struct ec_params_usb_pd_control req;
+	struct ec_response_usb_pd_control_v1 resp;
+	int ret;
+
+	if (port_num < 0 || port_num >= typec->num_ports) {
+		dev_err(typec->dev, "cannot get status for invalid port %d\n",
+			port_num);
+		return -EINVAL;
+	}
+
+	req.port = port_num;
+	req.role = USB_PD_CTRL_ROLE_NO_CHANGE;
+	req.mux = USB_PD_CTRL_MUX_NO_CHANGE;
+	req.swap = USB_PD_CTRL_SWAP_NONE;
+
+	ret = cros_typec_ec_command(typec, typec->cmd_ver,
+				    EC_CMD_USB_PD_CONTROL, &req, sizeof(req),
+				    &resp, sizeof(resp));
+	if (ret < 0)
+		return ret;
+
+	dev_dbg(typec->dev, "Enabled %d: 0x%hhx\n", port_num, resp.enabled);
+	dev_dbg(typec->dev, "Role %d: 0x%hhx\n", port_num, resp.role);
+	dev_dbg(typec->dev, "Polarity %d: 0x%hhx\n", port_num, resp.polarity);
+	dev_dbg(typec->dev, "State %d: %s\n", port_num, resp.state);
+
+	if (typec->cmd_ver == 1)
+		cros_typec_set_port_params_v1(typec, port_num, &resp);
+	else
+		cros_typec_set_port_params_v0(typec, port_num,
+			(struct ec_response_usb_pd_control *) &resp);
+
+	return 0;
+}
 
 static int cros_typec_get_num_ports(struct cros_typec_data *typec)
 {
@@ -219,7 +293,7 @@ static int cros_typec_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct cros_typec_data *typec;
-	int ret;
+	int ret, i;
 
 	typec = devm_kzalloc(dev, sizeof(*typec), GFP_KERNEL);
 	if (!typec)
@@ -242,7 +316,19 @@ static int cros_typec_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	for (i = 0; i < typec->num_ports; i++) {
+		ret = cros_typec_port_update(typec, i);
+		if (ret < 0)
+			goto unregister_ports;
+	}
+
 	return 0;
+
+unregister_ports:
+	for (i = 0; i < typec->num_ports; i++)
+		if (typec->ports[i])
+			typec_unregister_port(typec->ports[i]);
+	return ret;
 }
 
 static struct platform_driver cros_typec_driver = {
-- 
2.25.0.341.g760bfbb309-goog

