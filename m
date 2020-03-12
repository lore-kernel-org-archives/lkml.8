Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAB9C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 23:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4450D206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 23:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JA+OPDXa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgCLXED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 19:04:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44179 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgCLXEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 19:04:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id b72so3999795pfb.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 16:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XAdSv21dSQkMe6ASh/4rd2HigmIRXAw4ZLVXNFDtyVU=;
        b=JA+OPDXa5jC/dqTY/BEaS2/VtEz+hMQLPwkTH8PkNmHkGYFL8RCOVkhO580y5J9feL
         NicY7eREQT5oZj3PsVQz0IPqODw6jQceJy7EWL+cyn6pTIYff70HIED0XoJiL9enhaFP
         94gwRLRJ2dUCBQUV8j1eGG2g+ss9Oc1MJDrsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XAdSv21dSQkMe6ASh/4rd2HigmIRXAw4ZLVXNFDtyVU=;
        b=NlBq9r0que5eWkhxqoaIf9Fvpym1xoOLp/BlE3LjQ7Qfh+xtZqVGXNTT/mpj3FGK3X
         vtjgpKxxMZer//EeCSv7LGCIMWYmOxPTgPeTIDkT1m+nZniSFhNCC/L2dQbMx9Lmr9bh
         U7PjbZCOJ/pK3mz/aAhwB0IwwlaOajz8frVu/My07Hf3HH1DUXyfUVmkyf2DGQ0soZ92
         ZiGfEuHQ3y5to5+NnRIqBhO3jul7/idL9WZsnqrECnAHslWM8xn/D5DGwwYe3Mwt6YkM
         1d7F+Rac+ua4ERNWdkMjYXw9YxfAijP0VMbfzXZHvtwnW7Xfw0e2cghNrRzzOLzzal2y
         d1Dw==
X-Gm-Message-State: ANhLgQ0wEr1pYNZ1ZYoNHOpfzrj359VAj5M/xBBI0gRoZOJbbvsl8UCm
        W44HcnVhrpGlyWb4Lne891RYF8cKpfw=
X-Google-Smtp-Source: ADFU+vvjno42cAm5y/8oQ65JfHb1VuFeqX7rgvYx+44CmwxBfeik0igWnv24J20CGxcvQt2nVdmHZQ==
X-Received: by 2002:aa7:990e:: with SMTP id z14mr8766053pff.274.1584054241555;
        Thu, 12 Mar 2020 16:04:01 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id v123sm28763161pfb.85.2020.03.12.16.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 16:04:01 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v4 3/4] platform/chrome: typec: Get PD_CONTROL cmd version
Date:   Thu, 12 Mar 2020 15:57:17 -0700
Message-Id: <20200312225719.14753-4-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200312225719.14753-1-pmalani@chromium.org>
References: <20200312225719.14753-1-pmalani@chromium.org>
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

Changes in v4:
- No changes

Changes in v3:
- Moved if statement check in the end of probe() from this patch to a
  previous patch.

Changes in v2:
- No changes.

 drivers/platform/chrome/cros_ec_typec.c | 32 +++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 02e6d5cbbbf7a..9f692eb78b322 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -21,6 +21,7 @@ struct cros_typec_data {
 	struct device *dev;
 	struct cros_ec_device *ec;
 	int num_ports;
+	unsigned int cmd_ver;
 	/* Array of ports, indexed by port number. */
 	struct typec_port *ports[EC_USB_PD_MAX_PORTS];
 	/* Initial capabilities for each port. */
@@ -171,6 +172,31 @@ static int cros_typec_ec_command(struct cros_typec_data *typec,
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
@@ -202,6 +228,12 @@ static int cros_typec_probe(struct platform_device *pdev)
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
2.25.1.481.gfbce0eb801-goog

