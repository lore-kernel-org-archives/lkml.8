Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F408C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 21:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A4220720
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 21:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HMwCz2GC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbgBEVBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 16:01:44 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37665 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgBEVBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 16:01:44 -0500
Received: by mail-pg1-f194.google.com with SMTP id z12so1560545pgl.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 13:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SQ0GAnvyRYeOH9Mitx5dzN1/E/DrwnX3jWdRMovUOco=;
        b=HMwCz2GCC0Jfy1f9ihH08auHez7uQ6tn0r4XPFzFK3hhUou76MmRNGoLjNQRRVdk/S
         uYpaaknKmil8nDrofl03+3tk5nnJleooK8Rxas6cR/X8m8EY+KCPzL9xW5nZ9ZdkO1bY
         Qa1hRmoQ7kQpoK/4l3AnWMvxZsoXa0iXT+FQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SQ0GAnvyRYeOH9Mitx5dzN1/E/DrwnX3jWdRMovUOco=;
        b=tGE3+EXQNAi5FsSPMq/FnG3D8nAZbQNX4rHiIU1BAM1qu4j712xc291erQ3kgKOeCk
         QGM7cXW7EUaVPl0mQUqR/wrYGQES4AahlKMb2H33FtsD9Cm7SgTrX/f6ivDzQu3YAzbv
         /ez25r23/WXlZlLo6R7CkmPlMRaDSe3Sd82dosLeOtbpEgZGtV/xo6kvL+FiB70M+PUs
         r0dV87fDkB8lWFhi2m1bovh8KujIJYLW0Zuq7znFCmpsDXOVBmO8QutZ3+JjpsURyBzR
         1EkYjbBvBZCusX1Eylzk30qcOJEqgGw3yzfDXRYt7nIygz5CnuC6FVJu3y8BLVIaF1My
         S9jA==
X-Gm-Message-State: APjAAAWcpCS9yDZ8qze3N31lhy3mV1ItSRbxeervm3o238YhLT8cPNdz
        860GWF03tfy38LNQM+16lKOOOoHJ8SQ=
X-Google-Smtp-Source: APXvYqwcmYL3/qOYdV1Y8wZxf06q2ddJEYBnibS0ZZtwjFoNK0C40O6lng4NAf9xpdFBkR9TifQytQ==
X-Received: by 2002:a63:26c4:: with SMTP id m187mr38940067pgm.410.1580936502800;
        Wed, 05 Feb 2020 13:01:42 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id f8sm648797pjg.28.2020.02.05.13.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 13:01:42 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@intel.com, enric.balletbo@collabora.com,
        bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 2/3] platform/chrome: typec: Get PD_CONTROL cmd version
Date:   Wed,  5 Feb 2020 12:59:52 -0800
Message-Id: <20200205205954.84503-3-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200205205954.84503-1-pmalani@chromium.org>
References: <20200205205954.84503-1-pmalani@chromium.org>
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
 drivers/platform/chrome/cros_ec_typec.c | 34 ++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index fe5659171c2a85..b8edcfaa8a5297 100644
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
@@ -173,6 +174,31 @@ static int cros_typec_get_num_ports(struct cros_typec_data *typec)
 	return 0;
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
@@ -206,8 +232,14 @@ static int cros_typec_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	ret = cros_typec_get_cmd_version(typec);
+	if (ret < 0) {
+		dev_err(dev, "failed to get PD command version info\n");
+		return ret;
+	}
+
 	ret = cros_typec_init_ports(typec);
-	if (!ret)
+	if (ret < 0)
 		return ret;
 
 	return 0;
-- 
2.25.0.341.g760bfbb309-goog

