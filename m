Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACA0C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B6B20866
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lGaWE277"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbgCCRMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:12:39 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47044 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730707AbgCCRMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:12:12 -0500
Received: by mail-wr1-f66.google.com with SMTP id j7so5266580wrp.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 09:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QTnLUqWFBpyvzwpVTBm89O8eiqTgQtA9qR2QiZEc26U=;
        b=lGaWE277H8XcdYwgtTfFH2tb9CSGbygtic32Z57TPhFArHTX+Yh/AJINcTL+sR5ohN
         SyW9FHO9a/JP3Tbi8Jur/QHJsiZx9S2NjMf/hV8X7jHpVn755In/oZ0cxcbjaKkSjyBs
         baF1UxtdXtY0AoABG+2r7LbMdHLcl9wGaM4eOKO0m9/HGrzo3QNsu9OBLvM8xGWyMwTv
         kqaaW2N4Y2S2Ndtkdq3SAtM3eBTqI+92ohNkDstDtNOiP3R09SBL89pheduAnO2CHlBY
         u6NbAyV9TD6c7SPoah2RoM+sBaXjNjUyumcUBIo8lFnY9G9cxUjvJiAi1bmzPSVYomtM
         OyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QTnLUqWFBpyvzwpVTBm89O8eiqTgQtA9qR2QiZEc26U=;
        b=jK87nhPq4WSWDTY4YskY27/gftTcM58p1z47NGYLhDoaI65Feyoop+DMpGsNm9evcj
         lxkY65j9CY+5P24rssn9k5K32EuHgg3TnkVfjI4TkBtvs3uQRzdbxR6d2JdQQ5C8sRd+
         Uw+SGoTWhhrAHMybgjVmSykaclUn6V8IkoZM02tnK2t8e0+L/pT4QDszL+FQfv0OTxqh
         Ehe8akk+SYXB8JTTLSAz9QLdm3j2xbGtoSJaQHiO+YmpQetTmS3iDGBj0v/JQtcOhQ1W
         OFftHVCHnVSj5kTM+QWnDWJvcI9qoBjbMDL5pmjvADBla2+wuVoZ/6kIpkw+LjWfwkN1
         nUkw==
X-Gm-Message-State: ANhLgQ1M9beeyuNwebv5hgX15wsDToQVT6XprhAep96h9kRbsHJwC0l2
        WcMGeeOGTB813WWq3O06cyekkQ==
X-Google-Smtp-Source: ADFU+vu+2MIALvRP3/YG7FgAq8QTTJwY8E2jeOrziUGeyqcqEgxAb5nrJcHlcTK9t1UYDDmZdRVluQ==
X-Received: by 2002:adf:d086:: with SMTP id y6mr6114796wrh.387.1583255531155;
        Tue, 03 Mar 2020 09:12:11 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id z13sm5425319wrw.88.2020.03.03.09.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 09:12:10 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v7 15/18] arm64: dts: qcom: qcs404-evb: Define USB ID pin
Date:   Tue,  3 Mar 2020 17:11:56 +0000
Message-Id: <20200303171159.246992-16-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303171159.246992-1-bryan.odonoghue@linaro.org>
References: <20200303171159.246992-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB ID pin is used to tell if a system is a Host or a Device. For our
purposes we will bind this pin into gpio-usb-conn later.

For now define the pin with its pinmux.

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index 62ef9c34b04e..cb893ca76901 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -271,6 +271,20 @@ rclk {
 			bias-pull-down;
 		};
 	};
+
+	usb3_id_pin: usb3-id-pin {
+		pinmux {
+			pins = "gpio116";
+			function = "gpio";
+		};
+
+		pinconf {
+			pins = "gpio116";
+			drive-strength = <2>;
+			bias-pull-up;
+			input-enable;
+		};
+	};
 };
 
 &pms405_gpios {
-- 
2.25.1

