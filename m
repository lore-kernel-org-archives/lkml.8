Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A56AC7619D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 00:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB88206E2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 00:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EeQQVTCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbgBTAgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 19:36:37 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34296 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgBTAgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 19:36:37 -0500
Received: by mail-pg1-f196.google.com with SMTP id j4so995201pgi.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 16:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DHH6Cxa30NDrImHrLr3z5k1RDXrDB96aHEdjNpf39yY=;
        b=EeQQVTCXUnySDxGyHZNJe2fiADhSnLgaxqxoasZKZkkX94JvxBVzSG9usWYcBgU7Uw
         fUb+rqhwp4lIPzT63pxxLrb2Uc5nwtuoTUxPsrcPCBI0EwOu/XVR1dk2Pqn7dc9aWIe6
         aaSyPo4tJm01XDFeCH0kEl+Uqt6M92FNelWsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DHH6Cxa30NDrImHrLr3z5k1RDXrDB96aHEdjNpf39yY=;
        b=ajQzgw7ufZWAJ1HfZ8Qzv+khE60dccgsCQxuJYttsP6aF9AYE4LrkCQt0Hi+T1cbCh
         mZGRSUq94Z+uNuRvp9pBfq+Qn92C1DOZUAmuzSc2yQt9mZ8KTpwlkD1lExmjttwxzLpz
         i0WlnAeF8/E6HkH/1ghzg4ua5YItTld4gKFMFz5X/TmLhVZ8g8qycAY2SQHY1os+kxjI
         2n8Mzs0dQv65hn0V513h1V6+BM/Ky8QEWRYbzROol7ozd6fDDtxau9gV0WN6x0Tt1iid
         yO3McoXA5YwEhuXDY1mcUhqfBTITpM/ZyGRbO1SXMqmU1kXxlKoGlFM2G8obVVU2HyZu
         b9Hg==
X-Gm-Message-State: APjAAAWDSlM8uVXEDucx7uQKe7NNI9h1XgNR7iMb5//xWIQGUhxxyYK3
        FLnowav6jU3C6q660wGsyZ+myWDj4hc=
X-Google-Smtp-Source: APXvYqzfcskQAyzM9AYEC6o0vJ7n46W6+Nu86B95+RjYp7QUNvfXpkFoBvazutkUcczUJhl1GttPbw==
X-Received: by 2002:aa7:9562:: with SMTP id x2mr29388803pfq.147.1582158996546;
        Wed, 19 Feb 2020 16:36:36 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id g24sm788773pfk.92.2020.02.19.16.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 16:36:35 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@intel.com, enric.balletbo@collabora.com,
        bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v3 3/4] platform/chrome: typec: Get PD_CONTROL cmd version
Date:   Wed, 19 Feb 2020 16:36:30 -0800
Message-Id: <20200220003631.206078-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Query the EC to determine the version number of the PD_CONTROL
command which is supported by the EC. Also store this value in the Type
C data struct since it will be used to determine how to parse the
response to queries for port information from the EC.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v3:
- Moved if statement check in the end of probe() from this patch to a
  previous patch.

Changes in v2:
- No changes.

 drivers/platform/chrome/cros_ec_typec.c | 32 +++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 6cac41f246b99f..5e025c3442bed1 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -21,6 +21,7 @@ struct cros_typec_data {
 	struct device *dev;
 	struct cros_ec_device *ec;
 	int num_ports;
+	unsigned int cmd_ver;
 	/* Array of ports, indexed by port number. */
 	struct typec_port *ports[EC_USB_PD_MAX_PORTS];
 };
@@ -154,6 +155,31 @@ static int cros_typec_ec_command(struct cros_typec_data *typec,
 	return ret;
 }
 
+static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
+{
+	struct ec_params_get_cmd_versions_v1 req_v1;
+	struct ec_response_get_cmd_versions resp;
+	int ret;
+
+	/* We're interested in the PD control command version. */
+	req_v1.cmd = EC_CMD_USB_PD_CONTROL;
+	ret = cros_typec_ec_command(typec, 1, EC_CMD_GET_CMD_VERSIONS,
+				    &req_v1, sizeof(req_v1), &resp,
+				    sizeof(resp));
+	if (ret < 0)
+		return ret;
+
+	if (resp.version_mask & EC_VER_MASK(1))
+		typec->cmd_ver = 1;
+	else
+		typec->cmd_ver = 0;
+
+	dev_dbg(typec->dev, "PD Control has version mask 0x%hhx\n",
+		typec->cmd_ver);
+
+	return 0;
+}
+
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id cros_typec_acpi_id[] = {
 	{ "GOOG0014", 0 },
@@ -185,6 +211,12 @@ static int cros_typec_probe(struct platform_device *pdev)
 	typec->ec = dev_get_drvdata(pdev->dev.parent);
 	platform_set_drvdata(pdev, typec);
 
+	ret = cros_typec_get_cmd_version(typec);
+	if (ret < 0) {
+		dev_err(dev, "failed to get PD command version info\n");
+		return ret;
+	}
+
 	ret = cros_typec_ec_command(typec, 0, EC_CMD_USB_PD_PORTS, NULL, 0,
 				    &resp, sizeof(resp));
 	if (ret < 0)
-- 
2.25.0.265.gbab2e86ba0-goog

