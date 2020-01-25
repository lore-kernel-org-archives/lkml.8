Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9646BC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 01:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63DFA2073B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 01:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V7gNpm6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbgAYBWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 20:22:20 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43039 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgAYBWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 20:22:20 -0500
Received: by mail-pl1-f196.google.com with SMTP id p23so1480181plq.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 17:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/CBLP4zJTiApGSM+fXOeI1RBw2aN/kHUsOiaSD/bkm0=;
        b=V7gNpm6Vi8iEjBxI/eMT+Bcv63RhQZDAaVu5HSs9A0OWPY/oVLUjWNpCpSjnYMQrh7
         GGa49vVpRENiccRsfXxAzhOH7mNPHuEz2vw9kvj1FFnlrKNJnPAqYtxd44gxpHIRJal+
         mkWZTUTEgG2Pxa7Iu67e613O7XjH+j8njXUUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/CBLP4zJTiApGSM+fXOeI1RBw2aN/kHUsOiaSD/bkm0=;
        b=dpbSXDJd/KRmXzi57ALkn7xH8XAbq5bXPA7H1gP+XGM3wcALLo3V//HgOp74MaTKjR
         ifIdY1cZcgrHbcmbETVKQ8o8S763X7IkWMHBjsvgReJAQzBRgEg7nM7Q2TlHHFXX0D2G
         UU+1u1hLK9zomqbsx4Xtlm9rmx76loVq7d7Jbck8+4GFcIxHG5yHp/UNwDQCnN4tDIKR
         wOWBLouKMi8etKKitLTrCPSy3JLA74D8aQ2VsFx4QQtUaHfbb3UhqF3ZEx7d02Ir2FZV
         enm5NNKYF/HZGHsbdmuvE5/iBb+eEny2sMK1epSTak9SQKqHs+T3S8qszXZJZaYHaZI7
         pURg==
X-Gm-Message-State: APjAAAURZ+4i8IOP4rUgfYV5p+HCQvHvyAUmW4/AHAYqhIDuESST0Dmx
        6ISvX9FF0aSekwZOvlT0Dz16D6jXR7Q=
X-Google-Smtp-Source: APXvYqzXBQ+sz+1ceS/PmJ3H6TGXEtc63OJhDYfas5T4SdXfrKVBS1Sa2jlnoZRMuEhtweDAjKFCkA==
X-Received: by 2002:a17:90b:3c9:: with SMTP id go9mr2323550pjb.7.1579915339467;
        Fri, 24 Jan 2020 17:22:19 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id n4sm7443337pgg.88.2020.01.24.17.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 17:22:19 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>
Subject: [PATCH 4/4] platform/chrome: Make check_features() use wrapper
Date:   Fri, 24 Jan 2020 17:21:09 -0800
Message-Id: <20200125012105.59903-5-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200125012105.59903-1-pmalani@chromium.org>
References: <20200125012105.59903-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the use of cros_ec_cmd_xfer_status() with the new wrapper
function.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_proto.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 8ef3b7d27d260..d3540fe1b7556 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -804,31 +804,21 @@ EXPORT_SYMBOL(cros_ec_get_host_event);
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

