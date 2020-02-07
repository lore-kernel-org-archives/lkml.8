Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF48C35247
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 01:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2030320715
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 01:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ph/ceQJB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgBGB7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 20:59:44 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39422 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbgBGB73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 20:59:29 -0500
Received: by mail-wm1-f67.google.com with SMTP id c84so957678wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 17:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GxnmQXYbPrwwDf1YSEYt6X6fG7RNrO9V3k1o149cooA=;
        b=Ph/ceQJBkbfcaN2157vp1LsLvms4t8gRLjruxE0+ZYUYxSz9CF4i6n3ysHGgZXvOnj
         nXoUAoKnAVWL15mrTFqyDJO/Qm1F+EXvHDFvCbnVigDDqPXhqJ2QF2pLpsOKC7caM279
         u/IkyIqsM6YZVobJaeS2dGFbatI/q7BDqEvcDJtvZO0MfMa64s3dpwCgKMy8C7tCyiqh
         /qzJYn9ueunXKKYkPP1qgmNiQHgZ9HOY+0mC0f6gmqf5+FHsLCTxfLgJwqsKPKtH6COj
         cNi/UBuBbNuYsxKZeuNXh0113n5iwRQjlCCph8NVd5AAn8LjaBaXAbk1yi2VJtjcXO+V
         pYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GxnmQXYbPrwwDf1YSEYt6X6fG7RNrO9V3k1o149cooA=;
        b=Zii/P8uwd7LSpFxpPLK7aX0ro7BoyXjusLWkOoA9VbsjtxZK+aRaYsxteCJUFNDOxJ
         AWrrnHlWNB6+71gSPU5MPpfJdIb09t2WLwbL/D+o9UIvQWNSOUDtixrPpqBItUiFKWPF
         f0/h7PKiXQGRAZOfxKtncZh8O+3VWq29p6DpSFsZxqZA2DnpIuclyhasBUsvCSK4nHs/
         N13V6dkGapLyS1v7sTI61sVHiGz29QkHfIpAldaCgpfLoISxMFyjYMGlze5wwi+ucxQz
         pv8g7hDjDwGGLqAQOrh1xJh7byQRAWSpCP8eARYKWA4f65Sn8GRMX7qc5aKiZG+Y2Qwe
         pOCA==
X-Gm-Message-State: APjAAAX7XT6J5UbJOvMNC6Xos0dSc0j8D79xkKhN3Cr7DL8EcucuSHuN
        601mPvpDbT1eQIL5xwwJqQidsQ==
X-Google-Smtp-Source: APXvYqzRCnHwCvNpDLkgCsTiWvatIyOa3bRtPAr2/syZ37Q0Ryuo260neou5/AukdGISrddCaXKjJg==
X-Received: by 2002:a1c:ded7:: with SMTP id v206mr1007653wmg.106.1581040767193;
        Thu, 06 Feb 2020 17:59:27 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id a62sm1490095wmh.33.2020.02.06.17.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 17:59:26 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v4 16/18] arm64: dts: qcom: qcs404-evb: Raise vreg_l12_3p3 minimum voltage
Date:   Fri,  7 Feb 2020 01:59:05 +0000
Message-Id: <20200207015907.242991-17-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207015907.242991-1-bryan.odonoghue@linaro.org>
References: <20200207015907.242991-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than set the minimum microvolt for this regulator in the USB SS PHY
driver, set it in the DTS.

Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index 01ef59e8e5b7..0fff50f755ef 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -199,7 +199,7 @@ vreg_l11_sdc2: l11 {
 		};
 
 		vreg_l12_3p3: l12 {
-			regulator-min-microvolt = <2968000>;
+			regulator-min-microvolt = <3050000>;
 			regulator-max-microvolt = <3300000>;
 		};
 
-- 
2.25.0

