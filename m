Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354D7C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 04:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD4C820EDD
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 04:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MUMfh+24"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgIIEED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 00:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgIIEEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 00:04:02 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E05DC061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 21:04:02 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b124so957018pfg.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 21:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=25YjaD8ldMoK9F1MuilGuFXMbIftFyYkB/apwsJ8bzI=;
        b=MUMfh+24JYKWl2x4xNDV3SOA73U7JDSDFVMg2EKXvWoqs1+MfarsfUZmvWBFzc0g2E
         Dm+jdYR/Tv48W5Cb7zkuoBS0qsECxfECI1fj2e4Yb2hdnJuCtE9hrIRAq9gQrxouBYbO
         G+jPJd38vpVSn3nN6qJfDjcP65tyck1Qq/M50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=25YjaD8ldMoK9F1MuilGuFXMbIftFyYkB/apwsJ8bzI=;
        b=ZStGlk9B/jLMJvx6Lsg1y+WIe+M5eGZ+Fo0sneSfROKdiamE+uptw0Jj0V6KV+Olea
         gbNna1R2JrayQ9Rp4q9VUUS/8i9s+gVe73Y3x4I6AFi5JAqjw3OsGcAkwfnNigBgzrNL
         O4oU89cEbVsnxnXdvjIupveiNOPfbIPcdpS9BdsJj/tNeiOjAr8zXaiDk099sLfCQEF7
         Fjii36pJ+VL0aQgia/wmgJBh6x3c5+YXifuI3uDOIILOJAkFGg96CgKUk7CeZ7SqMhdE
         r1RqNvEpCmd/cXfwa43aDvWw2GanpJukqTRkUPBVX52s44aCX/R6LaCcHg1MN7W9LmwF
         o5Rg==
X-Gm-Message-State: AOAM532dEv/m4UFgXim45EeAtF8HjO+mPe4tlfACRs3ETC8je/8BDa8d
        GB5kkKECMgEMZAj56nPolVuCiQ==
X-Google-Smtp-Source: ABdhPJyKvDI+QJQMdqmpUMhe/g57N103NiqXLYnt/XVX0bU+2QtVVRRLSvXuLpV2Lx2OAdjqK9TCRQ==
X-Received: by 2002:a17:902:9349:b029:d0:cb2d:f26c with SMTP id g9-20020a1709029349b02900d0cb2df26cmr2192098plp.5.1599624242153;
        Tue, 08 Sep 2020 21:04:02 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id 141sm882653pfb.50.2020.09.08.21.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 21:04:01 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH] platform/chrome: cros_ec_debugfs: Support pd_info v2 format
Date:   Tue,  8 Sep 2020 21:04:00 -0700
Message-Id: <20200909040400.908217-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's try to read more information out of more modern cros_ec devices by
using the v2 format first and then fall back to the v1 format. This
gives us more information about things such as DP mode of the typec pins
and the CC state, along with some more things.

Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Prashant Malani <pmalani@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Should we move read_buf to the heap?

 drivers/platform/chrome/cros_ec_debugfs.c | 40 +++++++++++++++++------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index 272c89837d74..4f8c902c0de6 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -195,28 +195,31 @@ static ssize_t cros_ec_pdinfo_read(struct file *file,
 				   size_t count,
 				   loff_t *ppos)
 {
-	char read_buf[EC_USB_PD_MAX_PORTS * 40], *p = read_buf;
+	char read_buf[EC_USB_PD_MAX_PORTS * 64], *p = read_buf;
 	struct cros_ec_debugfs *debug_info = file->private_data;
 	struct cros_ec_device *ec_dev = debug_info->ec->ec_dev;
 	struct {
 		struct cros_ec_command msg;
 		union {
-			struct ec_response_usb_pd_control_v1 resp;
+			struct ec_response_usb_pd_control_v2 resp_v2;
+			struct ec_response_usb_pd_control_v1 resp_v1;
 			struct ec_params_usb_pd_control params;
 		};
 	} __packed ec_buf;
 	struct cros_ec_command *msg;
-	struct ec_response_usb_pd_control_v1 *resp;
+	struct ec_response_usb_pd_control_v1 *resp_v1;
+	struct ec_response_usb_pd_control_v2 *resp_v2;
 	struct ec_params_usb_pd_control *params;
 	int i;
 
 	msg = &ec_buf.msg;
 	params = (struct ec_params_usb_pd_control *)msg->data;
-	resp = (struct ec_response_usb_pd_control_v1 *)msg->data;
+	resp_v1 = (struct ec_response_usb_pd_control_v1 *)msg->data;
+	resp_v2 = (struct ec_response_usb_pd_control_v2 *)msg->data;
 
 	msg->command = EC_CMD_USB_PD_CONTROL;
-	msg->version = 1;
-	msg->insize = sizeof(*resp);
+	msg->version = 2;
+	msg->insize = sizeof(*resp_v2);
 	msg->outsize = sizeof(*params);
 
 	/*
@@ -229,13 +232,30 @@ static ssize_t cros_ec_pdinfo_read(struct file *file,
 		params->mux = 0;
 		params->swap = 0;
 
-		if (cros_ec_cmd_xfer_status(ec_dev, msg) < 0)
+		if (cros_ec_cmd_xfer_status(ec_dev, msg) < 0) {
+			if (i == 0 && msg->version == 2) {
+				/* Try again with version 1 */
+				msg->version = 1;
+				msg->insize = sizeof(*resp_v1);
+				i = 0;
+				continue;
+			}
+
 			break;
+		}
 
 		p += scnprintf(p, sizeof(read_buf) + read_buf - p,
-			       "p%d: %s en:%.2x role:%.2x pol:%.2x\n", i,
-			       resp->state, resp->enabled, resp->role,
-			       resp->polarity);
+			       "p%d: %s en:%.2x role:%.2x pol:%.2x", i,
+			       resp_v1->state, resp_v1->enabled, resp_v1->role,
+			       resp_v1->polarity);
+		if (msg->version == 2) {
+			p += scnprintf(p, sizeof(read_buf) + read_buf - p,
+				       " cc:%.2x dp:%.2x ctrl:%.2x cs:%.2x gen:%.2x",
+				       resp_v2->cc_state, resp_v2->dp_mode,
+				       resp_v2->control_flags, resp_v2->cable_speed,
+				       resp_v2->cable_gen);
+		}
+		p += scnprintf(p, sizeof(read_buf) + read_buf - p, "\n");
 	}
 
 	return simple_read_from_buffer(user_buf, count, ppos,
-- 
Sent by a computer, using git, on the internet

