Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6600BC32771
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 01:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32AB12073B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 01:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eN8g4PFU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbgAYBWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 20:22:05 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34277 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgAYBWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 20:22:05 -0500
Received: by mail-pf1-f193.google.com with SMTP id i6so1958112pfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 17:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JwNAT38uZz21Fou+nxtSqV2POWJ4Lnccl1Lds062gEU=;
        b=eN8g4PFUQA/zfbSLhLk0EizRBjwVlPnAj486l7RDRW27upiEendjq7GCQDT+V/fTAg
         21r76jPO1mroldm/9YfgdbOeYXS3ODUtYa2XKmQ9leu14e5NH1lpv4nTnXQY9aS2KoPx
         Mm+vgQa5lFxjOXYpsRqAZsGAD5nqNo+gcB+Y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JwNAT38uZz21Fou+nxtSqV2POWJ4Lnccl1Lds062gEU=;
        b=IQVnQJUH0oGPvcUlBMaonJnBqzn7H3Q4ftS7E0k6x22MqP/ZYawqZA+fKQiyx36fMg
         6GjErSlZeDBcgXRmISsUMiE8MAH22nIPvCS3WC1jorhR2s8V4Zpeuy0zypFUBYnjDtKz
         dXe864hX/pI0RPueCvn2n5wN14+LyBEs7vyqNONsUjNarv9bkNX5sR/ykFXt9EFD7QxT
         YZv792+FvUxkB/PGXPJPnc1pV74SeYMIgIWtvGo+cHvqxdMYAt/d8Rb3ZLxEC6sKGwWE
         VhFBXwsItRh9+qMGvLcZgxjFnuHd0C92YT9RW+It4dedl874nyjx71w1moX5bFPg0Abp
         dSUQ==
X-Gm-Message-State: APjAAAWMknLGcYzIw7BYfVcFOIyOY6tXaxRKPA6w8qA5yJZOSvg5tCzk
        666jRLOmYhyC5vwKqbG+PGQYTw==
X-Google-Smtp-Source: APXvYqwvoxNwKMUo98vwrwDr1+u1puI/uBM3KIgtz3QvRv/raK6rjKx1MGKPoCSHpOcdTtbi8sIgmw==
X-Received: by 2002:a62:486:: with SMTP id 128mr5982032pfe.236.1579915324262;
        Fri, 24 Jan 2020 17:22:04 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id n4sm7443337pgg.88.2020.01.24.17.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 17:22:03 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>
Subject: [PATCH 3/4] platform/chrome: Use send_cmd_msg in debugfs
Date:   Fri, 24 Jan 2020 17:21:07 -0800
Message-Id: <20200125012105.59903-4-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200125012105.59903-1-pmalani@chromium.org>
References: <20200125012105.59903-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update Chrome EC's debugfs driver to use the cros_ec_send_cmd_msg()
wrapper instead of cros_ec_cmd_xfer_status() within the pdinfo_read()
function. This helps to remove some of the structure and buffer
definitions and some of the message buffer set up code.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_debugfs.c | 39 +++++++----------------
 1 file changed, 12 insertions(+), 27 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index 6ae484989d1f5..34c1c36be1c51 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -199,44 +199,29 @@ static ssize_t cros_ec_pdinfo_read(struct file *file,
 	char read_buf[EC_USB_PD_MAX_PORTS * 40], *p = read_buf;
 	struct cros_ec_debugfs *debug_info = file->private_data;
 	struct cros_ec_device *ec_dev = debug_info->ec->ec_dev;
-	struct {
-		struct cros_ec_command msg;
-		union {
-			struct ec_response_usb_pd_control_v1 resp;
-			struct ec_params_usb_pd_control params;
-		};
-	} __packed ec_buf;
-	struct cros_ec_command *msg;
-	struct ec_response_usb_pd_control_v1 *resp;
-	struct ec_params_usb_pd_control *params;
+	struct ec_response_usb_pd_control_v1 resp = {0};
+	struct ec_params_usb_pd_control params = {0};
 	int i;
 
-	msg = &ec_buf.msg;
-	params = (struct ec_params_usb_pd_control *)msg->data;
-	resp = (struct ec_response_usb_pd_control_v1 *)msg->data;
-
-	msg->command = EC_CMD_USB_PD_CONTROL;
-	msg->version = 1;
-	msg->insize = sizeof(*resp);
-	msg->outsize = sizeof(*params);
-
 	/*
 	 * Read status from all PD ports until failure, typically caused
 	 * by attempting to read status on a port that doesn't exist.
 	 */
 	for (i = 0; i < EC_USB_PD_MAX_PORTS; ++i) {
-		params->port = i;
-		params->role = 0;
-		params->mux = 0;
-		params->swap = 0;
-
-		if (cros_ec_cmd_xfer_status(ec_dev, msg) < 0)
+		params.port = i;
+		params.role = 0;
+		params.mux = 0;
+		params.swap = 0;
+
+		if (cros_ec_send_cmd_msg(ec_dev, 1, EC_CMD_USB_PD_CONTROL,
+					 &params, sizeof(params), &resp,
+					 sizeof(resp)) < 0)
 			break;
 
 		p += scnprintf(p, sizeof(read_buf) + read_buf - p,
 			       "p%d: %s en:%.2x role:%.2x pol:%.2x\n", i,
-			       resp->state, resp->enabled, resp->role,
-			       resp->polarity);
+			       resp.state, resp.enabled, resp.role,
+			       resp.polarity);
 	}
 
 	return simple_read_from_buffer(user_buf, count, ppos,
-- 
2.25.0.341.g760bfbb309-goog

