Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAF9C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1F812065D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zves/PjM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406579AbgFYTRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390959AbgFYTRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:17:24 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4B2C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:17:23 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r12so6983182wrj.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VJTFtlmSJJssMoK2NzaWqKKHmjNJh935ngd0RHoSQ4I=;
        b=zves/PjMXG5dsDUU3LkKSqvd8Bb0cLVC4eNdrmRTaXPn3sjcy9wIXCjmp4oOjJ298l
         YwImrnxAene93jXTIWVWM7v1FnFrZ2XY/VT3blGeG+jT79aoHFGu1p5/clb2w+cMbLX3
         b093iveq45CviyVp7oOKIxrnO/t3MVXzq44W/IWi77iSIsZ482hjzQKzReXHdOVjv3XL
         kD+qjvbQVJPQsSEtil8n/WCGrxnO/6kdotX1ZWjp2HJbChf8oPE4thsI9msSAs/bKVER
         gz8oecwLYYbbG+Li7kB9lUjOPlCnykyn00TgD9mURb3uGkJm+yPXNknQkKxyS1j6Ijdl
         u1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VJTFtlmSJJssMoK2NzaWqKKHmjNJh935ngd0RHoSQ4I=;
        b=VX3gUIWGUQdlFdSr7LcdWPa9AsU6W5xBrWGRxQd1YVFeq1G2sUZ7BFCrk1vrtLKtzX
         6XlTCj3AblHLhBafw3NVxlHiKiaprzBCsN30D+ZhqHLfAdPuq7qgbJYCRgAR+u9KLWaH
         YSX3BCNs5dNmNVSPXubqdNc1GTVwVVDOe4obFugQMU8Z/t0lHOWtGvhREmS/0oXbTmJV
         u10zAGPTXpi9Z4qQ2+6QB3VJI/XQ/ZTZaFx1KpW4RGq/F9iyexqZnAHwyvBAEDYprF9O
         1aOOVPe4MJNOJjHGVOJ3C6EOKFmeU2PWR4O2eRFLqjORdxcWq6OlEo9H2mwMLxn8IRh5
         EX3Q==
X-Gm-Message-State: AOAM531FES8khhlr3UK4C13ZygfzJOwOU3C757L87ROR0Fu2fmnCsKsS
        2+nafwZBCOv5/dBtkz8bhANWgA==
X-Google-Smtp-Source: ABdhPJymLg8gydmo/J1S/z2FvMDOD/E0XTWBEtx2MX9NS1hIZsEuZGaoD+dfeVXI2wMZrmEbLwn25g==
X-Received: by 2002:a5d:46d0:: with SMTP id g16mr41499262wrs.229.1593112642402;
        Thu, 25 Jun 2020 12:17:22 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id p13sm22693983wrn.0.2020.06.25.12.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 12:17:21 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [RESEND 07/10] regulator: cpcap-regulator: Remove declared and set, but never used variable 'ignore'
Date:   Thu, 25 Jun 2020 20:17:05 +0100
Message-Id: <20200625191708.4014533-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625191708.4014533-1-lee.jones@linaro.org>
References: <20200625191708.4014533-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's okay to not check the return value that you're not conserned
about, however it is not okay to assign a variable and not check or
use the result.

Fixes W=1 warnings(s):

 drivers/regulator/cpcap-regulator.c:172:13: warning: variable ‘ignore’ set but not used [-Wunused-but-set-variable]
 172 | int error, ignore;
 | ^~~~~~
 drivers/regulator/cpcap-regulator.c: In function ‘cpcap_regulator_disable’:
 drivers/regulator/cpcap-regulator.c:196:13: warning: variable ‘ignore’ set but not used [-Wunused-but-set-variable]
 196 | int error, ignore;
 | ^~~~~~

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/cpcap-regulator.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/cpcap-regulator.c b/drivers/regulator/cpcap-regulator.c
index f80781d58a282..fbf823b830308 100644
--- a/drivers/regulator/cpcap-regulator.c
+++ b/drivers/regulator/cpcap-regulator.c
@@ -169,7 +169,7 @@ enum cpcap_regulator_id {
 static int cpcap_regulator_enable(struct regulator_dev *rdev)
 {
 	struct cpcap_regulator *regulator = rdev_get_drvdata(rdev);
-	int error, ignore;
+	int error;
 
 	error = regulator_enable_regmap(rdev);
 	if (error)
@@ -180,7 +180,7 @@ static int cpcap_regulator_enable(struct regulator_dev *rdev)
 					   regulator->assign_mask,
 					   regulator->assign_mask);
 		if (error)
-			ignore = regulator_disable_regmap(rdev);
+			regulator_disable_regmap(rdev);
 	}
 
 	return error;
@@ -193,7 +193,7 @@ static int cpcap_regulator_enable(struct regulator_dev *rdev)
 static int cpcap_regulator_disable(struct regulator_dev *rdev)
 {
 	struct cpcap_regulator *regulator = rdev_get_drvdata(rdev);
-	int error, ignore;
+	int error;
 
 	if (rdev->desc->enable_val & CPCAP_REG_OFF_MODE_SEC) {
 		error = regmap_update_bits(rdev->regmap, regulator->assign_reg,
@@ -204,9 +204,9 @@ static int cpcap_regulator_disable(struct regulator_dev *rdev)
 
 	error = regulator_disable_regmap(rdev);
 	if (error && (rdev->desc->enable_val & CPCAP_REG_OFF_MODE_SEC)) {
-		ignore = regmap_update_bits(rdev->regmap, regulator->assign_reg,
-					    regulator->assign_mask,
-					    regulator->assign_mask);
+		regmap_update_bits(rdev->regmap, regulator->assign_reg,
+				   regulator->assign_mask,
+				   regulator->assign_mask);
 	}
 
 	return error;
-- 
2.25.1

