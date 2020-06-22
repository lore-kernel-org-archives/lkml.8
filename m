Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D92C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A892D2076E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eu7GWeez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731112AbgFVW1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 18:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731067AbgFVW1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:27:47 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E937C06179A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 15:27:44 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id m2so14552267otr.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 15:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wYNMROVmkPoqnFNJEIZnim/Bm5IaS8jlBoM1iy2mvU4=;
        b=Eu7GWeezIsY98Lhv5zUe1w1NHm20dZSTrxwPs+915PiCZMMXYl1YNoahivWGO3OSzp
         2205LUnuTVeeAhvmJqyo69nUaBB5XsQmH/jKUToqMvrUToZplPOa0pxu3esjemtHnFYG
         sUwhDh7Y22P/W7s8X5cSBGrmYGfZExAq2Iu1t7+LMJiw1ncptKDsOhGhurEjs+g4sAvs
         4bGwCTUztSOfdokyhtFdm3vibXW/0nuLcgIBkY6rToK6enSaWpOAOesF9KfJ7FQLWy+j
         sAAW5oE2r4IhZM4OVBI8X3fLQnp/w73ow0vxKztz/vlw3kqu3vx8m7w0AmeX+4McLIsH
         7HBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wYNMROVmkPoqnFNJEIZnim/Bm5IaS8jlBoM1iy2mvU4=;
        b=LEK3NqW6X0E2h6SIlXcbKHPsm+Eh5YG3Bu08UpbSZUdoqIhY0i/lbWo4b68qX/NbAa
         J2LPrOLgzYZx+BVVUrWfHFELOsi7eOFh0aqP8BibVLytHMw+PUtYq8mHFBC9pGEnoHGQ
         0eqUKguepfJxC1pBVsUqNPVbGZx8Yy27cyFadxmYkvr5dcxtdtDvLCIGhESQv6qiMYPC
         nZC0un0ErCytZUZ7IKTvVl6TO6oFsPGacIKt7oMI/+1fJVELM7ZcQyP8eRRMKGbg9isQ
         lbZT8RsK6AMW4MQhWeSGxf1SiNF6yyRXgxOH4oe9GssLWh4xmnePEsDOvyunn5z6cYMo
         iCnQ==
X-Gm-Message-State: AOAM533666hTKxdUhsrrtX0tAPEGWa9yIcw45j86AX2GPvzmSE5hryaF
        Imivohz++sMm1yEnz4e1P30tyQ==
X-Google-Smtp-Source: ABdhPJxDYpR6ozG7NXjG90R1W8Yle7TD/t1iZgbOx+Pv/Buvf9vD3n0B2NKOlb+A3aeWuy5WiGsleA==
X-Received: by 2002:a05:6830:134d:: with SMTP id r13mr15726946otq.264.1592864863665;
        Mon, 22 Jun 2020 15:27:43 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h36sm3589304oth.37.2020.06.22.15.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 15:27:43 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/6] arm64: dts: qcom: sm8250: Add remoteprocs
Date:   Mon, 22 Jun 2020 15:27:46 -0700
Message-Id: <20200622222747.717306-6-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200622222747.717306-1-bjorn.andersson@linaro.org>
References: <20200622222747.717306-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add remoteproc nodes for the audio, compute and sensor cores, define
glink for each one and enable them on the MTP with appropriate firmware
defined.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts |  15 +++
 arch/arm64/boot/dts/qcom/sm8250.dtsi    | 116 ++++++++++++++++++++++++
 2 files changed, 131 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
index 63d259931c4d..6894f8490dae 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
@@ -55,6 +55,11 @@ vreg_s6c_0p88: smpc6-regulator {
 	};
 };
 
+&adsp {
+	status = "okay";
+	firmware-name = "qcom/sm8250/adsp.mbn";
+};
+
 &apps_rsc {
 	pm8150-rpmh-regulators {
 		compatible = "qcom,pm8150-rpmh-regulators";
@@ -348,10 +353,20 @@ vreg_l7f_1p8: ldo7 {
 	};
 };
 
+&cdsp {
+	status = "okay";
+	firmware-name = "qcom/sm8250/cdsp.mbn";
+};
+
 &qupv3_id_1 {
 	status = "okay";
 };
 
+&slpi {
+	status = "okay";
+	firmware-name = "qcom/sm8250/slpi.mbn";
+};
+
 &tlmm {
 	gpio-reserved-ranges = <28 4>, <40 4>;
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 364d9a798673..a21299b9c62f 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -1052,6 +1052,83 @@ tcsr_mutex_regs: syscon@1f40000 {
 			reg = <0x0 0x01f40000 0x0 0x40000>;
 		};
 
+		slpi: remoteproc@5c00000 {
+			compatible = "qcom,sm8250-slpi-pas";
+			reg = <0 0x05c00000 0 0x4000>;
+
+			interrupts-extended = <&pdc 9 IRQ_TYPE_LEVEL_HIGH>,
+					      <&smp2p_slpi_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_slpi_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_slpi_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_slpi_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
+
+			power-domains = <&aoss_qmp AOSS_QMP_LS_SLPI>,
+					<&rpmhpd SM8250_LCX>,
+					<&rpmhpd SM8250_LMX>;
+			power-domain-names = "load_state", "lcx", "lmx";
+
+			memory-region = <&slpi_mem>;
+
+			qcom,smem-states = <&smp2p_slpi_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts-extended = <&ipcc IPCC_CLIENT_SLPI
+							     IPCC_MPROC_SIGNAL_GLINK_QMP
+							     IRQ_TYPE_EDGE_RISING>;
+				mboxes = <&ipcc IPCC_CLIENT_SLPI
+						IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+				label = "lpass";
+				qcom,remote-pid = <3>;
+			};
+		};
+
+		cdsp: remoteproc@8300000 {
+			compatible = "qcom,sm8250-cdsp-pas";
+			reg = <0 0x08300000 0 0x10000>;
+
+			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_LEVEL_HIGH>,
+					      <&smp2p_cdsp_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
+
+			power-domains = <&aoss_qmp AOSS_QMP_LS_CDSP>,
+					<&rpmhpd SM8250_CX>;
+			power-domain-names = "load_state", "cx";
+
+			memory-region = <&cdsp_mem>;
+
+			qcom,smem-states = <&smp2p_cdsp_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts-extended = <&ipcc IPCC_CLIENT_CDSP
+							     IPCC_MPROC_SIGNAL_GLINK_QMP
+							     IRQ_TYPE_EDGE_RISING>;
+				mboxes = <&ipcc IPCC_CLIENT_CDSP
+						IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+				label = "lpass";
+				qcom,remote-pid = <5>;
+			};
+		};
+
 		pdc: interrupt-controller@b220000 {
 			compatible = "qcom,sm8250-pdc", "qcom,pdc";
 			reg = <0 0x0b220000 0 0x30000>, <0 0x17c000f0 0 0x60>;
@@ -1668,6 +1745,45 @@ config {
 			};
 		};
 
+		adsp: remoteproc@17300000 {
+			compatible = "qcom,sm8250-adsp-pas";
+			reg = <0 0x17300000 0 0x100>;
+
+			interrupts-extended = <&pdc 6 IRQ_TYPE_LEVEL_HIGH>,
+					      <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
+
+			power-domains = <&aoss_qmp AOSS_QMP_LS_LPASS>,
+					<&rpmhpd SM8250_LCX>,
+					<&rpmhpd SM8250_LMX>;
+			power-domain-names = "load_state", "lcx", "lmx";
+
+			memory-region = <&adsp_mem>;
+
+			qcom,smem-states = <&smp2p_adsp_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
+							     IPCC_MPROC_SIGNAL_GLINK_QMP
+							     IRQ_TYPE_EDGE_RISING>;
+				mboxes = <&ipcc IPCC_CLIENT_LPASS
+						IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+				label = "lpass";
+				qcom,remote-pid = <2>;
+			};
+		};
+
 		intc: interrupt-controller@17a00000 {
 			compatible = "arm,gic-v3";
 			#interrupt-cells = <3>;
-- 
2.26.2

