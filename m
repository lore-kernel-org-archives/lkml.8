Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55994C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26018217BA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oMBoToc9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgBGUnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 15:43:02 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33552 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgBGUnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 15:43:02 -0500
Received: by mail-pg1-f194.google.com with SMTP id 6so395344pgk.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 12:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tfGepi3b0hZsP0eynwkvtU7Dzi5ho/+WU7/Amaz8QIE=;
        b=oMBoToc9coTuVIDmfDRf6SOictmOFqZqpXb4VzfmSt4hpCzfsl2jyiGNqwxI2LM820
         kWtAX2TBVHD7Obj5dtflcjNatewkKiUyTB8lCE9R2fAZvdw5FjksowH9MdbxWDGVmo+x
         eGIK/WP7FteVVHWI3hwHO9iwev/q2icNwyOVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tfGepi3b0hZsP0eynwkvtU7Dzi5ho/+WU7/Amaz8QIE=;
        b=mLsOai6qDg7mQMTsh97w+htYoO3cMW+2RYqveAOp8RzS794w0mW7IGhHlWHxrm8i08
         nhK9U5vX5IHcZsF5n0ftEuWVCg7SlQ9T8veTDvBMqF5qRFxOMc/OxJHubM8jTiA9TsEn
         zUf+VIWbABBzkVMBIlOjyJ66NnmhMIvC45qfxEH2sNKbdGXGhD4aZ54cOm1Ig0anL2NW
         nACU0hwv5hiUO04OjTQlEttJeozvJwdX9ArBs6HEdxzoE6SShAkyZWqzBrFmn5TvCZuh
         RAdJUnJOH8bg2RwKC4XapR2NO12TMr4pS6U+9FMYJ/OdxI9sXf+eRGNOOFqI7FUVnMIf
         2K5w==
X-Gm-Message-State: APjAAAVT34FN2/1XTIpWZi9bNuznLySHB5OJZcTVl5AUsV9z+Ew49Z48
        TkSLoK2sG8z7lu3xItQEbbs4N/3GuaQ=
X-Google-Smtp-Source: APXvYqxagcwCHMD33MC0fr0WY2XrOMvQ279AaOy+0YEmrkiVzyH/nF1mBV58FB/T2/gij1I/Pi5vwA==
X-Received: by 2002:a62:1d07:: with SMTP id d7mr657929pfd.159.1581108180434;
        Fri, 07 Feb 2020 12:43:00 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id 4sm4051001pfn.90.2020.02.07.12.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 12:42:59 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@intel.com, enric.balletbo@collabora.com,
        bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Jon Flatley <jflat@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v2 4/4] platform/chrome: typec: Update port info from EC
Date:   Fri,  7 Feb 2020 12:37:50 -0800
Message-Id: <20200207203752.209296-5-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200207203752.209296-1-pmalani@chromium.org>
References: <20200207203752.209296-1-pmalani@chromium.org>
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

Changes in v2:
- No changes.

 drivers/platform/chrome/cros_ec_typec.c | 89 ++++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index df01ce86c7146c..4cdbd85966ee02 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -153,6 +153,81 @@ static int cros_typec_ec_command(struct cros_typec_data *typec,
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
@@ -199,7 +274,7 @@ static int cros_typec_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct cros_typec_data *typec;
 	struct ec_response_usb_pd_ports resp;
-	int ret;
+	int ret, i;
 
 	typec = devm_kzalloc(dev, sizeof(*typec), GFP_KERNEL);
 	if (!typec)
@@ -231,7 +306,19 @@ static int cros_typec_probe(struct platform_device *pdev)
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

