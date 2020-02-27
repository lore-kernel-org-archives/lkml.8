Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20502C4BA06
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99FC2467F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="iUbTjDFq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbgB0I46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 03:56:58 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:48980 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728483AbgB0I44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 03:56:56 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582793815; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=hMrarw0TLt8vKrXnYDHn83TLuMY1FSMaf4jQ8e/gFIA=; b=iUbTjDFq589fpk7Fs80TP+pkJJFKwGjaQ+RttS63xCSMpM0nJVz6eKG2vbpCzpGbx61VOMNy
 HIScqmGkj700DQb2GMBOt7rgG2g62mEplMCcYRM1XtQ8PSPmfn4OIZblIQOPRR1ev+0/Ajka
 lQi6vnCuYnyRyNAHR+YoBajDuqs=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e57844b.7efb82fee5e0-smtp-out-n02;
 Thu, 27 Feb 2020 08:56:43 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4BFDFC4479F; Thu, 27 Feb 2020 08:56:43 +0000 (UTC)
Received: from mkshah-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AF84BC447A2;
        Thu, 27 Feb 2020 08:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AF84BC447A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     swboyd@chromium.org, mka@chromium.org, evgreen@chromium.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>,
        devicetree@vger.kernel.orgi
Subject: [PATCH v8 1/3] arm64: dts: qcom: sc7180: Add cpuidle low power states
Date:   Thu, 27 Feb 2020 14:26:23 +0530
Message-Id: <1582793785-22423-2-git-send-email-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582793785-22423-1-git-send-email-mkshah@codeaurora.org>
References: <1582793785-22423-1-git-send-email-mkshah@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device bindings for cpuidle states for cpu devices.

Cc: devicetree@vger.kernel.orgi
Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
Reviewed-by: Srinivas Rao L <lsrao@codeaurora.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 78 ++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index cc5a94f..2941a7e 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -86,6 +86,9 @@
 			compatible = "arm,armv8";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
+					   &LITTLE_CPU_SLEEP_1
+					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_0>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -103,6 +106,9 @@
 			compatible = "arm,armv8";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
+			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
+					   &LITTLE_CPU_SLEEP_1
+					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_100>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -117,6 +123,9 @@
 			compatible = "arm,armv8";
 			reg = <0x0 0x200>;
 			enable-method = "psci";
+			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
+					   &LITTLE_CPU_SLEEP_1
+					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_200>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -131,6 +140,9 @@
 			compatible = "arm,armv8";
 			reg = <0x0 0x300>;
 			enable-method = "psci";
+			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
+					   &LITTLE_CPU_SLEEP_1
+					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_300>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -145,6 +157,9 @@
 			compatible = "arm,armv8";
 			reg = <0x0 0x400>;
 			enable-method = "psci";
+			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
+					   &LITTLE_CPU_SLEEP_1
+					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_400>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -159,6 +174,9 @@
 			compatible = "arm,armv8";
 			reg = <0x0 0x500>;
 			enable-method = "psci";
+			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
+					   &LITTLE_CPU_SLEEP_1
+					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_500>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
@@ -173,6 +191,9 @@
 			compatible = "arm,armv8";
 			reg = <0x0 0x600>;
 			enable-method = "psci";
+			cpu-idle-states = <&BIG_CPU_SLEEP_0
+					   &BIG_CPU_SLEEP_1
+					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_600>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
@@ -187,6 +208,9 @@
 			compatible = "arm,armv8";
 			reg = <0x0 0x700>;
 			enable-method = "psci";
+			cpu-idle-states = <&BIG_CPU_SLEEP_0
+					   &BIG_CPU_SLEEP_1
+					   &CLUSTER_SLEEP_0>;
 			next-level-cache = <&L2_700>;
 			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
@@ -195,6 +219,60 @@
 				next-level-cache = <&L3_0>;
 			};
 		};
+
+		idle-states {
+			entry-method = "psci";
+
+			LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "little-power-down";
+				arm,psci-suspend-param = <0x40000003>;
+				entry-latency-us = <549>;
+				exit-latency-us = <901>;
+				min-residency-us = <1774>;
+				local-timer-stop;
+			};
+
+			LITTLE_CPU_SLEEP_1: cpu-sleep-0-1 {
+				compatible = "arm,idle-state";
+				idle-state-name = "little-rail-power-down";
+				arm,psci-suspend-param = <0x40000004>;
+				entry-latency-us = <702>;
+				exit-latency-us = <915>;
+				min-residency-us = <4001>;
+				local-timer-stop;
+			};
+
+			BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "big-power-down";
+				arm,psci-suspend-param = <0x40000003>;
+				entry-latency-us = <523>;
+				exit-latency-us = <1244>;
+				min-residency-us = <2207>;
+				local-timer-stop;
+			};
+
+			BIG_CPU_SLEEP_1: cpu-sleep-1-1 {
+				compatible = "arm,idle-state";
+				idle-state-name = "big-rail-power-down";
+				arm,psci-suspend-param = <0x40000004>;
+				entry-latency-us = <526>;
+				exit-latency-us = <1854>;
+				min-residency-us = <5555>;
+				local-timer-stop;
+			};
+
+			CLUSTER_SLEEP_0: cluster-sleep-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "cluster-power-down";
+				arm,psci-suspend-param = <0x40003444>;
+				entry-latency-us = <3263>;
+				exit-latency-us = <6562>;
+				min-residency-us = <9926>;
+				local-timer-stop;
+			};
+		};
 	};
 
 	memory@80000000 {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
