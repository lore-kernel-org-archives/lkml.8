Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11F1C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 07:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BADF520693
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 07:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OVBifuNq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgH3G7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 02:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgH3G7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 02:59:44 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FC2C061573
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 23:59:44 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e33so130722pgm.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 23:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K9Gf0x2ncvyGL8YFXBuW887ejicOMMwmZsRzWz8KKUU=;
        b=OVBifuNqnMP2VqawYDiUOm4otXb5SUy5Q9TIsS4xDSNeCY5HSiLHcEe5s0Hb28WrOa
         SFUvd+X7iE8UIXx2IZeNPWDysE/GB9IzUZLRPE1jLOWSDl3FiGB9ElkGZqwa+D+nhgTG
         lQ7JGtCp/hcljTAEYbNrTxISRItmKQe8iAlqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K9Gf0x2ncvyGL8YFXBuW887ejicOMMwmZsRzWz8KKUU=;
        b=fmWY6RuMBBxzgZyET340ievG8871MoN6HDt5OCZcM/kgTL2n3JXCCmRw91EvE+8ZuX
         jOjmIog/YFOb1x9U+Ak1cryYRy6L6RsOnuF098GpXzwfyyQnfpP5ohG6IxlDKu/Jjwy3
         KlLqQaTWfVKg8Yd969qS4x2nsUg9t/nJeUF91zw8XqrQyt8Qs0K4h5deW55yDFLIZ/q2
         HyTxX86FFN6xc19sGQ1juujs78GIscEeDJxfpTjrIr3dUbNvlEAuQXM/uzk+1iwWVyzL
         H0+j88nguYd5rm7rfwqcyFNFCZNc0nrGvWfctUkv2JDklsR+V0Y7+iluO8egqqjMbahW
         3Etg==
X-Gm-Message-State: AOAM5326jjHVXSAZpZtzWwyY4Mjb90Cm62tDSRpaN+Pm19q0jOai5oBu
        w7v5XTqYww4zyEkquHAEIjehb7Qy5X7B9g==
X-Google-Smtp-Source: ABdhPJx6O5Mj34AlopwMDXjnU4f0U5kozDenNVwLXzZsXiwa9C4V2F376PlC18vFR7nOilmPefoRkA==
X-Received: by 2002:a63:dd13:: with SMTP id t19mr4359386pgg.430.1598770783433;
        Sat, 29 Aug 2020 23:59:43 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id h11sm474154pfq.101.2020.08.29.23.59.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Aug 2020 23:59:42 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, enric.balletbo@collabora.com, jic23@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3] platform: cros_ec: Reduce ligthbar get version command
Date:   Sat, 29 Aug 2020 23:59:37 -0700
Message-Id: <20200830065937.2562679-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, the lightbar commands are set to the
biggest lightbar command and response. That length is greater than 128
bytes and may not work on all machines.
But all EC are probed for lightbar by sending a get version request.
Set that request size precisely.

Before the command would be:
cros_ec_cmd: version: 0, command: EC_CMD_LIGHTBAR_CMD, outsize: 194, insize: 128, result: 0
Afer:
cros_ec_cmd: version: 0, command: EC_CMD_LIGHTBAR_CMD, outsize: 1, insize: 8, result: 0

Fixes: a841178445bb7 ("mfd: cros_ec: Use a zero-length array for command data")
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes since v2:
- Add fix field where the inefficiency was present.

Changes since v1:
- Remove BUG and TEST fields.

 drivers/platform/chrome/cros_ec_lightbar.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
index b59180bff5a3e..ef61298c30bdd 100644
--- a/drivers/platform/chrome/cros_ec_lightbar.c
+++ b/drivers/platform/chrome/cros_ec_lightbar.c
@@ -116,6 +116,8 @@ static int get_lightbar_version(struct cros_ec_dev *ec,
 
 	param = (struct ec_params_lightbar *)msg->data;
 	param->cmd = LIGHTBAR_CMD_VERSION;
+	msg->outsize = sizeof(param->cmd);
+	msg->result = sizeof(resp->version);
 	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
 	if (ret < 0) {
 		ret = 0;
-- 
2.28.0.402.g5ffc5be6b7-goog

