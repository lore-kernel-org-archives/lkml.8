Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3AFC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E98E92074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ez1U5xHO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504531AbgDNS6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504521AbgDNS5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 14:57:50 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D560C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:57:50 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a22so1237442pjk.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=eLhNg8kDFNpBIRgI1oareY/yJAWpxKnYxH3HqcN0OKc=;
        b=ez1U5xHOxFaBocYyvpYcUW3fff2IH0WXHGkc5ZTFQ9vHmRlorLGiAGbqRVF3ylGzl6
         aQuz4yVKzjIFAREzZf8GrBsBXWjVIBOjMo5r3VdcGcdKizW34CI91N8KY/0Fp0Ij+jLe
         3i6A1zhISgRJ1FvCLFcHCSxzTQE3IhloAOm6a10IcaU/DwxQp10GpZxVQES2LrO8RaWs
         Yk7lMqRiNiXoPWrx6+7aZoRGI77G1c6nX7wOfiF4iKknvXx70ba7kqkM6lMPqmLOEmCi
         8Anbggy4C2herkaUy8MlH3ygKEbO4ekWk1bdySIiPLiy1wadSFSJfb1EViD49iJxegxs
         gEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eLhNg8kDFNpBIRgI1oareY/yJAWpxKnYxH3HqcN0OKc=;
        b=pF2XO0V7SiUSplgf5lUSeOa9WxxHBj3uKyBcXsC5BGrvyV8AMEn6+Kt+EDiJgIJyFO
         islvlWKIJhTzHmUlibB5YYWJk6KgAN0ySje1dg4JtpXT4R3g4/2KtZHfuJyuvfMsiH2D
         REny0+eCVRbO3o32502fMLhquiglIfXK1S303COuwdTpT/wW0AUhQAU6dqnZIbuvjHzX
         Pg90TiEZvr8hIVG5PXnwpA8Dki1nPeKxwvv+ev23d5U1HU1wUYxeZ17FXUl3h8p3rXXp
         iOVT5xIW6br0RoBRyCrjhInUjTdyZqm7YdZIiU/oH+aGlFI/clOQ650mRerzdSnkXO64
         tHbA==
X-Gm-Message-State: AGi0PuZktDC2/6uJ9qbHXZRECgJkUHQBtC8onqbCINYoBU4pgi+43Jfx
        EchUgI1Dc4qhEJA647VKJGIq9m3o+8o=
X-Google-Smtp-Source: APiQypIQqv3aTGpX5KMbNC05HSpYyKy/zSB3plcdQbijP6ouAUwBS3T+FFgq7tSGMMQkTN4B1//L6Q==
X-Received: by 2002:a17:902:8a89:: with SMTP id p9mr1280398plo.286.1586890669483;
        Tue, 14 Apr 2020 11:57:49 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id a13sm1865870pfo.85.2020.04.14.11.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 11:57:48 -0700 (PDT)
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
Subject: [RESEND][PATCH v2] phy: qcom-qusb2: Re add "qcom,sdm845-qusb2-phy" compat string
Date:   Tue, 14 Apr 2020 18:57:44 +0000
Message-Id: <20200414185744.84581-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a regression in 5.7-rc1.

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

