Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67869C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 09:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A31720674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 09:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZZu+PFl1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbgCPJBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 05:01:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37704 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730206AbgCPJB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 05:01:29 -0400
Received: by mail-pf1-f194.google.com with SMTP id 3so1714026pff.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 02:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9T6PSykNJnlF/av8JBWrr1nuinRnZqLCQ+xbxw+WMEE=;
        b=ZZu+PFl1mK9qU0P10CGl39H/rTRtxfeAr69Oq7NhOErRr8GmV425Z3sIEckIpKp6Np
         GnGGbMluwcdzkNukeau3Sm+e3u/hYK+PoDHRRuFPp/k4zQo79gxxvunfen8E/J0aOUAh
         qY1ANeq40FkbYoTzh66Gnxw/EQ54exY/tmLNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9T6PSykNJnlF/av8JBWrr1nuinRnZqLCQ+xbxw+WMEE=;
        b=PEUKpHIuhvbbNxhp24RT1IRqW0Nf50RQgOKLdmRWXdp5I9WpAh6WzXtMS6dZViXRCg
         FbETNBzm+S/dP2uTsRHKrIbg5uR2r9SILPdomrz3J+nEH9hCMVlszTfbkSJ4zvw4h9Wc
         zjs+DhdlCmcw48B2nnO6cnCFP43L6rRN22f5qZ7Q4GOKip8hAGXHpw/FPVueRmEaMMQN
         Du5DHNMhieWQktcpeDof76TSoWL9c8n8GPMCvAeYHtp/5QuedFaT4H0nOQB8J6WhNtdx
         zHV7yO1AqoioKe9/TdikBTZbdlMxqSATbo87dcGIR+dL9IbC2Y7riZsN/F+95UtCWy2T
         PWig==
X-Gm-Message-State: ANhLgQ0TKSJsHZ/mE9fv0pJ0TMNjv+q32lQVXilwasLoT4jX/OdfBefO
        LxX4wBXjBon5O2/5daBlOIv9DNw4/Bo=
X-Google-Smtp-Source: ADFU+vvLvPvGhCkrWATw/SZqDKpdG7VLWr6UbOFjK7Pzf6BKs0/ShsyvCxKTLPxRKrynfha3e5iKnQ==
X-Received: by 2002:a62:a515:: with SMTP id v21mr26712371pfm.128.1584349287586;
        Mon, 16 Mar 2020 02:01:27 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id d3sm65040080pfn.113.2020.03.16.02.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 02:01:27 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Jon Flatley <jflat@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v5 4/4] platform/chrome: typec: Update port info from EC
Date:   Mon, 16 Mar 2020 02:00:21 -0700
Message-Id: <20200316090021.52148-5-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200316090021.52148-1-pmalani@chromium.org>
References: <20200316090021.52148-1-pmalani@chromium.org>
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

Changes in v5:
- No changes.

Changes in v4:
- No changes

Changes in v3:
- No changes.

Changes in v2:
- No changes.

 drivers/platform/chrome/cros_ec_typec.c | 89 ++++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 9f692eb78b322..874269c070739 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -172,6 +172,81 @@ static int cros_typec_ec_command(struct cros_typec_data *typec,
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
@@ -218,7 +293,7 @@ static int cros_typec_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct cros_typec_data *typec;
 	struct ec_response_usb_pd_ports resp;
-	int ret;
+	int ret, i;
 
 	typec = devm_kzalloc(dev, sizeof(*typec), GFP_KERNEL);
 	if (!typec)
@@ -251,7 +326,19 @@ static int cros_typec_probe(struct platform_device *pdev)
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
2.25.1.481.gfbce0eb801-goog

