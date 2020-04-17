Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6408C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B267921D91
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kSz5h/7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbgDQJga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 05:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730131AbgDQJga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 05:36:30 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D024DC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 02:36:28 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j2so2252083wrs.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 02:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nr4vKvs2qrJShxFn1O+ztxZUZEQFA+yVojQ7rh1kCD0=;
        b=kSz5h/7bGrJkc/P34ntw8nXpZOrDvE3F342U/XFDDNM66DRjfnDbDvE1g3Xowe2Hyo
         0O3XJZHuZ0WPvz7I2nWs9vEste+IZSGrcbecg+Ngk5H2nY63ld/TuVvhujmGJ0CJIiXc
         CI0D/rzFPSEBMEuaX0ih2c4fpyuEQchuqwFN/58oaQHIRX1VNuwKNt5khMWCXhKjuEVS
         xPscU1/UGdx+r5816XnjgBxCMDaqEr2q4isXF9pkx0OqUOovm1aMlkMBFwxA8pqX561X
         3tI4ecUg/+lDdjbVBHo2urtXRQpJJzn2yRlqzVMJ1cWhD/AwoJF7/MMWBPOAO/7w/g2l
         4fHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nr4vKvs2qrJShxFn1O+ztxZUZEQFA+yVojQ7rh1kCD0=;
        b=pet1tjcOvQMQs8iZKVSh9UBgZiy/kwjL9kNwFc0VYCPDCbvnV87+3QeIcWg1iljqQk
         OqlEJP5U/RQzjT2s+Xul0oh+UK183jQA8E7SwADQmw8VNBL9UadGVdur07Bp9xzBsxsu
         bQzU2EoIZT9PUh3PtEVGjosrSOCPvDMP5nApu+ZeDy6MN9qFYXgrFC6+iXWTz5YL+EvD
         rd5sQThFXp7lvkYm56J4NhowrS4xKsBglsEp9SRCW2jAlvmOi1Vl+OcJPYslx9++yHMH
         B93h2wDMINiF/vrE+Ur7+Q+byoT41m6T0ZHv2rZNvVrMy0Kztiqv8SiHbVRGD0loClPi
         VRRQ==
X-Gm-Message-State: AGi0PuZ5BvEzCXrT8YgXkZxLx+yaUHphBkJkHIfhK7f35Vb0qRpZxcGi
        T65jOln/uxYhYAlbuFFTw1icT136g/M=
X-Google-Smtp-Source: APiQypLxHOfwG1ryjC/TcH1jk7Fqcg15PZuF3rUQqrV6goNBMMG+OjJ2jRHeFEWG+XHD0e7kNPGDGA==
X-Received: by 2002:a5d:6a04:: with SMTP id m4mr3148130wru.326.1587116187648;
        Fri, 17 Apr 2020 02:36:27 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id h137sm7819792wme.0.2020.04.17.02.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 02:36:26 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     srini@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] slimbus: ngd: get drvdata from correct device
Date:   Fri, 17 Apr 2020 10:36:18 +0100
Message-Id: <20200417093618.7929-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get drvdata directly from parent instead of ngd dev, as ngd
dev can probe defer and previously set drvdata will become null.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index fc2575fef51b..7426b5884218 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1361,7 +1361,6 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 		ngd->pdev->driver_override = QCOM_SLIM_NGD_DRV_NAME;
 		ngd->pdev->dev.of_node = node;
 		ctrl->ngd = ngd;
-		platform_set_drvdata(ngd->pdev, ctrl);
 
 		platform_device_add(ngd->pdev);
 		ngd->base = ctrl->base + ngd->id * data->offset +
@@ -1376,12 +1375,13 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 
 static int qcom_slim_ngd_probe(struct platform_device *pdev)
 {
-	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
 	struct device *dev = &pdev->dev;
+	struct qcom_slim_ngd_ctrl *ctrl = dev_get_drvdata(dev->parent);
 	int ret;
 
 	ctrl->ctrl.dev = dev;
 
+	platform_set_drvdata(pdev, ctrl);
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_set_autosuspend_delay(dev, QCOM_SLIM_NGD_AUTOSUSPEND);
 	pm_runtime_set_suspended(dev);
-- 
2.21.0

