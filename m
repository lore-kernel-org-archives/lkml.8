Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FCEC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 13:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13D432065E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 13:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BUFYxvRH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgIGNBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 09:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729332AbgIGM5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 08:57:01 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D3EC061575
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 05:56:52 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t10so15762214wrv.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 05:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UCzAly/0nJVCfCDesjIWsuPixCCm9Upr/s0zYEfIO3o=;
        b=BUFYxvRHRgKC5ncXH85VxOzRmvu5RblAUQSDL1NdiJ/Xkn/+okQNWorZtycgiLWKPE
         aoHJ7A+tighMYuB1c3SjlYa7jmU5T+E1kpwVNXtY5JOOEBk9DC1AsHxavHwD5xmopRGh
         FiSvsPcp/taYNnX960IWEM+AsNhKasxEFp4hOgEFGoz9GJInt6jNCldG6nIb7/fNPvC8
         PCYS8+Swm/zJi553TMirU61YOXooAgqqfKaGcZA8TLcE6w6YtkqMePf5VadrHhfS5Ur8
         ne24iPl4d3R9ADjL2trf8OVcnW5t8p/w6YdMhuhsU6mh909amvQPzeC/I3OlIUcGKm3/
         XCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UCzAly/0nJVCfCDesjIWsuPixCCm9Upr/s0zYEfIO3o=;
        b=nS3kkmCMNQCLoVYNC9rLTW+zsARQWtDc/iBk7pRcIwKrHEaqSqBN0+vf/zgUN3XrLT
         EvSjDZIWMJfHQ1P5UHlh7+j2khU83hwpptv43627mHlcNcELmd2Ym/cYafZR+fGFRGXh
         Agk2enuOr0lgxozzXzsSrEbVpUKVFCmb+T1D8MZ6eSuxI5mRFyRbiyw4XlSNHhXBfwKa
         8HvG+xYdKG7HEq9XoniWoTkY1gaEL9n6Gy+UMu8NH6PhMuqgLoxD0j4M0mVzLJ4HWiP4
         ROWJ9cxpNrtyiefRfpWBXbRpzy0ktcCWE7gPmjoK2anAYFVTNRAAqoi82r8qrU6BILJH
         P7vA==
X-Gm-Message-State: AOAM533lP0MDKX0ialwigsdaqPcqA9hICpgBhlVm+3yTgfXCU02c9Q5s
        DJTrUlOcrf0MLD11vier1vsjKQ==
X-Google-Smtp-Source: ABdhPJxhcZdfCuLpTThVNnmLYN235Mar/1UTcpUqAvP3ZFEZGRRqteFw+fGsTsmT+xY1mE7YxrH0RQ==
X-Received: by 2002:a5d:620e:: with SMTP id y14mr23278493wru.371.1599483410542;
        Mon, 07 Sep 2020 05:56:50 -0700 (PDT)
Received: from localhost.localdomain (122.105.23.93.rev.sfr.net. [93.23.105.122])
        by smtp.gmail.com with ESMTPSA id o4sm24845215wru.55.2020.09.07.05.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 05:56:49 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     enric.balletbo@collabora.com, krzk@kernel.org,
        masahiroy@kernel.org, ck.hu@mediatek.com, owen.chen@mediatek.com,
        macpaul.lin@mediatek.com, mars.cheng@mediatek.com,
        wendell.lin@mediatek.com, matthias.bgg@gmail.com, sboyd@kernel.org,
        robh+dt@kernel.org, Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 1/2] dt-bindings: clock: mediatek: add bindings for MT8167 clocks
Date:   Mon,  7 Sep 2020 14:56:45 +0200
Message-Id: <20200907125646.1946282-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for topckgen, apmixedsys, infracfg, audsys,
imgsys, mfgcfg, mmsys, vdecsys on MT8167 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 .../arm/mediatek/mediatek,apmixedsys.txt      |   1 +
 .../bindings/arm/mediatek/mediatek,audsys.txt |   1 +
 .../bindings/arm/mediatek/mediatek,imgsys.txt |   1 +
 .../arm/mediatek/mediatek,infracfg.txt        |   1 +
 .../bindings/arm/mediatek/mediatek,mfgcfg.txt |   1 +
 .../arm/mediatek/mediatek,topckgen.txt        |   1 +
 .../arm/mediatek/mediatek,vdecsys.txt         |   1 +
 include/dt-bindings/clock/mt8167-clk.h        | 131 ++++++++++++++++++
 8 files changed, 138 insertions(+)
 create mode 100644 include/dt-bindings/clock/mt8167-clk.h

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
index bd7a0fa5801b..ea827e8763de 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
@@ -15,6 +15,7 @@ Required Properties:
 	- "mediatek,mt7623-apmixedsys", "mediatek,mt2701-apmixedsys"
 	- "mediatek,mt7629-apmixedsys"
 	- "mediatek,mt8135-apmixedsys"
+	- "mediatek,mt8167-apmixedsys", "syscon"
 	- "mediatek,mt8173-apmixedsys"
 	- "mediatek,mt8183-apmixedsys", "syscon"
 	- "mediatek,mt8516-apmixedsys"
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
index 38309db115f5..b32d374193c7 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
@@ -11,6 +11,7 @@ Required Properties:
 	- "mediatek,mt6779-audio", "syscon"
 	- "mediatek,mt7622-audsys", "syscon"
 	- "mediatek,mt7623-audsys", "mediatek,mt2701-audsys", "syscon"
+	- "mediatek,mt8167-audiosys", "syscon"
 	- "mediatek,mt8183-audiosys", "syscon"
 	- "mediatek,mt8516-audsys", "syscon"
 - #clock-cells: Must be 1
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
index 1e1f00718a7d..dce4c9241932 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
@@ -12,6 +12,7 @@ Required Properties:
 	- "mediatek,mt6779-imgsys", "syscon"
 	- "mediatek,mt6797-imgsys", "syscon"
 	- "mediatek,mt7623-imgsys", "mediatek,mt2701-imgsys", "syscon"
+	- "mediatek,mt8167-imgsys", "syscon"
 	- "mediatek,mt8173-imgsys", "syscon"
 	- "mediatek,mt8183-imgsys", "syscon"
 - #clock-cells: Must be 1
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
index 49a968be1a80..eb3523c7a7be 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
@@ -16,6 +16,7 @@ Required Properties:
 	- "mediatek,mt7623-infracfg", "mediatek,mt2701-infracfg", "syscon"
 	- "mediatek,mt7629-infracfg", "syscon"
 	- "mediatek,mt8135-infracfg", "syscon"
+	- "mediatek,mt8167-infracfg", "syscon"
 	- "mediatek,mt8173-infracfg", "syscon"
 	- "mediatek,mt8183-infracfg", "syscon"
 	- "mediatek,mt8516-infracfg", "syscon"
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mfgcfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mfgcfg.txt
index ad5f9d2f6818..054424fb64b4 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mfgcfg.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mfgcfg.txt
@@ -8,6 +8,7 @@ Required Properties:
 - compatible: Should be one of:
 	- "mediatek,mt2712-mfgcfg", "syscon"
 	- "mediatek,mt6779-mfgcfg", "syscon"
+	- "mediatek,mt8167-mfgcfg", "syscon"
 	- "mediatek,mt8183-mfgcfg", "syscon"
 - #clock-cells: Must be 1
 
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
index 9b0394cbbdc9..5ce7578cf274 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
@@ -15,6 +15,7 @@ Required Properties:
 	- "mediatek,mt7623-topckgen", "mediatek,mt2701-topckgen"
 	- "mediatek,mt7629-topckgen"
 	- "mediatek,mt8135-topckgen"
+	- "mediatek,mt8167-topckgen", "syscon"
 	- "mediatek,mt8173-topckgen"
 	- "mediatek,mt8183-topckgen", "syscon"
 	- "mediatek,mt8516-topckgen"
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
index 7894558b7a1c..98195169176a 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
@@ -11,6 +11,7 @@ Required Properties:
 	- "mediatek,mt6779-vdecsys", "syscon"
 	- "mediatek,mt6797-vdecsys", "syscon"
 	- "mediatek,mt7623-vdecsys", "mediatek,mt2701-vdecsys", "syscon"
+	- "mediatek,mt8167-vdecsys", "syscon"
 	- "mediatek,mt8173-vdecsys", "syscon"
 	- "mediatek,mt8183-vdecsys", "syscon"
 - #clock-cells: Must be 1
diff --git a/include/dt-bindings/clock/mt8167-clk.h b/include/dt-bindings/clock/mt8167-clk.h
new file mode 100644
index 000000000000..a96158edd817
--- /dev/null
+++ b/include/dt-bindings/clock/mt8167-clk.h
@@ -0,0 +1,131 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020 MediaTek Inc.
+ * Copyright (c) 2020 BayLibre, SAS.
+ * Author: James Liao <jamesjj.liao@mediatek.com>
+ *         Fabien Parent <fparent@baylibre.com>
+ */
+
+#ifndef _DT_BINDINGS_CLK_MT8167_H
+#define _DT_BINDINGS_CLK_MT8167_H
+
+/* MT8167 is based on MT8516 */
+#include <dt-bindings/clock/mt8516-clk.h>
+
+/* APMIXEDSYS */
+
+#define CLK_APMIXED_TVDPLL		(CLK_APMIXED_NR_CLK + 0)
+#define CLK_APMIXED_LVDSPLL		(CLK_APMIXED_NR_CLK + 1)
+#define CLK_APMIXED_HDMI_REF		(CLK_APMIXED_NR_CLK + 2)
+#define MT8167_CLK_APMIXED_NR_CLK	(CLK_APMIXED_NR_CLK + 3)
+
+/* TOPCKGEN */
+
+#define CLK_TOP_DSI0_LNTC_DSICK		(CLK_TOP_NR_CLK + 0)
+#define CLK_TOP_VPLL_DPIX		(CLK_TOP_NR_CLK + 1)
+#define CLK_TOP_LVDSTX_CLKDIG_CTS	(CLK_TOP_NR_CLK + 2)
+#define CLK_TOP_HDMTX_CLKDIG_CTS	(CLK_TOP_NR_CLK + 3)
+#define CLK_TOP_LVDSPLL			(CLK_TOP_NR_CLK + 4)
+#define CLK_TOP_LVDSPLL_D2		(CLK_TOP_NR_CLK + 5)
+#define CLK_TOP_LVDSPLL_D4		(CLK_TOP_NR_CLK + 6)
+#define CLK_TOP_LVDSPLL_D8		(CLK_TOP_NR_CLK + 7)
+#define CLK_TOP_MIPI_26M		(CLK_TOP_NR_CLK + 8)
+#define CLK_TOP_TVDPLL			(CLK_TOP_NR_CLK + 9)
+#define CLK_TOP_TVDPLL_D2		(CLK_TOP_NR_CLK + 10)
+#define CLK_TOP_TVDPLL_D4		(CLK_TOP_NR_CLK + 11)
+#define CLK_TOP_TVDPLL_D8		(CLK_TOP_NR_CLK + 12)
+#define CLK_TOP_TVDPLL_D16		(CLK_TOP_NR_CLK + 13)
+#define CLK_TOP_PWM_MM			(CLK_TOP_NR_CLK + 14)
+#define CLK_TOP_CAM_MM			(CLK_TOP_NR_CLK + 15)
+#define CLK_TOP_MFG_MM			(CLK_TOP_NR_CLK + 16)
+#define CLK_TOP_SPM_52M			(CLK_TOP_NR_CLK + 17)
+#define CLK_TOP_MIPI_26M_DBG		(CLK_TOP_NR_CLK + 18)
+#define CLK_TOP_SCAM_MM			(CLK_TOP_NR_CLK + 19)
+#define CLK_TOP_SMI_MM			(CLK_TOP_NR_CLK + 20)
+#define CLK_TOP_26M_HDMI_SIFM		(CLK_TOP_NR_CLK + 21)
+#define CLK_TOP_26M_CEC			(CLK_TOP_NR_CLK + 22)
+#define CLK_TOP_32K_CEC			(CLK_TOP_NR_CLK + 23)
+#define CLK_TOP_GCPU_B			(CLK_TOP_NR_CLK + 24)
+#define CLK_TOP_RG_VDEC			(CLK_TOP_NR_CLK + 25)
+#define CLK_TOP_RG_FDPI0		(CLK_TOP_NR_CLK + 26)
+#define CLK_TOP_RG_FDPI1		(CLK_TOP_NR_CLK + 27)
+#define CLK_TOP_RG_AXI_MFG		(CLK_TOP_NR_CLK + 28)
+#define CLK_TOP_RG_SLOW_MFG		(CLK_TOP_NR_CLK + 29)
+#define CLK_TOP_GFMUX_EMI1X_SEL		(CLK_TOP_NR_CLK + 30)
+#define CLK_TOP_CSW_MUX_MFG_SEL		(CLK_TOP_NR_CLK + 31)
+#define CLK_TOP_CAMTG_MM_SEL		(CLK_TOP_NR_CLK + 32)
+#define CLK_TOP_PWM_MM_SEL		(CLK_TOP_NR_CLK + 33)
+#define CLK_TOP_SPM_52M_SEL		(CLK_TOP_NR_CLK + 34)
+#define CLK_TOP_MFG_MM_SEL		(CLK_TOP_NR_CLK + 35)
+#define CLK_TOP_SMI_MM_SEL		(CLK_TOP_NR_CLK + 36)
+#define CLK_TOP_SCAM_MM_SEL		(CLK_TOP_NR_CLK + 37)
+#define CLK_TOP_VDEC_MM_SEL		(CLK_TOP_NR_CLK + 38)
+#define CLK_TOP_DPI0_MM_SEL		(CLK_TOP_NR_CLK + 39)
+#define CLK_TOP_DPI1_MM_SEL		(CLK_TOP_NR_CLK + 40)
+#define CLK_TOP_AXI_MFG_IN_SEL		(CLK_TOP_NR_CLK + 41)
+#define CLK_TOP_SLOW_MFG_SEL		(CLK_TOP_NR_CLK + 42)
+#define MT8167_CLK_TOP_NR_CLK		(CLK_TOP_NR_CLK + 43)
+
+/* MFGCFG */
+
+#define CLK_MFG_BAXI			0
+#define CLK_MFG_BMEM			1
+#define CLK_MFG_BG3D			2
+#define CLK_MFG_B26M			3
+#define CLK_MFG_NR_CLK			4
+
+/* MMSYS */
+
+#define CLK_MM_SMI_COMMON		0
+#define CLK_MM_SMI_LARB0		1
+#define CLK_MM_CAM_MDP			2
+#define CLK_MM_MDP_RDMA			3
+#define CLK_MM_MDP_RSZ0			4
+#define CLK_MM_MDP_RSZ1			5
+#define CLK_MM_MDP_TDSHP		6
+#define CLK_MM_MDP_WDMA			7
+#define CLK_MM_MDP_WROT			8
+#define CLK_MM_FAKE_ENG			9
+#define CLK_MM_DISP_OVL0		10
+#define CLK_MM_DISP_RDMA0		11
+#define CLK_MM_DISP_RDMA1		12
+#define CLK_MM_DISP_WDMA		13
+#define CLK_MM_DISP_COLOR		14
+#define CLK_MM_DISP_CCORR		15
+#define CLK_MM_DISP_AAL			16
+#define CLK_MM_DISP_GAMMA		17
+#define CLK_MM_DISP_DITHER		18
+#define CLK_MM_DISP_UFOE		19
+#define CLK_MM_DISP_PWM_MM		20
+#define CLK_MM_DISP_PWM_26M		21
+#define CLK_MM_DSI_ENGINE		22
+#define CLK_MM_DSI_DIGITAL		23
+#define CLK_MM_DPI0_ENGINE		24
+#define CLK_MM_DPI0_PXL			25
+#define CLK_MM_LVDS_PXL			26
+#define CLK_MM_LVDS_CTS			27
+#define CLK_MM_DPI1_ENGINE		28
+#define CLK_MM_DPI1_PXL			29
+#define CLK_MM_HDMI_PXL			30
+#define CLK_MM_HDMI_SPDIF		31
+#define CLK_MM_HDMI_ADSP_BCK		32
+#define CLK_MM_HDMI_PLL			33
+#define CLK_MM_NR_CLK			34
+
+/* IMGSYS */
+
+#define CLK_IMG_LARB1_SMI		0
+#define CLK_IMG_CAM_SMI			1
+#define CLK_IMG_CAM_CAM			2
+#define CLK_IMG_SEN_TG			3
+#define CLK_IMG_SEN_CAM			4
+#define CLK_IMG_VENC			5
+#define CLK_IMG_NR_CLK			6
+
+/* VDECSYS */
+
+#define CLK_VDEC_CKEN			0
+#define CLK_VDEC_LARB1_CKEN		1
+#define CLK_VDEC_NR_CLK			2
+
+#endif /* _DT_BINDINGS_CLK_MT8167_H */
-- 
2.28.0

