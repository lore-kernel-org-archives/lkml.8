Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71981C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488AD22314
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KrTOAFoS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbgATQbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 11:31:41 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33323 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729602AbgATQbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:31:09 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so140344wrq.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 08:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GxnmQXYbPrwwDf1YSEYt6X6fG7RNrO9V3k1o149cooA=;
        b=KrTOAFoS5gy+apxyUACawp/SYox8aFo3/e48JlAmR7nlZGrIQnow4soJ8NO/A5riPi
         8W3W6rcc287qy0yDWKV406c14yEIk49y7sCgU5cs0XAgMCNAOQ2K9xXfYyDOEJxZKm/B
         dgd/waopQrmDQZm+v4nx15QANkFEBC6OHtiPWJTEpAoeY982NQRPihwOLZyTpiAihGB9
         7AiSSPLU3f568JvEiQYmXJIocofBn0gMqnfXqcVPuVOILoCPVlGFRNYhG/ejpVZQTaE+
         Bj3fMJtiYxx07qYvBPBQL/HYUVbQH11JD0dVOirhJZI4+fWGHDNEdYV30yZdynVPwKms
         pfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GxnmQXYbPrwwDf1YSEYt6X6fG7RNrO9V3k1o149cooA=;
        b=LNR3KAOw8eVmH3P3C7psjAqKBi+aPqgDunDNzLK8W+3zbFNCu44H0dWJNKnzQx4wIe
         Dwc81SZqW79G6DppkqDogwRzOhhcEW8i7PA/c04tpQVWik36YsptEG026OjsxnPQIJsV
         8Svs2QbgDZ/FW7UjckA5EETGHdbbFU63rqsR2AGfmh0Npo9SFsBQea7yP+RZvhOtsNSX
         6aRQ+uAJ053/KelqqwV+RFDmOBT809n+5qRAcZV1XnfDqotgoQObIeqTl6k9kcVEOrmy
         iqEBp4pHe710I1p0mW1rg5lhDtXAOipT1a1nMsj+zdVvWurC7x9tDM+YIZNzG+8wDBDQ
         mYJg==
X-Gm-Message-State: APjAAAXuMGDNHHISsYDIF3MFE3HposBRAlFVL1EYMnMd/uG3SOZzHlMd
        jny3zBku9+A13Yrz2oV9ACM5EQ==
X-Google-Smtp-Source: APXvYqwghhUleMw2LU1W4UEnJa6R+rtx1K9hRLFt9rX2+vX67QUtw60cSxqT+JLR7aSNeUPZ5C2Bmw==
X-Received: by 2002:adf:dc86:: with SMTP id r6mr372278wrj.68.1579537867368;
        Mon, 20 Jan 2020 08:31:07 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id p26sm22631756wmc.24.2020.01.20.08.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 08:31:06 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v2 17/19] arm64: dts: qcom: qcs404-evb: Raise vreg_l12_3p3 minimum voltage
Date:   Mon, 20 Jan 2020 16:31:14 +0000
Message-Id: <20200120163116.1197682-18-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200120163116.1197682-1-bryan.odonoghue@linaro.org>
References: <20200120163116.1197682-1-bryan.odonoghue@linaro.org>
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

