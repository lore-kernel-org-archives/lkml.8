Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787D5C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DFD620708
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="X2h00nEK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731988AbgIHQru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731970AbgIHQrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:47:16 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDC5C06124F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 06:16:07 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id cr8so7729645qvb.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 06:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K6nXsix6OgnB440V2dVZFg3CDm1Av9Lyz63Xse3HaT8=;
        b=X2h00nEKklHqm/sfVWNm2gHs6SXZJ3uPJgyn4w5AOnAxneEAq69OtrJMDl/ALcM4V7
         bchFGlvBV9xW8617ZkfFmWS5X7XUNEf3YhX7bSh/rzBt06aOXVseXlXftRytg1ROhzg6
         0O/fMdn7kySDxRvkcu1m1C9AWgICEGu8/9NdmiAO14CDJRrxD9mGxkjO0qrrr/hVppNH
         8zEYavt7YJGqwPtP+GYYM+1/cwXph77Dw+PdkA6u8Yt52LyQdnknfx2Zq7gD5f1LZmKv
         lgxFRYDlBsm5rYpdb8UZMtZjyFdluwhsGB1XEl2oHuz940/DsFdRWkCkdZPjZeuYHGyv
         xsnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K6nXsix6OgnB440V2dVZFg3CDm1Av9Lyz63Xse3HaT8=;
        b=ZH5HW8e99LC3jCv2xuZH8+AUcoTvdhfXyF0C9fW0ZueogMZZBZPWpLwgwSsui41fVN
         9lVVh3fdGQp8FGbpOMLrnqHDIIGhQzW7noaB8eORC/N3I8Og64TS8m5NajP4ln1uXwLd
         xgfkvHVB/kW2pOzPCJ2LbU/OzfttfLzEoipGit89IgLmMwSAE/biOA/l66NtQfXg8rqr
         WLR1wL5G+L2GLhlklEODh5BSYAW0FwNGnfh7c4MnFjlvbotIdzPlTauDeYTrw3UCNklC
         Cel+gd0otk0kVULQQ1443QBd/7h/eVeELPfxLAgqNSAR1R5nR45Wp6Q+x0uKREX+fWDm
         KBoA==
X-Gm-Message-State: AOAM533fFyXQUb43rqICHAGifNv71vEcAiSy/Fw7gyuCep/BeinkHfHF
        yxHU77tQvU/4M7vbHGxw0Eo7SWQx0dpTzskMzRk=
X-Google-Smtp-Source: ABdhPJz2YoVk7KQVpRhnJ1zexjKzF7PA0rYZEGBr5ECURFh5Vu41aroQ01kJnVB98FRfsvp1eyAP4w==
X-Received: by 2002:ad4:4594:: with SMTP id x20mr49890qvu.4.1599570966352;
        Tue, 08 Sep 2020 06:16:06 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id i66sm14392017qkc.63.2020.09.08.06.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 06:16:05 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] arm64: dts: qcom: add sm8250 fastrpc nodes
Date:   Tue,  8 Sep 2020 09:15:00 -0400
Message-Id: <20200908131500.19891-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fastrpc nodes for sDSP, cDSP, and aDSP.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
v2: rebase without audio dts nodes, changed "dsps" to "sdsp"

 arch/arm64/boot/dts/qcom/sm8250.dtsi | 115 ++++++++++++++++++++++++++-
 1 file changed, 113 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index d223a2a14f2d..8ca544b47190 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -1282,8 +1282,35 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 				mboxes = <&ipcc IPCC_CLIENT_SLPI
 						IPCC_MPROC_SIGNAL_GLINK_QMP>;
 
-				label = "lpass";
+				label = "slpi";
 				qcom,remote-pid = <3>;
+
+				fastrpc {
+					compatible = "qcom,fastrpc";
+					qcom,glink-channels = "fastrpcglink-apps-dsp";
+					label = "sdsp";
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					compute-cb@1 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <1>;
+						iommus = <&apps_smmu 0x0541 0x0>;
+					};
+
+					compute-cb@2 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <2>;
+						iommus = <&apps_smmu 0x0542 0x0>;
+					};
+
+					compute-cb@3 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <3>;
+						iommus = <&apps_smmu 0x0543 0x0>;
+						/* note: shared-cb = <4> in downstream */
+					};
+				};
 			};
 		};
 
@@ -1320,8 +1347,66 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 				mboxes = <&ipcc IPCC_CLIENT_CDSP
 						IPCC_MPROC_SIGNAL_GLINK_QMP>;
 
-				label = "lpass";
+				label = "cdsp";
 				qcom,remote-pid = <5>;
+
+				fastrpc {
+					compatible = "qcom,fastrpc";
+					qcom,glink-channels = "fastrpcglink-apps-dsp";
+					label = "cdsp";
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					compute-cb@1 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <1>;
+						iommus = <&apps_smmu 0x1001 0x0460>;
+					};
+
+					compute-cb@2 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <2>;
+						iommus = <&apps_smmu 0x1002 0x0460>;
+					};
+
+					compute-cb@3 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <3>;
+						iommus = <&apps_smmu 0x1003 0x0460>;
+					};
+
+					compute-cb@4 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <4>;
+						iommus = <&apps_smmu 0x1004 0x0460>;
+					};
+
+					compute-cb@5 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <5>;
+						iommus = <&apps_smmu 0x1005 0x0460>;
+					};
+
+					compute-cb@6 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <6>;
+						iommus = <&apps_smmu 0x1006 0x0460>;
+					};
+
+					compute-cb@7 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <7>;
+						iommus = <&apps_smmu 0x1007 0x0460>;
+					};
+
+					compute-cb@8 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <8>;
+						iommus = <&apps_smmu 0x1008 0x0460>;
+					};
+
+					/* note: secure cb9 in downstream */
+				};
 			};
 		};
 
@@ -2178,6 +2263,32 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 
 				label = "lpass";
 				qcom,remote-pid = <2>;
+
+				fastrpc {
+					compatible = "qcom,fastrpc";
+					qcom,glink-channels = "fastrpcglink-apps-dsp";
+					label = "adsp";
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					compute-cb@3 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <3>;
+						iommus = <&apps_smmu 0x1803 0x0>;
+					};
+
+					compute-cb@4 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <4>;
+						iommus = <&apps_smmu 0x1804 0x0>;
+					};
+
+					compute-cb@5 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <5>;
+						iommus = <&apps_smmu 0x1805 0x0>;
+					};
+				};
 			};
 		};
 
-- 
2.26.1

