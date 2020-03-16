Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54972C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 09:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297C420674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 09:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hklC2Dw0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbgCPJBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 05:01:24 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39209 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730242AbgCPJBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 05:01:23 -0400
Received: by mail-pj1-f67.google.com with SMTP id d8so8277083pje.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 02:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mPt7LHQC0VkAtA+GFeRvZAx3rFXp2/l5EXFJ5H0G1qQ=;
        b=hklC2Dw0fPeR9wjYyhFbhgcF0Vupbnd23oPU6+U1we0/gbQM7bqlqGXI9BRC7xfSQj
         4nuFS9Ng373XdHFQc16A2eYqzW1b/YCZn9M9bP5r1mPlqRWdC0cueciOsul3ULFQm7OU
         iXokaSebMQBtnW0bd4q+eGXsIULjLVHhHsohU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mPt7LHQC0VkAtA+GFeRvZAx3rFXp2/l5EXFJ5H0G1qQ=;
        b=ldMmDycNDzxO2Rjyd1GmjjQznXpnyiUrG0jMMjQ6+oX19LkQF4czv3hO7txvTA4jj4
         ClxNUHkaDgaLD3l3EhIfX6Z39sm3ltOch2FLHJDR9C4ygAjJLJ44ZZBpuxmF1N58/seG
         bbMzqZham5OVIc4f1ofX8BhHVoavTEJOP4M+tNptPj9Ek3w5lG0hqFlR+rZcsbgjFt4i
         l5VDPOFfdu9zUcA2ushQ1FD+WThElV3WFWhnWlYSU3OaghU2HR/EzTHVuIWim/VcdIh8
         2c5wMXZz/TZn0qNIfm1UlG0Ciw1MbrU9byLYoPb2EBEODNZlber5dcP5PAkRTAMZlrvA
         ioRw==
X-Gm-Message-State: ANhLgQ2fGJ8bgpqWKwNXTzQ/7GfzAQpivbQ9TMNZ0uWpRYnp5qw3ej0n
        uQmYrWxr7PXJ4T2ypzBR8DQAkyeB8EM=
X-Google-Smtp-Source: ADFU+vtajIf7Cs3WocCqMmlnPw7tELzK61tTGeO+obTDS3wU3tHE+ZfuiUE6c3QjVn8TRUNPSv/55g==
X-Received: by 2002:a17:902:9a08:: with SMTP id v8mr25875764plp.192.1584349280705;
        Mon, 16 Mar 2020 02:01:20 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id d3sm65040080pfn.113.2020.03.16.02.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 02:01:20 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v5 3/4] platform/chrome: typec: Get PD_CONTROL cmd version
Date:   Mon, 16 Mar 2020 02:00:19 -0700
Message-Id: <20200316090021.52148-4-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200316090021.52148-1-pmalani@chromium.org>
References: <20200316090021.52148-1-pmalani@chromium.org>
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

Changes in v5:
- No changes.

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

