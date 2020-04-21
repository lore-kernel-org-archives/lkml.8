Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96E6C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 04:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9BE42223D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 04:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z66vAOf3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgDUESV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 00:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725904AbgDUESU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 00:18:20 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEC5C061A41
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 21:18:20 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id g30so6046848pfr.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 21:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8e6fmLjhn9iA1rR0EhCdHo59ETG2z9t4z8p3W3x9ZsE=;
        b=Z66vAOf3VQVmIh3G/f3v+6AhWFW/rGAlD7zhpbTN+8JTLOCQmy3sn1cR8uwLZOsUbf
         CsqLN6Ll2QQIj07DvacoMIIY9VqBt5A4RcgY26IOwDFYrWR5oS3Tcvel8CM2DF/cgFC3
         Z4JHFm1o5plpW7mK4ZHM2sHW2Bc3R1ou5MUG+54JXkCnIuKvnKJS6h7gfJMpnV2W8oGu
         UEgm4W/+Shn+cjTdAWgMA842Oe5/C8ZV7ypvyInb5oaiTYz8al1a05rHl4eANNd8wtgV
         mkH2EAR3og9LeL3pW8Wirhw0IwqHyyN08rBAZ8JNA8jGbPl5+nKGY99uLHlNyC7eLgsl
         390A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8e6fmLjhn9iA1rR0EhCdHo59ETG2z9t4z8p3W3x9ZsE=;
        b=Z+RJsA/wN6ClZf6/T7meBPnauQApXawCrybGY9KASwFQTMSzaXV96g+hwR3Z9OKmlL
         KWxIHrfjNCUP+y6K7GQy+pw8pcTO011qMX/ElCHwJDo8OIYgjsBLzUOM8UGdAfQ1DKpg
         0AbxY5m32wB8PIDCoJMpTBFwTPV9a4jU2y+fNcLsFjV+/1nt/z8iepylnP70LCwIP5i3
         zBQijVD6BWBNIm5broczTTddzMmXvvzIUxCS808pJTpW4pBR/g1zxDThjsA8xjXRuUqj
         JwmHm0b+vDS0WKCIeQIqfZaPRFG55mRHljUZQy3qtqz/TkxfDGaH8YDL/uU9ot1z1RHf
         mbng==
X-Gm-Message-State: AGi0Pua9jCQ4Se4sGyCvxBU1lEXImkGnkqNG8BmprcS6y9Yl9WGdKz5d
        YLogal/p4h44uViuV4BxvZOADDHjvxg=
X-Google-Smtp-Source: APiQypIWgC4Ikb23fi2/xY/q7/ojPQJBPkkRf3Hnp9tPWOb2+PCZ1n6vZSajOCgL3d/OC6zb5dVLnA==
X-Received: by 2002:a63:3814:: with SMTP id f20mr10279254pga.283.1587442699578;
        Mon, 20 Apr 2020 21:18:19 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id a136sm1083262pfa.99.2020.04.20.21.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 21:18:18 -0700 (PDT)
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
Subject: [RESEND x2][PATCH v2] phy: qcom-qusb2: Re add "qcom,sdm845-qusb2-phy" compat string
Date:   Tue, 21 Apr 2020 04:18:15 +0000
Message-Id: <20200421041815.1808-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a regression in 5.7-rc1+

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
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
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

