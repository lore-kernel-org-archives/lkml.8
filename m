Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C27AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 13:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C46B208B8
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 13:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LYAkHByC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgFQNpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 09:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbgFQNpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 09:45:16 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB98C061755
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 06:45:16 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l10so2383948wrr.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 06:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jZcfSh9+wW5N+Dlp3gMek+FnLdHyfPdEraPwakLbSEY=;
        b=LYAkHByCGO57OGvCsKakDa/onsj0NNBFKEEvJ1Z7yYhTezhe8ecYidS+fkrK9VFrBz
         SygBH0qJBjfg3qU3HPXeyU8qALRaERnoia1cSFiOruEduuKOrx8vuRg1Kl1WksZQCLMK
         x/5nLL7+T2k0SU7zHsW7tdWl4RiwXAqkqs2Fy546cOoMY647WD5v1IQqNKWaqoQQDTo4
         Fu93NL6f5TPFC+i9cCNmWKSL2uQnJg0vC4e+UvZuzF13cCeVrCAApkOOBlsVWXiytWqG
         c5GFLY/NNOSig71fvwBpu2UfSn9tOl2xE27q9XngYXC+pEjbm45Ppje22FIen6vyjkGr
         lRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jZcfSh9+wW5N+Dlp3gMek+FnLdHyfPdEraPwakLbSEY=;
        b=GLA895+nhWh01vDFNACp9+PquH9E0hiBZFOPQVAYQZjRLm9SbddY9p6JCD1NWdgErR
         s4vadJy5AYH2Ps3SHGa3A8Ji6H51G5dsZ0Sr0priom4P/aLIQZFiH0yyEC0yoFoXWa1D
         sV71KMkSMxql+0ZgTqaUbnmSj3XWm9QXmC3r2FjFQrOm+HzGUXJe0QC1sTZAkOCWfjos
         4TfyAt5OWFlxpyXjv9LfJ7JwXtKwdB2X7lxdeImOVBknIxqnGpFntYKgtuvwwTkG/b3r
         dbTZkEdL8y+7+tb9yPzYdT35Hzn4z1oDCMYml4W32jUvoazfzhXZu3dBZ6ehVFTQgb7v
         dnsQ==
X-Gm-Message-State: AOAM53059Zu3QhzyWY3oDM5m+k+An6Jq7KOygXtt8wyQ1jJvNE1YMPkR
        MJ+iBpog2ByQtVKnRaf8O7vAmA==
X-Google-Smtp-Source: ABdhPJyjEYHOKxsSHo9Q9bM5sAOlNls27BPQ1cWgfi72kiXg1pUC1BOlnpNjFiDtsyLCGFq+QVwFTA==
X-Received: by 2002:adf:9c12:: with SMTP id f18mr9306013wrc.105.1592401514854;
        Wed, 17 Jun 2020 06:45:14 -0700 (PDT)
Received: from localhost.localdomain ([87.120.218.65])
        by smtp.googlemail.com with ESMTPSA id j14sm1251165wrs.75.2020.06.17.06.45.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jun 2020 06:45:14 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH] arm64: dts: msm8916: Add interconnect provider DT nodes
Date:   Wed, 17 Jun 2020 16:45:15 +0300
Message-Id: <20200617134515.25229-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for the network-on-chip interconnect buses present on
MSM8916-based platforms.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 28 +++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 32bd140ac9fd..6c57896d9836 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/arm/coresight-cti-dt.h>
+#include <dt-bindings/interconnect/qcom,msm8916.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-msm8916.h>
 #include <dt-bindings/reset/qcom,gcc-msm8916.h>
@@ -406,11 +407,38 @@ soc: soc {
 		ranges = <0 0 0 0xffffffff>;
 		compatible = "simple-bus";
 
+		bimc: interconnect@400000 {
+			compatible = "qcom,msm8916-bimc";
+			reg = <0x00400000 0x62000>;
+			#interconnect-cells = <1>;
+			clock-names = "bus", "bus_a";
+			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
+				 <&rpmcc RPM_SMD_BIMC_A_CLK>;
+		};
+
 		restart@4ab000 {
 			compatible = "qcom,pshold";
 			reg = <0x4ab000 0x4>;
 		};
 
+		pcnoc: interconnect@500000 {
+			compatible = "qcom,msm8916-pcnoc";
+			reg = <0x00500000 0x11000>;
+			#interconnect-cells = <1>;
+			clock-names = "bus", "bus_a";
+			clocks = <&rpmcc RPM_SMD_PCNOC_CLK>,
+				 <&rpmcc RPM_SMD_PCNOC_A_CLK>;
+		};
+
+		snoc: interconnect@580000 {
+			compatible = "qcom,msm8916-snoc";
+			reg = <0x00580000 0x14000>;
+			#interconnect-cells = <1>;
+			clock-names = "bus", "bus_a";
+			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
+				 <&rpmcc RPM_SMD_SNOC_A_CLK>;
+		};
+
 		msmgpio: pinctrl@1000000 {
 			compatible = "qcom,msm8916-pinctrl";
 			reg = <0x1000000 0x300000>;
