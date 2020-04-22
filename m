Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3764C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F0A420656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fQog2JFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731789AbgDVKnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730067AbgDVKTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:19:39 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D762C03C1A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 03:19:35 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t14so1686927wrw.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 03:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5PhIRlfxSd6Xawyu0KJOVJaENTrBMylRV4/RWfRrVd8=;
        b=fQog2JFHadvS9RrhNUQ8NXgdPQM3795g/mlpdl336mApkCejO/gL0OcFOxX3/2PN/P
         GpPKu2N7mnFNBSVAl9Xp/lWjM5TGxtcVffG1VqZ8BoRtN81WAQ8wtyBKO98NSQ6pJgqC
         CpiHAOm6KVVOYAWLE68uhj4Pmewf835akUehm840wphbDXoh25/uZiCot+NenUXr3lWO
         HcAGIWiqCtC0K4H8SBUEAp0zSaNgRiDvB5Qc38OIS9pHCj98Lq8MMZ1RXctVEGbEDbaE
         fL4ywv2N1AKR4tIzgjjR7qLgIpQfWFPEC1VBkbw36K2d3qp/YfcLQaJRpowtxgMCjMSJ
         rK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5PhIRlfxSd6Xawyu0KJOVJaENTrBMylRV4/RWfRrVd8=;
        b=dHahfOQD05Gy2WE+ZVJpPDxpfzMSo7KzoxR4nQKDhUOzkrZ4mYVv7YOKb92rihwXyJ
         1cmVnKOCp2/syAyMoJeTzJlOEzqvwwKUhq1ZKvN7MlYiX51hAXl5bRpYWDEe7SOFQKfp
         Z41lOl0YJ1kIgFDQ6L2/g1ZOhU9Q37IElu3W7n274YhynUBlYtODdPphGZBJ5DuHbAMz
         /OLPeJW/R6/CN5L7EXTRYXXK5TvSxsom+1cAbhPV8rsp9Or5BcKLeZ29jn0sUkVZe7KG
         +fcLSnEyKPExMnFB7xbfUHftki2JNgLPl0TT+V1ji3IBlwGl/vevtPOed0foPVlBQhCd
         6H5Q==
X-Gm-Message-State: AGi0PuY8nePr8DkJ/nC+2f2Zwq63LYaucDXn9NBupF39XBcM3st6RvUq
        ItkrNk0UaFJND6WhJ9f9dDg80w==
X-Google-Smtp-Source: APiQypKtnvoqO690NcodPG5Icoc96fbnAS6AsX06nqnlt6p4KLnlpdrwCBcwDHeB2H2N5nbR++xHTw==
X-Received: by 2002:a5d:4381:: with SMTP id i1mr28121319wrq.194.1587550774176;
        Wed, 22 Apr 2020 03:19:34 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id k3sm8483299wru.90.2020.04.22.03.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 03:19:33 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2] arm64: dts: qcom: db820c: fix audio configuration
Date:   Wed, 22 Apr 2020 11:19:22 +0100
Message-Id: <20200422101922.8894-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After patch f864edff110d ("ASoC: qdsp6: q6routing: remove default routing")
and 9b60441692d9 ("ASoC: qdsp6: q6asm-dai: only enable dais from device tree")
asm dais and routing needs to be properly specified at device tree level.

This patch fixes this.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Changes since v1:
	- removed invalid direction property

 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 19 ++++++++++++++++++-
 arch/arm64/boot/dts/qcom/msm8996.dtsi        |  2 ++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index af87350b5547..6e81db5671c9 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -908,10 +908,27 @@
 	status = "okay";
 };
 
+&q6asmdai {
+	dai@0 {
+		reg = <0>;
+	};
+
+	dai@1 {
+		reg = <1>;
+	};
+
+	dai@2 {
+		reg = <2>;
+	};
+};
+
 &sound {
 	compatible = "qcom,apq8096-sndcard";
 	model = "DB820c";
-	audio-routing =	"RX_BIAS", "MCLK";
+	audio-routing =	"RX_BIAS", "MCLK",
+		"MM_DL1",  "MultiMedia1 Playback",
+		"MM_DL2",  "MultiMedia2 Playback",
+		"MultiMedia3 Capture", "MM_UL3";
 
 	mm1-dai-link {
 		link-name = "MultiMedia1";
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 14827adebd94..98634d5c4440 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -2066,6 +2066,8 @@
 						reg = <APR_SVC_ASM>;
 						q6asmdai: dais {
 							compatible = "qcom,q6asm-dais";
+							#address-cells = <1>;
+							#size-cells = <0>;
 							#sound-dai-cells = <1>;
 							iommus = <&lpass_q6_smmu 1>;
 						};
-- 
2.21.0

