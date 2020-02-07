Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E1BC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C6620838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j3wm9jIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgBGUmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 15:42:01 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:34884 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgBGUmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 15:42:01 -0500
Received: by mail-pj1-f67.google.com with SMTP id q39so1412945pjc.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 12:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IXG1SsgmeHKZaaUB/P+xmTOqLSj/EIyBQWrqCegBEbc=;
        b=j3wm9jISIatbqjYCuZS07BfRQUp2CI9tLsAfitjCvNycw7uq3f6MjN44Li5WpQFfqn
         oIpZY/4cMoMLtCLDhi6IlvfduVVV+mqOspjPIMRew7vPlbIOyjimovlc2SkLqfXM0Fz3
         bPKF7nEHyjmCS5Os19CR/wqa6CtxEqjwWd320=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IXG1SsgmeHKZaaUB/P+xmTOqLSj/EIyBQWrqCegBEbc=;
        b=NfM7rHuHFbszFt4hrYcmcvbQlpS75Zr4gL7shY6RiBJdqjj0T0gy2MMDI6Q6glYmg2
         8qkcEWIR2nzSk73w2cwBooSaSqTayo8iXVbA91khF73DgJ4Pp6XJb96y+g6KQgvhy1Am
         3Z8Jnyp+DjnBe7mT8PhOQSn1X/Sc9J2oTEc7LkZQy7FTOOnTBC1eoG8d/lsTqTDkUz4T
         fCvw/aORO0adOXRgFbUEI4fnFt6pL5y18b5quJcU8/VzgzhsrZGvuiFZI5IrCPtnWWme
         lFwGMGvH7J82aMCp/7SPcD80XMvdvdijrcSCBKhmASoIUptO0aCVz43OXMX8p4jwUeTy
         9xCQ==
X-Gm-Message-State: APjAAAX6O11KFvcce6DCxJg6ilTY+M4m2h5afCLON9e8xyq9fOHqpm4V
        M0Kll/0xT5QBaoBT5DelTpkv7Ex4lK8=
X-Google-Smtp-Source: APXvYqx4DBEcwExNiQJByPLf4hkSNYNoLwEHng4lNReVNwZnmYQX7HVikOaH0tr10uFBQCC7TA4Q5g==
X-Received: by 2002:a17:902:8f91:: with SMTP id z17mr205180plo.234.1581108120326;
        Fri, 07 Feb 2020 12:42:00 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id 4sm4051001pfn.90.2020.02.07.12.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 12:41:59 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@intel.com, enric.balletbo@collabora.com,
        bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v2 3/4] platform/chrome: typec: Get PD_CONTROL cmd version
Date:   Fri,  7 Feb 2020 12:37:48 -0800
Message-Id: <20200207203752.209296-4-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200207203752.209296-1-pmalani@chromium.org>
References: <20200207203752.209296-1-pmalani@chromium.org>
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

Changes in v2:
- No changes.

 drivers/platform/chrome/cros_ec_typec.c | 34 ++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 8374ccfe784f3b..df01ce86c7146c 100644
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
@@ -152,6 +153,31 @@ static int cros_typec_ec_command(struct cros_typec_data *typec,
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
@@ -182,6 +208,12 @@ static int cros_typec_probe(struct platform_device *pdev)
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
@@ -196,7 +228,7 @@ static int cros_typec_probe(struct platform_device *pdev)
 	}
 
 	ret = cros_typec_init_ports(typec);
-	if (!ret)
+	if (ret < 0)
 		return ret;
 
 	return 0;
-- 
2.25.0.341.g760bfbb309-goog

