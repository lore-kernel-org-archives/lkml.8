Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87DBC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9846820708
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DVa+bvyU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbgA3Uc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:32:59 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33583 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbgA3Uc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 15:32:59 -0500
Received: by mail-pl1-f193.google.com with SMTP id ay11so1790646plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 12:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ya9WKYi67VM/FY4q+UxJQlPTkj8e9bF4AOYzR/6vx70=;
        b=DVa+bvyU/xGBVVZLoWSBFNEiiYIhh3Hzg8iPXJJlQ9nJzPodQNLyZjD2bF0fo4RGBt
         e9XBi4RFaCCD4gnm6gTR4HoIJ7QriyCLiA2K8J+frS3bv7GTTP2Ezb6bvCyYQJJJRQBt
         jHCW3uv3IoO5sMb+42bkBtZOaM9JwP01irP2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ya9WKYi67VM/FY4q+UxJQlPTkj8e9bF4AOYzR/6vx70=;
        b=Ss0iyw3Cg6GXctzvMTg3OUQJItbV/B65KcHqYZgg7/nr8Oj9773iZoFQ9D+WO8sj/f
         1IaH2jmeGXjv0W/Oc7UQHGW4PrR68KVFsw2WEtBIqodQhSK4SdLlja97eRxPrL1tO34g
         kGjwgb3aX8m2Efyci0XhhLBKvSjpNcAWQR0BFYw5fG1YY+nvLVtbPQSue+XculC43Bjf
         a+6kLkZBcIvz6pIRz3iLkm/H9Ykr02ptug1c3mR4eBsDsv1eledb3A6s/gPcKIJhFhuL
         hf97uvcpsFk+ztiBpTebtZ+fvZYXWyxNpY7sAmUP0UdZ2/zMl3E3n3jm0KyUUJA8o/Xm
         grgw==
X-Gm-Message-State: APjAAAVUeKPn8aZDQISCtbYXzrTuCkFi3OVk6bGK03moVheSVL1iGf5s
        JnfSUb/w5mDiIBgxkRijO1XxIFyGaIA=
X-Google-Smtp-Source: APXvYqyFNwywSlu1XnOgy2XCM1V6DnS6fBFvWoPuymK6vCSp2mv/0VQhgE/4KqsgOZ7s01PLp2cRSw==
X-Received: by 2002:a17:90a:8a0c:: with SMTP id w12mr7919420pjn.61.1580416378408;
        Thu, 30 Jan 2020 12:32:58 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id q12sm7469321pfh.158.2020.01.30.12.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:32:57 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 03/17] platform/chrome: proto: Use send_cmd_msg
Date:   Thu, 30 Jan 2020 12:30:38 -0800
Message-Id: <20200130203106.201894-4-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200130203106.201894-1-pmalani@chromium.org>
References: <20200130203106.201894-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the use of cros_ec_cmd_xfer_status() with the new function
cros_ec_send_cmd_msg().

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_proto.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 53f3bfac71d90e..efd1c0b6a830c8 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -808,31 +808,21 @@ EXPORT_SYMBOL(cros_ec_get_host_event);
  */
 int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
 {
-	struct cros_ec_command *msg;
 	int ret;
 
 	if (ec->features[0] == -1U && ec->features[1] == -1U) {
 		/* features bitmap not read yet */
-		msg = kzalloc(sizeof(*msg) + sizeof(ec->features), GFP_KERNEL);
-		if (!msg)
-			return -ENOMEM;
-
-		msg->command = EC_CMD_GET_FEATURES + ec->cmd_offset;
-		msg->insize = sizeof(ec->features);
-
-		ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
+		ret = cros_ec_send_cmd_msg(ec->ec_dev, 0,
+					   ec->cmd_offset + EC_CMD_GET_FEATURES,
+					   NULL, 0, ec->features,
+					   sizeof(ec->features));
 		if (ret < 0) {
-			dev_warn(ec->dev, "cannot get EC features: %d/%d\n",
-				 ret, msg->result);
+			dev_warn(ec->dev, "cannot get EC features: %d\n", ret);
 			memset(ec->features, 0, sizeof(ec->features));
-		} else {
-			memcpy(ec->features, msg->data, sizeof(ec->features));
 		}
 
 		dev_dbg(ec->dev, "EC features %08x %08x\n",
 			ec->features[0], ec->features[1]);
-
-		kfree(msg);
 	}
 
 	return ec->features[feature / 32] & EC_FEATURE_MASK_0(feature);
-- 
2.25.0.341.g760bfbb309-goog

