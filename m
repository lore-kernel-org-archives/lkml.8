Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F44C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 156D5205CB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="i4VYynak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgIGKYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 06:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbgIGKQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:16:59 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AEAC061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 03:16:58 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id w5so15198189wrp.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 03:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o7KIQGaZLRrmrAAlxdI4JNMVSiQlEJ8fSUoBN8I+Xf8=;
        b=i4VYynakNDb2WI/pIy79r9zqh8yP1EVq+qeDo4qGHXp6XQgH1ROgPsIkGIWc1nFutG
         5jepqFgTB+vcAG3t2zeStqop0UdEX6MXpv3tB4Cj5b2RssOnT5VPAs1aaE0/iAPESeiM
         OtPy1xSO8kcCtXB6IN5xY34elUra0SQkPrXuB2zC/spDCmucT9x7TD8xqwMmk6SaCJ49
         ml7kphiRwIc4RFi1AROi2GqTNj5g5K9jB4exHnQ0wfWRrKFdDqtGIJrO8dydH53ntpFX
         aY5rfeEj8/CF7dhqCYZaECerEPGZi5FMVpZheuA3v2emjVRQOMpBu3njhrdBDCRBPeVt
         O/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o7KIQGaZLRrmrAAlxdI4JNMVSiQlEJ8fSUoBN8I+Xf8=;
        b=af9cXd6MkfB3Bgea2CGPS4c5aAOMvBDGmW1nDp37QDXnT1i411HOeECt68q2KRMJth
         Rm+F9c9dnKsH90ZBOryuqBMxoyLY7reY603QTArCY28wjBqzixEvUIT+DzqoHeXJYKXh
         RhfYSaPsSVqUU41ZQXSssBjrUwqNbzt/ZY/nGMobxJHwsX9br5k/r5Oj6LKR0mb4T2qu
         luJXtKH5qE3e5g/8dZTZGD4okz1IU4vckkfI8b6gOuOd8mjAgeqaAuglv2/lxOuho8rk
         sHgHsx1nFLq/vdyFI/wq2Xayp3zDiiJGmBdQZGRGMbg3DTwFQghsQC/ZEKyt+ViEIJCm
         U04g==
X-Gm-Message-State: AOAM533K6hXyqzEDfmu0UiUjp0rPSmqM1TQt5cWulJE4oizrH1LB3DuM
        PSfG/5wpAGup6Ru3/HB1rWc6Vg==
X-Google-Smtp-Source: ABdhPJzoP9v7yuMPfMOlA8vMx95R4j+MIfrbjA33m48SJ7NXSflBVbFFQtTensuBMDC6CFNSOjR9aQ==
X-Received: by 2002:adf:f4c6:: with SMTP id h6mr20427607wrp.310.1599473816656;
        Mon, 07 Sep 2020 03:16:56 -0700 (PDT)
Received: from localhost.localdomain (122.105.23.93.rev.sfr.net. [93.23.105.122])
        by smtp.gmail.com with ESMTPSA id j7sm28728689wrw.35.2020.09.07.03.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 03:16:56 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, matthias.bgg@gmail.com,
        yong.wu@mediatek.com, miles.chen@mediatek.com,
        Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/3] dt-bindings: iommu: Add binding for MediaTek MT8167 IOMMU
Date:   Mon,  7 Sep 2020 12:16:47 +0200
Message-Id: <20200907101649.1573134-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds IOMMU binding documentation and larb port definitions
for the MT8167 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Acked-by: Rob Herring <robh@kernel.org>
---

V4:
	* Added path to mt8167 larb header file
	* Added Honghui Zhang in copyright header
V3: Added mt8167-larb-port.h file for iommu port definitions
V2: no change

---
 .../bindings/iommu/mediatek,iommu.txt         |  2 +
 include/dt-bindings/memory/mt8167-larb-port.h | 51 +++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 include/dt-bindings/memory/mt8167-larb-port.h

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
index c1ccd8582eb2..ac949f7fe3d4 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
@@ -61,6 +61,7 @@ Required properties:
 	"mediatek,mt6779-m4u" for mt6779 which uses generation two m4u HW.
 	"mediatek,mt7623-m4u", "mediatek,mt2701-m4u" for mt7623 which uses
 						     generation one m4u HW.
+	"mediatek,mt8167-m4u" for mt8167 which uses generation two m4u HW.
 	"mediatek,mt8173-m4u" for mt8173 which uses generation two m4u HW.
 	"mediatek,mt8183-m4u" for mt8183 which uses generation two m4u HW.
 - reg : m4u register base and size.
@@ -80,6 +81,7 @@ Required properties:
 	dt-binding/memory/mt2701-larb-port.h for mt2701, mt7623
 	dt-binding/memory/mt2712-larb-port.h for mt2712,
 	dt-binding/memory/mt6779-larb-port.h for mt6779,
+	dt-binding/memory/mt8167-larb-port.h for mt8167,
 	dt-binding/memory/mt8173-larb-port.h for mt8173, and
 	dt-binding/memory/mt8183-larb-port.h for mt8183.
 
diff --git a/include/dt-bindings/memory/mt8167-larb-port.h b/include/dt-bindings/memory/mt8167-larb-port.h
new file mode 100644
index 000000000000..000fb299a408
--- /dev/null
+++ b/include/dt-bindings/memory/mt8167-larb-port.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020 MediaTek Inc.
+ * Copyright (c) 2020 BayLibre, SAS
+ * Author: Honghui Zhang <honghui.zhang@mediatek.com>
+ * Author: Fabien Parent <fparent@baylibre.com>
+ */
+#ifndef __DTS_IOMMU_PORT_MT8167_H
+#define __DTS_IOMMU_PORT_MT8167_H
+
+#define MTK_M4U_ID(larb, port)		(((larb) << 5) | (port))
+
+#define M4U_LARB0_ID			0
+#define M4U_LARB1_ID			1
+#define M4U_LARB2_ID			2
+
+/* larb0 */
+#define M4U_PORT_DISP_OVL0		MTK_M4U_ID(M4U_LARB0_ID, 0)
+#define M4U_PORT_DISP_RDMA0		MTK_M4U_ID(M4U_LARB0_ID, 1)
+#define M4U_PORT_DISP_WDMA0		MTK_M4U_ID(M4U_LARB0_ID, 2)
+#define M4U_PORT_DISP_RDMA1		MTK_M4U_ID(M4U_LARB0_ID, 3)
+#define M4U_PORT_MDP_RDMA		MTK_M4U_ID(M4U_LARB0_ID, 4)
+#define M4U_PORT_MDP_WDMA		MTK_M4U_ID(M4U_LARB0_ID, 5)
+#define M4U_PORT_MDP_WROT		MTK_M4U_ID(M4U_LARB0_ID, 6)
+#define M4U_PORT_DISP_FAKE		MTK_M4U_ID(M4U_LARB0_ID, 7)
+
+/* larb1*/
+#define M4U_PORT_CAM_IMGO		MTK_M4U_ID(M4U_LARB1_ID, 0)
+#define M4U_PORT_CAM_IMG2O		MTK_M4U_ID(M4U_LARB1_ID, 1)
+#define M4U_PORT_CAM_LSCI		MTK_M4U_ID(M4U_LARB1_ID, 2)
+#define M4U_PORT_CAM_ESFKO		MTK_M4U_ID(M4U_LARB1_ID, 3)
+#define M4U_PORT_CAM_AAO		MTK_M4U_ID(M4U_LARB1_ID, 4)
+#define M4U_PORT_VENC_REC		MTK_M4U_ID(M4U_LARB1_ID, 5)
+#define M4U_PORT_VENC_BSDMA		MTK_M4U_ID(M4U_LARB1_ID, 6)
+#define M4U_PORT_VENC_RD_COMV		MTK_M4U_ID(M4U_LARB1_ID, 7)
+#define M4U_PORT_CAM_IMGI		MTK_M4U_ID(M4U_LARB1_ID, 8)
+#define M4U_PORT_VENC_CUR_LUMA		MTK_M4U_ID(M4U_LARB1_ID, 9)
+#define M4U_PORT_VENC_CUR_CHROMA	MTK_M4U_ID(M4U_LARB1_ID, 10)
+#define M4U_PORT_VENC_REF_LUMA		MTK_M4U_ID(M4U_LARB1_ID, 11)
+#define M4U_PORT_VENC_REF_CHROMA	MTK_M4U_ID(M4U_LARB1_ID, 12)
+
+/* larb2*/
+#define M4U_PORT_HW_VDEC_MC_EXT		MTK_M4U_ID(M4U_LARB2_ID, 0)
+#define M4U_PORT_HW_VDEC_PP_EXT		MTK_M4U_ID(M4U_LARB2_ID, 1)
+#define M4U_PORT_HW_VDEC_VLD_EXT	MTK_M4U_ID(M4U_LARB2_ID, 2)
+#define M4U_PORT_HW_VDEC_AVC_MV_EXT	MTK_M4U_ID(M4U_LARB2_ID, 3)
+#define M4U_PORT_HW_VDEC_PRED_RD_EXT	MTK_M4U_ID(M4U_LARB2_ID, 4)
+#define M4U_PORT_HW_VDEC_PRED_WR_EXT	MTK_M4U_ID(M4U_LARB2_ID, 5)
+#define M4U_PORT_HW_VDEC_PPWRAP_EXT	MTK_M4U_ID(M4U_LARB2_ID, 6)
+
+#endif
-- 
2.28.0

