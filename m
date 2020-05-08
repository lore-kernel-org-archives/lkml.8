Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0103CC47257
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 20:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A85218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 20:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DpwtSGfU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgEHUmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 16:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726906AbgEHUmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 16:42:44 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B7BC05BD09
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 13:42:44 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t16so1242952plo.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 13:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v/kJOzHQVNztoa88Zqa893txGdJr3NbK0Uy6cZ9N+p4=;
        b=DpwtSGfUSL9CaKsXqVEz6+TLkdcWRpU57TbJQD2eIMJuVeMUFx37rOlwnIXKjG0zg1
         +T9J0pJVRIGiPFPXLEG2zpm4A7vsYF252Wlid8+YjZBVRvYfbOs2dz7Qpb/m5iRtWtlK
         VvZG3TgTNpJq7gSlWQlFU0fi8IsfhcBGaKSY0ikVodZYDbeUbOJinlO3Y+N2eR4u2ISv
         +SlnwR1RvQ+7JDhuoTMdWxwG2DJuiimRfvT8+B8F2ZnkmQKYNDLRpSXcAAWBJ5R5EMd5
         z/M2wfmFJT4uyoxKQwU6JiCkKwCF0XQPOUaRuzoK+hO9E2951WDCcYkuMAbpCZrpyWQW
         devQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v/kJOzHQVNztoa88Zqa893txGdJr3NbK0Uy6cZ9N+p4=;
        b=nxEurZm0PVaCDd8Ls2r/5KyIDF7ozXst0lwztaJRb7hrDa0elnivHUuaAk7Z5JNqo0
         2NbzyGbJL36A45KGmrdoA1p0TdeJSzHq3Yg/vnhTPmSmGowpWdZD80hs7gnKEhgsihed
         Okbhc9BI2XklN6gt6p+yGBBBpNalSMTPfT1LBcWh1fJaHGB3edZSOzgBwmlQnckl69p1
         gHejaWj2Mt+Q3zd+JdZnaYAC7MLaVux3cH9YcEcSAjf9AZZXQtNPp66JQpoMOgkNrFPz
         /nTxhpzJPShhOJNp4PReD6/6Xu+NAQhyDlR2fu+3hUp0XaD3q1cVAEZmf+12v/RzyQu/
         tBdQ==
X-Gm-Message-State: AGi0PuaexFoHZcL417pL0E0M3FLLP4tKmIkhfysi3kjUTu5at9GA6yaw
        AeiaCN4M3ghu0dnIYSU8GS9q1w==
X-Google-Smtp-Source: APiQypJAb3f+QC64YiN7o7OeDguzr0+81s7Vq9M944QMiAehMTcBe6OBqfD9/1Clsaudgtub5c7lTA==
X-Received: by 2002:a17:90b:8c8:: with SMTP id ds8mr7896979pjb.164.1588970563609;
        Fri, 08 May 2020 13:42:43 -0700 (PDT)
Received: from nagraj.local ([49.206.21.239])
        by smtp.gmail.com with ESMTPSA id h191sm2670720pfe.44.2020.05.08.13.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 13:42:43 -0700 (PDT)
From:   Sumit Semwal <sumit.semwal@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org
Cc:     nishakumari@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kgunda@codeaurora.org, rnayak@codeaurora.org,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [v2 1/4] dt-bindings: regulator: Add labibb regulator
Date:   Sat,  9 May 2020 02:11:57 +0530
Message-Id: <20200508204200.13481-2-sumit.semwal@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508204200.13481-1-sumit.semwal@linaro.org>
References: <20200508204200.13481-1-sumit.semwal@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nisha Kumari <nishakumari@codeaurora.org>

Adding the devicetree binding for labibb regulator.

Signed-off-by: Nisha Kumari <nishakumari@codeaurora.org>
Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>

--
v2: updated for better compatible string and names.
---
 .../regulator/qcom-labibb-regulator.txt       | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.txt
new file mode 100644
index 000000000000..6e639d69f780
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.txt
@@ -0,0 +1,47 @@
+Qualcomm's LAB(LCD AMOLED Boost)/IBB(Inverting Buck Boost) Regulator
+
+LAB can be used as a positive boost power supply and IBB can be used as a negative
+boost power supply for display panels. Currently implemented for pmi8998.
+
+Main node required properties:
+
+- compatible:			Must be:
+				"qcom,pmi8998-lab-ibb"
+- #address-cells:		Must be 1
+- #size-cells:			Must be 0
+
+LAB subnode required properties:
+
+- interrupts:			Specify the interrupts as per the interrupt
+				encoding.
+- interrupt-names:		Interrupt names to match up 1-to-1 with
+				the interrupts specified in 'interrupts'
+				property.
+
+IBB subnode required properties:
+
+- interrupts:			Specify the interrupts as per the interrupt
+				encoding.
+- interrupt-names:		Interrupt names to match up 1-to-1 with
+				the interrupts specified in 'interrupts'
+				property.
+
+Example:
+	pmi8998_lsid1: pmic@3 {
+		labibb {
+			compatible = "qcom,pmi8998-lab-ibb";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			lab: lab {
+				interrupts = <0x3 0xde 0x0 IRQ_TYPE_EDGE_RISING>;
+				interrupt-names = "lab-sc-err";
+			};
+
+			ibb: ibb {
+				interrupts = <0x3 0xdc 0x2 IRQ_TYPE_EDGE_RISING>;
+				interrupt-names = "ibb-sc-err";
+			};
+
+		};
+	};
-- 
2.26.2

