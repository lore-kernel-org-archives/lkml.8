Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E76C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44CAD20BED
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgIJVol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:44:41 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:32804 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730553AbgIJMy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 08:54:59 -0400
Received: from ironmsg07-lv.qualcomm.com (HELO ironmsg07-lv.qulacomm.com) ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 10 Sep 2020 05:54:58 -0700
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qulacomm.com with ESMTP/TLS/AES256-SHA; 10 Sep 2020 05:54:56 -0700
Received: from c-skakit-linux.ap.qualcomm.com (HELO c-skakit-linux.qualcomm.com) ([10.242.51.242])
  by ironmsg01-blr.qualcomm.com with ESMTP; 10 Sep 2020 18:24:31 +0530
Received: by c-skakit-linux.qualcomm.com (Postfix, from userid 2344709)
        id 794584401; Thu, 10 Sep 2020 18:24:30 +0530 (IST)
From:   satya priya <skakit@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>, gregkh@linuxfoundation.org,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, akashast@codeaurora.org,
        rojay@codeaurora.org, msavaliy@qti.qualcomm.com,
        dianders@chromium.org, satya priya <skakit@codeaurora.org>
Subject: [PATCH V5 3/4] arm64: dts: qcom: sc7180-trogdor: Add pinctrl and interrupt config for BT UART
Date:   Thu, 10 Sep 2020 18:23:57 +0530
Message-Id: <1599742438-16811-4-git-send-email-skakit@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599742438-16811-1-git-send-email-skakit@codeaurora.org>
References: <1599742438-16811-1-git-send-email-skakit@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a suitable sleep configuration for uart3 to support Bluetooth wakeup.

If QUP function is selected in sleep state, UART RTS/RFR is pulled high
during suspend and BT SoC not able to send wakeup bytes. So, configure
GPIO mode in sleep state to keep it low during suspend.

Signed-off-by: satya priya <skakit@codeaurora.org>
---
Changes in V5:
 - Newly added in V5. This patch adds wakeup support for trogdor board files.

 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 48 ++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index a6b9beb..96b5331 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -792,6 +792,11 @@ ap_spi_fp: &spi10 {
 #include <arm/cros-ec-sbs.dtsi>
 
 &uart3 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-1 = <&qup_uart3_sleep>;
+	interrupts-extended = <&intc GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>,
+				<&tlmm 41 IRQ_TYPE_EDGE_FALLING>;
+
 	status = "okay";
 
 	bluetooth: bluetooth {
@@ -1345,4 +1350,47 @@ ap_spi_fp: &spi10 {
 			drive-strength = <2>;
 		};
 	};
+
+	qup_uart3_sleep: qup-uart3-sleep {
+		pinmux {
+			pins = "gpio38", "gpio39",
+			       "gpio40", "gpio41";
+			function = "gpio";
+		};
+
+		pinconf-cts {
+			/*
+			 * Configure a pull-down on CTS to match the pull of
+			 * the Bluetooth module.
+			 */
+			pins = "gpio38";
+			bias-pull-down;
+		};
+
+		pinconf-rts {
+			/*
+			 * Configure pull-down on RTS to make sure that the BT SoC can
+			 * wake up the system by sending wakeup bytes during suspend.
+			 */
+			 pins = "gpio39";
+			 bias-pull-down;
+		};
+
+		pinconf-tx {
+			/* Configure pull-up on TX when it isn't actively driven */
+			pins = "gpio40";
+			bias-pull-up;
+		};
+
+		pinconf-rx {
+			/*
+			 * Configure a pull-up on RX. This is needed to avoid
+			 * garbage data when the TX pin of the Bluetooth module is
+			 * in tri-state (module powered off or not driving the
+			 * signal yet).
+			 */
+			pins = "gpio41";
+			bias-pull-up;
+		};
+	};
 };
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

