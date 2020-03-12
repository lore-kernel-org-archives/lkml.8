Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3761C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 16:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D09206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 16:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ps6uYL78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgCLQon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 12:44:43 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36219 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgCLQoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 12:44:38 -0400
Received: by mail-qt1-f195.google.com with SMTP id m33so4897747qtb.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 09:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M8I0tibm0x9o216WA6J8pQVPILtFuntNhRaRSj7eG4A=;
        b=Ps6uYL78L8tiiefDveevpxYZYKo1t9+cCCagwNnkPLBaPSV2pPdfXTIXk604ph2xpw
         faAVSCi08gDu/GHSdCihjkCKqIZSC2IleEQoObaiVDFlTPmjYm52pvdzdaISQ9hf//Pv
         FodTrRUDCzthOuurF7NFtvTYK4oPZVJw9M/IozV4SMQzttu16TI5wTezqHL46bbcltwQ
         /kSxZi3YBmPrNogjVuKfjbEAmaL6NE7CmpTD/CO+q3VYSldYo70H8zjtDyhMYExHBeHf
         iV3HE8sYXetkWPcjjwtfAJNRiW034zFfHwuVUuIIQo35aeFKxDYrLLidYWAh9MJ0tHKD
         WFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M8I0tibm0x9o216WA6J8pQVPILtFuntNhRaRSj7eG4A=;
        b=Pcu/oRMo+7a0e5wCifhWAPKeDcTZ6uaDdQ5AA/hnXVeCwcKCm4fcBTm+XwV0hVq61C
         BH8YrBFVzFJ2QnzA+zTosUDpkeuOqF1bEO0r+HJVijy53MCnRwfhCEXEK8cMg265agJ8
         MjwCGFBTb4zDt8l2Jb+Q4qXnubUYaUihIT5MOP8T8qG3gq27EXqW0gyvBqS2dsJ9LsR5
         u4Uiov3HGqpF1SB4eqGXzI2+RNq3Svv51NaDgmCx+OfUhc9v5qWBHJaqvoP9HrJxQKwl
         kr6IksuxITNBa3UgIzenvFyYyDln5UFMJAt+oE19n+L5kkWhgBJHutuHzr4iT/RvGVvp
         DK+g==
X-Gm-Message-State: ANhLgQ1OUEg79DzQKeQw5ai+FwpjZBcDieYioQtFFyRBPt6MV86/yDUy
        g1zkQ+zz1gFC00RqUT7cz9nI9g==
X-Google-Smtp-Source: ADFU+vtn1v3TaOzby5HYYtlyHy9Ftixfhi2XKzOU4sP3mHDxuJyhG7MDqq56wClzWXEfwdgTOCMy0w==
X-Received: by 2002:ac8:1e90:: with SMTP id c16mr8251707qtm.265.1584031477341;
        Thu, 12 Mar 2020 09:44:37 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id j4sm7244743qtn.78.2020.03.12.09.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 09:44:36 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] Revert "arm64: dts: sdm845: add IPA information"
Date:   Thu, 12 Mar 2020 11:44:28 -0500
Message-Id: <20200312164428.18132-3-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312164428.18132-1-elder@linaro.org>
References: <20200312164428.18132-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 9cc5ae125f0eaee471bc87fb5cbf29385fd9272a.

This commit:
  b303f9f0050b arm64: dts: sdm845: Redefine interconnect provider DT nodes
found in the Qualcomm for-next tree removes/redefines the interconnect
provider node(s) used for IPA.  I'm not sure whether it technically
conflicts with the IPA change to "sdm845.dtsi" in for-next, but it renders
it broken.

Revert this commit in the for-next tree, with the plan to incorporate
it into the Qualcomm tree instead.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 51 ----------------------------
 1 file changed, 51 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 58fd1c611849..d42302b8889b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -675,17 +675,6 @@
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
-
-		ipa_smp2p_out: ipa-ap-to-modem {
-			qcom,entry-name = "ipa";
-			#qcom,smem-state-cells = <1>;
-		};
-
-		ipa_smp2p_in: ipa-modem-to-ap {
-			qcom,entry-name = "ipa";
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
 	};
 
 	smp2p-slpi {
@@ -1446,46 +1435,6 @@
 			};
 		};
 
-		ipa@1e40000 {
-			compatible = "qcom,sdm845-ipa";
-
-			modem-init;
-			modem-remoteproc = <&mss_pil>;
-
-			reg = <0 0x1e40000 0 0x7000>,
-			      <0 0x1e47000 0 0x2000>,
-			      <0 0x1e04000 0 0x2c000>;
-			reg-names = "ipa-reg",
-				    "ipa-shared",
-				    "gsi";
-
-			interrupts-extended =
-					<&intc 0 311 IRQ_TYPE_EDGE_RISING>,
-					<&intc 0 432 IRQ_TYPE_LEVEL_HIGH>,
-					<&ipa_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
-					<&ipa_smp2p_in 1 IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "ipa",
-					  "gsi",
-					  "ipa-clock-query",
-					  "ipa-setup-ready";
-
-			clocks = <&rpmhcc RPMH_IPA_CLK>;
-			clock-names = "core";
-
-			interconnects =
-				<&rsc_hlos MASTER_IPA &rsc_hlos SLAVE_EBI1>,
-				<&rsc_hlos MASTER_IPA &rsc_hlos SLAVE_IMEM>,
-				<&rsc_hlos MASTER_APPSS_PROC &rsc_hlos SLAVE_IPA_CFG>;
-			interconnect-names = "memory",
-					     "imem",
-					     "config";
-
-			qcom,smem-states = <&ipa_smp2p_out 0>,
-					   <&ipa_smp2p_out 1>;
-			qcom,smem-state-names = "ipa-clock-enabled-valid",
-						"ipa-clock-enabled";
-		};
-
 		tcsr_mutex_regs: syscon@1f40000 {
 			compatible = "syscon";
 			reg = <0 0x01f40000 0 0x40000>;
-- 
2.20.1

