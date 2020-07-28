Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAB7C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2773920786
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 09:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E2IFz/ic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgG1JTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbgG1JTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 05:19:18 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45539C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 02:19:18 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x9so9581549plr.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 02:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bbjbm60d3lgEusGHdreE/mybmZQ1ctrCeEtW3kkMm5Q=;
        b=E2IFz/icPPAcKC5tD4Wn/GI4mg4xDiqI6tGO2TqyU+W+AfbBJ8j0N7rCLySY1XNUOj
         +A6LX/DWyFbhYZabZFV17rTHMO1VliWMyzT0htZNI9JzR+jGelBk3r/tBEaE3RPsa/iJ
         fPpbdLlbvVwna8Osx8Gv4N70yFOtSRPg+rVvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bbjbm60d3lgEusGHdreE/mybmZQ1ctrCeEtW3kkMm5Q=;
        b=quu8uEdBC1Fh3f94mOGK8kSIi2B1L7rWlnxUMp8OMY/I/EDJZ6CLzKoCjQbbo5pQFo
         uwwL+HLVnr94vRYQe6HnV30dgfdnYP8fZkHS/Skl2ZwBTEKmL4l08TBVj2gME1Pb+znK
         +DVKc3m3Qn15mvPtqWRKdZfTCI41HsRHIl/C2XTec/ekN5YEIOZBHNvGs66aF45mqi2j
         CJZe8HeE1iWPXyEGSnb2M5sQnioECoNNSAb2vjdcB+wh4pN+SCKLS/LX8X7okGbjTHLP
         3K3kW9RfbotBEkG7EMp7hb8TEJvXIEPgfXK7pdCnCJefuxKY2fR99OZmXefOCrK0IAK7
         89YQ==
X-Gm-Message-State: AOAM5312xzyu9ZomHwahfkQibRlVTb5qElGsU0FcWxcdopVgpmZxsFAS
        JQS+KpMl6z/M1N4fUYY9MAzPtg==
X-Google-Smtp-Source: ABdhPJwbKmDSwfmq5puJq+56F/f7rteApOYLPBmeFCDgJMzNodihvryKO+ULdoI1pzUJdNcR9KtsvQ==
X-Received: by 2002:a17:902:a416:: with SMTP id p22mr22040033plq.341.1595927957746;
        Tue, 28 Jul 2020 02:19:17 -0700 (PDT)
Received: from kafuu-chino.c.googlers.com.com (105.219.229.35.bc.googleusercontent.com. [35.229.219.105])
        by smtp.googlemail.com with ESMTPSA id q5sm15339258pgv.1.2020.07.28.02.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 02:19:17 -0700 (PDT)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org (open list:VOLTAGE AND CURRENT REGULATOR
        FRAMEWORK)
Subject: [PATCH] regulator: cros-ec-regulator: Fix double free of desc->name.
Date:   Tue, 28 Jul 2020 17:19:09 +0800
Message-Id: <20200728091909.2009771-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The desc->name field is allocated with devm_kstrdup, but is also kfreed
on the error path, causing it to be double freed. Remove the kfree on
the error path.

Fixes: 8d9f8d57e023 ("regulator: Add driver for cros-ec-regulator")
Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
 drivers/regulator/cros-ec-regulator.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/regulator/cros-ec-regulator.c b/drivers/regulator/cros-ec-regulator.c
index 35f97246bc48..cee259eb0213 100644
--- a/drivers/regulator/cros-ec-regulator.c
+++ b/drivers/regulator/cros-ec-regulator.c
@@ -222,18 +222,13 @@ static int cros_ec_regulator_probe(struct platform_device *pdev)
 
 	drvdata->dev = devm_regulator_register(dev, &drvdata->desc, &cfg);
 	if (IS_ERR(drvdata->dev)) {
-		ret = PTR_ERR(drvdata->dev);
 		dev_err(&pdev->dev, "Failed to register regulator: %d\n", ret);
-		goto free_name;
+		return PTR_ERR(drvdata->dev);
 	}
 
 	platform_set_drvdata(pdev, drvdata);
 
 	return 0;
-
-free_name:
-	kfree(desc->name);
-	return ret;
 }
 
 static const struct of_device_id regulator_cros_ec_of_match[] = {

base-commit: 8d9f8d57e023893bfa708d83e3a787e77766a378
-- 
2.28.0.rc0.142.g3c755180ce-goog

