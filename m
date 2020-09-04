Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F03C10DAA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A246206D4
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="db3/8iW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbgIDDLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 23:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729691AbgIDDKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 23:10:55 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9922AC06125C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 20:10:54 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id t20so3655704qtr.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 20:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9FeyMPX2ym39zTofXtT3Ie7eSdDscnW/zN+nSIbkxbk=;
        b=db3/8iW0YSOOpJ9PRWYydw7qDOPh+V4Ggge5oMydh+3WWgYNTweHdr4hvCoiKK+0FK
         tIMUWaejgZM7CWw76fyYpwnXX+IUWmc5ZoqRNxOjfpsf85BPrHhPtSkYK8V5OjE6yXcG
         w2AFOP0PSifzabk7kLJ9pKTZj6oFOp8AxY1END3qoxbCUCrhYVLh8Z6mcH/x+W9l/5bT
         A7benu3NqekPupELzMN3t0dQrreEiF+wPO0y1EcbuAu23nddHCiFCY5wbO6IpUUwSkNq
         9Ls2ne8JWYSVK7WK5A5ewlmAGYJyO2/+SU8KHTQYDov4YwcBrdawOA50WsSlGo/yA083
         xmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9FeyMPX2ym39zTofXtT3Ie7eSdDscnW/zN+nSIbkxbk=;
        b=g7F9mrMKgntR33+ArlsaRy2PDXjaLAa4xOBMJnBzZLtu/2PvicZZDtSjQ3c/YwQ4nQ
         2s+TD+EkRIguS8ZlHiauyulhqkHJiy7LxP1HDOM76xi7EvrUdQbPjaTzL/pcyzB4lFGv
         f9ZQgyPL8wvZu3o85jaDQc/qHC6KLT0osqM+fGnv1w/As1MgFfEbs/F512sdscUeA394
         45s7hE2S5Opfqmbs+3r6DoA5sUHuvFVXB6SpM7dndjRc1LFU/B8Qoup6TLEjG5vei1WF
         0tN7pbqc1w068eZdgIsT3DTiPr5O7lS7hgOZyanMjyTkvrQeX7cgmKe6PoY13AVnVfNU
         zHGA==
X-Gm-Message-State: AOAM532A5c8PNHcVoaHjDqgZAIN/L+1Xl7Psg/YjichGZNQIibQV+KoS
        Z/5AXpzFwLS/CA5FQm53YK1VZg==
X-Google-Smtp-Source: ABdhPJzS+j+uNwV/2v0X923k7X6DWo03FrAHH6ldcb1z1Hl6oIBNIfHiPTaqa1YVEvMGv9ZJzKKG4A==
X-Received: by 2002:ac8:474a:: with SMTP id k10mr6524626qtp.115.1599189053862;
        Thu, 03 Sep 2020 20:10:53 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id x59sm3481063qte.14.2020.09.03.20.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 20:10:53 -0700 (PDT)
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
Subject: [PATCH v2 3/5] dt-bindings: clock: add SM8250 QCOM video clock bindings
Date:   Thu,  3 Sep 2020 23:09:52 -0400
Message-Id: <20200904030958.13325-4-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200904030958.13325-1-jonathan@marek.ca>
References: <20200904030958.13325-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for video clock controller for SM8250 SoCs.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 .../bindings/clock/qcom,videocc.yaml          |  8 +++-
 .../dt-bindings/clock/qcom,videocc-sm8250.h   | 42 +++++++++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/clock/qcom,videocc-sm8250.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
index d04f5bd28dde..66a6066ae353 100644
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
@@ -24,14 +25,19 @@ properties:
       - qcom,sdm845-videocc
       - qcom,sc7180-videocc
       - qcom,sm8150-videocc
+      - qcom,sm8250-videocc
 
   clocks:
+    minItems: 1
     items:
       - description: Board XO source
+      - description: Board XO source, always-on (required by sm8250 only)
 
   clock-names:
+    minItems: 1
     items:
       - const: bi_tcxo
+      - const: bi_tcxo_ao
 
   '#clock-cells':
     const: 1
diff --git a/include/dt-bindings/clock/qcom,videocc-sm8250.h b/include/dt-bindings/clock/qcom,videocc-sm8250.h
new file mode 100644
index 000000000000..d5867fe320c7
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
+#define MVS0C_GDSC			0
+#define MVS1C_GDSC			1
+#define MVS0_GDSC			2
+#define MVS1_GDSC			3
+
+#endif
-- 
2.26.1

