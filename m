Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BB7C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD42B2067C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="mYMkTOrz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgHRQZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbgHRQZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:25:04 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF40CC061342
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 09:25:04 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id r19so9792814qvw.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 09:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TqDr2bIlDLtYnNvZqpiixZQmHFVnxcx4iPQhqi0JosM=;
        b=mYMkTOrzXL2mg6SR9UVW8uflezWrPRs/DctiC1r8m+fUPDVFQLdFdeboWF4U1YTc+t
         T4IuBIdES/07OHLsd5RfUS5PAOk9+FSuTPjhKEKObEA+L7HwwKVzdFySMdRRSUhhmWPr
         qP1qAFIwym901nzt1m8xtlm8NwLmsom3pt8rav9/dPaaCG0uU0gbSTowUNrMSjFEyBLN
         1/EyMGXUXlKchiCkJRRkjxjFdPijtPpyXIqdubcPhumnAT9KHNqlK4nnloVWwWK9LomT
         W7r0F7XLLgRrd776Skp0WqG2xzS3qHVKig9o4lWRhfWMqwJjCHhk45yZF76GaE5JgqD9
         IPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TqDr2bIlDLtYnNvZqpiixZQmHFVnxcx4iPQhqi0JosM=;
        b=fVbxdwsCygUXd73BlHiuASvveaDeiFijMf1raN4k6K3UZ/txL3QRIxpno6hYGUdOPe
         9EKKWRBptGFvC6Bvyb6GIq9l3dHqAAe25b2qBladT7qeE58IoBRPyDl8yY3Olvbn2wKr
         o9HFIGv8hsI5rdDwk+Zabg6aHFUSVm9E1V9k+uZFkShZWCYZlr8zaXwQDpL2m/zip4ij
         q1rpHEQSnaYUzFp0seuF6rbM7A2eQBrxe+O3JVfTV0YDAvADL1J8xM2oafjThGtPHVTx
         EIevmsc7ocw7Q6jYOomDTJLIFrHCdyGfQq47AX8DelRbixPncb8tV7IrdMlHDGbulehS
         7vLg==
X-Gm-Message-State: AOAM5308xBRi524YX+DMxuLNo18cokayAiqb2BOSSk7eXXNeOm/XI9Oh
        UuEh2I5peS20f0qF1ASgQwwpPA==
X-Google-Smtp-Source: ABdhPJxdyaNiqroS8WWKqzRJMEB/vseMFbiquHGIKVAhsS/bA/m2taL4B7/61/7Fjf/i0dzWoCgz6w==
X-Received: by 2002:a0c:b52b:: with SMTP id d43mr20176800qve.158.1597767902819;
        Tue, 18 Aug 2020 09:25:02 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id d16sm20868571qkk.106.2020.08.18.09.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 09:25:01 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Wesley Cheng <wcheng@codeaurora.org>,
        linux-kernel@vger.kernel.org (open list:VOLTAGE AND CURRENT REGULATOR
        FRAMEWORK)
Subject: [RESEND PATCH] regulator: set of_node for qcom vbus regulator
Date:   Tue, 18 Aug 2020 12:25:08 -0400
Message-Id: <20200818162508.5246-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the regulator to be found by devm_regulator_get().

Fixes: 4fe66d5a62fb ("regulator: Add support for QCOM PMIC VBUS booster")

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/regulator/qcom_usb_vbus-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/qcom_usb_vbus-regulator.c b/drivers/regulator/qcom_usb_vbus-regulator.c
index 8ba947f3585f..457788b50572 100644
--- a/drivers/regulator/qcom_usb_vbus-regulator.c
+++ b/drivers/regulator/qcom_usb_vbus-regulator.c
@@ -63,6 +63,7 @@ static int qcom_usb_vbus_regulator_probe(struct platform_device *pdev)
 	qcom_usb_vbus_rdesc.enable_mask = OTG_EN;
 	config.dev = dev;
 	config.init_data = init_data;
+	config.of_node = dev->of_node;
 	config.regmap = regmap;
 
 	rdev = devm_regulator_register(dev, &qcom_usb_vbus_rdesc, &config);
-- 
2.26.1

