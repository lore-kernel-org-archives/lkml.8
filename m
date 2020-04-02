Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D674BC2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98622072E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DyUHLDg4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390270AbgDBXpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 19:45:00 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34812 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390172AbgDBXpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 19:45:00 -0400
Received: by mail-pl1-f194.google.com with SMTP id a23so1983895plm.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 16:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IcUXuPRxJQI5RCQqnjKMDNcCLnTPm1SBa74gYbeIkBY=;
        b=DyUHLDg4Q8iCWGfd69LaO0+mou9XnqdjVX5kvqZ+DYN6xTB6D3cvDXDdEyv7NcNvcG
         M20M6jgMNJjsJKyg+H6A4ScEe7xWy0TUeLrSG8I9625ok+MFgJVNywJjVWjC5qRbOJuF
         eycoES/pIhuiBrj4P8Oi7FpcX26pUDyrJdEJiyYhjLuvSIa+uUzEPVWu6Wo1rAawj274
         xG0tZ8fO/7Ptz/3CvYUM5+8DsSXrmYMvcAwkIuLT3k+2F5QvO0fxuWNBMMNKEqlCeyQG
         lQdqM8ursthvgV2j4yHmWXOJqyXqJ7PXtg+HcTw5ustbHUbdUs3Zc677t5PAk1CPJzZO
         +gRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IcUXuPRxJQI5RCQqnjKMDNcCLnTPm1SBa74gYbeIkBY=;
        b=Sms4vaS8fAPP9YeHqGhlXnzjaVIGDuk+d5EdBATe+zzPZqyQ8kYzwV9m9pS7ZpJHtK
         KoxuTZjG+IJg4vvRfYFs2j8gyWyPApjbpoShHDcv4/JiMC+sy6O/+dUlzLiPwEzKFFf1
         cX7dxlReIEvS7unHywZ4uRuu3hPVxXsiUk6qX8zh5Y9sBrpC1lVuxu0v/Bq2auR78ktB
         9M34vG5q27otreW3TiFZR/1HgVTQE4DekHmWjQaSTc4gJ+c3mKEz7bJnM6XmMaS6yzTb
         Mtk7KslMmLONoz0RBw+LzxCcpZJfO5nA4OH7JU5KWwjD1+/+yqXOqL4Uc2zjhNJZNhWS
         5Erg==
X-Gm-Message-State: AGi0PuYd3mEETvMFyEmZ7PI8C7cIn3xhTjc9XDQT3p0wg9tMvLJhLW2w
        K0z8KYwlHkmrVHfK7GujXY9QcW49C2M=
X-Google-Smtp-Source: APiQypLLA09iAbXGXVuJYxW6lprsIUBovTbEFKjLafv05TQE436Pp93UgzeyhGoErgG1V6cnI5yeTQ==
X-Received: by 2002:a17:90a:da06:: with SMTP id e6mr6592136pjv.14.1585871098591;
        Thu, 02 Apr 2020 16:44:58 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id q71sm4481727pjb.5.2020.04.02.16.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 16:44:57 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Doug Anderson <dianders@chromium.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2] phy: qcom-qusb2: Re add "qcom,sdm845-qusb2-phy" compat string
Date:   Thu,  2 Apr 2020 23:44:55 +0000
Message-Id: <20200402234455.75061-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200402223723.7150-1-john.stultz@linaro.org>
References: <20200402223723.7150-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 8fe75cd4cddf ("phy: qcom-qusb2: Add generic QUSB2 V2
PHY support"), the change was made to add "qcom,qusb2-v2-phy"
as a generic compat string. However the change also removed
the "qcom,sdm845-qusb2-phy" compat string, which is documented
in the binding and already in use.

This patch re-adds the "qcom,sdm845-qusb2-phy" compat string
which allows the driver to continue to work with existing dts
entries such as found on the db845c.

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Manu Gautam <mgautam@codeaurora.org>
Cc: Sandeep Maheswaram <sanm@codeaurora.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: Stephen Boyd <swboyd@chromium.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Fixes: 8fe75cd4cddf ("phy: qcom-qusb2: Add generic QUSB2 V2 PHY support")
Reported-by: YongQin Liu <yongqin.liu@linaro.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2: Add deprecation note on "qcom,sdm845-qusb2-phy" string
    as suggested by Doug.
---
 drivers/phy/qualcomm/phy-qcom-qusb2.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
index 3708d43b7508..393011a05b48 100644
--- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
@@ -815,6 +815,13 @@ static const struct of_device_id qusb2_phy_of_match_table[] = {
 	}, {
 		.compatible	= "qcom,msm8998-qusb2-phy",
 		.data		= &msm8998_phy_cfg,
+	}, {
+		/*
+		 * Deprecated. Only here to support legacy device
+		 * trees that didn't include "qcom,qusb2-v2-phy"
+		 */
+		.compatible	= "qcom,sdm845-qusb2-phy",
+		.data		= &qusb2_v2_phy_cfg,
 	}, {
 		.compatible	= "qcom,qusb2-v2-phy",
 		.data		= &qusb2_v2_phy_cfg,
-- 
2.17.1

