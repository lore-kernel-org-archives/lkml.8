Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B00C433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 03:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D14C720707
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 03:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="T43X5Kbm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgIBDPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 23:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgIBDO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 23:14:59 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2727C06125F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 20:14:57 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id 92so2626088qtb.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 20:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Ea8WQ7Wt3j9I6paBCaizvENu7u3kExQvs9OIGg49V8=;
        b=T43X5KbmN9quqEoOwg/Sle/n+McXfL0lJjPUhImrykyaXnR8DCAkq2iFDRK10Jur9B
         wDBfhWpojeQunsT2fZ25eHXoKlS0nKO2g8LPVq1sjwZ9WNMRU38a4RhX54AkOH7+uciM
         RtirV0XtnFyW20HZ3VnRzEKahK8TZkn8mIV/j0yTzcMdBi1+FEgJyT+Qc16Xsb7xtbv8
         D7ErysIvk0L22AQjKX/gMDRYpqRsbIrq1ChkZazbF67eywXRgLts5S5PAMl+Z5e+yoOo
         JP0xf/QGuUmPQo/uX1wLvdaujDnSKK3vEnyVNlN8FzozlCaL5w5nH3Yc8txrASuGv3wG
         R7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Ea8WQ7Wt3j9I6paBCaizvENu7u3kExQvs9OIGg49V8=;
        b=czpn1KfAc5vLtWT+diFVdtcP+po9Up+68KsPvQFrPX9fywo1If4im2h5hUpeGqu93j
         WG7u+ik/BtEVHndPWhWc1SbSESkLlk4x6eqG0EkImiDMqRg+RRthfk1AGhb8nnahXk2k
         v0SEExSvAywqUtSpqFzlMy9LMAJ44CU8JUgM2Io2igYJTNCZeqfcDHnDq0ulQCC8c2xR
         mpkjNbAtrdTSNPlp5EklUyZrZCcRLUwFH/DZbpJSA4ljeQ0IsV29wPt6/t9rTx0UfXkV
         QQ8ikGdiQrYf1OXBw1MGKqotTE5v0oxkg9j0YxkZoDrxnK2gEsAs4db8aAC/D+zPB4cK
         S/qw==
X-Gm-Message-State: AOAM533n+sT3Bo2K5FXaF/aGTxc8pTJ6CFVMq9bhgT8wmbcz6iW0QTTz
        AOkNrZZask7p+VLqTe9dPaignw==
X-Google-Smtp-Source: ABdhPJxF/WFugNydZ9grXTfO44GFOgMIDvNVhFjciGy95j+EFCwxll+3T0da17InEjt0oL96zQ83aA==
X-Received: by 2002:ac8:660a:: with SMTP id c10mr4946660qtp.217.1599016497120;
        Tue, 01 Sep 2020 20:14:57 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id q35sm3755649qtd.75.2020.09.01.20.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 20:14:56 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/5] dt-bindings: clock: add SM8250 QCOM video clock bindings
Date:   Tue,  1 Sep 2020 23:13:53 -0400
Message-Id: <20200902031359.6703-4-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200902031359.6703-1-jonathan@marek.ca>
References: <20200902031359.6703-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for video clock controller for SM8250 SoCs.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 .../bindings/clock/qcom,videocc.yaml          |  6 ++-
 .../dt-bindings/clock/qcom,videocc-sm8250.h   | 42 +++++++++++++++++++
 2 files changed, 47 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/clock/qcom,videocc-sm8250.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
index d04f5bd28dde..757837e260a2 100644
--- a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
@@ -11,12 +11,13 @@ maintainers:
 
 description: |
   Qualcomm video clock control module which supports the clocks, resets and
-  power domains on SDM845/SC7180/SM8150.
+  power domains on SDM845/SC7180/SM8150/SM8250.
 
   See also:
     dt-bindings/clock/qcom,videocc-sdm845.h
     dt-bindings/clock/qcom,videocc-sc7180.h
     dt-bindings/clock/qcom,videocc-sm8150.h
+    dt-bindings/clock/qcom,videocc-sm8250.h
 
 properties:
   compatible:
@@ -24,14 +25,17 @@ properties:
       - qcom,sdm845-videocc
       - qcom,sc7180-videocc
       - qcom,sm8150-videocc
+      - qcom,sm8250-videocc
 
   clocks:
     items:
       - description: Board XO source
+      - description: Board XO source, always-on (required by sm8250 only)
 
   clock-names:
     items:
       - const: bi_tcxo
+      - const: bi_tcxo_ao
 
   '#clock-cells':
     const: 1
diff --git a/include/dt-bindings/clock/qcom,videocc-sm8250.h b/include/dt-bindings/clock/qcom,videocc-sm8250.h
new file mode 100644
index 000000000000..4c44f9c468db
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,videocc-sm8250.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_VIDEO_CC_SM8250_H
+#define _DT_BINDINGS_CLK_QCOM_VIDEO_CC_SM8250_H
+
+/* VIDEO_CC clocks */
+#define VIDEO_CC_AHB_CLK		0
+#define VIDEO_CC_AHB_CLK_SRC		1
+#define VIDEO_CC_MVS0_CLK		2
+#define VIDEO_CC_MVS0_CLK_SRC		3
+#define VIDEO_CC_MVS0_DIV_CLK_SRC	4
+#define VIDEO_CC_MVS0C_CLK		5
+#define VIDEO_CC_MVS0C_DIV2_DIV_CLK_SRC	6
+#define VIDEO_CC_MVS1_CLK		7
+#define VIDEO_CC_MVS1_CLK_SRC		8
+#define VIDEO_CC_MVS1_DIV2_CLK		9
+#define VIDEO_CC_MVS1_DIV_CLK_SRC	10
+#define VIDEO_CC_MVS1C_CLK		11
+#define VIDEO_CC_MVS1C_DIV2_DIV_CLK_SRC	12
+#define VIDEO_CC_XO_CLK			13
+#define VIDEO_CC_XO_CLK_SRC		14
+#define VIDEO_CC_PLL0			15
+#define VIDEO_CC_PLL1			16
+
+/* VIDEO_CC resets */
+#define VIDEO_CC_CVP_INTERFACE_BCR	0
+#define VIDEO_CC_CVP_MVS0_BCR		1
+#define VIDEO_CC_MVS0C_CLK_ARES		2
+#define VIDEO_CC_CVP_MVS0C_BCR		3
+#define VIDEO_CC_CVP_MVS1_BCR		4
+#define VIDEO_CC_MVS1C_CLK_ARES		5
+#define VIDEO_CC_CVP_MVS1C_BCR		6
+
+#define MVS0C_GDSC 			0
+#define MVS1C_GDSC 			1
+#define MVS0_GDSC 			2
+#define MVS1_GDSC 			3
+
+#endif
-- 
2.26.1

