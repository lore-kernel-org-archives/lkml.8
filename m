Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EF8C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 01:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F312E20756
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 01:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eCxOQfZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgEUBDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 21:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgEUBDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 21:03:40 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995A0C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 18:03:39 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t7so2114919plr.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 18:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gxRanuvI5KQIRmWH6q33bcoUu0lm4mjXkGuIPrGzvAE=;
        b=eCxOQfZSh5y1RZmnMJOYfxFq7MbVOgvPrO3DCKFQwB/Yc3OarHWNkrUiX1FHdsdTSR
         4JGeSXCjpqs1LkRK/1Ck1art0d2XaYJPXBVChtw7kI1RtqykPNNgeCcrdkXI23qWZtja
         g9xpmNl0GV6F8HimqmZkGvXGBU2dMiSXhE7Ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gxRanuvI5KQIRmWH6q33bcoUu0lm4mjXkGuIPrGzvAE=;
        b=jhSnG1wIwwypEStl8YaH9h57X/BUUGz6yx26Y+kA5sQ9WDzlEW5b+qyO8JIG/txENS
         988sI3z0DfHwlIBiPS99GQg6IhgcHPSXo6AyqvMGxWyAuUOG5pMA16PG2JMUsIl13qyC
         f66v3eVd0ueGE5gNkrTHyMMi4lwRYvy0PBeINvJadqOT38w5gqMyQXiUoo8m+9W6SEUb
         Rhr7YwkLsrCBWi+WtaQ4YuwyKBOC/O3081ahTOfwkCycHYlDSNvZMiWAYZmHXJEqS5k9
         KWgV1N+kWonjgDlOFRyVY1DiwKUG4t5GJX6bmaU04WHxvBh6tj2sLTlCWj1S14FMeXSp
         V3Wg==
X-Gm-Message-State: AOAM530BJ/G/zA+clnXav/GheD8c2rnYomgbD5eFUFqMj6IipV2d1SAV
        ujQ62D6yN4JPvPjboVmiATEpDw==
X-Google-Smtp-Source: ABdhPJyNqTICJlq/2OKpP0yn5cf6ISpdAzYYJbQ3iqeeESwI8F0nT/1076ldnKWDhzdzojojaQI2sA==
X-Received: by 2002:a17:902:301:: with SMTP id 1mr753221pld.245.1590023018891;
        Wed, 20 May 2020 18:03:38 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 70sm2930983pfx.78.2020.05.20.18.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 18:03:38 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH] arm64: dts: qcom: sc7180: Move mss node to the right place
Date:   Wed, 20 May 2020 18:03:37 -0700
Message-Id: <20200521010337.229177-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The modem node has an address of 4080000 and thus should come after tlmm
and before gpu. Move the node to the right place to maintainer proper
address sort order.

Cc: Evan Green <evgreen@chromium.org>
Cc: Sibi Sankar <sibis@codeaurora.org>
Fixes: e14a15eba89a ("arm64: dts: qcom: sc7180: Add Q6V5 MSS node")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 102 +++++++++++++--------------
 1 file changed, 51 insertions(+), 51 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 6b12c60c37fb..1027ef70f8db 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -1459,6 +1459,57 @@ pinconf-sd-cd {
 			};
 		};
 
+		remoteproc_mpss: remoteproc@4080000 {
+			compatible = "qcom,sc7180-mpss-pas";
+			reg = <0 0x04080000 0 0x4040>, <0 0x04180000 0 0x48>;
+			reg-names = "qdsp6", "rmb";
+
+			interrupts-extended = <&intc GIC_SPI 266 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready", "handover",
+					  "stop-ack", "shutdown-ack";
+
+			clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
+				 <&gcc GCC_MSS_Q6_MEMNOC_AXI_CLK>,
+				 <&gcc GCC_MSS_NAV_AXI_CLK>,
+				 <&gcc GCC_MSS_SNOC_AXI_CLK>,
+				 <&gcc GCC_MSS_MFAB_AXIS_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "iface", "bus", "nav", "snoc_axi",
+				      "mnoc_axi", "xo";
+
+			power-domains = <&aoss_qmp AOSS_QMP_LS_MODEM>,
+					<&rpmhpd SC7180_CX>,
+					<&rpmhpd SC7180_MX>,
+					<&rpmhpd SC7180_MSS>;
+			power-domain-names = "load_state", "cx", "mx", "mss";
+
+			memory-region = <&mpss_mem>;
+
+			qcom,smem-states = <&modem_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			resets = <&aoss_reset AOSS_CC_MSS_RESTART>,
+				 <&pdc_reset PDC_MODEM_SYNC_RESET>;
+			reset-names = "mss_restart", "pdc_reset";
+
+			qcom,halt-regs = <&tcsr_mutex_regs 0x23000 0x25000 0x24000>;
+			qcom,spare-regs = <&tcsr_regs 0xb3e4>;
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts = <GIC_SPI 449 IRQ_TYPE_EDGE_RISING>;
+				label = "modem";
+				qcom,remote-pid = <1>;
+				mboxes = <&apss_shared 12>;
+			};
+		};
+
 		gpu: gpu@5000000 {
 			compatible = "qcom,adreno-618.0", "qcom,adreno";
 			#stream-id-cells = <16>;
@@ -2054,57 +2105,6 @@ apss_merge_funnel_in: endpoint {
 			};
 		};
 
-		remoteproc_mpss: remoteproc@4080000 {
-			compatible = "qcom,sc7180-mpss-pas";
-			reg = <0 0x04080000 0 0x4040>, <0 0x04180000 0 0x48>;
-			reg-names = "qdsp6", "rmb";
-
-			interrupts-extended = <&intc GIC_SPI 266 IRQ_TYPE_EDGE_RISING>,
-					      <&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
-					      <&modem_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
-					      <&modem_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
-					      <&modem_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
-					      <&modem_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "wdog", "fatal", "ready", "handover",
-					  "stop-ack", "shutdown-ack";
-
-			clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
-				 <&gcc GCC_MSS_Q6_MEMNOC_AXI_CLK>,
-				 <&gcc GCC_MSS_NAV_AXI_CLK>,
-				 <&gcc GCC_MSS_SNOC_AXI_CLK>,
-				 <&gcc GCC_MSS_MFAB_AXIS_CLK>,
-				 <&rpmhcc RPMH_CXO_CLK>;
-			clock-names = "iface", "bus", "nav", "snoc_axi",
-				      "mnoc_axi", "xo";
-
-			power-domains = <&aoss_qmp AOSS_QMP_LS_MODEM>,
-					<&rpmhpd SC7180_CX>,
-					<&rpmhpd SC7180_MX>,
-					<&rpmhpd SC7180_MSS>;
-			power-domain-names = "load_state", "cx", "mx", "mss";
-
-			memory-region = <&mpss_mem>;
-
-			qcom,smem-states = <&modem_smp2p_out 0>;
-			qcom,smem-state-names = "stop";
-
-			resets = <&aoss_reset AOSS_CC_MSS_RESTART>,
-				 <&pdc_reset PDC_MODEM_SYNC_RESET>;
-			reset-names = "mss_restart", "pdc_reset";
-
-			qcom,halt-regs = <&tcsr_mutex_regs 0x23000 0x25000 0x24000>;
-			qcom,spare-regs = <&tcsr_regs 0xb3e4>;
-
-			status = "disabled";
-
-			glink-edge {
-				interrupts = <GIC_SPI 449 IRQ_TYPE_EDGE_RISING>;
-				label = "modem";
-				qcom,remote-pid = <1>;
-				mboxes = <&apss_shared 12>;
-			};
-		};
-
 		sdhc_2: sdhci@8804000 {
 			compatible = "qcom,sc7180-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0 0x08804000 0 0x1000>;

base-commit: d82fade846aa8bb34956120e3792f494058ec35e
-- 
Sent by a computer, using git, on the internet

