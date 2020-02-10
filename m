Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A11C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0901E20863
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JYVokK1h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgBJMHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:07:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50462 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgBJMHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:07:43 -0500
Received: by mail-wm1-f68.google.com with SMTP id a5so9652222wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 04:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GxnmQXYbPrwwDf1YSEYt6X6fG7RNrO9V3k1o149cooA=;
        b=JYVokK1h8id/NM8RC8cIzlCHTrzIsW0ziXruIZI/cN0zjHVCkvPQfJHVudxXD2B/E/
         iuei8pxiWCj2y95760Ipn2LBKKYu/TA/05bacNvYdxivtXNoXqQ3e5PbZDREWNaMbA/z
         MxlALHMwHdVz2z+ox3JnSeVCYjU0yFbDxeJMTpp5I/U6CRAQ07CP4SgVCi5qHxPmKZfX
         3+UlSBRdvt5RmySOKHP/VEkjfybgdF409X/U8lR3sAb2obJcDo2lNLdWJ7jbTt22CyaD
         dN/TN5Gcs1zOwqU5fYmD3sTAZ7dWLizJMeKKpmkyOfZUgI0NvZwBAoHw+VoRnMWUqmjt
         tXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GxnmQXYbPrwwDf1YSEYt6X6fG7RNrO9V3k1o149cooA=;
        b=igbmBaQiwI3RukDa7jYND/FKjwDquZa2O1VTJoZDBuJgm3WYIiKQvzqDgDxyjFVUaj
         s0uqUps6aCVQkJ1P5pmwtGi3colEhR2YcGAE+8K1MaitnOS896rokcYOOsrOLkq7ta9R
         nDeujLJnneQtHtimnUVSPZKE4CACKH+Kup9AEDXNlR2azJf4OUuutoObEHnfqQITKSVv
         Ok05GMt2ermKksBxoTJxRUXI7e7lyjOIFtpUufHwV0JYwH/vn1WrBB1lj6CYaKcdvOkO
         ptE8olWLF1M/hcuDxKe5PPB8ITDIUVr+1bevcEst+Nr+opLGaI0Typ/wlyJ1Qf9AG32T
         EKHw==
X-Gm-Message-State: APjAAAXVfVwWssS3mo6P5Z0KNwcgQcjZQghp7HSRY7u68qw0P8duOIzG
        yPS/rfmwD1ub0LKrehuwtDsP9A==
X-Google-Smtp-Source: APXvYqyg50LS7K0ZlCoyl5pWdp5LLY78AsZesPAwQjPbRqIERhI7RKU41ZhE7gJ1E0V4HI3YLA4Vfw==
X-Received: by 2002:a7b:c5d9:: with SMTP id n25mr15481658wmk.65.1581336461460;
        Mon, 10 Feb 2020 04:07:41 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id i204sm293124wma.44.2020.02.10.04.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 04:07:40 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v6 17/18] arm64: dts: qcom: qcs404-evb: Raise vreg_l12_3p3 minimum voltage
Date:   Mon, 10 Feb 2020 12:07:22 +0000
Message-Id: <20200210120723.91794-18-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210120723.91794-1-bryan.odonoghue@linaro.org>
References: <20200210120723.91794-1-bryan.odonoghue@linaro.org>
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

