Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E096C7619D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 00:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46AF92465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 00:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vr6Q6uK0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbgBTAhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 19:37:12 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44885 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbgBTAhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 19:37:09 -0500
Received: by mail-pl1-f194.google.com with SMTP id d9so798861plo.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 16:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pLE4I3o8jdwDvZKVU55StRKqxAvQ7TlkptivTca4Ny4=;
        b=Vr6Q6uK0kl5NcofH4ISt9CiKdHe7ophokugjLDVEsbzHItf0SRuPltxv2eNshnaFnX
         tzXWw7G7ZPeV48mFn3GKA+YCgJpWxuBx0a0ItFomklLbv9foIetJ5LQ9uxRnm71oZxMM
         3JPQNn4MzoiKGpng/VXK89odXM9H0BOgHZXHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pLE4I3o8jdwDvZKVU55StRKqxAvQ7TlkptivTca4Ny4=;
        b=Kij09HRwvoyuU6Ys516qSTQqEeBfZvDVlt7NudK7xRzA29V0tIJvU9hf7UQXJy3bIG
         IIySNNJgrAStBcBXIOsfz+tl94LyV+AOGMrAcv+czJ8cfvKqrQpQQzORuECL04NdrBnJ
         Z/ntjESGlh8aHoZOM7YcgSwjPwAWCi5UPrNEB8lqN0+iPWgUe3pwCvYUnQbljmkkTchx
         6aayjnvBjUNfdXS4wk9jLc2ayhhV2/3Tqx+Qu5DY6ZODPNnPP65yOHiQHEaB3pmAKpnE
         2Jr2Zq8quGfQ9gOjndm4QlorP1bDeyoR9zny2pG2Pfb0sRWMC0XWLs3J5KUqm9sbeswu
         pN9w==
X-Gm-Message-State: APjAAAXi1vAQ9pNHb/FvORvpIYPkTbBvIEzOmqZhBoSTQKsaAD9bJ5fX
        sWXo52DCblLKNbmrAUw4gr+tEPbOV5c=
X-Google-Smtp-Source: APXvYqwaEmiwYs193DX5Hllk0uSWLf8xyMKiFwgGAeMwRH5GmXZrxWaaubXFUZQDM/BtqGFUQfRq5A==
X-Received: by 2002:a17:90a:da03:: with SMTP id e3mr419652pjv.57.1582159026908;
        Wed, 19 Feb 2020 16:37:06 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id g24sm788773pfk.92.2020.02.19.16.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 16:37:06 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@intel.com, enric.balletbo@collabora.com,
        bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Jon Flatley <jflat@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v3 4/4] platform/chrome: typec: Update port info from EC
Date:   Wed, 19 Feb 2020 16:36:32 -0800
Message-Id: <20200220003631.206078-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200220003631.206078-1-pmalani@chromium.org>
References: <20200220003631.206078-1-pmalani@chromium.org>
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

Changes in v3:
- No changes.

Changes in v2:
- No changes.

 drivers/platform/chrome/cros_ec_typec.c | 89 ++++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 5e025c3442bed1..eebe526155a9c3 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -155,6 +155,81 @@ static int cros_typec_ec_command(struct cros_typec_data *typec,
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
+
 static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
 {
 	struct ec_params_get_cmd_versions_v1 req_v1;
@@ -201,7 +276,7 @@ static int cros_typec_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct cros_typec_data *typec;
 	struct ec_response_usb_pd_ports resp;
-	int ret;
+	int ret, i;
 
 	typec = devm_kzalloc(dev, sizeof(*typec), GFP_KERNEL);
 	if (!typec)
@@ -234,7 +309,19 @@ static int cros_typec_probe(struct platform_device *pdev)
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
2.25.0.265.gbab2e86ba0-goog

