Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6FFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6750207ED
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UgV20lxE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgETItV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 04:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgETItR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 04:49:17 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E23FC061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 01:49:17 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id c75so1126776pga.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 01:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5/GPOSvzOGmCtBHrtawLleBNjihEJLwhFje0r/gyBuU=;
        b=UgV20lxE+m+5SQqLGTghEUwbTUIM9gsx3aohb5041IPILli+i+DueRkw4rs3CjRGxL
         LZS5e2UCfwkwAMonLsL3niejayYElFI+pPozSt58oS1qocOOL7IlVKiYeT/toB8tkEjV
         wMz+aKUDq8VAhC0/BzUvqi272zqkPk5rMwZdJKtMR2GOI5HKU8bvFYTTAp/GDmaxI2YO
         BlQkxKE+5rSWht00tp+BRAjus+zrmgdOja0SNtIMKGtKvCDLJlZOGld8f9lntRvNW1RJ
         ya2kpYX94mnL0y2m1esWiPualqY7/k5Rqdyh8hlEUOET73J2UFTjSHqL6Yq1vd5DMDWx
         PtMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5/GPOSvzOGmCtBHrtawLleBNjihEJLwhFje0r/gyBuU=;
        b=FTopt+HRsizTD3OQKirCt5RzRR1PYMbsdcC8PH5RB7hZB6SSKBwYYUyNqTeHQ+raKz
         v2dbeepW2k4gJBDsAhV0ta+fxNOb3bQz29lIC+Z1oYDF9wjS/LIa0wjG8mH5Wfq8Zc+M
         YJmGAuMcTBEETjOqRwZrwxNbWDdfOqbL90V4qjwYCSdnMTFcaBUcWSRZgXJXVuOyunTC
         bCdKBwZwVGQpq9Ha/Q2mlvglHsGuH+NHK4Sz79RCEhsInknmKtuSskPcKjFYWWO/FbOS
         MMTWXEmilF1sSiyBQQ/Gl8GP3Sl8CpsguBfsQhxF+b7FFuurmxl1QX/xNQtmywCj8tN9
         Drag==
X-Gm-Message-State: AOAM532Z9j1opG8dhVlaNfgZZflGdA5UWIoU9WfvhSfKW6lvng6RyDg9
        rIJY7HX2LwS/8W37gWJN/Nv3
X-Google-Smtp-Source: ABdhPJzj9bk9hZCRxZo8oW53zgCLOrVhCvadLVA3ohiWT2uJcdRzK8qBIb25Ia1yGDIjiBKPe55flw==
X-Received: by 2002:a63:4b0c:: with SMTP id y12mr3054903pga.56.1589964556662;
        Wed, 20 May 2020 01:49:16 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:91e:dd0a:7c30:1f7e:ebdb:aa2a])
        by smtp.gmail.com with ESMTPSA id a5sm1629332pfk.210.2020.05.20.01.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 01:49:16 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 3/3] MAINTAINERS: Add entry for Qualcomm IPCC driver
Date:   Wed, 20 May 2020 14:18:54 +0530
Message-Id: <20200520084854.19729-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.26.GIT
In-Reply-To: <20200520084854.19729-1-manivannan.sadhasivam@linaro.org>
References: <20200520084854.19729-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for Qualcomm IPCC driver and its binding.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e64e5db31497..cc2fb991cc0d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14013,6 +14013,14 @@ L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	drivers/iommu/qcom_iommu.c
 
+QUALCOMM IPCC MAILBOX DRIVER
+M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+L:	linux-arm-msm@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
+F:	drivers/mailbox/qcom-ipcc.c
+F:	include/dt-bindings/mailbox/qcom-ipcc.h
+
 QUALCOMM RMNET DRIVER
 M:	Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
 M:	Sean Tranchetti <stranche@codeaurora.org>
-- 
2.26.GIT

