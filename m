Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65C6C2BB85
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0E3F21D91
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AolHcYqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbgDQHD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbgDQHD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:03:27 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1FAC061A0F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 00:03:27 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y25so643569pfn.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 00:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r1lo/KjYdlHW1B6KauS14pcMDOjbPoKhISw8ay5HipA=;
        b=AolHcYqWLKNq46i9aUR3OEvbQ/gxmiSHz8gYBNmNyxLY6vjoC72Mu8KnUESH7Mz1CW
         uirBVy7GdDtLxLUySl2pC0ZUieSsPGPRWmZsXY6UiY03lUY50pPytVNwcxo+LwjxDTty
         k2wYC/JS+xuzwfrycSM6E2eU+yASVtf2gJ2RVcdvI6z6W/Xu1aNxFuWo8ZRDIZ5ErL5k
         gB4h9pnHysvL/gKZheQKjbuQ125wm7lkh0HVIuANMTrB/u6A/RoXXJC6nr49R7acX6UZ
         8SqBGbQgPxKOiG6SO1t+GlG1N4tkKiUJwbB6iGT9MjFPgkRRZ9YSfN+EIRRMyGMSI+32
         j10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r1lo/KjYdlHW1B6KauS14pcMDOjbPoKhISw8ay5HipA=;
        b=jpX5963QvWMFwQMJewE/CWOAuSbYkIW3FCovM0oki98UlNmxW/G39nmfKRxfkA6Pn4
         VcZiK9NKCsd7i7V/t09vHDUfC/JfdslREi5muXNoMpxmB47pOBNlB6W0pZOsWhRicL/X
         mxEJFliZJoyh3Fl04rvW2OgPZxEPq7NoOWg7NbtIQh9ljaIxraga7fDH1bpyFG8iZF81
         IWTo+BptEQCbgETcubH7IDOLDqyhIenZY9ujAP0B7ZjlflGHAmuJYiQ8S+cxl/wCd/ov
         kyBhuZPJARIMHEDm1Fgdj6VE8lJ9jZkmjnO97smOWhNjgObPn10YS1UJZiTm/YM/9/EM
         MKaA==
X-Gm-Message-State: AGi0PuYSYwlBaxVvpthmm7SugFyu4muDximvuwmxjnJUQZziqHEIvpPo
        ZZtSkVaUohEOB42+dm58u7dODg==
X-Google-Smtp-Source: APiQypJG70+MFZ+kuIBOZ6lEaW7FlG5lH/m55Qa4Jzz/SSvZaWYde7OKUco7A1CqzdSYpxiS20aRcw==
X-Received: by 2002:a63:e60a:: with SMTP id g10mr1600021pgh.51.1587107007102;
        Fri, 17 Apr 2020 00:03:27 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id o99sm4683714pjo.8.2020.04.17.00.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 00:03:26 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: db820c: Add pmi8994 RPM regulators
Date:   Fri, 17 Apr 2020 00:03:03 -0700
Message-Id: <20200417070303.1376290-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMI8994 provides 3 SPMS regulators and one boost/bypass regulator.
Define s1 and the boot/bypass and update pm8994 to appropriately
describe the supply from PMI8994.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 26 ++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index fc23b381c5e4..1baf41fbdf6e 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -718,13 +718,18 @@ pm8994-regulators {
 		vdd_s10-supply = <&vph_pwr>;
 		vdd_s11-supply = <&vph_pwr>;
 		vdd_s12-supply = <&vph_pwr>;
+		vdd_l1-supply = <&vreg_s1b_1p025>;
 		vdd_l2_l26_l28-supply = <&vreg_s3a_1p3>;
 		vdd_l3_l11-supply = <&vreg_s8a_l3a_input>;
 		vdd_l4_l27_l31-supply = <&vreg_s3a_1p3>;
 		vdd_l5_l7-supply = <&vreg_s5a_2p15>;
 		vdd_l6_l12_l32-supply = <&vreg_s5a_2p15>;
 		vdd_l8_l16_l30-supply = <&vph_pwr>;
+		vdd_l9_l10_l18_l22-supply = <&vph_pwr_bbyp>;
+		vdd_l13_l19_l23_l24-supply = <&vph_pwr_bbyp>;
 		vdd_l14_l15-supply = <&vreg_s5a_2p15>;
+		vdd_l17_l29-supply = <&vph_pwr_bbyp>;
+		vdd_l20_l21-supply = <&vph_pwr_bbyp>;
 		vdd_l25-supply = <&vreg_s3a_1p3>;
 		vdd_lvs1_2-supply = <&vreg_s4a_1p8>;
 
@@ -909,6 +914,27 @@ vreg_lvs2a_1p8: lvs2 {
 			regulator-name = "vreg_lvs2a_1p8";
 		};
 	};
+
+	pmi8994-regulators {
+		compatible = "qcom,rpm-pmi8994-regulators";
+
+		vdd_s1-supply = <&vph_pwr>;
+		vdd_s2-supply = <&vph_pwr>;
+		vdd_s3-supply = <&vph_pwr>;
+		vdd_bst_byp-supply = <&vph_pwr>;
+
+		vph_pwr_bbyp: boost-bypass {
+			regulator-name = "vph_pwr_bbyp";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		vreg_s1b_1p025: s1 {
+			regulator-name = "vreg_s1b_1p025";
+			regulator-min-microvolt = <1025000>;
+			regulator-max-microvolt = <1025000>;
+		};
+	};
 };
 
 &sdhc2 {
-- 
2.24.0

