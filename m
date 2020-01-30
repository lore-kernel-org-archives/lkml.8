Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24177C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 22:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E717320708
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 22:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D5QIZdev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgA3WBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 17:01:20 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:56153 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgA3WBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 17:01:19 -0500
Received: by mail-pj1-f68.google.com with SMTP id d5so1914563pjz.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 14:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KDIJaSDiayliPM9rw3c4tDAdzrRAWY+dKzu33Xt6Ifs=;
        b=D5QIZdevKOFAhI9d73kaAaxfXe5CyRlPPuVjXyprM88Z0/lkpF/YWC7of293Ya+nQF
         8HPCDFOMlhwvaLq1jPPeYGUNrwWggWhJC1ZmsBwPbibyURS4k7CG8DwjBt3+GUvcslGi
         Q+XFTEimCsizRQy8GPFvURfMcazXt1IsAw8EQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KDIJaSDiayliPM9rw3c4tDAdzrRAWY+dKzu33Xt6Ifs=;
        b=Fs/MRN3DGBJvg39z4wDb6GhlUXr/L4oDvATlT7ugx0KhP48RY5ohD8otoNMjLDAhY9
         XcWiLpllZieDS4gUbzXCMHk8OJq0+fAruqZHqpo8ZcCYz4GJJ36HUDZ0LeBv/96mxsoK
         8aCvTaRNdsKz9qsDKEfEFcGbZfHHIa8aUJ1kPZbU/mXwfzx5KDryPvmOBwosa6By3i8t
         P0zcG2b6d9xs0iQoO7i5KrVpzZsxFiSINW3dugUeXZpeukU2Ga1m62xp/ZQRrzr3Zmhy
         J0I/TtxJWVAZDnTneVuXWKTz4V4WnPZR4GUEV07YnoecfQtQgL1kvjL5hIgoOacLyYhi
         04Rg==
X-Gm-Message-State: APjAAAUfHzCO6xnnmyhpND++vaxwl+NhGnJHa/pu4f8RsfQeQYo+lUGj
        9ZRNSRRLaSaw3Muu8WFIlmnFnLC64tD/7g==
X-Google-Smtp-Source: APXvYqwvJn6aQLQk5A5MGBBF0n2ojfrl/fahum8vXglUFiwP6vfcKM8T37gR6gGgp/IEPLJbURpTBg==
X-Received: by 2002:a17:90a:cb0f:: with SMTP id z15mr8360192pjt.67.1580421678772;
        Thu, 30 Jan 2020 14:01:18 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id g21sm8219849pfb.126.2020.01.30.14.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 14:01:18 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@intel.com, enric.balletbo@collabora.com,
        bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [RFC 2/3] platform/chrome: typec: Get PD_CONTORL version
Date:   Thu, 30 Jan 2020 14:00:31 -0800
Message-Id: <20200130220032.160855-3-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200130220032.160855-1-pmalani@chromium.org>
References: <20200130220032.160855-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Query the EC to determine the version number of the USB_PD_CONTROL
command which is supported by the EC. Also store this value in the Type
C data struct since it will be used to determine how to parse the
response to queries for port information from the EC.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 35 ++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index f48bb0172c565f..189c2192375c5d 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -22,6 +22,7 @@ struct cros_typec_data {
 	struct device *dev;
 	struct cros_ec_device *ec;
 	int num_ports;
+	unsigned int cmd_ver;
 	/* Array of ports, indexed by port number. */
 	struct typec_port *ports[EC_USB_PD_MAX_PORTS];
 };
@@ -137,6 +138,32 @@ static int cros_typec_get_num_ports(struct cros_typec_data *typec)
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
+	ret = cros_ec_send_cmd_msg(typec->ec, 1, EC_CMD_GET_CMD_VERSIONS,
+				   &req_v1, sizeof(req_v1), &resp,
+				   sizeof(resp));
+	if (ret < 0) {
+		return ret;
+	}
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
 static int cros_typec_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -160,8 +187,14 @@ static int cros_typec_probe(struct platform_device *pdev)
 		return -EOVERFLOW;
 	}
 
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

