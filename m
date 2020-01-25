Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E03C35242
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 01:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28FC2075D
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 01:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VlKl/P8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbgAYBVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 20:21:44 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35089 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgAYBVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 20:21:43 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so1496536plt.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 17:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=08VQxfV2CyDM+aJ1ZAO9E0Z3ABZWvz7HlPxyrk/L3TE=;
        b=VlKl/P8HXrS/2JEmMnVJeHNlvsEeZOJqYYLqK2PkgGiwBlpfv0EmCvHP+VUO5nGTQ3
         QC0f7azrW3430/ltBmZhGW74+GV4wVpJcH8S4kfF7CSEvTvIbRXdW3wUxvOjDFqeJyKn
         mR5s/jOfLiby2VDkx11lxiUm3TDVqmP3kcF2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=08VQxfV2CyDM+aJ1ZAO9E0Z3ABZWvz7HlPxyrk/L3TE=;
        b=KIx+sFKxbAxy0jfDaIV9KqkxAPufgqcDK7n/4Lcg7tszl5tt/C1Ef66WAiaS94Isjf
         h5WRMoAyNqjete4WS9K2nSNfRfxT1HYNTPm1QeEBcfj3rcYFojnuXZBY3hPHv0kSL1t/
         /ZnPb/9GVH1fac9JDuM/Kqu8sYo/TICOCOSZvk47oXQAoWBPe0Kr+sqAjgWUW3g/8BjT
         rxd/ay9ctsyri/QkmbxkVupJmZsHM6O60B87kyOOnwJwBy3dxz1U0WkbexcKpq9YUgL4
         WFN2kQ5ywjYYob0Qbqf9httF3wB6bHHpbRio3D9iv1CPUu9uS4jTU0r/56ICuMJU8wka
         7flg==
X-Gm-Message-State: APjAAAWuTHc2iwOx9pNSKHHGVdF/GzwKRwsE7rEQtny7rPrke13Y6/dd
        mxyhnwWViWJBDqubewlqUBtEWw==
X-Google-Smtp-Source: APXvYqwFNZK+x1AnENMm3AhXieV0KuHNBqgRG9zLgy78OzvC7qSxlBT61ulCu9TQ9NSTQXPGacUPYw==
X-Received: by 2002:a17:902:a616:: with SMTP id u22mr6491751plq.173.1579915302864;
        Fri, 24 Jan 2020 17:21:42 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id n4sm7443337pgg.88.2020.01.24.17.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 17:21:42 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>
Subject: [PATCH 2/4] platform/chrome: Make chardev use send_cmd_msg
Date:   Fri, 24 Jan 2020 17:21:05 -0800
Message-Id: <20200125012105.59903-3-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200125012105.59903-1-pmalani@chromium.org>
References: <20200125012105.59903-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the Chrome OS character device driver to use the newly introduced
cros_ec_send_cmd_msg() wrapper instead of cros_ec_cmd_xfer_status(),
thus avoiding message buffer set up work which is already done by the
wrapper.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_chardev.c | 33 ++++++++---------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_chardev.c b/drivers/platform/chrome/cros_ec_chardev.c
index 74ded441bb500..0c43f59184acb 100644
--- a/drivers/platform/chrome/cros_ec_chardev.c
+++ b/drivers/platform/chrome/cros_ec_chardev.c
@@ -57,37 +57,26 @@ static int ec_get_version(struct cros_ec_dev *ec, char *str, int maxlen)
 	static const char * const current_image_name[] = {
 		"unknown", "read-only", "read-write", "invalid",
 	};
-	struct ec_response_get_version *resp;
-	struct cros_ec_command *msg;
+	struct ec_response_get_version resp = {0};
 	int ret;
 
-	msg = kzalloc(sizeof(*msg) + sizeof(*resp), GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
-
-	msg->command = EC_CMD_GET_VERSION + ec->cmd_offset;
-	msg->insize = sizeof(*resp);
-
-	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
+	ret = cros_ec_send_cmd_msg(ec->ec_dev, 0,
+				   ec->cmd_offset + EC_CMD_GET_VERSION, NULL, 0,
+				   &resp, sizeof(resp));
 	if (ret < 0) {
 		snprintf(str, maxlen,
-			 "Unknown EC version, returned error: %d\n",
-			 msg->result);
-		goto exit;
+			 "Unknown EC version, returned error: %d\n", ret);
+		return ret;
 	}
 
-	resp = (struct ec_response_get_version *)msg->data;
-	if (resp->current_image >= ARRAY_SIZE(current_image_name))
-		resp->current_image = 3; /* invalid */
+	if (resp.current_image >= ARRAY_SIZE(current_image_name))
+		resp.current_image = 3; /* invalid */
 
 	snprintf(str, maxlen, "%s\n%s\n%s\n%s\n", CROS_EC_DEV_VERSION,
-		 resp->version_string_ro, resp->version_string_rw,
-		 current_image_name[resp->current_image]);
+		 resp.version_string_ro, resp.version_string_rw,
+		 current_image_name[resp.current_image]);
 
-	ret = 0;
-exit:
-	kfree(msg);
-	return ret;
+	return 0;
 }
 
 static int cros_ec_chardev_mkbp_event(struct notifier_block *nb,
-- 
2.25.0.341.g760bfbb309-goog

